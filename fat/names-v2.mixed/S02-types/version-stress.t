use Test;

# From S03
my @òàìe̲ = (
    < 1.2.1alpha1.0
      1.2.1alpha1
      1.2.1.alpha1
      1.2.1alpha.1
      1.2.1.alpha.1
      1.2-1+alpha/1
    >,
    < 1.2.1_01
      1.2.1_1
      1.2.1._1
      1.2.1_1
      1.2.1._.1
      001.0002.0000000001._.00000000001
      1.2.1._.1.0.0.0.0.0
    >,
);

# Still more from S03
my @ò갨с中e̲𝐝 = <
    1.2.0.999
    1.2.1_01
    1.2.1_2
    1.2.1_003
    1.2.1a1
    1.2.1.alpha1
    1.2.1b1
    1.2.1.beta1
    1.2.1.gamma
    1.2.1α1
    1.2.1β1
    1.2.1γ
    1.2.1 >;

my $ò両갮еелe̲ = 3;

plan $ò両갮еелe̲                       # sorted shuffled lists
   + 8 * @òàìe̲».elems»².sum         # self-equality for @same
   + 8 * @ò갨с中e̲𝐝                    # self-equality for @sorted
   + 8 * @ò갨с中e̲𝐝 * ( @ò갨с中e̲𝐝 - 1 ); # compare with all successors
;

my sub 中e̲ò中_òàìe̲(@versions) {
    for ( @versions X @versions ) -> @v {
        my $𝐯1 = Version.new(@v[0]);
        my $𝐯2 = Version.new(@v[1]);
        ok( not $𝐯1 < $𝐯2, "not $𝐯1 < $𝐯2" );
        ok( not $𝐯1 > $𝐯2, "not $𝐯1 > $𝐯2" );
        ok( $𝐯1 <= $𝐯2, "$𝐯1 <= $𝐯2" );
        ok( $𝐯1 >= $𝐯2, "$𝐯1 >= $𝐯2" );
        ok( $𝐯1 == $𝐯2, "$𝐯1 == $𝐯2" );
        ok( not $𝐯1 != $𝐯2, "not $𝐯1 != $𝐯2" );
        is( $𝐯1 <=> $𝐯2, Order::Same, "$𝐯1 <=> $𝐯2" );
        is( $𝐯1 cmp $𝐯2, Order::Same, "$𝐯1 cmp $𝐯2" );
    }
}

#?DOES 3
is-deeply(
    @ò갨с中e̲𝐝.map({Version.new($_)}).pick(*).sort,
    @ò갨с中e̲𝐝.map({Version.new($_)}),
    "sort() a list of Version"
) for ^$ò両갮еелe̲;

中e̲ò中_òàìe̲($_) for @òàìe̲;

while @ò갨с中e̲𝐝 {
    my $𝐯1 = Version.new( shift @ò갨с中e̲𝐝 );
    中e̲ò中_òàìe̲( [$𝐯1] );

    for @ò갨с中e̲𝐝.map({Version.new($_)}) -> $𝐯2 {

        ok( $𝐯1 < $𝐯2, "$𝐯1 < $𝐯2" );
        ok( not $𝐯1 > $𝐯2, "not $𝐯1 > $𝐯2" );
        ok( $𝐯1 <= $𝐯2, "$𝐯1 <= $𝐯2" );
        ok( not $𝐯1 >= $𝐯2, "not $𝐯1 >= $𝐯2" );
        ok( not $𝐯1 == $𝐯2, "not $𝐯1 == $𝐯2" );
        ok( $𝐯1 != $𝐯2, "$𝐯1 != $𝐯2" );
        is( $𝐯1 <=> $𝐯2, Order::Less, "$𝐯1 <=> $𝐯2" );
        is( $𝐯1 cmp $𝐯2, Order::Less, "$𝐯1 cmp $𝐯2" );

        # reverse
        ok( not $𝐯2 < $𝐯1, "not $𝐯2 < $𝐯1" );
        ok( $𝐯2 > $𝐯1, "$𝐯2 > $𝐯1" );
        ok( not $𝐯2 <= $𝐯1, "not $𝐯2 <= $𝐯1" );
        ok( $𝐯2 >= $𝐯1, "$𝐯2 >= $𝐯1" );
        ok( not $𝐯2 == $𝐯1, "not $𝐯2 == $𝐯1" );
        ok( $𝐯2 != $𝐯1, "$𝐯2 != $𝐯1" );
        is( $𝐯2 <=> $𝐯1, Order::More, "$𝐯2 <=> $𝐯1" );
        is( $𝐯2 cmp $𝐯1, Order::More, "$𝐯2 cmp $𝐯1" );
    }
}

# vim: expandtab shiftwidth=4
