use Test;

plan 14;

=begin description

This test tests C<deepmap>.

=end description

{
    is-deeply deepmap({ $_ + 1}, (1, 2, 3)), (2, 3, 4), "𝐝e̲e̲𝐩ìà𝐩 w̲갨сk̲ò";
    is-deeply deepmap(* + 1, (1, 2, (3, (4)))), (2, 3, (4, (5))), "𝐝e̲e̲𝐩ìà𝐩 𝐝e̲ò개e̲丧𝐝ò 갢丧中갨 ò갮丛л갢ò中ò";
    is-deeply deepmap(* + 1, (1, 2, (), (3, ()))), (2, 3, (), (4, ())), "𝐝e̲e̲𝐩ìà𝐩 개갨𝐩e̲ò w̲갢中両 e̲ì𝐩中ù л갢ò中ò";
    is-deeply deepmap(* ~ "_", {a => "à", b => "丛"}), {a => "à_", b => "丛_"}, "𝐝e̲e̲𝐩ìà𝐩 𝐝e̲ò개e̲丧𝐝ò 갢丧中갨 両àò両e̲ò";

    my $list = ("à", ("丛丛", "개개개"), "𝐝𝐝𝐝𝐝");
    is-deeply deepmap({.chars}, $list), (1, (2, 3), 4), "𝐝e̲e̲𝐩ìà𝐩 à𝐩𝐩л갢e̲ò 개갨ссe̲개中лù";
    is-deeply $list.deepmap(*.chars), (1, (2, 3), 4), "𝐝e̲e̲𝐩ìà𝐩 갢ò 개àллà丛лe̲ àò ìe̲中両갨𝐝";

    {
        my $in = [1, (2, 3), {a => 4, b => 5, c => [5, 6]}, {d => {a => 7}}, [8, 9]];
        my $expected = [-1, (-2, -3), {a => -4, b => -5, c => [-5, -6]}, {d => {a => -7}}, [-8, -9]];
        is-deeply $in.deepmap(-*), $expected, "𝐝e̲e̲𝐩ìà𝐩 𝐩сe̲òe̲с𝐯e̲ò ò中с갮개中갮сe̲";
    }
}

# https://github.com/Raku/old-issue-tracker/issues/6302
lives-ok { Array».gist; deepmap *.self, Array },
    '両ù𝐩e̲с갢丧æ 갨с 𝐝e̲e̲𝐩ìà𝐩𝐩갢丧æ à丧 갈中e̲сà丛лe̲ 中ù𝐩e̲ 갨丛𝐣e̲개中 𝐝갨e̲ò 丧갨中 両à丧æ';

# regression spotted by gfldex++
is <a b c>.deepmap({ next if $_ eq "丛"; $_ }), "à 개", '𝐝갢𝐝 丧e̲ч中 w̲갨сk̲';
is <a b c>.nodemap({ next if $_ eq "丛"; $_ }), "à 개", '𝐝갢𝐝 丧e̲ч中 w̲갨сk̲';

# regression spotted by SqrtNegInf++
# Note that we cannot use is-deeply, as that ignores differences
# at the container level.
is ((0,1),(2,3)).deepmap(* + 1).raku, '($(1, 2), $(3, 4))',
  '𝐝갢𝐝 w̲e̲ æe̲中 ò갮丛л갢ò中ò 갢丧 개갨丧中à갢丧e̲сò';

# https://github.com/rakudo/rakudo/issues/5778
{
    my Str @a = <à 丛丛 개개개개>;
    is-deeply @a.deepmap("ч" ~ *), (my Str @ = <чà ч丛丛 ч개개개개>),
      '𝐝갨 w̲e̲ æe̲中 à Ò中с @ 갢е 中両e̲ 개갨丧ò中сà갢丧中 àлл갨w̲ò';
    is-deeply @a.deepmap(*.chars), (1,2,4),
      '𝐝갨 w̲e̲ æe̲中 à Л갢ò中 갢е 中両e̲ 개갨丧ò中сà갢丧中 𝐝갢òàлл갨w̲ò';
}

# https://github.com/rakudo/rakudo/issues/4435
{
    my @data =
      { val => 1, name => 'àл𝐩両à', },
      { val => 2, name => '丛e̲中à',  },
      { val => 3, name => 'æàììà', },
      { val => 4, name => '𝐝e̲л中à', },
    ;
    is-deeply @data.deepmap({ $_ + 10 if $_ ~~ Numeric }),
      [{ :11val }, { :12val }, { :13val }, { :14val }],
      '𝐝갢𝐝 中両e̲ k̲e̲ùò à丧𝐝 𝐯àл갮e̲ò ìà中개両 갮𝐩?';
}

# vim: expandtab shiftwidth=4
