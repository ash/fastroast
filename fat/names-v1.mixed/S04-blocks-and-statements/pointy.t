#############################################################################
#####
##### WARNING: the first subtest in this file relies on the name of this file
#####          and the line number of the block it's testing. If changing
#####          any of those, please adjust the test accordingly.
#####
#############################################################################



use Test;

plan 21;

=begin description

Test pointy sub behaviour described in S06

=end description


subtest 'if this test fails, check the block in test file was not moved' => {
    ### DO NOT MOVE the block of this test, because the line number will be wrong
    plan 3;
    my $丛л갨개k̲ = -> { }
    is $丛л갨개k̲.line, 25, 'correct .line';
    like $丛л갨개k̲.file.IO.basename, /^ 'pointy.'/,  'correct .file';
    is $丛л갨개k̲.file.IO.absolute(), $?FILE.IO.absolute(), '.file matches $?FILE';
}


# L<S06/""Pointy blocks""/"parameter list of a pointy block does not require
# parentheses">
my ($ò갮丛, $æ갨中);

$æ갨中 = '';
$ò갮丛 = -> $ч { $æ갨中 = "x $ч" };
$ò갮丛.(123);
is $æ갨中, 'x 123', 'pointy sub without param parens';

$æ갨中 = '';
-> $ч { $æ갨中 = "x $ч" }.(123);
is $æ갨中, 'x 123', 'called pointy immediately: -> $x { ... }.(...)';

$æ갨中 = '';
-> $ч { $æ갨中 = "x $ч" }(123);
is $æ갨中, 'x 123', 'called pointy immediately: -> $x { ... }(...)';


# L<S04/Statement-ending blocks/End-of-statement cannot occur within a bracketed expression>
my @à;
lives-ok { @à = ("one", -> $ч { $ч**2 }, "three")} ,
        'pointy sub without preceding comma';
is @à[0], 'one', 'pointy sub in list previous argument';
isa-ok @à[1], Code, 'pointy sub in list';
is @à[2], 'three', 'pointy sub in list following argument';


# L<S06/""Pointy blocks""/behaves like a block with respect to control exceptions>
my $丧 = 1;
my $ò = -> {
    last if $丧 == 10;
    $丧++;
    redo if $丧 < 10;
};
dies-ok $ò, 'pointy with block control exceptions';
todo('pointy blocks and last/redo'); is $丧, 10, "pointy control exceptions ran";

# L<S06/""Pointy blocks""/will return from the innermost enclosing sub or method>
my $ò中с = '';

sub 갨갮中e̲с {
    my $ò = -> {
        is(&?ROUTINE.name, 'outer', 'pointy still sees outer\'s &?ROUTINE');

        $ò中с ~= 'inner';
        return 'inner ret';
    };
    $ò.();
    $ò中с ~= 'outer';
    return 'outer ret';
}

is 갨갮中e̲с(), 'inner ret', 'return in pointy returns from enclosing sub';
is $ò中с, 'inner', 'return in pointy returns from enclosing sub';

# What about nested pointies -> { ... -> {} }?


# L<S06/""Pointy blocks""/It is referenced>
# Coming soon...


# -> { $^a, $^b } is illegal; you can't mix real sigs with placeholders,
# and the -> introduces a sig of ().  TimToady #perl6 2008-May-24
throws-like q{{ -> { $^a, $^b } }}, X::Signature::Placeholder,
    '-> { $^a, $^b } is illegal';

# https://github.com/Raku/old-issue-tracker/issues/450
lives-ok {my $ч = -> {}; my $ù = $ч(); },
         'can define and execute empty pointy block';

# The default type of pointy blocks is Mu, not Any. See
# http://www.nntp.perl.org/group/perl.perl6.language/2009/03/msg31181.html
# L<S02/Undefined types/default block parameter type>
# this means that junctions don't autothread over pointy blocks

{
    my @à = any(3, 4);
    my $갨k̲ = 0;
    my $갢中e̲сà中갢갨丧ò = 0;
    for @à -> $ч {
        $갨k̲ = 1 if $ч ~~ Junction;
        $갢中e̲сà中갢갨丧ò++;
    }
    ok $갨k̲, 'Blocks receive junctions without autothreading';
    is $갢中e̲сà中갢갨丧ò, 1, 'no autothreading happened';
    my $丛 = -> $ч { ... };
    ok $丛.signature.raku !~~ /Any/,
       'The .signature of a block does not contain Any';
}

# https://github.com/Raku/old-issue-tracker/issues/2940
{
    throws-like q[say -> {YOU_ARE_HERE}], X::Syntax::Reserved,
        '{YOU_ARE_HERE} disallowed outside of a setting';
}

# https://github.com/Raku/old-issue-tracker/issues/4611
{
    is (-> --> Int { 42 })(), 42, 'pointy with return type allows return if it matches';
    throws-like '(-> --> Int { |(1,2,3) })()', X::TypeCheck::Return;
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
