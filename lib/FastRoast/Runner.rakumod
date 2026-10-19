unit module FastRoast::Runner;

# A bounded run of one engine on one file. The child runs from a shell that
# makes it a process-group leader, so a timeout kills the test and anything it
# spawned (Roast's S29 files run children). Output is captured as bytes and
# decoded leniently (`utf8-c8`): an engine that prints a stray byte is an
# observation, not a reason for the harness to die.

my atomicint $GUARD = 0;

sub sh-quote(Str:D $s --> Str:D) { "'" ~ $s.subst("'", "'\\''", :g) ~ "'" }

sub capped(IO::Path:D $path, Int:D $limit --> Str:D) {
    return '' unless $path.e;
    my $blob = $path.slurp(:bin);
    ($blob.elems > $limit ?? $blob.subbuf(0, $limit) !! $blob).decode('utf8-c8')
}

# Run `engine file` from `cwd`, with `env` added to the environment.
# Returns { status => 'exit' | 'timeout', exit => Int, stdout, stderr, ms }.
sub run-engine(Str:D $engine, IO::Path:D $file, IO::Path:D $tmp,
               IO::Path :$cwd, :%env, Int:D :$timeout = 90,
               Int:D :$max-output = 1_048_576 --> Hash:D) is export {
    $tmp.mkdir unless $tmp.d;
    my $base = $tmp.add("run-$*PID-{$GUARD⚛++}").absolute;
    my ($out, $err) = "$base.out", "$base.err";
    my $vars = %env.sort.map({ "{.key}={sh-quote(.value.Str)}" }).join(' ');
    my $line = ($vars ?? "env $vars " !! '') ~ ($engine, $file.absolute).map({ sh-quote(~$_) }).join(' ');
    my $script = "exec >/dev/null 2>&1; set -m 2>/dev/null || true; "
        ~ ($cwd ?? "cd {sh-quote($cwd.absolute)} || exit 125; " !! '')
        ~ "$line > {sh-quote($out)} 2> {sh-quote($err)} & p=\$!; "
        ~ "( sleep $timeout; kill -9 -\$p 2>/dev/null || kill -9 \$p 2>/dev/null ) & w=\$!; "
        ~ "wait \$p; rc=\$?; kill \$w 2>/dev/null; wait \$w 2>/dev/null; exit \$rc";
    my $started = now;
    my $proc = run('/bin/sh', '-c', $script);
    my %r = status => ($proc.exitcode == 137 ?? 'timeout' !! 'exit'), exit => $proc.exitcode,
            stdout => capped($out.IO, $max-output), stderr => capped($err.IO, $max-output),
            ms => ((now - $started) * 1000).Int;
    .IO.unlink for $out, $err;
    %r
}

# The engine's own name for itself, as `--version` prints it.
sub engine-identity(Str:D $engine --> Str:D) is export {
    my $p = run($engine, '--version', :out, :err);
    my $v = ($p.out.slurp(:close) ~ $p.err.slurp(:close)).trim;
    $v.chars ?? $v.lines[0] !! $engine
}
