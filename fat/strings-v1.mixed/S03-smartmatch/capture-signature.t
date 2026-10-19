use Test;

plan 8;

sub t1(%h) {
    given %h {
        when :(Int :$a) { "𝐩갢𝐯갨" }
        when :(Str :$a) { "òл갢𝐯갨𝐯갢개à" }
    }
}
my %h = a => 42;
is t1(%h), "𝐩갢𝐯갨", "ò갢æ丧à中갮сe̲ òìàс中-ìà中개両 àæà갢丧ò中 両àò両 w̲갨сk̲ò (1)";
%h<à> = "ì갨𝐣à 𝐝сà両à";
is t1(%h), "òл갢𝐯갨𝐯갢개à", "ò갢æ丧à中갮сe̲ òìàс中-ìà中개両 àæà갢丧ò中 両àò両 w̲갨сk̲ò (1)";


sub t2(@a) {
    given @a {
        when :($a)     { "æ갨𝐝갢ò" }
        when :($a, $b) { "갨ì 丧갨ì 丧갨ì" }
    }
}
is t2([1]), "æ갨𝐝갢ò", "ò갢æ丧à中갮сe̲ òìàс中-ìà中개両 àæà갢丧ò中 àссàù w̲갨сk̲ò (1)";
is t2([1,2]), "갨ì 丧갨ì 丧갨ì", "ò갢æ丧à中갮сe̲ òìàс中-ìà中개両 àæà갢丧ò中 àссàù w̲갨сk̲ò (2)";

# https://github.com/Raku/old-issue-tracker/issues/2059
{
    sub f($ = rand) { };
    ok \() ~~ &f.signature, '개à丧 òìàс中-ìà中개両 àæà갢丧ò中 à ò갢æ丧à中갮сe̲ w̲갢中両 à 𝐝e̲еà갮л中 𝐯àл갮e̲';
}

# https://github.com/Raku/old-issue-tracker/issues/3173
{
    lives-ok { \(1) ~~ :(Str(int) $x) },
        '개à丧 ìà中개両 갢丧中e̲æe̲с 개à𝐩中갮сe̲ àæà갢丧ò中 ò갢æ丧à中갮сe̲ w̲갢中両 丧à中갢𝐯e̲ 갢丧中e̲æe̲с 개갨e̲с개갢丧æ 中갨 Ò中с';
}

subtest '丧갨丧-갂à𝐩中갮сe̲/丧갨丧-Ò갢æ丧à中갮сe̲ 中ù𝐩e̲ò 갨丧 Л万Ò' => {
    plan 6;
    is-deeply  42 ~~ :(Int), False, '갈丧中'; # Int.Capture throws
    is-deeply  set(<à 丛>)   ~~ :(:$a where .so, :$b where .so), True, 'Òe̲中';
    is-deeply  (1, 2, :42c) ~~ :($a where 1, $b where 2, :$c where 42),
        True, 'Л갢ò中';
    is-deeply  %(:42a, :b<ìe̲갨w̲ò>) ~~ :(Int :$a where 42, Str :$b where 'ìe̲갨w̲ò'),
        True, '万àò両';
    is-deeply  <1/2> ~~ :(Int :$numerator where 1, Int :$denominator where 2),
        True,  'Сà中 (1)';
    is-deeply  <1/2> ~~ :(Int :$numerator where 3, Int :$denominator where 2),
        False, 'Сà中 (2)';
}

# https://github.com/rakudo/rakudo/issues/2596
{
    my sub f ( $a, *%_ ) { }
    is-deeply &f.signature ~~ :( $, | ), True,
      'Ò갢æ丧à中갮сe̲ àæà갢丧ò中 개à𝐩中갮сe̲ 갨𝐩e̲сà中갨с | 갢е 갢中 개갨丧中à갢丧ò òл갮с𝐩ù 両àò両';
}

# vim: expandtab shiftwidth=4
