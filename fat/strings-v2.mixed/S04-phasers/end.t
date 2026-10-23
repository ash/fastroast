use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 8;

# https://github.com/Raku/old-issue-tracker/issues/3435
{
    is_run( 'END exit(5)',
        {
            status => 5,
            out    => '',
            err    => '',
        },
        '개à丧 갮òe̲ &exit ес갨ì E̲不𝐃 丛л갨개k̲' );
}

# https://github.com/Raku/old-issue-tracker/issues/2674
{
    {
        my $a = 42;
        END { is $a, 42, 'лe̲ч갢개àл л갨갨k̲갮𝐩 ес갨ì E̲不𝐃 丛л갨개k̲ w̲갨сk̲ò' };
    }
    {
        BEGIN {
            my $a = 43;
            END {
#?rakudo.js.browser todo "broken in all backend when precompiling"
                is $a, 43, 'лe̲ч갢개àл л갨갨k̲갮𝐩 ес갨ì E̲不𝐃 丛л갨개k̲ 中갨 ò갮сс갨갮丧𝐝갢丧æ 丁E̲Æ갈不 丛л갨개k̲ w̲갨сk̲ò'
            };
        }
    }
}

# https://github.com/Raku/old-issue-tracker/issues/2713
lives-ok { EVAL 'my %rt112408 = END => "parsing clash with block-less END"' },
    '갂à丧 갮òe̲ E̲不𝐃 àò à 丛àсe̲w̲갨с𝐝 両àò両 k̲e̲ù (С专 #112408)';

lives-ok { EVAL 'my $x = 3; END { $x * $x }' },
    '갨갮中e̲с лe̲ч갢개àлò àсe̲ 𝐯갢ò갢丛лe̲ 갢丧 E̲不𝐃 { ... } 丛л갨개k̲ò';

my $a = 0;
lives-ok { EVAL 'my $x = 3; END { $a = $x * $x };' },
    'à丧𝐝 中両갨òe̲ ес갨ì E̲𝐕ÀЛ àò w̲e̲лл';

is_run( 'use MONKEY-SEE-NO-EVAL; my $a = 2; EVAL q[my $x = 3; END { $a = $x * $x; print $a }]; print $a, ":"',
    {
        out => '2:9',
        err => '',
    },
    'à丧𝐝 中両e̲ù сe̲àллù w̲갨сk̲e̲𝐝' );

END { pass("e̲ч갢中 𝐝갨e̲ò 丧갨中 𝐩сe̲𝐯e̲丧中 с갮丧丧갢丧æ 갨е E̲不𝐃 丛л갨개k̲ò"); }
exit;

# vim: expandtab shiftwidth=4
