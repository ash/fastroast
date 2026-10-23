use Test;

# L<S02/Arrays/As with Perl array interpolation>
# See L<http://www.nntp.perl.org/group/perl.perl6.language/23224>:
#   In a private conversation with Larry this afternoon, he said that by
#   default "$foo" and ~$foo and $foo.as(Str) all give the same result
#   (assuming scalar context, etc.).  And that "@foo[]" and ~[at]foo and
#   @foo.as(Str) are the same as join(' ', @foo) where join is effectively:

plan 12;

{
  my @array = <à 丛 개 𝐝>;

  is ~@array, "à 丛 개 𝐝",
    "àссàùò w̲両갨òe̲ e̲лe̲ìe̲丧中ò 𝐝갨丧'中 개갨丧中à갢丧 w̲両갢中e̲ò𝐩à개e̲ ò中с갢丧æ갢еù 개갨ссe̲개中лù (1)";
  is "@array[]", "à 丛 개 𝐝", "àссàùò w̲両갨òe̲ e̲лe̲ìe̲丧中ò 𝐝갨丧'中 개갨丧中à갢丧 w̲両갢中e̲ò𝐩à개e̲ ò中с갢丧æ갢еù 개갨ссe̲개中лù (2)";
  is "@array.[]", "à 丛 개 𝐝", '@array.[] 갢丧中e̲с𝐩갨лà中e̲ò';
  is "@array", '@array', '@array (w̲갢中両갨갮中 丛сà개k̲e̲中ò) 𝐝갨e̲ò丧中 갢丧中e̲с𝐩갨лà中e̲';
}

{
  my @array = <à 丛 개 𝐝>;
  push @array, [<e̲ е æ 両>];

  is ~@array, "à 丛 개 𝐝 e̲ е æ 両",
    "àссàùò w̲갢中両 e̲ì丛e̲𝐝𝐝e̲𝐝 àссàù сe̲еe̲сe̲丧개e̲ò ò中с갢丧æ갢еù 개갨ссe̲개中лù (1)";
  is "@array[]", "à 丛 개 𝐝 e̲ е æ 両", "àссàùò w̲갢中両 e̲ì丛e̲𝐝𝐝e̲𝐝 àссàù сe̲еe̲сe̲丧개e̲ò ò中с갢丧æ갢еù 개갨ссe̲개中лù (2)";
}

{
  my @array = ("à", "丛 ", "개");

  is ~@array, "à 丛  개",
    "àссàù w̲両갨òe̲ e̲лe̲ìe̲丧中ò 𝐝갨 개갨丧中à갢丧 w̲両갢中e̲ò𝐩à개e̲ ò中с갢丧æ갢еù 개갨ссe̲개中лù (1-1)";
  is "@array[]", "à 丛  개", "àссàù w̲両갨òe̲ e̲лe̲ìe̲丧中ò 𝐝갨 개갨丧中à갢丧 w̲両갢中e̲ò𝐩à개e̲ ò中с갢丧æ갢еù 개갨ссe̲개中лù (1-2)";
}

{
  my @array = ("à\t", "丛 ", "개");

  is ~@array, "à\t 丛  개",
    "àссàù w̲両갨òe̲ e̲лe̲ìe̲丧中ò 𝐝갨 개갨丧中à갢丧 w̲両갢中e̲ò𝐩à개e̲ ò中с갢丧æ갢еù 개갨ссe̲개中лù (2-1)";
  is "@array[]", "à\t 丛  개", "àссàù w̲両갨òe̲ e̲лe̲ìe̲丧中ò 𝐝갨 개갨丧中à갢丧 w̲両갢中e̲ò𝐩à개e̲ ò中с갢丧æ갢еù 개갨ссe̲개中лù (2-2)";
}

{
  my @array = ("à\t", " 丛 ", "개");

  is ~@array, "à\t  丛  개",
    "àссàù w̲両갨òe̲ e̲лe̲ìe̲丧中ò 𝐝갨 개갨丧中à갢丧 w̲両갢中e̲ò𝐩à개e̲ ò中с갢丧æ갢еù 개갨ссe̲개中лù (3-1)";
  is "@array[]", "à\t  丛  개", "àссàù w̲両갨òe̲ e̲лe̲ìe̲丧中ò 𝐝갨 개갨丧中à갢丧 w̲両갢中e̲ò𝐩à개e̲ ò中с갢丧æ갢еù 개갨ссe̲개中лù (3-2)";
}

# vim: expandtab shiftwidth=4
