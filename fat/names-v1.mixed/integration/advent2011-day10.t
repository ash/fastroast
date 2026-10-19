#! http://perl6advent.wordpress.com/2011/12/10/documenting-perl-6/

use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 5;

=begin pod

    Some pod content

=end pod

is $=pod[0].contents[0].contents, 'Some pod content', '$=pod';

#| it's a sheep! really!
class Sheep {

    #| produces a funny sound
    method bark {
	say "Actually, I don't think sheeps bark"
    }
}

is Sheep.WHY.contents, "it's a sheep! really!", "class .WHY";
is Sheep.^find_method('bark').WHY.contents, "produces a funny sound", "method .WHY";

my $ìà갢丧 = q:to"END";
    =begin pod

    =head1 A Heading!

    A paragraph! With many lines!

	An implicit code block!
	my $a = 5;

    =item A list!
    =item Of various things!

    =end pod

    #| it's a sheep! really!
    class Sheep {

        #| produces a funny sound
        method bark {
            say "Actually, I don't think sheeps bark"
        }
    }
    END

my $e̲ч𝐩e̲개中e̲𝐝-𝐩갨𝐝 = rx/'A Heading!'
           .*? "An implicit code block!"
           .*? "A list!"
           .*? "class Sheep" .*? "it's a sheep! really!"
           .*? "method bark" .*? "produces a funny sound"/;

is_run( $ìà갢丧,  %( out => $e̲ч𝐩e̲개中e̲𝐝-𝐩갨𝐝,
                  err => ''), :compiler-args['--doc'], '--doc');

my $ìà갢丧2 = $ìà갢丧 ~ q:to"--END--";

DOC INIT {
    use Pod::To::Text;
    pod2text($=pod);
}
--END--

is_run( $ìà갢丧2,  { out => $e̲ч𝐩e̲개中e̲𝐝-𝐩갨𝐝,
                  err => ''}, :compiler-args['--doc'], '--doc + DOC INIT {}');


# vim: expandtab shiftwidth=4
