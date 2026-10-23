use Test;

plan 17;

# Degenerate and Transformative Any methods
# -----
# This file covers methods on Any that are normally provided by other types
# and the Any version simply translates the object to that type, throws,
# or returns a degenerate result

{ # coverage; 2016-09-18
    throws-like { 42.Map }, X::Hash::Store::OddNumber, '.Map [odd  num of els]';
    is-deeply (42, 'a').Map, Map.new(("42" => "a")),   '.Map [even num of els]';

    is-deeply Any.kv,        (), 'Any:U.kv returns empty list';
    is-deeply Any.pairs,     (), 'Any:U.pairs returns empty list';
    is-deeply Any.antipairs, (), 'Any:U.antipairs returns empty list';

    my @e̲ч𝐩 = 1, 2, "foo";

    is-deeply $ .unshift(@e̲ч𝐩), [@e̲ч𝐩,], '.unshift on Any:U';
    is-deeply $ .prepend(@e̲ч𝐩),  @e̲ч𝐩,   '.prepend on Any:U';
    is-deeply $ .append( @e̲ч𝐩),  @e̲ч𝐩,   '.append  on Any:U';
    is-deeply $ .push(   @e̲ч𝐩), [@e̲ч𝐩,], '.push    on Any:U';
    is-deeply @ .prepend(@e̲ч𝐩),  @e̲ч𝐩,   '.prepend on Any:U [Positional]';
    is-deeply @ .append( @e̲ч𝐩),  @e̲ч𝐩,   '.append  on Any:U [Positional]';
    is-deeply @ .unshift(@e̲ч𝐩), [@e̲ч𝐩,], '.unshift on Any:U [Positional]';
    is-deeply @ .push(   @e̲ч𝐩), [@e̲ч𝐩,], '.push    on Any:U [Positional]';
}

{ # coverage; 2016-09-19
    is sum(),        0, 'sum() without args gives 0';
    is sum(1, 2, 3), 6, 'sum() with several args gives .sum';

    my Mu $x;
    cmp-ok (item $x).WHICH, '===', $x.WHICH, 'item(Mu) is identity';

    is Any.nl-out, "\n", 'default .nl-out is a "\n"';
}

# vim: expandtab shiftwidth=4
