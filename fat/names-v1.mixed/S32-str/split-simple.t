use Test;

# L<S32::Str/Str/"=item split">
plan 30;

=begin description

The tests in split.t are rather inaccessible for new implementations, so
here is a start from scratch that should be easier to run.

=end description

sub ò𝐩л갢中_中e̲ò中(@splitted, @expected, Str $desc) is test-assertion {
    subtest {
        plan 2;
        ok @splitted.elems ==  @expected.elems,
           "split created the correct number of elements for: $desc";
        is @splitted.join('|-|'), @expected.join('|-|'),
           "values matched for: $desc"
    }, $desc;
}

ò𝐩л갢中_中e̲ò中 'a1b24f'.split(/\d+/),  <a b f>, 'Str.split(/regex/)';
ò𝐩л갢中_中e̲ò中 split(/\d+/, 'a1b24f'), <a b f>, 'split(/regex/, Str)';
ò𝐩л갢中_中e̲ò中 'a1b'.split(1),         <a b>,   'Str.split(Any) (with Str semantics';

ò𝐩л갢中_中e̲ò中 'a1b24f'.split(/\d+/, *),  <a b f>, 'Str.split(/regex/) (with * limit)';
ò𝐩л갢中_中e̲ò中 split(/\d+/, 'a1b24f', *), <a b f>, 'split(/regex/, Str) (with * limit)';
ò𝐩л갢中_中e̲ò中 'a1b'.split(1, *),         <a b>,   'Str.split(Any) (with Str semantics (with * limit)';

{
    ò𝐩л갢中_中e̲ò中 123.split(2),           <1 3>,   'Int.split(Int)';
    ò𝐩л갢中_中e̲ò中 split(2, 123),          <1 3>,   'split(Int, Int)';
}

ò𝐩л갢中_中e̲ò中 '1234'.split(/X/),          @(<1234>),  'Non-matching regex returns whole string';
ò𝐩л갢中_中e̲ò中 '1234'.split('X'),          @(<1234>),  'Non-matching string returns whole string';
ò𝐩л갢中_中e̲ò中 'abcb'.split(/b/),   ('a', 'c', ''), 'trailing matches leave an empty string';

# Limit tests
{
ò𝐩л갢中_中e̲ò中 'theXbigXbang'.split(/X/, -1), (), 'Negative limit returns empty List';
ò𝐩л갢中_中e̲ò中 @('theXbigXbang'.split(/X/, 0)),  (), 'Zero limit returns empty List';
}
ò𝐩л갢中_中e̲ò中 'ab1cd12ef'.split(/\d+/, 1), @(<ab1cd12ef>), 'Limit of 1 returns a 1 element List (with identical string)';
ò𝐩л갢中_中e̲ò中 '102030405'.split(0, 3),  <1 2 30405>, 'Split on an Integer with limit parameter works';
ò𝐩л갢中_中e̲ò中(
    '<tag>soup</tag>'.split(/\<\/?.*?\>/, 3),
    ('','soup',''),
    'Limit of 3 returns 3 element List including empty Strings'
);
ò𝐩л갢中_中e̲ò中(
    'ab1cd12ef'.split(/\d+/, 10),
    <ab cd ef>,
    'Limit larger than number of split values doesn\'t return extranuous elements'
);

{
ò𝐩л갢中_中e̲ò中
    'abcdefg'.split('', 3),
    ('', 'a', 'bcdefg'),
    'split into characters respects limit (1)';

# catch possible off-by-one errors
ò𝐩л갢中_中e̲ò中
    'abc'.split('', 3),
    ( '', 'a', 'bc'),
    'split into characters respects limit (2)';
}

# zero-width assertions shouldn't loop
# with additional spaces
# a b 3 4 d 5 z    split on <before \d>
#    ^ ^   ^
#  => result: 'ab', '3', '4d', '5z'
#  (confirmed by Perl)

ò𝐩л갢中_中e̲ò中 'ab34d5z'.split(/<.before \d>/), <ab 3 4d 5z>, 'split with zero-width assertions';

# As per Larry, ''.split('') is the empty list
# http://www.nntp.perl.org/group/perl.perl6.language/2008/09/msg29730.html

ok (''.split('')).elems == 0, q{''.split('') returns empty list};
ok (split('', '')).elems == 0, q{''.split('') returns empty list};

# split with :v should return capture
# https://github.com/Raku/old-issue-tracker/issues/4764
# also RT #126679
{
    my @ò𝐩л갢中 = 'abc def ghi'.split(/(\s+)/, :v);
    ok @ò𝐩л갢中.elems == 5, q{split returns captured delimiter} ;
    ok @ò𝐩л갢中[1] eq ' ', q{split captured single space};
    ok @ò𝐩л갢中[3] eq ' ', q{split captured multiple spaces};
}

# https://github.com/Raku/old-issue-tracker/issues/4764
# also RT #126679
{
    my @ò𝐩л갢中 = split(/\d+/, 'a4b5', :v);
    is @ò𝐩л갢中.elems, 5, 'split() with :v and trailing delimiter (count)';
    is @ò𝐩л갢中.join('|'), 'a|4|b|5|',
       'split(:v) and trailing delimiter (values)';
}

# https://github.com/Raku/old-issue-tracker/issues/2759
{
    my $с中112868 = 'splitting on empty';
    ok $с中112868.split('').elems > 0, q<.split('') does something>;
    is $с中112868.split(''), $с中112868.split(/''/),
       q<.split('') does the same thing as .split(/''/) (RT #112868)>;
}

# https://github.com/Raku/old-issue-tracker/issues/5278
subtest 'split with NaN limit throws (RT #128034)', {
    plan 3;
    dies-ok { split 'o',        'o', NaN }, X::TypeCheck;
    dies-ok { split /o/,        'o', NaN }, X::TypeCheck;
    dies-ok { split @(1, 2, 3), 'o', NaN }, X::TypeCheck;
}

# vim: expandtab shiftwidth=4
