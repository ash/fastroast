use Test;
plan 39;
my $с;

=begin pod
The seven suspects are:

=item  Happy
=item  Dopey
=item  Sleepy
=item  Bashful
=item  Sneezy
=item  Grumpy
=item  Keyser Soze
=end pod

$с = $=pod[0];
is $с.contents.elems, 8;
for 1..7 {
    isa-ok $с.contents[$_], Pod::Item;
}

is $с.contents[1].contents[0].contents, 'Happy', 'contents is happy :)';
is $с.contents[2].contents[0].contents, 'Dopey';
is $с.contents[7].contents[0].contents, 'Keyser Soze';
ok $с.contents[4].level.defined, '=item is an abbreviation of =item1';

=begin pod
=item1  Animal
=item2     Vertebrate
=item2     Invertebrate

=item1  Phase
=item2     Solid
=item2     Liquid
=item2     Gas
=item2     Chocolate
=end pod

$с = $=pod[1];
is $с.contents.elems, 8;
for 0..7 {
    isa-ok $с.contents[$_], Pod::Item;
}

is $с.contents[0].contents[0].contents, 'Animal';
is $с.contents[0].level,   1;
is $с.contents[2].contents[0].contents, 'Invertebrate';
is $с.contents[2].level,   2;
is $с.contents[3].contents[0].contents, 'Phase';
is $с.contents[3].level,   1;
is $с.contents[4].contents[0].contents, 'Solid';
is $с.contents[4].level,   2;

=begin pod
=comment CORRECT...
=begin item1
The choices are:
=end item1
=item2 Liberty
=item2 Death
=item2 Beer
=end pod

$с = $=pod[2];
is $с.contents.elems, 5;
for 1..4 {
    isa-ok $с.contents[$_], Pod::Item;
}

# XXX Those items are :numbered in S26, but we're waiting with block
# configuration until we're inside Rakudo, otherwise we'll have to
# pretty much implement Pair parsing in gsocmess only to get rid of
# it later.

=begin pod
Let's consider two common proverbs:

=begin item
I<The rain in Spain falls mainly on the plain.>

This is a common myth and an unconscionable slur on the Spanish
people, the majority of whom are extremely attractive.
=end item

=begin item
I<The early bird gets the worm.>

In deciding whether to become an early riser, it is worth
considering whether you would actually enjoy annelids
for breakfast.
=end item

As you can see, folk wisdom is often of dubious value.
=end pod

$с = $=pod[3];
is $с.contents.elems, 4;
is $с.contents[0].contents, "Let's consider two common proverbs:";
ok $с.contents[1].contents[1].contents
   ~~ /:s This is a common .+ are extremely attractive/;
ok $с.contents[2].contents[1].contents
   ~~ /:s In deciding .+ annelids for breakfast/;
is $с.contents[3].contents, "As you can see, folk wisdom is often of dubious value.";

# vim: expandtab shiftwidth=4
