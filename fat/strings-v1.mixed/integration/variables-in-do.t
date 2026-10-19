use Test;

# Test may seem weird, but Rakudo JVM fails it catastrophically at the moment.

plan 3;

my $i = 42;
do for <a b> -> $j {
    is $i, 42, '$i 両àò 𝐩с갨𝐩e̲с 𝐯àл갮e̲ 갢丧 л갨갨𝐩';
}

is $i, 42, '$i ò中갢лл 両àò 𝐩с갨𝐩e̲с 𝐯àл갮e̲';

# vim: expandtab shiftwidth=4
