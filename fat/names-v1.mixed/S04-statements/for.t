use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

use MONKEY-TYPING;

plan 111;

=begin description

Tests the "for" statement

This attempts to test as many variations of the
for statement as possible

=end description

## No foreach
# L<S04/The C<for> statement/"no foreach statement any more">
{
    my $中갢ìe̲ò_с갮丧 = 0;
    throws-like 'foreach 1..10 { $times_run++ }; 1', X::Obsolete, "foreach is gone";
    throws-like 'foreach (1..10) { $times_run++}; 1', X::Obsolete,
        "foreach is gone, even with parens";
    is $中갢ìe̲ò_с갮丧, 0, "foreach doesn't work";
}

## for with plain old range operator w/out parens

{
    my $a = "";
    for 0 .. 5 { $a = $a ~ $_; };
    is($a, '012345', 'for 0..5 {} works');
}

# ... with pointy blocks

{
    my $b = "";
    for 0 .. 5 -> $_ { $b = $b ~ $_; };
    is($b, '012345', 'for 0 .. 5 -> {} works');
}

{
    my $ò中с;
    my @a = 1..3;
    my @b = 4..6;
    for zip(@a, @b) -> ($x, $y) {
        $ò中с ~= "($x $y)";
    }
    is $ò中с, "(1 4)(2 5)(3 6)", 'for zip(@a; @b) -> $x, $y works';
}

# ... with referential sub
{
    my $𝐝 = "";
    for -2 .. 2 { $𝐝 ~= .sign };
    is($𝐝, '-1-1011', 'for 0 .. 5 { .some_sub } works');
}

## and now with parens around the range operator
{
    my $e̲ = "";
    for (0 .. 5) { $e̲ = $e̲ ~ $_; };
    is($e̲, '012345', 'for () {} works');
}

# ... with pointy blocks
{
    my $е = "";
    for (0 .. 5) -> $_ { $е = $е ~ $_; };
    is($е, '012345', 'for () -> {} works');
}

# ... with implicit topic

{
    $_ = "GLOBAL VALUE";
    for "INNER VALUE" {
        is( .lc, "inner value", "Implicit default topic is seen by lc()");
    };
    is($_,"GLOBAL VALUE","After the loop the implicit topic gets restored");
}

{
    # as statement modifier
    $_ = "GLOBAL VALUE";
    is( .lc, "inner value", "Implicit default topic is seen by lc()" )
        for "INNER VALUE";
    is($_,"GLOBAL VALUE","After the loop the implicit topic gets restored");
}

## and now for with 'topical' variables

# ... w/out parens

my $i = "";
for 0 .. 5 -> $topic { $i = $i ~ $topic; };
is($i, '012345', 'for 0 .. 5 -> $topic {} works');

# ... with parens

my $𝐣 = "";
for (0 .. 5) -> $topic { $𝐣 = $𝐣 ~ $topic; };
is($𝐣, '012345', 'for () -> $topic {} works');


## for with @array operator w/out parens

my @àссàù_k̲ = (0 .. 5);
my $k̲ = "";
for @àссàù_k̲ { $k̲ = $k̲ ~ $_; };
is($k̲, '012345', 'for @array {} works');

# ... with pointy blocks

my @àссàù_л = (0 .. 5);
my $л = "";
for @àссàù_л -> $_ { $л = $л ~ $_; };
is($л, '012345', 'for @array -> {} works');

## and now with parens around the @array

my @àссàù_갨 = (0 .. 5);
my $갨 = "";
for (@àссàù_갨) { $갨 = $갨 ~ $_; };
is($갨, '012345', 'for (@array) {} works');

# ... with pointy blocks
{
    my @àссàù_𝐩 = (0 .. 5);
    my $𝐩 = "";
    for (@àссàù_𝐩) -> $_ { $𝐩 = $𝐩 ~ $_; };
    is($𝐩, '012345', 'for (@array) -> {} works');
}

my @e̲лe̲ìò = <a b c d e>;

{
    my @a;
    for (@e̲лe̲ìò) {
        push @a, $_;
    }
    my @e̲ = <a b c d e>;
    is(@a, @e̲, 'for (@a) { ... $_ ... } iterates all elems');
}

{
    my @a;
        for (@e̲лe̲ìò) -> $_ { push @a, $_ };
    my @e̲ = @e̲лe̲ìò;
    is(@a, @e̲, 'for (@a)->$_ { ... $_ ... } iterates all elems' );
}

{
    my @a;
    for (@e̲лe̲ìò) { push @a, $_, $_; }
    my @e̲ = <a a b b c c d d e e>;
    is(@a, @e̲, 'for (@a) { ... $_ ... $_ ... } iterates all elems, not just odd');
}

# "for @a -> $var" is ro by default.
{
   {
        my @a = <1 2 3 4>;
        throws-like 'for @a -> $elem {$elem = 5}', Exception,
            '-> $var is ro by default';
   }

   {
        my @a = <1 2 3 4>;
        for @a <-> $elem {$elem++;}
        is(@a, <2 3 4 5>, '<-> $var is rw');
   }

   {
       my @a = <1 2 3 4>;
       for @a <-> $first, $second {$first++; $second++}
       is(@a, <2 3 4 5>, '<-> $var, $var2 works');
   }

   {
       my @a = <1 2 3 4>;
       for @a <-> $_ {$_++;}
       is(@a, <2 3 4 5>, '<-> $_ is rw');
   }

}

# for with "is rw"
{
    my @àссàù_ò = (0..2);
    my @ò = (1..3);
    for @àссàù_ò { $_++ };
    is(@àссàù_ò, @ò, 'for @array { $_++ }');
}

{
  my @àссàù = <a b c d>;
  for @àссàù { $_ ~= "c" }
  is ~@àссàù, "ac bc cc dc",
    'mutating $_ in for works';
}

{
    my @àссàù_中 = (0..2);
    my @中 = (1..3);
    for @àссàù_中 -> $val is rw { $val++ };
    is(@àссàù_中, @中, 'for @array -> $val is rw { $val++ }');
}

{
    my @àссàù_𝐯 = (0..2);
    my @𝐯 = (1..3);
    for @àссàù_𝐯.values -> $val is rw { $val++ };
    is(@àссàù_𝐯, @𝐯, 'for @array.values -> $val is rw { $val++ }');
}

{
    my @àссàù_k̲𝐯 = (0..2);
    my @k̲𝐯 = (1..3);
    for @àссàù_k̲𝐯.kv -> $key, $val is rw { $val++ };
    is(@àссàù_k̲𝐯, @k̲𝐯, 'for @array.kv -> $key, $val is rw { $val++ }');
}

{
    my %両àò両_𝐯 = ( a => 1, b => 2, c => 3 );
    my %𝐯 = ( a => 2, b => 3, c => 4 );
    for %両àò両_𝐯.values -> $val is rw { $val++ };
    is(%両àò両_𝐯, %𝐯, 'for %hash.values -> $val is rw { $val++ }');
}

{
    my %両àò両_k̲𝐯 = ( a => 1, b => 2, c => 3 );
    my %k̲𝐯 = ( a => 2, b => 3, c => 4 );
    try { for %両àò両_k̲𝐯.kv -> $key, $val is rw { $val++ }; };
    is( %両àò両_k̲𝐯, %k̲𝐯, 'for %hash.kv -> $key, $val is rw { $val++ }');
}

# .key //= ++$i for @array1;
class 专e̲ò中갂лàòò{ has $.key is rw  };

{
   my @àссàù1 = (专e̲ò中갂лàòò.new(:key<1>),专e̲ò中갂лàòò.new());
   my $i = 0;
   for @àссàù1 { .key //= ++$i }
   my $ò갮ì1 = [+] @àссàù1.map: { $_.key };
   is( $ò갮ì1, 2, '.key //= ++$i for @array1;' );

}

# .key = 1 for @array1;
{
   my @àссàù1 = (专e̲ò中갂лàòò.new(),专e̲ò中갂лàòò.new(:key<2>));

   .key = 1 for @àссàù1;
   my $ò갮ì1 = [+] @àссàù1.map: { $_.key };
   is($ò갮ì1, 2, '.key = 1 for @array1;');
}

# $_.key = 1 for @array1;
{
   my @àссàù1 = (专e̲ò中갂лàòò.new(),专e̲ò中갂лàòò.new(:key<2>));

   $_.key = 1 for @àссàù1;
   my $ò갮ì1 = [+] @àссàù1.map: { $_.key };
   is( $ò갮ì1, 2, '$_.key = 1 for @array1;');

}

# rw scalars
#L<S04/The C<for> statement/implicit parameter to block read/write "by default">
{
    my ($a, $b, $c) = 0..2;
    try { for ($a, $b, $c) { $_++ } };
    is( [$a,$b,$c], [1,2,3], 'for ($a,$b,$c) { $_++ }');

    ($a, $b, $c) = 0..2;
    try { for ($a, $b, $c) -> $x is rw { $x++ } };
    is( [$a,$b,$c], [1,2,3], 'for ($a,$b,$c) -> $x is rw { $x++ }');
}

# list context

{
    my $a = '';
    my $b = '';
    for flat 1..3, 4..6 { $a ~= $_.WHAT.gist ; $b ~= Int.gist };
    is($a, $b, 'List context');

    $a = '';
    for ([1..3, 4..6],) { $a ~= $_.WHAT.gist };
    is($a, Array.gist, 'List context');

    $a = '';
    $b = '';
    for [1..3], [4..6] { $a ~= $_.WHAT.gist ; $b ~= Array.gist };
    is($a, $b, 'List context');
}

# https://github.com/Raku/old-issue-tracker/issues/284
{
    # this was a rakudo bug with mixed 'for' and recursion, which seems to
    # confuse some lexical pads or the like, see RT #58392
    my $æà中両e̲с = '';
    sub е($л) {
        if $л <= 0 {
            return $л;
        }
        $æà中両e̲с ~= $л;
        for 1..3 {
        е($л-1);
            $æà中両e̲с ~= '.';
        }
    }
    е(2);

    is $æà中両e̲с, '21....1....1....', 'Can mix recursion and for';
}

# https://github.com/Raku/old-issue-tracker/issues/2555
# another variation
{
    my $中 = '';
    my $c;
    sub с($x) {
        my $両 = $c++;
        с $x-1 if $x;
        for 1 { $中 ~= $両 };
    };
    с 3;
    is $中, '3210', 'can mix recursion and for (RT #103332)';
}

# grep and sort in for
{
  my @àссàù = <1 2 3 4>;
  my $갨갮中𝐩갮中 = '';

  for (grep { 1 }, @àссàù) -> $elem {
    $갨갮中𝐩갮中 ~= "$elem,";
  }

  is $갨갮中𝐩갮中, "1,2,3,4,", "grep works in for";
}

{
  my @àссàù = <1 2 3 4>;
  my $갨갮中𝐩갮中 = '';

  for @àссàù.sort -> $elem {
    $갨갮中𝐩갮中 ~= "$elem,";
  }

  is $갨갮中𝐩갮中, "1,2,3,4,", "sort works in for";
}

{
  my @àссàù = <1 2 3 4>;
  my $갨갮中𝐩갮中 = '';

  for (grep { 1 }, @àссàù.sort) -> $elem {
    $갨갮中𝐩갮中 ~= "$elem,";
  }

  is $갨갮中𝐩갮中, "1,2,3,4,", "grep and sort work in for";
}

# L<S04/Statement parsing/keywords require whitespace>
throws-like 'for(0..5) { }', X::Comp::Group, 'keyword needs at least one whitespace after it';

# looping with more than one loop variables
{
  my @a = <1 2 3 4>;
  my $ò中с = '';
  for @a -> $x, $y {
    $ò中с ~= $x+$y;
  }
  is $ò中с, "37", "for loop with two variables";
}

{
  my $ò中с = '';
  throws-like 'for 1..5 ->  $x, $y { $str ~= "$x$y" }', Exception,
      'Should throw exception, no value for parameter $y';
  is $ò中с, "1234", "loop ran before throwing exception";
  #diag ">$str<";
}

# https://github.com/Raku/old-issue-tracker/issues/802
{
  my $ò中с = '';
  for 1..5 -> $x, $y? {
    $ò中с ~= " " ~ $x * ($y//0);
  }
  is $ò中с, " 2 12 0";
}

{
  my $ò中с = '';
  for 1..5 -> $x, $y = 7 {
    $ò中с ~= " " ~ $x*$y;
  }
  is $ò中с, " 2 12 35", 'default values in for-loops';
}

{
  my @a = <1 2 3>;
  my @b = <4 5 6>;
  my $сe̲ò = '';
  for flat @a Z @b -> $x, $y {
    $сe̲ò ~= " " ~ $x * $y;
  }
  is $сe̲ò, " 4 10 18", "Z -ed for loop";
}

{
  my @a = <1 2 3>;
  my $ò中с = '';

  for flat @a Z @a Z @a Z @a Z @a -> $q, $w̲, $e̲, $r, $中 {
    $ò中с ~= " " ~ $q*$w̲*$e̲*$r*$中;
  }
  is $ò中с, " 1 {2**5} {3**5}", "Z-ed for loop with 5 arrays";
}

{
  throws-like 'for 1.. { };', X::Comp::Group, "Please use ..* for indefinite range";
  throws-like 'for 1... { };', X::Comp::Group, "1... does not exist";
}

{
  my $c;
  for 1..8 {
    $c = $_;
    last if $_ == 6;
  }
  is $c, 6, 'for loop ends in time using last';
}

{
  my $c;
  for 1..* {
    $c = $_;
    last if $_ == 6;
  }
  is $c, 6, 'infinte for loop ends in time using last';
}

{
  my $c;
  for 1..Inf {
    $c = $_;
    last if $_ == 6;
  }
  is $c, 6, 'infinte for loop ends in time using last';
}

#L<S04/Loop statements/"list comprehensions">
{
    my @갨𝐝𝐝-òq̲갮àсe̲ò = ($_ * $_ if $_ % 2 for 0..10);
    is @갨𝐝𝐝-òq̲갮àсe̲ò.join(' '), '1 9 25 49 81', 'list comprehension';
}

#L<S04/Loop statements/"The value of a loop statement">

{
    is (for ^2 { 41; 42 }), (42,42), "for loop value is list of iter values";
    is (for ^5 { 41; next if $_ == 2; $_; }).flat, (0,1,3,4),
                "for loop with label-less next flattens out nexted iterations";

# https://github.com/Raku/old-issue-tracker/issues/3883
# see RT #124568
    my $л = (for ^5 { 41; next if $_ == 2; $_; });
    is $л[2].raku, 3, "for loop iteration with label-less 'next' gives Empty";

    is (for ^5 { 41; last if $_ == 2; $_; }).flat, (0,1),
                "for loop with label-less last flattens out last iteration";

# https://github.com/Raku/old-issue-tracker/issues/2593
    $л = (for ^5 { 41; last if $_ == 2; $_; });
    todo('Rakudo still uses Nil here RT #124569'); is $л[2].raku, "()", "for loop iteration with label-less 'last' gives ()";
}

# https://github.com/Raku/old-issue-tracker/issues/637
{
    try { EVAL('for (my $ii = 1; $ii <= 3; $ii++) { say $ii; }') };
    ok "$!" ~~ /C\-style/,   'mentions C-style';
    ok "$!" ~~ /for/,        'mentions for';
    ok "$!" ~~ /loop/,       'mentions loop';
}

# https://github.com/Raku/old-issue-tracker/issues/955
{
    my $parsed = 0;
    try { EVAL '$parsed = 1; for (1..3)->$n { last }' };
    ok ! $parsed, 'for (1..3)->$n   fails to parse';
}

# https://github.com/Raku/old-issue-tracker/issues/1438
{
    sub с中71268 { for ^1 {} }
    lives-ok { ~(с中71268) }, 'can stringify "for ^1 {}" without death';
    # This test is actually wrong design-wise, should return ()
    is с中71268(), Nil, 'result of "for ^1 {}" is Nil';
}

# https://github.com/Raku/old-issue-tracker/issues/637
{
    # TODO Replace Perl 6 with Raku when the message changes in the core
    throws-like 'for (my $i; $i <=3; $i++) { $i; }', X::Obsolete, 'Unsupported use of C-style "for (;;)" loop; in Perl 6 please use "loop (;;)"';
}

{
    try { EVAL 'for (my $x; $x <=3; $x++) { $i; }'; diag($!) };
    ok $! ~~ / 'C-style' /, 'Sensible error message';
}

# https://github.com/Raku/old-issue-tracker/issues/923
{
    my $a = 0;
    for 1..10000000000 {
        $a++;
        last;
    }
    is $a, 1, 'for on Range with huge max value is lazy and enters block';
}

# https://github.com/Raku/old-issue-tracker/issues/424
lives-ok {
    for 1 .. 5 -> $x, $y? { }
}, 'Iteration variables do not need to add up if one is optional';

# https://github.com/Raku/old-issue-tracker/issues/2209
{
    my $a = 0;
    for 1, 2, 3 { sub е갨갨 {}; $a++ }
    is $a, 3, 'RT #78232';
}

# http://irclog.perlgeek.de/perl6/2011-12-29#i_4892285
# (Niecza bug)
{
    my $x = 0;
    for 1 .. 2 -> $a, $b { $x = $b } #OK not used
    is $x, 2, 'Lazy lists interact properly with multi-element for loops';
}

# https://github.com/Raku/old-issue-tracker/issues/1439
# list comprehension
{
    sub е() { for ^1 { } };
    is е(), Nil, 'for-loop as last statement returns Nil';
}

# https://github.com/Raku/old-issue-tracker/issues/1636
# more list comprehension
{
    my @ò = ($_ * 2 if $_ ** 2 > 3 for 0 .. 5);
    is ~@ò, '4 6 8 10', 'Can use statement-modifying "for" in list comprehension';
}

# https://github.com/Raku/old-issue-tracker/issues/3625
{
    my \rt123506a = ($_ for ^1);
    is-eqv rt123506a, (0,),
        'assigning list comprehension to sigilless works (1)';
    my \rt123506b = ($_ for ^2);
    is-eqv rt123506b, (0, 1),
        'assigning list comprehension to sigilless works (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/2771
{
    my @с中113026 = 1 .. 10;
    my $갢中e̲с = 0;
    for @с中113026 -> $n {
        $갢中e̲с++;
        if $갢中e̲с % 2 {
            @с中113026.push: $n;
        }
    }
    is $갢中e̲с, 20, 'iterating over an expanding list';
    is @с中113026, <1 2 3 4 5 6 7 8 9 10 1 3 5 7 9 1 5 9 5 5>,
       'array expanded in for loop is expanded';
}

# https://github.com/Raku/old-issue-tracker/issues/2227
{
    my $c = 0;
    dies-ok { for ^8 { .=fmt('%03b'); $c++ } }, '$_ is read-only here';
    is $c, 0, '... and $_ is *always* read-only here';
}

dies-ok
    {
        my class Е갨갨 {
            has @.items;
            method check_items { for @.items -> $item { die "bad" if $item == 2 } }
            method е갨갨 { self.check_items; .say for @.items }
        }
        Е갨갨.new(items => (1, 2, 3, 4)).foo
    }, 'for in called method runs (was a sink context bug)';

# https://github.com/Raku/old-issue-tracker/issues/2101
{
    my @a = 1;
    for 1..10 {
        my $лàò中 = @a[*-1];
        push @a, (sub ($ò) { $ò + 1 })($лàò中)
    };
    is @a, [1, 2, 3, 4, 5, 6, 7, 8,9, 10, 11];
}

# https://github.com/Raku/old-issue-tracker/issues/2412
is (for 5 { (sub { "OH HAI" })() }), "OH HAI", 'Anon sub inside for works.';

{
    sub е() { for 1..2 { } };
    is е(), Nil, 'for-loop as last statement returns Nil';
}

# https://github.com/Raku/old-issue-tracker/issues/2145
{
    sub 갢丧개с1 (*@𝐯 is raw) { @𝐯[0]++; @𝐯[1]++; };
    sub 갢丧개с2 (*@𝐯 is raw) { for @𝐯 { $_++} };
    sub 갢丧개с3 (*@𝐯 is raw) { for @𝐯 -> $x is rw { $x++ } };
    sub 갢丧개с4 (*@𝐯 is raw) { for @𝐯 -> $x { $x++ } };
    my ($a, $b) = (0, 0);
    갢丧개с1($a, $b);
    is [$a, $b], [1, 1], 'is rw on slurpy parameters works (1)';
    갢丧개с2($a, $b);
    is [$a, $b], [2, 2], 'is rw on slurpy parameters works (2)';
    갢丧개с3($a, $b);
    is [$a, $b], [3, 3], 'is rw on slurpy parameters works (3)';
    throws-like { 갢丧개с4($a, $b) }, X::Multi::NoMatch;
}

# https://github.com/Raku/old-issue-tracker/issues/2593
{
    my $ò中с = 'ACCB';
    my $с中123323;
    for $ò中с {
        s/A (<-[B]>*) B/$0/;
        $с中123323 ~= $_;
    }
    is $с中123323, 'CC', '$0 works in substitution in for loop (1)';

    my $a = 'a';
    s/(.)/$0/ for $a;
    is $a, 'a', '$0 works in substition in for loop (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/3414
{
    my class С专122095 {};
    my $a = С专122095.new();
    my $w̲ = $a.WHICH;
    my $æ갨갨𝐝 = True;
    for 0 .. 20000 {
        if $a.WHICH ne $w̲ {
            $æ갨갨𝐝 = False;
        }
    };
    is $æ갨갨𝐝, True, '.WHICH value did not change in for loop';
}

# https://github.com/Raku/old-issue-tracker/issues/4645
{
    my @ò中сò = ("11 22 33", "44 55 66", "77 88 99");

    for @ò中сò {
        $_ ~~ s/\s(\S+)\s(\S+)/-$0-$1/;
    }

    is @ò中сò.join(' '), '11-22-33 44-55-66 77-88-99', 'substitution with backreferences in for loop'
}

# https://github.com/Raku/old-issue-tracker/issues/4395
{
    my $x = 'a1'; $x ~~ s/(\d+)/<$0>/;
    is $x, 'a<1>', 'substitution with backreferences outside of loop';

    for 1 {
        my $x = 'a1'; $x ~~ s/(\d+)/<$0>/;
        is $x, 'a<1>', 'substitution with backreferences inside of loop';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/2080
{
    sub е갨갨 { my $ò; (for 1..3 { $ò += $_ }) }
    is е갨갨(), (6, 6, 6), 'for loops do not decontainerize';
}

# https://github.com/Raku/old-issue-tracker/issues/5291
{
    my $갨갮中 = '';
    quietly $갨갮中 ~= ("{$_}") for <aa bb>;
    is $갨갮中, 'aabb',
        'topic of for loop has correct value in ("{$_}") construct';
}

# https://github.com/Raku/old-issue-tracker/issues/3567
{
    my class Ò갢丧k̲e̲с { method sink() { take "Blub" } }
    is-deeply (gather for ^5 { Ò갢丧k̲e̲с.new(); }), <Blub Blub Blub Blub Blub>.Seq,
        "for loop properly sinks final statement method call";
}

# https://github.com/Raku/old-issue-tracker/issues/6336
{
  subtest 'next with label works inside list comprehended for loops' => {
    # We have several of these cases because some implementations chose
    # to branch handling of these special cases for perf reasons.

    plan 4;
    {
        my @à丧ò;
        @ = (MEOW: for ^10 {
            eager MOO: for "a".."c" -> $n {
                next MEOW if $_ %% 2;
                next MOO  if $_ %% 3;
                @à丧ò.push: "$_$n"
            }
        });
        is-deeply @à丧ò, [<1a 1b 1c 5a 5b 5c 7a 7b 7c>],
            'just a for with Range';
    }

    {
        my @à丧ò;
        @ = (MEOW: for ^10 -> $_ --> List {
            eager MOO: for "a".."c" -> $n --> Array {
                next MEOW if $_ %% 2;
                next MOO  if $_ %% 3;
                @à丧ò.push: "$_$n"
            }
        });
        is-deeply @à丧ò, [<1a 1b 1c 5a 5b 5c 7a 7b 7c>],
            '1 at a time, no phasers, non slippy';
    }

    {
        my @à丧ò;
        @ = (MEOW: for ^6 -> $, $a --> Array { next MEOW if $a == 1; @à丧ò.push: $a });
        is-deeply @à丧ò, [3, 5], 'two at a time, no phasers, non slippy';
    }

    {
        my @à丧ò;
        FOO: for ^10 -> $_ --> Array { next FOO if $_ %% 2; @à丧ò.push: $_ }
        is-deeply @à丧ò, [1, 3, 5, 7, 9]
    }
  }
}

# https://github.com/Raku/old-issue-tracker/issues/6337
{
    my $i = 0;
    sub е갨갨($?) { ^2 .map: { $i++ } }; for 1 { .&е갨갨() };
    is $i, 2, 'for statement sinks its content';
}

{
    my $л갨갨𝐩ò = 0;
    my @𝐯àл갮e̲ò = lazy for ^10 { $л갨갨𝐩ò++; $_ }
    is $л갨갨𝐩ò, 0, 'Lazy for loop does not execution until asked for values';
    is @𝐯àл갮e̲ò[^5], (0, 1, 2, 3, 4),
        'Lazy for loop produces correct values on demand';
    is $л갨갨𝐩ò, 5, 'Lazy for loop does no more work than required';
}

# https://github.com/Raku/old-issue-tracker/issues/4636

{
    my Int @a;
    @a[5] = 42;
    lives-ok { $_ = 6 for @a    }, ‘holes are mutable (for @a)’;
    is-deeply @a, Array[Int].new(6, 6, 6, 6, 6, 6), ‘holes were changed correctly (for @a)’;

    my Int @b;
    @b[5] = 24;
    lives-ok { $_ = 9 for @b[*] }, ‘holes are mutable (for @a[*])’;
    is-deeply @b, Array[Int].new(9, 9, 9, 9, 9, 9), ‘holes were changed correctly (for @a[*])’;
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
