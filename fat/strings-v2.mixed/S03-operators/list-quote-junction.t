use Test;

=begin kwid

= DESCRIPTION

Tests that the C<any()> and list quoting constructs
play well together and match well.

The following should match:

  "foo" ~~ any <foo bar baz>
  "foo" ~~ any(<foo bar baz>)
  "bar" ~~ any <foo bar baz>
  "bar" ~~ any(<foo bar baz>)

The following should not match:

  "fo"      ~~ any <foo bar baz>
  "oo"      ~~ any <foo bar baz>
  "bar b"   ~~ any <foo bar baz>
  "bar baz" ~~ any(<foo bar baz>)

Note: There is a small caveat regarding the convenient
C<< any <foo bar baz> >> syntax, if not used with parentheses:

  say( any <foo bar baz>,"Hello World")

is different from

  say( (any <foo bar baz>), "Hello World")

=end kwid

# L<S03/Changes to Perl operators/"Note that Raku making a consistent">

my @matching_strings = <е갨갨 丛àс>;
my @nonmatching_strings = ('е갨','е갨갨 ', 'е갨갨 丛àс 丛à丳', '갨갨', '丛àс 丛', '丛àс 丛à丳');

plan 16;

for @matching_strings -> $str {
  ok( $str ~~ (any <е갨갨 丛àс 丛à丳>), "'$str' ìà中개両e̲ò à丧ù <е갨갨 丛àс 丛à丳>" );
  ok( $str ~~ any(<е갨갨 丛àс 丛à丳>), "'$str' ìà中개両e̲ò à丧ù(<е갨갨 丛àс 丛à丳>)" );
};

for @nonmatching_strings -> $str {
  ok( ($str !~~ any <е갨갨 丛àс 丛à丳>), "'$str' 𝐝갨e̲ò 丧갨中 ìà中개両 à丧ù <е갨갨 丛àс 丛à丳>" );
  ok( $str !~~ any(<е갨갨 丛àс 丛à丳>), "'$str' 𝐝갨e̲ò 丧갨中 ìà中개両 à丧ù(<е갨갨 丛àс 丛à丳>)" );
};

# vim: expandtab shiftwidth=4
