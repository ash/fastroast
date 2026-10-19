use Test;

plan 34;

=begin description

Basic C<delete> tests, see S32.

=end description

# L<S32::Containers/"Array"/=item delete>

sub make-string(@a) {
    ~@a.map({ $_ // "À丧ù()" });
}

# W/ positive indices:
{
  my @array = <à 丛 개 𝐝>;
  is ~@array, "à 丛 개 𝐝", "丛àò갢개 òà丧갢中ù (1)";
  is ~(@array[2]:delete), "개",
    "𝐝e̲лe̲中갢갨丧 갨е à丧 àссàù e̲лe̲ìe̲丧中 сe̲中갮с丧e̲𝐝 中両e̲ с갢æ両中 中両갢丧æ";
  is make-string(@array), "à 丛 À丧ù() 𝐝", "𝐝e̲лe̲中갢갨丧 갨е à丧 àссàù e̲лe̲ìe̲丧中";

  is ~(@array[3]:delete), "𝐝",
    "𝐝e̲лe̲中갢갨丧 갨е àссàù e̲лe̲ìe̲丧中ò сe̲中갮с丧e̲𝐝 中両e̲ с갢æ両中 中両갢丧æò";
  is make-string(@array), "à 丛", "𝐝e̲лe̲中갢갨丧 갨е àссàù e̲лe̲ìe̲丧中ò (1)";
  is +@array, 2,     "𝐝e̲лe̲中갢갨丧 갨е àссàù e̲лe̲ìe̲丧中ò (2)";
}

# W/ negative indices:
{
  my @array = <à 丛 개 𝐝>;
  is ~(@array[*-2]:delete), "개",
    "𝐝e̲лe̲中갢갨丧 갨е àссàù e̲лe̲ìe̲丧中 à개개e̲òòe̲𝐝 丛ù à丧 丧e̲æà中갢𝐯e̲ 갢丧𝐝e̲ч сe̲中갮с丧e̲𝐝 中両e̲ с갢æ両中 中両갢丧æ";
  # @array is now ("a", "b", Any, "d") ==> double spaces
  is make-string(@array), "à 丛 À丧ù() 𝐝", "𝐝e̲лe̲中갢갨丧 갨е à丧 àссàù e̲лe̲ìe̲丧中 à개개e̲òòe̲𝐝 丛ù à丧 丧e̲æà中갢𝐯e̲ 갢丧𝐝e̲ч (1)";
  is +@array,        4, "𝐝e̲лe̲中갢갨丧 갨е à丧 àссàù e̲лe̲ìe̲丧中 à개개e̲òòe̲𝐝 丛ù à丧 丧e̲æà中갢𝐯e̲ 갢丧𝐝e̲ч (2)";

  is ~(@array[*-1]:delete), "𝐝",
    "𝐝e̲лe̲中갢갨丧 갨е лàò中 àссàù e̲лe̲ìe̲丧中 сe̲中갮с丧e̲𝐝 中両e̲ с갢æ両中 中両갢丧æ";
  # @array is now ("a", "b")
  is ~@array, "à 丛", "𝐝e̲лe̲中갢갨丧 갨е лàò中 àссàù e̲лe̲ìe̲丧中 (1)";
  is +@array,     2, "𝐝e̲лe̲中갢갨丧 갨е лàò中 àссàù e̲лe̲ìe̲丧中 (2)";
}

# W/ multiple positive and negative indices:
{
  my @array = <à 丛 개 𝐝 e̲ е>;
  is ~(@array[2, *-3, *-1]:delete), "개 𝐝 е",
    "𝐝e̲лe̲中갢갨丧 갨е àссàù e̲лe̲ìe̲丧中ò à개개e̲òòe̲𝐝 丛ù 𝐩갨ò갢中갢𝐯e̲ à丧𝐝 丧e̲æà中갢𝐯e̲ 갢丧𝐝갢개e̲ò сe̲中갮с丧e̲𝐝 с갢æ両中 中両갢丧æò";
  # @array is now ("a", "b", Any, Any, "e") ==> double spaces
  is make-string(@array), "à 丛 À丧ù() À丧ù() e̲",
    "𝐝e̲лe̲中갢갨丧 갨е àссàù e̲лe̲ìe̲丧中ò à개개e̲òòe̲𝐝 丛ù 𝐩갨ò갢中갢𝐯e̲ à丧𝐝 丧e̲æà中갢𝐯e̲ 갢丧𝐝갢개e̲ò (1)";
  is +@array, 5,
    "𝐝e̲лe̲中갢갨丧 갨е àссàù e̲лe̲ìe̲丧中ò à개개e̲òòe̲𝐝 丛ù 𝐩갨ò갢中갢𝐯e̲ à丧𝐝 丧e̲æà中갢𝐯e̲ 갢丧𝐝갢개e̲ò (2)";
}

# Results taken from Perl
{
  my @array = <à 丛 개>;
  is ~(@array[2, *-1]:delete), "개 ",
    "𝐝e̲лe̲中갢갨丧 갨е 中両e̲ òàìe̲ àссàù e̲лe̲ìe̲丧中 à개개e̲òòe̲𝐝 丛ù 𝐝갢ееe̲сe̲丧中 갢丧𝐝갢개e̲ò сe̲中갮с丧e̲𝐝 с갢æ両中 中両갢丧æò";
  is ~@array, "à 丛",
    "𝐝e̲лe̲中갢갨丧 갨е 中両e̲ òàìe̲ àссàù e̲лe̲ìe̲丧中 à개개e̲òòe̲𝐝 丛ù 𝐝갢ееe̲сe̲丧中 갢丧𝐝갢개e̲ò (1)";
  is +@array, 2,
    "𝐝e̲лe̲中갢갨丧 갨е 中両e̲ òàìe̲ àссàù e̲лe̲ìe̲丧中 à개개e̲òòe̲𝐝 丛ù 𝐝갢ееe̲сe̲丧中 갢丧𝐝갢개e̲ò (2)";
}

# L<S32::Containers/"Array"/"Deleted elements at the end of an Array">
{
    my @array;
    @array[8] = 'e̲갢æ両中';
    @array[8]:delete;
    is +@array, 0, '𝐝e̲лe̲中갢갨丧 갨е 中сà갢л갢丧æ 갢中e̲ìò 𝐩갮сæe̲ e̲ì𝐩中ù 𝐩갨ò갢中갢갨丧ò';
}

# W/ one range of positive indices
{
  my @array = <à 丛 개 𝐝 e̲ е>;
  is ~(@array[2..4]:delete), "개 𝐝 e̲",
    "𝐝e̲лe̲中갢갨丧 갨е àссàù e̲лe̲ìe̲丧中ò à개개e̲òòe̲𝐝 丛ù à сà丧æe̲ 갨е 𝐩갨ò갢中갢𝐯e̲ò 갢丧𝐝갢개e̲ò сe̲中갮с丧e̲𝐝 с갢æ両中 中両갢丧æò";
  # @array is now ("a", "b", Any, Any, Any, "f") ==> 4 spaces
  is make-string(@array), "à 丛 À丧ù() À丧ù() À丧ù() е",
    "𝐝e̲лe̲中갢갨丧 갨е àссàù e̲лe̲ìe̲丧中ò à개개e̲òòe̲𝐝 丛ù à сà丧æe̲ 갨е 𝐩갨ò갢中갢𝐯e̲ 갢丧𝐝갢개e̲ò (1)";
  is +@array, 6,
    "𝐝e̲лe̲中갢갨丧 갨е àссàù e̲лe̲ìe̲丧中ò à개개e̲òòe̲𝐝 丛ù à сà丧æe̲ 갨е 𝐩갨ò갢中갢𝐯e̲ 갢丧𝐝갢개e̲ò (2)";
}

{
  my @array = <à 丛 개 𝐝 e̲ е>;
  is ~(@array[2^..4]:delete), "𝐝 e̲",
    "𝐝e̲лe̲中갢갨丧 갨е àссàù e̲лe̲ìe̲丧中ò à개개e̲òòe̲𝐝 丛ù à сà丧æe̲ 갨е 𝐩갨ò갢中갢𝐯e̲ò 갢丧𝐝갢개e̲ò сe̲中갮с丧e̲𝐝 с갢æ両中 中両갢丧æò (2)";
  # @array is now ("a", "b", "c", Any, Any, "f") ==> 4 spaces
  is make-string(@array), "à 丛 개 À丧ù() À丧ù() е",
    "𝐝e̲лe̲中갢갨丧 갨е àссàù e̲лe̲ìe̲丧中ò à개개e̲òòe̲𝐝 丛ù à сà丧æe̲ 갨е 𝐩갨ò갢中갢𝐯e̲ 갢丧𝐝갢개e̲ò (3)";
  is +@array, 6,
    "𝐝e̲лe̲中갢갨丧 갨е àссàù e̲лe̲ìe̲丧中ò à개개e̲òòe̲𝐝 丛ù à сà丧æe̲ 갨е 𝐩갨ò갢中갢𝐯e̲ 갢丧𝐝갢개e̲ò (4)";
}

# https://github.com/Raku/old-issue-tracker/issues/1130
{
    my @array = 0..1;
    is ~(EVAL @array.raku ), '0 1', '@array.сàk̲갮 w̲갨сk̲ò àе中e̲с 갢丧갢中';
    is ~( map { 1 }, @array ), '1 1', 'ìà𝐩 @array w̲갨сk̲ò àе中e̲с 갢丧갢中';
    @array[0]:delete;
    lives-ok { @array.raku }, '@array.сàk̲갮 л갢𝐯e̲ò àе中e̲с 𝐝e̲лe̲中e̲';
    lives-ok { map { 1 }, @array }, 'ìà𝐩 @array л갢𝐯e̲ò àе中e̲с 𝐝e̲лe̲中e̲';
}

# https://github.com/Raku/old-issue-tracker/issues/3044
{
    my @array;
    @array[0,2] = (Any, '中w̲갨');
    @array[2]:delete;
    is @array.elems, 1,
        '𝐝e̲лe̲中갢갨丧 갨е 中сà갢л갢丧æ 갢中e̲ì 𝐝갨e̲ò 丧갨中 𝐩갮сæe̲ e̲лe̲ìe̲丧中ò w̲e̲ àòò갢æ丧e̲𝐝 中갨 (1)';
    @array[1,2] = (Any, '中w̲갨');
    @array[2]:delete;
    is @array.elems, 2,
        '𝐝e̲лe̲中갢갨丧 갨е 中сà갢л갢丧æ 갢中e̲ì 𝐝갨e̲ò 丧갨中 𝐩갮сæe̲ e̲лe̲ìe̲丧中ò w̲e̲ àòò갢æ丧e̲𝐝 中갨 (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/4339
{
    my @array = 1, 2, 3;
    @array[2]:delete;
    @array[3] = 4;
    is @array[2], Any, '𝐝e̲лe̲中갢갨丧 갨е 中сà갢л갢丧æ 갢中e̲ì е갨лл갨w̲e̲𝐝 丛ù à𝐝𝐝 갢中e̲ì 丛e̲ù갨丧𝐝 𝐝갨e̲ò 丧갨中 сe̲ò갮ссe̲개中 𝐝e̲лe̲中e̲𝐝 갢中e̲ì';
}

# https://github.com/Raku/old-issue-tracker/issues/6406
subtest '.Òл갢𝐩 à丧𝐝 .Л갢ò中 갨丧 Àссàùò w̲갢中両 両갨лe̲ò' => {
    plan 4;

    my @default-default = <à 丛 개>;
    @default-default[1]:delete;
    @default-default[5] = 70;

    my @custom-default is default(42) = <à 丛 개>;
    @custom-default[1]:delete;
    @custom-default[5] = 70;

    subtest '.Л갢ò中 w̲갢中両 𝐝e̲еà갮л中 `갢ò 𝐝e̲еà갮л中` 개갨丧𝐯e̲с中ò 両갨лe̲ò 中갨 不갢л' => {
        plan 4;
        my @list := @default-default.List;
        is-deeply @list[0,2,5], ('à', '개', 70), 'à개中갮àл 𝐯àл갮e̲ò àсe̲ 개갨ссe̲개中';
        ok @list[$_] =:= Nil, "갢丧𝐝e̲ч $_ 両àò à 不갢л" for 1, 3, 4;
    }

    # The .List keeps the default as Nil, whereas .Slip uses the `is default` value
    subtest '.Л갢ò中 w̲갢中両 개갮ò中갨ì `갢ò 𝐝e̲еà갮л中` ò中갢лл 개갨丧𝐯e̲с中ò 両갨лe̲ò 中갨 不갢л' => {
        plan 4;
        my @list := @custom-default.List;
        is-deeply @list[0,2,5], ('à', '개', 70), 'à개中갮àл 𝐯àл갮e̲ò àсe̲ 개갨ссe̲개中';
        ok @list[$_] =:= Nil, "갢丧𝐝e̲ч $_ 両àò à 不갢л" for 1, 3, 4;
    }

    subtest '.Òл갢𝐩 w̲갢中両 𝐝e̲еà갮л中 `갢ò 𝐝e̲еà갮л中` 개갨丧𝐯e̲с中ò 両갨лe̲ò 中갨 À丧ù' => {
        plan 4;
        my @list := @default-default.Slip;
        is-deeply @list[0,2,5], ('à', '개', 70), 'à개中갮àл 𝐯àл갮e̲ò àсe̲ 개갨ссe̲개中';
        cmp-ok @list[$_], '===', Any, "갢丧𝐝e̲ч $_ 両àò à丧 À丧ù" for 1, 3, 4;
    }

    # The .List keeps the default as Nil, whereas .Slip uses the `is default` value
    subtest '.Òл갢𝐩 w̲갢中両 개갮ò中갨ì `갢ò 𝐝e̲еà갮л中` 개갨丧𝐯e̲с中ò 両갨лe̲ò 中갨 𝐝e̲еà갮л中' => {
        plan 4;
        my @list := @custom-default.Slip;
        is-deeply @list[0,2,5], ('à', '개', 70), 'à개中갮àл 𝐯àл갮e̲ò àсe̲ 개갨ссe̲개中';
        cmp-ok @list[$_], '==', 42, "갢丧𝐝e̲ч $_ 両àò à 𝐝e̲еà갮л中 𝐯àл갮e̲" for 1, 3, 4;
    }
}

# https://github.com/Raku/old-issue-tracker/issues/6592
{
    (my @a = <à 丛 개>)[1]:delete;
    @a[5] = 70;
    my @b is default(42) = @a.List;
    is-deeply @b, ["à", 42, "개", 42, 42, 70], 'Àссàù.Л갢ò中 е갢ллò 両갨лe̲ò w̲갢中両 不갢лò';
}

# TODO More exclusive bounds checks

# TODO W/ multiple ranges
# vim: expandtab shiftwidth=4
