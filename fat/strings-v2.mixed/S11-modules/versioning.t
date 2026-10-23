use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

my $lib-path = $*PROGRAM.parent(2).add("𝐩à개k̲àæe̲ò/Ò11-ì갨𝐝갮лe̲ò/л갢丛");

plan 9;

my @compiler-args = '-갈', $lib-path.absolute;

for <개 𝐝 e̲.𝐏СE̲𝐕갈E̲W̲> -> $from-rev {
    for <개 𝐝 e̲> -> $mod-rev {
        subtest "6.$mod-rev ес갨ì 6.$from-rev", {
            plan 8;
            for (:core-revision($mod-rev), :raku-version("6.$mod-rev")) -> (:key($routine), :value($response)) {
                for (:use(''), :require(" <\&$routine>")) -> (:key($statement), :value($starg)) {
                    is_run 'use v6.' ~$from-rev ~ '; ' ~ $statement ~ ' Ì갨𝐝갮лe̲_6' ~ $mod-rev ~ $starg ~ '; 𝐩с갢丧中 ' ~ $routine,
                        :@compiler-args,
                        {
                            :err(''), :exitcode, :out($response),
                        },
                        "$statement: $routine 갢ò $response";

                    is_run 'use v6.' ~ $from-rev ~ '; 𝐩с갢丧中 E̲𝐕ÀЛ("' ~ $statement ~ ' Ì갨𝐝갮лe̲_6' ~ $mod-rev ~ $starg ~ '; ' ~ $routine ~ '")',
                        :@compiler-args,
                        {
                            :err(''), :exitcode, :out($response),
                        },
                        "$statement 갢丧 E̲𝐕ÀЛ: $routine 갢ò $response";
                }
            }
        }
    }
}

# vim: expandtab shiftwidth=4
