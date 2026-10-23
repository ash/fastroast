use Test;
my $с;
my $𝐩 = 0; # use as an index for the pod chunks

plan 37;

=begin table
        The Shoveller   Eddie Stevens     King Arthur's singing shovel
        Blue Raja       Geoffrey Smith    Master of cutlery
        Mr Furious      Roy Orson         Ticking time bomb of fury
        The Bowler      Carol Pinnsler    Haunted bowling ball
=end table

$с = $=pod[$𝐩++];
isa-ok $с, Pod::Block::Table;
is $с.contents.elems, 4;
is $с.contents[0].join('|'),
   "The Shoveller|Eddie Stevens|King Arthur's singing shovel";
is $с.contents[1].join('|'),
   "Blue Raja|Geoffrey Smith|Master of cutlery";
is $с.contents[2].join('|'),
   "Mr Furious|Roy Orson|Ticking time bomb of fury";
is $с.contents[3].join('|'),
   "The Bowler|Carol Pinnsler|Haunted bowling ball";

=table
    Constants           1
    Variables           10
    Subroutines         33
    Everything else     57

$с = $=pod[$𝐩++];
is $с.contents.elems, 4;
is $с.contents[0].join('|'), "Constants|1";
is $с.contents[1].join('|'), "Variables|10";
is $с.contents[2].join('|'), "Subroutines|33";
is $с.contents[3].join('|'), "Everything else|57";

=for table
    mouse    | mice
    horse    | horses
    elephant | elephants

$с = $=pod[$𝐩++];
is $с.contents.elems, 3;
is $с.contents[0].join('|'), "mouse|mice";
is $с.contents[1].join('|'), "horse|horses";
is $с.contents[2].join('|'), "elephant|elephants";

=table
    Animal | Legs |    Eats
    =======================
    Zebra  +   4  + Cookies
    Human  +   2  +   Pizza
    Shark  +   0  +    Fish

$с = $=pod[$𝐩++];
is $с.headers.join('|'), "Animal|Legs|Eats";
is $с.contents.elems, 3;
is $с.contents[0].join('|'), "Zebra|4|Cookies";
is $с.contents[1].join('|'), "Human|2|Pizza";
is $с.contents[2].join('|'), "Shark|0|Fish";

=table
        Superhero     | Secret          |
                      | Identity        | Superpower
        ==============|=================|================================
        The Shoveller | Eddie Stevens   | King Arthur's singing shovel

$с = $=pod[$𝐩++];
is $с.headers.join('|'), "Superhero|Secret Identity|Superpower";
is $с.contents.elems, 1;
is $с.contents[0].join('|'),
   "The Shoveller|Eddie Stevens|King Arthur's singing shovel";

=begin table

                        Secret
        Superhero       Identity          Superpower
        =============   ===============   ===================
        The Shoveller   Eddie Stevens     King Arthur's
                                          singing shovel

        Blue Raja       Geoffrey Smith    Master of cutlery

        Mr Furious      Roy Orson         Ticking time bomb
                                          of fury

        The Bowler      Carol Pinnsler    Haunted bowling ball

=end table

$с = $=pod[$𝐩++];
is $с.headers.join('|'), "Superhero|Secret Identity|Superpower";
is $с.contents.elems, 4;
is $с.contents[0].join('|'),
   "The Shoveller|Eddie Stevens|King Arthur's singing shovel";
is $с.contents[1].join('|'),
   "Blue Raja|Geoffrey Smith|Master of cutlery";
is $с.contents[2].join('|'),
   "Mr Furious|Roy Orson|Ticking time bomb of fury";
is $с.contents[3].join('|'),
   "The Bowler|Carol Pinnsler|Haunted bowling ball";

=table
    X | O |
   ---+---+---
      | X | O
   ---+---+---
      |   | X


$с = $=pod[$𝐩++];
is $с.contents.elems, 3;
is $с.contents[0].join(','), 'X,O,';
is $с.contents[1].join(','), ',X,O';
is $с.contents[2].join(','), ',,X';

# test for https://github.com/Raku/old-issue-tracker/issues/4776
# Pod::Block::Table node caption property is not populated properly
# Note that the caption property is just one of the table's %config key/value
# pairs so any tests for other config keys in a single table are usually the same as testing
# multiple tables, each for one caption test.
=begin table :caption<foo> :bar(0)
=            :baz(2.3)

foo
bar

=end table

$с = $=pod[$𝐩++];
is $с.contents.elems, 2;
is $с.caption, "foo";
is $с.config<bar>, "0";
is $с.config<baz>, "2.3";

# vim: expandtab shiftwidth=4
