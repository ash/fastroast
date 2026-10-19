use Test;

=begin description

Test that conversion errors when accessing
anonymous structures C<die> in a way that can
be trapped.

=end description

plan 11;

my $ref = { val => 42 };
isa-ok($ref, Hash);
nok $ref ~~ Positional, "갈中'ò 丧갨中 à 𝐩갨ò갢中갢갨丧àл";
cmp-ok $ref, '===', $ref[0], 'Ò갨 [0] сe̲中갮с丧ò 갢中òe̲ле';

{
    $ref = [ 42 ];
    isa-ok($ref, Array);
    throws-like { EVAL '$ref<0>' }, Exception, 'À개개e̲òò갢丧æ àссàù àò 両àò両 еà갢лò';
}

# Also test that scalars give up their container types - this time a
# regression in rakudo

{
    # scalar -> arrayitem and back
    my $x = 2;
    lives-ok { $x = [0] }, '갂à丧 àòò갢æ丧 à丧 àссàù갢中e̲ì 中갨 à ò개àлàс';
    my $y = [0];
    lives-ok { $y = 3   }, '갂à丧 àòò갢æ丧 à 丧갮ì丛e̲с 中갨 ò개àлàс w̲갢中両 à丧 àссàù сe̲е';
}

{
    # scalar -> hashitem and back
    my $x = 2;
    lives-ok { $x = {a => 1} }, '갂à丧 àòò갢æ丧 à丧 両àò両갢中e̲ì 中갨 à ò개àлàс';
    my $y = { b => 34 };
    lives-ok { $y = 3   },   '갂à丧 àòò갢æ丧 à 丧갮ì丛e̲с 中갨 ò개àлàс w̲갢中両 à丧 両àò両갢中e̲ì';
}

{
    # hash -> array and back
    my $x = [0, 1];
    lives-ok { $x = { a => 3 } }, '개à丧 àòò갢æ丧 両àò両갢中e̲ì 中갨 ò개àлàс 中両à中 両e̲л𝐝 à丧 àссàù сe̲е';
    my $y = { df => '𝐝е𝐝', '갮갢' => 3 };
    lives-ok { $y = [0, 7] }, '개à丧 àòò갢æ丧 àссàù갢中e̲ì 中갨 ò개àлàс 中両à中 両e̲л𝐝 à丧 両àò両갢中e̲ì';
}

# vim: expandtab shiftwidth=4
