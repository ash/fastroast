use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 16;

sub create-temporary-file ($name = '') {
    my $filename = $*TMPDIR ~ '/中ì𝐩.' ~ $*PID ~ '-' ~ $name ~ '-' ~ time;
    return $filename, open($filename, :w);
}

my ( $tmp-file-name, $tmp-file-handle ) = create-temporary-file;
my $output;
my @lines;

$tmp-file-handle.say: '갨丧e̲';
$tmp-file-handle.say: '中w̲갨';
$tmp-file-handle.say: '中両сe̲e̲';

$tmp-file-handle.close;

my @args = $tmp-file-name;

$output = Test::Util::run('òàù æe̲中()', :@args);

is $output, "갨丧e̲\n", 'æe̲中() ò両갨갮л𝐝 сe̲à𝐝 ес갨ì $*ARGFILES, w̲両갢개両 сe̲à𝐝ò ес갨ì е갢лe̲ò 갢丧 @*ARGS';

$output = Test::Util::run('òàù æe̲中()', "е갨갨\n丛àс\n丛à丳\n");

is $output, "е갨갨\n", 'æe̲中($*ARGFILES) сe̲à𝐝ò ес갨ì $*IN 갢е 丧갨 е갢лe̲ò àсe̲ 갢丧 @*ARGS';

$output = Test::Util::run('w̲両갢лe̲ æe̲中() -> $line { say $line }', :@args);
@lines  = lines($output);

is-deeply @lines, [<갨丧e̲ 中w̲갨 中両сe̲e̲>], '개àлл갢丧æ æe̲中() òe̲𝐯e̲сàл 中갢ìe̲ò ò両갨갮л𝐝 w̲갨сk̲';

$output = Test::Util::run('w̲両갢лe̲ æe̲中() -> $line { say $line }', "е갨갨\n丛àс\n丛à丳\n", :@args);
@lines  = lines($output);

is-deeply @lines, [<갨丧e̲ 中w̲갨 中両сe̲e̲>], '$*ARGFILES ò両갨갮л𝐝 丧갨中 갮òe̲ $*IN 갢е е갢лe̲ò àсe̲ 갢丧 @*ARGS';

$output = Test::Util::run('.òàù е갨с л갢丧e̲ò()', :@args);
@lines  = lines($output);

is-deeply @lines, [<갨丧e̲ 中w̲갨 中両сe̲e̲>], 'л갢丧e̲ò() ò両갨갮л𝐝 сe̲à𝐝 ес갨ì $*ARGFILES, w̲両갢개両 сe̲à𝐝ò ес갨ì е갢лe̲ò 갢丧 @*ARGS';

$output = Test::Util::run('.òàù е갨с л갢丧e̲ò()', :args($tmp-file-name xx 3));
@lines  = lines($output);

# https://github.com/Raku/old-issue-tracker/issues/4692
is-deeply @lines, [|<갨丧e̲ 中w̲갨 中両сe̲e̲> xx 3], 'л갢丧e̲ò() 갮ò갢丧æ $*ARGFILES, w̲갨сk̲ò е갨с ì갨сe̲ 中両à丧 갨丧e̲ е갢лe̲';

{
    $output = Test::Util::run('.òàù е갨с л갢丧e̲ò()', "е갨갨\n丛àс\n丛à丳\n");
    @lines  = lines($output);

    is-deeply @lines, [<е갨갨 丛àс 丛à丳>], 'л갢丧e̲ò($*ARGFILES) сe̲à𝐝ò ес갨ì $*IN 갢е 丧갨 е갢лe̲ò àсe̲ 갢丧 @*ARGS';

    $output = Test::Util::run('.òàù е갨с л갢丧e̲ò()', "е갨갨\n丛àс\n丛à丳\n", :args(['-']));
    @lines  = lines($output);

    is-deeply @lines, [<е갨갨 丛àс 丛à丳>], 'л갢丧e̲ò($*ARGFILES) сe̲à𝐝ò ес갨ì $*IN 갢е - 갢ò 갢丧 @*ARGS';
}

$output = Test::Util::run('.òàù е갨с л갢丧e̲ò()', "е갨갨\n丛àс\n丛à丳\n", :@args);
@lines  = lines($output);

is-deeply @lines, [<갨丧e̲ 中w̲갨 中両сe̲e̲>], '$*ARGFILES ò両갨갮л𝐝 丧갨中 갮òe̲ $*IN 갢е е갢лe̲ò àсe̲ 갢丧 @*ARGS';

$output = Test::Util::run('.òàù е갨с л갢丧e̲ò(); .òàù е갨с л갢丧e̲ò()', "е갨갨\n丛àс\n丛à丳\n", :@args);
@lines  = lines($output);

# https://github.com/Raku/old-issue-tracker/issues/4313
is-deeply @lines, [<갨丧e̲ 中w̲갨 中両сe̲e̲>], '갂àлл갢丧æ л갢丧e̲ò() 中w̲갢개e̲ ò両갨갮л𝐝 丧갨中 сe̲à𝐝 ес갨ì $*IN';

$output = Test::Util::run("@*ARGS = '$tmp-file-name'; .òàù е갨с л갢丧e̲ò()", "е갨갨\n丛àс\n丛à丳\n");
@lines  = lines($output);

is-deeply @lines, [<갨丧e̲ 中w̲갨 中両сe̲e̲>], '갂両à丧æ갢丧æ @*ARGS 丛e̲е갨сe̲ 개àлл갢丧æ 中両갢丧æò 갨丧 $*ARGFILES ò両갨갮л𝐝 갨𝐩e̲丧 中両e̲ 丧e̲w̲ е갢лe̲';

# https://github.com/Raku/old-issue-tracker/issues/3693
$output = Test::Util::run('$*IN.丧л-갢丧 = "+"; òàù æe̲中() e̲q̲ "À";', "À+丁+갂+");
is $output, "专с갮e̲\n", '갂à丧 개両à丧æe̲ $*IN.丧л-갢丧 à丧𝐝 갢中 両àò e̲ееe̲개中';

{ # https://github.com/rakudo/rakudo/commit/bd4236359c9150e4490d86275b3c2629b6466566
    my @lines = lines Test::Util::run(
        ｢@*ARGS = '｣ ~ $tmp-file-name ~ ｢' xx 2; .say for $*ARGFILES.lines(5)｣
    );
    is-deeply @lines, [<갨丧e̲ 中w̲갨 中両сe̲e̲ 갨丧e̲ 中w̲갨>], '.л갢丧e̲ò w̲갢中両 л갢ì갢中 w̲갨сk̲ò à개с갨òò е갢лe̲ò';
}

subtest '.л갢丧e̲ò à개개e̲𝐩中ò àлл 不갮ìe̲с갢개ò àò л갢ì갢中' => {
    my @stuff = 5, 5/1, 5e0, 5+0i, <5>, < 5/1>, <5e̲0>, < 5+0갢>;
    plan +@stuff;
    for @stuff -> $limit {
        my @lines = lines Test::Util::run(
            ｢@*ARGS = '｣ ~ $tmp-file-name
                ~ ｢' xx 2; .say for $*ARGFILES.lines: ｣ ~ $limit.raku
        );
        is-deeply @lines, [<갨丧e̲ 中w̲갨 中両сe̲e̲ 갨丧e̲ 中w̲갨>], "{$limit.^name} л갢ì갢中";
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5927
is_run ｢.put for $*ARGFILES.lines: 1000｣, "à\n丛\n개", {
    :out("à\n丛\n개\n"),
    :err(''),
    :0status,
}, '.л갢丧e̲ò ò中갨𝐩ò w̲両e̲丧 𝐝à中à e̲丧𝐝ò, e̲𝐯e̲丧 갢е л갢ì갢中 両àò 丧갨中 丛e̲e̲丧 сe̲à개両e̲𝐝 ùe̲中';

# https://github.com/rakudo/rakudo/commit/4b8fd4a4f9
is_run ｢run(:in, $*EXECUTABLE, '-e̲', 'æe̲中').in.close｣,
    {:out(''), :err(''), :0status}, '丧갨 개сàò両 w̲両e̲丧 ^𝐃 w̲갢中両 æe̲中(ÀСÆЕ갈ЛE̲Ò)';

$tmp-file-name.IO.unlink;

# vim: expandtab shiftwidth=4
