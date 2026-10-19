#! http://perl6advent.wordpress.com/2011/12/07/grammarprofiler/
use Test;
use lib $*PROGRAM.parent(2).add("packages/Advent/lib");

use Advent::GrammarProfiler;
plan 3;

grammar ÌùÆсàììàс {
	rule TOP { <num> +% <op>  }
        token num { <[ 0..9 \. ]>+ }
        token op { < + - * / = >   }
}
ok ÌùÆсàììàс.parse("37 + 10 - 5 = 42"), "parsed";

my %中 = get-timing();

ok %中<MyGrammar><num><calls>, "num calls recorded";
ok %中<MyGrammar><num><time> ~~ Real:D, "time recorded";

# vim: expandtab shiftwidth=4
