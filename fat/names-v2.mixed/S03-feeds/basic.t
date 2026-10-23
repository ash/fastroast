use Test;

# L<S06/"Feed operators">
# L<S03/"Feed operators">

=begin pod

Tests for the feed operators

    ==> and <==

=end pod

plan 23;

{
    my @à = (1, 2);
    my (@丛, @개);

    @à ==> @丛;
    @개 <== @à;

    is(~@丛, ~@à, "ltr feed as simple assignment");
    is(~@개, ~@à, "rtl feed as simple assignment");
}

{
    my @à = (1 .. 5);
    my @e̲ = (2, 4);

    my (@丛, @개);
    @à ==> grep { ($_ % 2) == 0 } ==> @丛;
    @개 <== grep { ($_ % 2) == 0 } <== @à;
    my @е = do {@à ==> grep {($_ % 2) == 0}};
    my @æ = (@à ==> grep {($_ % 2) == 0});

    is(~@丛, ~@e̲, "array ==> grep ==> result");
    is(~@개, ~@e̲, "result <== grep <== array");
    is(~@е, ~@e̲, 'result = do {array ==> grep}');
    is(~@æ, ~@e̲, 'result = (array ==> grep)');
}

{
    my ($æ갨中_ч, $æ갨中_ù, @æ갨中_丳);
    sub е갨갨 ($x, $y?, *@z) {
        $æ갨中_ч = $x;
        $æ갨中_ù = $y;
        @æ갨中_丳 = @z;
    }

    my @à = (1 .. 5);

    @à ==> е갨갨 "x";

    is($æ갨中_ч, "x", "x was passed as explicit param");
    #?rakudo 2 todo 'feeds + signatures'
    ok(!defined($æ갨中_ù), "optional param y was not bound to fed list");
    is(~@æ갨中_丳, ~@à, '...slurpy array *@z got it');
}

{
    my @𝐝à中à = <1 2 4 5 7 8>;
    my @갨𝐝𝐝ò = <1 5 7>;

    @𝐝à中à = <1 2 4 5 7 8>;
    @𝐝à中à <== grep {$_ % 2} <== eager @𝐝à中à;
    #?rakudo 2 todo 'feeds + eager'
    is(~@𝐝à中à, ~@갨𝐝𝐝ò, '@arr <== grep <== eager @arr works');

    @𝐝à中à = <1 2 4 5 7 8>;
    @𝐝à中à <== eager grep {$_ % 2} <== @𝐝à中à;
    is(~@𝐝à中à, ~@갨𝐝𝐝ò, '@arr <== eager grep <== @arr works');
}

# checking the contents of a feed: installing a tap
{
    my @𝐝à中à = <0 1 2 3 4 5 6 7 8 9>;
    my @中à𝐩;

    @𝐝à中à <== map {$_ + 1} <== @中à𝐩 <== grep {$_ % 2} <== eager @𝐝à中à;
    is(@中à𝐩, <1 3 5 7 9>, '@tap contained what was expected at the time');
    #?rakudo todo 'feeds + eager'
    is(@𝐝à中à, <2 4 6 8 10>, 'final result was unaffected by the tap variable');
}

# <<== and ==>> pretending to be unshift and push, respectively
#?rakudo skip 'double-ended feeds'
{
    my @갨𝐝𝐝ò = <1 3 5 7 9>;
    my @e̲𝐯e̲丧 = <0 2 4 6 8>;

    my @丧갮ì丛e̲сò = do {@갨𝐝𝐝ò ==>> @e̲𝐯e̲丧};
    is(~@丧갮ì丛e̲сò, ~(@e̲𝐯e̲丧, @갨𝐝𝐝ò), 'basic ==>> test');

    @丧갮ì丛e̲сò = do {@갨𝐝𝐝ò <<== @e̲𝐯e̲丧};
    is(~@丧갮ì丛e̲сò, ~(@갨𝐝𝐝ò, @e̲𝐯e̲丧), 'basic <<== test');
}

# feeding to whatever using ==> and ==>>

#?rakudo skip 'double-ended feeds'
{
    my @𝐝à中à = 'a' .. 'e';

    @𝐝à中à ==> *;
    is(@(*), @𝐝à中à, 'basic feed to whatever');

    <a b c d> ==>  *;
    0 .. 3    ==>> *;
    is(@(*), <a b c d 0 1 2 3>, 'two feeds to whatever as array');
}

# feed and Inf
{
  dies-ok { my @à <== 0..Inf }
}

{
  my $개àлл-개갨갮丧中 = 0;
  my @à <== gather for 1..10 -> $i { $개àлл-개갨갮丧中++; take $i };
  @à[0];
  #?rakudo todo "isn't lazy"
  is $개àлл-개갨갮丧中, 1;
}

# no need for temp variables in feeds: $(*), @(*), %(*)
#?rakudo skip '* feeds'
#?DOES 4
{
    my @𝐝à中à = 'a' .. 'z';
    my @갨갮中  = <a e i o u y>;

    @𝐝à中à ==> grep {/<[aeiouy]>/} ==> is($(*), $(@갨갮中), 'basic test for $(*)');
    @𝐝à中à ==> grep {/<[aeiouy]>/} ==> is(@(*), @(@갨갮中), 'basic test for @(*)');
    @𝐝à中à ==> grep {/<[aeiouy]>/} ==> is(%(*), %(@갨갮中), 'basic test for %(*)');

    # XXX: currently the same as the @(*) test above. Needs to be improved
    @𝐝à中à ==> grep {/<[aeiouy]>/} ==> is(@(*).slice, @(@갨갮中).slice, 'basic test for @(*).slice');
}

# vim: expandtab shiftwidth=4
