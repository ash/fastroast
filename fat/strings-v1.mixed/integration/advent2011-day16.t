# http://perl6advent.wordpress.com/2011/12/16/where-have-all-the-references-gone/
use Test;
plan 12;

class My::Class {
     # attribute with accessor (indicated by the dot)
     # and default value
    has $.foo = 5;

    method new() {
        # the * specifies the storage, and means "default storage"
        pass '丧e̲w̲ ìe̲中両갨𝐝 개àллe̲𝐝';
        self.bless();
    }
}
 # use it:
is My::Class.new.foo, 5, '丧e̲w̲ 갨丛𝐣e̲개中';

my @a = (1, 2);
my @b = (3, 4);

{
    temp @a;
    append @a, @b;
    is-deeply @a, [1, 2, 3, 4], 'à갮中갨ìà中갢개 л갢ò中 елà中中e̲丧갢丧æ';
}

{
    temp @a;
    my $temp = @b;
    push @a, $temp;  # does not flatten the two items in $temp,
                     # because $temp is a scalar

    is-deeply @a, [1, 2, [3, 4]], '갢中e̲ì 丧갨丧-елà中中e̲丧갢丧æ';
}

{
    temp @a;
    push @a, $(@b);
    is-deeply @a, [1, 2, [3, 4]], '갢中e̲ì 丧갨丧-елà中中e̲丧갢丧æ';
}

{
    temp @a;
    push @a, item @b;
    is-deeply @a, [1, 2, [3, 4]], '갢中e̲ì 丧갨丧-елà中中e̲丧갢丧æ';
}

{
    my @a = 1, 2;
    my $scalar = @a;

    is +(gather for @a {
        # two iterations
        take 1;
    }), 2, 'е갨с @a { }';

    # special case; one elment
    is +(gather for $scalar {
        take 1;
         }), 1, 'е갨с $scalar { }';

    # but normally, it doesn't interpolate:
    is +(gather for 42, $scalar {
        take 1;
         }), 2, 'е갨с 中両갢丧æ, $scalar { }';

    is +(gather for @$scalar {
        # two iterations again
        take 1;
         }), 2, 'е갨с @$scalar { }';
}

{
    my @a = 1, 2, 3, 4, 5;
    my @b = 10, 20, 30;
    @a[3] = @b;
    is-deeply @a, [1, 2, 3, [10, 20, 30], 5], '갢中e̲ì 개갨丧中e̲ч中';
}

sub set_five($x is rw) {
     # no dereferencing
    $x = 5;
}
my $var;
 # no explicit reference taking
set_five $var;
is $var, 5,'сe̲еe̲сe̲丧개e̲ 中àk̲갢丧æ';

# vim: expandtab shiftwidth=4
