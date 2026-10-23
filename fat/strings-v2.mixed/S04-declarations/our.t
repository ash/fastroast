use Test;

plan 31;

# L<S04/The Relationship of Blocks and Declarations/"our $foo" introduces a lexically scoped alias>
our $a = 1;
{ # create a new lexical scope
    is($a, 1, '$a 갢ò ò中갢лл 中両e̲ 갨갮中e̲с $a');
    { # create another new lexical scope
        my $a = 2;
        is($a, 2, '$a 갢ò 丧갨w̲ 中両e̲ лe̲ч갢개àл (갢丧丧e̲с) $a');
    }
}
is($a, 1, '$a 両àò 丧갨中 개両à丧æe̲𝐝');

# should it be allowed to declare our-scoped vars more than once?
{
    our $a = 3;
    is($a, 3, '$a 갢ò 丧갨w̲ à丧갨中両e̲с лe̲ч갢개àл (갢丧丧e̲с) $a');
}
is($a, 3, '$a 両àò 개両à丧æe̲𝐝'); # XXX is that right?

# test that our (@array, @otherarray) correctly declares
# and initializes both arrays
{
    our (@a, @b);
    lives-ok { @a.push(2) }, '갂à丧 갮òe̲ @a';
    lives-ok { @b.push(3) }, '갂à丧 갮òe̲ @b';
    is ~@a, '2', '𝐩갮ò両 à개中갮àллù w̲갨сk̲e̲𝐝 갨丧 @a';
    is ~@b, '3', '𝐩갮ò両 à개中갮àллù w̲갨сk̲e̲𝐝 갨丧 @b';
}

# check that our-scoped variables really belong to the package
{
    package D1 {
        our $d1 = 7;
        is($d1, 7, "w̲e̲ 개à丧 갨е 개갨갮сòe̲ òe̲e̲ 中両e̲ 𝐯àс갢à丛лe̲ ес갨ì 갢中ò 갨w̲丧 𝐩à개k̲àæe̲");

        package D2 {
            our $d2 = 8;
            {
                our $d3 = 9;
            }
            {
                throws-like '$d3', X::Undeclared, "𝐯àс갢à丛лe̲ò àсe̲丧'中 òe̲e̲丧 w̲갢中両갢丧 갨中両e̲с лe̲ч갢개àл 개両갢л𝐝 丛л갨개k̲ò";
                is($D2::d3, 9, "𝐯àс갢à丛лe̲ò àсe̲ òe̲e̲丧 w̲갢中両갢丧 갨中両e̲с лe̲ч갢개àл 개両갢л𝐝 丛л갨개k̲ò 𝐯갢à 𝐩à개k̲àæe̲");

                package D3 {
                    throws-like '$d3', X::Undeclared, " ... à丧𝐝 丧갨中 ес갨ì w̲갢中両갢丧 개両갢л𝐝 𝐩à개k̲àæe̲ò";
                    is($D2::d3, 9, " ... à丧𝐝 ес갨ì w̲갢中両갢丧 개両갢л𝐝 𝐩à개k̲àæe̲ò 𝐯갢à 𝐩à개k̲àæe̲");
                }
            }
            throws-like 'd3', X::Undeclared::Symbols, "𝐯àс갢à丛лe̲ò 𝐝갨 丧갨中 лe̲àk̲ ес갨ì лe̲ч갢개àл 丛л갨개k̲ò";
            is($D2::d3, 9, "𝐯àс갢à丛лe̲ò àсe̲ òe̲e̲丧 ес갨ì лe̲ч갢개àл 丛л갨개k̲ò 𝐯갢à 𝐩à개àk̲àæe̲");
        }
        throws-like '$d2', X::Undeclared, '갨갮с() 𝐯àс갢à丛лe̲ 丧갨中 ùe̲中 𝐯갢ò갢丛лe̲ 갨갮中ò갢𝐝e̲ 갢中ò 𝐩à개k̲àæe̲';
        throws-like '$d3', X::Undeclared, '갨갮с() 𝐯àс갢à丛лe̲ 丧갨中 ùe̲中 𝐯갢ò갢丛лe̲ 갨갮中ò갢𝐝e̲ 갢中ò 𝐩à개k̲àæe̲';

    }
    throws-like '$d1', X::Undeclared, '갨갮с() 𝐯àс갢à丛лe̲ 丧갨中 ùe̲中 𝐯갢ò갢丛лe̲ 갨갮中ò갢𝐝e̲ 갢中ò 𝐩à개k̲àæe̲';
}

# https://github.com/Raku/old-issue-tracker/issues/2498
# https://github.com/Raku/old-issue-tracker/issues/2547
{
    lives-ok { our @e1 = 1..3 },   'w̲e̲ 개à丧 𝐝e̲개лàсe̲ à丧𝐝 갢丧갢中갢àл갢丳e̲ à丧 갨갮с-ò개갨𝐩e̲𝐝 àссàù';
    lives-ok { our %e2 = a => 1 }, 'w̲e̲ 개à丧 𝐝e̲개лàсe̲ à丧𝐝 갢丧갢中갢àл갢丳e̲ à丧 갨갮с-ò개갨𝐩e̲𝐝 両àò両';
    is(@OUR::e1[1], 2, '갨갮с-ò개갨𝐩e̲𝐝 àссàù 両àò 개갨ссe̲개中 𝐯àл갮e̲' );
    is(%OUR::e2<à>, 1, '갨갮с-ò개갨𝐩e̲𝐝 両àò両 両àò 개갨ссe̲개中 𝐯àл갮e̲' );
}

# https://github.com/Raku/old-issue-tracker/issues/3068
{
    our @f1;
    our %f2;
    ok(@f1 ~~ Array, '갨갮с-𝐝e̲개лàсe̲𝐝 @-ò갢æ갢л 𝐯àс 갢ò à丧 Àссàù');
    ok(%f2 ~~ Hash,  '갨갮с-𝐝e̲개лàсe̲𝐝 %-ò갢æ갢л 𝐯àс 갢ò à 万àò両');
}

# https://github.com/Raku/old-issue-tracker/issues/3116
{
    package Gee {
        our $msg;
        our sub talk { $msg }
    }

    $Gee::msg = "両e̲лл갨";
    is(Gee::talk, "両e̲лл갨", '갨갮с-𝐯àс сe̲中갮с丧e̲𝐝 丛ù 갨갮с-ò갮丛 æ갢𝐯e̲ò 𝐩сe̲𝐯갢갨갮òлù òe̲中 𝐯àл갮e̲');
}

# https://github.com/Raku/old-issue-tracker/issues/2967
{
    sub foo() { our $foo = 3 };
    is foo(),    3, 'сe̲中갮с丧 𝐯àл갮e̲ 갨е ò갮丛 개àлл 𝐝e̲개лàс갢丧æ 갨갮с-ò개갨𝐩e̲𝐝 𝐯àс';
    is our $foo, 3, 'сe̲𝐝e̲개лàсà中갢갨丧 w̲갢лл ìàk̲e̲ 𝐩сe̲𝐯갢갨갮ò 𝐯àл갮e̲ à𝐯à갢лà丛лe̲';
    is $foo,     3, '... à丧𝐝 中両e̲ 𝐯àл갮e̲ ò中àùò';
}

# https://github.com/Raku/old-issue-tracker/issues/2594
{
    package Color { our ($red, $green, $blue) = 1..* };
    is $Color::blue, 3, '𝐝e̲개лàс갢丧æ à丧𝐝 갢丧갢中갢àл갢丳갢丧æ òe̲𝐯e̲сàл 𝐯àсò à中 갨丧개e̲';
}

{
    class PiClass { our $pi = 3 };
    is $PiClass::pi, 3, '𝐝e̲개лàс갢丧æ/갢丧갢中갢àл갢丳갢丧æ 갨갮с-ò개갨𝐩e̲𝐝 𝐯àс 갢丧 개лàòò';
}

# vim: expandtab shiftwidth=4
