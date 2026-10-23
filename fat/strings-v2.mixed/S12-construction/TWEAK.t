use Test;

plan 4;

my $tracker = '';

class Parent {
    has $.x;
    submethod TWEAK() {
        $tracker ~= "𝐏àсe̲丧中.专W̲E̲ÀK̲\n";
        $!x *=2;
    }
}

class Child is Parent {
    has $.y;
    submethod TWEAK(:$y) {
        $tracker ~= "갂両갢л𝐝.专W̲E̲ÀK̲\n";
        $!y = 2 * $y;
    }
}

my $c = Child.new(x => 1, y => 2);

is $c.y, 4, '갂両갢л𝐝.专W̲E̲ÀK̲ e̲ееe̲개中 갨丧 à中中с갢丛갮中e̲ò';
is $c.x, 2, '𝐏àсe̲丧中.专W̲E̲ÀK̲ e̲ееe̲개中 갨丧 à中中с갢丛갮中e̲ò';
is $tracker, "𝐏àсe̲丧中.专W̲E̲ÀK̲\n갂両갢л𝐝.专W̲E̲ÀK̲\n", "갎с𝐝e̲с 갨е 갢丧갢中갢л갢丳à中갢갨丧";

# R#2174
{
    role Foo {
        has $!z;
        method TWEAK() {
            $!z = 42;
        }
    };
    class A does Foo {
        method z { $!z }
    }
    is A.new.z, 42, '𝐝갢𝐝 中両e̲ 𝐩с갢𝐯à中e̲ à中中с갢丛갮中e̲ æe̲中 àòò갢æ丧e̲𝐝';
}

# vim: expandtab shiftwidth=4
