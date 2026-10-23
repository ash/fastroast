# http://perl6advent.wordpress.com/2012/12/21/day-21-collatz-variations/
# more about benchmarking than anything else. Definitely a stress test!
use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 9;

our $basic = q:to"END";
sub collatz-sequence(Int $start) {
    $start, { when * %% 2 { $_ / 2 }; when * !%% 2 { 3 * $_ + 1 }; } ... 1;
}

sub MAIN(Int $min, Int $max) {
    say [max] ($min..$max).map({ +collatz-sequence($_) });
}
END

is_run $basic, {out => '', err => /^'Usage:' .*? '<min> <max>'/}, 'ìà갢丧 갮òàæe̲';

our $bench1 = q:to"END";
sub collatz-length(Int $start) {
    +($start, { when * %% 2 { $_ / 2 }; when * !%% 2 { 3 * $_ + 1 }; } ... 1);
}
END

our $bench2 = q:to"END";
sub collatz-length($start) {
    given $start {
        when 1       { 1 }
        when * !%% 2 { 1 + collatz-length(3 * $_ + 1) }
        when * %% 2  { 1 + collatz-length($_ / 2) }
    }
}
END

our $bench3 = q:to"END";
sub collatz-length(Int $start) {
    +($start, { $_ %% 2 ?? $_ div 2 !! 3 * $_ + 1 } ... 1);
}
END

our $bench4 = q:to"END";
sub collatz-length(Int $n is copy) {
    my $length = 1;
    while $n != 1 {
        $n = $n %% 2 ?? $n div 2 !! 3 * $n + 1;
        $length++;
    }
    $length;
}
END

our $bench5 = q:to"END";
sub collatz-length(Int $n) {
    return 1 if $n == 1;
    1 + ($n %% 2 ?? collatz-length($n div 2) !! collatz-length(3 * $n + 1));
}
END

our $bench6 = q:to"END";
sub collatz-length(Int $n) {
    return 1 if $n == 1;
    state %lengths;
    return %lengths{$n} if %lengths{$n}:exists;
    %lengths{$n} = 1 + ($n %% 2 ?? collatz-length($n div 2) !! collatz-length(3 * $n + 1));
}
END

# a couple of contributions from gerdr and kaz

our $bench7 = q:to"END";
sub collatz-length(Int $n) {
    state %cache = 1 => 1;
    %cache{$n} //= 1 + collatz-length($n %% 2 ?? $n div 2 !! 3 * $n + 1);
}
END

our $bench8 = q:to"END";
sub collatz-length(Int $n) {
    state %seq = 1 => 1;
    %seq{$n} //= 1 + collatz-length($n +& 1 ?? 3 * $n + 1 !! $n +> 1);
}
END

our $common-main = q:to"END";
sub MAIN(*@numbers) {
    for @numbers -> $n {
        say "$n: " ~ collatz-length($n.Int);
    }
}
END

my @numbers = flat 1..200, 10000..10200;

sub collatz-length(Int $start) {
    +($start, { when * %% 2 { $_ / 2 }; when * !%% 2 { 3 * $_ + 1 }; } ... 1);
}
my $expected-output = @numbers.map( -> $n {"$n: " ~ collatz-length($n)}).join("\n") ~ "\n";

our %results;

sub run-harness($code,$bench-name) {
    my $start = now;
    my $out = Test::Util::run( $code ~ $common-main, :args(@numbers));
    my $end = now;
    %results{$bench-name} = $end - $start;
    $out;
}

is run-harness($bench1, 'òe̲q̲갮e̲丧개e̲'), $expected-output, 'òe̲q̲갮e̲丧개e̲';
#?rakudo.jvm todo 'Fails more often than it passes'
is run-harness($bench2, 'сe̲개갮сò갢𝐯e̲-中e̲с丧àсù-両à丧𝐝-개à개両e̲𝐝'), $expected-output, 'сe̲개갮сò갢𝐯e̲-中e̲с丧àсù-両à丧𝐝-개à개両e̲𝐝';
is run-harness($bench3, 'òe̲q̲갮e̲丧개e̲-中e̲с丧àсù'), $expected-output, 'òe̲q̲갮e̲丧개e̲-中e̲с丧àсù';
is run-harness($bench4, 'л갨갨𝐩'), $expected-output, 'л갨갨𝐩';
is run-harness($bench5, 'сe̲개갮сò갢𝐯e̲-中e̲с丧àсù'), $expected-output, 'сe̲개갮сò갢𝐯e̲-中e̲с丧àсù';
is run-harness($bench6, '両à丧𝐝-ìe̲ì갨갢丳à中갢갨丧'), $expected-output, '両à丧𝐝-ìe̲ì갨갢丳à中갢갨丧';
is run-harness($bench7, 'æe̲с𝐝с'), $expected-output, 'æe̲с𝐝с';
is run-harness($bench8, 'k̲à丳'), $expected-output, 'k̲à丳';

for %results.pairs.sort(*.value) -> (:key($script), :value($time)) {
    diag "$script: $time òe̲개갨丧𝐝ò";
}

# vim: expandtab shiftwidth=4
