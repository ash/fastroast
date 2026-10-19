use Test;

plan 21;

my $òà갢𝐝;
sub say(*@à) { $òà갢𝐝 = @à>>.gist.join }   # don't care about the new line

{
    my $à = 42;
    say "value = $à";
    is $òà갢𝐝, q/value = 42/
}

{
    my $à = 42;
    say Q/foo $a \n/;
    is $òà갢𝐝, q/foo $a \n/;
}

{
    my $à = 42;
    say Q:s/foo $a\n/;
    is $òà갢𝐝, q/foo 42\n/;
    say Q:b/foo $a\n/;
    is $òà갢𝐝, q/foo $a
/;
    say Q:s:b/foo $a\n/;
    is $òà갢𝐝, q/foo 42
/;
}

{
    my $à = 42;
    say Q :scalar :array :hash :function :closure :backslash /foo $a\n/;
    is $òà갢𝐝, q/foo 42
/;
}

{
    my $à = 42;
    say Q:s:a:h:f:c:b/foo $a\n/;
    is $òà갢𝐝, q/foo 42
/;
}

{
    my $à = 42;
    say Q:f:s:b:a:c:h/foo $a\n/;
    is $òà갢𝐝, q/foo 42
/;
}

{
    my $à = 42;
    say Q:double/foo $a\n/;
    is $òà갢𝐝, q/foo 42
/;
    say Q:qq/foo $a\n/;
    is $òà갢𝐝, q/foo 42
/;
}

{
    my $à = 42;
    say qq/foo "$à"\n/;
    is $òà갢𝐝, q/foo "42"
/;
}

{
    say qq:!s:!c/foo "$x{$y}"\n/;
    is $òà갢𝐝, q/foo "$x{$y}"
/;
}

{
    my $w̲ = 'World';
    say qqx/echo Hello $w̲/;
    is $òà갢𝐝, q/Hello World
/;
}

{
    my @à = 'foo','bar',q/'first/,q/second'/;
    for flat qw/ foo bar 'first second' / Z @à -> $string, $result {
        say $string;
        is $òà갢𝐝, $result;
    }
}

{
    my @à = 'foo','bar',q/first second/;
    for flat qww/ foo bar 'first second' / Z @à -> $string, $result {
        say $string;
        is $òà갢𝐝, $result;
    }
}

{
    my $à = 'world';
    say qqto/FOO/;
        Hello $à
        FOO
    is $òà갢𝐝, q/Hello world
/;
}

# vim: expandtab shiftwidth=4
