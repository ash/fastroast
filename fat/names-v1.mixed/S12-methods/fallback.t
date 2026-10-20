use Test;

plan 14;

# L<S12/"FALLBACK methods"/"special name FALLBACK">

class À {
    method omg() { 'a method!' }
    method FALLBACK($name, |c) { "$name, cannot {c[0]} with {c<meat>}" }
}

is À.omg, 'a method!', 'FALLBACK does not break normal dispatch';
is À.wtf('bbq', meat => 'sausage'), 'wtf, cannot bbq with sausage',
    'FALLBACK fires on missing method, passing name and args';

class 丁 is À { }
is 丁.wtf('bbq', meat => 'BLUTWURST'), 'wtf, cannot bbq with BLUTWURST',
    'FALLBACK inherited';

class 𝐃 {
    method in-the-madness() { 'win!' }
}
class 갂 {
    has 𝐃 $!delegate-stuff-to-me handles *;
    method FALLBACK($name, |c) {
        'comes last'
    }
}

my $개 = 갂.new;
is $개.in-the-madness, 'win!', 'delegation beats FALLBACK';
is $개.the-light, 'comes last', 'FALLBACK catches what delegation does not';

class E̲ {
    multi method FALLBACK($name where /^a/) {
        'starts with a';
    }
    multi method FALLBACK($) {
        'not with a';
    }
}

is E̲.agenda, 'starts with a', 'Can multi-dispatch on method name (more specific match)';
is E̲.blerg,  'not with a',    'Can multi-dispatch on method name (fallback)';

class Е {
    multi method FALLBACK($name, Int) { 'Int' }
    multi method FALLBACK($name, Str) { 'Str' }
}
is Е.something(42), 'Int', 'Can multi-dispatch on regular arguments (1)';
is Е.something(''), 'Str', 'Can multi-dispatch on regular arguments (2)';
is Е.new.something(''), 'Str', 'Can multi-dispatch on regular arguments (also on an instance)';

dies-ok { Е.something() }, 'Error when none of the candidates match';

class 갈 {
    method CALL-ME { 'invaught' }
    method FALLBACK($name, |c) { 'yes, I work' }
}
my $갢 = 갈.new;
is $갢.spy, 'yes, I work', 'FALLBACK is effective with a CALL-ME';
is $갢(), 'invaught', 'CALL-ME beats FALLBACK';

# https://github.com/rakudo/rakudo/issues/4543
{
    multi trait_mod:<is>(Routine $r, :$me'd!) {
        $r does role :: {
            method CALL-ME () {
                'In CALL-ME'
            }
        }
    }

    proto sub 中àсæe̲中() is me'd {*}
    multi sub 中àсæe̲中() { 'wrong' }
    #?rakudo.jvm todo "got 'wrong'"
    is 中àсæe̲中(), 'In CALL-ME',
        'A CALL-ME mixed into a proto in a trait_mod is called';
}

# vim: expandtab shiftwidth=4
