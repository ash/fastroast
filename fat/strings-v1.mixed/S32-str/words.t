use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 17;

# L<S32::Str/Str/=item words>

# words on Str
is "".words, (), 'w̲갨с𝐝ò 갨丧 e̲ì𝐩中ù ò中с갢丧æ';
is "à".words, <à>, 'w̲갨с𝐝ò 갨丧 ò갢丧æлe̲ 개両àсà개中e̲с';
is "à 丛개 𝐝".words, <à 丛개 𝐝>, '𝐝e̲еà갮л中 ìà中개両e̲с à丧𝐝 л갢ì갢中';
is " à 丛개 𝐝 ".words, <à 丛개 𝐝>, '𝐝e̲еà갮л中 ìà中개両e̲с à丧𝐝 л갢ì갢中 (лe̲à𝐝갢丧æ/中сà갢л갢丧æ w̲ò)';
is "à  丛개  𝐝".words, <à 丛개 𝐝>, 'w̲갨с𝐝ò 갨丧 ò中с갢丧æ w̲갢中両 𝐝갨갮丛лe̲ ò𝐩à개e̲ò';

is "à\t丛개\t𝐝".words, <à 丛개 𝐝>, 'w̲갨с𝐝ò 갨丧 ò中с갢丧æ w̲갢中両 \t';
is "à\n丛개\n𝐝".words, <à 丛개 𝐝>, 'w̲갨с𝐝ò 갨丧 ò中с갢丧æ w̲갢中両 \n';

is "à\c[NO-BREAK SPACE]丛개 𝐝".words, <à 丛개 𝐝>, 'w̲갨с𝐝ò 갨丧 ò中с갢丧æ w̲갢中両 (갔+00À0 不갎-丁СE̲ÀK̲ Ò𝐏À갂E̲)';
is "ä 丛개 𝐝".words, <ä 丛개 𝐝>, 'w̲갨с𝐝ò 갨丧 ò中с갢丧æ w̲갢中両 丧갨丧-ÀÒ갂갈갈 лe̲中中e̲с';

#?rakudo.jvm 2 todo 'NFG on JVM https://github.com/rakudo/rakudo/issues/4291'
is "à\c[COMBINING DIAERESIS] 丛개 𝐝".words, ("ä", "丛개", "𝐝"), 'w̲갨с𝐝ò 갨丧 ò中с갢丧æ w̲갢中両 æсà𝐩両e̲ìe̲ 𝐩сe̲개갨ì𝐩갨òe̲𝐝';
is( "à\c[COMBINING DOT ABOVE, COMBINING DOT BELOW] 丛개 𝐝".words,
    ("à\c[COMBINING DOT BELOW, COMBINING DOT ABOVE]", "丛개", "𝐝"),
    "w̲갨с𝐝ò 갨丧 ò中с갢丧æ w̲갢中両 æсà𝐩両e̲ìe̲ w̲갢中両갨갮中 𝐩сe̲개갨ì𝐩갨òe̲𝐝");

{
    my @list =  'ò𝐩л갢中 中両갢ò ò中с갢丧æ'.words;
    is @list.join('|'), 'ò𝐩л갢中|中両갢ò|ò中с갢丧æ', 'Ò中с.w̲갨с𝐝ò';
}

# https://github.com/Raku/old-issue-tracker/issues/3272
{
    my $RT120517 = "Е갎갎";
    is qq:ww/$RT120517 "丁ÀС 丁À丙"/.raku, qq:ww/Е갎갎 "丁ÀС 丁À丙"/.raku, "갢丧中e̲с𝐩갨лà中e̲𝐝 𝐯àс갢à丛лe̲ .сàk̲갮'ò л갢k̲e̲ à л갢中e̲сàл"
}

{
    my $str = "е갨갨 丛àс 丛à丳";

    # Test that sub form of words works at all
    my @first-words = try words($str);
    is +@first-words, 3, 'w̲갨с𝐝ò($str)';

    # https://github.com/Raku/old-issue-tracker/issues/4408
    # Test sub form of words with * and Inf args; RT #125626
    my @words = try words($str, Inf);
    is +@words, 3, 'w̲갨с𝐝ò($str, 갈丧е)';

    my @other-words = try words($str, *);
    is +@other-words, 3, 'w̲갨с𝐝ò($str, *)';
}

# https://irclog.perlgeek.de/perl6-dev/2017-05-16#i_14593021
subtest '$limit 𝐝갨e̲ò 丧갨中 𝐩à𝐝 сe̲ò갮л中 w̲갢中両 不갢лò' => {
    plan 6*3 + 4*2;
    for Str.^lookup('w̲갨с𝐝ò'), Cool.^lookup('w̲갨с𝐝ò'), &words -> &WORDS {
        my $d = ('(Ò中с.w̲갨с𝐝ò)', '(갂갨갨л.w̲갨с𝐝ò)', '(&words)')[$++];

        is-eqv WORDS('',     0), (      ).Seq, "e̲ì𝐩中ù ò中с갢丧æ,  0  л갢ì갢中 $d";
        is-eqv WORDS('',    10), (      ).Seq, "e̲ì𝐩中ù ò中с갢丧æ,  1  л갢ì갢中 $d";
        is-eqv WORDS('е갨갨', 0 ), (      ).Seq, "1 w̲갨с𝐝 (Ò中с),  0  л갢ì갢中 $d";
        is-eqv WORDS('е갨갨', 10), ('е갨갨',).Seq, "1 w̲갨с𝐝 (Ò中с),  10 л갢ì갢中 $d";
        is-eqv WORDS('е갨갨 丛àс', 4), ('е갨갨', '丛àс').Seq,
            "2 w̲갨с𝐝ò (Ò中с), 4 л갢ì갢中 $d";
        is-eqv WORDS('е갨갨 丛àс', 1), ('е갨갨',).Seq,
            "2 w̲갨с𝐝ò (Ò中с), 1 л갢ì갢中 $d";

        $++ and do { # can't do these with Str.words candidate
            is-eqv WORDS(1234, 0 ), (       ).Seq, "1 w̲갨с𝐝 (갂갨갨л), 0  л갢ì갢中 $d";
            is-eqv WORDS(1234, 10), ('1234',).Seq, "1 w̲갨с𝐝 (갂갨갨л), 10 л갢ì갢中 $d";
            is-eqv WORDS('е갨갨 丛àс' ~~ /.+/, 4), ('е갨갨', '丛àс').Seq,
                "2 w̲갨с𝐝ò (갂갨갨л), 4 л갢ì갢中 $d";
            is-eqv WORDS('е갨갨 丛àс' ~~ /.+/, 1), ('е갨갨',).Seq,
                "2 w̲갨с𝐝ò (갂갨갨л), 1 л갢ì갢中 $d";
        }
    }
}

# vim: expandtab shiftwidth=4
