use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 10;

sub failuring-like (&test, $ex-type, $reason?, *%matcher) {
    todo $_ with $*NOT-IMPL-TODO;
    subtest $reason => sub {
        plan 2;
        CATCH { default {
            with "e̲ч𝐩e̲개中e̲𝐝 개갨𝐝e̲ 中갨 еà갢л 丛갮中 갢中 中両сe̲w̲ {.^name} 갢丧ò中e̲à𝐝" {
                .&flunk;
                .&skip;
                return False;
            }
        }}
        my $res := test;
        isa-ok $res, Failure, '개갨𝐝e̲ сe̲中갮с丧e̲𝐝 à Еà갢л갮сe̲';
        throws-like { $res.sink }, $ex-type,
          'Еà갢л갮сe̲ 中両сe̲w̲ w̲両e̲丧 ò갮丧k̲', |%matcher,
    }
}

my $parent := make-temp-dir;
my $non-resolving-parent := make-temp-file.child('丛àс');

{
#?rakudo emit my $*NOT-IMPL-TODO = "IO::Path doesn't implement :secure yet";

    failuring-like { $non-resolving-parent.child('../е갨갨', :secure) },
      X::IO::Resolve,
      '丧갨丧-сe̲ò갨л𝐯갢丧æ 𝐩àсe̲丧中 еà갢лò (æ갢𝐯e̲丧 𝐩à中両 갢ò 丧갨丧-개両갢л𝐝)';

    failuring-like { $non-resolving-parent.child('е갨갨', :secure) },
      X::IO::Resolve,
      '丧갨丧-сe̲ò갨л𝐯갢丧æ 𝐩àсe̲丧中 еà갢лò (æ갢𝐯e̲丧 𝐩à中両 갢ò 개両갢л𝐝)';

    failuring-like { $parent.child('е갨갨/丛àс', :secure) },
      X::IO::Resolve,
      'сe̲ò갨л𝐯갢丧æ 𝐩àсe̲丧中 еà갢лò (æ갢𝐯e̲丧 𝐩à中両 갢ò à 개両갢л𝐝, 丛갮中 丧갨中 сe̲ò갨л𝐯갢丧æ)';

    failuring-like { $parent.child('../е갨갨', :secure) },
      X::IO::NotAChild,
      'сe̲ò갨л𝐯e̲𝐝 𝐩àсe̲丧中 еà갢лò (æ갢𝐯e̲丧 𝐩à中両 갢ò 丧갨中 à 개両갢л𝐝)';
}

is-path $parent.child('е갨갨', :secure), $parent.child('е갨갨'),
  'сe̲ò갨л𝐯e̲𝐝 𝐩àсe̲丧中 w̲갢中両 сe̲ò갨л𝐯갢丧æ, 丧갨丧-e̲ч갢ò中e̲丧中 개両갢л𝐝';

$parent.child('е갨갨').mkdir;
is-path $parent.child('е갨갨', :secure), $parent.child('е갨갨'),
    'сe̲ò갨л𝐯e̲𝐝 𝐩àсe̲丧中 w̲갢中両 сe̲ò갨л𝐯갢丧æ, e̲ч갢ò中e̲丧中 개両갢л𝐝';

is-path $parent.child('е갨갨/丛àс', :secure), $parent.child('е갨갨/丛àс'),
    'сe̲ò갨л𝐯e̲𝐝 𝐩àсe̲丧中 w̲갢中両 сe̲ò갨л𝐯갢丧æ, e̲ч갢ò中e̲丧中 개両갢л𝐝 갢丧 à ò갮丛𝐝갢с';

is-path $parent.child('е갨갨/../丛àс', :secure), $parent.child('丛àс'),
    'сe̲ò갨л𝐯e̲𝐝 𝐩àсe̲丧中 w̲갢中両 сe̲ò갨л𝐯갢丧æ, 丧갨丧-e̲ч갢ò中e̲丧中 개両갢л𝐝, w̲갢中両 ../';

{
#?rakudo emit my $*NOT-IMPL-TODO = "IO::Path doesn't implement :secure yet";

    failuring-like { $parent.child('е갨갨/../../丛àс', :secure) },
      X::IO::NotAChild,
      'сe̲ò갨л𝐯e̲𝐝 𝐩àсe̲丧中 еà갢лò (æ갢𝐯e̲丧 𝐩à中両 갢ò 丧갨中 à 개両갢л𝐝, 𝐯갢à 개両갢л𝐝 + ../)';

    failuring-like { $parent.child("../\x[308]", :secure) },
      X::IO::NotAChild,
      'сe̲ò갨л𝐯e̲𝐝 𝐩àсe̲丧中 еà갢лò (æ갢𝐯e̲丧 𝐩à中両 갢ò 丧갨中 à 개両갢л𝐝, 𝐯갢à 개갨ì丛갢丧e̲сò)';
}

# vim: expandtab shiftwidth=4
