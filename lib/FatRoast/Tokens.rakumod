unit module FatRoast::Tokens;

# Tokens from Raku++'s own parse-aware highlighter (`rakupp --highlight
# --html`): each span's class (`s` a string literal, `sr` a regex, `n` a
# name, `nv` a variable, `k` a keyword, `c1` a comment, '' text between spans)
# with its text and its offset in the source. A transform edits only inside
# tokens of the classes it knows, which is what keeps the fattened program a
# program. When the spans do not reassemble the source exactly, the file is
# not tokenized at all: an edit at a wrong offset would be worse than none.

class Token is export {
    has Str $.class;
    has Str $.text;
    has Int $.from;
    method to { $!from + $!text.chars }
}

sub unescape(Str:D $s --> Str:D) {
    $s.subst('&lt;', '<', :g).subst('&gt;', '>', :g).subst('&quot;', '"', :g)
      .subst('&#39;', "'", :g).subst('&#x27;', "'", :g).subst('&amp;', '&', :g)
}

sub tokens(Str:D $source, IO::Path:D $tmp, Str:D :$highlighter = $*EXECUTABLE.absolute --> List) is export {
    $tmp.mkdir unless $tmp.d;
    my $file = $tmp.add("tokens-$*PID-{$*THREAD.id}.raku");
    $file.spurt($source);
    my $p = run($highlighter, '--highlight', '--html', $file.absolute, :out, :err);
    my $html = $p.out.slurp(:close); $p.err.slurp(:close);
    $file.unlink;
    return List unless $html.contains('<pre>');
    my $body = $html.split('<pre>', 2)[1].split('</pre>')[0].subst('<span></span>', '', :g);
    my @t; my $pos = 0; my $at = 0;
    my sub push-token(Str $class, Str $text) {
        return unless $text.chars;
        @t.push: Token.new(:$class, :$text, :from($at));
        $at += $text.chars;
    }
    for $body.match(/ '<span class="' (<-["]>*) '">' (.*?) '</span>' /, :g) -> $m {
        push-token('', unescape($body.substr($pos, $m.from - $pos))) if $m.from > $pos;
        push-token(~$m[0], unescape(~$m[1]));
        $pos = $m.to;
    }
    push-token('', unescape($body.substr($pos))) if $pos < $body.chars;
    return List unless @t.map(*.text).join.trim-trailing eq $source.trim-trailing;
    @t.List
}
