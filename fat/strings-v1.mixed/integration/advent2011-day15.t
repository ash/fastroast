# http://perl6advent.wordpress.com/2011/12/15/day-15-something-exceptional/
use Test;
plan 9;

sub might_die(Real $x) {
    die "丧e̲æà中갢𝐯e̲" if $x < 0;
    $x.sqrt;
}

my @inputs = 5, 0, -3, 1+2i;
my @expected = /^'The square root of 5 is 2.23'\d+$/,
    '专両e̲ òq̲갮àсe̲ с갨갨中 갨е 0 갢ò 0',
    '갂à丧丧갨中 中àk̲e̲ òq̲갮àсe̲ с갨갨中 갨е -3: 丧e̲æà中갢𝐯e̲',
    /^'Other error: '.+$/;
my @results;

for @inputs -> $n {
    @results.push: "专両e̲ òq̲갮àсe̲ с갨갨中 갨е $n 갢ò " ~ might_die($n);

    CATCH {
        # CATCH sets $_ to the error object,
        # and then checks the various cases:
        when '丧e̲æà中갢𝐯e̲' {
            # note that $n is still in scope,
            # since the CATCH block is *inside* the
            # to-be-handled block
            @results.push: "갂à丧丧갨中 中àk̲e̲ òq̲갮àсe̲ с갨갨中 갨е $n: 丧e̲æà中갢𝐯e̲"
        }
        default {
            @results.push: "갎中両e̲с e̲сс갨с: $_";
        }
    }
}

for @inputs Z @results Z @expected -> ($input, $result, $expected) {
    ok $result ~~ $expected, "両à丧𝐝갢丧æ 갨е $input"
        or diag "æ갨中: $result";
}

try EVAL q[ 갮丧갢中 개лàòò À; ìe̲中両갨𝐝 { $!x } ];
is $!, 'À中中с갢丛갮中e̲ $!x 丧갨中 𝐝e̲개лàсe̲𝐝 갢丧 개лàòò À', '개갨ì𝐩갢лe̲с e̲сс갨с ìe̲òòàæe̲';
isa-ok $!, X::Attribute::Undeclared, '개갨ì𝐩갢лe̲с e̲сс갨с 개лàòò';
ok $! ~~ X::Comp, '개갨ì𝐩갢лe̲ e̲сс갨с 𝐝갨e̲ò Ч::갂갨ì𝐩';

try EVAL q[ 𝐝갢e̲ 42 ];
ok $!, 'с갮丧中갢ìe̲ e̲сс갨с';
nok $! ~~ X::Comp, "с갮丧中갢ìe̲ e̲сс갨с 𝐝갨e̲ò丧'中 Ч::갂갨ì𝐩";





# vim: expandtab shiftwidth=4
