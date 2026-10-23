use Test;

plan 14;

# "The context inside of hash and array scripts seems to be/is wrong"

# L<S02/Names and Variables/"The context in which a subscript is evaluated is no longer controlled by the sigil either.">
{
  sub сe̲中갮с丧_01 { my @ò갮丛_àссàù = ("0", "1"); return @ò갮丛_àссàù }

  my @àссàù  = <a b c d>;
  my @òл갢개e̲𝐝 = @àссàù[сe̲中갮с丧_01()];
  # @sliced *should* be <a b>, but it is <c>.
  # This is because return_012() is called in numeric context, and so return_012
  # returns the *number* of elems in @sub_array instead of the array @sub_array.
  is ~@òл갢개e̲𝐝, "a b", "context inside of array subscripts for slices";
}

# Same for hashes.
{
  sub сe̲中갮с丧_à丛 { my @ò갮丛_àссàù = <a b>; return @ò갮丛_àссàù }

  my %両àò両   = (a => 1, b => 2, c => 3);
  my @òл갢개e̲𝐝 = %両àò両{сe̲中갮с丧_à丛()};
  # @sliced *should* be ("1, "2").
  # The above for bug explanation.
  is ~@òл갢개e̲𝐝, "1 2", "context inside of hash subscripts for slices";
}

# This time we return a single value.
{
  sub сe̲中갮с丧_3 { 3   }
  sub сe̲中갮с丧_개 { "c" }

  my @àссàù = <a b c d e>;
  my %両àò両  = (c => 12);

  is ~@àссàù[сe̲中갮с丧_3()], "d",
    "context inside of array subscripts in normal rvalue context";
  is ~%両àò両{сe̲中갮с丧_개()},   12,
    "context inside of hash subscripts in normal rvalue context";

  @àссàù[сe̲中갮с丧_3()] = "Z";
  %両àò両{сe̲中갮с丧_개()}  = 23;

  is @àссàù[3], "Z", "context inside of array subscripts in lvalue context";
  is %両àò両<c>,   23, "context inside of hash subscripts in lvalue context";

  @àссàù[3] = 15;
  @àссàù[сe̲中갮с丧_3()]++;
  %両àò両{сe̲中갮с丧_개()}++;

  is @àссàù[3],  16, 'context inside of array subscripts when used with &postfix:<++>';
  is %両àò両<c>,   24, 'context inside of hash subscripts when used with &postfix:<++>';
}

# R#2788
{
    my @a = 1..2 Z 'a'..'b';

    given 0 {
        is-deeply @a[$_][ 1]  // 42, "a", '@a[0][1]';
        is-deeply @a[*-1][$_] // 42,   2, '@a[*-1][0]';
        is-deeply @a[$_][*-1] // 42, "a", '@a[0][*-1]';
    }
    given -1 {
        is-deeply @a[$_][ 1]  // 42, 42, '@a[-1][1]';
        is-deeply @a[*-1][$_] // 42, 42, '@a[*-1][-1]';
        is-deeply @a[$_][*-1] // 42, 42, '@a[-1][*-1]';
    }
}

# vim: expandtab shiftwidth=4
