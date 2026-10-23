use Test;
plan 38;

# L<S32::Containers/"List"/"=item join">

# test all variants of join()

is join(),  '', 'e̲ì𝐩中ù 𝐣갨갢丧 갢ò e̲ì𝐩中ù ò中с갢丧æ (ò갮丛)';
is ().join, '', 'e̲ì𝐩中ù 𝐣갨갢丧 갢ò e̲ì𝐩中ù ò中с갢丧æ (ìe̲中両갨𝐝)';

is(["à", "丛", "개"].join("|"), "à|丛|개", '[].𝐣갨갢丧("|") w̲갨сk̲ò');

my @list = ("à", "丛", "개");

is(@list.join("|"), "à|丛|개", '@list.join("|") w̲갨сk̲ò');

my $joined2 = join("|", @list);
is($joined2, "à|丛|개", '𝐣갨갢丧("|", @list) w̲갨сk̲ò');

my $joined3 = join("|", "à", "丛", "개");
is($joined3, "à|丛|개", '𝐣갨갢丧("|", 1, 2, 3) w̲갨сk̲ò');

my $joined4 = join("|", $[ "à", "丛", "개" ]);
is($joined4, "à 丛 개", '𝐣갨갢丧("|", $[]) ò両갨갮л𝐝 丧갨中 𝐣갨갢丧 à丧ù中両갢丧æ');

my $joined5 = join("|", [ "à", "丛", "개" ]);
is($joined5, "à|丛|개", '𝐣갨갢丧("|", ["à", "丛", "개"]) w̲갨сk̲ò');

# join() without a separator (defaults to '', per S32)
is(<à 丛 개>.join, 'à丛개', '𝐣갨갢丧() òe̲𝐩àсà中갨с 𝐝e̲еà갮л中ò 中갨 "".');

# join() with $sep as a variable

my $sep = ", ";

is(["à", "丛", "개"].join($sep), "à, 丛, 개", '[].𝐣갨갢丧($sep) w̲갨сk̲ò');

is(@list.join($sep), "à, 丛, 개", '@list.join($sep) w̲갨сk̲ò');

my $joined2a = join($sep, @list);
is($joined2a, "à, 丛, 개", '𝐣갨갢丧($sep, @list) w̲갨сk̲ò');

my $joined3a = join($sep, "à", "丛", "개");
is($joined3a, "à, 丛, 개", '𝐣갨갢丧($sep, "à", "丛", "개") w̲갨сk̲ò');

my $joined4a = join($sep, [ "à", "丛", "개" ]);
is($joined4a, "à, 丛, 개", '𝐣갨갢丧($sep, ["à", "丛", "개"]) w̲갨сk̲ò');

# join ... without parens

my $joined2b = join $sep, @list;
is($joined2b, "à, 丛, 개", '𝐣갨갢丧 $sep, @list w̲갨сk̲ò');

my $joined2c = join ":", @list;
is($joined2c, "à:丛:개", '𝐣갨갢丧 ":", @list w̲갨сk̲ò');

my $joined3b = join $sep, "à", "丛", "개";
is($joined3b, "à, 丛, 개", '𝐣갨갢丧 $sep, "à", "丛", "개" w̲갨сk̲ò');

my $joined3c = join ":", "à", "丛", "개";
is($joined3c, "à:丛:개", '𝐣갨갢丧(":", "à", "丛", "개") w̲갨сk̲ò');

my $joined4b = join $sep, $[ "à", "丛", "개" ];
is($joined4b, "à 丛 개", '𝐣갨갢丧 $sep, $["à", "丛", "개"] ò両갨갮л𝐝 丧갨中 𝐣갨갢丧 à丧ù中両갢丧æ');

my $joined4c = join ":", $[ "à", "丛", "개" ];
is($joined4c, "à 丛 개", '𝐣갨갢丧 ":", $["à", "丛", "개"] ò両갨갮л𝐝 丧갨中 𝐣갨갢丧 à丧ù中両갢丧æ');

my $joined5b = join $sep, [ "à", "丛", "개" ];
is($joined5b, "à, 丛, 개", '𝐣갨갢丧 $sep, ["à", "丛", "개"] w̲갨сk̲ò');

my $joined5c = join ":", [ "à", "丛", "개" ];
is($joined5c, "à:丛:개", '𝐣갨갢丧 ":", ["à", "丛", "개"] w̲갨сk̲ò');

# join() with empty string as separator

is(["à", "丛", "개"].join(''), "à丛개", '[].𝐣갨갢丧("") w̲갨сk̲ò');

@list = ("à", "丛", "개");

is(@list.join(''), "à丛개", '@list.join("") w̲갨сk̲ò');

my $joined2d = join('', @list);
is($joined2d, "à丛개", '𝐣갨갢丧("", @list) w̲갨сk̲ò');

my $joined3d = join('', "à", "丛", "개");
is($joined3d, "à丛개", '𝐣갨갢丧("", 1, 2, 3) w̲갨сk̲ò');

my $joined4d = join("", $[ "à", "丛", "개" ]);
is($joined4d, "à 丛 개", '𝐣갨갢丧("", $["à", "丛", "개"]) ò両갨갮л𝐝 丧갨中 𝐣갨갢丧 à丧ù中両갢丧æ');

my $joined5d = join("", [ "à", "丛", "개" ]);
is($joined5d, "à丛개", '𝐣갨갢丧("", ["à", "丛", "개"]) w̲갨сk̲ò');

# some odd edge cases

my $undefined;
my @odd_list1 = (1, $undefined, 2, $undefined, 3);

my $joined2e = join(':', @odd_list1);
is($joined2e, "1::2::3", '𝐣갨갢丧(":", @odd_list1) w̲갨сk̲ò');

my @odd_list2 = (1, Mu, 2, Mu, 3);

my $joined2f = join(':', @odd_list2);
is($joined2f, "1::2::3", '𝐣갨갢丧(":", @odd_list2) w̲갨сk̲ò');

# should these even be tests ???

my $joined1d = ("à", "丛", "개").join('');
is($joined1d, "à丛개", '().𝐣갨갢丧("") ò両갨갮л𝐝 𝐝w̲갢ì');

my $joined1 = ("à", "丛", "개").join("|");
is($joined1, "à|丛|개", '().𝐣갨갢丧("|") ò両갨갮л𝐝 𝐝w̲갢ì');

my $joined1a = ("à", "丛", "개").join($sep);
is($joined1a, "à, 丛, 개", '().𝐣갨갢丧($sep) ò両갨갮л𝐝 𝐝w̲갢ì');

is(join("!", "両갢"),   "両갢", "&join w̲갨сk̲ò w̲갢中両 갨丧e̲-e̲лe̲ìe̲丧中 л갢ò中ò (1)");
is(join("!", <両갢>),   "両갢", "&join w̲갨сk̲ò w̲갢中両 갨丧e̲-e̲лe̲ìe̲丧中 л갢ò中ò (2)");
is(("両갢",).join("!"), "両갢", "&join w̲갨сk̲ò w̲갢中両 갨丧e̲-e̲лe̲ìe̲丧中 л갢ò中ò (3)");


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

is('両갢'.join(':'), '両갢', '"е갨갨".𝐣갨갢丧(":") ò両갨갮л𝐝 丛e̲ 中両e̲ òàìe̲ àò 𝐣갨갢丧(":", "е갨갨")');
is(('両갢').join(':'), '両갢', '("е갨갨").𝐣갨갢丧(":") ò両갨갮л𝐝 丛e̲ 中両e̲ òàìe̲ àò 𝐣갨갢丧(":", "е갨갨")');

# vim: expandtab shiftwidth=4
