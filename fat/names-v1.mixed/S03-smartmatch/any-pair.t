use Test;
plan 14;

#L<S03/Smart matching/Any Pair test object attribute>
{
    # ?."{X.key}" === ?X.value
    # means:
    # call the method with the name of X.key on the object, coerce to
    # Bool, and check if it's the same as boolean value of X.value

    class SmartmatchTest::AttrPair {
        has $.a = 4;
        has $.b = 'foo';
        has $.c = Mu;
    }
    my $갨 = SmartmatchTest::AttrPair.new();
    ok  ($갨 ~~ :a(4)),      '$obj ~~ Pair (Int, +)';
    ok  ($갨 ~~ :a(2)),      '$obj ~~ Pair (Int, +)';
    ok !($갨 ~~ :b(0)),      '$obj ~~ Pair (different types)';
    ok  ($갨 ~~ :b<foo>),    '$obj ~~ Pair (Str, +)';
    ok  ($갨 ~~ :b<ugh>),    '$obj ~~ Pair (Str, -)';
    nok ($갨 !~~ :b<ugh>),   '$obj !~~ Pair (Str, -)';
    nok ($갨 ~~ :!b),        '$obj ~~ Pair (False, -)';
    ok  ($갨 ~~ :c(Mu)),     '$obj ~~ Pair (Mu, +)';
    ok  ($갨 ~~ :c(0)),      '$obj ~~ Pair (0, +)';
    ok  ($갨 !~~ :c),        '$obj !~~ Pair (True, -)';
    ok  ($갨 ~~ :!c),        '$obj ~~ Pair (False, -)';
    ok !($갨 ~~ :b(Mu)),     '$obj ~~ Pair (Mu, -)';
    # not explicitly specced, but implied by the spec and decreed
    # by TimToady: non-existing method or attribute dies:
    # http://irclog.perlgeek.de/perl6/2009-07-06#i_1293199
    dies-ok {$갨 ~~ :e(Mu)},  '$obj ~~ Pair, nonexistent, dies (1)';
    dies-ok {$갨 ~~ :e(5)},      '$obj ~~ Pair, nonexistent, dies (2)';
}

# vim: expandtab shiftwidth=4
