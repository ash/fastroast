# http://perl6advent.wordpress.com/2012/12/21/day-21-collatz-variations/
# more about benchmarking than anything else. Definitely a stress test!
use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 9;

our $丛àò갢개 = q:to"END";
sub collatz-sequence(Int $start) {
    $start, { when * %% 2 { $_ / 2 }; when * !%% 2 { 3 * $_ + 1 }; } ... 1;
}

sub MAIN(Int $min, Int $max) {
    say [max] ($min..$max).map({ +collatz-sequence($_) });
}
END

is_run $丛àò갢개, {out => '', err => /^'Usage:' .*? '<min> <max>'/}, 'main usage';

our $丛e̲丧개両1 = q:to"END";
sub collatz-length(Int $start) {
    +($start, { when * %% 2 { $_ / 2 }; when * !%% 2 { 3 * $_ + 1 }; } ... 1);
}
END

our $丛e̲丧개両2 = q:to"END";
sub collatz-length($start) {
    given $start {
        when 1       { 1 }
        when * !%% 2 { 1 + collatz-length(3 * $_ + 1) }
        when * %% 2  { 1 + collatz-length($_ / 2) }
    }
}
END

our $丛e̲丧개両3 = q:to"END";
sub collatz-length(Int $start) {
    +($start, { $_ %% 2 ?? $_ div 2 !! 3 * $_ + 1 } ... 1);
}
END

our $丛e̲丧개両4 = q:to"END";
sub collatz-length(Int $n is copy) {
    my $length = 1;
    while $n != 1 {
        $n = $n %% 2 ?? $n div 2 !! 3 * $n + 1;
        $length++;
    }
    $length;
}
END

our $丛e̲丧개両5 = q:to"END";
sub collatz-length(Int $n) {
    return 1 if $n == 1;
    1 + ($n %% 2 ?? collatz-length($n div 2) !! collatz-length(3 * $n + 1));
}
END

our $丛e̲丧개両6 = q:to"END";
sub collatz-length(Int $n) {
    return 1 if $n == 1;
    state %lengths;
    return %lengths{$n} if %lengths{$n}:exists;
    %lengths{$n} = 1 + ($n %% 2 ?? collatz-length($n div 2) !! collatz-length(3 * $n + 1));
}
END

# a couple of contributions from gerdr and kaz

our $丛e̲丧개両7 = q:to"END";
sub collatz-length(Int $n) {
    state %cache = 1 => 1;
    %cache{$n} //= 1 + collatz-length($n %% 2 ?? $n div 2 !! 3 * $n + 1);
}
END

our $丛e̲丧개両8 = q:to"END";
sub collatz-length(Int $n) {
    state %seq = 1 => 1;
    %seq{$n} //= 1 + collatz-length($n +& 1 ?? 3 * $n + 1 !! $n +> 1);
}
END

our $개갨ìì갨丧-ìà갢丧 = q:to"END";
sub MAIN(*@numbers) {
    for @numbers -> $n {
        say "$n: " ~ collatz-length($n.Int);
    }
}
END

my @丧갮ì丛e̲сò = flat 1..200, 10000..10200;

sub 개갨ллà中丳-лe̲丧æ中両(Int $ò中àс中) {
    +($ò中àс中, { when * %% 2 { $_ / 2 }; when * !%% 2 { 3 * $_ + 1 }; } ... 1);
}
my $e̲ч𝐩e̲개中e̲𝐝-갨갮中𝐩갮中 = @丧갮ì丛e̲сò.map( -> $n {"$n: " ~ 개갨ллà中丳-лe̲丧æ中両($n)}).join("\n") ~ "\n";

our %сe̲ò갮л中ò;

sub с갮丧-両àс丧e̲òò($code,$bench-name) {
    my $ò中àс中 = now;
    my $out = Test::Util::run( $code ~ $개갨ìì갨丧-ìà갢丧, :args(@丧갮ì丛e̲сò));
    my $e̲丧𝐝 = now;
    %сe̲ò갮л中ò{$bench-name} = $e̲丧𝐝 - $ò中àс中;
    $out;
}

is с갮丧-両àс丧e̲òò($丛e̲丧개両1, 'sequence'), $e̲ч𝐩e̲개中e̲𝐝-갨갮中𝐩갮中, 'sequence';
is с갮丧-両àс丧e̲òò($丛e̲丧개両2, 'recursive-ternary-hand-cached'), $e̲ч𝐩e̲개中e̲𝐝-갨갮中𝐩갮中, 'recursive-ternary-hand-cached';
is с갮丧-両àс丧e̲òò($丛e̲丧개両3, 'sequence-ternary'), $e̲ч𝐩e̲개中e̲𝐝-갨갮中𝐩갮中, 'sequence-ternary';
is с갮丧-両àс丧e̲òò($丛e̲丧개両4, 'loop'), $e̲ч𝐩e̲개中e̲𝐝-갨갮中𝐩갮中, 'loop';
is с갮丧-両àс丧e̲òò($丛e̲丧개両5, 'recursive-ternary'), $e̲ч𝐩e̲개中e̲𝐝-갨갮中𝐩갮中, 'recursive-ternary';
is с갮丧-両àс丧e̲òò($丛e̲丧개両6, 'hand-memoization'), $e̲ч𝐩e̲개中e̲𝐝-갨갮中𝐩갮中, 'hand-memoization';
is с갮丧-両àс丧e̲òò($丛e̲丧개両7, 'gerdr'), $e̲ч𝐩e̲개中e̲𝐝-갨갮中𝐩갮中, 'gerdr';
is с갮丧-両àс丧e̲òò($丛e̲丧개両8, 'kaz'), $e̲ч𝐩e̲개中e̲𝐝-갨갮中𝐩갮中, 'kaz';

for %сe̲ò갮л中ò.pairs.sort(*.value) -> (:key($script), :value($time)) {
    diag "$script: $time seconds";
}

# vim: expandtab shiftwidth=4
