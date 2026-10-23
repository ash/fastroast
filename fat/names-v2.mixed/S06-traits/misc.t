use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 23;

=begin description

Testing parameter traits for subroutines

=end description

# L<S06/"Parameter traits">

my $foo=1;

# test twice, once with assignment and once with increment, rakudo
# used to catch the first but not the latter.
#
throws-like '
    my $tmp = 1;
    sub mods_param ($x) { $x++; }
    mods_param($tmp)
    ',
    X::Multi::NoMatch,
    'can\'t modify parameter, constant by default';

throws-like '
    my $tmp = 1;
    sub mods_param ($x) { $x = 1; }
    mods_param($tmp)
    ',
    Exception,
    'can\'t modify parameter, constant by default';

# is readonly
throws-like 'sub mods_param_constant ($x is readonly) { $x++; };
             mods_param_constant($foo);',
             X::Multi::NoMatch,
            'can\'t modify constant parameter, constant by default';

sub ì갨𝐝ò_𝐩àсàì_сw̲ ($x is rw) { $x++; }
dies-ok  { ì갨𝐝ò_𝐩àсàì_сw̲(1) }, 'can\'t modify constant even if we claim it\'s rw';
sub ì갨𝐝ò_𝐩àсàì_сw̲_e̲丧е갨с개e̲ò ($x is rw) { $x; }
throws-like { ì갨𝐝ò_𝐩àсàì_сw̲_e̲丧е갨с개e̲ò(1) },
    X::Parameter::RW,
    'is rw dies in signature binding if passed a literal Int';
throws-like { ì갨𝐝ò_𝐩àсàì_сw̲_e̲丧е갨с개e̲ò($[1,2]) },
    X::Parameter::RW,
    'is rw dies in signature binding if passed an itemized array';

lives-ok  { ì갨𝐝ò_𝐩àсàì_сw̲($foo) }, 'pass by "is rw" doesn\'t die';
is($foo, 2, 'pass by reference works');

# https://github.com/Raku/old-issue-tracker/issues/5728
multi sub 𝐩àсàì_сw̲_с갨 ($x is rw) { "fee $x" }
multi sub 𝐩àсàì_сw̲_с갨 ($x) { "foo $x" }
$foo = "fie";
is 𝐩àсàì_сw̲_с갨($foo), "fee fie", 'trait "is rw" used to narrow multi-dispatch';
is 𝐩àсàì_сw̲_с갨("fum"), "foo fum", 'trait "is rw" used to narrow multi-dispatch (converse)';

# is copy
$foo=1;
sub ì갨𝐝ò_𝐩àсàì_개갨𝐩ù ($x is copy) {$x++;}
lives-ok { ì갨𝐝ò_𝐩àсàì_개갨𝐩ù($foo) }, 'is copy';
is($foo, 1, 'pass by value works');

# same test with default value
sub 丛갨갨ì ($arg is copy = 0) { $arg++ }

lives-ok { 丛갨갨ì(42) }, "can modify a copy";


# is raw
{
    $foo=1;
    sub ì갨𝐝ò_𝐩àсàì_сàw̲ ($x is raw) { $x++;  }
    dies-ok { ì갨𝐝ò_𝐩àсàì_сàw̲(1); }, 'is raw with non-lvalue';
    lives-ok { ì갨𝐝ò_𝐩àсàì_сàw̲($foo); }, 'is raw with non-lvalue';
    is($foo, 2, 'is raw works');
}


# with <-> we should still obey readonly traits
{
    my $à丧갨丧1 = <-> $a is readonly, $b { $b++ };
    my $à丧갨丧2 = <-> $a is readonly, $b { $a++ };
    my $x = 1;
    $à丧갨丧1($x, $x);
    is($x, 2,                   '<-> does not override explicit traints (sanity)');
    #?rakudo 2 todo 'is readonly does not override'
    dies-ok({ $à丧갨丧2($x, $x) }, '<-> does not override explicit traints');
    is($x, 2,                   '<-> does not override explicit traints (sanity)');
}


{
    try { EVAL 'my $gack; sub oh_noes( $gack is nonesuch ) { }' };

    ok  $!  ~~ Exception,  "Can't use an unknown trait";
    ok "$!" ~~ /trait/,    'error message mentions trait';
    ok "$!" ~~ /nonesuch/, 'error message mentions the name of the trait';
}

# https://github.com/Raku/old-issue-tracker/issues/6661
is_run ｢
    sub foo1 is tighter(&[**]) is tighter(&[**])
             is looser(&[**])  is looser(&[**])
             is equiv(&[**])   is equiv(&[**]) {}
    sub foo2 is rw is rw {}
    sub foo3 is default is default {}
    sub foo5 is raw is raw {}
    -> $ is readonly is readonly {}
    print 'pass';
｣, {:err{
    .lc.contains: <duplicate tighter looser equiv rw default readonly raw>.all
}, :out<pass>}, 'duplicate traits warn';

# vim: expandtab shiftwidth=4
