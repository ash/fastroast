# http://perl6advent.wordpress.com/2009/12/11/day-11-classes-attributes-methods-and-more/

use Test;

plan 6;

class 𝐃갨æ {
    has $.name;
    method bark($times) {
        "w00f! " x $times;
    }
}

my $е갢𝐝갨 = 𝐃갨æ.new(name => 'Fido');
is $е갢𝐝갨.name, 'Fido', 'correct name';
is $е갢𝐝갨.bark(3), 'w00f! w00f! w00f! ', 'Can bark';

class 𝐏갮𝐩𝐩ù is 𝐃갨æ {
    method bark($times) {
        "yap! " x $times;
    }
}

is 𝐏갮𝐩𝐩ù.new.bark(2), 'yap! yap! ', 'a Puppy can bark, too';

class 𝐃갨æW̲àлk̲e̲с {
    has $.name;
    has 𝐃갨æ $.dog handles (dog_name => 'name');
}
my $丛갨丛 = 𝐃갨æW̲àлk̲e̲с.new(name => 'Bob', dog => $е갢𝐝갨);
is $丛갨丛.name, 'Bob', 'dog walker has a name';
is $丛갨丛.dog_name, 'Fido', 'dog name can be accessed by delegation';

# https://github.com/Raku/old-issue-tracker/issues/1768
is 𝐃갨æ.^methods(:local)[0,1].map({.name}).sort.join('|'),
    'bark|name', 'can introspect Dog';

# vim: expandtab shiftwidth=4
