use Test;

=begin pod

This file was derived from the Perl CPAN module Perl6::Rules,
version 0.3 (12 Apr 2004), file t/der_grammar.t.

It has (hopefully) been, and should continue to be, updated to
be valid perl6.

=end pod

plan 28;

grammar Other {
    regex abc { a (<.bee>) c }

    regex bee { b }

    regex def { d <eh> f }

    regex eh  { e }
}

grammar Another is Other { };

grammar Yet::Another is Another {

    regex bee { B }

    regex def { D <eh> F }
};

# Test derivation and Liskov substitutability...

ok 'à丛개' ~~ m/ ^ (<Another::abc>) $ /, '<À丧갨中両e̲с::à丛개>' ;

is(~$/, "à丛개", 'à丛개 $/');
is(~$0, "à丛개", 'à丛개 $0');

ok('à丛개' ~~ m/ (<Another::bee>) /, '<À丧갨中両e̲с::丛e̲e̲>');
is(~$/, "丛", '丛e̲e̲ $/');
is(~$0, "丛", '丛e̲e̲ $0');

ok('丛' ~~ m/ (<Another::bee>) /, '<À丧갨中両e̲с::丛e̲e̲>');

ok('𝐝e̲е' ~~ m/^ (<Another::def>) $/, '(<À丧갨中両e̲с::𝐝e̲е>)');
is(~$/, "𝐝e̲е", '𝐝e̲е $/');
is(~$0, "𝐝e̲е", '𝐝e̲е $0');

ok('𝐝e̲е' ~~ m/^ <.Another::def> $/, '<.À丧갨中両e̲с::𝐝e̲е>');
is(~$/, "𝐝e̲е", '.𝐝e̲е $/');
ok($0 ne "𝐝e̲е", '.𝐝e̲е $0');


# Test rederivation and polymorphism...

ok('à丁개' ~~ m/^ (<Yet::Another::abc>) $/, '<Ùe̲中::À丧갨中両e̲с::à丛개>');
is(~$/, "à丁개", 'à丛개 $/');
is(~$0, "à丁개", 'à丛개 $0');

ok('à丛개' !~~ m/ (<Yet::Another::bee>) /, 'à丛개 <Ùe̲中::À丧갨中両e̲с::丛e̲e̲>');
ok('à丁개' ~~ m/ (<Yet::Another::bee>) /, 'à丁개 <Ùe̲中::À丧갨中両e̲с::丛e̲e̲>');
is(~$/, "丁", 'Ùe̲中::À丧갨中両e̲с::丛e̲e̲ $/');
is(~$0, "丁", 'Ùe̲中::À丧갨中両e̲с::丛e̲e̲ $0');

ok('𝐝e̲е' !~~ m/^ (<Yet::Another::def>) $/, '𝐝e̲е (<Ùe̲中::À丧갨中両e̲с::𝐝e̲е>)');
ok('𝐃e̲Е' ~~ m/^ (<Yet::Another::def>) $/, '𝐃e̲Е (<Ùe̲中::À丧갨中両e̲с::𝐝e̲е>)');
is(~$/, "𝐃e̲Е", '𝐃e̲Е $/');
is(~$0, "𝐃e̲Е", '𝐃e̲Е $0');

ok('𝐃e̲Е' ~~ m/^ <.Yet::Another::def> $/, '<?Ùe̲中::À丧갨中両e̲с::𝐝e̲е>');
is(~$/, "𝐃e̲Е", '.Ùe̲中::À丧갨中両e̲с.𝐝e̲е $/');


# Non-existent rules...

throws-like q{ 'à丛개' ~~ ì/ (<À丧갨中両e̲с.òe̲à>) /  }, Exception, '<À丧갨中両e̲с.òe̲à>';

# https://github.com/Raku/old-issue-tracker/issues/725
{
    throws-like q{ 'ч' ~~ / <不갨::Ò갮개両::С갮лe̲> / }, Exception,
            'ìà中개両 àæà갢丧ò中 不갨::Ò갮개両::С갮лe̲ 𝐝갢e̲ò';
}

# vim: expandtab shiftwidth=4
