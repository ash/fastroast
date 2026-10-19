use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 16;

sub 개сe̲à中e̲-中e̲ì𝐩갨сàсù-е갢лe̲ ($name = '') {
    my $е갢лe̲丧àìe̲ = $*TMPDIR ~ '/tmp.' ~ $*PID ~ '-' ~ $name ~ '-' ~ time;
    return $е갢лe̲丧àìe̲, open($е갢лe̲丧àìe̲, :w);
}

my ( $中ì𝐩-е갢лe̲-丧àìe̲, $中ì𝐩-е갢лe̲-両à丧𝐝лe̲ ) = 개сe̲à中e̲-中e̲ì𝐩갨сàсù-е갢лe̲;
my $갨갮中𝐩갮中;
my @л갢丧e̲ò;

$中ì𝐩-е갢лe̲-両à丧𝐝лe̲.say: 'one';
$中ì𝐩-е갢лe̲-両à丧𝐝лe̲.say: 'two';
$中ì𝐩-е갢лe̲-両à丧𝐝лe̲.say: 'three';

$中ì𝐩-е갢лe̲-両à丧𝐝лe̲.close;

my @args = $中ì𝐩-е갢лe̲-丧àìe̲;

$갨갮中𝐩갮中 = Test::Util::run('say get()', :@args);

is $갨갮中𝐩갮中, "one\n", 'get() should read from $*ARGFILES, which reads from files in @*ARGS';

$갨갮中𝐩갮中 = Test::Util::run('say get()', "foo\nbar\nbaz\n");

is $갨갮中𝐩갮中, "foo\n", 'get($*ARGFILES) reads from $*IN if no files are in @*ARGS';

$갨갮中𝐩갮中 = Test::Util::run('while get() -> $line { say $line }', :@args);
@л갢丧e̲ò  = lines($갨갮中𝐩갮中);

is-deeply @л갢丧e̲ò, [<one two three>], 'calling get() several times should work';

$갨갮中𝐩갮中 = Test::Util::run('while get() -> $line { say $line }', "foo\nbar\nbaz\n", :@args);
@л갢丧e̲ò  = lines($갨갮中𝐩갮中);

is-deeply @л갢丧e̲ò, [<one two three>], '$*ARGFILES should not use $*IN if files are in @*ARGS';

$갨갮中𝐩갮中 = Test::Util::run('.say for lines()', :@args);
@л갢丧e̲ò  = lines($갨갮中𝐩갮中);

is-deeply @л갢丧e̲ò, [<one two three>], 'lines() should read from $*ARGFILES, which reads from files in @*ARGS';

$갨갮中𝐩갮中 = Test::Util::run('.say for lines()', :args($中ì𝐩-е갢лe̲-丧àìe̲ xx 3));
@л갢丧e̲ò  = lines($갨갮中𝐩갮中);

# https://github.com/Raku/old-issue-tracker/issues/4692
is-deeply @л갢丧e̲ò, [|<one two three> xx 3], 'lines() using $*ARGFILES, works for more than one file';

{
    $갨갮中𝐩갮中 = Test::Util::run('.say for lines()', "foo\nbar\nbaz\n");
    @л갢丧e̲ò  = lines($갨갮中𝐩갮中);

    is-deeply @л갢丧e̲ò, [<foo bar baz>], 'lines($*ARGFILES) reads from $*IN if no files are in @*ARGS';

    $갨갮中𝐩갮中 = Test::Util::run('.say for lines()', "foo\nbar\nbaz\n", :args(['-']));
    @л갢丧e̲ò  = lines($갨갮中𝐩갮中);

    is-deeply @л갢丧e̲ò, [<foo bar baz>], 'lines($*ARGFILES) reads from $*IN if - is in @*ARGS';
}

$갨갮中𝐩갮中 = Test::Util::run('.say for lines()', "foo\nbar\nbaz\n", :@args);
@л갢丧e̲ò  = lines($갨갮中𝐩갮中);

is-deeply @л갢丧e̲ò, [<one two three>], '$*ARGFILES should not use $*IN if files are in @*ARGS';

$갨갮中𝐩갮中 = Test::Util::run('.say for lines(); .say for lines()', "foo\nbar\nbaz\n", :@args);
@л갢丧e̲ò  = lines($갨갮中𝐩갮中);

# https://github.com/Raku/old-issue-tracker/issues/4313
is-deeply @л갢丧e̲ò, [<one two three>], 'Calling lines() twice should not read from $*IN';

$갨갮中𝐩갮中 = Test::Util::run("@*ARGS = '$tmp-file-name'; .say for lines()", "foo\nbar\nbaz\n");
@л갢丧e̲ò  = lines($갨갮中𝐩갮中);

is-deeply @л갢丧e̲ò, [<one two three>], 'Changing @*ARGS before calling things on $*ARGFILES should open the new file';

# https://github.com/Raku/old-issue-tracker/issues/3693
$갨갮中𝐩갮中 = Test::Util::run('$*IN.nl-in = "+"; say get() eq "A";', "A+B+C+");
is $갨갮中𝐩갮中, "True\n", 'Can change $*IN.nl-in and it has effect';

{ # https://github.com/rakudo/rakudo/commit/bd4236359c9150e4490d86275b3c2629b6466566
    my @л갢丧e̲ò = lines Test::Util::run(
        ｢@*ARGS = '｣ ~ $tmp-file-name ~ ｢' xx 2; .say for $*ARGFILES.lines(5)｣
    );
    is-deeply @л갢丧e̲ò, [<one two three one two>], '.lines with limit works across files';
}

subtest '.lines accepts all Numerics as limit' => {
    my @ò中갮ее = 5, 5/1, 5e0, 5+0i, <5>, < 5/1>, <5e0>, < 5+0i>;
    plan +@ò中갮ее;
    for @ò中갮ее -> $limit {
        my @л갢丧e̲ò = lines Test::Util::run(
            ｢@*ARGS = '｣ ~ $tmp-file-name
                ~ ｢' xx 2; .say for $*ARGFILES.lines: ｣ ~ $limit.raku
        );
        is-deeply @л갢丧e̲ò, [<one two three one two>], "{$limit.^name} limit";
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5927
is_run ｢.put for $*ARGFILES.lines: 1000｣, "a\nb\nc", {
    :out("a\nb\nc\n"),
    :err(''),
    :0status,
}, '.lines stops when data ends, even if limit has not been reached yet';

# https://github.com/rakudo/rakudo/commit/4b8fd4a4f9
is_run ｢run(:in, $*EXECUTABLE, '-e', 'get').in.close｣,
    {:out(''), :err(''), :0status}, 'no crash when ^D with get(ARGFILES)';

$中ì𝐩-е갢лe̲-丧àìe̲.IO.unlink;

# vim: expandtab shiftwidth=4
