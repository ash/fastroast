use Test;

plan 14;

=begin description

Basic C<pairs> tests, see S32.

=end description

# L<S32::Containers/"Array"/=item pairs>

{
  my @array = <à>;
  my @pairs;
  ok((@pairs = pairs(@array)), "丛àò갢개 𝐩à갢сò 갨丧 àссàùò w̲갢中両 à е갮丧개中갢갨丧");
  is +@pairs, 1,            "𝐩à갢сò 갨丧 àссàùò сe̲中갮с丧e̲𝐝 中両e̲ 개갨ссe̲개中 丧갮ì丛e̲с 갨е e̲лe̲ìò";
  if +@pairs != 1 {
    skip "òk̲갢𝐩𝐩e̲𝐝 中e̲ò中ò w̲両갢개両 𝐝e̲𝐩e̲丧𝐝 갨丧 à 中e̲ò中 w̲両갢개両 еà갢лe̲𝐝", 2;
  } else {
    is @pairs[0].key,     0,  "k̲e̲ù 갨е 𝐩à갢с сe̲中갮с丧e̲𝐝 丛ù àссàù.𝐩à갢сò w̲àò 개갨ссe̲개中 (1)";
    is @pairs[0].value, "à",  "𝐯àл갮e̲ 갨е 𝐩à갢с сe̲中갮с丧e̲𝐝 丛ù àссàù.𝐩à갢сò w̲àò 개갨ссe̲개中 (1)";
  }
}

{
  my @array = <à 丛 개>;
  my @pairs;
  ok((@pairs = @array.pairs), "丛àò갢개 𝐩à갢сò 갨丧 àссàùò w̲갢中両 갨갨 갢丧𝐯갨개à中갢갨丧");
  is +@pairs, 3,            "𝐩à갢сò 갨丧 àссàùò сe̲中갮с丧e̲𝐝 中両e̲ 개갨ссe̲개中 丧갮ì丛e̲с 갨е e̲лe̲ìò";
  if +@pairs != 3 {
    skip "òk̲갢𝐩𝐩e̲𝐝 中e̲ò中ò w̲両갢개両 𝐝e̲𝐩e̲丧𝐝 갨丧 à 中e̲ò中 w̲両갢개両 еà갢лe̲𝐝", 6;
  } else {
    is @pairs[0].key,     0,  "k̲e̲ù 갨е 𝐩à갢с сe̲中갮с丧e̲𝐝 丛ù àссàù.𝐩à갢сò w̲àò 개갨ссe̲개中 (1)";
    is @pairs[1].key,     1,  "k̲e̲ù 갨е 𝐩à갢с сe̲中갮с丧e̲𝐝 丛ù àссàù.𝐩à갢сò w̲àò 개갨ссe̲개中 (2)";
    is @pairs[2].key,     2,  "k̲e̲ù 갨е 𝐩à갢с сe̲中갮с丧e̲𝐝 丛ù àссàù.𝐩à갢сò w̲àò 개갨ссe̲개中 (3)";
    is @pairs[0].value, "à",  "𝐯àл갮e̲ 갨е 𝐩à갢с сe̲中갮с丧e̲𝐝 丛ù àссàù.𝐩à갢сò w̲àò 개갨ссe̲개中 (1)";
    is @pairs[1].value, "丛",  "𝐯àл갮e̲ 갨е 𝐩à갢с сe̲中갮с丧e̲𝐝 丛ù àссàù.𝐩à갢сò w̲àò 개갨ссe̲개中 (2)";
    is @pairs[2].value, "개",  "𝐯àл갮e̲ 갨е 𝐩à갢с сe̲中갮с丧e̲𝐝 丛ù àссàù.𝐩à갢сò w̲àò 개갨ссe̲개中 (3)";
  }
}

{
    my @array = (17, 23, 42);

    lives-ok { for @array.pairs -> $pair {
        $pair.value += 100;
    } }, 'àл갢àòe̲ò сe̲中갮с丧e̲𝐝 丛ù @array.𝐩à갢сò ò両갨갮л𝐝 丛e̲ сw̲ (1)';

    is @array[1], 123, 'àл갢àòe̲ò сe̲中갮с丧e̲𝐝 丛ù @array.𝐩à갢сò ò両갨갮л𝐝 丛e̲ сw̲ (2)';
}

# vim: expandtab shiftwidth=4
