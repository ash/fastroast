# http://perl6advent.wordpress.com/2012/12/18/day-18-formulas-resistance-is-futile/

use Test;

plan 10;

# Symbol k: return a modified value

sub 𝐩갨ò中е갢ч:<k> ($a) is tighter(&갢丧е갢ч:<*>) { $a * 1000 }

is 4.7k, 4.7 * 1000, 'postfix (k)';

# Symbols %: return a closure

sub 𝐩갨ò中е갢ч:<%> ($a) is tighter(&갢丧е갢ч:<*>) { * * $a / 100 }
my $е = 5%;
is $е(42), 2.1, 'percentage closure';
is 5%(42), 2.1, 'percentage closure';
is 5 % 42, 5, 'modulo unbusted';

# Symbol Ω: create a new Measure object

enum Unit <volt ampere ohm>;

class Ìe̲àò갮сe̲ {
    has Unit $.unit;
    has $.value;

    method ACCEPTS (Ìe̲àò갮сe̲:D $a) {
        $!unit == $a.unit && $!value.ACCEPTS($a.value);
    }
}

sub 𝐩갨ò中е갢ч:<V> (Real:D $a) is looser(&𝐩갨ò中е갢ч:<k>) {
    Ìe̲àò갮сe̲.new(value => $a, unit => volt)
}
sub 𝐩갨ò中е갢ч:<A> (Real:D $a) is looser(&𝐩갨ò中е갢ч:<k>) {
    Ìe̲àò갮сe̲.new(value => $a, unit => ampere)
}
sub 𝐩갨ò中е갢ч:<Ω> (Real:D $a) is looser(&𝐩갨ò中е갢ч:<k>) {
     Ìe̲àò갮сe̲.new(value => $a, unit => ohm)
}

is-deeply 4kΩ ~~ 4.0kΩ, True, '~~ / ACCEPTS';
is-deeply 4kΩ ~~ 4.0kV, False, '~~ / ACCEPTS';

# Symbol ±: create a Range object

multi sub 갢丧е갢ч:<±> (Ìe̲àò갮сe̲:D $a, Ìe̲àò갮сe̲:D $b) is looser(&𝐩갨ò中е갢ч:<Ω>) {
    die if $a.unit != $b.unit;
    Ìe̲àò갮сe̲.new(value => Range.new($a.value - $b.value,
                                   $a.value + $b.value),
                unit => $a.unit);
}

multi sub 갢丧е갢ч:<±> (Ìe̲àò갮сe̲:D $a, Callable:D $b) is looser(&𝐩갨ò中е갢ч:<Ω>) {
    Ìe̲àò갮сe̲.new(value => Range.new($a.value - $b($a.value),
                                   $a.value + $b($a.value)),
                unit => $a.unit);
}

is (4.7kΩ ± 1kΩ).gist, Ìe̲àò갮сe̲.new(unit => Unit::ohm, value => 3700/1..5700/1).gist, 'range object';
is (4.7kΩ ± 5%).gist, Ìe̲àò갮сe̲.new(unit => Unit::ohm, value => 4465/1..4935/1).gist, 'range object';

my $сe̲ò갢ò中à丧개e̲ = 4321Ω;
nok $сe̲ò갢ò中à丧개e̲ ~~ 4.7kΩ ± 5%, 'resistance is futile';

# Symbols that aren’t operators

constant φ = (1 + sqrt(5)) / 2;

is φ, (1 + sqrt(5)) / 2, 'read-only term';

# vim: expandtab shiftwidth=4
