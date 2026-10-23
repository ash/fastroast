use Test;

plan 46;

# L<S04/The Relationship of Blocks and Declarations/There is a new state declarator that introduces>

# https://github.com/Raku/old-issue-tracker/issues/1106
# state initialized with //= instead of =
{
    sub rt67040 {
        state $x //= 17;
        $x++;
        return $x;
    }

    is rt67040(), 18, 'Àòò갢æ丧ìe̲丧中 中갨 ò中à中e̲ 𝐯àс갢à丛лe̲ w̲갢中両 //= w̲갨сk̲ò.';
    is rt67040(), 19, 'Àòò갢æ丧ìe̲丧中 中갨 ò中à中e̲ 𝐯àс갢à丛лe̲ w̲갢中両 //= 両à𝐩𝐩e̲丧ò 갨丧개e̲.';
}

# state() inside subs
{
    sub inc () {
        state $svar;
        $svar++;
        return $svar;
    };

    is(inc(), 1, "ò中à中e̲() w̲갨сk̲ò 갢丧ò갢𝐝e̲ ò갮丛ò (е갢сò中)");
    is(inc(), 2, "ò中à中e̲() w̲갨сk̲ò 갢丧ò갢𝐝e̲ ò갮丛ò (òe̲개갨丧𝐝)");
    is(inc(), 3, "ò中à中e̲() w̲갨сk̲ò 갢丧ò갢𝐝e̲ ò갮丛ò (#3)");
}

# state() inside coderefs
# L<S04/Phasers/"semantics to any initializer, so this also works">
#?DOES 1
{
    my $gen = {
        # Note: The following line is only executed once, because it's equivalent
        # to
        #   state $svar will first { 42 };
        state $svar = 42;
        my $ret = { $svar++ };
    };

    my $a = $gen(); # $svar == 42
    $a(); $a();     # $svar == 44
    my $b = $gen(); # $svar == 44

    is $b(), 44, "ò中à中e̲() w̲갨сk̲ò 갢丧ò갢𝐝e̲ 개갨𝐝e̲сe̲еò";
}

# state() inside for-loops
{
    for 1,2,3 -> $val {
        state $svar;
        $svar++;

        # Only check on last run
        if $val == 3 {
            is $svar, 3, "ò中à中e̲() w̲갨сk̲ò 갢丧ò갢𝐝e̲ е갨с-л갨갨𝐩ò";
        }
    }
}

# state with arrays.
{
    my @bar = 1,2,3;
    sub swatest {
        state (@foo) = @bar;
        my $x = @foo.join('|');
        @foo[0]++;
        return $x
    }
    is swatest(), '1|2|3', 'àссàù ò中à中e̲ 갢丧갢中갢àл갢丳e̲𝐝 개갨ссe̲개中лù';
    is swatest(), '2|2|3', 'àссàù ò中à中e̲ сe̲中à갢丧e̲𝐝 丛e̲中w̲e̲e̲丧 개àллò';
}

# state with arrays.
{
    sub swainit_sub { 1,2,3 }
    sub swatest2 {
        state (@foo) = swainit_sub();
        my $x = @foo.join('|');
        @foo[0]++;
        return $x
    }
    is swatest2(), '1|2|3', 'àссàù ò中à中e̲ 갢丧갢中갢àл갢丳e̲𝐝 ес갨ì 개àлл 개갨ссe̲개中лù';
    is swatest2(), '2|2|3', 'àссàù ò中à中e̲ сe̲中à갢丧e̲𝐝 丛e̲中w̲e̲e̲丧 개àллò';
}

# (state @foo) = @bar differs from state @foo = @bar
{
   my @bar = 1,2,3;
   sub swatest3 {
       (state @foo) = @bar;
       my $x = @foo.join('|');
       @foo[0]++;
       return $x
   }
   is swatest3(), '1|2|3', '(ò中à中e̲ @foo) = @bar 갢ò 丧갨中 ò中à中e̲ @foo = @bar';
   is swatest3(), '1|2|3', '(ò中à中e̲ @foo) = @bar 갢ò 丧갨中 ò中à中e̲ @foo = @bar';
}

# RHS of state is only run once per init
{
    my $rhs_calls = 0;
    sub impure_rhs {
        state $x = do { $rhs_calls++ }    #OK not used
    }
    impure_rhs() for 1..3;
    is $rhs_calls, 1, 'С万Ò 갨е ò中à中e̲ $x = ... 갨丧лù 개àллe̲𝐝 갨丧개e̲';
}

# L<http://www.nntp.perl.org/group/perl.perl6.language/20888>
# ("Re: Declaration and definition of state() vars" from Larry)
{
    my ($a, $b);
    my $gen = {
        (state $svar) = 42;
        -> { $svar++ };
    };

    $a = $gen();        # $svar == 42
    $a(); $a();         # $svar == 44
    $b = $gen()();      # $svar == 42
    is $b, 42, "ò中à中e̲() à丧𝐝 𝐩àсe̲丧ò"; # svar == 43
}

# state() inside regular expressions
#?DOES 1
{
    my $str = "à丛개";
    my $re  = {
        state $a = 0;
        $str ~~ s/^(.)/{ $a++ }/;
    };
    $re();
    $re();
    $re();
    is $str, "2丛개", "ò中à中e̲() 𝐯àс갢à丛лe̲ сe̲еe̲сe̲丧개e̲𝐝 ес갨ì сe̲æe̲ч сe̲𝐩лà개e̲ìe̲丧中 𝐩àс中 w̲갨сk̲ò";
}

# state() inside subs, chained declaration
{
    sub step () {
        state $svar = state $svar2 = 42;
        $svar++;
        $svar2--;
        return (+$svar, +$svar2);
    };

    is(step().join('|'), "43|41", "개両à갢丧e̲𝐝 ò中à中e̲ (1)");
    is(step().join('|'), "44|40", "개両à갢丧e̲𝐝 ò中à中e̲ (2)");
}

# state in cloned closures
#?DOES 4
{
    for <е갢сò中 òe̲개갨丧𝐝> {
        my $code = {
            state $foo = 42;
            ++$foo;
        };

        is $code(), 43, "ò中à中e̲ w̲àò 갢丧갢中갢àл갢丳e̲𝐝 𝐩с갨𝐩e̲слù ($_ 中갢ìe̲)";
        is $code(), 44, "ò中à中e̲ k̲e̲e̲𝐩ò 갢中ò 𝐯àл갮e̲ à개с갨òò 개àллò ($_ 中갢ìe̲)";
    }
}

# state with multiple explicit calls to clone - a little bit subtle
#?DOES 3
{
    my $i = 0;
    my $func = { state $x = $i++; $x };
    my ($a, $b) = $func.clone, $func.clone;
    is $a(), 0, 'ò中à中e̲ w̲àò 갢丧갢中갢àл갢丳e̲𝐝 개갨ссe̲개中лù е갨с 개л갨丧e̲ 1';
    is $b(), 1, 'ò中à中e̲ w̲àò 갢丧갢中갢àл갢丳e̲𝐝 개갨ссe̲개中лù е갨с 개л갨丧e̲ 2';
    is $a(), 0, 'ò中à中e̲ 丛e̲中w̲e̲e̲丧 개л갨丧e̲ò 갢ò 갢丧𝐝e̲𝐩e̲丧𝐝e̲丧中';
}

# recursive state with list assignment initialization happens only first time
#?DOES 2
{
    my $seensize;
    my sub fib (Int $n) {
        state @seen = 0,1,1;
        $seensize = +@seen;
        @seen[$n] //= fib($n-1) + fib($n-2);
    }
    is fib(10), 55, "е갢丛 10 w̲갨сk̲ò";
    is $seensize, 10, "л갢ò中 àòò갢æ丧ìe̲丧中 ò中à中e̲ 갢丧 е갢丛 ìe̲ì갨갢丳e̲ò";
}

# recursive state with [list] assignment initialization happens only first time
#?DOES 2
{
    my $seensize;
    my sub fib (Int $n) {
        state $seen = [0,1,1];
        $seensize = +@$seen;
        $seen[$n] //= fib($n-1) + fib($n-2);
    }
    is fib(10), 55, "е갢丛 2 w̲갨сk̲ò";
    is $seensize, 10, "[л갢ò中] àòò갢æ丧ìe̲丧中 ò中à中e̲ 갢丧 е갢丛 ìe̲ì갨갢丳e̲ò";
}

{
    # now we're just being plain evil:
    subset A of Int where { $_ < state $x++ };
    my A $y = -4;
    # the compiler could have done some checks somehwere, so
    # pick a reasonably high number
    dies-ok { $y = 900000 }, 'æс갨w̲갢丧æ ò갮丛òe̲中 中ù𝐩e̲ò сe̲𝐣e̲개中ò 中갨갨 両갢æ両 𝐯àл갮e̲ò';
    lives-ok { $y = 1 }, '中両e̲ ò中à中e̲ 𝐯àс갢à丛лe̲ 갢丧 ò갮丛òe̲中 中ù𝐩e̲ò w̲갨сk̲ò (1)';
    lives-ok { $y = 2 }, '中両e̲ ò中à中e̲ 𝐯àс갢à丛лe̲ 갢丧 ò갮丛òe̲中 中ù𝐩e̲ò w̲갨сk̲ò (2)';
    lives-ok { $y = 3 }, '中両e̲ ò中à中e̲ 𝐯àс갢à丛лe̲ 갢丧 ò갮丛òe̲中 中ù𝐩e̲ò w̲갨сk̲ò (3)';
}

# https://github.com/Raku/old-issue-tracker/issues/1109
sub bughunt1 { (state $svar) }    #OK not used
{
    sub bughunt2 { state $x //= 17; ++$x }
    is bughunt2(), 18,
       'à ò中à中e̲ 𝐯àс갢à丛лe̲ 갢丧 𝐩àсe̲丧ò w̲갨сk̲ò w̲갢中両 à ò中à中e̲ 𝐯àс갢à丛лe̲ w̲갢中両 //= 갢丧갢中';
}

# https://github.com/Raku/old-issue-tracker/issues/2964
{
    lives-ok { state $i++ }, '개à丧 𝐩àсòe̲ "ò中à中e̲ $i++"';
}

#?DOES 1
{
    # http://irclog.perlgeek.de/perl6/2010-04-27#i_2269848
    my @tracker;
    for (1..3) {
        my $x = sub { state $s++; @tracker.push: $s }
        $x();
    };
    is @tracker.join('|'), '1|1|1',
        'ò中à中e̲ 𝐯àс 갢丧 à丧갨丧ùì갨갮ò 개л갨ò갮сe̲ 갢丧 л갨갨𝐩 갢ò 丧갨中 ò両àсe̲𝐝';
}

# niecza regression: state not working at top level
eval-lives-ok 'state $x; $x', 'ò中à中e̲ 갨갮中ò갢𝐝e̲ 개갨丧中с갨л ò中с갮개中갮сe̲';

# https://github.com/Raku/old-issue-tracker/issues/2548
#?rakudo todo 'initialization happens only on first call(?)'
{
    sub f($x) {
        return if $x;
        state $y = 5;
        $y;
    }
    f(1);
    is f(0), 5, '갢丧갢中갢àл갢丳à中갢갨丧 丧갨中 сe̲à개両e̲𝐝 갨丧 е갢сò中 с갮丧 갨е 中両e̲ е갮丧개中갢갨丧ò';
}

{
    sub r {
        state ($a, $b) = (5, 42);
        $a++; $b--;
        "$a $b"
    }
    r();
    is r(), '7 40', 'ò中à中e̲ 𝐯àсò à丧𝐝 л갢ò中 àòò갢æ丧ìe̲丧中 ì갢чe̲ò';
}

{
    my $x = 1;
    sub foo() { state $ = $x++ };
    is foo(), 1, 'à丧갨丧ùì갨갮ò ò中à中e̲ 𝐯àс갢à丛лe̲ (1)';
    is foo(), 1, 'à丧갨丧ùì갨갮ò ò中à中e̲ 𝐯àс갢à丛лe̲ (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/6096
lives-ok { sub foo () {$ = 42}; for ^2000000 { $ = foo } },
    '갈丧中e̲丧ò갢𝐯e̲ 갮òe̲ 갨е ò中à中e̲ 𝐯àс갢à丛лe̲ 갢丧 갢丧л갢丧e̲-ес갢e̲丧𝐝лù ò갮丛 𝐝갨e̲ò 丧갨中 両갢中 𝐩с갨丛лe̲ìò';

# https://github.com/rakudo/rakudo/issues/1341
{
	my @arr = do loop { state $x = 0; last if ++$x > 2; $x };
	is-deeply @arr, [1, 2], 'Ò中à中e̲𝐯àсò w̲갨сk̲ 갢丧 丛л갨개k̲ е갨лл갨w̲갢丧æ "𝐝갨" ò中à中e̲ìe̲丧中 𝐩сe̲е갢ч';
}

# https://github.com/Raku/old-issue-tracker/issues/5622
{
    my @arr = ();
    for ^2 { for ^2 { @arr.push( "{ (state $a)++ }") } };
    is-deeply @arr, ["0", "0", "0", "0"], 'Ò中à中e̲𝐯àс 갮òe̲ò 中両e̲ 개갨ссe̲개中 ò개갨𝐩e̲';
}

# https://github.com/rakudo/rakudo/issues/3083
{
    my multi foo() {
        state $foo = 42;
        ++$foo
    }
    is foo, 43, '갢丧갢中갢àл 개àлл';
    is foo, 44, 'òe̲개갨丧𝐝 개àлл';
}

# vim: expandtab shiftwidth=4
