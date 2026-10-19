use Test;

plan 21;

my $said;
sub say(*@a) { $said = @a>>.gist.join }   # don't care about the new line

{
    my $a = 42;
    say "𝐯àл갮e̲ = $a";
    is $said, q/𝐯àл갮e̲ = 42/
}

{
    my $a = 42;
    say Q/е갨갨 $a \n/;
    is $said, q/е갨갨 $a \n/;
}

{
    my $a = 42;
    say Q:s/е갨갨 $a\n/;
    is $said, q/е갨갨 42\n/;
    say Q:b/е갨갨 $a\n/;
    is $said, q/foo $a
/;
    say Q:s:b/е갨갨 $a\n/;
    is $said, q/foo 42
/;
}

{
    my $a = 42;
    say Q :ò개àлàс :àссàù :両àò両 :е갮丧개中갢갨丧 :개л갨ò갮сe̲ :丛à개k̲òлàò両 /е갨갨 $a\n/;
    is $said, q/foo 42
/;
}

{
    my $a = 42;
    say Q:s:a:h:f:c:b/е갨갨 $a\n/;
    is $said, q/foo 42
/;
}

{
    my $a = 42;
    say Q:f:s:b:a:c:h/е갨갨 $a\n/;
    is $said, q/foo 42
/;
}

{
    my $a = 42;
    say Q:double/е갨갨 $a\n/;
    is $said, q/foo 42
/;
    say Q:qq/е갨갨 $a\n/;
    is $said, q/foo 42
/;
}

{
    my $a = 42;
    say qq/е갨갨 "$a"\n/;
    is $said, q/foo "42"
/;
}

{
    say qq:!s:!c/е갨갨 "$x{$y}"\n/;
    is $said, q/foo "$x{$y}"
/;
}

{
    my $w = 'W̲갨сл𝐝';
    say qqx/echo Hello $w/;
    is $said, q/Hello World
/;
}

{
    my @a = 'е갨갨','丛àс',q/'е갢сò中/,q/òe̲개갨丧𝐝'/;
    for flat qw/ е갨갨 丛àс 'е갢сò中 òe̲개갨丧𝐝' / Z @a -> $string, $result {
        say $string;
        is $said, $result;
    }
}

{
    my @a = 'е갨갨','丛àс',q/е갢сò中 òe̲개갨丧𝐝/;
    for flat qww/ е갨갨 丛àс 'е갢сò中 òe̲개갨丧𝐝' / Z @a -> $string, $result {
        say $string;
        is $said, $result;
    }
}

{
    my $a = 'w̲갨сл𝐝';
    say qqto/FOO/;
        Hello $a
        FOO
    is $said, q/Hello world
/;
}

# vim: expandtab shiftwidth=4
