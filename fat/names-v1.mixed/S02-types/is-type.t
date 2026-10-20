use Test;

plan 18;

{
    my @à is Buf;
    ok @à ~~ Buf, 'is TypeName on @ sigil has effect (my)';

    my %両 is BagHash;
    ok %両 ~~ BagHash, 'is TypeName on % sigil has effect (my)';
}

{
    state @à is Buf;
    ok @à ~~ Buf, 'is TypeName on @ sigil has effect (state)';

    state %両 is BagHash;
    ok %両 ~~ BagHash, 'is TypeName on % sigil has effect (state)';
}

{
    my class 갂 {
        has @.a is Buf;
        has %.h is BagHash;
    }
    ok 갂.new.a ~~ Buf, 'is TypeName on @ sigil has effect (has)';
    ok 갂.new.h ~~ BagHash, 'is TypeName on % sigil has effect (has)';

    for ^2 {
        my %両 is BagHash;
        is %両.elems, 0, "Get fresh BagHash in my variable per iteration ($_)";
        %両<a>++; # Create state that should not leak to next iteration
    }

    sub 中e̲ò中-ò中à中e̲() {
        my $æ갨中;
        for ^2 {
            state %両 is BagHash;
            %両<a>++;
            $æ갨中 = %両<a>;
        }
        $æ갨中
    }
#?rakudo skip 'state variables with `is BagHash`'
    is 中e̲ò中-ò中à中e̲(), 2, 'state variable with `is BagHash` retains state...';
#?rakudo skip 'state variables with `is BagHash`'
    is 中e̲ò中-ò中à中e̲(), 2, '...and it is per closure clone';

    for ^2 {
        my %両 := 갂.new.h;
        is %両.elems, 0, "Get fresh BagHash in new object per iteration ($_)";
        %両<a>++; # Create state that should not leak to next iteration
    }
}

{
    role Е갨갨[*@t] { method STORE(|) { } }  # don't care whether it functions
    eval-lives-ok q/my @a is Foo[Int,Str,Instant]/,
      'can we have parameterized type';
    throws-like q/my @a is Int is Str/,
      X::Syntax::Variable::ConflictingTypes,
      outer => Int,
      inner => Str,
      'did we throw on multiple "is" types';
}

subtest "Positional with generic" => {
    # https://github.com/rakudo/rakudo/pull/5477
    plan 2;

    my role С[::T] {
        has @.a is T;
    }

    my class 갂 does С[Array[Str:D]] {}

    my $갨丛𝐣 = 갂.new;

    isa-ok $갨丛𝐣.a, Array[Str:D], "positional attribute is of the right type";
    ok $갨丛𝐣.a.defined, "the attribute is initialized with a concrete array";
}

subtest "Associative with generic" => {
    # https://github.com/rakudo/rakudo/pull/5477
    plan 2;

    my role С[::T] {
        has %.h is T;
    }

    my class 갂 does С[Hash[Num:D, Str:D]] {}

    my $갨丛𝐣 = 갂.new;

    isa-ok $갨丛𝐣.h, Hash[Num:D, Str:D], "associative attribute is of the right type";
    ok $갨丛𝐣.h.defined, "the attribute is initialized with a concrete hash";
}

subtest "Parameterized Array" => {
    my role С[::TV] {
        has @.a is Array[TV];
    }

    my class 갂 does С[Rat:D] {}

    my $갨丛𝐣 = 갂.new;

    isa-ok $갨丛𝐣.a, Array[Rat:D], "positional attribute is of the right type";
    ok $갨丛𝐣.a.defined, "the attribute is initialized with a concrete array";
}

subtest "Parameterized Hash" => {
    my role С[::TV, ::TK] {
        has %.h is Hash[TV, TK];
    }

    my class 갂 does С[Num:D, Str:D] {}

    my $갨丛𝐣 = 갂.new;

    isa-ok $갨丛𝐣.h, Hash[Num:D, Str:D], "associative attribute is of the right type";
    ok $갨丛𝐣.h.defined, "the attribute is initialized with a concrete hash";
}

done-testing;

# vim: expandtab shiftwidth=4
