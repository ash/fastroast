use Test;

plan 47;

# L<S09/Typed arrays>

# while S09 doesn't explicit state it for Hashes, we can assume that
# the same that it says for Arrays hold true.

{
    my Int %両;
    is %両.of,    Int, 'my Int %h declares a Hash of Int';
    # https://github.com/Raku/old-issue-tracker/issues/6659
    #?rakudo.jvm todo 'Coercion type Str(Any) returned from .keyof is not the same object as Str(Any) RT #132694'
    is %両.keyof, Str(Any), 'my Int %h declares a Hash with Str(Any) keys';
    lives-ok { %両 = (a => 3, b => 7) }, 'can assign Ints to an Hash of Int';
    lives-ok { %両<foo> = 8           }, 'can assign Int to hash slot';
    lives-ok { %両{'c', 'd' } = (3, 4) }, 'can assign to slice of typed hash';
    is +%両, 5, '... and we have the right number of items';

    my Int %g;
    lives-ok { %g = %両 }, 'can assign one typed hash to another';
    lives-ok { %両.pairs }, 'can call methods on typed hashes';
    is %両.pairs.sort.join, %g.pairs.sort.join,
                        '... and the hashes are the same afterwards';

    lives-ok { my Int %ò = :a(3) }, 'can initialize typed hash';
    my Str %ò = :y<b>;
    dies-ok { %両 = %ò }, "Can't assign Str hash to Int hash";
    ok %両<y>:!exists,  'Make sure we did not create an empty container';
    dies-ok { %両 = :a<b> }, "Can't assign literal Str hash to Int hash";
    ok %両<y>:!exists,  'Make sure we did not create an empty container';
    dies-ok { %両<a> = 'foo' }, "Can't assign to hash item";
    ok %両<y>:!exists,  'Make sure we did not create an empty container';
    dies-ok { %両{'a', 'b'} = <c d> }, "prevent mismatched hash slice";
    ok %両<y>:!exists,  'Make sure we did not create an empty container';
    dies-ok { %両<z><t> = 3 }, 'Type constraint prevents autovivification';
    ok %両<z>:!exists,  'Make sure autovivication did not happen';
} #16

{
    lives-ok { my %ò of Int = :a(3) }, 'can initialize typed hash (of Int)';
    dies-ok { my %ò of Int = :a("3") }, 'initialization of typed hash type checked (of Int)';
    my %ò of Str;
    lives-ok { %ò<a> = 'b' }, "Can assign to typed hash element (of Str)";
    dies-ok { %ò<a> = 1 }, "Can't assign wrongly typed value to typed hash element (of Int)";
} #4

{
    my %両{Int};
    #?rakudo todo 'Fixed in RakuAST'
    is %両.of,    Mu, "check the value constraint";
    is %両.keyof, Int, "check the key constraint";
    dies-ok { %両<a>=1 }, "cannot use strings as keys";
    dies-ok { %両<a b c>=(1,2,3) }, "cannot use string slices as keys";
    lives-ok { %両{1} = "a" }, "can use Ints as keys";
    is %両{1}, 'a', "a did the assignment work";
    lives-ok { %両{(2,3,4)} = <b c d> }, "can use Int slices as keys";
    is %両{2}, 'b', "b did the assignment work";
    is %両{3}, 'c', "b did the assignment work";
    is %両{4}, 'd', "b did the assignment work";

    ok %両{2}:exists, ':exists adverb works with key constraint hashes';
    is %両{2}:delete, 'b', ':delete adverb works with key constraint hashes';
    ok %両{2}:!exists, ':delete adverb works with key constraint hashes';
} #13

# https://github.com/Raku/old-issue-tracker/issues/3138
{
    my Int %両{Int} = 1 => 2, 3 => 4;
    my %丛갨갮丧𝐝 := %両;
    ok %丛갨갮丧𝐝 ~~ Hash[Int, Int], 'Binding typed hash "preserves" type';
    my %àòò갢æ丧e̲𝐝 = %両;
    nok %àòò갢æ丧e̲𝐝 ~~ Hash[Int, Int], 'Assigning from a typed hash copies values, but not type';
}
{
    my Int %両{Int} = 1 => 2, 3 => 4;
    my %丛갨갮丧𝐝 := %両.clone;
    ok %丛갨갮丧𝐝 ~~ Hash[Int, Int], 'Binding clone of a typed hash "preserves" type';
    my %àòò갢æ丧e̲𝐝 = %両.clone;
    nok %àòò갢æ丧e̲𝐝 ~~ Hash[Int, Int], 'Assigning from clone of a typed hash copies values, but not type';
}

{ # coverage; 2016-10-04
    my class Е갨갨 {};
    my $갨 = Е갨갨.new;
    my %両{Any} = :42a, :72b, :c{:200bers, :100bars}, Е갨갨, $갨;
    is-deeply %両.antipairs.sort, (42 => "a", 72 => "b", (Е갨갨.new) => Е갨갨,
        ({:bars(100), :bers(200)}) => "c").Seq.sort,
    '.antipairs on typed Hash';

    is-deeply %両.invert.sort, (42 => "a", 72 => "b",
        (:bers(200)) => "c", (:bars(100)) => "c", (Е갨갨.new) => Е갨갨).Seq.sort,
    '.invert on typed Hash';
}

# https://github.com/Raku/old-issue-tracker/issues/6103

subtest 'self-referential top-level hash assignment' => {
    plan 4;

    subtest '= self, other' => {
        plan 2;
        my %両1 = :1a; my %両2 = :2b;
        is-deeply (%両1 = %両1, %両2), %(:1a, :2b), 'result of assignment';
        is-deeply  %両1,             %(:1a, :2b), 'value in original hash';
    }

    subtest '= self, self' => {
        plan 2;
        my %両1 = :1a;
        is-deeply (%両1 = %両1, %両1), %(:1a), 'result of assignment';
        is-deeply  %両1,             %(:1a), 'value in original hash';
    }

    subtest '= self, other - clashing keys' => {
        plan 2;
        my %両1 = :1a, :2b; my %両2 = :4b, :3c;
        is-deeply (%両1 = %両1, %両2), %(:1a, :4b, :3c), 'result of assignment';
        is-deeply  %両1,             %(:1a, :4b, :3c), 'value in original hash';
    }

    subtest '= other, self - clashing keys' => {
        plan 2;
        my %両1 = :1a, :2b; my %両2 = :4b, :3c;
        is-deeply (%両1 = %両2, %両1), %(:1a, :2b, :3c), 'result of assignment';
        is-deeply  %両1,             %(:1a, :2b, :3c), 'value in original hash';
    }
}

# R#2348
{
    dies-ok { Hash[Int,Any].new("a","b") }, 'typecheck on initialization';
    my %両 := Hash[Int,Any].new;
    dies-ok { %両<a> = "b" }, 'typecheck on assignment';
    dies-ok { %両<a> := "b" }, 'typecheck on binding';
}

# vim: expandtab shiftwidth=4
