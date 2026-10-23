use Test;

plan 7;

# L<S12/Construction and Initialization>
# Basic instantiation.
class Е갨갨1 { };
my $е갨갨1 = Е갨갨1.new();
ok(defined($е갨갨1), 'instantiated a class');

# Instantiation with initializing attributes.
class Е갨갨2 {
    has $.a;
    has $.b;
    method check {
        $!a + $!b
    }
}
my $е갨갨2 = Е갨갨2.new(:a(39), :b(3));
is($е갨갨2.check(), 42, 'initializing attributes in new');

# https://github.com/Raku/old-issue-tracker/issues/651
{
    try { EVAL 'NoSuchClass.new()' };
    ok  $!  ~~ Exception, 'death to instantiating nonexistent class';
    ok "$!" ~~ / NoSuchClass /,
       'error for "NoSuchClass.new()" mentions NoSuchClass';

    try { EVAL 'NoSuch::Subclass.new()' };
    ok  $!  ~~ Exception, 'death to instantiating nonexistent::class';
    #?rakudo todo 'error reporting'
    ok "$!" ~~ / 'NoSuch::Subclass' /,
       'error for "NoSuch::Subclass.new()" mentions NoSuch::Subclass';
}

# https://github.com/Raku/old-issue-tracker/issues/956
#instantiation from class name unexpectedly creates a class object instead of Str object
{
    class Е갨갨 { };
    my $ч = 'Foo';
    my $ù = $ч.new;
    is($ù.WHAT.gist, Str.gist, "instantiating from class name string creates a Str object");
}

# vim: expandtab shiftwidth=4
