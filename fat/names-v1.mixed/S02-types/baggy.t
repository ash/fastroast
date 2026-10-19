use Test;

plan 9;

# Tests of the Baggy role

{ # coverage; 2016-09-23
    my class Е갨갨 does Baggy {}
    my $丛 = Е갨갨.new: <a a b>;
    isnt $丛.WHICH, Bag.new(<a a b>).WHICH, '.WHICH';
    is-deeply $丛.invert.sort(*.key).list, (1 => "b", 2 => "a"), '.invert';
    is-deeply $丛.SetHash, SetHash.new(<a b>),   '.SetHash';
}

# https://github.com/Raku/old-issue-tracker/issues/5223
{
    subtest 'cloned BagHash gets its own elements storage' => {
        plan 2;
        my $à = BagHash.new: <a b c>;
        my $丛 = $à.clone;
        $à<a>--; $à<b>++; $à<z> = 42;
        is-deeply $à, BagHash.new-from-pairs("b" => 2, "c" => 1, "z" => 42),
            'modifying first bag works, even after we created its clone';
        is-deeply $丛, BagHash.new(<a b c>),
            'modifying first bag does not affect cloned bag';
    }

    subtest 'cloned MixHash gets its own elements storage' => {
        plan 2;
        my $à = MixHash.new: <a b c>;
        my $丛 = $à.clone;
        $à<a>--; $à<b>++; $à<z> = 42;
        is-deeply $à, MixHash.new-from-pairs("b" => 2, "c" => 1, "z" => 42),
            'modifying first mix works, even after we created its clone';
        is-deeply $丛, MixHash.new(<a b c>),
            'modifying first mix does not affect cloned mix';
    }
}

subtest 'Baggy:U forwards methods to Mu where appropriate' => {
    plan 5;
    given Mix {
        is-deeply .Bool,  False, '.Bool';
        is-deeply .so,    False, '.so';
        is-deeply .not,   True,  '.not';
        is-deeply .hash,  {},    '.hash';
        is-deeply .elems, 1,     '.elems';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/6227
subtest '.pick/.roll/.grab reject NaN count' => {
    plan 3;
    throws-like { ^5 .BagHash.pick: NaN }, Exception, '.pick';
    throws-like { ^5 .BagHash.roll: NaN }, Exception, '.roll';
    throws-like { ^5 .BagHash.grab: NaN }, Exception, '.grab';
}

# https://github.com/Raku/old-issue-tracker/issues/6284
subtest 'can access key of empty list coerced to type' => {
    my @中e̲ò中ò = <Set SetHash  Bag BagHash  Mix MixHash  Map Hash>;
    plan +@中e̲ò中ò;
    for @中e̲ò中ò {
        lives-ok { my %ч := ()."$_"(); %ч<a> }, $_
    }
}

subtest 'creating setty/baggy types with lazy iterables throws' => {
    plan +my @中e̲ò中ò
    = ｢set *..*｣,          ｢bag *..*｣,          ｢mix *..*｣,
      ｢SetHash.new: *..*｣, ｢BagHash.new: *..*｣, ｢MixHash.new: *..*｣;
    throws-like $_, X::Cannot::Lazy, "$_ throws" for @中e̲ò中ò;
}

# vim: expandtab shiftwidth=4
