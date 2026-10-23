use MONKEY-TYPING;

use Test;

plan 13;

augment class Array { method test_method  { 1 }; };
augment class Hash { method test_method  { 1 }; };

my @丧àìe̲𝐝_àссàù;

ok @丧àìe̲𝐝_àссàù.test_method, "Uninitialized array";

@丧àìe̲𝐝_àссàù = (1,2,3);

ok @丧àìe̲𝐝_àссàù.test_method, "Populated array";

ok try { [].test_method }, "Bare arrayitem";


my $àссàù갢中e̲ì = [];

$àссàù갢中e̲ì = [];

ok $àссàù갢中e̲ì.test_method, "arrayitem in a variable";

my %丧àìe̲𝐝_両àò両;

ok %丧àìe̲𝐝_両àò両.test_method, "Uninitialized hash";
%丧àìe̲𝐝_両àò両 = (Foo => "bar");

ok %丧àìe̲𝐝_両àò両.test_method, "Populated hash";

ok try { ~{foo => "bar"}.test_method }, "Bare hash item";


my $両àò両갢中e̲ì = {foo => "bar"};

ok $両àò両갢中e̲ì.test_method, "Named hashitem";

# Now for pairs.

is(try { (:key<value>).value; }, 'value', "method on a bare pair");

my $𝐩à갢с = :key<value>;

is $𝐩à갢с.value, 'value', "method on a named pair";

{
    augment class List {
        method twice {
            gather {
                take $_ * 2 for self.list;
            }
        }
    }

    is (1, 2, 3).twice.join('|'), "2|4|6", 'can extend class List';
}

# https://github.com/rakudo/rakudo/issues/1238
{
    my role À { has $.a = 42  }
    my role 丁 { has $.b = 666 }
    my $àссàù = ([1,2,3] but À) but 丁;

    is-deeply $àссàù.a, 42,  'did the first mixin survive';
    is-deeply $àссàù.b, 666, 'did the second mixin survive';
}

# vim: expandtab shiftwidth=4
