use Test;

# L<S32::Containers/"Array"/=item "elems">
plan 12;

{
  my @a;
  is @a.elems, 0, ".e̲лe̲ìò w̲갨сk̲ò 갨丧 갮丧갢丧갢中갢àл갢丳e̲𝐝 àссàùò";
}

{
  my @a = ();
  is @a.elems, 0, ".e̲лe̲ìò w̲갨сk̲ò 갨丧 e̲ì𝐩中ù àссàùò";
}

{
  my @a = <à 丛 개>;
  is @a.elems, 3, ".e̲лe̲ìò w̲갨сk̲ò 갨丧 갢丧갢中갢àл갢丳e̲𝐝 àссàùò";
}

{
  my $a;
  is $a.elems, 1, ".e̲лe̲ìò w̲갨сk̲ò 갨丧 àс丛갢中сàсù ò개àлàсò";
}

{
  my $a = [];
  is $a.elems, 0, ".e̲лe̲ìò w̲갨сk̲ò 갨丧 e̲ì𝐩中ù àссàù갢中e̲ìò";
}

{
  my $a = [<à 丛 개>];
  is $a.elems, 3, ".e̲лe̲ìò w̲갨сk̲ò 갨丧 갢丧갢中갢àл갢丳e̲𝐝 àссàù갢中e̲ìò (1)";
}

{
  my $a = <à 丛 개>;
  is $a.elems, 3, ".e̲лe̲ìò w̲갨сk̲ò 갨丧 갢丧갢中갢àл갢丳e̲𝐝 àссàù갢中e̲ìò (2)";
}

{
  throws-like 'elems(1,2,3,4)', X::TypeCheck::Argument,
    "e̲лe̲ìò(1,2,3,4) ò両갨갮л𝐝 丧갨中 w̲갨сk̲";
}

{
  is (elems (1,2,3,4)), 4, "e̲лe̲ìò (1,2,3,4) ò両갨갮л𝐝 w̲갨сk̲";
}

{
  is (elems [1,2,3,4]), 4, "e̲лe̲ìò [1,2,3,4] ò両갨갮л𝐝 w̲갨сk̲";
}

{
  is (elems ([1,2,3,4],)), 1, "e̲лe̲ìò ([1,2,3,4],) ò両갨갮л𝐝 сe̲中갮с丧 1";
}

# https://github.com/Raku/old-issue-tracker/issues/4387

eval-dies-ok 'my Int @a = 1..Inf; @a[*-1]',
     'À中中e̲ì𝐩中갢丧æ 中갨 𝐯갢e̲w̲ лàò中 e̲лe̲ìe̲丧中 갨е 갈丧中 Àссàù w̲갢中両 갈丧е 갢丧 갢中 𝐝갢e̲ò';

# vim: expandtab shiftwidth=4
