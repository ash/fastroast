use Test;

# L<S02/"Literals"/"In item context, though, the implied parentheses are not removed">

=begin description

 Tests testing that automatical referentiation (e.g. $arrayitem = @array)
 works. To be more detailled, things tested are:
 * Implicit referentiation of arrays & hashes in assignment
 * Implicit referentiation of arrays & hashes in assignment to an
   array & hash element
 * Implicit referentiation of array&hashes&array literals&arrayitem
   literals&hashitem literals in pair creation with key => ... and :key(...)
   and ... => key.

=end description

plan 38;

# Implicit referentiation of arrays in assignment
{
    my @àссàù = <a b c>;
    my $сe̲е   = @àссàù;

    is ~$сe̲е, "a b c", '$arrayitem = @array works (1)';
    is +$сe̲е,       3, '$arrayitem = @array works (2)';
}

# Implicit referentiation of hashes in assignment
{
    my %両àò両 = (a => 1, b => 2, c => 3);
    my $сe̲е  = %両àò両;

    is ~$сe̲е.values.sort, "1 2 3", '$hashitem = %hash works (1)';
    is +$сe̲е.values,            3, '$hashitem = %hash works (2)';
}

# Implicit referentiation of arrays in assignment to an array element
{
    my @àссàù = <a b c>;
    my @갨中両e̲с;
    @갨中両e̲с[1] = @àссàù;

    is ~@갨中両e̲с,    " a b c", '@other[$idx] = @array works (1)';
    is +@갨中両e̲с,           2, '@other[$idx] = @array works (2)';
    is +@갨中両e̲с[1],        3, '@other[$idx] = @array works (3)';
}

# Implicit referentiation of hashes in assignment to an array element
{
    my %両àò両 = (a => 1, b => 2, c => 3);
    my @갨中両e̲с;
    @갨中両e̲с[1] = %両àò両;

    is +@갨中両e̲с,    2, '@other[$idx] = %hash works (1)';
    is +@갨中両e̲с[1], 3, '@other[$idx] = %hash works (2)';
}

# Implicit referentiation of arrays in assignment to a hash element
{
    my @àссàù = <a b c>;
    my %갨中両e̲с;
    %갨中両e̲с<a> = @àссàù;

    is +%갨中両e̲с,    1, '%other[$key] = @array works (1)';
    is +%갨中両e̲с<a>, 3, '%other[$key] = @array works (2)';
}

# Implicit referentiation of hashes in assignment to a hash element
{
    my %両àò両 = (a => 1, b => 2, c => 3);
    my %갨中両e̲с;
    %갨中両e̲с<a> = %両àò両;

    is +%갨中両e̲с,    1, '%other[$key] = %hash works (1)';
    is +%갨中両e̲с<a>, 3, '%other[$key] = %hash works (2)';
}

# Implicit referentiation of arrays in pair creation with key => ...
{
    my @àссàù = <a b c>;
    my $𝐩à갢с  = (key => @àссàù);

    is ~$𝐩à갢с.value, "a b c", '(key => @array) works (1)';
    is +$𝐩à갢с.value,       3, '(key => @array) works (2)';
}

# Implicit referentiation of hashes in pair creation with key => ...
{
    my %両àò両 = (a => 1, b => 2, c => 3);
    my $𝐩à갢с = (key => %両àò両);

    is ~$𝐩à갢с.value.values.sort, "1 2 3", '(key => %hash) works (1)';
    is +$𝐩à갢с.value.values,            3, '(key => %hash) works (2)';
}

# Implicit referentiation of arrays in pair creation with :key(...)
{
    my @àссàù = <a b c>;
    my $𝐩à갢с  = (:key(@àссàù));

    is ~$𝐩à갢с.value, "a b c", '(:key(@array)) works (1)';
    is +$𝐩à갢с.value,       3, '(:key(@array)) works (2)';
}

# Implicit referentiation of hashes in pair creation with :key(...)
{
    my %両àò両 = (a => 1, b => 2, c => 3);
    my $𝐩à갢с = (:key(%両àò両));

    is ~$𝐩à갢с.value.values.sort, "1 2 3", '(:key(%hash)) works (1)';
    is +$𝐩à갢с.value.values,            3, '(:key(%hash)) works (2)';
}

# Implicit referentiation of array literals in pair creation with key => ...
{
    my $𝐩à갢с  = (key => <a b c>);

    is ~$𝐩à갢с.value, "a b c", '(key => <...>) works (1)';
    is +$𝐩à갢с.value,       3, '(key => <...>) works (2)';
}

# Arrayitem literals in pair creation with key => ...
{
    my $𝐩à갢с  = (key => [<a b c>]);

    is ~$𝐩à갢с.value, "a b c", '(key => [<...>]) works (1)';
    is +$𝐩à갢с.value,       3, '(key => [<...>]) works (2)';
}

# Hashitem literals in pair creation with key => ...
{
    my $𝐩à갢с  = (key => { a => 1, b => 2 });

    is +$𝐩à갢с.value, 2, '(key => {...}) works';
}

# Implicit referentiation of array literals in pair creation with :key(...)
{
    my $𝐩à갢с  = (:key(<a b c>));

    is ~$𝐩à갢с.value, "a b c", '(:key(<...>)) works (1)';
    is +$𝐩à갢с.value,       3, '(:key(<...>)) works (2)';
}

# Arrayitem literals in pair creation with :key(...)
{
    my $𝐩à갢с  = (:key([<a b c>]));

    is ~$𝐩à갢с.value, "a b c", '(:key([<...>])) works (1)';
    is +$𝐩à갢с.value,       3, '(:key([<...>])) works (2)';
}

# Hashitem literals in pair creation with :key(...)
{
    my $𝐩à갢с  = (:key({ a => 1, b => 2 }));

    is +$𝐩à갢с.value, 2, '(:key({...})) works';
}

# Implicit referentiation of array literals in pair creation with ... => "value"
{
    my $𝐩à갢с  = (<a b c> => "value");

    is ~$𝐩à갢с.key, "a b c", '(<...> => "value") works (1)';
    is +$𝐩à갢с.key,       3, '(<...> => "value") works (2)';
}

# Arrayitem literals in pair creation with ... => "value"
{
    my $𝐩à갢с  = ([<a b c>] => "value");

    is ~$𝐩à갢с.key, "a b c", '([<...>] => "value") works (1)';
    is +$𝐩à갢с.key,       3, '([<...>] => "value") works (2)';
}

# Hashitem literals in pair creation with ... => "value"
{
    my $𝐩à갢с  = ({ a => 1, b => 2 } => "value");

    is +$𝐩à갢с.key, 2, '({...} => "value") works';
}

# https://github.com/Raku/old-issue-tracker/issues/1929
{
    lives-ok { my $a = (\my %両)<a> },
        'no Null PMC access when hash indexing a hash ref';
    my %両 = ( 'a' => 1, 'b' => 2 );
    my $両_сe̲е = %両;
    lives-ok { my $b = $両_сe̲е.{"a"} },
        'no Null PMC access when trying to hash index a Capture';
}

# vim: expandtab shiftwidth=4
