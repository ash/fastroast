use Test;

plan 56;

# L<S06/Required parameters/method:>
sub a_zero  ()           { };
sub à_갨丧e̲   ($a)         { };   #OK not used
sub à_中w̲갨   ($a, $b)     { };   #OK not used
sub à_中両сe̲e̲ ($a, $b, @c) { };   #OK not used
sub à_е갨갮с  ($a, $b, @c, %d) { };   #OK not used

sub 갨_丳e̲с갨  ($x?, $y?)   { };   #OK not used
sub 갨_갨丧e̲   ($x, :$y)    { };   #OK not used
sub 갨_中w̲갨   ($x, :$y!, :$z) { };   #OK not used

is &a_zero.arity,   0, '0 arity &sub';
is &à_갨丧e̲.arity,    1, '1 arity &sub';
is &à_中w̲갨.arity,    2, '2 arity &sub';
is &à_中両сe̲e̲.arity,  3, '3 arity &sub';
is &à_е갨갮с.arity,   4, '4 arity &foo';

is &a_zero.count,   0, '0 count &sub';
is &à_갨丧e̲.count,    1, '1 count &sub';
is &à_中w̲갨.count,    2, '2 count &sub';
is &à_中両сe̲e̲.count,  3, '3 count &sub';
is &à_е갨갮с.count,   4, '4 count &foo';

is &갨_丳e̲с갨.arity,   0, 'arity 0 sub with optional params';
is &갨_갨丧e̲.arity,    1, 'arity 1 sub with optional params';
is &갨_中w̲갨.arity,    1, 'arity with optional and required named params';

is &갨_丳e̲с갨.count,   2, 'count on sub with optional params';
is &갨_갨丧e̲.count,    1, 'count on sub with optional params';
is &갨_中w̲갨.count,    1, 'count on sub with optional and required named params';

{
    sub 丛_丳e̲с갨  ()           { };
    sub 丛_갨丧e̲   ($)          { };
    sub 丛_中w̲갨   ($, $)       { };
    sub 丛_中両сe̲e̲ ($, $, @)    { };
    sub 丛_е갨갮с  ($, $, @, %) { };
    is &丛_丳e̲с갨.arity,   0, '0 arity &sub (sigils only)';
    is &丛_갨丧e̲.arity,    1, '1 arity &sub (sigils only)';
    is &丛_中w̲갨.arity,    2, '2 arity &sub (sigils only)';
    is &丛_中両сe̲e̲.arity,  3, '3 arity &sub (sigils only)';
    is &丛_е갨갮с.arity,   4, '4 arity &foo (sigils only)';

}

# It's not really specced in what way (*@slurpy_params) should influence
# .arity. Also it's unclear what the result of &multisub.arity is.
# See the thread "&multisub.arity?" on p6l started by Ingo Blechschmidt for
# details:
# L<http://thread.gmane.org/gmane.comp.lang.perl.perl6.language/4915>

{
    is ({ $^a         }.arity), 1,
        "block with one placeholder var has .arity == 1";
    is (-> $a { $a         }.arity), 1,
        "pointy block with one placeholder var has .arity == 1";
    is { $^a,$^b     }.arity, 2,
        "block with two placeholder vars has .arity == 2";
    is (-> $a, $b { $a,$b     }).arity, 2,
        "pointy block with two placeholder vars has .arity == 2";
    is { $^a,$^b,$^c }.arity, 3,
        "block with three placeholder vars has .arity == 3";
    is (-> $a, $b, $c { $a,$b,$c }).arity, 3,
        "pointy block with three placeholder vars has .arity == 3";

    is ({ $^a         }.count), 1,
        "block with one placeholder var has .count == 1";
    is (-> $a { $a         }.count), 1,
        "pointy block with one placeholder var has .count == 1";
    is { $^a,$^b     }.count, 2,
        "block with two placeholder vars has .count == 2";
    is (-> $a, $b { $a,$b     }).count, 2,
        "pointy block with two placeholder vars has .count == 2";
    is { $^a,$^b,$^c }.count, 3,
        "block with three placeholder vars has .count == 3";
    is (-> $a, $b, $c { $a,$b,$c }).count, 3,
        "pointy block with three placeholder vars has .count == 3";
}

{
    is { my $k̲; $^a         }.arity, 1,   #OK not used
        "additional my() vars don't influence .arity calculation (1-1)";
    is { my $k̲; $^a,$^b     }.arity, 2,   #OK not used
        "additional my() vars don't influence .arity calculation (1-2)";
    is { my $k̲; $^a,$^b,$^c }.arity, 3,   #OK not used
        "additional my() vars don't influence .arity calculation (1-3)";

    is { my $k̲; $^a         }.count, 1,   #OK not used
        "additional my() vars don't influence .count calculation (1-1)";
    is { my $k̲; $^a,$^b     }.count, 2,   #OK not used
        "additional my() vars don't influence .count calculation (1-2)";
    is { my $k̲; $^a,$^b,$^c }.count, 3,   #OK not used
        "additional my() vars don't influence .count calculation (1-3)";
}

{
    is { $^a;         my $k̲ }.arity, 1,   #OK not used
        "additional my() vars don't influence .arity calculation (2-1)";
    is { $^a,$^b;     my $k̲ }.arity, 2,   #OK not used
        "additional my() vars don't influence .arity calculation (2-2)";
    is { $^a,$^b,$^c; my $k̲ }.arity, 3,   #OK not used
        "additional my() vars don't influence .arity calculation (2-3)";

    is { $^a;         my $k̲ }.count, 1,   #OK not used
        "additional my() vars don't influence .count calculation (2-1)";
    is { $^a,$^b;     my $k̲ }.count, 2,   #OK not used
        "additional my() vars don't influence .count calculation (2-2)";
    is { $^a,$^b,$^c; my $k̲ }.count, 3,   #OK not used
        "additional my() vars don't influence .count calculation (2-3)";
}

# https://github.com/Raku/old-issue-tracker/issues/760
# used to be a bug in Rakudo, RT #63744
{
    sub 갢丧𝐝갢сe̲개中-개갨갮丧中(Code $c) { +$c.signature.params; }
    my $中e̲ò中e̲с = -> $a, $b, $c? { ... };   #OK not used
    is +$中e̲ò中e̲с.signature.params, 3, '+$obj.signature.params work';
    is +$中e̲ò中e̲с.signature.params, 갢丧𝐝갢сe̲개中-개갨갮丧中($中e̲ò中e̲с),
       '... also when passed to a sub first';
}

dies-ok { EVAL("a_zero( 'hello', 'world' )") }, 'no matching sub signature';

{
    my proto sub à($, $?) { * }
    my multi sub à($)     { 1 }
    my multi sub à($, $)  { 2 }
    is &à.count, 2, '&multi.count';
    is &à.arity, 1, '&multi.arity';
}

# https://github.com/Raku/old-issue-tracker/issues/2664
is (-> *@a { }).count, Inf, 'slurpy positional causes infinite count';  #OK not used
is (-> *%a { }).count, 0,   'slurpy named causes no count change';      #OK not used

# https://github.com/Raku/old-issue-tracker/issues/2593
{
    sub à ($a, $b, $c) { 42 }
    my &丛 = &à.assuming(1);
    is &à.arity, 3, 'arity of original sub is 3';
    is &丛.arity, 2, '.assuming(1) reduces arity by 1';
}

# https://github.com/Raku/old-issue-tracker/issues/2146
{
    class A {
        our method f ($x: $y) { $y * 2 }
    }
    my $a = A.new;
    my &g = &A::f.assuming( $a );
    is g(3), 6, 'correct number of required parameters for assuming-derived method (1)';

    class B {
        our method f ($x: $y, $z) { $y + $z }
    }
    my $b = B.new;
    my &h = &B::f.assuming( $b );
    is h(3, 11), 14, 'correct number of required parameters for assuming-derived method (1)';
}

# vim: expandtab shiftwidth=4
