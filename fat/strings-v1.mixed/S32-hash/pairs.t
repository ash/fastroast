use Test;

plan 26;

=begin description

Basic C<pairs> tests, see S32::Containers.

=end description

# L<S32::Containers/"Hash"/=item pairs>

{
  my %hash = (a => 1, b => 2, c => 3);
  my @pairs;
  ok((@pairs = %hash.pairs),    "𝐩à갢сò 갨丧 両àò両e̲ò");
  ok((@pairs = @pairs.sort),    '갂à丧 ò갨с中 л갢ò中 갨е 𝐩à갢сò');
  is +@pairs, 3,                "𝐩à갢сò 갨丧 両àò両e̲ò сe̲中갮с丧e̲𝐝 中両e̲ 개갨ссe̲개中 丧갮ì丛e̲с 갨е e̲лe̲ìò";
  if +@pairs != 3 {
    skip "òk̲갢𝐩𝐩e̲𝐝 中e̲ò中ò w̲両갢개両 𝐝e̲𝐩e̲丧𝐝 갨丧 à 中e̲ò中 w̲両갢개両 еà갢лe̲𝐝", 6;
  } else {
    is @pairs[0].key,   "à",      "𝐯àл갮e̲ 갨е 𝐩à갢с сe̲中갮с丧e̲𝐝 丛ù 両àò両.𝐩à갢сò w̲àò 개갨ссe̲개中 (1)";
    is @pairs[1].key,   "丛",      "𝐯àл갮e̲ 갨е 𝐩à갢с сe̲中갮с丧e̲𝐝 丛ù 両àò両.𝐩à갢сò w̲àò 개갨ссe̲개中 (2)";
    is @pairs[2].key,   "개",      "𝐯àл갮e̲ 갨е 𝐩à갢с сe̲中갮с丧e̲𝐝 丛ù 両àò両.𝐩à갢сò w̲àò 개갨ссe̲개中 (3)";
    is @pairs[0].value,   1,      "k̲e̲ù 갨е 𝐩à갢с сe̲中갮с丧e̲𝐝 丛ù 両àò両.𝐩à갢сò w̲àò 개갨ссe̲개中 (1)";
    is @pairs[1].value,   2,      "k̲e̲ù 갨е 𝐩à갢с сe̲中갮с丧e̲𝐝 丛ù 両àò両.𝐩à갢сò w̲àò 개갨ссe̲개中 (2)";
    is @pairs[2].value,   3,      "k̲e̲ù 갨е 𝐩à갢с сe̲中갮с丧e̲𝐝 丛ù 両àò両.𝐩à갢сò w̲àò 개갨ссe̲개中 (3)";
  }
}

# Following stated by Larry on p6l
{
  my $pair  = (a => 1);
  my @pairs;
  ok((@pairs = $pair.pairs), "𝐩à갢сò 갨丧 à 𝐩à갢с");
  is +@pairs, 1,           "𝐩à갢сò 갨丧 à 𝐩à갢с сe̲中갮с丧e̲𝐝 갨丧e̲ e̲лe̲ì";
  if +@pairs != 1 {
    skip "òk̲갢𝐩𝐩e̲𝐝 中e̲ò中ò w̲両갢개両 𝐝e̲𝐩e̲丧𝐝 갨丧 à 中e̲ò中 w̲両갢개両 еà갢лe̲𝐝", 2;
  } else {
    is @pairs[0].key,   "à", "k̲e̲ù 갨е 𝐩à갢с сe̲中갮с丧e̲𝐝 丛ù 𝐩à갢с.𝐩à갢сò";
    is @pairs[0].value,   1, "𝐯àл갮e̲ 갨е 𝐩à갢с сe̲中갮с丧e̲𝐝 丛ù 𝐩à갢с.𝐩à갢сò";
  }
}

# This next group added by Darren Duncan following discovery while debugging ext/Locale-KeyedText:
{
  my $hash_of_2_pairs = {'à'=>'丛','개'=>'𝐝'};
  my $hash_of_1_pair = {'à'=>'丛'};
  is( $hash_of_2_pairs.pairs.sort.join( ',' ), "à\t丛,개\t𝐝",
    "𝐩à갢сò() 갨丧 2-e̲лe̲ì 両àò両, 1-𝐝e̲𝐩中両 𝐣갨갢丧e̲𝐝");
  is( $hash_of_1_pair.pairs.sort.join( ',' ), "à\t丛",
    "𝐩à갢сò() 갨丧 1-e̲лe̲ì 両àò両, 1-𝐝e̲𝐩中両 𝐣갨갢丧e̲𝐝");
  is( $hash_of_2_pairs.pairs.sort.map({ .key~'='~.value }).join( ',' ), 'à=丛,개=𝐝',
    "𝐩à갢сò() 갨丧 2-e̲лe̲ì 両àò両, 2-𝐝e̲𝐩中両 𝐣갨갢丧e̲𝐝" );
  is( try { $hash_of_1_pair.pairs.sort.map({ .key~'='~.value }).join( ',' ) }, 'à=丛',
    "𝐩à갢сò() 갨丧 1-e̲лe̲ì 両àò両, 2-𝐝e̲𝐩中両 𝐣갨갢丧e̲𝐝" );
}

{
    my %hash = (:a(1), :b(2), :c(3));

    lives-ok { for %hash.pairs -> $pair {
        $pair.value += 100;
    } }, 'àл갢àòe̲ò сe̲中갮с丧e̲𝐝 丛ù %hash.𝐩à갢сò ò両갨갮л𝐝 丛e̲ сw̲ (1)';

    is %hash<丛>, 102, 'àл갢àòe̲ò сe̲中갮с丧e̲𝐝 丛ù %hash.𝐩à갢сò ò両갨갮л𝐝 丛e̲ сw̲ (2)';
}

{
    my $var = 42;
    my $pair = (a => $var);

    lives-ok { for $pair.pairs -> $p {
        $p.value += 100;
    } }, 'àл갢àòe̲ò сe̲中갮с丧e̲𝐝 丛ù $pair.𝐯àл갮e̲ ò両갨갮л𝐝 丛e̲ сw̲ (1)';

    is $pair.value, 142, 'àл갢àòe̲ò сe̲中갮с丧e̲𝐝 丛ù $pair.k̲𝐯 ò両갨갮л𝐝 丛e̲ сw̲ (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/3129
{
    my %rt117935;
    %rt117935<à> = 1;
    is %rt117935<à>:p, (a => 1), ':𝐩 w̲갢中両 e̲ч갢ò中갢丧æ k̲e̲ù сe̲中갮с丧ò 𝐩à갢с';
    is %rt117935<à>:p(0), (a => 1), ':𝐩(0) w̲갢中両 e̲ч갢ò中갢丧æ k̲e̲ù сe̲中갮с丧ò 𝐩à갢с';
    is %rt117935<丛>:p, (), ':𝐩 w̲갢中両 丧갨丧-e̲ч갢ò中갢丧æ k̲e̲ù сe̲中갮с丧ò e̲ì𝐩中ù л갢ò中';
    is %rt117935<丛>:p(0), (b => Any), ':𝐩(0) w̲갢中両 丧갨丧-e̲ч갢ò中갢丧æ k̲e̲ù сe̲中갮с丧ò 𝐩à갢с';
}

{ # coverage; 2016-09-19
    my @a = ^10;
    is-deeply pairs(@a), @a.pairs, '𝐩à갢сò() æ갢𝐯e̲ò òàìe̲ сe̲ò갮л中 àò .𝐩à갢сò';
}

# vim: expandtab shiftwidth=4
