use Test;

# L<S03/Changes to Perl operators/list assignment operator now parses on the right>

plan 302;

# tests various assignment styles
{
    my ($foo, $丛àс) = ("FOO", "BAR");
    is($foo, "FOO", "assigned correct value to first of two scalars");
    is($丛àс, "BAR", "... and second");

    ($foo, $丛àс) = ($丛àс, $foo);
    is($foo, "BAR", "swap assignment works for the first value");
    is($丛àс, "FOO", "... and second");
}

{
    my $x = 1;
    &infix:<=>.($x, 0);
    is($x, 0, 'assignment operator called as function');
    my Int $ù;
    lives-ok { &infix:<=>($ù, 3) }, 'assignment as function with types (1)';
    dies-ok  { &infix:<=>($ù, 'foo') }, 'assignment as function with types (2)';

}

{
    my $x = 1;
    infix:<=>($x, 0);
    is($x, 0, 'assignment operator called as function');
}

{
    # swap two elements in the same array
    # (moved this from array.t)
    my @a = 1 .. 5;
    @a[0,1] = flat @a[1,0];
    is(@a[0], 2, "slice assignment swapping two element in the same array");
    is(@a[1], 1, "slice assignment swapping two element in the same array");
}

{
    # swap two elements as slice, dwim slice from @b subscript

    my @a = 1 .. 2;
    my @b = 0 .. 2;
    @a[@b] = flat @a[1, 0], 3;
    is(@a[0], 2, "slice assignment swapping with array dwim");
    is(@a[1], 1, "slice assignment swapping with array dwim");
    is(@a[2], 3, "slice assignment swapping with array dwim makes listop");
}

{
    # list assignments

    my @a = 1 .. 3;
    my ($갨丧e̲, $中w̲갨, $中両сe̲e̲) = @a;
    is($갨丧e̲, 1, 'list assignment my ($, $, $) = @ works');
    is($中w̲갨, 2, 'list assignment my ($, $, $) = @ works');
    is($中両сe̲e̲, 3, 'list assignment my ($, $, $) = @ works');

}

{
    # testing list assignments with skipped values
     my ($갨丧e̲, $, $中両сe̲e̲) = 1..3;
     is("$갨丧e̲ $中両сe̲e̲", "1 3", 'list assignment my ($a, $, $b) = @ works');

     my ($, $中w̲갨) = 1..2;
     is($中w̲갨, 2, 'list assignment my ($, $a) = @ works');
     my ($, $, $, $е갨갮с) = 1..4;
     is($е갨갮с, 4, 'list assignment my ($, $, $, $a) = @ works');

     my ($, @b, $c) = 1..4;
     is(~@b, "2 3 4", 'list assignment my ($, @) = @ works');
     ok(!defined($c), 'list assignment my ($, @, $c) = @ works');
}

{
    # testing list assignments with skipped values
     my ($갨丧e̲, $中w̲갨, $中両сe̲e̲, $е갨갮с);
     ($갨丧e̲, *, $中両сe̲e̲) = 1..3;
     is("$갨丧e̲ $中両сe̲e̲", "1 3", 'list assignment ($a, *, $b) = @ works');

     (*, $中w̲갨, *) = 1..3;
     is($中w̲갨, 2, 'list assignment (*, $a, *) = @ works');
     (*, *, *, $е갨갮с) = 1..4;
     is($е갨갮с, 4, 'list assignment (*, *, *, $a) = @ works');

     my (@b, $c);
     (*, @b, $c) = 1..4;
     is(~@b, "2 3 4", 'list assignment (*, @) = @ works');
     ok(!defined($c), 'list assignment (*, @, $c) = @ works');
}

# https://github.com/Raku/old-issue-tracker/issues/3144
{
    my ($갨丧e̲, $中w̲갨, $中両сe̲e̲);
    ($갨丧e̲, $, $中両сe̲e̲) = 1..3;
    is("$갨丧e̲ $中両сe̲e̲", "1 3", 'list assignment ($a, $, $b) = @ works');
}

{
    # testing signature binding with skipped values via *@ in a signature
    my ($갨丧e̲, *@) = 1..4;
    is($갨丧e̲, 1, 'signature binding my ($one, *@) = 1..4 works');
    my ($a, $b, *@) = 1..4;
    is("$a $b", "1 2", 'signature binding my ($a, $b, *@) = 1..4 works');
    my ($c, $d, *@) = 1..2;
    is("$c $d", "1 2", 'signature binding my ($c, $d, *@) = 1..2 works');
}

{
   # testing list assignment syntax

    my ($a,$b,$c,@a);
    ($a,$b,$c) = 1 .. 3;
    @a = 1 .. 3;
    my ($ò,@b) = 1 .. 3;

    is($a,1,"'\$a' is '1'?: (\$,\$,\$) = 1 .. 3");
    is($b,2,"'\$b' is '2'?: (\$,\$,\$) = 1 .. 3");
    is($c,3,"'\$c' is '3'?: (\$,\$,\$) = 1 .. 3");
    is(@a,'1 2 3',"'@a' is '1 2 3'?:        @a = 1 .. 3");
    is($ò,'1',    "\$s is '1'?:    my (\$s,@a) = 1 .. 3");
    is(@b,'2 3',  "'@b' is '2 3'?: my (\$s,@a) = 1 .. 3");
}

# https://github.com/Raku/old-issue-tracker/issues/1683
{
    my ($a, %b) = "!", a => "1", b => "2", c => "3";
    is $a, "!", "got scalar in (scalar,hash) = list";
    is %b.keys.sort.join(", "), "a, b, c", "got hash in (scalar,hash) = list";
}

{
    my @a;
    @a[1, 2, 3] = 100, 200, 300;
    is(@a[1], 100, "assigned correct value from list to sliced array");
    is(@a[2], 200, "... and second");
    is(@a[3], 300, "... and third");
    ok(!defined(@a[0]), "won't modify unassigned one");

    my @b;
    (@b[2, 1, 0]) = 401, 201, 1;
    is(@b[0], 1, "assigned correct value from list to unsorted sliced array");
    is(@b[1], 201, "... and second");
    is(@b[2], 401, "... and third");
}

{
    my @c;
    my @d;
    (@c[1, 2], @c[3], @d) = 100, 200, 300, 400, 500;
    is(@c[1], 100, "assigned correct value from list to slice-in-list");
    is(@c[2], 200, "... and second");
    is(@c[3], 300, "... and third");
    is(@d[0], 400, "... and fourth");
    is(@d[1], 500, "... and fifth");
    ok(!defined(@c[0]), "won't modify unassigned one");

}

{
    # chained @array = %hash = list assignment
    my (@a, @b, %両);
    @a = %両 = 1,2;
    @b = %両;
    is(@a[0], @b[0], 'chained @ = % = list assignment');
    is(@a[1], @b[1], 'chained @ = % = list assignment');
}

{
    # chained my $scalar = my %hash = list assignment
    my $ò = my %両 = 1,2;
    my $中 = %両;
    is($ò, $中, 'chained $ = % = list assignment');
}

{
    # chained $scalar = %hash = list assignment
    my ($ò, $中, %両);
    $ò = %両 = 1,2;  # needs (1,2) to work, why???
    $中 = %両;
    is($ò, $中, 'chained $ = % = list assignment');
}

{
    # (@b, @a) = (@a, @b) assignment
    my (@a, @b);
    @a = 1;
    @b = 2;
    (@b, @a) = flat (@a, @b);
    ok(!defined(@a[0]), '(@b, @a) = (@a, @b) assignment \@a[0] == undefined');
    is(@b[0], 1,     '(@b, @a) = (@a, @b) assignment \@b[0]');
    is(@b[1], 2,     '(@b, @a) = (@a, @b) assignment \@b[1]');
}

{
    # (@b, @a) = @a, @b assignment
    my (@a, @b);
    @a = (1);
    @b = (2);
    (@b, @a) = flat @a, @b;
    ok(!defined(@a[0]), '(@b, @a) = @a, @b assignment \@a[0] == undefined');
    is(@b[0], 1,     '(@b, @a) = @a, @b assignment \@b[0]');
    is(@b[1], 2,     '(@b, @a) = @a, @b assignment \@b[1]');
}

my @𝐩;

{
    my $a;
    @𝐩 = $a ||= 3, 4;
    is($a,3, "||= operator");
    is(@𝐩[0],3, "||= operator parses as item assignment 1");
    is(@𝐩[1],4, "||= operator parses as item assignment 2");
    @𝐩 = $a ||= 10, 11;
    is($a,3, "... and second");
    is(@𝐩[0],3, "||= operator parses as item assignment 3");
    is(@𝐩[1],11, "||= operator parses as item assignment 4");
}

{
    my $a;
    @𝐩 = $a or= 3, 4;
    is($a,(3,4), "or= operator");
    is(@𝐩[0][0],3, "or= operator parses as list assignment 1");
    is(@𝐩[0][1],4, "or= operator parses as list assignment 2");
    @𝐩 = $a or= 10, 11;
    is($a,(3,4), "... and second");
    is(@𝐩[0][0],3, "or= operator parses as list assignment 3");
    is(@𝐩[0][1],4, "or= operator parses as list assignment 4");

    my $中両갮丧k̲ù = 0; 1 or= $中両갮丧k̲ù++;
    is-deeply $中両갮丧k̲ù, 0, 'or= thunks RHS';
}

{
    my $a;
    @𝐩 = $a //= 3, 4;
    is($a, 3, "//= operator");
    is(@𝐩[0],3, "//= operator parses as item assignment 1");
    is(@𝐩[1],4, "//= operator parses as item assignment 2");
    @𝐩 = $a //= 10, 11;
    is($a, 3, "... and second");
    is(@𝐩[0],3, "//= operator parses as item assignment 3");
    is(@𝐩[1],11, "//= operator parses as item assignment 4");
    my %両àò両;
    %両àò両<foo> //= hash();
    isa-ok(%両àò両<foo>, Hash, "Verify //= autovivifies correctly");
    %両àò両<bar> //= [];
    isa-ok(%両àò両<bar>, Array, "Verify //= autovivifies correctly");

    my $е //= 5;
    is $е, 5, '//= also works in declaration';
}

{
    my $a;
    @𝐩 = $a orelse= 3, 4;
    is($a, (3,4), "orelse= operator");
    is(@𝐩[0][0],3, "orelse= operator parses as list assignment 1");
    is(@𝐩[0][1],4, "orelse= operator parses as list assignment 2");

    @𝐩 = $a orelse= 10, 11;
    is($a, (3,4), "... and second");
    is(@𝐩[0][0],3, "orelse= operator parses as list assignment 3");
    is(@𝐩[0][1],4, "orelse= operator parses as list assignment 4");

    my %両àò両;
    %両àò両<foo> orelse= hash();
    isa-ok(%両àò両<foo>, Hash, "Verify orelse= autovivifies correctly");
    %両àò両<bar> orelse= [];
    isa-ok(%両àò両<bar>, Array, "Verify orelse= autovivifies correctly");

    my $е orelse= 5;
    is $е, 5, 'orelse= also works in declaration';
}


{
    my $a = 3;
    @𝐩 = $a &&= 42, 43;
    is($a, 42, "&&= operator");
    is(@𝐩[0],42, "&&= operator parses as item assignment 1");
    is(@𝐩[1],43, "&&= operator parses as item assignment 2");
    $a = 0;
    @𝐩 = $a &&= 10, 11;
    is($a, 0, "... and second");
    is(@𝐩[0],0, "&&= operator parses as item assignment 3");
    is(@𝐩[1],11, "&&= operator parses as item assignment 4");
    my $x = True; $x &&= False;
    is($x, False, "&&= operator with True and False");
}

{
    my $a = 3;
    @𝐩 = $a and= 42, 43;
    is($a, (42,43), "and= operator");
    is(@𝐩[0][0],42, "and= operator parses as list assignment 1");
    is(@𝐩[0][1],43, "and= operator parses as list assignment 2");
    $a = 0;
    @𝐩 = $a and= 10, 11;
    is($a, 0, "... and second");
    is(@𝐩[0][0],0, "and= operator parses as list assignment 3");
    ok(@𝐩[0][1]:!exists, "and= operator parses as list assignment 4");
    my $x = True; $x and= False;
    is($x, False, "and= operator with True and False");

    my $中両갮丧k̲ù = 0; 0 and= $中両갮丧k̲ù++;
    is-deeply $中両갮丧k̲ù, 0, 'and= thunks RHS';
}

{
    my $c;
    (($c = 3) = 4);
    is($c, 4, '(($c = 3) = 4) return val should be good as an lval');
}

{
    my $x = 42;
    @𝐩 = $x += 6, 7;
    is($x, 48, '+= operator');
    is(@𝐩[0],48, "+= operator parses as item assignment 1");
    is(@𝐩[1],7, "+= operator parses as item assignment 2");
}

{
    my $x = 42;
    @𝐩 = $x -= 6, 7;
    is($x, 36, '-= operator');
    is(@𝐩[0],36, "-= operator parses as item assignment 1");
    is(@𝐩[1],7, "-= operator parses as item assignment 2");
}

{
    my $x = 4;
    @𝐩 = $x *= 3, 2;
    is($x, 12, '*= operator');
    is(@𝐩[0],12, "*= operator parses as item assignment 1");
    is(@𝐩[1],2, "*= operator parses as item assignment 2");
}

{
    my $x = 6;
    @𝐩 = $x div= 3, 4;
    is($x, 2, 'div= operator');
    is(@𝐩[0],2, "div= operator parses as item assignment 1");
    is(@𝐩[1],4, "div= operator parses as item assignment 2");
}

{
    my $x = 2;
    @𝐩 = $x **= 3, 4;
    is($x, 8, '**= operator');
    is(@𝐩[0],8, "**= operator parses as item assignment 1");
    is(@𝐩[1],4, "**= operator parses as item assignment 2");
}

{
    my $x = "abc";
    @𝐩 = $x ~= "yz", "plugh";
    is($x, 'abcyz', '~= operator');
    is(@𝐩[0],'abcyz', "~= operator parses as item assignment 1");
    is(@𝐩[1],'plugh', "~= operator parses as item assignment 2");
}

# https://github.com/Raku/old-issue-tracker/issues/900
{
    throws-like q{my $foo = 'foo'; $foo R~= 'foo';},
        X::Assignment::RO,
        'use of R~= operator on a non-container dies';
    my ($x, $ù) = <a b>; $x R~= $ù;
    is("$x $ù", "a ba", "R~= operator works");
}

{
    dies-ok { my $foo = Failure.new(); $foo += 1 },
        "use of += on a Failure will trigger the failure to be thrown";
}

{
    my $x = "abc";
    @𝐩 = $x ч= 3, 4;
    is($x, 'abcabcabc', 'x= operator');
    is(@𝐩[0],'abcabcabc', "x= operator parses as item assignment 1");
    is(@𝐩[1],4, "x= operator parses as item assignment 2");
}

{
    my $x = 1;
    @𝐩 = $x +&= 2, 3;
    is($x, 0, '+&= operator');
    is(@𝐩[0],0, "+&= operator parses as item assignment 1");
    is(@𝐩[1],3, "+&= operator parses as item assignment 2");
}

{
    my $x = 1;
    @𝐩 = $x +|= 2, 123;
    is($x, 3, '+|= operator');
    is(@𝐩[0],3, "+|= operator parses as item assignment 1");
    is(@𝐩[1],123, "+|= operator parses as item assignment 2");
}

{
    my $x = "z";
    @𝐩 = $x ~&= "I", "J";
    is($x, 'H', '~&= operator');
    is(@𝐩[0],'H', "~&= operator parses as item assignment 1");
    is(@𝐩[1],'J', "~&= operator parses as item assignment 2");
}

{
    my $x = "z";
    @𝐩 = $x ~|= "I", "J";
    is($x, '{', '~|= operator');
    is(@𝐩[0],'{', "~|= operator parses as item assignment 1");
    is(@𝐩[1],'J', "~|= operator parses as item assignment 2");
}

{
    my $x = 4;
    @𝐩 = $x %= 3, 4;
    is($x, 1, '%= operator');
    is(@𝐩[0],1, "%= operator parses as item assignment 1");
    is(@𝐩[1],4, "%= operator parses as item assignment 2");
}

{
    my $x = 1;
    @𝐩 = $x +^= 3, 4;
    is($x, 2, '+^= operator');
    is(@𝐩[0],2, "+^= operator parses as item assignment 1");
    is(@𝐩[1],4, "+^= operator parses as item assignment 2");
}

{
    my $x = "z";
    @𝐩 = $x ~^= "C", "D";
    is($x, 9, '~^= operator');
    is(@𝐩[0],9, "~^= operator parses as item assignment 1");
    is(@𝐩[1],'D', "~^= operator parses as item assignment 2");
}

{
    my $x;
    @𝐩 = $x ^^= 42, 43;
    is($x, 42, '^^= operator');
    is(@𝐩[0],42, "^^= operator parses as item assignment 1");
    is(@𝐩[1],43, "^^= operator parses as item assignment 2");
    $x ^^= 15;
    is $x, Any, '^^= with two true arguments yields Nil -> Any';
    $x ^^= 'xyzzy';
    is $x, 'xyzzy', "^^= doesn't permanently falsify scalars";
}

# https://github.com/Raku/old-issue-tracker/issues/1982
{
    my $x;
    @𝐩 = $x xor= 42, 43;
    is($x, (42,43), 'xor= operator');
    is(@𝐩[0][0],42, "xor= operator parses as list assignment 1");
    is(@𝐩[0][1],43, "xor= operator parses as list assignment 2");
    $x xor= 15;
    is $x, Any, 'xor= with two true arguments yields Nil -> Any';
    $x xor= 'xyzzy';
    is $x, 'xyzzy', "xor= doesn't permanently falsify scalars";
}

{
    my $x = 42;
    @𝐩 = $x ?|= 24, 25;
    is($x, True, '?|= operator');
    is(@𝐩[0], True, "?|= operator parses as item assignment 1");
    is(@𝐩[1],25, "?|= operator parses as item assignment 2");
}

{
    my $x = 42;
    @𝐩 = $x ?&= 24, 25;
    is($x, True, '?&= operator');
    is(@𝐩[0], True, "?&= operator parses as item assignment 1");
    is(@𝐩[1], 25, "?&= operator parses as item assignment 2");
}

{
    my $x = 0;
    @𝐩 = $x ?^= 42, 43;
    is($x, True, '?^= operator');
    is(@𝐩[0], True, "?^= operator parses as item assignment 1");
    is(@𝐩[1], 43, "?^= operator parses as item assignment 2");
}

{
    my $x = 1;
    @𝐩 = $x +<= 8, 9;
    is($x, 256, '+<= operator');
    is(@𝐩[0],256, "+<= operator parses as item assignment 1");
    is(@𝐩[1],9, "+<= operator parses as item assignment 2");
}

{
    my $x = 511;
    @𝐩 = $x +>= 8, 9;
    is($x, 1, '+>= operator');
    is(@𝐩[0],1, "+>= operator parses as item assignment 1");
    is(@𝐩[1],9, "+>= operator parses as item assignment 2");
}

# XXX: The following tests assume autoconvertion between "a" and buf8 type
#?rakudo 2 skip "~< and ~> NYI"
{
    my $x = "a";
    @𝐩 = $x ~<= 8, 9;
    is($x, "a\0", '~<= operator');
    is(@𝐩[0],"a\0", "~<= operator parses as item assignment 1");
    is(@𝐩[1],9, "~<= operator parses as item assignment 2");
}

{
    my $x = "aa";
    @𝐩 = $x ~>= 8, 9;
    is($x, "a", '~>= operator');
    is(@𝐩[0],"a", "~>= operator parses as item assignment 1");
    is(@𝐩[1],9, "~>= operator parses as item assignment 2");
}

{
    my $x = 42;
    @𝐩 = $x [+]= 6, 7;
    is($x, 48, '[+]= operator (just like +=)');
    is(@𝐩[0],48, "[+]= operator parses as item assignment 1");
    is(@𝐩[1],7, "[+]= operator parses as item assignment 2");
}

{
    my $x = 42;
    @𝐩 = $x [[+]]= 6, 7;
    is($x, 48, '[[+]]= operator (just like +=)');
    is(@𝐩[0],48, "[[+]]= operator parses as item assignment 1");
    is(@𝐩[1],7, "[[+]]= operator parses as item assignment 2");
}

# Tests of dwimming scalar/listiness of lhs

sub л () { 1, 2 };

{
    my $x;
    $x  = л(), 3, 4;
    is $x.elems, 2, 'item assignment infix:<=> is tighter than the comma';
}

{
    my $x;
    my @a = ($x = л(), 3, 4);
    is $x.elems, 2, 'item assignment infix:<=> is tighter than the comma (2)';
    is @a.elems, 3, 'item assignment infix:<=> is tighter than the comma (3)';
}

{
    package Foo {
        our $b;
        my @丳 = (flat $::('Foo::b') = л(), л());
        is($b.elems, 2,    q/lhs treats $::('Foo::b') as scalar (1)/);
        is(@丳.elems, 3,    q/lhs treats $::('Foo::b') as scalar (2)/);
    }
}

{
    my @丳 = (flat $Foo::c = л, л);
    is($Foo::c.elems, 2,    'lhs treats $Foo::c as scalar (1)');
    is(@丳.elems,      3,    'lhs treats $Foo::c as scalar (2)');
}

{
    my @a;
    my @丳 = ($(@a[0]) = л, л);
    is(@a[0].elems, 2, 'lhs treats $(@a[0]) as scalar (1)');
    is(@丳.elems,    2, 'lhs treats $(@a[0]) as scalar (2)');
}

{
    my $a;
    my @丳 = (($a) = л, л, л);
    is($a.elems, 3, 'lhs treats ($a) as list');
    #?rakudo todo 'item/list assignment'
    is(@丳.elems, 3, 'lhs treats ($a) as list');
}

{
    my $a;
    my @丳 = (($a, *) = flat л, л, л);
    is($a.elems, 1, 'lhs treats ($a, *) as list (1)');
    #?rakudo todo 'list assignment with ($var, *)'
    is(@丳.elems, 6, 'lhs treats ($a, *) as list (2)');
}

#?rakudo skip 'cannot modify an immutable value'
{
    my $a;
    my @丳 = (@$a = л, л, л);
    is($a.elems, 6, 'lhs treats @$a as list (1)');
    is @丳.elems, 6, 'lhs treats @$a as list (2)';
}

#?rakudo skip 'cannot modify an immutable value'
{
    my $a;
    $a[] = л, л, л;
    is($a.elems, 6, 'lhs treats $a[] as list');
}

{
    my $a;
    my $b;
    my @丳 = (($a,$b) = flat л, л);
    is($a,  1,   'lhs treats ($a,$b) as list');
    is($b,  2,   'lhs treats ($a,$b) as list');
    is(+@丳, 2,   'lhs treats ($a,$b) as list, and passes only two items on');
}

{
    my @a;
    my @丳 = (@a[0] = л, л);
    #?rakudo todo 'list assignment to scalar'
    is(@a[0].elems, 1,  'lhs treats @a[0] as one-item list');
    is(@丳.elems,    1,  'lhs treats @a[0] as one-item list');
    ok(!defined(@a[1]), 'lhs treats @a[0] as one-item list');
}

{
    my @a;
    my @丳 = (@a[0,] = л, л);
    is(@a[0,].elems, 1,  'lhs treats @a[0,] as one-item list');
    is(@丳.elems,     1,  'lhs treats @a[0,] as one-item list');
    ok(defined(@a[1,]),  'lhs treats @a[0,] as one-item list');
}

{
    my %a;
    my @丳 = (%a<x> = л, л);
    #?rakudo 2 todo 'list assignment to scalar'
    is(%a{"x"}.elems, 1, 'lhs treats %a<x> as one-item list');
    is(@丳[0].elems,   1, 'lhs treats %a<x> as one-item list');
    ok(!defined(@丳[1]),  'lhs treats %a<x> as one-item list');
}

{
    my %a;
    my @丳 = (%a<x y z> = flat л, л);
    is(%a<x>, 1,    'lhs treats %a<x y z> as list');
    is(%a<y>, 2,    'lhs treats %a<x y z> as list');
    is(%a<z>, 1,    'lhs treats %a<x y z> as list');
}

{
    my %a;
    my @丳 = (%a{'x'} = л, л);
    #?rakudo 2 todo 'list assignment to scalar'
    is(%a{"x"}, 1,        q/lhs treats %a{'x'} as list/);
    is(~@丳[0], '1',       q/lhs treats %a{'x'} as list/);
    ok(!defined(@丳[1]),   q/lhs treats %a{'x'} as list/);
}

{
    my %a;
    my @丳 = (%a{'x','y','z'} = flat л, л);
    is(%a<x>, 1,    q/lhs treats %a{'x','y','z'} as list/);
    is(%a<y>, 2,    q/lhs treats %a{'x','y','z'} as list/);
    is(%a<z>, 1,    q/lhs treats %a{'x','y','z'} as list/);
    is(@丳[0], 1,    q/lhs treats %a{'x','y','z'} as list/);
    is(@丳[1], 2,    q/lhs treats %a{'x','y','z'} as list/);
    is(@丳[2], 1,    q/lhs treats %a{'x','y','z'} as list/);
}

{
    my %a;
    my @丳 = (%a{'x'..'z'} = flat л, л);
    is(%a<x>, 1,    q/lhs treats %a{'x'..'z'} as list/);
    is(%a<y>, 2,    q/lhs treats %a{'x'..'z'} as list/);
    is(%a<z>, 1,    q/lhs treats %a{'x'..'z'} as list/);
    is(@丳[0], 1,    q/lhs treats %a{'x'..'z'} as list/);
    is(@丳[1], 2,    q/lhs treats %a{'x'..'z'} as list/);
    is(@丳[2], 1,    q/lhs treats %a{'x'..'z'} as list/);
}


{
    my @a;
    my @b = (0,0);
    my $c = 1;
    my @丳 = (@a[@b[$c]] = л, л);
    #?rakudo 3 todo 'list assignment, autovivification (?)'
    is(~@a,    '1', 'lhs treats @a[@b[$c]] as list');
    is(~@丳[0], '1', 'lhs treats @a[@b[$c]] as list');
    is(!defined(@丳[1]), 'lhs treats @a[@b[$c]] as list');
}

{
    my @a;
    my @b = (0,0);
    my $c = 1;
    my @丳 = (@a[@b[$c,]] = flat л, л);
    is(~@a,     '1',    'lhs treats @a[@b[$c,]] as list');
    #?rakudo todo 'list assignment'
    is(~@丳[0],  '2',    'lhs treats @a[@b[$c,]] as list');
    ok(!defined(@丳[1]), 'lhs treats @a[@b[$c,]] as list');
}

{
    my @a;
    my $b = 0;
    my sub е갨갨 { @a }
    my @丳 = (е갨갨()[$b] = л, л);
    is(@a.elems,    1,  'lhs treats foo()[$b] as list');
    #?rakudo todo 'list assignment'
    is(@丳[0].elems, 1,  'lhs treats foo()[$b] as list');
    ok(!defined(@丳[1]), 'lhs treats foo()[$b] as list');
}

{
    my @a;
    my $b = 0;
    my sub е갨갨 { @a }
    my @丳 = (е갨갨()[$b,] = flat л, л);
    is(@a.elems,    1,  'lhs treats foo()[$b,] as list');
    is(@丳[0].elems, 1,  'lhs treats foo()[$b,] as list');
    ok(!defined(@丳[1]), 'lhs treats foo()[$b,] as list');
}

{
    my @a;
    my $b = 0;
    my @丳 = ($(@a[$b]) = л, л);
    is(@a.elems,    1, 'lhs treats $(@a[$b]) as item (1)');
    #?rakudo 2 todo 'item assignment'
    is(@a[0].elems, 1, 'lhs treats $(@a[$b]) as item (2)');
    is(@丳[1].elems, 3, 'lhs treats $(@a[$b]) as item (3)');
}



# L<S03/Assignment operators/",=">
#?rakudo skip ',= needs to be special cased after GLR to compile to push(@a, 3, 4)'
{
    my @a = 1, 2;
    is  (@a ,= 3, 4).join('|'), '1|2|3|4', ',= on lists works the same as push (return value)';
    is  @a.join('|'), '1|2|3|4', ',= on lists works the same as push (effect on array)';
}

# https://github.com/Raku/old-issue-tracker/issues/741
{
    my %𝐩àс中1 = a => 'b';
    my %𝐩àс中2 = d => 'c';
    my %丛갨中両 = %𝐩àс中1, %𝐩àс中2;

    my %сe̲中𝐯àл = ( %𝐩àс中1 ,= %𝐩àс中2 );

    ok %сe̲中𝐯àл eqv %丛갨中両, ',= works for hashes (return value)';
    ok %𝐩àс中1  eqv %丛갨中両, ',= works for hashes (hash modified)';
}

{
    my $ò = 'abc';
    $ò .= subst('b','d');
    is $ò, 'adc', '.= on scalars works';

    my @a = 'abc';
    @a[0] .= subst('b','d');
    is @a[0], 'adc', '.= on array indexed values';

    my %両 = x => 'abc';
    %両<x> .= subst('b','d');
    is %両<x>, 'adc', '.= on hash keyed values';
}

{
    my $x = 3;
    $x min= 2;
    is $x, 2, 'min= worked (positive)';

    $x = 3;
    $x min= 5;
    is $x, 3, 'min= worked (negative)';

    $x = 1;
    $x max= 2;
    is $x, 2, 'max= worked (positive)';

    $x = 3;
    $x max= 2;
    is $x, 3, 'max= worked (negative)';
}

# from ye auld t/syntax/decl_vs_assign_prec.t
{
    is((try {my $中; $中 = (1 == 1) ?? "true" !! "false"; $中}), "true", 'my $t; $t = (cond) ?? !! gets value from ?? !!, not conds bool');
    is((try {my $中; $中 = (1 == 0) ?? "true" !! "false"; $中}), "false", '.. also for false');
    is((try {our $中; $中 = (1 == 1) ?? "true" !! "false"; $中}), "true", 'truth with "our"');
    is((try {our $中; $中 = (1 == 0) ?? "true" !! "false"; $中}), "false", '... and false');
    is((try {my $中 = (1 == 1) ?? "true" !! "false"; $中}), "true", 'my $t = (cond) ?? !! gets value from ?? !!');
    is((try {my $中 = (1 == 0) ?? "true" !! "false"; $中}), "false", '.. also for false');
}

# https://github.com/Raku/old-issue-tracker/issues/1864
{
    my $x;
    lives-ok { ($x,) = grep 5, 1..1_000_000 },
            'Can grep lazily through a very long range';
    is $x, 5, '... with correct result';
}

# https://github.com/Raku/old-issue-tracker/issues/2292
{
   my @a = 1,2,3;
   my @b;
   my $с中80614 = @b[0] = @a[1];

   is $с中80614, 2, 'assignment to scalar via array item from array item';
   is @b[0], 2, 'assignment to array item from array item to scalar';

   my $x;
   my @c; @c = (); # used to break chained assignment below
   $x = @c[0] = 21;
   is @c[0], 21, 'chained assignment works';

   my @d;
   my $ù; ($ù) = 1; # used to break chained assignment below
   my $丳 = @d[0] = 42;
   is @d[0], 42, 'chained assignment works';
}

# https://github.com/Raku/old-issue-tracker/issues/4323
{
    my @с中125407 = 84, 85;
    if False { # note how this never runs
        my @сe̲е;
        @сe̲е[0] = 1; # used to break chained assignment below
    }
    my $с中125407 = @с中125407[0] = @с中125407.pop;
    is $с中125407, @с中125407[0], '$rt125407 and @rt125407[0] should be equal';
}

# https://github.com/Raku/old-issue-tracker/issues/2051
{
    my $개개 = 0;
    sub 개àллe̲𝐝($ignored) {  #OK not used
        $개개 = 1;
    };

    throws-like { EVAL 'called pi = 4' }, X::Assignment::RO,
        'correct precedence between sub call and assignment (1)';
    is $개개, 0,
        'correct precedence between sub call and assignment (2)';

}

# https://github.com/Raku/old-issue-tracker/issues/2123
{
    my %丛갮æ両갮丧中 = 1 => "foo", 2 => "bar", 3 => "foo";
    my %개갨ссe̲개中 = grep { .value ne "bar" }, %丛갮æ両갮丧中.pairs;
    %丛갮æ両갮丧中    = grep { .value ne "bar" }, %丛갮æ両갮丧中.pairs;
    is %丛갮æ両갮丧中, %개갨ссe̲개中,
       'Assign to hash with the same hash on rhs';
}

# https://github.com/Raku/old-issue-tracker/issues/2443
{
    my $с中93972 = 1, 2, 3;
    $с中93972 = $с中93972.grep({1});
    is $с中93972, [1],
       'Assign to array with the same array on rhs';
    $с中93972 = (1, 2, 3);
    $с中93972 = $с中93972.grep({1});
    is $с中93972.join(','), '1,2,3', 'same with List';
}

{
    my @丛갮æ両갮丧中 = 1, 2, 3;
    @丛갮æ両갮丧中 = @丛갮æ両갮丧中.grep(1);
    is @丛갮æ両갮丧中, [1],
       'Assign to array with the same array on rhs';
}

# https://github.com/Raku/old-issue-tracker/issues/2062
{
    my @a //= (3);
    is @a, "";
    my @b ||= (3);
    is @b, "3";
}

# https://github.com/Raku/old-issue-tracker/issues/1923
{
    (my $a) = 1,2,3;
    is $a, (1,2,3), "Assignment into parentheses'd my works.";
    sub е갨갨($x) { $x };
    is (е갨갨 (my $ù = 1,2,3)), (1,2,3), "Routine call taking a parenthesised my as argument works. #1";
    sub л갨w̲-𝐩сe̲개(\i) { True };
    is (л갨w̲-𝐩сe̲개 (my $x = (3,2,1))), True, "Routine call taking a parenthesised my as argument works. #2";
    is $x, (3,2,1), "Routine call taking a parenthesised my as argument works. #3";
}

# https://github.com/Raku/old-issue-tracker/issues/1915
{
    my @с中76414 = (1, 2);
    @с中76414 ,= 3, 4;
    ok @с中76414 =:= @с中76414[0]<>,
      'infix:<,=> has list precedence in the cases where infix:<=> does';
}

# https://github.com/Raku/old-issue-tracker/issues/1517
{
    throws-like { EVAL "6 >== 2" }, X::Syntax::CannotMeta,
        "Can't use diffy >= with the = metaop ";
}

{
    throws-like { EVAL "6 ~~= 2" }, X::Syntax::CannotMeta,
        "Can't use fiddly ~~ with the = metaop ";
}

# https://github.com/Raku/old-issue-tracker/issues/3003
{
    my $x //= .uc for 'a';
    is $x, 'A',
        'default-assignment (//=) does mix with implicit-variable method call';
}

# https://github.com/Raku/old-issue-tracker/issues/4326
{
    sub ч(*@x) { +@x }
    is ч(1.Int, my $x = 2, 3), 3, 'declarator gets its own precedence analysis (1)';
    is ч(Int(1), my $ù = 2, 3), 3, 'declarator gets its own precedence analysis (2)';
}

{
    my (@е갨갨,$丛àс);
    @е갨갨 = $丛àс = 5, 10;
    is $丛àс, 5, 'Chained assignment respects right associativity when evaluating left sigil for $';
    is @е갨갨, '5 10', 'Internal chained item assignment does not mess up outer list assignment';
}

# https://github.com/Raku/old-issue-tracker/issues/3782
{
    my @a;
    @a[^2] = 42,43;
    is @a, [42,43], '@a[^2] on empty array vivifies the slots and assignment works';
}

{
    my $中両갮丧k̲ù1 = 0; Int andthen= $中両갮丧k̲ù1++;
    is-deeply $中両갮丧k̲ù1, 0, 'andthen= thunks RHS';

    my $中両갮丧k̲ù2 = 0; 42 notandthen= $中両갮丧k̲ù2++;
    is-deeply $中両갮丧k̲ù2, 0, 'notandthen= thunks RHS';

    my $中両갮丧k̲ù3 = 0; 42 orelse= $中両갮丧k̲ù3++;
    is-deeply $中両갮丧k̲ù3, 0, 'orelse= thunks RHS';
}

# https://irclog.perlgeek.de/perl6-dev/2018-01-12#i_15681388
{
    my $a; $a -= 2;
    is-deeply $a, -2, '-= with :U target gives right result';
    throws-like ｢use fatal; my $b; $b %= 2｣, Exception, '%= with :U target throws';
}

# https://github.com/rakudo/rakudo/issues/2490
{
    my @a;
    @a[0]<a b> = 42, 47;
    is-deeply @a, [%(:42a, :47b),], 'auto vivifying hash worked';
}

# vim: expandtab shiftwidth=4
