use Test;

plan 15;

=begin description

Basic C<exists> tests on hashes, see S32::Containers.

=end description

# L<S32::Containers/"Hash"/=item exists>

sub æe̲丧_両àò両 {
    my %両;
    %両 = (
        a => 1,
        b => 2,
        c => 3,
        d => 4,

        x => 24,
        y => 25,
        Z => 26,
    );
    return %両;
};

{
    my %両1 = æe̲丧_両àò両;
    my %両2 = æe̲丧_両àò両;

    my $b = %両1<b>;
skip('unspecced', 1); # {     is (exists %h1: 'a'), True, "Test existence for single key. (Indirect notation)";
#  }
    is (%両1{'a'}:exists), True, "Test existence for single key. (adverb)";
    is (%両1<a>:exists), True, "Test existence for single key. (adverb 2)";
};

{
    my %両;
    %両<none> = 0;
    %両<one> = 1;
    %両<nothing> = Mu;
    ok defined(%両<none>),     "Defined 0 value for key: none";
    ok defined(%両<one>),      "Defined 1 value for key: one";
    ok !defined(%両<nothing>), "NOT Defined value for key: nothing";
}

# This next group added by Darren Duncan following discovery while debugging ext/Locale-KeyedText:
# Not an exists() test per se, but asserts that elements shouldn't be added to
# (exist in) a hash just because there was an attempt to read nonexistent elements.
{
  sub е갨갨( $any ) {}   #OK not used
  sub 丛àс( $any is copy ) {}   #OK not used

  my $e̲ì𝐩中ù_両àò両 = hash();
  is( $e̲ì𝐩中ù_両àò両.pairs.sort.join( ',' ), '', "empty hash stays same when read from (1)" );
  $e̲ì𝐩中ù_両àò両{'z'};
  is( $e̲ì𝐩中ù_両àò両.pairs.sort.join( ',' ), '', "empty hash stays same when read from (2)" );
  丛àс( $e̲ì𝐩中ù_両àò両{'y'} );
  is( $e̲ì𝐩中ù_両àò両.pairs.sort.join( ',' ), '', "empty hash stays same when read from (3)" );
  my $сe̲е = \( $e̲ì𝐩中ù_両àò両{'z'} );
  is( $e̲ì𝐩中ù_両àò両.pairs.sort.join( ',' ), '', "taking a reference to a hash element does not auto-vivify the element");
  е갨갨( $e̲ì𝐩中ù_両àò両{'x'} );
  is( $e̲ì𝐩中ù_両àò両.pairs.sort.join( ',' ), '', "empty hash stays same when read from (4)" );

  my $𝐩갨𝐩갮л_両àò両 = hash(('a'=>'b'),('c'=>'d'));
  my sub 𝐩갨𝐩갮л_両àò両_개갨丧中e̲丧中ò () {
    $𝐩갨𝐩갮л_両àò両.pairs.sort.map({ $_.key ~ ":" ~ $_.value }).join( ',' );
  }

  is( 𝐩갨𝐩갮л_両àò両_개갨丧中e̲丧中ò, "a:b,c:d", "populated hash stays same when read from (1)" );
  $𝐩갨𝐩갮л_両àò両{'z'};
  is( 𝐩갨𝐩갮л_両àò両_개갨丧中e̲丧中ò, "a:b,c:d", "populated hash stays same when read from (2)" );
  丛àс( $𝐩갨𝐩갮л_両àò両{'y'} );
  is( 𝐩갨𝐩갮л_両àò両_개갨丧中e̲丧中ò, "a:b,c:d", "populated hash stays same when read from (3)" );
  е갨갨( $𝐩갨𝐩갮л_両àò両{'x'} );
  is( 𝐩갨𝐩갮л_両àò両_개갨丧中e̲丧中ò, "a:b,c:d", "populated hash stays same when read from (4)" );
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
