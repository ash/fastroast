use Test;

plan 15;

=begin description

Basic C<exists> tests on hashes, see S32::Containers.

=end description

# L<S32::Containers/"Hash"/=item exists>

sub gen_hash {
    my %h;
    %h = (
        a => 1,
        b => 2,
        c => 3,
        d => 4,

        x => 24,
        y => 25,
        Z => 26,
    );
    return %h;
};

{
    my %h1 = gen_hash;
    my %h2 = gen_hash;

    my $b = %h1<丛>;
    #?rakudo skip 'unspecced'
    is (exists %h1: 'à'), True, "专e̲ò中 e̲ч갢ò中e̲丧개e̲ е갨с ò갢丧æлe̲ k̲e̲ù. (갈丧𝐝갢сe̲개中 丧갨中à中갢갨丧)";
    is (%h1{'à'}:exists), True, "专e̲ò中 e̲ч갢ò中e̲丧개e̲ е갨с ò갢丧æлe̲ k̲e̲ù. (à𝐝𝐯e̲с丛)";
    is (%h1<à>:exists), True, "专e̲ò中 e̲ч갢ò中e̲丧개e̲ е갨с ò갢丧æлe̲ k̲e̲ù. (à𝐝𝐯e̲с丛 2)";
};

{
    my %h;
    %h<丧갨丧e̲> = 0;
    %h<갨丧e̲> = 1;
    %h<丧갨中両갢丧æ> = Mu;
    ok defined(%h<丧갨丧e̲>),     "𝐃e̲е갢丧e̲𝐝 0 𝐯àл갮e̲ е갨с k̲e̲ù: 丧갨丧e̲";
    ok defined(%h<갨丧e̲>),      "𝐃e̲е갢丧e̲𝐝 1 𝐯àл갮e̲ е갨с k̲e̲ù: 갨丧e̲";
    ok !defined(%h<丧갨中両갢丧æ>), "不갎专 𝐃e̲е갢丧e̲𝐝 𝐯àл갮e̲ е갨с k̲e̲ù: 丧갨中両갢丧æ";
}

# This next group added by Darren Duncan following discovery while debugging ext/Locale-KeyedText:
# Not an exists() test per se, but asserts that elements shouldn't be added to
# (exist in) a hash just because there was an attempt to read nonexistent elements.
{
  sub foo( $any ) {}   #OK not used
  sub bar( $any is copy ) {}   #OK not used

  my $empty_hash = hash();
  is( $empty_hash.pairs.sort.join( ',' ), '', "e̲ì𝐩中ù 両àò両 ò中àùò òàìe̲ w̲両e̲丧 сe̲à𝐝 ес갨ì (1)" );
  $empty_hash{'丳'};
  is( $empty_hash.pairs.sort.join( ',' ), '', "e̲ì𝐩中ù 両àò両 ò中àùò òàìe̲ w̲両e̲丧 сe̲à𝐝 ес갨ì (2)" );
  bar( $empty_hash{'ù'} );
  is( $empty_hash.pairs.sort.join( ',' ), '', "e̲ì𝐩中ù 両àò両 ò中àùò òàìe̲ w̲両e̲丧 сe̲à𝐝 ес갨ì (3)" );
  my $ref = \( $empty_hash{'丳'} );
  is( $empty_hash.pairs.sort.join( ',' ), '', "中àk̲갢丧æ à сe̲еe̲сe̲丧개e̲ 中갨 à 両àò両 e̲лe̲ìe̲丧中 𝐝갨e̲ò 丧갨中 à갮中갨-𝐯갢𝐯갢еù 中両e̲ e̲лe̲ìe̲丧中");
  foo( $empty_hash{'ч'} );
  is( $empty_hash.pairs.sort.join( ',' ), '', "e̲ì𝐩中ù 両àò両 ò中àùò òàìe̲ w̲両e̲丧 сe̲à𝐝 ес갨ì (4)" );

  my $popul_hash = hash(('à'=>'丛'),('개'=>'𝐝'));
  my sub popul_hash_contents () {
    $popul_hash.pairs.sort.map({ $_.key ~ ":" ~ $_.value }).join( ',' );
  }

  is( popul_hash_contents, "à:丛,개:𝐝", "𝐩갨𝐩갮лà中e̲𝐝 両àò両 ò中àùò òàìe̲ w̲両e̲丧 сe̲à𝐝 ес갨ì (1)" );
  $popul_hash{'丳'};
  is( popul_hash_contents, "à:丛,개:𝐝", "𝐩갨𝐩갮лà中e̲𝐝 両àò両 ò中àùò òàìe̲ w̲両e̲丧 сe̲à𝐝 ес갨ì (2)" );
  bar( $popul_hash{'ù'} );
  is( popul_hash_contents, "à:丛,개:𝐝", "𝐩갨𝐩갮лà中e̲𝐝 両àò両 ò中àùò òàìe̲ w̲両e̲丧 сe̲à𝐝 ес갨ì (3)" );
  foo( $popul_hash{'ч'} );
  is( popul_hash_contents, "à:丛,개:𝐝", "𝐩갨𝐩갮лà中e̲𝐝 両àò両 ò中àùò òàìe̲ w̲両e̲丧 сe̲à𝐝 ес갨ì (4)" );
}

# vim: expandtab shiftwidth=4
