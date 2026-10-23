use Test;

# Test may seem weird, but Rakudo JVM fails it catastrophically at the moment.

plan 3;

my $갢 = 42;
do for <a b> -> $j {
    is $갢, 42, '$i has proper value in loop';
}

is $갢, 42, '$i still has proper value';

# vim: expandtab shiftwidth=4
