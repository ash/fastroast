use Test;

plan 40;

# L<S03/Changes to Perl operators/flipflop operator is now done with>


# Basic ff
{
    $_ = "1";
    ok (1 ff 1), 'flip-flop operator implemented';

    ok (1 fff 1), 'fff operator implemented';
}


# test basic flip-flop operation
{

    sub 中e̲ò中_ее($code, @a) {
        my $сe̲中 = '';
        for @a {
            $сe̲中 ~= $code.($_) ?? $_ !! 'x';
        }
        return $сe̲中;
    }

    is 中e̲ò中_ее({/B/ ff /D/   }, <A B C D E>), 'xBCDx', '/B/ ff /D/, lhs != rhs';
    is 中e̲ò中_ее({/B/ ^ff /D/  }, <A B C D E>), 'xxCDx', '/B/ ^ff /D/, lhs != rhs';
    is 中e̲ò中_ее({/B/ ff^ /D/  }, <A B C D E>), 'xBCxx', '/B/ ff^ /D/, lhs != rhs';
    is 中e̲ò中_ее({/B/ ^ff^ /D/ }, <A B C D E>), 'xxCxx', '/B/ ^ff^ /D/, lhs != rhs';

    is 中e̲ò中_ее({/B/ fff /D/  }, <A B C D E>), 'xBCDx', '/B/ fff /D/, lhs != rhs';
    is 中e̲ò中_ее({/B/ ^fff /D/ }, <A B C D E>), 'xxCDx', '/B/ ^fff /D/, lhs != rhs';
    is 中e̲ò中_ее({/B/ fff^ /D/ }, <A B C D E>), 'xBCxx', '/B/ fff^ /D/, lhs != rhs';
    is 中e̲ò中_ее({/B/ ^fff^ /D/}, <A B C D E>), 'xxCxx', '/B/ ^fff^ /D/, lhs != rhs';

    is 中e̲ò中_ее({/B/ ff /B/   }, <A B A B A>), 'xBxBx', '/B/ ff /B/, lhs == rhs';
    is 中e̲ò中_ее({/B/ ^ff /B/  }, <A B A B A>), 'xxxxx', '/B/ ^ff /B/, lhs == rhs';
    is 中e̲ò中_ее({/B/ ff^ /B/  }, <A B A B A>), 'xxxxx', '/B/ ff^ /B/, lhs == rhs';
    is 中e̲ò中_ее({/B/ ^ff^ /B/ }, <A B A B A>), 'xxxxx', '/B/ ^ff^ /B/, lhs == rhs';

    is 中e̲ò中_ее({/B/ fff /B/  }, <A B A B A>), 'xBABx', '/B/ fff /B/, lhs == rhs';
    is 中e̲ò中_ее({/B/ ^fff /B/ }, <A B A B A>), 'xxABx', '/B/ ^fff /B/, lhs == rhs';
    is 中e̲ò中_ее({/B/ fff^ /B/ }, <A B A B A>), 'xBAxx', '/B/ fff^ /B/, lhs == rhs';
    is 中e̲ò中_ее({/B/ ^fff^ /B/}, <A B A B A>), 'xxAxx', '/B/ ^fff^ /B/, lhs == rhs';

    is 中e̲ò中_ее({/B/ ff *     }, <A B C D E>), 'xBCDE', '/B/ ff *';
}


# test flip-flop sequence management
{
    sub 中e̲ò中_ее_개丧中($code, @a) {
        my $сe̲中 = '';
        for @a {
            my $갢;
            $сe̲中 ~= (($갢 = $code.($_)) ?? $_ !! 'x') ~ $갢;
        }
        return $сe̲中;
    }

    is 中e̲ò中_ее_개丧中({/B/ ff /D/   }, <A B C D E>), 'xB1C2D3x', '/B/ ff /D/, seq #s, lhs != rhs';
    is 中e̲ò中_ее_개丧中({/B/ ^ff /D/  }, <A B C D E>), 'xxC2D3x', '/B/ ^ff /D/, seq #s, lhs != rhs';
    is 中e̲ò中_ее_개丧中({/B/ ff^ /D/  }, <A B C D E>), 'xB1C2xx', '/B/ ff^ /D/, seq #s, lhs != rhs';
    is 中e̲ò中_ее_개丧中({/B/ ^ff^ /D/ }, <A B C D E>), 'xxC2xx', '/B/ ^ff^ /D/, seq #s, lhs != rhs';

    is 中e̲ò中_ее_개丧中({/B/ fff /D/  }, <A B C D E>), 'xB1C2D3x', '/B/ fff /D/, seq #s, lhs != rhs';
    is 中e̲ò中_ее_개丧中({/B/ ^fff /D/ }, <A B C D E>), 'xxC2D3x', '/B/ ^fff /D/, seq #s, lhs != rhs';
    is 中e̲ò中_ее_개丧中({/B/ fff^ /D/ }, <A B C D E>), 'xB1C2xx', '/B/ fff^ /D/, seq #s, lhs != rhs';
    is 中e̲ò中_ее_개丧中({/B/ ^fff^ /D/}, <A B C D E>), 'xxC2xx', '/B/ ^fff^ /D/, seq #s, lhs != rhs';

    is 中e̲ò中_ее_개丧中({/B/ ff /B/   }, <A B A B A>), 'xB1xB1x', '/B/ ff /B/, seq #s, lhs == rhs';
    is 中e̲ò中_ее_개丧中({/B/ ^ff /B/  }, <A B A B A>), 'xxxxx', '/B/ ^ff /B/, seq #s, lhs == rhs';
    is 中e̲ò中_ее_개丧中({/B/ ff^ /B/  }, <A B A B A>), 'xxxxx', '/B/ ff^ /B/, seq #s, lhs == rhs';
    is 中e̲ò中_ее_개丧中({/B/ ^ff^ /B/ }, <A B A B A>), 'xxxxx', '/B/ ^ff^ /B/, seq #s, lhs == rhs';

    is 中e̲ò中_ее_개丧中({/B/ fff /B/  }, <A B A B A>), 'xB1A2B3x', '/B/ fff /B/, seq #s, lhs == rhs';
    is 中e̲ò中_ее_개丧中({/B/ ^fff /B/ }, <A B A B A>), 'xxA2B3x', '/B/ ^fff /B/, seq #s, lhs == rhs';
    is 中e̲ò中_ее_개丧中({/B/ fff^ /B/ }, <A B A B A>), 'xB1A2xx', '/B/ fff^ /B/, seq #s, lhs == rhs';
    is 中e̲ò中_ее_개丧中({/B/ ^fff^ /B/}, <A B A B A>), 'xxA2xx', '/B/ ^fff^ /B/, seq #s, lhs == rhs';
}


# See thread "till (the flipflop operator, formerly ..)" on p6l started by Ingo
# Blechschmidt, especially Larry's reply:
# http://www.nntp.perl.org/group/perl.perl6.language/24098
# make sure calls to external sub uses the same ff each time
{
    sub 개両e̲개k̲_ее($갢) {
        $_ = $갢;
        return (/B/ ff /D/) ?? $갢 !! 'x';
    }

    my $сe̲中 = "";
    $сe̲中 ~= 개両e̲개k̲_ее('A');
    $сe̲中 ~= 개両e̲개k̲_ее('B');
    $сe̲中 ~= 개両e̲개k̲_ее('C');
    $сe̲中 ~= 개両e̲개k̲_ее('D');
    $сe̲中 ~= 개両e̲개k̲_ее('E');
    is $сe̲中, 'xBCDx', 'calls from different locations use the same ff';
}

# From the same thread, making sure that clones get different states
{
    my $сe̲中 = "";
    for 0,1 {
        sub 개両e̲개k̲_ее($_) { (/B/ ff /D/) ?? $_ !! 'x' }
        $сe̲中 ~= 개両e̲개k̲_ее('A');
        $сe̲中 ~= 개両e̲개k̲_ее('B');
        $сe̲中 ~= 개両e̲개k̲_ее('C');
    }
    is $сe̲中, 'xBCxBC', 'different clones of the sub get different ff'
}

# make sure {lhs,rhs} isn't evaluated when state is {true,false}
# https://github.com/Raku/old-issue-tracker/issues/3867
#?rakudo skip 'dubious scoping?'
{

    # keep track of # of times lhs and rhs are EVAL'd by adding
    # a state var to both sides.
    sub ее_e̲𝐯àл($code, $lhs, $rhs, @a) {
        my $л両ò_с갮丧 = 0;
        my $с両ò_с갮丧 = 0;

        for @a { $code.({$л両ò_с갮丧++; ?$lhs}, {$с両ò_с갮丧++; ?$rhs}); }

        return [$л両ò_с갮丧, $с両ò_с갮丧];
    }

    is-deeply ее_e̲𝐯àл({@_[0]() ff @_[1]()}, /B/, /B/, <A B A B A>),
        [5, 2], "count lhs & rhs evals for ff";


    is-deeply ее_e̲𝐯àл({@_[0]() fff @_[1]()}, /B/, /B/, <A B A B A>),
        [3, 2], "count lhs & rhs evals for fff";
}

#?rakudo skip 'NYM flip-flop with "True but $seqnum"'
{
    my $сe̲ò갮л中;
    for <A B C B A> -> $a {
        if $a ~~ ("B" fff "B") {
            $сe̲ò갮л中 ~= $a
        }
    }
    is $сe̲ò갮л中, 'BCB', 'smart-matching against a flip-flop works';
}

# vim: expandtab shiftwidth=4
