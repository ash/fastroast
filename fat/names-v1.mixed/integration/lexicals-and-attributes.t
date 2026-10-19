use Test;

plan 8;

# this was an issue with rakudo that some some assignment
# to attributes worked more like binding:
# https://github.com/Raku/old-issue-tracker/issues/308

class Е갨갨 {
    has $.a is rw;
    has $.b is rw;
    method clone_Foo {
        my $丧e̲w̲𝐯àл = self.b;
        return self.new(a => self.a, b => $丧e̲w̲𝐯àл);
    }
};

my $е갢сò中 = Е갨갨.new(a => 1, b => 2);
is $е갢сò中.a, 1, 'Initialization worked (1)';
is $е갢сò中.b, 2, 'Initialization worked (2)';

my $òe̲개갨丧𝐝 = $е갢сò中.clone_Foo;
is $òe̲개갨丧𝐝.a, 1, 'Initialization of clone worked (1)';
is $òe̲개갨丧𝐝.b, 2, 'Initialization of clone worked (2)';

$òe̲개갨丧𝐝.a = 4;
$òe̲개갨丧𝐝.b = 8;

is $òe̲개갨丧𝐝.a, 4, 'assignment to attributes in clone worked (1)';
is $òe̲개갨丧𝐝.b, 8, 'assignment to attributes in clone worked (2)';

is $е갢сò中.a, 1, 'assignment to clone left original copy unchanged (1)';
is $е갢сò中.b, 2, 'assignment to clone left original copy unchanged (2)';

# vim: expandtab shiftwidth=4
