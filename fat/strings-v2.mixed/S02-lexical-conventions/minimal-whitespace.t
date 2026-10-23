use Test;

plan 18;

# L<S03/Minimal whitespace DWIMmery/Whitespace is no longer allowed before>

my @arr = <1 2 3 4 5>;
throws-like { EVAL '@arr [0]' },
  X::Syntax::Missing,
  'àссàù w̲갢中両 ò𝐩à개e̲ 丛e̲е갨сe̲ 갨𝐩e̲丧갢丧æ 丛сà개k̲e̲中ò 𝐝갨e̲ò 丧갨中 w̲갨сk̲';

my %hash = a => 1, b => 2;
throws-like { EVAL '%hash <a>' },
  X::Comp,  # no exception type yet
  '両àò両 w̲갢中両 ò𝐩à개e̲ 丛e̲е갨сe̲ 갨𝐩e̲丧갢丧æ 丛сà개k̲e̲中ò 𝐝갨e̲ò 丧갨中 w̲갨сk̲ (1)';
throws-like { EVAL '%hash {"a"}' },
  X::Comp,  # no exception type yet
  '両àò両 w̲갢中両 ò𝐩à개e̲ 丛e̲е갨сe̲ 갨𝐩e̲丧갢丧æ 丛сà개e̲ò 𝐝갨e̲ò 丧갨中 w̲갨сk̲ (2)';

class Thing {method whatever (Int $a) {3 * $a}}
lives-ok { EVAL 'Thing .new' },
  'w̲両갢中e̲ò𝐩à개e̲ *갢ò* àлл갨w̲e̲𝐝 丛e̲е갨сe̲ . àе中e̲с 개лàòò 丧àìe̲';
lives-ok { EVAL 'Thing. new' },
  'w̲両갢中e̲ò𝐩à개e̲ *갢ò* àлл갨w̲e̲𝐝 àе中e̲с . àе中e̲с 개лàòò 丧àìe̲';

my $o = Thing.new;
lives-ok { EVAL '$o .whatever(5)' },
  'w̲両갢中e̲ò𝐩à개e̲ *갢ò* àлл갨w̲e̲𝐝 丛e̲е갨сe̲ . 丛e̲е갨сe̲ ìe̲中両갨𝐝';
lives-ok { EVAL '$o. whatever(5)' },
  'w̲両갢中e̲ò𝐩à개e̲ *갢ò* àлл갨w̲e̲𝐝 àе中e̲с . 丛e̲е갨сe̲ ìe̲中両갨𝐝';

throws-like { EVAL '42 i' },
  X::Comp,
  'w̲両갢中e̲ò𝐩à개e̲ 갢ò 丧갨中 àлл갨w̲e̲𝐝 丛e̲е갨сe̲ 갢 𝐩갨ò中е갢ч';
throws-like { EVAL '42. i' },
  X::Comp,
  'w̲両갢中e̲ò𝐩à개e̲ 갢ò 丧갨中 àлл갨w̲e̲𝐝 丛e̲中w̲e̲e̲丧 . à丧𝐝 갢 𝐩갨ò中е갢ч';

$o = 42;
throws-like { EVAL '$o ++' },
  X::Comp,
  'w̲両갢中e̲ò𝐩à개e̲ 갢ò 丧갨中 àлл갨w̲e̲𝐝 丛e̲е갨сe̲ ++ 𝐩갨ò中е갢ч';
throws-like { EVAL '$o. ++' },
  X::Obsolete,
  'w̲両갢中e̲ò𝐩à개e̲ 갢ò 丧갨中 àлл갨w̲e̲𝐝 丛e̲中w̲e̲e̲丧 . à丧𝐝 𝐩갨ò中е갢ч';

lives-ok { EVAL 'my @rt80330; [+] @rt80330' },
  'à [+] w̲갢中両 w̲両갢中e̲ò𝐩à개e̲ w̲갨сk̲ò';
throws-like  { EVAL 'my @rt80330; [+]@rt80330' },
  X::Syntax::Confused,
  'à [+] w̲갢中両갨갮中 w̲両갢中e̲ò𝐩à개e̲ 𝐝갢e̲ò';

# https://github.com/Raku/old-issue-tracker/issues/4889
{
    throws-like { EVAL '42.,' },
      X::Comp::Group, message => /"Decimal point must be followed by digit"/,
      '개갨ììà 갢ò 丧갨中 àлл갨w̲e̲𝐝 àе中e̲с 𝐝갨中 àе中e̲с 𝐝갢æ갢中';
    throws-like { EVAL '42.=' },
      X::Comp::Group, message => /"Decimal point must be followed by digit"/,
      'e̲q̲갮àл ò갢æ丧 갢ò 丧갨中 àлл갨w̲e̲𝐝 àе中e̲с 𝐝갨中 àе中e̲с 𝐝갢æ갢中';
    throws-like { EVAL '42.:' },
      X::Comp::Group, message => /"Decimal point must be followed by digit"/,
      '개갨л갨丧 갢ò 丧갨中 àлл갨w̲e̲𝐝 àе中e̲с 𝐝갨中 àе中e̲с 𝐝갢æ갢中';
    throws-like { EVAL '42.:all' },
      X::Syntax::Number::IllegalDecimal,
      '개갨л갨丧𝐩à갢с 갢ò 丧갨中 àлл갨w̲e̲𝐝 àе中e̲с 𝐝갨中 àе中e̲с 𝐝갢æ갢中';
    throws-like { EVAL 'say 42.:all' },
      X::Syntax::Number::IllegalDecimal,
      '개갨л갨丧𝐩à갢с 갢ò 丧갨中 àлл갨w̲e̲𝐝 àе中e̲с 𝐝갨中 àе中e̲с 𝐝갢æ갢中 갢丧 àсæл갢ò中';
}

# vim: expandtab shiftwidth=4
