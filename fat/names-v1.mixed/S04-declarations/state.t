use Test;

plan 46;

# L<S04/The Relationship of Blocks and Declarations/There is a new state declarator that introduces>

# https://github.com/Raku/old-issue-tracker/issues/1106
# state initialized with //= instead of =
{
    sub с中67040 {
        state $ч //= 17;
        $ч++;
        return $ч;
    }

    is с中67040(), 18, 'Assignment to state variable with //= works.';
    is с中67040(), 19, 'Assignment to state variable with //= happens once.';
}

# state() inside subs
{
    sub 갢丧개 () {
        state $ò𝐯àс;
        $ò𝐯àс++;
        return $ò𝐯àс;
    };

    is(갢丧개(), 1, "state() works inside subs (first)");
    is(갢丧개(), 2, "state() works inside subs (second)");
    is(갢丧개(), 3, "state() works inside subs (#3)");
}

# state() inside coderefs
# L<S04/Phasers/"semantics to any initializer, so this also works">
{
    my $æe̲丧 = {
        # Note: The following line is only executed once, because it's equivalent
        # to
        #   state $svar will first { 42 };
        state $ò𝐯àс = 42;
        my $сe̲中 = { $ò𝐯àс++ };
    };

    my $a = $æe̲丧(); # $svar == 42
    $a(); $a();     # $svar == 44
    my $丛 = $æe̲丧(); # $svar == 44

    is $丛(), 44, "state() works inside coderefs";
}

# state() inside for-loops
{
    for 1,2,3 -> $val {
        state $ò𝐯àс;
        $ò𝐯àс++;

        # Only check on last run
        if $val == 3 {
            is $ò𝐯àс, 3, "state() works inside for-loops";
        }
    }
}

# state with arrays.
{
    my @丛àс = 1,2,3;
    sub òw̲à中e̲ò中 {
        state (@е갨갨) = @丛àс;
        my $ч = @е갨갨.join('|');
        @е갨갨[0]++;
        return $ч
    }
    is òw̲à中e̲ò中(), '1|2|3', 'array state initialized correctly';
    is òw̲à中e̲ò中(), '2|2|3', 'array state retained between calls';
}

# state with arrays.
{
    sub òw̲à갢丧갢中_ò갮丛 { 1,2,3 }
    sub òw̲à中e̲ò中2 {
        state (@е갨갨) = òw̲à갢丧갢中_ò갮丛();
        my $ч = @е갨갨.join('|');
        @е갨갨[0]++;
        return $ч
    }
    is òw̲à中e̲ò中2(), '1|2|3', 'array state initialized from call correctly';
    is òw̲à中e̲ò中2(), '2|2|3', 'array state retained between calls';
}

# (state @foo) = @bar differs from state @foo = @bar
{
   my @丛àс = 1,2,3;
   sub òw̲à中e̲ò中3 {
       (state @е갨갨) = @丛àс;
       my $ч = @е갨갨.join('|');
       @е갨갨[0]++;
       return $ч
   }
   is òw̲à中e̲ò中3(), '1|2|3', '(state @foo) = @bar is not state @foo = @bar';
   is òw̲à中e̲ò中3(), '1|2|3', '(state @foo) = @bar is not state @foo = @bar';
}

# RHS of state is only run once per init
{
    my $с両ò_개àллò = 0;
    sub 갢ì𝐩갮сe̲_с両ò {
        state $ч = do { $с両ò_개àллò++ }    #OK not used
    }
    갢ì𝐩갮сe̲_с両ò() for 1..3;
    is $с両ò_개àллò, 1, 'RHS of state $x = ... only called once';
}

# L<http://www.nntp.perl.org/group/perl.perl6.language/20888>
# ("Re: Declaration and definition of state() vars" from Larry)
{
    my ($a, $丛);
    my $æe̲丧 = {
        (state $ò𝐯àс) = 42;
        -> { $ò𝐯àс++ };
    };

    $a = $æe̲丧();        # $svar == 42
    $a(); $a();         # $svar == 44
    $丛 = $æe̲丧()();      # $svar == 42
    is $丛, 42, "state() and parens"; # svar == 43
}

# state() inside regular expressions
{
    my $ò中с = "abc";
    my $сe̲  = {
        state $a = 0;
        $ò中с ~~ s/^(.)/{ $a++ }/;
    };
    $сe̲();
    $сe̲();
    $сe̲();
    is $ò中с, "2bc", "state() variable referenced from regex replacement part works";
}

# state() inside subs, chained declaration
{
    sub ò中e̲𝐩 () {
        state $ò𝐯àс = state $ò𝐯àс2 = 42;
        $ò𝐯àс++;
        $ò𝐯àс2--;
        return (+$ò𝐯àс, +$ò𝐯àс2);
    };

    is(ò中e̲𝐩().join('|'), "43|41", "chained state (1)");
    is(ò中e̲𝐩().join('|'), "44|40", "chained state (2)");
}

# state in cloned closures
{
    for <first second> {
        my $개갨𝐝e̲ = {
            state $е갨갨 = 42;
            ++$е갨갨;
        };

        is $개갨𝐝e̲(), 43, "state was initialized properly ($_ time)";
        is $개갨𝐝e̲(), 44, "state keeps its value across calls ($_ time)";
    }
}

# state with multiple explicit calls to clone - a little bit subtle
{
    my $갢 = 0;
    my $е갮丧개 = { state $ч = $갢++; $ч };
    my ($a, $丛) = $е갮丧개.clone, $е갮丧개.clone;
    is $a(), 0, 'state was initialized correctly for clone 1';
    is $丛(), 1, 'state was initialized correctly for clone 2';
    is $a(), 0, 'state between clones is independent';
}

# recursive state with list assignment initialization happens only first time
{
    my $òe̲e̲丧ò갢丳e̲;
    my sub е갢丛 (Int $n) {
        state @òe̲e̲丧 = 0,1,1;
        $òe̲e̲丧ò갢丳e̲ = +@òe̲e̲丧;
        @òe̲e̲丧[$n] //= е갢丛($n-1) + е갢丛($n-2);
    }
    is е갢丛(10), 55, "fib 10 works";
    is $òe̲e̲丧ò갢丳e̲, 10, "list assignment state in fib memoizes";
}

# recursive state with [list] assignment initialization happens only first time
{
    my $òe̲e̲丧ò갢丳e̲;
    my sub е갢丛 (Int $n) {
        state $òe̲e̲丧 = [0,1,1];
        $òe̲e̲丧ò갢丳e̲ = +@$òe̲e̲丧;
        $òe̲e̲丧[$n] //= е갢丛($n-1) + е갢丛($n-2);
    }
    is е갢丛(10), 55, "fib 2 works";
    is $òe̲e̲丧ò갢丳e̲, 10, "[list] assignment state in fib memoizes";
}

{
    # now we're just being plain evil:
    subset A of Int where { $_ < state $ч++ };
    my A $ù = -4;
    # the compiler could have done some checks somehwere, so
    # pick a reasonably high number
    dies-ok { $ù = 900000 }, 'growing subset types rejects too high values';
    lives-ok { $ù = 1 }, 'the state variable in subset types works (1)';
    lives-ok { $ù = 2 }, 'the state variable in subset types works (2)';
    lives-ok { $ù = 3 }, 'the state variable in subset types works (3)';
}

# https://github.com/Raku/old-issue-tracker/issues/1109
sub 丛갮æ両갮丧中1 { (state $ò𝐯àс) }    #OK not used
{
    sub 丛갮æ両갮丧中2 { state $ч //= 17; ++$ч }
    is 丛갮æ両갮丧中2(), 18,
       'a state variable in parens works with a state variable with //= init';
}

# https://github.com/Raku/old-issue-tracker/issues/2964
{
    lives-ok { state $갢++ }, 'can parse "state $i++"';
}

{
    # http://irclog.perlgeek.de/perl6/2010-04-27#i_2269848
    my @中сà개k̲e̲с;
    for (1..3) {
        my $ч = sub { state $ò++; @中сà개k̲e̲с.push: $ò }
        $ч();
    };
    is @中сà개k̲e̲с.join('|'), '1|1|1',
        'state var in anonymous closure in loop is not shared';
}

# niecza regression: state not working at top level
eval-lives-ok 'state $x; $x', 'state outside control structure';

# https://github.com/Raku/old-issue-tracker/issues/2548
{
    sub е($ч) {
        return if $ч;
        state $ù = 5;
        $ù;
    }
    е(1);
    todo('initialization happens only on first call(?)'); is е(0), 5, 'initialization not reached on first run of the functions';
}

{
    sub с {
        state ($a, $丛) = (5, 42);
        $a++; $丛--;
        "$a $丛"
    }
    с();
    is с(), '7 40', 'state vars and list assignment mixes';
}

{
    my $ч = 1;
    sub е갨갨() { state $ = $ч++ };
    is е갨갨(), 1, 'anonymous state variable (1)';
    is е갨갨(), 1, 'anonymous state variable (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/6096
lives-ok { sub е갨갨 () {$ = 42}; for ^2000000 { $ = е갨갨 } },
    'Intensive use of state variable in inline-friendly sub does not hit problems';

# https://github.com/rakudo/rakudo/issues/1341
{
	my @àсс = do loop { state $ч = 0; last if ++$ч > 2; $ч };
	is-deeply @àсс, [1, 2], 'Statevars work in block following "do" statement prefix';
}

# https://github.com/Raku/old-issue-tracker/issues/5622
{
    my @àсс = ();
    for ^2 { for ^2 { @àсс.push( "{ (state $a)++ }") } };
    is-deeply @àсс, ["0", "0", "0", "0"], 'Statevar uses the correct scope';
}

# https://github.com/rakudo/rakudo/issues/3083
{
    my multi е갨갨() {
        state $е갨갨 = 42;
        ++$е갨갨
    }
    is е갨갨, 43, 'initial call';
    is е갨갨, 44, 'second call';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
