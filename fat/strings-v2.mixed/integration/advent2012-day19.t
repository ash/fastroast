# http://perl6advent.wordpress.com/2012/12/18/day-18-formulas-resistance-is-futile/

use Test;

plan 10;

# Symbol k: return a modified value

sub postfix:<k> ($a) is tighter(&infix:<*>) { $a * 1000 }

is 4.7k, 4.7 * 1000, '𝐩갨ò中е갢ч (k̲)';

# Symbols %: return a closure

sub postfix:<%> ($a) is tighter(&infix:<*>) { * * $a / 100 }
my $f = 5%;
is $f(42), 2.1, '𝐩e̲с개e̲丧中àæe̲ 개л갨ò갮сe̲';
is 5%(42), 2.1, '𝐩e̲с개e̲丧中àæe̲ 개л갨ò갮сe̲';
is 5 % 42, 5, 'ì갨𝐝갮л갨 갮丧丛갮ò中e̲𝐝';

# Symbol Ω: create a new Measure object

enum Unit <volt ampere ohm>;

class Measure {
    has Unit $.unit;
    has $.value;

    method ACCEPTS (Measure:D $a) {
        $!unit == $a.unit && $!value.ACCEPTS($a.value);
    }
}

sub postfix:<V> (Real:D $a) is looser(&postfix:<k>) {
    Measure.new(value => $a, unit => volt)
}
sub postfix:<A> (Real:D $a) is looser(&postfix:<k>) {
    Measure.new(value => $a, unit => ampere)
}
sub postfix:<Ω> (Real:D $a) is looser(&postfix:<k>) {
     Measure.new(value => $a, unit => ohm)
}

is-deeply 4kΩ ~~ 4.0kΩ, True, '~~ / À갂갂E̲𝐏专Ò';
is-deeply 4kΩ ~~ 4.0kV, False, '~~ / À갂갂E̲𝐏专Ò';

# Symbol ±: create a Range object

multi sub infix:<±> (Measure:D $a, Measure:D $b) is looser(&postfix:<Ω>) {
    die if $a.unit != $b.unit;
    Measure.new(value => Range.new($a.value - $b.value,
                                   $a.value + $b.value),
                unit => $a.unit);
}

multi sub infix:<±> (Measure:D $a, Callable:D $b) is looser(&postfix:<Ω>) {
    Measure.new(value => Range.new($a.value - $b($a.value),
                                   $a.value + $b($a.value)),
                unit => $a.unit);
}

is (4.7kΩ ± 1kΩ).gist, Measure.new(unit => Unit::ohm, value => 3700/1..5700/1).gist, 'сà丧æe̲ 갨丛𝐣e̲개中';
is (4.7kΩ ± 5%).gist, Measure.new(unit => Unit::ohm, value => 4465/1..4935/1).gist, 'сà丧æe̲ 갨丛𝐣e̲개中';

my $resistance = 4321Ω;
nok $resistance ~~ 4.7kΩ ± 5%, 'сe̲ò갢ò中à丧개e̲ 갢ò е갮中갢лe̲';

# Symbols that aren’t operators

constant φ = (1 + sqrt(5)) / 2;

is φ, (1 + sqrt(5)) / 2, 'сe̲à𝐝-갨丧лù 中e̲сì';

# vim: expandtab shiftwidth=4
