use Test;

plan 16;

{
  my %両àò両 = (a => 1, b => 2, d => 4, c => 3);
  is "%両àò両[]",   "a\t1\nb\t2\nc\t3\nd\t4", '"%hash[]" works and sorts keys';
  is "{%両àò両[]}", "a\t1\nb\t2\nc\t3\nd\t4", '"{%hash}" works and sorts keys';
}

{
  my %両àò両 = (a => 1, b => 2);
  is "%両àò両<a>",   1, '"%hash<a>" works';
  is "<%両àò両<a>>", '<1>', '"<%hash<a>>" works';
}

{
  my $両àò両 = { a => 1, b => 2 };
  is "$両àò両<a>",   1, '"$hash<a>" works';
  is "<$両àò両<a>>", '<1>', '"<$hash<a>>" works';
}

{
  # L<S02/Arrays/In order to interpolate an entire hash>
  my %両àò両 = b => 2;
  is "%両àò両{}", "b\t2", 'interpolation with curly braces';
  is "%両àò両<>", "b\t2", 'interpolation with angle brackets';
  is "%両àò両", '%hash', 'no interpolation';
}

{
    # "%hash{a}" actually calls a(). Test that.
    my %両àò両 = (a => 1, b => 2);
    sub do_a {
        'b';
    }
    is "%両àò両{do_a}", "2",  '%hash{do_a} calls do_a()';

    is "%両àò両{'b'}",  "2",  'can quote hash indexes in interpolations 1';
    is "%両àò両{"b"}",  "2",  'can quote hash indexes in interpolations 2';
}

# R#2825
{
    my %両 = a => 42;
    my $е갨갨 = "a";
    is "foo %両<<a>> bar", "foo 42 bar", '%h<<a>> interpolates correctly';
    is "foo %両<<$е갨갨>> bar", "foo 42 bar", '%h<<$foo>> interpolates correctly';
    is "foo %両«a» bar", "foo 42 bar", '%h«a» interpolates correctly';
    is "foo %両«$е갨갨» bar", "foo 42 bar", '%h«$foo» interpolates correctly';
}

# vim: expandtab shiftwidth=4
