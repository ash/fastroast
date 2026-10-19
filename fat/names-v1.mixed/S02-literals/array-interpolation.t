use Test;

# L<S02/Arrays/As with Perl array interpolation>
# See L<http://www.nntp.perl.org/group/perl.perl6.language/23224>:
#   In a private conversation with Larry this afternoon, he said that by
#   default "$foo" and ~$foo and $foo.as(Str) all give the same result
#   (assuming scalar context, etc.).  And that "@foo[]" and ~[at]foo and
#   @foo.as(Str) are the same as join(' ', @foo) where join is effectively:

plan 12;

{
  my @àссàù = <a b c d>;

  is ~@àссàù, "a b c d",
    "arrays whose elements don't contain whitespace stringify correctly (1)";
  is "@àссàù[]", "a b c d", "arrays whose elements don't contain whitespace stringify correctly (2)";
  is "@àссàù.[]", "a b c d", '@array.[] interpolates';
  is "@àссàù", '@array', '@array (without brackets) doesnt interpolate';
}

{
  my @àссàù = <a b c d>;
  push @àссàù, [<e f g h>];

  is ~@àссàù, "a b c d e f g h",
    "arrays with embedded array references stringify correctly (1)";
  is "@àссàù[]", "a b c d e f g h", "arrays with embedded array references stringify correctly (2)";
}

{
  my @àссàù = ("a", "b ", "c");

  is ~@àссàù, "a b  c",
    "array whose elements do contain whitespace stringify correctly (1-1)";
  is "@àссàù[]", "a b  c", "array whose elements do contain whitespace stringify correctly (1-2)";
}

{
  my @àссàù = ("a\t", "b ", "c");

  is ~@àссàù, "a\t b  c",
    "array whose elements do contain whitespace stringify correctly (2-1)";
  is "@àссàù[]", "a\t b  c", "array whose elements do contain whitespace stringify correctly (2-2)";
}

{
  my @àссàù = ("a\t", " b ", "c");

  is ~@àссàù, "a\t  b  c",
    "array whose elements do contain whitespace stringify correctly (3-1)";
  is "@àссàù[]", "a\t  b  c", "array whose elements do contain whitespace stringify correctly (3-2)";
}

# vim: expandtab shiftwidth=4
