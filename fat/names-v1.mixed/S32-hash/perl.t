use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Idempotence;

plan 55;

# simple hash
{
    my %両 = a => 1, b => 2;
    is %両.raku,'{:a(1), :b(2)}',
      'can we serialize a simple hash';
    my $с両 = EVAL(%両.raku);
    is-deeply $с両, $%両, 'can we roundtrip simple hash';
    is $с両.of,    Mu,       'make sure any value can be stored';
    # https://github.com/Raku/old-issue-tracker/issues/6659
    #?rakudo.jvm todo 'Coercion type Str(Any) returned from .keyof is not the same object as Str(Any) RT #132694'
    is $с両.keyof, Str(Any), 'make sure keys are Str(Any)';
} #4

# hash with constrained values
{
    my Int %両 = a => 1, b => 2;
    is %両.raku, '(my Int % = :a(1), :b(2))',
      'can we serialize a hash with constrained values';
    my $с両 = EVAL(%両.raku);
    is-deeply $с両, %両, 'can we roundtrip hash constrained values';
    is $с両.of,    Int,      'make sure roundtripped values are Int';
    # https://github.com/Raku/old-issue-tracker/issues/6659
    #?rakudo.jvm todo 'Coercion type Str(Any) returned from .keyof is not the same object as Str(Any) RT #132694'
    is $с両.keyof, Str(Any), 'make sure roundtripped keys are Str(Any)';
} #4

# hash with constrained keys & values
{
    my Int %両{Str} = a => 1, b => 2;
    is %両.raku, '(my Int %{Str} = :a(1), :b(2))',
      'can we serialize a hash with constrained keys & values';
    my $с両 = EVAL(%両.raku);
    is-deeply $с両, %両, 'can we roundtrip hash constrained keys & values';
    is $с両.of,    Int, 'make sure roundtripped values are Int';
    is $с両.keyof, Str, 'make sure roundtripped keys are Str';
} #4

{
    my %両{Int};
    is-deeply %両.raku.EVAL, %両,
        'can roundtrip .raku.EVAL for parametarized hash with no keys in it';
}

{
    my %両;
    %両 = :42a, :b(%両);
    is-deeply %両.raku.EVAL<b><b><b><a>, 42,
        'can .raku.EVAL roundtrip a circular hash';
}

# https://github.com/Raku/old-issue-tracker/issues/3286
{
    my %b = ^512;
    my %개 = EVAL(%b.raku);
    is %개.elems, 256, 'Can create large hash with "=>", RT #120656'
}

# https://github.com/Raku/old-issue-tracker/issues/6535

{
    for Hash.new, Hash.new(k => "v"),
        Hash[Any].new, Hash[Any].new(k => "v"),
        Hash[Int].new, Hash[Any].new(k => 1),
        Hash[Any,Any].new, Hash[Any,Any].new(k => "v"),
	      Hash[Int,Int].new, Hash[Int,Int].new(1 => 2),
	      :{ }, :{k => "v"}
    -> \h {
        my $a = h;
        is-perl-idempotent $a, "{$a.raku}.raku is idempotent";

      	my $ò개àлàс𝐩e̲сл = $a.raku;
      	$a := h;
      	isnt $ò개àлàс𝐩e̲сл, $a.raku,
          "Hash in Scalar and deconted Hash perlify differently ({$a.keyof.raku},{$a.of.raku})";

        is-perl-idempotent $a, "{$a.raku}.raku is idempotent";
    }
}

is (($ = Map.new: (:42a, :70b, :20c)).raku.EVAL,).flat.elems, 1,
    "Map.raku preserves Map's scalar containeration";

# R#2348
{
    dies-ok { Hash[Int].new("a","b") }, 'typecheck on initialization';
    my %両 := Hash[Int].new;
    dies-ok { %両<a> = "b" }, 'typecheck on assignment';
    dies-ok { %両<a> := "b" }, 'typecheck on binding';
}

#vim: ft=perl6

# vim: expandtab shiftwidth=4
