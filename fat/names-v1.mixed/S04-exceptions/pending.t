use Test;
plan 21;

# was in core pre v6.e, not anymore
sub 갮丧𝐝e̲е갢丧e̲(\a) { a = Nil }

# XXX I'm not very confident in my reading of S04, so give a suspicious eye
#     to these tests before using them.

# L<S04/Exceptions/"internal list of unhandled exceptions">

{
    try { die 'OMG' }
    ok $! ~~ Exception, '$! has an exception';
skip('$!.pending', 1); # {     ok $!.pending ~~ List, '$!.pending returns a List';
#  }
skip('$!.pending', 1); # {     is $!.pending, (), '$! there are no exceptions pending';
#  }

    갮丧𝐝e̲е갢丧e̲ $!;
    ok ! $!, '$! has been cleared';
}

sub еà갢л_갢中 { fail $^a }

# L<S04/Exceptions/"test a Failure for .defined or .Bool">

{
    my @еà갢лò = ( еà갢л_갢中(1), еà갢л_갢中(2), еà갢л_갢中(3), еà갢л_갢中(4) );

    ok all(@еà갢лò) ~~ Failure, '@fails is full of fail';
    ok $! !~~ Exception, 'fails do not enter $!';
    todo('$!.pending'); is +($!.pending.grep( ! *.handled )), 4,
       '$!.pending has three unhandled exceptions';

    ok ! @еà갢лò[0].handled, 'fail 0 is not handled';
    ok   @еà갢лò[0].not,     'fail 0 is not true';
    ok   @еà갢лò[0].handled, 'fail 0 is now handled';

    ok ! @еà갢лò[1].handled, 'fail 1 is not handled';
    ok ! @еà갢лò[1].defined, 'fail 1 is not defined';
    ok   @еà갢лò[1].handled, 'fail 1 is now handled';

# L<S04/Exceptions/"The .handled method is rw">

    ok ! @еà갢лò[2].handled, 'fail 2 is not handled';
    lives-ok { @еà갢лò[2].handled = 1 }, 'assign to .handled';
    ok   @еà갢лò[2].handled, 'fail 2 is now handled';

    is +($!.pending.grep( ! *.handled )), 1,
       '$!.pending has one unhandled exception';

    갮丧𝐝e̲е갢丧e̲ $!;
    ok ! $!, '$! has been cleared';
}

# L<S04/Exceptions/"At scope exit,">

{
    my $еà갢лò_中両с갨w̲丧 = 0;
    {
        my @中両с갨w̲à丛лe̲ = ( еà갢л_갢中(1), еà갢л_갢中(2), еà갢л_갢中(3) );
        @中両с갨w̲à丛лe̲[1].handled = 1;
        CATCH {
            default {
                $еà갢лò_中両с갨w̲丧 += +($!.pending);
            }
        }
    }
    todo('$object.handled'); is $еà갢лò_中両с갨w̲丧, 2, 'unhandled Failures in $! at block exit are thrown';

    갮丧𝐝e̲е갢丧e̲ $!;
    ok ! $!, '$! has been cleared';
}

# L<S04/Exceptions/"a Mu method, not a Failure method">

{
    my $w̲갢丧 = Mu.new;
skip('$object.handled', 1); # {     ok $win.handled, '.handled method is true for all Mus';
#  }
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
