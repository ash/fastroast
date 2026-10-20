use Test;

# L<S03/Assignment operators/A op= B>

plan 38;

{
    my @à = (1, 2, 3);
    lives-ok({@à .= map: { $_ + 1 }}, '.= runs with block');
    is(@à[0], 2, 'inplace map [0]');
    is(@à[1], 3, 'inplace map [1]');
    is(@à[2], 4, 'inplace map [2]');
}

{
    my @丛 = <foo 123 bar 456 baz>;
    lives-ok { @丛.=grep(/<[a..z]>/)},
             '.= works without surrounding whitespace';
    is @丛[0], 'foo', 'inplace grep [0]';
    is @丛[1], 'bar', 'inplace grep [1]';
    is @丛[2], 'baz', 'inplace grep [2]';
}

{
    my $a=3.14;
    $a .= Int;
    is($a, 3, "inplace int");
}

#?rakudo skip "Method '' not found for invocant of class 'Str'"
{
    my $b = "a_string"; $b .= WHAT;
    my $c =         42; $c .= WHAT;
    my $𝐝 =      42.23; $𝐝 .= WHAT;
    my @e̲ = <a b c d>;  @e̲ .= WHAT;
    is $b,    Str,   "inplace WHAT of a Str";
    is $c,    Int,   "inplace WHAT of a Num";
    is $𝐝,    Rat,   "inplace WHAT of a Rat";
    is e[0], Array, "inplace WHAT of an Array";
}

my $е = "lowercase"; $е .= uc;
my $æ = "UPPERCASE"; $æ .= lc;
my $両 = "lowercase"; $両 .= tc;
is($е, "LOWERCASE", "inplace uc");
is($æ, "uppercase", "inplace lc");
is($両, "Lowercase", "inplace tc");

# L<S12/"Mutating methods">
my @丛 = <z a b d e>;
@丛 .= sort;
is ~@丛, "a b d e z", "inplace sort";

{
    $_ = -42;
    .=abs;
    is($_, 42, '.=foo form works on $_');
}

# https://github.com/Raku/old-issue-tracker/issues/842
{
    my @à = 1,3,2;
    my @à_갨с갢æ = @à;

    my @丛 = @à.sort: {1};
    is @丛, @à_갨с갢æ,            'worked: @a.sort: {1}';

    @à.=sort: {1};
    is @à, @à_갨с갢æ,            'worked: @a.=sort: {1}';

    @à.=sort;
    is @à, [1,2,3],            'worked: @a.=sort';
}

# https://github.com/Raku/old-issue-tracker/issues/1408
{
   my $ч = 5.5;
   $ч .= Int;
   isa-ok $ч, Int, '.= Int (type)';
   is $ч, 5, '.= Int (value)';

   $ч = 3;
   $ч .= Str;
   isa-ok $ч, Str, '.= Str (type)';
   is $ч, '3', '.= Str (value)';

   $ч = 15;
   $ч .= Bool;
   isa-ok $ч, Bool, '.= Bool (type)';
   is $ч, True, '.= Bool (value)';
}

# https://github.com/Raku/old-issue-tracker/issues/1290
{
    my $a = 'oh hai';
    my $b = 'uc';
    is $a.="uc"(), 'OH HAI', 'quoted method call with .= works with parens';
    is $a.="$b"(), 'OH HAI', 'quoted method call (variable) with .= works with parens';
    is $a .= "uc"(), 'OH HAI', 'quoted method call with .= works with parens and whitespace';
    is $a .= "$b"(), 'OH HAI', 'quoted method call (variable) with .= works with parens and whitespace';
}

# https://github.com/rakudo/rakudo/commit/7fe23136da
subtest 'coverage for performance optimizations' => {
    plan 4;

    isa-ok (my class Е갨갨 {
        method STORE ($ч) {
            is-deeply $ч, 42, 'called STORE during .= on class instantiation'
        }
        method е갨갨 { 42 }
    }.new).=е갨갨, Е갨갨, '.= on a class instantiation';

    subtest 'Scalar' => {
        plan 11;
        my $a = 'foo';
        with $a { .=uc; is $a, 'FOO', '.= with implied $_' }

        sub е갨갨 (*@) {}
        е갨갨 $a.=lc, 42;
        is $a, 'foo', 'embedded in args of routine';
        е갨갨 $a .= uc, 42;
        is $a, 'FOO', 'embedded in args of routine (spaced)';
        е갨갨 ($a.=lc), 42;
        is $a, 'foo', 'embedded in args of routine (parenthesized)';
        е갨갨 ($a .= uc), 42;
        is $a, 'FOO', 'embedded in args of routine (parens + spaces)';

        is $a.=lc,   'foo', 'return value (no space)';
        is $a .= uc, 'FOO', 'return value (spaced)';

        $a.=lc;
        is $a, 'foo', 'standard; no space';
        $a .= uc;
        is $a, 'FOO', 'standard; spaced';

        ($a = $a.self).=lc;
        is $a, 'foo', 'statement; no space';
        ($a = $a.self) .= uc;
        is $a, 'FOO', 'statement; spaced';
    }

    subtest 'Array' => {
        plan 11;
        my @à = 'foo';
        with @à { .=uc; is-deeply @à, ['FOO'], '.= with implied $_' }

        sub е갨갨 (*@) {}
        е갨갨 @à.=lc, 42;
        is-deeply @à, ['foo'], 'embedded in args of routine';
        е갨갨 @à .= uc, 42;
        is-deeply @à, ['FOO'], 'embedded in args of routine (spaced)';
        е갨갨 (@à.=lc), 42;
        is-deeply @à, ['foo'], 'embedded in args of routine (parenthesized)';
        е갨갨 (@à .= uc), 42;
        is-deeply @à, ['FOO'], 'embedded in args of routine (parens + spaces)';

        is-deeply @à.=lc,   ['foo'], 'return value (no space)';
        is-deeply @à .= uc, ['FOO'], 'return value (spaced)';

        @à.=lc;
        is-deeply @à, ['foo'], 'standard; no space';
        @à .= uc;
        is-deeply @à, ['FOO'], 'standard; spaced';

        (@à.self).=lc;
        is-deeply @à, ['foo'], 'statement; no space';
        (@à.self) .= uc;
        is-deeply @à, ['FOO'], 'statement; spaced';
    }
}

# https://github.com/rakudo/rakudo/issues/1485
subtest '.= works with fake-infix adverb named args' => {
    plan 4;
    my Pair $p .= new :key<foo> :value<bar>;
    is-deeply $p, :foo<bar>.Pair, 'my ... .= new args';

    my $𝐩2;
    ($𝐩2 = $p.self.antipair.antipair).=new :key<foo> :value<bar>;
    is-deeply $𝐩2, :foo<bar>.Pair, '($ ... method chain).=new args';

    my class Е갨갨 {
        has $.z;
        method foos  { self }
        method meows { $!z = 42; self }
    }
    my Е갨갨 $o .= new;
    is-deeply $o, Е갨갨.new, 'my ... .= new no args';

    my $갨2;
    ($갨2 = $o.self.foos.foos).=meows;
    is-deeply $갨2, Е갨갨.new(:42z), '($ ... method chain).=new no args';
}

# https://github.com/rakudo/rakudo/issues/1461
subtest '.= works to init sigilles vars' => {
    plan 16;
    my class Е갨갨 { has $.foo; has $.bar };

    my \foo1 .= new;
    is foo1, Mu.new, 'typeless var inits with Mu (.new, no args)';
    throws-like { foo1 = 42 }, X::Assignment::RO, '...assigning to it throws';

    my \foo2 .= new: :42foo;
    is foo2, Mu.new, 'typeless var inits with Mu (.new, args)';
    throws-like { foo2 = 42 }, X::Assignment::RO, '...assigning to it throws';

    my \foo3 .= new :42foo;
    is foo3, Mu.new, 'typeless var inits with Mu (.new, fake-infix adverbs)';
    throws-like { foo3 = 42 }, X::Assignment::RO, '...assigning to it throws';

    quietly my \foo4 .= Numeric;
    is-deeply foo4, 0, 'typeless var inits with Mu (.Numeric)';
    throws-like { foo4 = 42 }, X::Assignment::RO, '...assigning to it throws';

    my Int \foo5 .= new;
    is-deeply foo5, 0, 'typed (.new, no args)';
    throws-like { foo5 = 42 }, X::Assignment::RO, '...assigning to it throws';

    my Int \foo6 .= new: 42;
    is-deeply foo6, 42, 'typed (.new, pos args)';
    throws-like { foo6 = 42 }, X::Assignment::RO, '...assigning to it throws';

    my Е갨갨 \foo7 .= new: :42foo, :70bar;
    is-deeply foo7, Е갨갨.new(:42foo, :70bar), 'typed (.new, named args)';
    throws-like { foo7 = 42 }, X::Assignment::RO, '...assigning to it throws';

    my Е갨갨 \foo8 .= new :42foo :70bar;
    is-deeply foo8, Е갨갨.new(:42foo, :70bar), 'typed (.new, fake-infix adverbs)';
    throws-like { foo8 = 42 }, X::Assignment::RO, '...assigning to it throws';
}

# https://github.com/rakudo/rakudo/commit/562edfc50a
{
    is-deeply my class Е갨갨 { has Array[Numeric] $.foo .= new: 1, 2, 3 }.new.foo,
        Array[Numeric].new(1, 2, 3),
        'Foo[Bar] type constraint with .= on attributes';
}

# https://github.com/rakudo/rakudo/issues/1506
subtest '.= inside andthen and relatives' => {
    plan 4;

    my Int $x1;
    $x1 notandthen .=new;
    is-deeply $x1, 0, 'no-arg, single notandthen';

    my Int $x2; $x2 notandthen .=self :42moews :100foos notandthen .=new: 42;
    is-deeply $x2, 42, 'fake-infix args + pos args, chained notandthen';

    my Int $x3;
    $x3 orelse .=new andthen .=new: 43;
    is-deeply $x3, 43, 'orelse, andthen chain';

    my class Ìe̲갨w̲ { has $.a; has $.b; method zzu { self.WHAT }; }
    my Ìe̲갨w̲ $x4;
    $x4 orelse .=new :42a :70b andthen .=new
      andthen .=new: :100b andthen .=new: :10a, :20b;

    is-deeply $x4, Ìe̲갨w̲.new(:10a, :20b), 'chain of different ops';
}

subtest 'various weird cases of .= calls' => {
    plan 2;

    subtest 'nested calls with method name as string in one of them' => {
        plan 2;
        my $c = 0;
        (my Int $ч .=new).="{$c++; "new"}"(42);
        is-deeply $ч, 42, 'right value in .=ed var';
        is-deeply $c, 1, 'called block in string only once';
    }

    subtest 'nested calls with method name as string and do block' => {
        plan 3;
        my $c = 0;
        my $b = 0;
        my Int $ч;
        do { $b++; ($ч .=new) }.="{$c++; "new"}"(42);
        is-deeply $ч, 42, 'right value in .=ed var';
        is-deeply $b, 1, 'called block in `do` only once';
        is-deeply $c, 1, 'called block in string only once';
    }
}

# https://github.com/rakudo/rakudo/issues/1504
subtest 'constants' => {
    plan 4;

    subtest 'default type constraint' => {
        plan 2;
        my constant foo1 .= new;
        ok foo1.DEFINITE, 'instantiated an object';
        is foo1.WHAT, Mu, 'default type is Mu';
    }

    my Int constant foo2 .= new: 42;
    is-deeply foo2, 42, 'basic type constraint';

    subtest 'class with `::` in name' => {
        plan 4;
        my class Foo::Bar::Ber {
            has $.a; has $.b; has $.c;
            method new ($a?, :$b, :$c) { self.bless: :$a, :$b, :$c }
        }

        my Foo::Bar::Ber constant foo3 .= new;
        is-deeply foo3, Foo::Bar::Ber.new, 'no args';

        my Foo::Bar::Ber constant foo4 .= new: 10, :20b, :30c;
        is-deeply foo4, Foo::Bar::Ber.new(10, :20b, :30c), 'pos + named args';

        ok 1;
        # my Foo::Bar::Ber constant foo5 .= new :20b :30c;
        # is-deeply foo5, Foo::Bar::Ber.new(:20b, :30c), 'fake-infix adverbs';

        ok 1;
        # my Foo::Bar::Ber constant foo6 .= new(10) :20b :30c;
        # is-deeply foo6, Foo::Bar::Ber.new(10, :20b, :30c),
            # 'pos arg + fake-infix adverbs';
    }

    my Array[Numeric] constant foo7 .=new: 1, 2, 3;
    is-deeply foo7, Array[Numeric].new(1, 2, 3), 'parametarized type';
}

# vim: expandtab shiftwidth=4
