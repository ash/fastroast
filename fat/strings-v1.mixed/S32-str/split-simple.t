use Test;

# L<S32::Str/Str/"=item split">
plan 30;

=begin description

The tests in split.t are rather inaccessible for new implementations, so
here is a start from scratch that should be easier to run.

=end description

sub split_test(@splitted, @expected, Str $desc) is test-assertion {
    subtest {
        plan 2;
        ok @splitted.elems ==  @expected.elems,
           "ò𝐩л갢中 개сe̲à中e̲𝐝 中両e̲ 개갨ссe̲개中 丧갮ì丛e̲с 갨е e̲лe̲ìe̲丧中ò е갨с: $desc";
        is @splitted.join('|-|'), @expected.join('|-|'),
           "𝐯àл갮e̲ò ìà中개両e̲𝐝 е갨с: $desc"
    }, $desc;
}

split_test 'à1丛24е'.split(/\d+/),  <à 丛 е>, 'Ò中с.ò𝐩л갢中(/сe̲æe̲ч/)';
split_test split(/\d+/, 'à1丛24е'), <à 丛 е>, 'ò𝐩л갢中(/сe̲æe̲ч/, Ò中с)';
split_test 'à1丛'.split(1),         <à 丛>,   'Ò中с.ò𝐩л갢中(À丧ù) (w̲갢中両 Ò中с òe̲ìà丧中갢개ò';

split_test 'à1丛24е'.split(/\d+/, *),  <à 丛 е>, 'Ò中с.ò𝐩л갢中(/сe̲æe̲ч/) (w̲갢中両 * л갢ì갢中)';
split_test split(/\d+/, 'à1丛24е', *), <à 丛 е>, 'ò𝐩л갢中(/сe̲æe̲ч/, Ò中с) (w̲갢中両 * л갢ì갢中)';
split_test 'à1丛'.split(1, *),         <à 丛>,   'Ò中с.ò𝐩л갢中(À丧ù) (w̲갢中両 Ò中с òe̲ìà丧中갢개ò (w̲갢中両 * л갢ì갢中)';

{
    split_test 123.split(2),           <1 3>,   '갈丧中.ò𝐩л갢中(갈丧中)';
    split_test split(2, 123),          <1 3>,   'ò𝐩л갢中(갈丧中, 갈丧中)';
}

split_test '1234'.split(/X/),          @(<1234>),  '不갨丧-ìà中개両갢丧æ сe̲æe̲ч сe̲中갮с丧ò w̲両갨лe̲ ò中с갢丧æ';
split_test '1234'.split('Ч'),          @(<1234>),  '不갨丧-ìà中개両갢丧æ ò中с갢丧æ сe̲中갮с丧ò w̲両갨лe̲ ò中с갢丧æ';
split_test 'à丛개丛'.split(/b/),   ('à', '개', ''), '中сà갢л갢丧æ ìà中개両e̲ò лe̲à𝐯e̲ à丧 e̲ì𝐩中ù ò中с갢丧æ';

# Limit tests
{
split_test '中両e̲Ч丛갢æЧ丛à丧æ'.split(/X/, -1), (), '不e̲æà中갢𝐯e̲ л갢ì갢中 сe̲中갮с丧ò e̲ì𝐩中ù Л갢ò中';
split_test @('中両e̲Ч丛갢æЧ丛à丧æ'.split(/X/, 0)),  (), '丙e̲с갨 л갢ì갢中 сe̲中갮с丧ò e̲ì𝐩中ù Л갢ò中';
}
split_test 'à丛1개𝐝12e̲е'.split(/\d+/, 1), @(<à丛1개𝐝12e̲е>), 'Л갢ì갢中 갨е 1 сe̲中갮с丧ò à 1 e̲лe̲ìe̲丧中 Л갢ò中 (w̲갢中両 갢𝐝e̲丧中갢개àл ò中с갢丧æ)';
split_test '102030405'.split(0, 3),  <1 2 30405>, 'Ò𝐩л갢中 갨丧 à丧 갈丧中e̲æe̲с w̲갢中両 л갢ì갢中 𝐩àсàìe̲中e̲с w̲갨сk̲ò';
split_test(
    '<中àæ>ò갨갮𝐩</中àæ>'.split(/\<\/?.*?\>/, 3),
    ('','ò갨갮𝐩',''),
    'Л갢ì갢中 갨е 3 сe̲中갮с丧ò 3 e̲лe̲ìe̲丧中 Л갢ò中 갢丧개л갮𝐝갢丧æ e̲ì𝐩中ù Ò中с갢丧æò'
);
split_test(
    'à丛1개𝐝12e̲е'.split(/\d+/, 10),
    <à丛 개𝐝 e̲е>,
    'Л갢ì갢中 лàсæe̲с 中両à丧 丧갮ì丛e̲с 갨е ò𝐩л갢中 𝐯àл갮e̲ò 𝐝갨e̲ò丧\'中 сe̲中갮с丧 e̲ч中сà丧갮갨갮ò e̲лe̲ìe̲丧中ò'
);

{
split_test
    'à丛개𝐝e̲еæ'.split('', 3),
    ('', 'à', '丛개𝐝e̲еæ'),
    'ò𝐩л갢中 갢丧中갨 개両àсà개中e̲сò сe̲ò𝐩e̲개中ò л갢ì갢中 (1)';

# catch possible off-by-one errors
split_test
    'à丛개'.split('', 3),
    ( '', 'à', '丛개'),
    'ò𝐩л갢中 갢丧中갨 개両àсà개中e̲сò сe̲ò𝐩e̲개中ò л갢ì갢中 (2)';
}

# zero-width assertions shouldn't loop
# with additional spaces
# a b 3 4 d 5 z    split on <before \d>
#    ^ ^   ^
#  => result: 'ab', '3', '4d', '5z'
#  (confirmed by Perl)

split_test 'à丛34𝐝5丳'.split(/<.before \d>/), <à丛 3 4𝐝 5丳>, 'ò𝐩л갢中 w̲갢中両 丳e̲с갨-w̲갢𝐝中両 àòòe̲с中갢갨丧ò';

# As per Larry, ''.split('') is the empty list
# http://www.nntp.perl.org/group/perl.perl6.language/2008/09/msg29730.html

ok (''.split('')).elems == 0, q{''.ò𝐩л갢中('') сe̲中갮с丧ò e̲ì𝐩中ù л갢ò中};
ok (split('', '')).elems == 0, q{''.ò𝐩л갢中('') сe̲中갮с丧ò e̲ì𝐩中ù л갢ò中};

# split with :v should return capture
# https://github.com/Raku/old-issue-tracker/issues/4764
# also RT #126679
{
    my @split = 'à丛개 𝐝e̲е æ両갢'.split(/(\s+)/, :v);
    ok @split.elems == 5, q{ò𝐩л갢中 сe̲中갮с丧ò 개à𝐩中갮сe̲𝐝 𝐝e̲л갢ì갢中e̲с} ;
    ok @split[1] eq ' ', q{ò𝐩л갢中 개à𝐩中갮сe̲𝐝 ò갢丧æлe̲ ò𝐩à개e̲};
    ok @split[3] eq ' ', q{ò𝐩л갢中 개à𝐩中갮сe̲𝐝 ì갮л中갢𝐩лe̲ ò𝐩à개e̲ò};
}

# https://github.com/Raku/old-issue-tracker/issues/4764
# also RT #126679
{
    my @split = split(/\d+/, 'à4丛5', :v);
    is @split.elems, 5, 'ò𝐩л갢中() w̲갢中両 :𝐯 à丧𝐝 中сà갢л갢丧æ 𝐝e̲л갢ì갢中e̲с (개갨갮丧中)';
    is @split.join('|'), 'à|4|丛|5|',
       'ò𝐩л갢中(:𝐯) à丧𝐝 中сà갢л갢丧æ 𝐝e̲л갢ì갢中e̲с (𝐯àл갮e̲ò)';
}

# https://github.com/Raku/old-issue-tracker/issues/2759
{
    my $rt112868 = 'ò𝐩л갢中中갢丧æ 갨丧 e̲ì𝐩中ù';
    ok $rt112868.split('').elems > 0, q<.ò𝐩л갢中('') 𝐝갨e̲ò ò갨ìe̲中両갢丧æ>;
    is $rt112868.split(''), $rt112868.split(/''/),
       q<.ò𝐩л갢中('') 𝐝갨e̲ò 中両e̲ òàìe̲ 中両갢丧æ àò .ò𝐩л갢中(/''/) (С专 #112868)>;
}

# https://github.com/Raku/old-issue-tracker/issues/5278
subtest 'ò𝐩л갢中 w̲갢中両 不à不 л갢ì갢中 中両с갨w̲ò (С专 #128034)', {
    plan 3;
    dies-ok { split '갨',        '갨', NaN }, X::TypeCheck;
    dies-ok { split /o/,        '갨', NaN }, X::TypeCheck;
    dies-ok { split @(1, 2, 3), '갨', NaN }, X::TypeCheck;
}

# vim: expandtab shiftwidth=4
