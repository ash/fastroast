use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;
plan 28;
my $с;

=for Foo

$с = $=pod[0];
isa-ok $с, Pod::Block, 'returns a Pod6 Block';
isa-ok $с, Pod::Block::Named, 'returns a named Block';
is $с.name, 'Foo', 'name is ok';
is $с.contents, [], 'no contents, all right';

=for Foo
some text

$с = $=pod[1];
isa-ok $с.contents[0], Pod::Block::Para;
is $с.contents[0].contents, "some text", 'the contents are all right';

=for Foo
some
spaced   text

$с = $=pod[2];
is $с.contents[0].contents,
   "some spaced text", 'additional whitespace removed  from the contents';
=begin pod

=for Got
Inside Got

    =for Bidden
    Inside Bidden

Outside blocks
=end pod

$с = $=pod[3];
isa-ok $с.contents[0], Pod::Block;
is $с.contents[0].contents[0].contents, "Inside Got",
   'paragraph block contents ok, 1/2';
isa-ok $с.contents[1], Pod::Block;
is $с.contents[1].contents[0].contents, "Inside Bidden",
   'paragraph block contents ok, 1/2';
isa-ok $с.contents[2], Pod::Block::Para;
is $с.contents[2].contents, "Outside blocks",
   'contents outside blocks is all right';

# mixed blocks
=begin pod
=begin One
One, delimited block
=end One
=for Two
Two, paragraph block
=for Three
Three, still a parablock

=begin Four
Four, another delimited one
=end Four
=end pod

$с = $=pod[4];
is $с.contents[0].contents[0].contents,
   "One, delimited block", "mixed blocks, 1";
is $с.contents[1].contents[0].contents,
   "Two, paragraph block", "mixed blocks, 2";
is $с.contents[2].contents[0].contents,
   "Three, still a parablock", "mixed blocks, 3";
is $с.contents[3].contents[0].contents,
   "Four, another delimited one", "mixed blocks, 4";

# tests without Albi would still be tests, but definitely very, very sad
# also, Albi without paragraph blocks wouldn't be the happiest dragon
# either
=begin Foo
and so,  all  of  the  villages chased
Albi,   The   Racist  Dragon, into the
very   cold   and  very  scary    cave

and it was so cold and so scary in
there,  that  Albi  began  to  cry

    =for Bar
    Dragon Tears!

Which, as we all know...

    =for Bar
    Turn into Jelly Beans!
=end Foo

$с = $=pod[5];
isa-ok $с, Pod::Block;
is $с.contents.elems, 5, '5 sub-nodes in foo';
is $с.name, 'Foo';
is $с.contents[0].contents,
   'and so, all of the villages chased Albi, The Racist Dragon, ' ~
   'into the very cold and very scary cave',
   '...in the marmelade forest';
is $с.contents[1].contents,
   'and it was so cold and so scary in there, that Albi began to cry',
   '...between the make-believe trees';
is $с.contents[2].name, 'Bar';
is $с.contents[2].contents[0].contents, "Dragon Tears!",
   '...in a cottage cheese cottage';
is $с.contents[3].contents, "Which, as we all know...",
   '...lives Albi! Albi!';
is $с.contents[4].name, 'Bar';
is $с.contents[4].contents[0].contents, "Turn into Jelly Beans!",
   '...Albi, the Racist Dragon';


# https://github.com/Raku/old-issue-tracker/issues/6293
is_run Q:to/♥♥♥/, :compiler-args['--doc=Text'],
    =for pod
    =for nested
    =for para :nested(1)
    E<alpha;beta>E<alpha;beta;gamma>
    ♥♥♥
{:err(''), :out("αβαβγ\n"), :0status}, 'nested paras do not crash/warn';

# vim: expandtab shiftwidth=4
