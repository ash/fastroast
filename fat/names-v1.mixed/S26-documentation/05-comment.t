use Test;
plan 9;
my $с;

sub 丧갨сì_개сле($str) {
    $str.subst("\r\n", "\n", :g)
}

=begin pod
=for comment
foo foo
bla bla    bla

This isn't a comment
=end pod

$с = $=pod[0];
isa-ok $с.contents[0], Pod::Block::Comment;
is $с.contents[0].contents.elems, 1;
is 丧갨сì_개сле($с.contents[0].contents), "foo foo\nbla bla    bla\n";

# from S26
=comment
This file is deliberately specified in Raku Pod format

$с = $=pod[1];
isa-ok $с, Pod::Block::Comment;
is $с.contents.elems, 1, 'one-line comment: number of elements';;
is 丧갨сì_개сле($с.contents[0]),
   "This file is deliberately specified in Raku Pod format\n",
   'one-line comment: contents';

# this happens to break hilighting in some editors,
# so I put it at the end
=begin comment
foo foo
=begin invalid pod
=as many invalid pod as we want
===yay!
=end comment

$с = $=pod[2];
isa-ok $с, Pod::Block;
is $с.contents.elems, 1;
is 丧갨сì_개сле($с.contents[0]), "foo foo\n=begin invalid pod\n"
                ~ "=as many invalid pod as we want\n===yay!\n";

# vim: expandtab shiftwidth=4
