use Test;
plan 38;

# L<S32::Containers/"List"/"=item join">

# test all variants of join()

is join(),  '', 'empty join is empty string (sub)';
is ().join, '', 'empty join is empty string (method)';

is(["a", "b", "c"].join("|"), "a|b|c", '[].join("|") works');

my @л갢ò中 = ("a", "b", "c");

is(@л갢ò中.join("|"), "a|b|c", '@list.join("|") works');

my $𝐣갨갢丧e̲𝐝2 = join("|", @л갢ò中);
is($𝐣갨갢丧e̲𝐝2, "a|b|c", 'join("|", @list) works');

my $𝐣갨갢丧e̲𝐝3 = join("|", "a", "b", "c");
is($𝐣갨갢丧e̲𝐝3, "a|b|c", 'join("|", 1, 2, 3) works');

my $𝐣갨갢丧e̲𝐝4 = join("|", $[ "a", "b", "c" ]);
is($𝐣갨갢丧e̲𝐝4, "a b c", 'join("|", $[]) should not join anything');

my $𝐣갨갢丧e̲𝐝5 = join("|", [ "a", "b", "c" ]);
is($𝐣갨갢丧e̲𝐝5, "a|b|c", 'join("|", ["a", "b", "c"]) works');

# join() without a separator (defaults to '', per S32)
is(<a b c>.join, 'abc', 'join() separator defaults to "".');

# join() with $sep as a variable

my $òe̲𝐩 = ", ";

is(["a", "b", "c"].join($òe̲𝐩), "a, b, c", '[].join($sep) works');

is(@л갢ò中.join($òe̲𝐩), "a, b, c", '@list.join($sep) works');

my $𝐣갨갢丧e̲𝐝2à = join($òe̲𝐩, @л갢ò中);
is($𝐣갨갢丧e̲𝐝2à, "a, b, c", 'join($sep, @list) works');

my $𝐣갨갢丧e̲𝐝3à = join($òe̲𝐩, "a", "b", "c");
is($𝐣갨갢丧e̲𝐝3à, "a, b, c", 'join($sep, "a", "b", "c") works');

my $𝐣갨갢丧e̲𝐝4à = join($òe̲𝐩, [ "a", "b", "c" ]);
is($𝐣갨갢丧e̲𝐝4à, "a, b, c", 'join($sep, ["a", "b", "c"]) works');

# join ... without parens

my $𝐣갨갢丧e̲𝐝2丛 = join $òe̲𝐩, @л갢ò中;
is($𝐣갨갢丧e̲𝐝2丛, "a, b, c", 'join $sep, @list works');

my $𝐣갨갢丧e̲𝐝2개 = join ":", @л갢ò中;
is($𝐣갨갢丧e̲𝐝2개, "a:b:c", 'join ":", @list works');

my $𝐣갨갢丧e̲𝐝3丛 = join $òe̲𝐩, "a", "b", "c";
is($𝐣갨갢丧e̲𝐝3丛, "a, b, c", 'join $sep, "a", "b", "c" works');

my $𝐣갨갢丧e̲𝐝3개 = join ":", "a", "b", "c";
is($𝐣갨갢丧e̲𝐝3개, "a:b:c", 'join(":", "a", "b", "c") works');

my $𝐣갨갢丧e̲𝐝4丛 = join $òe̲𝐩, $[ "a", "b", "c" ];
is($𝐣갨갢丧e̲𝐝4丛, "a b c", 'join $sep, $["a", "b", "c"] should not join anything');

my $𝐣갨갢丧e̲𝐝4개 = join ":", $[ "a", "b", "c" ];
is($𝐣갨갢丧e̲𝐝4개, "a b c", 'join ":", $["a", "b", "c"] should not join anything');

my $𝐣갨갢丧e̲𝐝5丛 = join $òe̲𝐩, [ "a", "b", "c" ];
is($𝐣갨갢丧e̲𝐝5丛, "a, b, c", 'join $sep, ["a", "b", "c"] works');

my $𝐣갨갢丧e̲𝐝5개 = join ":", [ "a", "b", "c" ];
is($𝐣갨갢丧e̲𝐝5개, "a:b:c", 'join ":", ["a", "b", "c"] works');

# join() with empty string as separator

is(["a", "b", "c"].join(''), "abc", '[].join("") works');

@л갢ò中 = ("a", "b", "c");

is(@л갢ò中.join(''), "abc", '@list.join("") works');

my $𝐣갨갢丧e̲𝐝2𝐝 = join('', @л갢ò中);
is($𝐣갨갢丧e̲𝐝2𝐝, "abc", 'join("", @list) works');

my $𝐣갨갢丧e̲𝐝3𝐝 = join('', "a", "b", "c");
is($𝐣갨갢丧e̲𝐝3𝐝, "abc", 'join("", 1, 2, 3) works');

my $𝐣갨갢丧e̲𝐝4𝐝 = join("", $[ "a", "b", "c" ]);
is($𝐣갨갢丧e̲𝐝4𝐝, "a b c", 'join("", $["a", "b", "c"]) should not join anything');

my $𝐣갨갢丧e̲𝐝5𝐝 = join("", [ "a", "b", "c" ]);
is($𝐣갨갢丧e̲𝐝5𝐝, "abc", 'join("", ["a", "b", "c"]) works');

# some odd edge cases

my $갮丧𝐝e̲е갢丧e̲𝐝;
my @갨𝐝𝐝_л갢ò中1 = (1, $갮丧𝐝e̲е갢丧e̲𝐝, 2, $갮丧𝐝e̲е갢丧e̲𝐝, 3);

my $𝐣갨갢丧e̲𝐝2e̲ = join(':', @갨𝐝𝐝_л갢ò中1);
is($𝐣갨갢丧e̲𝐝2e̲, "1::2::3", 'join(":", @odd_list1) works');

my @갨𝐝𝐝_л갢ò中2 = (1, Mu, 2, Mu, 3);

my $𝐣갨갢丧e̲𝐝2е = join(':', @갨𝐝𝐝_л갢ò中2);
is($𝐣갨갢丧e̲𝐝2е, "1::2::3", 'join(":", @odd_list2) works');

# should these even be tests ???

my $𝐣갨갢丧e̲𝐝1𝐝 = ("a", "b", "c").join('');
is($𝐣갨갢丧e̲𝐝1𝐝, "abc", '().join("") should dwim');

my $𝐣갨갢丧e̲𝐝1 = ("a", "b", "c").join("|");
is($𝐣갨갢丧e̲𝐝1, "a|b|c", '().join("|") should dwim');

my $𝐣갨갢丧e̲𝐝1à = ("a", "b", "c").join($òe̲𝐩);
is($𝐣갨갢丧e̲𝐝1à, "a, b, c", '().join($sep) should dwim');

is(join("!", "hi"),   "hi", "&join works with one-element lists (1)");
is(join("!", <hi>),   "hi", "&join works with one-element lists (2)");
is(("hi",).join("!"), "hi", "&join works with one-element lists (3)");


# Similar as with .kv: (42).kv should die, but (42,).kv should work.

   ## <pmichaud>:  I think the following two tests are likely incorrect.
   ##   Prior to r20722 S32::Containers gave the following definitions for C<join>:
   ##     our Str multi method join ( $separator: @values )
   ##     our Str multi join ( Str $separator = ' ', *@values )
   ##   Neither of these allows C< @list.join('sep') > to work.
   ##   In r20722 I changed S32::Containers to read
   ##     our Str multi method join ( @values: $separator = ' ' )
   ##     our Str multi join ( Str $separator = ' ', *@values )
   ##   This enables C< @list.join('sep') > to work, but now
   ##   C< 'foo'.join(':') > through method fallback is equivalent
   ##   to C< join('foo', ':') >, which results in ':' and not 'foo'.
   ##   Same is true for C< ('foo').join(':') >.
#
## from http://www.nntp.perl.org/group/perl.perl6.language/2008/06/msg29283.html
#
# Larry Wall writes:
#
## On Sat, Jun 14, 2008 at 01:46:10PM +0200, Moritz Lenz wrote:
## : Fallback semantics in S12 suggest that since no matching multi method is
## : found, subs are tried - that is, the expression is interpreted as
## :    join('str', 'other_str')
## : yielding 'other_str'. S32::Containers-list/join.t disagrees, and wants the
## : result to be 'str'.
##
## I want the result to be 'str'.

is('hi'.join(':'), 'hi', '"foo".join(":") should be the same as join(":", "foo")');
is(('hi').join(':'), 'hi', '("foo").join(":") should be the same as join(":", "foo")');

# vim: expandtab shiftwidth=4
