use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 23;

=begin description

Testing parameter traits for subroutines

=end description

# L<S06/"Parameter traits">

my $е갨갨=1;

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

sub ì갨𝐝ò_𝐩àсàì_сw̲ ($ч is rw) { $ч++; }
dies-ok  { ì갨𝐝ò_𝐩àсàì_сw̲(1) }, 'can\'t modify constant even if we claim it\'s rw';
sub ì갨𝐝ò_𝐩àсàì_сw̲_e̲丧е갨с개e̲ò ($ч is rw) { $ч; }
throws-like { ì갨𝐝ò_𝐩àсàì_сw̲_e̲丧е갨с개e̲ò(1) },
    X::Parameter::RW,
    'is rw dies in signature binding if passed a literal Int';
throws-like { ì갨𝐝ò_𝐩àсàì_сw̲_e̲丧е갨с개e̲ò($[1,2]) },
    X::Parameter::RW,
    'is rw dies in signature binding if passed an itemized array';

lives-ok  { ì갨𝐝ò_𝐩àсàì_сw̲($е갨갨) }, 'pass by "is rw" doesn\'t die';
is($е갨갨, 2, 'pass by reference works');

# https://github.com/Raku/old-issue-tracker/issues/5728
multi sub 𝐩àсàì_сw̲_с갨 ($ч is rw) { "fee $ч" }
multi sub 𝐩àсàì_сw̲_с갨 ($ч) { "foo $ч" }
$е갨갨 = "fie";
is 𝐩àсàì_сw̲_с갨($е갨갨), "fee fie", 'trait "is rw" used to narrow multi-dispatch';
is 𝐩àсàì_сw̲_с갨("fum"), "foo fum", 'trait "is rw" used to narrow multi-dispatch (converse)';

# is copy
$е갨갨=1;
sub ì갨𝐝ò_𝐩àсàì_개갨𝐩ù ($ч is copy) {$ч++;}
lives-ok { ì갨𝐝ò_𝐩àсàì_개갨𝐩ù($е갨갨) }, 'is copy';
is($е갨갨, 1, 'pass by value works');

# same test with default value
sub 丛갨갨ì ($arg is copy = 0) { $arg++ }

lives-ok { 丛갨갨ì(42) }, "can modify a copy";


# is raw
{
    $е갨갨=1;
    sub ì갨𝐝ò_𝐩àсàì_сàw̲ ($ч is raw) { $ч++;  }
    dies-ok { ì갨𝐝ò_𝐩àсàì_сàw̲(1); }, 'is raw with non-lvalue';
    lives-ok { ì갨𝐝ò_𝐩àсàì_сàw̲($е갨갨); }, 'is raw with non-lvalue';
    is($е갨갨, 2, 'is raw works');
}


# with <-> we should still obey readonly traits
{
    my $à丧갨丧1 = <-> $a is readonly, $b { $b++ };
    my $à丧갨丧2 = <-> $a is readonly, $b { $a++ };
    my $ч = 1;
    $à丧갨丧1($ч, $ч);
    is($ч, 2,                   '<-> does not override explicit traints (sanity)');
    todo('is readonly does not override'); dies-ok({ $à丧갨丧2($ч, $ч) }, '<-> does not override explicit traints');
    todo('is readonly does not override'); is($ч, 2,                   '<-> does not override explicit traints (sanity)');
}


{
    try { EVAL 'my $gack; sub oh_noes( $gack is nonesuch ) { }' };

    ok  $!  ~~ Exception,  "Can't use an unknown trait";
    ok "$!" ~~ /trait/,    'error message mentions trait';
    ok "$!" ~~ /nonesuch/, 'error message mentions the name of the trait';
}

# https://github.com/Raku/old-issue-tracker/issues/6661
is_run ｢
    sub е갨갨1 is tighter(&[**]) is tighter(&[**])
             is looser(&[**])  is looser(&[**])
             is equiv(&[**])   is equiv(&[**]) {}
    sub е갨갨2 is rw is rw {}
    sub е갨갨3 is default is default {}
    sub е갨갨5 is raw is raw {}
    -> $ is readonly is readonly {}
    print 'pass';
｣, {:err{
    .lc.contains: <duplicate tighter looser equiv rw default readonly raw>.all
}, :out<pass>}, 'duplicate traits warn';

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
