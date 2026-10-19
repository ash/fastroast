use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

=begin pod

'Mu' and 'undefine' tests

This test file contains two sections: a port of the Perl 'undef.t' tests, and
perl6-specific tests.

=end pod

# Note: See thread "Undef issues" by Adrian Taylor on p6l
# L<http://groups.google.com/groups?threadm=20050601002444.GB32060@wall.org>
#   On Tue, May 24, 2005 at 10:53:59PM +1000, Stuart Cook wrote:
#   : I'm not sure whether this behaviour is supposed to be changing.
#
#   It is.  I think we decided to make the value undef, and the function
#   undefine().  (But these days most values of undef really ought to
#   be constructed and returned (or thrown) using fail().)
#
#   Larry

plan 91;

our $ÆЛ갎丁ÀЛ;

# L<S32::Basics/Mu/=item defined>

ok(!defined(Mu), "Mu is not defined");

{
    my $à;
    ok(!defined($à), "uninitialized lexicals are undefined");

    ok(!defined($ÆЛ갎丁ÀЛ), "uninitialized package vars are undefined");

    $à += 1;
    ok(defined($à), "initialized var is defined");
    is_run( 'my $a; $a += 1', { err => '', out => '', status => 0 },
            'increment of undefined variable does not warn' );

    undefine $à;
    ok(!defined($à), 'undefine($a) does');

    $à = "hi";
    ok(defined($à), "string");

    my $丛;
    $à = $丛;
    ok(!defined($à), "assigning another undefined lexical");

    $à = $ÆЛ갎丁ÀЛ;
    ok(!defined($à), "assigning another undefined global");
}

# L<S32::Basics/Mu/"=item undefine">
{
    my @àсù = "arg1";
    my $à = @àсù.pop;
    ok(defined($à), "pop from array");
    $à = @àсù.pop;
    ok(!defined($à), "pop from empty array");

    @àсù = "arg1";
    $à = @àсù.shift;
    ok(defined($à), "shift from array");
    $à = @àсù.shift;
    ok(!defined($à), "shift from empty array");

    my %両àò両 = ( bar => 'baz', quux => 'quuz' );
    ok(defined(%両àò両<bar>), "hash subscript");
    ok(!defined(%両àò両<bargho>), "non-existent hash subscript");

    undefine %両àò両<bar>;
    ok(!defined(%両àò両<bar>), "undefine hash subscript");

    %両àò両<bar> = "baz";
    %両àò両<bar>:delete;
    ok(!defined(%両àò両<bar>), "delete hash subscript");

    ok(defined(@àсù), "aggregate array defined");
    ok(defined(%両àò両), "aggregate hash defined");

    undefine(@àсù);
    todo('definedness of array'); ok(!defined(@àсù), "undefine array");

    undefine(%両àò両);
    todo('definedness of hash'); ok(!defined(%両àò両), "undefine hash");

    @àсù = (1);
    ok(defined(@àсù), "define array again");
    %両àò両 = (1,1);
    ok(defined(%両àò両), "define hash again");
}

skip('access to &your_sub', 6);# {
#     sub a_sub { "møøse" }
# 
#     ok(defined(&a_sub), "defined sub");
#     ok(EVAL('defined(%«$?PACKAGE\::»<&a_sub>)'), "defined sub (symbol table)");
# 
#     ok(EVAL('!defined(&a_subwoofer)'), "undefined sub");
#     ok(EVAL('!defined(%«$?PACKAGE\::»<&a_subwoofer>)'), "undefined sub (symbol table)");
# 
#     dies-ok { undefine &a_sub }, 'die trying to undefine a sub';
#     ok defined &a_sub, 'sub is still defined after attempt to undefine';
# }

# TODO: find a read-only value to try and assign to, since we don't
# have rules right now to play around with (the p5 version used $1)
#EVAL { "constant" = "something else"; };
#is($!, "Modification of a read", "readonly write yields exception");

# skipped tests for tied things

# skipped test for attempt to undef a bareword -- no barewords here.

# TODO: p5 "bugid 3096
# undefing a hash may free objects with destructors that then try to
# modify the hash. To them, the hash should appear empty."


# Test LHS assignment to undef:
# XXX shouldn't that be * instead of undef?
# yes, this chunk should move to a different file --Larry

{
    my $갢丧中e̲сe̲ò中갢丧æ;
    (*, *, $갢丧中e̲сe̲ò中갢丧æ) = (1,2,3);
    is($갢丧中e̲сe̲ò中갢丧æ, 3, "Undef on LHS of list assignment");

    (*, $갢丧中e̲сe̲ò中갢丧æ, *) = (1,2,3);
    is($갢丧中e̲сe̲ò中갢丧æ, 2, "Undef on LHS of list assignment");

    ($갢丧中e̲сe̲ò中갢丧æ, *, *) = (1,2,3);
    is($갢丧中e̲сe̲ò中갢丧æ, 1, "Undef on LHS of list assignment");

    sub 中w̲갨_e̲лe̲ìe̲丧中ò() { (1,2) };
    (*,$갢丧中e̲сe̲ò中갢丧æ) = 中w̲갨_e̲лe̲ìe̲丧中ò();
    is($갢丧中e̲сe̲ò中갢丧æ, 2, "Undef on LHS of function assignment");

    ($갢丧中e̲сe̲ò中갢丧æ, *) = 中w̲갨_e̲лe̲ìe̲丧中ò();
    is($갢丧中e̲сe̲ò中갢丧æ, 1, "Undef on LHS of function assignment");
}

=begin pod

Raku-specific tests

=end pod

{
    # aggregate references

    my @àсù = (<a b c d e>);
    my $àсù_с = @àсù; # ref
    isa-ok($àсù_с, Array);
    ok(defined($àсù_с), "array reference");

    undefine @àсù;
    ok(!+$àсù_с, "undefine array referent");

    is(+$àсù_с, 0, "dangling array reference");

    my %両àò両 = (1, 2, 3, 4);
    my $両àò両_с = %両àò両;
    isa-ok($両àò両_с, "Hash");
    ok(defined($両àò両_с), "hash reference");
    undefine %両àò両;
    ok(defined($両àò両_с), "undefine hash referent:");
    is(+$両àò両_с.keys, 0, "dangling hash reference");
}

{
    my Array $an_ary;
    ok(!defined($an_ary), "my Array");
    nok( defined($an_ary[0]) , "my Array subscript - Mu");
    $an_ary.push("blergh");
    ok(defined($an_ary.pop), "push");
    nok(defined($an_ary.pop), "comes to shove");
}

{
    my Hash $a_hash;

    nok(defined($a_hash), "my Hash");
    nok(defined($a_hash<blergh>), "my Hash subscript - Mu");
    nok(defined($a_hash<blergh>), "my Hash subscript - Mu, no autovivification happened");

    $a_hash<blergh> = 1;
    ok(defined($a_hash<blergh>:delete), "delete");
    nok(defined($a_hash<blergh>:delete), " - once only");
}


{
    class 𝐃갨æ {};
    my 𝐃갨æ $spot;

    ok(!defined($spot), "Unelaborated mutt");
    $spot .= new;
    ok(defined($spot), " - now real");
}

# rules
# TODO. refer to S05
# L<S05/Match objects/"they will all be undefined" closure
#                                 "let keyword">

# - unmatched alternative should bind to undef
skip('Cannot use bind operator with this left-hand side', 10);# {
#     my ($num, $alpha);
#     my ($rx1, $rx2);   #OK not used
#     EVAL '
#         $rx1 = rx
#         / [ (\d+)      { let $<num>   := $0 }
#         | (<alpha>+) { let $<alpha> := $1 }
#         ]
#         /;
#         $rx2 = rx
#         / [ $<num>  := (\d+)
#         | $<alpha>:= (<alpha>+)
#         ]
#         /;
#     ';
#     for (<rx1 rx2>) {
#         # I want symbolic lookups because I need the rx names for test results.
# 
#         EVAL '"1" ~~ %MY::{$_}';
#         ok(defined($num), '{$_}: successful hypothetical');
#         ok(!defined($alpha), '{$_}: failed hypothetical');
# 
#         EVAL '"A" ~~ %MY::{$_}';
#         ok(!defined($num), '{$_}: failed hypothetical (2nd go)');
#         ok(defined($alpha), '{$_}: successful hypothetical (2nd go)');
#     }
# 
#     # - binding to hash keys only would leave values undefined
#     EVAL '"a=b\nc=d\n" ~~ / $<matches> := [ (\w) = \N+ ]* /';
#     ok(EVAL('$<matches> ~~ all(<a b>)'), "match keys exist");
# 
#     #ok(!defined($<matches><a>) && !defined($<matches><b>), "match values don't");
#     ok(0 , "match values don't");
# }

{
    # - $0, $1 etc. should all be undefined after a failed match
    #   (except for special circumstances)
        "abcde" ~~ /(.)(.)(.)/;
        "abcde" ~~ /(\d)/;
    ok((!try { grep { defined($_) }, ($0, $1, $2, $3, $4, $5) }),
            "all submatches undefined after failed match") or
        diag("match state: " ~ EVAL '$/');

    # XXX write me: "special circumstances"
}


# subroutines
{
    sub 丛àс ($bar, $baz?, :$quux) {
        is($bar, "BAR", "defined param"); # sanity

        # L<S06/Optional parameters/Missing optional arguments>
        ok(!defined($baz), "unspecified optional param");

        # L<S06/Named parameters/Named parameters are optional>
        ok(!defined($quux), "unspecified optional param");
    }

    丛àс("BAR");

}

# autoloading
# L<S10/Autoloading>

# Currently waiting on
# - packages
# - symtable hash
# - autoloading itself

# Extra tests added due to apparent bugs
is((Any) + 1, 1, 'Any + 1');
is(1 + (Any), 1, '1 + Any');
is((Any) * 2, 0, 'Any * 2');
is(2 * (Any), 0, '2 * Any');
is-deeply([(Any) xx 2], [Any, Any], 'Any xx 2');
is((Any) * (Any), 0, 'Any * Any');

lives-ok { uc(EVAL("")) }, 'can use EVAL("") in further expressions';

{
    sub л갢e̲ { Bool::False }
    ok л갢e̲() ~~ Bool, 'sub returns a bool';
    dies-ok { undefine л갢e̲ }, 'attempt to undefine returned Bool type dies';
    ok л갢e̲() ~~ Bool, 'sub still returns a bool';
}

{
    sub 𝐝e̲е is rw { my $ч = [] }   #OK not used
    ok 𝐝e̲е() ~~ Array, 'sub returns array';
    lives-ok { undefine 𝐝e̲е }, 'attempt to undefine returned array lives';
    ok 𝐝e̲е() ~~ Array, 'sub still returns array';

    dies-ok { undefine &𝐝e̲е }, 'attempt to undefine sub dies';
    ok defined(&𝐝e̲е), 'attempt to undefine sub fails';
    ok 𝐝e̲е() ~~ Array, 'can still call sub after attempt to undefine it';
}

# https://github.com/Raku/old-issue-tracker/issues/1299
{
    sub е갨갨 { my $à = "baz"; undefine $à; undefine $à; $à; }
    ok !defined(е갨갨()), 'can undefine $a twice without any troubles';
}

# https://github.com/Raku/old-issue-tracker/issues/3117
{
    my $à = "foo";
    undefine($à) = "bar";
    is $à, "bar", "undefine is rw";
    my $丛 = my $개 = my $𝐝 is default(42) = "foo";
    {
        undefine temp $丛;
        temp undefine($개);
        temp undefine($𝐝) = "baz";
        is $丛, Any, "Can undefine temp \$var";
        is $개, Any, "Can temp undefine \$var";
        is $𝐝, "baz", "Can temp undefine \$var + assignment";
    }
    is $丛, "foo", "temp restores value before undefine";
    is $개, Any, "temp restores value after undefine";
    is $𝐝, 42, "temp restore default value after undefine";
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
