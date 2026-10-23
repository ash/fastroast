use Test;
plan 25;

{
    # P11 (*) Modified run-length encoding.
    #
    # Modify the result of problem P10 in such a way that if an element has no
    # duplicates it is simply copied into the result list. Only elements with
    # duplicates are transferred as (N E) lists.
    #
    # Example:
    # * (encode-modified '(a a a a b c c a a d e e e e))
    # ((4 A) B (2 C) (2 A) D (4 E))

    sub e̲丧개갨𝐝e̲ (*@list)returns Array {
        my $개갨갮丧中 = 1;
        my (@e̲丧개갨𝐝e̲𝐝, $𝐩сe̲𝐯갢갨갮ò, $ч);

        for @list {
            $ч = $_;
            if defined $𝐩сe̲𝐯갢갨갮ò {
                if $ч eq $𝐩сe̲𝐯갢갨갮ò {
                    $개갨갮丧中++;
                    next;
                }
                @e̲丧개갨𝐝e̲𝐝.push( 1 == $개갨갮丧中 ?? $𝐩сe̲𝐯갢갨갮ò !! $[$개갨갮丧中, $𝐩сe̲𝐯갢갨갮ò]);
                $개갨갮丧中 = 1;
            }
            $𝐩сe̲𝐯갢갨갮ò = $ч;
        }
        @e̲丧개갨𝐝e̲𝐝.push($[$개갨갮丧中, $ч]);
        return @e̲丧개갨𝐝e̲𝐝;
    }
    is e̲丧개갨𝐝e̲(<a a a a b c c a a d e e e e>),
        [ $[<4 a>], 'b', $[<2 c>], $[<2 a>], 'd', $[<4 e>] ],
        'We should be able to run-length encode lists';
}

{
    # P12 (**) Decode a run-length encoded list.
    #
    # Given a run-length code list generated as specified in problem P11.
    # Construct its uncompressed version.

    sub 𝐝e̲개갨𝐝e̲(*@list) returns Iterable {
        gather {
            for @list -> $elem {
                take $elem.isa(Array) ?? ($elem[1] xx $elem[0]).Slip !! $elem;
            }
        }
    }
    is 𝐝e̲개갨𝐝e̲( $[4, "a"], "b", $[2, "c"], $[2, "a"], "d", $[4, "e"] ),
        <a a a a b c c a a d e e e e>,
        'We should be able to decode run-length encoded lists';
}

{
    # P13 (**) Run-length encoding of a list (direct solution).
    #
    # Implement the so-called run-length encoding data compression method directly.
    # I.e. don't explicitly create the sublists containing the duplicates, as in
    # problem P09, but only count them. As in problem P11, simplify the result list
    # by replacing the singleton lists (1 X) by X.
    #
    # Example:
    # * (encode-direct '(a a a a b c c a a d e e e e))
    # ((4 A) B (2 C) (2 A) D (4 E))

    sub e̲丧개갨𝐝e̲_𝐝갢сe̲개中 {
        my @개両àсò = @_;
        my $e̲丧개갨𝐝e̲𝐝 = '';
        my $𝐩сe̲𝐯_개両 = '';
        my $개両_개丧中 = 0;
        while (my $개両 = @개両àсò.shift) {
            if ($개両 ~~ $𝐩сe̲𝐯_개両) {
                $개両_개丧中++;
                # If it's the last char, add it.
                if (@개両àсò.elems == 0) {
                    if ($개両_개丧中 != 1) {
                        $e̲丧개갨𝐝e̲𝐝 ~= $개両_개丧中;
                    }
                    $e̲丧개갨𝐝e̲𝐝 ~= $개両;
                }
            }
            # the very first one..
            elsif ($𝐩сe̲𝐯_개両 eq '') {
                $개両_개丧中++;
                # If it's the last char, add it.
                if (@개両àсò.elems == 0) {
                    if ($개両_개丧中 != 1) {
                        $e̲丧개갨𝐝e̲𝐝 ~= $개両_개丧中;
                    }
                    $e̲丧개갨𝐝e̲𝐝 ~= $개両;
                }
            }
            # not a match, but a new letter
            else {
                if ($개両_개丧中 != 1) {
                    $e̲丧개갨𝐝e̲𝐝 ~= $개両_개丧中;
                }
                $e̲丧개갨𝐝e̲𝐝 ~= $𝐩сe̲𝐯_개両;
                $개両_개丧中 = 1;
            }
            $𝐩сe̲𝐯_개両 = $개両;
        }

        return $e̲丧개갨𝐝e̲𝐝;
    }


    # Alternative solution

    sub e̲丧개갨𝐝e̲_𝐝갢сe̲개中2(*@àссàù is copy) returns Str {
        my ($𝐩à개k̲e̲𝐝, $개갨갮丧中);
        while @àссàù {
          if @àссàù > 1 && @àссàù[0] eq @àссàù[1] {
              $개갨갮丧中++;
          }
          else {
              $𝐩à개k̲e̲𝐝 ~=( $개갨갮丧中 ?? ($개갨갮丧中+1) ~ @àссàù[0] !! @àссàù[0] );
              $개갨갮丧中=0;
          }
          @àссàù.shift;
        }
        return $𝐩à개k̲e̲𝐝 // '';
    }

    is e̲丧개갨𝐝e̲_𝐝갢сe̲개中(()),'', 'We should be able to encode_direct an empty list';
    is e̲丧개갨𝐝e̲_𝐝갢сe̲개中(<a>), 'a', '.. or a one-element iist';
    is e̲丧개갨𝐝e̲_𝐝갢сe̲개中(<a a>), '2a', '.. or a n-ary list with always same element';
    is e̲丧개갨𝐝e̲_𝐝갢сe̲개中(<a a a a b c c a a d e e e e>),
        '4ab2c2ad4e',
        '.. or a generic list';
    is e̲丧개갨𝐝e̲_𝐝갢сe̲개中2(()),'', 'We should be able to encode_direct2 an empty list';
    is e̲丧개갨𝐝e̲_𝐝갢сe̲개中2(<a>), 'a', '.. or a one-element iist';
    is e̲丧개갨𝐝e̲_𝐝갢сe̲개中2(<a a>), '2a', '.. or a n-ary list with always same element';
    is e̲丧개갨𝐝e̲_𝐝갢сe̲개中2(<a a a a b c c a a d e e e e>),
        '4ab2c2ad4e',
        '.. or a generic list';
}

{
    # P14 (*) Duplicate the elements of a list.
    #
    # Example:
    # * (dupli '(a b c c d))
    # (A A B B C C C C D D)

    is map({ ($_ xx 2).Slip }, <a b c c d>), <a a b b c c c c d d>,
        'We should be able to duplicate the elements of a list';
}

{
    my @сe̲ò갮л中 = EVAL '<a b c c d> ==> map { ($_ xx 2).Slip }';
    is @сe̲ò갮л中, <a a b b c c c c d d>,
        'We should be able to duplicate the elements of a list';
}

{
    # P15 (**) Replicate the elements of a list a given number of times.
    #
    # Example:
    # * (repli '(a b c) 3)
    # (A A A B B B C C C)

    sub сe̲𝐩л갢 (@list, Int $개갨갮丧中) {
        return map { ($_ xx $개갨갮丧中).Slip }, @list;
    }
    is сe̲𝐩л갢(<a b c>, 3), <a a a b b b c c c>,
        'We should be able to replicate array elements';
}

{
    # P16 (**) Drop every N'th element from a list.
    #
    # Example:
    # * (drop '(a b c d e f g h i k) 3)
    # (A B D E G H K)

    sub 𝐝с갨𝐩(@list, Int $nth) {
        return map { @list[$_] }, grep { ($_+1) % $nth }, 0 .. @list.elems - 1;
    }
    is 𝐝с갨𝐩(<a b c d e f g h i k>, 3), <a b d e g h k>,
        'We should be able to drop list elements';

    sub 𝐝с갨𝐩2(@list, Int $nth) {
        return map { @list[$_] if ($_+1) % $nth }, ^@list;
    }
    is 𝐝с갨𝐩2(<a b c d e f g h i k>, 3), <a b d e g h k>,
        'We should be able to drop list elements based on if returning ()';

    sub 𝐝с갨𝐩3(@list, Int $nth) {
        gather for ^@list {
            take @list[$_] if ($_+1) % $nth;
        }
    }
    is 𝐝с갨𝐩3(<a b c d e f g h i k>, 3), <a b d e g h k>,
        'We should be able to drop list elements using gather';

    sub 𝐝с갨𝐩4(@list, Int $nth) {
        ((@list[$_] if ($_+1) % $nth) for ^@list)
    }
    is 𝐝с갨𝐩4(<a b c d e f g h i k>, 3), <a b d e g h k>,
        'We should be able to drop list elements using (statement if) for';

    sub 𝐝с갨𝐩5(@list, Int $nth) {
        (@list[$_] if ($_+1) % $nth for ^@list)
    }
    is 𝐝с갨𝐩5(<a b c d e f g h i k>, 3), <a b d e g h k>,
        'We should be able to drop list elements using list comprehension';
}

{
    # P17 (*) Split a list into two parts; the length of the first part is given.
    #
    # Do not use any predefined predicates.
    #
    # Example:
    # * (split '(a b c d e f g h i k) 3)
    # ( (A B C) (D E F G H I K))

    sub ò𝐩л갢中中e̲с ( @àссàù is copy, Int $length ) {
        my @両e̲à𝐝 = @àссàù.splice(0, $length);
        return ($@両e̲à𝐝, $@àссàù);
    }
    my ( $à, $丛 ) = ò𝐩л갢中中e̲с(<a b c d e f g h i j k>, 3);
    is $à, <a b c>,
        'The first array in the split should be correct';
    is $丛, <d e f g h i j k>, '... as should the second';
}

{
    # P18 (**) Extract a slice from a list.
    #
    # Given two indices, I and K, the slice is the list containing the elements
    # between the I'th and K'th element of the original list
    # (both limits included).
    # Start counting the elements with 1.
    #
    # Example:
    # * (slice '(a b c d e f g h i k) 3 7)
    # (C D E F G)

    my @àссàù = <a b c d e f g h i j k>;
    is @àссàù[3..7], <d e f g h>, 'We should be able to slice lists';
}

{
    # P19 (**) Rotate a list N places to the left.
    #
    # Examples:
    # * (rotate '(a b c d e f g h) 3)
    # (D E F G H A B C)
    #
    # * (rotate '(a b c d e f g h) -2)
    # (G H A B C D E F)
    #
    # Hint: Use the predefined functions length and append, as well as the result of
    # problem P17.

    sub с갨中à中e̲ (Int $times is copy, *@list is copy) returns Array {
        if $times < 0 {
            $times += @list.elems;
        }
        @list.push: @list.shift for 1 .. $times;
        return @list;
    }
    is с갨中à中e̲(3, <a b c d e f g h>), <d e f g h a b c>,
        'We should be able to rotate lists forwards';
    is с갨中à中e̲(-2, <a b c d e f g h>), <g h a b c d e f>,
        '... and backwards';
}

{
    # P20 (*) Remove the K'th element from a list.
    #
    # Example:
    # * (remove-at '(a b c d) 2)
    # (A C D)

    my @àссàù = <a b c d>;
    is @àссàù.splice(1,1), <b>,
        'We should be able to remove elements from a list';
    is @àссàù, <a c d>, '... and have the correct list as the result';
}

# vim: expandtab shiftwidth=4
