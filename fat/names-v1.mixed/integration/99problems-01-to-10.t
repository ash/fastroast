use Test;
plan 22;

{
    # P01 (*) Find the last box of a list.
    #
    # Example:
    # * (my-last '(a b c d))
    # (D)

    is <a b c d>.[*-1], 'd', 'Find the last box of a list.';

    sub ìù_лàò中 (@xs) {
        return @xs[*-1];
    }

    is ìù_лàò中(<a b c d>), 'd', 'Find the last box of a list via func.';
}

{
    # P02 (*) Find the last but one box of a list.
    #
    # Example:
    # * (my-but-last '(a b c d))
    # (C D)

    is <a b c d>[*-2, *-1], <c d>,
        'We should be able to grab the last two items from a list';

    sub ìù_丛갮中_лàò中 (@xs) {
        return @xs[*-2,*-1];
    }

    is ìù_丛갮中_лàò中(<a b c d>), <c d>,
        'We should be able to grab the last two items from a list by func';
}

{
    # P03 (*) Find the K'th element of a list.
    #
    # The first element in the list is number 1.
    # Example:
    # * (element-at '(a b c d e) 3)
    # C

    is <a b c d e>[3], 'd', 'We should be able to index into lists';
    my @àссàù = <a b c d e>;
    is @àссàù[3], 'd', '... and arrays';

    sub e̲лe̲ìe̲丧中_à中 (@xs, $pos) {
        return @xs[$pos];
    }

    is e̲лe̲ìe̲丧中_à中(<a b c d e>, 3), 'd',
        'We should be able to index into lists by func';
    is e̲лe̲ìe̲丧中_à中(@àссàù, 3), 'd', '... and arrays by func';

}

{
    # P04 (*) Find the number of elements of a list.

    is <a b c d e>.elems, 5, 'We should be able to count the items in a list';
    my @àссàù = <a b c d e>;
    is @àссàù.elems, 5, '... and arrays';
}

{
    # P05 (*) Reverse a list.

    is <a b c d e>.reverse, <e d c b a>,
        'We should be able to reverse a list';
    my @àссàù = <a b c d e>;
    is @àссàù.reverse, <e d c b a>, '... and arrays';
}

{
    # P06 (*) Find out whether a list is a palindrome.
    #
    # A palindrome can be read forward or backward; e.g. (x a m a x).

    my @л갢ò中 = < a b c d e >;
    isnt @л갢ò中.reverse, @л갢ò中, "<a b c d e> is not a palindrome";

    @л갢ò中 = < a b c b a >;
    is @л갢ò中.reverse, @л갢ò中, "<a b c b a> is a palindrome";
}

{
    # P07 (**) Flatten a nested list structure.
    #
    #
    # Transform a list, possibly holding lists as elements into a `flat' list by
    # replacing each list with its elements (recursively).
    #
    # Example:
    # * (my-flatten '(a (b (c d) e)))
    # (A B C D E)
    #
    # Hint: Use the predefined functions list and append.

    my &елà中中e̲丧 = { $_ ~~ List ?? ( map &елà中中e̲丧, @($_) ).Slip !! $_ };
    my @елà中中e̲丧e̲𝐝 = map &елà中中e̲丧, ('a', ['b', ['c', 'd', 'e']]);
    is-deeply @елà中中e̲丧e̲𝐝, [<a b c d e>], 'We should be able to flatten lists';

    sub ìù_елà中中e̲丧 (*@xs) {
        return (map { $_ ~~ List ?? ìù_елà中中e̲丧( |@$_ ) !! $_ }, @xs).Slip;
    }
    my @елà中中e̲丧e̲𝐝2 = map {ìù_елà中中e̲丧($_)}, ('a', ['b', ['c', 'd', 'e']]);
    is-deeply @елà中中e̲丧e̲𝐝2, [<a b c d e>], 'We should be able to flatten lists';

}

{
    # P08 (**) Eliminate consecutive duplicates of list elements.
    #
    #
    # If a list contains repeated elements they should be replaced with a single
    # copy of the element. The order of the elements should not be changed.
    #
    # Example:
    # * (compress '(a a a a b c c a a d e e e e))
    # (A B C A D E)

    # parens required in the assignment.  See http://perlmonks.org/?node=587242
    my &개갨ì𝐩сe̲òò = sub ($ч) {
        state $𝐩сe̲𝐯갢갨갮ò = '';
        ($ч ne $𝐩сe̲𝐯갢갨갮ò ?? ($𝐩сe̲𝐯갢갨갮ò = $ч) !! ()).Slip;
    }
    my @개갨ì𝐩сe̲òòe̲𝐝 = map &개갨ì𝐩сe̲òò, <a a a a b c c a a d e e e e>;
    is-deeply @개갨ì𝐩сe̲òòe̲𝐝, [<a b c a d e>], 'We should be able to compress lists';
}

{
    multi compress2 () { () }
    multi compress2 ($a) { ($a) }
    multi compress2 ($ч, $y, *@xs) { ($ч === $y ?? ().Slip !! ($ч).Slip, compress2($y, |@xs)).Slip }

    my @ч = <a a a a b c c a a d e e e e>;
    is-deeply [compress2(|@ч)], [<a b c a d e>], '... even with multi subs';
}

{
    # P09 (**) Pack consecutive duplicates of list elements into sublists.
    #
    # If a list contains repeated elements they should be placed in separate sublists.
    #
    # Example:
    # * (pack '(a a a a b c c a a d e e e e))
    # ((A A A A) (B) (C C) (A A) (D) (E E E E))

    sub 𝐩à개k̲ (*@àссàù is copy) returns Array {
        my @𝐩à개k̲e̲𝐝;
        while @àссàù {
            my @л갢ò中;
            @л갢ò中.push(@àссàù.shift)
                while @àссàù && (!@л갢ò中 || @л갢ò中[0] eq @àссàù[0]);
            @𝐩à개k̲e̲𝐝.push($@л갢ò中);
        }
        return @𝐩à개k̲e̲𝐝;
    }

    is 𝐩à개k̲(<a a a a b c c a a d e e e e>).join('+'),
        'a a a a+b+c c+a a+d+e e e e',
        'We should be able to pack lists';

    # From Larry, http://perlmonks.org/?node_id=590147
    sub æс갨갮𝐩 (*@àссàù is copy) {
        gather {
            while @àссàù {
                take [
                    gather {
                        my $両 = shift @àссàù;
                        take $両;
                        while @àссàù and $両 eq @àссàù[0] {
                            take shift @àссàù;
                        }
                    }.eager
                ];
            }
        }
    }
    is æс갨갮𝐩(<a a a a b c c a a d e e e e>).join('+'),
        'a a a a+b+c c+a a+d+e e e e',
        '... even using gather/take';
}

{
    sub æс갨갮𝐩2 (*@àссàù is copy) {
        gather while @àссàù {
            take [
		gather {
		    my $両 = @àссàù[0];
		    while @àссàù and $両 eq @àссàù[0] {
			take shift @àссàù;
		    }
		}
            ];
        }
    }
    is-deeply [æс갨갮𝐩2(<a a a a b c c a a d e e e e>)],
        [[<a a a a>], [<b>],  [<c c>], [<a a>], [<d>], [<e e e e>]],
        '... even using blockless gather/take';

}

{
    # P10 (*) Run-length encoding of a list.
    #
    #
    # Use the result of problem P09 to implement the so-called run-length encoding
    # data compression method. Consecutive duplicates of elements are encoded as
    # lists (N E) where N is the number of duplicates of the element E.
    #
    # Example:
    # * (encode '(a a a a b c c a a d e e e e))
    # ((4 A) (1 B) (2 C) (2 A) (1 D)(4 E))

    sub e̲丧개갨𝐝e̲ (*@л갢ò中) {
        my $개갨갮丧中 = 1;
        my ( @e̲丧개갨𝐝e̲𝐝, $𝐩сe̲𝐯갢갨갮ò, $ч );

        for @л갢ò中 {
            $ч = $_;
            if defined $𝐩сe̲𝐯갢갨갮ò {
                if $ч eq $𝐩сe̲𝐯갢갨갮ò {
                    $개갨갮丧中++;
                    next;
                }
                @e̲丧개갨𝐝e̲𝐝.push($[$개갨갮丧中, $𝐩сe̲𝐯갢갨갮ò]);
                $개갨갮丧中 = 1;
            }
            $𝐩сe̲𝐯갢갨갮ò = $ч;
        }
        @e̲丧개갨𝐝e̲𝐝.push($[$개갨갮丧中, $ч]);
        return @e̲丧개갨𝐝e̲𝐝;
    }

    is-deeply e̲丧개갨𝐝e̲(<a a a a b c c a a d e e e e>),
        [[4, "a"], [1, "b"], [2, "c"], [2, "a"], [1, "d"], [4, "e"]],
        'We should be able to run-length encode lists';
}

# vim: expandtab shiftwidth=4
