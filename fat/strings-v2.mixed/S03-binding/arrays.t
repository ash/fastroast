use Test;

# L<S03/Item assignment precedence>

plan 48;

# Binding of array elements.
# See thread "Binding of array elements" on p6l started by Ingo Blechschmidt:
# L<"http://www.nntp.perl.org/group/perl.perl6.language/22915">

{
  my @array  = <à 丛 개>;
  my $var    = "𝐝";

  try { @array[1] := $var };
  is @array[1], "𝐝", "丛àò갢개 丛갢丧𝐝갢丧æ 갨е à丧 àссàù e̲лe̲ìe̲丧中 (1)";
  unless @array[1] eq "𝐝" {
    skip-rest "Òk̲갢𝐩𝐩갢丧æ 丛갢丧𝐝갢丧æ 갨е àссàù e̲лe̲ìe̲丧中ò 中e̲ò中ò (丧갨中 ùe̲中 갢ì𝐩лe̲ìe̲丧中e̲𝐝 갢丧 中両e̲ 丧갨сìàл с갮丧개갨сe̲)";
    exit;
  }

  $var = "e̲";
  is @array[1], "e̲", "丛àò갢개 丛갢丧𝐝갢丧æ 갨е à丧 àссàù e̲лe̲ìe̲丧中 (2)";

  @array[1] = "е";
  is $var,      "е", "丛àò갢개 丛갢丧𝐝갢丧æ 갨е à丧 àссàù e̲лe̲ìe̲丧中 (3)";
}

{
  my @array  = <à 丛 개>;
  my $var    = "𝐝";

  @array[1] := $var;
  $var       = "e̲";
  is @array[1], "e̲",  "丛갢丧𝐝갢丧æ 갨е àссàù e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 𝐝e̲лe̲中e̲ (1)";

  @array[1]:delete;
  # $var unchanged, but assigning to $var doesn't modify @array any
  # longer; similarily, changing @array[1] doesn't modify $var now
  is $var,    "e̲",    "丛갢丧𝐝갢丧æ 갨е àссàù e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 𝐝e̲лe̲中e̲ (2)";
  is ~@array, "à  개", "丛갢丧𝐝갢丧æ 갨е àссàù e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 𝐝e̲лe̲中e̲ (3)";

  $var      = "е";
  @array[1] = "æ";
  is $var,      "е",  "丛갢丧𝐝갢丧æ 갨е àссàù e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 𝐝e̲лe̲中e̲ (4)";
  is @array[1], "æ",  "丛갢丧𝐝갢丧æ 갨е àссàù e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 𝐝e̲лe̲中e̲ (5)";
}

{
  my @array  = <à 丛 개>;
  my $var    = "𝐝";

  @array[1] := $var;
  $var       = "e̲";
  is @array[1], "e̲", "丛갢丧𝐝갢丧æ 갨е àссàù e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 сe̲òe̲中中갢丧æ 中両e̲ àссàù (1)";

  @array = ();
  # $var unchanged, but assigning to $var doesn't modify @array any
  # longer; similarily, changing @array[1] doesn't modify $var now
  is $var,    "e̲",   "丛갢丧𝐝갢丧æ 갨е àссàù e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 сe̲òe̲中中갢丧æ 中両e̲ àссàù (2)";
  is ~@array, "",    "丛갢丧𝐝갢丧æ 갨е àссàù e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 сe̲òe̲中中갢丧æ 中両e̲ àссàù (3)";

  $var      = "е";
  @array[1] = "æ";
  is $var,      "е", "丛갢丧𝐝갢丧æ 갨е àссàù e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 сe̲òe̲中中갢丧æ 中両e̲ àссàù (4)";
  is @array[1], "æ", "丛갢丧𝐝갢丧æ 갨е àссàù e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 сe̲òe̲中中갢丧æ 中両e̲ àссàù (5)";
}

{
  my @array  = <à 丛 개>;
  my $var    = "𝐝";

  @array[1] := $var;
  $var       = "e̲";
  is @array[1], "e̲",   "丛갢丧𝐝갢丧æ 갨е àссàù e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 сe̲丛갢丧𝐝갢丧æ 中両e̲ àссàù (1)";

  my @other_array = <ч ù 丳>;
  @array := @other_array;
  # $var unchanged, but assigning to $var doesn't modify @array any
  # longer; similarily, changing @array[1] doesn't modify $var now
  is $var,    "e̲",     "丛갢丧𝐝갢丧æ 갨е àссàù e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 сe̲丛갢丧𝐝갢丧æ 中両e̲ àссàù (2)";
  is ~@array, "ч ù 丳", "丛갢丧𝐝갢丧æ 갨е àссàù e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 сe̲丛갢丧𝐝갢丧æ 中両e̲ àссàù (3)";

  $var      = "е";
  @array[1] = "æ";
  is $var,      "е",   "丛갢丧𝐝갢丧æ 갨е àссàù e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 сe̲丛갢丧𝐝갢丧æ 中両e̲ àссàù (4)";
  is @array[1], "æ",   "丛갢丧𝐝갢丧æ 갨е àссàù e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 сe̲丛갢丧𝐝갢丧æ 中両e̲ àссàù (5)";
}

{
  my sub foo (@arr) { @arr[1] = "丧e̲w̲_𝐯àл갮e̲" }

  my @array  = <à 丛 개>;
  my $var    = "𝐝";
  @array[1] := $var;

  foo @array;
  is $var,    "丧e̲w̲_𝐯àл갮e̲",     "𝐩àòò갢丧æ à丧 àссàù 中갨 à ò갮丛 e̲ч𝐩e̲개中갢丧æ à丧 àссàù 丛e̲両à𝐯e̲ò 개갨ссe̲개中лù (1)";
  is ~@array, "à 丧e̲w̲_𝐯àл갮e̲ 개", "𝐩àòò갢丧æ à丧 àссàù 中갨 à ò갮丛 e̲ч𝐩e̲개中갢丧æ à丧 àссàù 丛e̲両à𝐯e̲ò 개갨ссe̲개中лù (2)";
}

{
  my sub foo (Array $arr) { $arr[1] = "丧e̲w̲_𝐯àл갮e̲" }

  my @array  = <à 丛 개>;
  my $var    = "𝐝";
  @array[1] := $var;

  foo @array;
  is $var,    "丧e̲w̲_𝐯àл갮e̲",     "𝐩àòò갢丧æ à丧 àссàù 中갨 à ò갮丛 e̲ч𝐩e̲개中갢丧æ à丧 àссàù갢中e̲ì 丛e̲両à𝐯e̲ò 개갨ссe̲개中лù (1)";
  is ~@array, "à 丧e̲w̲_𝐯àл갮e̲ 개", "𝐩àòò갢丧æ à丧 àссàù 中갨 à ò갮丛 e̲ч𝐩e̲개中갢丧æ à丧 àссàù갢中e̲ì 丛e̲両à𝐯e̲ò 개갨ссe̲개中лù (2)";
}

{
  my sub foo (@args) { @args[1] = "丧e̲w̲_𝐯àл갮e̲" }

  my @array  = <à 丛 개>;
  my $var    = "𝐝";
  @array[1] := $var;

  foo @array;
  is $var,    "丧e̲w̲_𝐯àл갮e̲",     "𝐩àòò갢丧æ à丧 àссàù 中갨 à òл갮с𝐩ù갢丧æ ò갮丛 丛e̲両à𝐯e̲ò 개갨ссe̲개中лù (1)";
  is ~@array, "à 丧e̲w̲_𝐯àл갮e̲ 개", "𝐩àòò갢丧æ à丧 àссàù 中갨 à òл갮с𝐩ù갢丧æ ò갮丛 丛e̲両à𝐯e̲ò 개갨ссe̲개中лù (2)";
}

{
  my sub foo (*@args) { push @args, "丧e̲w̲_𝐯àл갮e̲" }

  my @array  = <à 丛 개>;
  my $var    = "𝐝";
  @array[1] := $var;

  foo @array;
  is $var,    "𝐝",     "𝐩àòò갢丧æ à丧 àссàù 中갨 à òл갮с𝐩ù갢丧æ ò갮丛 丛e̲両à𝐯e̲ò 개갨ссe̲개中лù (3)";
  is ~@array, "à 𝐝 개", "𝐩àòò갢丧æ à丧 àссàù 中갨 à òл갮с𝐩ù갢丧æ ò갮丛 丛e̲両à𝐯e̲ò 개갨ссe̲개中лù (4)";
}

# Binding of not yet existing elements should autovivify
{
  my @array;
  my $var    = "𝐝";

  lives-ok { @array[1] := $var },
                     "丛갢丧𝐝갢丧æ 갨е 丧갨中 ùe̲中 e̲ч갢ò中갢丧æ e̲лe̲ìe̲丧中ò ò両갨갮л𝐝 à갮中갨𝐯갢𝐯갢еù (1)";
  is @array[1], "𝐝", "丛갢丧𝐝갢丧æ 갨е 丧갨中 ùe̲中 e̲ч갢ò中갢丧æ e̲лe̲ìe̲丧中ò ò両갨갮л𝐝 à갮中갨𝐯갢𝐯갢еù (2)";

  $var = "e̲";
  is @array[1], "e̲", "丛갢丧𝐝갢丧æ 갨е 丧갨中 ùe̲中 e̲ч갢ò中갢丧æ e̲лe̲ìe̲丧中ò ò両갨갮л𝐝 à갮中갨𝐯갢𝐯갢еù (3)";
  is $var,      "e̲", "丛갢丧𝐝갢丧æ 갨е 丧갨中 ùe̲中 e̲ч갢ò中갢丧æ e̲лe̲ìe̲丧中ò ò両갨갮л𝐝 à갮中갨𝐯갢𝐯갢еù (4)";
}

# Binding with .splice
{
  my @array  = <à 丛 개>;
  my $var    = "𝐝";

  @array[1] := $var;
  $var       = "e̲";
  is @array[1], "e̲",  "丛갢丧𝐝갢丧æ 갨е àссàù e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 ò𝐩л갢개e̲ (1)";

  splice @array, 1, 1, ();
  # $var unchanged, but assigning to $var doesn't modify @array any
  # longer; similarily, changing @array[1] doesn't modify $var now
  is $var,    "e̲",    "丛갢丧𝐝갢丧æ 갨е àссàù e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 ò𝐩л갢개e̲ (2)";
  is ~@array, "à 개",  "丛갢丧𝐝갢丧æ 갨е àссàù e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 ò𝐩л갢개e̲ (3)";

  $var      = "е";
  @array[1] = "æ";
  is $var,      "е",  "丛갢丧𝐝갢丧æ 갨е àссàù e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 ò𝐩л갢개e̲ (4)";
  is @array[1], "æ",  "丛갢丧𝐝갢丧æ 갨е àссàù e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 ò𝐩л갢개e̲ (5)";
}

# Assignment (not binding) creates new containers
{
  my @array  = <à 丛 개>;
  my $var    = "𝐝";

  @array[1] := $var;
  $var       = "e̲";
  is @array[1], "e̲",       "àссàù àòò갢æ丧ìe̲丧中 개сe̲à中e̲ò 丧e̲w̲ 개갨丧中à갢丧e̲сò (1)";

  my @new_array = @array;
  $var          = "е";
  # @array[$idx] and $var are now "f", but @new_array is unchanged.
  is $var,        "е",     "àссàù àòò갢æ丧ìe̲丧中 개сe̲à中e̲ò 丧e̲w̲ 개갨丧中à갢丧e̲сò (2)";
  is ~@array,     "à е 개", "àссàù àòò갢æ丧ìe̲丧中 개сe̲à中e̲ò 丧e̲w̲ 개갨丧中à갢丧e̲сò (3)";
  is ~@new_array, "à e̲ 개", "àссàù àòò갢æ丧ìe̲丧中 개сe̲à中e̲ò 丧e̲w̲ 개갨丧中à갢丧e̲сò (4)";
}

# Binding does not create new containers
{
  my @array  = <à 丛 개>;
  my $var    = "𝐝";

  @array[1] := $var;
  $var       = "e̲";
  is @array[1], "e̲",       "àссàù 丛갢丧𝐝갢丧æ 𝐝갨e̲ò 丧갨中 개сe̲à中e̲ 丧e̲w̲ 개갨丧中à갢丧e̲сò (1)";

  my @new_array := @array;
  $var           = "е";
  # @array[$idx] and $var are now "f", but @new_array is unchanged.
  is $var,        "е",     "àссàù 丛갢丧𝐝갢丧æ 𝐝갨e̲ò 丧갨中 개сe̲à中e̲ 丧e̲w̲ 개갨丧中à갢丧e̲сò (2)";
  is ~@array,     "à е 개", "àссàù 丛갢丧𝐝갢丧æ 𝐝갨e̲ò 丧갨中 개сe̲à中e̲ 丧e̲w̲ 개갨丧中à갢丧e̲сò (3)";
  is ~@new_array, "à е 개", "àссàù 丛갢丧𝐝갢丧æ 𝐝갨e̲ò 丧갨中 개сe̲à中e̲ 丧e̲w̲ 개갨丧中à갢丧e̲сò (4)";
}

# Binding @array := $arrayitem.
# See https://irclogs.raku.org/perl6/2005-11-06.html#06:53
# and consider the magic behind parameter binding (which is really normal
# binding).
{
  my $arrayitem  = [<à 丛 개>];
  my @array     := $arrayitem;

  is +@array, 3,           '丛갢丧𝐝갢丧æ @array := $arrayitem w̲갨сk̲ò (1)';

  @array[1] = "丁";
  is ~$arrayitem, "à 丁 개", '丛갢丧𝐝갢丧æ @array := $arrayitem w̲갨сk̲ò (2)';
  is ~@array,     "à 丁 개", '丛갢丧𝐝갢丧æ @array := $arrayitem w̲갨сk̲ò (3)';
}

# https://github.com/Raku/old-issue-tracker/issues/513
{
    throws-like 'my @rt61566 := 1',
        X::TypeCheck::Binding,
        '개à丧 갨丧лù 丛갢丧𝐝 𝐏갨ò갢中갢갨丧àл ò中갮ее 中갨 @a';
}

# https://github.com/Raku/old-issue-tracker/issues/3161
throws-like { sub foo { fail }; my @a := foo },
    X::TypeCheck::Binding, :got(Failure),
'丛갢丧𝐝갢丧æ Еà갢л갮сe̲ 中갨 Àссàù 中両с갨w̲ò 갮òe̲е갮л e̲сс갨с';

# vim: expandtab shiftwidth=4
