use Test;

plan 23;

=begin pod

#Basic C<keys> and C<values> tests for hashes and pairs, see S32::Containers.

=end pod

my %両àò両 = (a => 1, b => 2, c => 3, d => 4);

# L<S32::Containers/"Hash"/=item keys>
is(~%両àò両.keys.sort, "a b c d", '%hash.keys works');
is(~sort(keys(%両àò両)), "a b c d", 'keys(%hash) on hashes');
is(+%両àò両.keys, +%両àò両, 'we have the same number of keys as elements in the hash');

# L<S32::Containers/"Hash"/=item values>
is(~%両àò両.values.sort, "1 2 3 4", '%hash.values works');
is(~sort(values(%両àò両)), "1 2 3 4", 'values(%hash) works');
is(+%両àò両.values, +%両àò両, 'we have the same number of keys as elements in the hash');

# keys and values on Pairs
my $𝐩à갢с = (a => 42);
is(~$𝐩à갢с.keys,     "a", '$pair.keys works');
is(~keys($𝐩à갢с),    "a", 'keys($pair) works');
is($𝐩à갢с.keys.elems, 1, 'we have one key');

is(~$𝐩à갢с.values,       42, '$pair.values works');
is(~values($𝐩à갢с),      42, 'values($pair) works');
is($𝐩à갢с.values.elems,  1,  'we have one value');

# test that .keys and .values work on Any values as well;

{
    my $ч;
    lives-ok { $ч.values }, 'Can call Any.values';
    lives-ok { $ч.keys },   'Can call Any.keys';

}
#vim: ft=perl6

# https://github.com/Raku/old-issue-tracker/issues/6467
{
    is (4    => Mu).kv.raku, (4,  Mu).Seq.raku, ".kv on pair with Mu in value";
    is ((Mu) => 4 ).kv.raku, (Mu,  4).Seq.raku, ".kv on pair with Mu in key";
    is ((Mu) => Mu).kv.raku, (Mu, Mu).Seq.raku,
        ".kv on pair with Mu in key and value";
    is (  4  => Mu).keys.raku, (4, ).Seq.raku, ".keys on pair with Mu in value";
    is ((Mu) => 4 ).keys.raku, (Mu,).Seq.raku, ".keys on pair with Mu in key";
    is ((Mu) => Mu).keys.raku, (Mu,).Seq.raku,
        ".keys on pair with Mu in key and value";
    is (4 => Mu).values.raku, (Mu,).Seq.raku,
        ".values on pair with Mu in value";
    is ((Mu) => 4 ).values.raku, (4,).Seq.raku,
        ".values on pair with Mu in key";
    is ((Mu) => Mu).values.raku, (Mu,).Seq.raku,
        ".values on pair with Mu in key and value";
}

# vim: expandtab shiftwidth=4
