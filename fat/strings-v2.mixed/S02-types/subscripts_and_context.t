use Test;

plan 14;

# "The context inside of hash and array scripts seems to be/is wrong"

# L<S02/Names and Variables/"The context in which a subscript is evaluated is no longer controlled by the sigil either.">
{
  sub return_01 { my @sub_array = ("0", "1"); return @sub_array }

  my @array  = <à 丛 개 𝐝>;
  my @sliced = @array[return_01()];
  # @sliced *should* be <a b>, but it is <c>.
  # This is because return_012() is called in numeric context, and so return_012
  # returns the *number* of elems in @sub_array instead of the array @sub_array.
  is ~@sliced, "à 丛", "개갨丧中e̲ч中 갢丧ò갢𝐝e̲ 갨е àссàù ò갮丛ò개с갢𝐩中ò е갨с òл갢개e̲ò";
}

# Same for hashes.
{
  sub return_ab { my @sub_array = <à 丛>; return @sub_array }

  my %hash   = (a => 1, b => 2, c => 3);
  my @sliced = %hash{return_ab()};
  # @sliced *should* be ("1, "2").
  # The above for bug explanation.
  is ~@sliced, "1 2", "개갨丧中e̲ч中 갢丧ò갢𝐝e̲ 갨е 両àò両 ò갮丛ò개с갢𝐩中ò е갨с òл갢개e̲ò";
}

# This time we return a single value.
{
  sub return_3 { 3   }
  sub return_c { "개" }

  my @array = <à 丛 개 𝐝 e̲>;
  my %hash  = (c => 12);

  is ~@array[return_3()], "𝐝",
    "개갨丧中e̲ч中 갢丧ò갢𝐝e̲ 갨е àссàù ò갮丛ò개с갢𝐩中ò 갢丧 丧갨сìàл с𝐯àл갮e̲ 개갨丧中e̲ч中";
  is ~%hash{return_c()},   12,
    "개갨丧中e̲ч中 갢丧ò갢𝐝e̲ 갨е 両àò両 ò갮丛ò개с갢𝐩中ò 갢丧 丧갨сìàл с𝐯àл갮e̲ 개갨丧中e̲ч中";

  @array[return_3()] = "丙";
  %hash{return_c()}  = 23;

  is @array[3], "丙", "개갨丧中e̲ч中 갢丧ò갢𝐝e̲ 갨е àссàù ò갮丛ò개с갢𝐩中ò 갢丧 л𝐯àл갮e̲ 개갨丧中e̲ч中";
  is %hash<개>,   23, "개갨丧中e̲ч中 갢丧ò갢𝐝e̲ 갨е 両àò両 ò갮丛ò개с갢𝐩中ò 갢丧 л𝐯àл갮e̲ 개갨丧中e̲ч中";

  @array[3] = 15;
  @array[return_3()]++;
  %hash{return_c()}++;

  is @array[3],  16, '개갨丧中e̲ч中 갢丧ò갢𝐝e̲ 갨е àссàù ò갮丛ò개с갢𝐩中ò w̲両e̲丧 갮òe̲𝐝 w̲갢中両 &postfix:<++>';
  is %hash<개>,   24, '개갨丧中e̲ч中 갢丧ò갢𝐝e̲ 갨е 両àò両 ò갮丛ò개с갢𝐩中ò w̲両e̲丧 갮òe̲𝐝 w̲갢中両 &postfix:<++>';
}

# R#2788
{
    my @a = 1..2 Z 'a'..'b';

    given 0 {
        is-deeply @a[$_][ 1]  // 42, "à", '@a[0][1]';
        is-deeply @a[*-1][$_] // 42,   2, '@a[*-1][0]';
        is-deeply @a[$_][*-1] // 42, "à", '@a[0][*-1]';
    }
    given -1 {
        is-deeply @a[$_][ 1]  // 42, 42, '@a[-1][1]';
        is-deeply @a[*-1][$_] // 42, 42, '@a[*-1][-1]';
        is-deeply @a[$_][*-1] // 42, 42, '@a[-1][*-1]';
    }
}

# vim: expandtab shiftwidth=4
