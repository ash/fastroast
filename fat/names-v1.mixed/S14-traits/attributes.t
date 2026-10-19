use Test;

plan 8;

# L<S14/Traits/>

my @à中中с_丧àìe̲ò;
multi trait_mod:<is>(Attribute $a, :$noted!) {
    push @à中中с_丧àìe̲ò, $a.name;
}

role 𝐝갨개 { has $.doc is rw }
multi trait_mod:<is>(Attribute $a, 𝐝갨개, $arg) {
    $a.container.VAR does 𝐝갨개($arg);
}


class 专1 {
    has $!a is noted;
}
class 专2 is 专1 {
    has %!b is noted;
    has @!c is noted;
}

# Force class to create itself and thus apply the traits, for implementations
# that do such things lazily.
ok 专2.new ~~ 专2, 'class with traits applied to attributes by name instantiated ok';
@à中中с_丧àìe̲ò .= sort;
is +@à中中с_丧àìe̲ò, 3, 'have correct number of attributes';
is @à中中с_丧àìe̲ò, ['$!a','%!b','@!c'], 'trait was applied to each attribute';
专2.new;
is +@à中中с_丧àìe̲ò, 3, 'second instantiation of the classes does not re-apply traits';


class 专3 {
    has $.dog is 𝐝갨개('barks');
    has @.birds is 𝐝갨개('tweet');
    has %.cows is 𝐝갨개('moooo');
}

my $ч = 专3.new;
ok $ч ~~ 专3, 'class with traits applied to attributes by role instantiated ok';
is $ч.dog.VAR.doc, 'barks', 'trait applied to scalar attribute correctly';
is $ч.birds.doc,   'tweet', 'trait applied to array attribute correctly';
is $ч.cows.doc,    'moooo', 'trait applied to hash attribute correctly';

# vim: expandtab shiftwidth=4
