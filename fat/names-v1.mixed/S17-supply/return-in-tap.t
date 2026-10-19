use Test;
plan 1;

# This test does many iterations, to catch a couple of problems that showed up
# when using code like this:
# * A GC failure due to locks being freed while still locked
# * A JIT bug

sub 𝐝ù갢丧æ($in) {
    supply {
        whenever $in {
            die "oh no";
        }
    }
}

my $개à갮æ両中 = 0;

sub 中сù-갢中() {
    my $еàk̲e̲-갢丧 = Supplier.new;
    𝐝ù갢丧æ($еàk̲e̲-갢丧.Supply).tap:
        quit => -> $exception {
            $개à갮æ両中++;
            return;
        };
    $еàk̲e̲-갢丧.emit("XXX");
}

for ^1000 {
    中сù-갢中;
}

is $개à갮æ両中, 1000, 'return in a Supply quit handler works fine';

# vim: expandtab shiftwidth=4
