# http://perl6advent.wordpress.com/2011/12/20/paired-up-hashes/
use Test;
plan 16;

my %ò갨丧æ = Panacea => 'found a lover', Photek => 'ni ten ichi ryu';
is +%ò갨丧æ.keys, 2, '+keys';
is-deeply (keys %ò갨丧æ), %ò갨丧æ.keys, 'Hash .keys';
is +%ò갨丧æ.values, 2, '+values';
is-deeply (values %ò갨丧æ), %ò갨丧æ.values, 'Hash .values';

is %ò갨丧æ{'Panacea'},%ò갨丧æ<Panacea>, 'hash lookup syntax';
is-deeply %ò갨丧æ{'Panacea', 'Photek'}, %ò갨丧æ<Panacea Photek>, 'hash slice syntax';

my $ò갨丧æ = paniq => 'Godshatter';
isa-ok $ò갨丧æ, Pair;
is $ò갨丧æ.key, 'paniq', 'Pair .key';
is $ò갨丧æ.value, 'Godshatter', 'Pair .value';

is-deeply $ò갨丧æ, (:paniq('Godshatter')), 'Pair alternate syntax';
{
    my @ò갨丧æò = %ò갨丧æ; # same as @(%songs);
    is +@ò갨丧æò, 2, 'Hash to Array flattening';
    isa-ok @ò갨丧æò[0], Pair, 'Array flattening (gives pairs)'
}

{
    my @ò갨丧æò = %ò갨丧æ.kv;
    is +@ò갨丧æò, 4, "Hash .kv flattening (flattens pairs)";
    isa-ok @ò갨丧æò[0], Str, "Hash .kv flattening (flattens pairs)";
}

%ò갨丧æ.push( 'Panacea' => "state of extacy" );
is-deeply %ò갨丧æ<Panacea>, ['found a lover', 'state of extacy'], 'Hash .push of Pair';

my %àс中갢ò中 = 'modus operandi' => 'Photek',
    'dying civilization' => 'Panacea';

%ò갨丧æ.push: %àс中갢ò中.invert;

is-deeply %ò갨丧æ, {
    "Panacea" => ["found a lover", "state of extacy",
                  "dying civilization"],
    "Photek" => ["ni ten ichi ryu", "modus operandi"]
}, 'inversion push';

# vim: expandtab shiftwidth=4
