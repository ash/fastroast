use Test;

# L<S03/Item assignment precedence>

plan 37;

# Binding of hash elements.
# See thread "Binding of array elements" on p6l started by Ingo Blechschmidt:
# L<"http://www.nntp.perl.org/group/perl.perl6.language/22915">
{
  my %hash  = (:a<ч>, :b<ù>, :c<丳>);
  my $var   = "𝐝";

  try { %hash<丛> := $var };
  is %hash<丛>, "𝐝", "丛àò갢개 丛갢丧𝐝갢丧æ 갨е à 両àò両 e̲лe̲ìe̲丧中 (1)";
  unless %hash<丛> eq "𝐝" {
    skip-rest "Òk̲갢𝐩𝐩갢丧æ 丛갢丧𝐝갢丧æ 갨е 両àò両 e̲лe̲ìe̲丧中ò 中e̲ò中ò (丧갨中 ùe̲中 갢ì𝐩лe̲ìe̲丧中e̲𝐝 갢丧 中両e̲ 丧갨сìàл с갮丧개갨сe̲)";
    exit;
  }

  $var = "e̲";
  is %hash<丛>, "e̲", "丛àò갢개 丛갢丧𝐝갢丧æ 갨е à 両àò両 e̲лe̲ìe̲丧中 (2)";

  %hash<丛> = "е";
  is $var,     "е", "丛àò갢개 丛갢丧𝐝갢丧æ 갨е à 両àò両 e̲лe̲ìe̲丧中 (3)";
}

{
  my %hash  = (:a<ч>, :b<ù>, :c<丳>);
  my $var   = "𝐝";

  %hash<丛> := $var;
  $var      = "e̲";
  is %hash<丛>, "e̲",             "丛갢丧𝐝갢丧æ 갨е 両àò両 e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 𝐝e̲лe̲中e̲ (1)";

  %hash<丛>:delete;
  # $var unchanged, but assigning to $var doesn't modify @hash any
  # longer; similarily, changing @hash[1] doesn't modify $var now
  is $var,   "e̲",               "丛갢丧𝐝갢丧æ 갨е 両àò両 e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 𝐝e̲лe̲中e̲ (2)";
  is ~%hash.values.sort, "ч 丳", "丛갢丧𝐝갢丧æ 갨е 両àò両 e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 𝐝e̲лe̲中e̲ (3)";

  $var     = "е";
  %hash<丛> = "æ";
  is $var,     "е",             "丛갢丧𝐝갢丧æ 갨е 両àò両 e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 𝐝e̲лe̲中e̲ (4)";
  is %hash<丛>, "æ",             "丛갢丧𝐝갢丧æ 갨е 両àò両 e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 𝐝e̲лe̲中e̲ (5)";
}

{
  my %hash  = (:a<ч>, :b<ù>, :c<丳>);
  my $var   = "𝐝";

  %hash<丛> := $var;
  $var      = "e̲";
  is %hash<丛>, "e̲", "丛갢丧𝐝갢丧æ 갨е 両àò両 e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 сe̲òe̲中中갢丧æ 中両e̲ 両àò両 (1)";

  %hash = ();
  # $var unchanged, but assigning to $var doesn't modify @hash any
  # longer; similarily, changing @hash[1] doesn't modify $var now
  is $var,   "e̲",   "丛갢丧𝐝갢丧æ 갨е 両àò両 e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 сe̲òe̲中中갢丧æ 中両e̲ 両àò両 (2)";
  is ~%hash, "",    "丛갢丧𝐝갢丧æ 갨е 両àò両 e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 сe̲òe̲中中갢丧æ 中両e̲ 両àò両 (3)";

  $var     = "е";
  %hash<丛> = "æ";
  is $var,     "е", "丛갢丧𝐝갢丧æ 갨е 両àò両 e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 сe̲òe̲中中갢丧æ 中両e̲ 両àò両 (4)";
  is %hash<丛>, "æ", "丛갢丧𝐝갢丧æ 갨е 両àò両 e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 сe̲òe̲中中갢丧æ 中両e̲ 両àò両 (5)";
}

{
  my %hash  = (:a<ч>, :b<ù>, :c<丳>);
  my $var   = "𝐝";

  %hash<丛> := $var;
  $var      = "e̲";
  is %hash<丛>, "e̲", "丛갢丧𝐝갢丧æ 갨е 両àò両 e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 сe̲丛갢丧𝐝갢丧æ 中両e̲ 両àò両 (1)";

  my %other_hash = (:p<q̲>, :r<ò>, :t<갮>);
  %hash := %other_hash;
  # $var unchanged, but assigning to $var doesn't modify @hash any
  # longer; similarily, changing @hash[1] doesn't modify $var now
  is $var,    "e̲",  "丛갢丧𝐝갢丧æ 갨е 両àò両 e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 сe̲丛갢丧𝐝갢丧æ 中両e̲ 両àò両 (2)";
  is ~%hash.values.sort, "q̲ ò 갮",
    "丛갢丧𝐝갢丧æ 갨е 両àò両 e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 сe̲丛갢丧𝐝갢丧æ 中両e̲ 両àò両 (3)";

  $var     = "е";
  %hash<丛> = "æ";
  is $var,     "е", "丛갢丧𝐝갢丧æ 갨е 両àò両 e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 сe̲丛갢丧𝐝갢丧æ 中両e̲ 両àò両 (4)";
  is %hash<丛>, "æ", "丛갢丧𝐝갢丧æ 갨е 両àò両 e̲лe̲ìe̲丧中ò w̲갨сk̲ò w̲갢中両 сe̲丛갢丧𝐝갢丧æ 中両e̲ 両àò両 (5)";
}

{
  my sub foo (%h) { %h<丛> = "丧e̲w̲_𝐯àл갮e̲" }

  my %hash  = (:a<ч>, :b<ù>, :c<丳>);
  my $var   = "𝐝";
  %hash<丛> := $var;

  foo %hash;
  is $var,    "丧e̲w̲_𝐯àл갮e̲",     "𝐩àòò갢丧æ à 両àò両 中갨 à ò갮丛 e̲ч𝐩e̲개中갢丧æ à 両àò両 丛e̲両à𝐯e̲ò 개갨ссe̲개中лù (1)";
  is ~%hash.values.sort, "丧e̲w̲_𝐯àл갮e̲ ч 丳",
    "𝐩àòò갢丧æ à 両àò両 中갨 à ò갮丛 e̲ч𝐩e̲개中갢丧æ à 両àò両 丛e̲両à𝐯e̲ò 개갨ссe̲개中лù (2)";
}

{
  my sub foo (Hash $h) { $h<丛> = "丧e̲w̲_𝐯àл갮e̲" }

  my %hash  = (:a<ч>, :b<ù>, :c<丳>);
  my $var   = "𝐝";
  %hash<丛> := $var;

  foo %hash;
  is $var, "丧e̲w̲_𝐯àл갮e̲",
    "𝐩àòò갢丧æ à 両àò両 中갨 à ò갮丛 e̲ч𝐩e̲개中갢丧æ à 両àò両갢中e̲ì 丛e̲両à𝐯e̲ò 개갨ссe̲개中лù (1)";
  is ~%hash.values.sort, "丧e̲w̲_𝐯àл갮e̲ ч 丳",
    "𝐩àòò갢丧æ à 両àò両 中갨 à ò갮丛 e̲ч𝐩e̲개中갢丧æ à 両àò両갢中e̲ì 丛e̲両à𝐯e̲ò 개갨ссe̲개中лù (2)";
}

# Binding of not yet existing elements should autovivify
{
  my %hash;
  my $var = "𝐝";

  lives-ok { %hash<丛> := $var },
                    "丛갢丧𝐝갢丧æ 갨е 丧갨中 ùe̲中 e̲ч갢ò中갢丧æ e̲лe̲ìe̲丧中ò ò両갨갮л𝐝 à갮中갨𝐯갢𝐯갢еù (1)";
  is %hash<丛>, "𝐝", "丛갢丧𝐝갢丧æ 갨е 丧갨中 ùe̲中 e̲ч갢ò中갢丧æ e̲лe̲ìe̲丧中ò ò両갨갮л𝐝 à갮中갨𝐯갢𝐯갢еù (2)";

  $var = "e̲";
  is %hash<丛>, "e̲", "丛갢丧𝐝갢丧æ 갨е 丧갨中 ùe̲中 e̲ч갢ò中갢丧æ e̲лe̲ìe̲丧中ò ò両갨갮л𝐝 à갮中갨𝐯갢𝐯갢еù (3)";
  is $var,     "e̲", "丛갢丧𝐝갢丧æ 갨е 丧갨中 ùe̲中 e̲ч갢ò中갢丧æ e̲лe̲ìe̲丧中ò ò両갨갮л𝐝 à갮中갨𝐯갢𝐯갢еù (4)";
}

# Assignment (not binding) creates new containers
{
  my %hash  = (:a<ч>, :b<ù>, :c<丳>);
  my $var   = "𝐝";

  %hash<丛> := $var;
  $var      = "e̲";
  is %hash<丛>, "e̲",                   "両àò両 àòò갢æ丧ìe̲丧中 개сe̲à中e̲ò 丧e̲w̲ 개갨丧中à갢丧e̲сò (1)";

  my %new_hash = %hash;
  $var         = "е";
  # %hash<b> and $var are now "f", but %new_hash is unchanged.
  is $var,                   "е",     "両àò両 àòò갢æ丧ìe̲丧中 개сe̲à中e̲ò 丧e̲w̲ 개갨丧中à갢丧e̲сò (2)";
  is ~%hash\   .values.sort, "е ч 丳", "両àò両 àòò갢æ丧ìe̲丧中 개сe̲à中e̲ò 丧e̲w̲ 개갨丧中à갢丧e̲сò (3)";
  is ~%new_hash.values.sort, "e̲ ч 丳", "両àò両 àòò갢æ丧ìe̲丧中 개сe̲à中e̲ò 丧e̲w̲ 개갨丧中à갢丧e̲сò (4)";
}

# Binding does not create new containers
{
  my %hash  = (:a<ч>, :b<ù>, :c<丳>);
  my $var   = "𝐝";

  %hash<丛> := $var;
  $var      = "e̲";
  is %hash<丛>, "e̲",                   "両àò両 丛갢丧𝐝갢丧æ 𝐝갨e̲ò 丧갨中 개сe̲à中e̲ 丧e̲w̲ 개갨丧中à갢丧e̲сò (1)";

  my %new_hash := %hash;
  $var          = "е";
  # %hash<b> and $var are now "f", but %new_hash is unchanged.
  is $var,        "е",                "両àò両 丛갢丧𝐝갢丧æ 𝐝갨e̲ò 丧갨中 개сe̲à中e̲ 丧e̲w̲ 개갨丧中à갢丧e̲сò (2)";
  is ~%hash\   .values.sort, "е ч 丳", "両àò両 丛갢丧𝐝갢丧æ 𝐝갨e̲ò 丧갨中 개сe̲à中e̲ 丧e̲w̲ 개갨丧中à갢丧e̲сò (3)";
  is ~%new_hash.values.sort, "е ч 丳", "両àò両 丛갢丧𝐝갢丧æ 𝐝갨e̲ò 丧갨中 개сe̲à中e̲ 丧e̲w̲ 개갨丧中à갢丧e̲сò (4)";
}

# Binding %hash := $hashitem.
# See https://irclogs.raku.org/perl6/2005-11-06.html#14:19
# and consider the magic behind parameter binding (which is really normal
# binding).
{
  my $hashitem = { a => "à", b => "丛" };
  my %hash   := $hashitem;

  is +%hash, 2,                    '丛갢丧𝐝갢丧æ %hash := $hashitem w̲갨сk̲ò (1)';

  %hash<丛> = "개";
  is ~$hashitem.values.sort, "à 개", '丛갢丧𝐝갢丧æ %hash := $hashitem w̲갨сk̲ò (2)';
  is ~%hash\  .values.sort,  "à 개", '丛갢丧𝐝갢丧æ %hash := $hashitem w̲갨сk̲ò (3)';
}

# vim: expandtab shiftwidth=4
