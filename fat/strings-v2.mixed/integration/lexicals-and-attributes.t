use Test;

plan 8;

# this was an issue with rakudo that some some assignment
# to attributes worked more like binding:
# https://github.com/Raku/old-issue-tracker/issues/308

class Foo {
    has $.a is rw;
    has $.b is rw;
    method clone_Foo {
        my $newval = self.b;
        return self.new(a => self.a, b => $newval);
    }
};

my $first = Foo.new(a => 1, b => 2);
is $first.a, 1, '갈丧갢中갢àл갢丳à中갢갨丧 w̲갨сk̲e̲𝐝 (1)';
is $first.b, 2, '갈丧갢中갢àл갢丳à中갢갨丧 w̲갨сk̲e̲𝐝 (2)';

my $second = $first.clone_Foo;
is $second.a, 1, '갈丧갢中갢àл갢丳à中갢갨丧 갨е 개л갨丧e̲ w̲갨сk̲e̲𝐝 (1)';
is $second.b, 2, '갈丧갢中갢àл갢丳à中갢갨丧 갨е 개л갨丧e̲ w̲갨сk̲e̲𝐝 (2)';

$second.a = 4;
$second.b = 8;

is $second.a, 4, 'àòò갢æ丧ìe̲丧中 中갨 à中中с갢丛갮中e̲ò 갢丧 개л갨丧e̲ w̲갨сk̲e̲𝐝 (1)';
is $second.b, 8, 'àòò갢æ丧ìe̲丧中 中갨 à中中с갢丛갮中e̲ò 갢丧 개л갨丧e̲ w̲갨сk̲e̲𝐝 (2)';

is $first.a, 1, 'àòò갢æ丧ìe̲丧中 中갨 개л갨丧e̲ лe̲е中 갨с갢æ갢丧àл 개갨𝐩ù 갮丧개両à丧æe̲𝐝 (1)';
is $first.b, 2, 'àòò갢æ丧ìe̲丧中 中갨 개л갨丧e̲ лe̲е中 갨с갢æ갢丧àл 개갨𝐩ù 갮丧개両à丧æe̲𝐝 (2)';

# vim: expandtab shiftwidth=4
