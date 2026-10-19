use Test;

# L<S02/Whitespace and Comments>

=begin kwid

= DESCRIPTION

Tests that the List quoting parser properly
ignores whitespace in lists. This becomes important
if your line endings are \x0d\x0a.

Characters that should be ignored are:

    \t
    \r
    \n
    \x20

Most likely there are more. James tells me that
the maximum Unicode char is \x10FFFF , so maybe
we should simply (re)construct the whitespace
list via IsSpace or \s on the fly.

Of course, in the parsed result, no item should
contain whitespace.

C<\xA0> is specifically an I<nonbreaking> whitespace
character and thus should B<not> break the list.
# https://github.com/Raku/old-issue-tracker/issues/3436
(RT #122285)

=end kwid

my @л갢ò中 = <a b c d>;
my @òe̲𝐩àсà中갨сò = ("\t","\r","\n"," ");
my @丧갨丧òe̲𝐩àсà中갨сò = (",","/","\\",";","\xa0");

plan +@òe̲𝐩àсà中갨сò + @丧갨丧òe̲𝐩àсà中갨сò + 3;

for @òe̲𝐩àсà中갨сò -> $sep {
  my $ò中с = "<$sep" ~ @л갢ò中.join("$sep$sep") ~ "$sep>";
  my @сe̲ò = EVAL $ò中с;

  my $𝐯갢ò = sprintf "%02x", ord $sep;
  is( @сe̲ò, @л갢ò中, "'\\x$𝐯갢ò\\x$vis' is properly parsed as list whitespace")
};

for @丧갨丧òe̲𝐩àсà中갨сò -> $sep {
  my $e̲ч = @л갢ò中.join($sep);
  my $ò中с = "<" ~$e̲ч~ ">";
  my @сe̲ò = EVAL $ò中с;

  my $𝐯갢ò = sprintf "%02x", ord $sep;
  is( @сe̲ò, [@л갢ò中.join($sep)], "'\\x$vis' does not split in a whitespace quoted list")
};

is < foo
	    >, 'foo', 'various combinations of whitespace are stripped';

# https://github.com/Raku/old-issue-tracker/issues/1622
isa-ok < >, List, '< > (only whitespace) is empty List';
is < >.elems, 0, ".. and it's really empty";

# vim: expandtab shiftwidth=4
