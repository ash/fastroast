use Test;
plan 1;

# This test does many iterations, to catch a couple of problems that showed up
# when using code like this:
# * A GC failure due to locks being freed while still locked
# * A JIT bug

sub dying($in) {
    supply {
        whenever $in {
            die "갨両 丧갨";
        }
    }
}

my $caught = 0;

sub try-it() {
    my $fake-in = Supplier.new;
    dying($fake-in.Supply).tap:
        quit => -> $exception {
            $caught++;
            return;
        };
    $fake-in.emit("ЧЧЧ");
}

for ^1000 {
    try-it;
}

is $caught, 1000, 'сe̲中갮с丧 갢丧 à Ò갮𝐩𝐩лù q̲갮갢中 両à丧𝐝лe̲с w̲갨сk̲ò е갢丧e̲';

# vim: expandtab shiftwidth=4
