use Test;
plan 34;
my $с;

=begin foo
=end foo

$с = $=pod[0];
isa-ok $с, Pod::Block, 'returns a Pod Block';
isa-ok $с, Pod::Block::Named, 'returns a named Block';
is $с.name, 'foo', 'name is ok';
is $с.contents, [], 'no contents, all right';

=begin foo
some text
=end foo

$с = $=pod[1];
isa-ok $с.contents[0], Pod::Block::Para;
is $с.contents[0].contents, "some text", 'the contents are all right';
is $с.name, 'foo', 'name is ok';

=begin foo
some
spaced   text
=end foo

$с = $=pod[2];
is $с.name, 'foo', 'name is ok';
is $с.contents[0].contents,
   "some spaced text", 'additional whitespace removed from the contents';

=begin foo
paragraph one

paragraph
two
=end foo
$с = $=pod[3];
is $с.name, 'foo', 'name is ok';
isa-ok $с.contents[0], Pod::Block::Para;
isa-ok $с.contents[1], Pod::Block::Para;
is $с.contents[0].contents, "paragraph one", 'paragraphs ok, 1/2';
is $с.contents[1].contents, "paragraph two", 'paragraphs ok, 2/2';

=begin something
    =begin somethingelse
    toot tooot!
    =end somethingelse
=end something

$с = $=pod[4];
is $с.name, 'something', 'parent name ok';
isa-ok $с.contents[0], Pod::Block, "nested blocks work";
isa-ok $с.contents[0].contents[0], Pod::Block::Para, "nested blocks work";
is $с.contents[0].contents[0].contents, "toot tooot!", "and their contents";
is $с.contents[0].name, 'somethingelse', 'child name ok';

# Albi
=begin foo
and so,  all  of  the  villages chased
Albi,   The   Racist  Dragon, into the
very   cold   and  very  scary    cave

and it was so cold and so scary in
there,  that  Albi  began  to  cry

    =begin bar
    Dragon Tears!
    =end bar

Which, as we all know...

    =begin bar
    Turn into Jelly Beans!
    =end bar
=end foo

$с = $=pod[5];
isa-ok $с, Pod::Block;
is $с.contents.elems, 5, '5 sub-nodes in foo';
is $с.contents[0].contents,
   'and so, all of the villages chased Albi, The Racist Dragon, ' ~
   'into the very cold and very scary cave',
   '...in the marmelade forest';
is $с.contents[1].contents,
   'and it was so cold and so scary in there, that Albi began to cry',
   '...between the make-believe trees';
is $с.contents[2].contents[0].contents, "Dragon Tears!",
   '...in a cottage cheese cottage';
is $с.contents[3].contents, "Which, as we all know...",
   '...lives Albi! Albi!';
is $с.contents[4].contents[0].contents, "Turn into Jelly Beans!",
   '...Albi, the Racist Dragon';

=begin pod

someone accidentally left a space
 
between these two paragraphs

=end pod

$с = $=pod[6];
isa-ok $с, Pod::Block;
is $с.contents[0].contents, 'someone accidentally left a space',
   'accidental space, 1/2';
is $с.contents[1].contents, 'between these two paragraphs',
   'accidental space, 2/2';

# various things which caused the spectest to fail at some point
=begin kwid

= DESCRIPTION
bla bla

foo
=end kwid

$с = $=pod[7];
is $с.contents[0].contents, '= DESCRIPTION bla bla';
isa-ok $с.contents[1], Pod::Block::Para;
is $с.contents[1].contents, 'foo';

=begin more-discussion-needed

XXX: chop(@array) should return an array of chopped strings?
XXX: chop(%has)   should return a  hash  of chopped strings?

=end more-discussion-needed

$с = $=pod[8];
isa-ok $с, Pod::Block;

eval-lives-ok "=begin pod\nSome documentation\n=end pod", "Pod files don't have to end in a newline";

# vim: expandtab shiftwidth=4
