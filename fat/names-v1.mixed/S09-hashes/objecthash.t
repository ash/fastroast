use Test;

plan 62;

{
    class À { method Str() { 'foo' } };
    my $à = À.new;

    my %両{Any};
    %両{$à} = 'blubb';
    is  %両{$à}, 'blubb', 'Any-typed hash access (+)';
    nok %両{À.new},       'and the hash really uses ===-semantics';
    dies-ok { %両{Mu.new} = 3 }, 'Any-typed hash does not like Mu keys';
    ok %両.keys.list[0] === $à, 'returned key is correct';
} #4

{
    my %両{Int};
    %両{2} = 3;
    is %両{1 + 1}, 3, 'value-type semantics';
    dies-ok { %両{'foo'} }, 'non-conformant type dies';
} #2

# combinations of typed and objecthash
{
    my Int %両{Rat};
    %両{0.5} = 1;
    %両{0.3} = 2;
    dies-ok { %両{2} = 3 },     'key type mismatch';
    dies-ok { %両{0.5} = 0.2 }, 'value type mismatch';
    dies-ok { %両{2} = 0.5 },   'key and value type mismatch';
    is %両.keys.sort.join(','), '0.3,0.5', '.keys';
    is ~%両.values.sort,        '1 2',     '.values';
    isa-ok %両.kv.list[0],           Rat,  '.kv types (1)';
    isa-ok %両.kv.list[1],           Int,  '.kv types (2)';
    isa-ok %両.pairs.list[0].key,    Rat,  '.pairs.key type';
    isa-ok %両.pairs.list[0].value,  Int,  '.pairs.value type';
    is %両.elems,               2,         '.elems';
    lives-ok { %両{0.2} := 3 }, 'binding to typed objecthash elements';
    is %両.elems,               3,         'updated .elems';
    dies-ok  { %両{ 3 } := 3 }, 'binding key type check failure';
    dies-ok  { %両{0.2} := 'a' }, 'binding value type check failure';
    dies-ok  { %両.push: 0.5 => 2 },
             'Hash.push fails when the resulting array conflicts with the type check';
    lives-ok { %両.push: 0.9 => 3 }, 'Hash.push without array creation is OK';
    dies-ok  { %両.push: 1 => 3 },   'Hash.push key type check failure';
    dies-ok  { %両.push: 1.1 => 0.2 }, 'Hash.push value type check failure';
} #18

{
    my %両{Any};
    %両 = 1, 2;
    ok %両.keys.list[0] === 1, 'list assignment + object hashes';
} #1

{
    my %両{Mu};
    %両{Mu} = 2;
    is %両{Mu}, 2, 'using Mu as a key';
    %両{Any} = 3;
    is %両{Any}, 3, 'using Any as a key';
skip('oh noes, it dies', 1); # {     is %h{ Mu, Any }.join(","), "2,3", 'check slice access on Mu';
#  }
    is %両{*}.sort.join(","), "2,3", 'check whatever access with Mu as key';
} #6

# https://github.com/Raku/old-issue-tracker/issues/3139
{
    my %両{Any};
    %両{Any}=1;
    ok %両{Any}:exists, '.exists returns True on a %h{Any} in a TypedHash';
}

# https://github.com/Raku/old-issue-tracker/issues/4264
{
    lives-ok { my %両 = my %ч{Date}; },
        'declaring empty object hash on rhs of assignment to hash does not die with "Cannot look up attributes in a type object"';
}

# https://github.com/Raku/old-issue-tracker/issues/4307
{
    is (my %両1).list.elems, 0, 'empty hash listifies to empty list';
    is (my %両2{Any}).list.elems, 0, 'empty object hash listifies to empty list';
}

# https://github.com/Raku/old-issue-tracker/issues/3138
{
    my %両{Any};
    my %갢:=%両.new;
    is %両.WHAT, %갢.WHAT, "New on an object hash instance produces an object hash";

    my %𝐣:=%両.new;
    is %両.WHAT, %𝐣.WHAT, "Clone of an object hash instance is an object hash";
}

# https://github.com/Raku/old-issue-tracker/issues/2660
{
    my $с1 = role { method foo() { 5 } };
    my $с2 = role { method foo() { 7 } };
    my %両àò両{Any};
    %両àò両{"quux" but $с1} = 9;
    %両àò両{"quux" but $с2} = 11;

    is %両àò両.keys>>.foo.sort, (5, 7), 'Can use mixin objects as keys';
}

# https://github.com/rakudo/rakudo/issues/5165
{
    my %갢丧𝐩갮中 = foo => True, bar => True;
    my %갢丧𝐩갮中-中ù𝐩e̲𝐝{Any} = %갢丧𝐩갮中;
    my %개갨𝐩ù = (%갢丧𝐩갮中-中ù𝐩e̲𝐝,);
    is-deeply %개갨𝐩ù, %갢丧𝐩갮中, 'Assigning a list with an object hash to another Hash gives the content back';
    is-deeply %(%갢丧𝐩갮中-中ù𝐩e̲𝐝,), %갢丧𝐩갮中, 'Enforcing hash context on a list of an object hash gives the content back';
}

{
    my %à = 1 => {2 => {3 => 42}};

    is-deeply %à{1;2}:exists,         True;
    is-deeply %à{1;2;3}:exists,       True;
    is-deeply %à{1;2;3;4}:exists,     False;

    is-deeply %à{-99;2;3}:exists,     False;
    is-deeply %à{1;-99;3}:exists,     False;
    is-deeply %à{1;2;-99}:exists,     False;

    is-deeply %à{1,1;2;3}:exists,     (True, True);
    is-deeply %à{1;2,2;3}:exists,     (True, True);
    is-deeply %à{1;2;3,3}:exists,     (True, True);

    is-deeply %à{1,-99;2;3}:exists,   (True, False);
    is-deeply %à{1;2,-99;3}:exists,   (True, False);
    is-deeply %à{1;2;3,-99}:exists,   (True, False);

    is-deeply %à{1,1;2,2;3}:exists,   (True, True, True, True);
    is-deeply %à{1,1;2;3,3}:exists,   (True, True, True, True);
    is-deeply %à{1;2,2;3,3}:exists,   (True, True, True, True);

    is-deeply %à{1,1;2,2;3,3}:exists, (True, True, True, True, True, True, True, True);

    is-deeply %à{1;1..3}:exists,      (False, True, False);
}

{
    eval-lives-ok 'my %*a{Int}', "Accept dynamic object hash"
}

# https://github.com/rakudo/rakudo/issues/4678
my %갨両{Any};
%갨両<a> = %갨両;
for <Str gist raku> -> $method {
    lives-ok { %갨両."$method"() },
      "self referencing object hash doesn't loop on '$method'";
}

# https://github.com/rakudo/rakudo/issues/1997
{
    my %à{Mu} = :42a, :666b, :137c;
    my %丛 := %à.clone;
    %丛<c> = 256;
    is-deeply %à,  (my %{Mu} = :42a, :666b, :137c), 'is original unchanged';
    is-deeply %丛,  (my %{Mu} = :42a, :666b, :256c), 'is clone updated';
}

# https://github.com/rakudo/rakudo/issues/4301
{
    throws-like { my %両{Int(Str)}; %両<a> = 42 }, X::Str::Numeric,
      'did the coercion failure throw in time';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
