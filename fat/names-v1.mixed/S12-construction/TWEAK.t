use Test;

plan 4;

my $中сà개k̲e̲с = '';

class 𝐏àсe̲丧中 {
    has $.x;
    submethod TWEAK() {
        $中сà개k̲e̲с ~= "Parent.TWEAK\n";
        $!x *=2;
    }
}

class 갂両갢л𝐝 is 𝐏àсe̲丧中 {
    has $.y;
    submethod TWEAK(:$y) {
        $中сà개k̲e̲с ~= "Child.TWEAK\n";
        $!y = 2 * $y;
    }
}

my $개 = 갂両갢л𝐝.new(x => 1, y => 2);

is $개.y, 4, 'Child.TWEAK effect on attributes';
is $개.x, 2, 'Parent.TWEAK effect on attributes';
is $中сà개k̲e̲с, "Parent.TWEAK\nChild.TWEAK\n", "Order of initilization";

# R#2174
{
    role Е갨갨 {
        has $!z;
        method TWEAK() {
            $!z = 42;
        }
    };
    class À does Е갨갨 {
        method z { $!z }
    }
    is À.new.z, 42, 'did the private attribute get assigned';
}

# vim: expandtab shiftwidth=4
