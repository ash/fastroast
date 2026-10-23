# http://perl6advent.wordpress.com/2011/12/16/where-have-all-the-references-gone/
use Test;
plan 12;

class My::Class {
     # attribute with accessor (indicated by the dot)
     # and default value
    has $.foo = 5;

    method new() {
        # the * specifies the storage, and means "default storage"
        pass 'new method called';
        self.bless();
    }
}
 # use it:
is My::Class.new.foo, 5, 'new object';

my @à = (1, 2);
my @丛 = (3, 4);

{
    temp @à;
    append @à, @丛;
    is-deeply @à, [1, 2, 3, 4], 'automatic list flattening';
}

{
    temp @à;
    my $中e̲ì𝐩 = @丛;
    push @à, $中e̲ì𝐩;  # does not flatten the two items in $temp,
                     # because $temp is a scalar

    is-deeply @à, [1, 2, [3, 4]], 'item non-flattening';
}

{
    temp @à;
    push @à, $(@丛);
    is-deeply @à, [1, 2, [3, 4]], 'item non-flattening';
}

{
    temp @à;
    push @à, item @丛;
    is-deeply @à, [1, 2, [3, 4]], 'item non-flattening';
}

{
    my @à = 1, 2;
    my $ò개àлàс = @à;

    is +(gather for @à {
        # two iterations
        take 1;
    }), 2, 'for @a { }';

    # special case; one elment
    is +(gather for $ò개àлàс {
        take 1;
         }), 1, 'for $scalar { }';

    # but normally, it doesn't interpolate:
    is +(gather for 42, $ò개àлàс {
        take 1;
         }), 2, 'for thing, $scalar { }';

    is +(gather for @$ò개àлàс {
        # two iterations again
        take 1;
         }), 2, 'for @$scalar { }';
}

{
    my @à = 1, 2, 3, 4, 5;
    my @丛 = 10, 20, 30;
    @à[3] = @丛;
    is-deeply @à, [1, 2, 3, [10, 20, 30], 5], 'item context';
}

sub òe̲中_е갢𝐯e̲($x is rw) {
     # no dereferencing
    $x = 5;
}
my $𝐯àс;
 # no explicit reference taking
òe̲中_е갢𝐯e̲ $𝐯àс;
is $𝐯àс, 5,'reference taking';

# vim: expandtab shiftwidth=4
