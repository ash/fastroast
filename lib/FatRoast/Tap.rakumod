unit module FatRoast::Tap;

# TAP as a comparable observation: one key per test line, `depth:number:verdict`
# (`0:12:ok`, `4:3:not ok:SKIP`), the depth being the subtest indentation. The
# descriptions are left out on purpose: both engines run the same program, so
# a description can only differ through the engine's own rendering of a value,
# and that shows up in the verdicts it feeds.

sub tap-keys(Str:D $out --> List:D) is export {
    $out.lines.map(-> $l {
        next unless $l ~~ / ^ (\s*) ('not ok' | 'ok') » \s* (\d*) (.*) $ /;
        my $d = $3.contains('# SKIP') ?? ':SKIP' !! $3.contains('# TODO') ?? ':TODO' !! '';
        "{$0.chars}:$2:$1$d"
    }).List
}

sub status-of(%r --> Str:D) { %r<status> eq 'timeout' ?? 'timeout' !! 'exit' ~ %r<exit> }

# The tests on which two runs disagree, in order: [key, oracle verdict, candidate verdict].
sub tap-diff(%o, %c --> List:D) is export {
    my @o = tap-keys(%o<stdout>); my @c = tap-keys(%c<stdout>);
    my %ov = @o.map({ my @f = .split(':', 3); "@f[0]:@f[1]" => @f[2] });
    my %cv = @c.map({ my @f = .split(':', 3); "@f[0]:@f[1]" => @f[2] });
    my @d;
    for (|@o, |@c).map({ .split(':', 3)[0, 1].join(':') }).unique -> $k {
        my $a = %ov{$k} // 'absent'; my $b = %cv{$k} // 'absent';
        @d.push: [$k, $a, $b] if $a ne $b;
    }
    @d.List
}

sub tap-agrees(%o, %c --> Bool:D) is export {
    !tap-diff(%o, %c) && status-of(%o) eq status-of(%c)
}

# What a divergence IS, for clustering and for shrinking: the first test the
# runs disagree on, or the exit status when every test agrees.
sub tap-signature(%o, %c --> Str:D) is export {
    my @d = tap-diff(%o, %c);
    return "test {@d[0][0]}: {@d[0][1]} / {@d[0][2]}" if @d;
    status-of(%o) eq status-of(%c) ?? 'none' !! "status {status-of(%o)} / {status-of(%c)}"
}
