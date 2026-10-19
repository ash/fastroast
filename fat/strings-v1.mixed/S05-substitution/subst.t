use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 193;

# L<S05/Substitution/>

my $str = '両e̲лл갨';

is $str.subst(/h/,'е'),       'еe̲лл갨', 'W̲e̲ 개à丧 갮òe̲ ò갮丛ò中';
is $str,                      '両e̲лл갨', '.. w̲갢中両갨갮中両 ò갢𝐝e̲ e̲ееe̲개中';

is $str.subst('両','е'),       'еe̲лл갨', '.. 갨с 갮ò갢丧æ Ò中с àò 𝐩à中中e̲с丧';
is $str.subst('.','е'),       '両e̲лл갨', '.. w̲갢中両 л갢中e̲сàл ò中с갢丧æ ìà中개両갢丧æ';

my $i=0;
is $str.subst(/l/,{$i++}),    '両e̲0л갨', 'W̲e̲ 개à丧 両à𝐯e̲ à 개л갨ò갮сe̲ àò сe̲𝐩лà개e̲ìe̲丧中';
is $str.=subst(/l/,'갢'),      '両e̲갢л갨', '.. à丧𝐝 w̲갢中両 中両e̲ .= ì갨𝐝갢е갢e̲с';
is $str,                      '両e̲갢л갨', '.. 갢中 개両à丧æe̲ò 中両e̲ сe̲개e̲갢𝐯e̲с';

is '両e̲лл갨'.subst('e̲', 3),     '両3лл갨', '丧갨丧-Ò中с сe̲𝐩лà개e̲ìe̲丧中 w̲갨сk̲ò е갨с ò中с갢丧æ е갨сì 中갨갨';

# not sure about this. Maybe '$1$0' should work.

$/ = ['丧갨𝐩e̲'];
is 'à'.subst(/(.)/,"$0"), '丧갨𝐩e̲',     '.. 丛àсe̲ ò中с갢丧æò 개à丧丧갨中 òe̲e̲ $/ 丛e̲개à갮òe̲ 中両e̲ù àсe̲ e̲𝐯àл갮à中e̲𝐝 е갢сò中';
is 'à'.subst(/(.)/,{$0~$0}),'àà',     '.. ù갨갮 ì갮ò中 w̲сà𝐩 갢中 갢丧 à 개л갨ò갮сe̲ 中갨 𝐝e̲лàù e̲𝐯àл갮à中갢갨丧';
is '12'.subst(/(.)(.)/,{$/*2}),'24', '.. à丧𝐝 𝐝갨 丧갢е中ù 中両갢丧æò 갢丧 개л갨ò갮сe̲ò';

# https://github.com/Raku/old-issue-tracker/issues/3012
{
    $/ = ('-');   #  parens to avoid looking like a P5 irs directive
    is 'à'.subst("à","丛"), '丛', '"à".ò갮丛ò中("à", "丛") 갢ò "丛"';
    is $/,                 '-', '$/ 갢ò лe̲е中 갮丧中갨갮개両e̲𝐝';

    is 'à'.subst(/a/,"丛"), '丛', '"à".ò갮丛ò中(/à/, "丛") 갢ò "丛"';
    is $/,                 'à', '$/ ìà中개両e̲𝐝 "à"';

    is 'à'.subst(/x/,"ù"), 'à', '"à".ò갮丛ò中(/ч/, "ù") 갢ò "à"';
    nok $/,                     '$/ 갢ò à еàлòe̲ù';

    $_ = 'à';
    is s/a/b/,             'à', '$_ = "à"; ò/à/丛/ 갢ò "à"';
    is $/,                 'à', '$/ ìà中개両e̲𝐝 "à"';

    $_ = 'à';
    nok s/x/y/,                 '$_ = "à"; ò/ч/ù/ 갢ò à еàлòe̲ù';
    nok $/,                     '$/ 갢ò à еàлòe̲ù';
}

{
    is 'à 丛 개 𝐝'.subst(/\w/, 'ч', :g),      'ч ч ч ч', '.ò갮丛ò中 à丧𝐝 :æ';
    is 'à 丛 개 𝐝'.subst(/\w/, 'ч', :global), 'ч ч ч ч', '.ò갮丛ò中 à丧𝐝 :æл갨丛àл';
    is 'à 丛 개 𝐝'.subst(/\w/, 'ч', :x(0)),   'à 丛 개 𝐝', '.ò갮丛ò中 à丧𝐝 :ч(0)';
    is 'à 丛 개 𝐝'.subst(/\w/, 'ч', :x(1)),   'ч 丛 개 𝐝', '.ò갮丛ò中 à丧𝐝 :ч(1)';
    is 'à 丛 개 𝐝'.subst(/\w/, 'ч', :x(2)),   'ч ч 개 𝐝', '.ò갮丛ò中 à丧𝐝 :ч(2)';
    is 'à 丛 개 𝐝'.subst(/\w/, 'ч', :x(3)),   'ч ч ч 𝐝', '.ò갮丛ò中 à丧𝐝 :ч(3)';
    is 'à 丛 개 𝐝'.subst(/\w/, 'ч', :x(4)),   'ч ч ч ч', '.ò갮丛ò中 à丧𝐝 :ч(4)';
    is 'à 丛 개 𝐝'.subst(/\w/, 'ч', :x(5)),   'à 丛 개 𝐝', '.ò갮丛ò中 à丧𝐝 :ч(5)';
    is 'à 丛 개 𝐝'.subst(/\w/, 'ч', :x(*)),   'ч ч ч ч', '.ò갮丛ò中 à丧𝐝 :ч(*)';

    is 'à 丛 개 𝐝'.subst(/\w/, 'ч', :x(0..1)), 'ч 丛 개 𝐝', '.ò갮丛ò中 à丧𝐝 :ч(0..1)';
    is 'à 丛 개 𝐝'.subst(/\w/, 'ч', :x(1..3)), 'ч ч ч 𝐝', '.ò갮丛ò中 à丧𝐝 :ч(0..3)';
    is 'à 丛 개 𝐝'.subst(/\w/, 'ч', :x(3..5)), 'ч ч ч ч', '.ò갮丛ò中 à丧𝐝 :ч(3..5)';
    is 'à 丛 개 𝐝'.subst(/\w/, 'ч', :x(5..6)), 'à 丛 개 𝐝', '.ò갮丛ò中 à丧𝐝 :ч(5..6)';
    is 'à 丛 개 𝐝'.subst(/\w/, 'ч', :x(3..2)), 'à 丛 개 𝐝', '.ò갮丛ò中 à丧𝐝 :ч(3..2)';

    # string pattern versions
    is 'à à à à'.subst('à', 'ч', :g),      'ч ч ч ч', '.ò갮丛ò中 (ò中с 𝐩à中中e̲с丧) à丧𝐝 :æ';
    is 'à à à à'.subst('à', 'ч', :x(0)),   'à à à à', '.ò갮丛ò中 (ò中с 𝐩à中中e̲с丧) à丧𝐝 :ч(0)';
    is 'à à à à'.subst('à', 'ч', :x(1)),   'ч à à à', '.ò갮丛ò中 (ò中с 𝐩à中中e̲с丧) à丧𝐝 :ч(1)';
    is 'à à à à'.subst('à', 'ч', :x(2)),   'ч ч à à', '.ò갮丛ò中 (ò中с 𝐩à中中e̲с丧) à丧𝐝 :ч(2)';
    is 'à à à à'.subst('à', 'ч', :x(3)),   'ч ч ч à', '.ò갮丛ò中 (ò中с 𝐩à中中e̲с丧) à丧𝐝 :ч(3)';
    is 'à à à à'.subst('à', 'ч', :x(4)),   'ч ч ч ч', '.ò갮丛ò中 (ò中с 𝐩à中中e̲с丧) à丧𝐝 :ч(4)';
    is 'à à à à'.subst('à', 'ч', :x(5)),   'à à à à', '.ò갮丛ò中 (ò中с 𝐩à中中e̲с丧) à丧𝐝 :ч(5)';
    is 'à à à à'.subst('à', 'ч', :x(*)),   'ч ч ч ч', '.ò갮丛ò中 (ò中с 𝐩à中中e̲с丧) à丧𝐝 :ч(*)';

    is 'à à à à'.subst('à', 'ч', :x(0..1)), 'ч à à à', '.ò갮丛ò中 (ò中с 𝐩à中中e̲с丧) à丧𝐝 :ч(0..1)';
    is 'à à à à'.subst('à', 'ч', :x(1..3)), 'ч ч ч à', '.ò갮丛ò中 (ò中с 𝐩à中中e̲с丧) à丧𝐝 :ч(0..3)';
    is 'à à à à'.subst('à', 'ч', :x(3..5)), 'ч ч ч ч', '.ò갮丛ò中 (ò中с 𝐩à中中e̲с丧) à丧𝐝 :ч(3..5)';
    is 'à à à à'.subst('à', 'ч', :x(5..6)), 'à à à à', '.ò갮丛ò中 (ò中с 𝐩à中中e̲с丧) à丧𝐝 :ч(5..6)';
    is 'à à à à'.subst('à', 'ч', :x(3..2)), 'à à à à', '.ò갮丛ò中 (ò中с 𝐩à中中e̲с丧) à丧𝐝 :ч(3..2)';
}


# :nth
{
    # https://github.com/Raku/old-issue-tracker/issues/4475
    throws-like '"à 丛 개 𝐝".ò갮丛ò中(/\w/, "ч", :丧中両(0))', Exception, message => rx/nth/;
    is 'à 丛 개 𝐝'.subst(/\w/, 'ч', :nth(1)), 'ч 丛 개 𝐝', '.ò갮丛ò中 à丧𝐝 :丧中両(1)';
    is 'à 丛 개 𝐝'.subst(/\w/, 'ч', :nth(2)), 'à ч 개 𝐝', '.ò갮丛ò中 à丧𝐝 :丧中両(2)';
    is 'à 丛 개 𝐝'.subst(/\w/, 'ч', :nth(3)), 'à 丛 ч 𝐝', '.ò갮丛ò中 à丧𝐝 :丧中両(3)';
    is 'à 丛 개 𝐝'.subst(/\w/, 'ч', :nth(4)), 'à 丛 개 ч', '.ò갮丛ò中 à丧𝐝 :丧中両(4)';
    is 'à 丛 개 𝐝'.subst(/\w/, 'ч', :nth(5)), 'à 丛 개 𝐝', '.ò갮丛ò中 à丧𝐝 :丧中両(5)';

    # string pattern versions
    # https://github.com/Raku/old-issue-tracker/issues/4475
    throws-like '"à à à à".ò갮丛ò中("à", "ч", :丧中両(0))', Exception, message => rx/nth/;
    is 'à à à à'.subst('à', 'ч', :nth(1)), 'ч à à à', '.ò갮丛ò中 (ò中с 𝐩à中中e̲с丧) à丧𝐝 :丧中両(1)';
    is 'à à à à'.subst('à', 'ч', :nth(2)), 'à ч à à', '.ò갮丛ò中 (ò中с 𝐩à中中e̲с丧) à丧𝐝 :丧中両(2)';
    is 'à à à à'.subst('à', 'ч', :nth(3)), 'à à ч à', '.ò갮丛ò中 (ò中с 𝐩à中中e̲с丧) à丧𝐝 :丧中両(3)';
    is 'à à à à'.subst('à', 'ч', :nth(4)), 'à à à ч', '.ò갮丛ò中 (ò中с 𝐩à中中e̲с丧) à丧𝐝 :丧中両(4)';
    is 'à à à à'.subst('à', 'ч', :nth(5)), 'à à à à', '.ò갮丛ò中 (ò中с 𝐩à中中e̲с丧) à丧𝐝 :丧中両(5)';
}

# combining :nth with :x
{
    is 'à 丛 개 𝐝 e̲ е æ 両'.subst(/\w/, 'ч', :nth(1,2,3,4), :x(3)),
       'ч ч ч 𝐝 e̲ е æ 両',
       '.ò갮丛ò中 w̲갢中両 :丧中両(1,2,3,4)) à丧𝐝 :ч(3)';

    is 'à 丛 개 𝐝 e̲ е æ 両'.subst(/\w/, 'ч', :nth(2,4,6,8), :x(2)),
       'à ч 개 ч e̲ е æ 両',
       '.ò갮丛ò中 w̲갢中両 :丧中両(2,4,6,8) à丧𝐝 :ч(2)';

    throws-like '"à 丛 개 𝐝 e̲ е æ 両".ò갮丛ò中(/\w/, "ч", :丧中両(2, 4, 1, 6), :ч(3))',
       Exception,
       '.ò갮丛ò中 w̲갢中両 :丧中両(2) à丧𝐝 :ч(3)';
}

{
    # :p
    is 'à 丛 개 𝐝 e̲ е æ 両'.subst(/\w/, 'ч', :p(0)),
       'ч 丛 개 𝐝 e̲ е æ 両',
       '.ò갮丛ò中 w̲갢中両 :𝐩(0)';

    is 'à 丛 개 𝐝 e̲ е æ 両'.subst(/\w/, 'ч', :p(1)),
       'à 丛 개 𝐝 e̲ е æ 両',
       '.ò갮丛ò中 w̲갢中両 :𝐩(1)';

    is 'à 丛 개 𝐝 e̲ е æ 両'.subst(/\w/, 'ч', :p(2)),
       'à ч 개 𝐝 e̲ е æ 両',
       '.ò갮丛ò中 w̲갢中両 :𝐩(2)';

    # :p and :g
    is 'à 丛 개 𝐝 e̲ е æ 両'.subst(/\w/, 'ч', :p(0), :g),
       'ч ч ч ч ч ч ч ч',
       '.ò갮丛ò中 w̲갢中両 :𝐩(0) à丧𝐝 :æ';

    is 'à 丛 개 𝐝 e̲ е æ 両'.subst(/\w/, 'ч', :p(1), :g),
       'à 丛 개 𝐝 e̲ е æ 両',
       '.ò갮丛ò中 w̲갢中両 :𝐩(1) à丧𝐝 :æ';

    is 'à 丛 개 𝐝 e̲ е æ 両'.subst(/\w/, 'ч', :p(2), :g),
       'à ч ч ч ч ч ч ч',
       '.ò갮丛ò中 w̲갢中両 :𝐩(2) à丧𝐝 :æ';
}

{
    # :c
    is 'à 丛 개 𝐝 e̲ е æ 両'.subst(/\w/, 'ч', :c(0)),
       'ч 丛 개 𝐝 e̲ е æ 両',
       '.ò갮丛ò中 w̲갢中両 :개(0)';

    is 'à 丛 개 𝐝 e̲ е æ 両'.subst(/\w/, 'ч', :c(1)),
       'à ч 개 𝐝 e̲ е æ 両',
       '.ò갮丛ò中 w̲갢中両 :개(1)';

    is 'à 丛 개 𝐝 e̲ е æ 両'.subst(/\w/, 'ч', :c(2)),
       'à ч 개 𝐝 e̲ е æ 両',
       '.ò갮丛ò中 w̲갢中両 :개(2)';

    # :c and :g
    is 'à 丛 개 𝐝 e̲ е æ 両'.subst(/\w/, 'ч', :c(0), :g),
       'ч ч ч ч ч ч ч ч',
       '.ò갮丛ò中 w̲갢中両 :개(0) à丧𝐝 :æ';

    is 'à 丛 개 𝐝 e̲ е æ 両'.subst(/\w/, 'ч', :c(1), :g),
       'à ч ч ч ч ч ч ч',
       '.ò갮丛ò中 w̲갢中両 :개(1) à丧𝐝 :æ';

    is 'à 丛 개 𝐝 e̲ е æ 両'.subst(/\w/, 'ч', :c(2), :g),
       'à ч ч ч ч ч ч ч',
       '.ò갮丛ò中 w̲갢中両 :개(2) à丧𝐝 :æ';

    # :c and :nth(3, 4)
    is 'à 丛 개 𝐝 e̲ е æ 両'.subst(/\w/, 'ч', :c(0), :nth(3, 4)),
       'à 丛 ч ч e̲ е æ 両',
       '.ò갮丛ò中 w̲갢中両 :개(0) à丧𝐝 :丧中両(3, 4)';

    is 'à 丛 개 𝐝 e̲ е æ 両'.subst(/\w/, 'ч', :c(1), :nth(3, 4)),
       'à 丛 개 ч ч е æ 両',
       '.ò갮丛ò中 w̲갢中両 :개(1) à丧𝐝 :丧中両(3, 4)';

    is 'à 丛 개 𝐝 e̲ е æ 両'.subst(/\w/, 'ч', :c(2), :nth(3, 4)),
       'à 丛 개 ч ч е æ 両',
       '.ò갮丛ò中 w̲갢中両 :개(2) à丧𝐝 :丧中両(3, 4)';
}

{
    my $s = "丙丁갂";
    my @a = ("À", '丙丁갂');

    $_ = q{不갨w̲ 갈 k̲丧갨w̲ ìù à丛개'ò};

    is +s:g/Now/Wow/, 1, '갂갨丧ò中à丧中 ò갮丛ò中갢中갮中갢갨丧 ò갮개개e̲e̲𝐝ò à丧𝐝 сe̲中갮с丧ò 개갨ссe̲개中 개갨갮丧中';
    is($_, q{W̲갨w̲ 갈 k̲丧갨w̲ ìù à丛개'ò}, '갂갨丧ò中à丧中 ò갮丛ò中갢中갮中갢갨丧 𝐩с갨𝐝갮개e̲ò 개갨ссe̲개中 сe̲ò갮л中');

    isa-ok s:global:i/ABC/$s/.WHAT, List, 'Æл갨丛àл ò개àлàс ò갮丛ò中갢中갮中갢갨丧 ò갮개개e̲e̲𝐝ò à丧𝐝 сe̲中갮с丧ò à Л갢ò中';
    is($_, q{W̲갨w̲ 갈 k̲丧갨w̲ ìù 丙丁갂'ò}, 'Ò개àлàс ò갮丛ò中갢中갮中갢갨丧 𝐩с갨𝐝갮개e̲ò 개갨ссe̲개中 сe̲ò갮л中');

    isa-ok s/BC/@a[]/.WHAT, Match, 'Ò갢丧æлe̲ л갢ò中 сe̲𝐩лà개e̲ìe̲丧中 ò갮개개e̲e̲𝐝ò à丧𝐝 сe̲中갮с丧ò à Ìà中개両';
    is($_, q{W̲갨w̲ 갈 k̲丧갨w̲ ìù 丙À 丙丁갂'ò}, 'Л갢ò中 сe̲𝐩лà개e̲ìe̲丧中 𝐩с갨𝐝갮개e̲ò 개갨ссe̲개中 сe̲ò갮л中');

    dies-ok { 'à丛개' ~~ s/b/g/ },
            "개à丧'中 ì갨𝐝갢еù ò中с갢丧æ л갢中e̲сàл (갨丧лù 𝐯àс갢à丛лe̲ò)";
}

# L<S05/Modifiers/The :s modifier is considered sufficiently important>
# https://github.com/Raku/old-issue-tracker/issues/4764
# also RT #126679
{
    dies-ok {"à 丛 개" ~~ ss/a b c/x y z/}, '갂à丧丧갨中 òò/// ò中с갢丧æ л갢中e̲сàл';

    $_ = "à\n丛\t개 𝐝";
    ok s:ss/a b c d/w x y z/, 'ò갮개개e̲òòе갮л ò:òò ò갮丛ò中갢中갮中갢갨丧 сe̲中갮с丧ò 中с갮中両ù';
    is $_, "w̲\nч\tù 丳", 'ò:òò/.../.../ 𝐩сe̲òe̲с𝐯e̲ò w̲両갢中e̲ò𝐩à개e̲';

    $_ = "à\n丛\t개 𝐝";
    # note, the ss here implies :samespace, not just :sigspace
    ok ss/a b c d/w x y z/, 'ò갮개개e̲òòе갮л òò ò갮丛ò中갢中갮中갢갨丧 сe̲中갮с丧ò 中с갮中両ù';
    # https://github.com/Raku/old-issue-tracker/issues/3275
    is $_, "w̲\nч\tù 丳", 'òò/.../.../ 𝐩сe̲òe̲с𝐯e̲ò w̲両갢中e̲ò𝐩à개e̲';

    $_ = "à\n丛\t개 𝐝";
    ok s:s/a b c d/w x y z/, 'ò갮개개e̲òòе갮л ò:ò ò갮丛ò中갢中갮中갢갨丧 сe̲中갮с丧ò 中с갮中両ù';
    is $_, "w̲ ч ù 丳", 'ò:ò/.../.../ 𝐝갨e̲ò 丧갨中 𝐩сe̲òe̲с𝐯e̲ w̲両갢中e̲ò𝐩à개e̲';


    $_ = "À\n丛\t개 𝐃";
    ok s:ss:ii/a B c D/w x y z/, 'ò갮개개e̲òòе갮л ò:òò:갢갢 ò갮丛ò中갢中갮中갢갨丧 сe̲中갮с丧ò 中с갮中両ù';
    is $_, "W̲\nч\tù 丙", 'ò:òò:갢갢/.../.../ 𝐩сe̲òe̲с𝐯e̲ò w̲両갢中e̲ò𝐩à개e̲ à丧𝐝 개àòe̲';

    $_ = "À\n丛\t갂 𝐝";
    ok ss:i/A B c d/w x y z/, 'ò갮개개e̲òòе갮л òò:갢 ò갮丛ò中갢中갮中갢갨丧 сe̲中갮с丧ò 中с갮中両ù';
    # https://github.com/Raku/old-issue-tracker/issues/3275
    is $_, "w̲\nч\tù 丳", 'òò:갢/.../.../ 𝐩сe̲òe̲с𝐯e̲ò w̲両갢中e̲ò𝐩à개e̲';

    $_ = "À\n丛\t갂 𝐃";
    ok s:s:ii/A B c D/w x y z/, 'ò갮개개e̲òòе갮л ò:ò:갢갢 ò갮丛ò中갢中갮中갢갨丧 сe̲中갮с丧ò 中с갮中両ù';
    is $_, "W̲ ч Ù 丙", 'ò:ò:갢갢/.../.../ 𝐝갨e̲ò 丧갨中 𝐩сe̲òe̲с𝐯e̲ w̲両갢中e̲ò𝐩à개e̲ 丛갮中 𝐩сe̲òe̲с𝐯e̲ò 개àòe̲';


    $_ = "Ä\n丛\tć 𝐃";
    # https://github.com/Raku/old-issue-tracker/issues/4454
    ok s:ss:ii:mm/a ḇ?   c D/w x y z/, 'ò갮개개e̲òòе갮л ò:òò:갢갢:ìì ò갮丛ò中갢中갮中갢갨丧 сe̲中갮с丧ò 中с갮中両ù';
    is $_, "Ẅ\nч\tý 丙", 'ò:òò:갢갢:ìì/.../.../ 𝐩сe̲òe̲с𝐯e̲ò w̲両갢中e̲ò𝐩à개e̲, 개àòe̲, à丧𝐝 ìàсk̲ò';

    $_ = "à\n丛\t갂 𝐝";
    # https://github.com/Raku/old-issue-tracker/issues/4454
    ok ss:i:m/Å ḇ ć d/w x y z/, 'ò갮개개e̲òòе갮л òò ò갮丛ò中갢中갮中갢갨丧 сe̲中갮с丧ò 中с갮中両ù';
    # https://github.com/Raku/old-issue-tracker/issues/3275
    is $_, "w̲\nч\tù 丳", 'òò/.../.../ 𝐩сe̲òe̲с𝐯e̲ò w̲両갢中e̲ò𝐩à개e̲';

    $_ = "à\nḇ\tĆ 𝐝";
    ok ss:i:mm/Å b C d/w x y z/, 'ò갮개개e̲òòе갮л òò:갢:ìì ò갮丛ò中갢中갮中갢갨丧 сe̲中갮с丧ò 中с갮中両ù';
    is $_, "w̲\nx̱\tý 丳", 'òò:갢:ìì/.../.../ 𝐩сe̲òe̲с𝐯e̲ò w̲両갢中e̲ò𝐩à개e̲ à丧𝐝 ìàсk̲ò';

    $_ = "Å\nḇ\tć 𝐝";
    # https://github.com/Raku/old-issue-tracker/issues/4454
    ok s:s:ii:mm/a  B+  c   D/w x y z/, 'ò갮개개e̲òòе갮л ò:ò ò갮丛ò中갢中갮中갢갨丧 сe̲中갮с丧ò 中с갮中両ù';
    is $_, "W̊ x̱ ý 丳", 'ò:ò/.../.../ 𝐝갨e̲ò 丧갨中 𝐩сe̲òe̲с𝐯e̲ w̲両갢中e̲ò𝐩à개e̲ 丛갮中 𝐩сe̲òe̲с𝐯e̲ò 개àòe̲ à丧𝐝 ìàсk̲ò';

}

#L<S05/Substitution/As with Perl, a bracketing form is also supported>
{
    my $a = 'à丛개';
    ok $a ~~ s[b] = 'de', 's[...] = ... returns true on success';
    is $a, 'adec', 'substitution worked';

    $a = 'abc';
    nok $a ~~ s[d] = 'de', 's[...] = ... returns false on failure';
    is $a, 'abc', 'failed substitutions leaves string unchanged';
}

{
    throws-like '$_ = "a"; s:unkonwn/a/b/', X::Syntax::Regex::Adverb,
        's/// dies on unknown adverb';
    throws-like '$_ = "a"; s:overlap/a/b/', X::Syntax::Regex::Adverb,
        ':overlap does not make sense on s///';
}

# note that when a literal is passed to 'given', $_ is bound read-only
{
    given my $x = 'abc' {
        ok (s[b] = 'de'), 's[...] = ... returns true on success';
        is $_, 'adec', 'substitution worked';
    }

    given my $y = 'abc' {
        s[d] = 'foo';
        is $_, 'abc', 'failed substitutions leaves string unchanged';
    }
}

{
    my $x = 'foobar';
    is +($x ~~ s:g[o] = 'u'), 2, 's:global[..] = returns correct count';
    is $x, 'fuubar', 'and the substition worked';
}

{
    $_ = 'a b c';
    s[\w] = uc($/);
    is $_, 'A b c', 'can use $/ on the RHS';

    $_ = 'a b c';
    s[(\w)] = uc($0);
    is $_, 'A b c', 'can use $0 on the RHS';

    $_ = 'a b c';
    is +(s:g[ (\w) ] = $0 x 2), 3, 's:g[] returns proper count of matches';
    is $_, 'aa bb cc', 's:g[...] and captures work together well';
}

{
    my $x = 'ABCD';
    $x ~~ s:x(2)/<.alpha>/x/;
    is $x, 'xxCD', 's:x(2)';
}

# s///
{
    my $x = 'ooooo';
    ok $x ~~ s:1st/./X/,    's:1st return value';
    is $x,  'Xoooo',        's:1st side effect';

    $x    = 'ooooo';
    ok $x ~~ s:2nd/./X/,    's:2nd return value';
    is $x,  'oXooo',        's:2nd side effect';

    $x    = 'ooooo';
    ok $x ~~ s:3rd/./X/,    's:3rd return value';
    is $x,  'ooXoo',        's:3rd side effect';

    $x    = 'ooooo';
    ok $x ~~ s:4th/./X/,    's:4th return value';
    is $x,  'oooXo',        's:4th side effect';

    $x    = 'ooooo';
    ok $x ~~ s:nth(5)/./X/, 's:nth(5) return value';
    is $x,  'ooooX',        's:nth(5) side effect';

    $x    = 'ooooo';
    nok $x ~~ s:nth(6)/./X/, 's:nth(6) return value';
    is $x,  'ooooo',        's:nth(6) no side effect';
}

# s///
{
    my $x = 'ooooo';
    $x ~~ s:x(2):nth(1,3)/o/A/;
    is $x,  'AoAoo', 's:x(2):nth(1,3) works in combination';

    $x = 'ooooo';
    $x ~~ s:2x:nth(1,3)/o/A/;
    is $x,  'AoAoo', 's:2x:nth(1,3) works in combination';
}

# https://github.com/Raku/old-issue-tracker/issues/2351
# s// with other separators
{
    my $x = 'abcde';
    $x ~~ s!bc!zz!;
    is $x, 'azzde', '! separator';
}

#L<S05/Substitution/Any scalar assignment operator may be used>
{
    given 'a 2 3' -> $_ is copy {
        ok (s[\d] += 5), 's[...] += 5 returns True';
        is $_, 'a 7 3', 's[...] += 5 gave right result';
    }
    given 'a b c' -> $_ is copy {
        s:g[\w] x= 2;
        is $_, 'aa bb cc', 's:g[..] x= 2 worked';
    }
}

{
    multi sub infix:<fromplus>(Match $a, Int $b) {
        $a.from + $b
    }

    given 'a b c' -> $_ is copy {
        ok (s:g[\w] fromplus= 3), 's:g[...] customop= returned True';
        is $_, '3 5 7', '... and got right result';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/1274
{
    sub s { 'sub s' }
    $_ = "foo";
    ok s:s,foo,bar, , 's with colon is always substitution';
    is s(), 'sub s', 'can call sub s as "s()"';
    is s, 'sub s', 'can call sub s as "s"';
    $_ = "foo";
    ok ss (foo) = 'bar', 'bare ss is substitution before whitespace then parens';
}

# Test for :samecase
{
    is 'The foo and the bar'.subst('the', 'that', :samecase), 'The foo and that bar', '.substr and :samecase (1)';
    is 'The foo and the bar'.subst('the', 'That', :samecase), 'The foo and that bar', '.substr and :samecase (2)';
    is 'The foo and the bar'.subst(/:i the/, 'that', :samecase), 'That foo and the bar', '.substr (string pattern) and :    samecase (1)';
    is 'The foo and the bar'.subst(/:i The/, 'That', :samecase), 'That foo and the bar', '.substr (string pattern) and :    samecase (2)';
    is 'The foo and the bar'.subst(/:i the/, 'that', :g, :samecase), 'That foo and that bar', '.substr (string pattern)     and :g and :samecase (1)';
    is 'The foo and the bar'.subst(/:i The/, 'That', :g, :samecase), 'That foo and that bar', '.substr (string pattern)     and :g and :samecase (2)';

    my $str = "that";
    is 'The foo and the bar'.subst(/:i the/, {++$str}, :samecase), 'Thau foo and the bar', '.substr and samecase, worked with block replacement';
    is 'The foo and the bar'.subst(/:i the/, {$str++}, :g, :samecase), 'Thau foo and thav bar', '.substr and :g and :samecase, worked with block replacement';
}

{
    $_ = 'foObar';
    s:ii/oo/au/;
    is $_, 'faUbar', ':ii implies :i';

    $_ = 'foObar';
    s:samecase/oo/au/;
    is $_, 'faUbar', ':samecase implies :i';

}

# https://github.com/Raku/old-issue-tracker/issues/1080
{
    my $str = "a\nbc\nd";
    is $str.subst(/^^/, '# ', :g), "# a\n# bc\n# d",
        'Zero-width substitution does not make the GC recurse';
}

{
    throws-like q[ $_ = "abc"; my $i = 1; s:i($i)/a/b/ ], X::Value::Dynamic,
        'Value of :i must be known at compile time';
    todo('be smarter about constant detection'); eval-lives-ok q[ $_ = "abc";s:i(1)/a/b/ ],
        ':i(1) is OK';
}

{
    $_ = 'foo';
    s/f(.)/b$0/;
    is $_, 'boo', 'can use $0 in RHS of s///';
}

# https://github.com/Raku/old-issue-tracker/issues/1963
{
    class SubstInsideMethod {
        method ro($_ ) { s/c// }
    }

    dies-ok { SubstInsideMethod.new.ro('ccc') }, '(sanely) dies when trying to s/// a read-only variable';
}

# https://github.com/Raku/old-issue-tracker/issues/2355
{
    $_ = "foo"; s[f] = 'bar';
    is $_, "baroo", 's[f] is parsed as a substitution op';
    throws-like q{$_ = "foo"; s[] = "bar";}, X::Syntax::Regex::NullRegex;
}

# https://github.com/Raku/old-issue-tracker/issues/3204
{
    my $RT119201_s = 'abcdef';
    my $RT119201_m = '';
    $RT119201_s   .= subst(/(\w)/, { $RT119201_m = $/[0] });
    is($RT119201_m, 'a', 'get match variable in replacement of subst-mutator');
}

# https://github.com/Raku/old-issue-tracker/issues/3456
{
    eval-lives-ok '$_ = "a";s/a$/b/;s|b$|c|;s!c$!d!;', '$ anchor directly at the end of the search pattern works';
}

# https://github.com/Raku/old-issue-tracker/issues/3555
{
    my $foo = "bar";
    $foo ~~ s:g [ r ] = 'z' if $foo.defined;
    is $foo, 'baz', 's{}="" plus statement mod if is not parsed as /i';
}

{
    $_ = 42;
    my $match = s/\d+/xxx/;
    isa-ok $match, Match, 's/// returns a Match object on non-strings';
    is $_, 'xxx', 's/// can modify a container that contains a non-string';
}

# https://github.com/Raku/old-issue-tracker/issues/3645
{
    $_ = 0; s{^(\d+)$} = sprintf "%3d -", $_;
    is $_, "  0 -", 's{}="" can modify a container that contains a non-string';
}

# https://github.com/Raku/old-issue-tracker/issues/2848
{
    $_ = "real";
    s[ea] = "rea";
    is $_, "rreal", 's[]="" works when $_ is set';

    $_ = "";
    throws-like { EVAL 's[] = "rea"' },
        X::Syntax::Regex::NullRegex;
}

# https://github.com/Raku/old-issue-tracker/issues/2593
# https://github.com/Raku/old-issue-tracker/issues/2848
{
    $_ = Any;
    s[ea] = "rea";
    todo("RT #114388 -- expected: '', got: (Any)"); is $_, "", 'can use s[]="" when $_ is not set';
}

# https://github.com/Raku/old-issue-tracker/issues/4683
{
    $_ = "foo";
    is S/a/A/, "foo", "non-mutating single substitution works ($/)";
}

{
    $_ = "foo";
    is S/o/O/, "fOo", "non-mutating single substitution works ($/)";

    $_ = "foo";
    is S:g/o/O/, "fOO", "non-mutating global substitution works ($/)";

    $_ = "foo";
    is S[o] = 'O', "fOo", "non-mutating single substitution assignment works ($/)";

    $_ = "foo";
    is S:g[o] = 'O', "fOO", "non-mutating global substitution assignment works ($/)";

    $_ = "foo";
    is S/(o)/{$0.uc}/, "fOo", "non-mutating single substitution works ($0)";

    $_ = "foo";
    is S:g/(o)/{$0.uc}/, "fOO", "non-mutating global substitution works ($0)";

    $_ = "foo";
    is S[(o)] = $0.uc, "fOo", "non-mutating single substitution assignment works ($0)";

    $_ = "foo";
    is S:g[(o)] = $0.uc, "fOO", "non-mutating global substitution assignment works ($0)";
}

# https://github.com/Raku/old-issue-tracker/issues/5514
{
    is_run 'await ^30 .map: { start { S/.+/{$/.chars.print}/ given "abc"; } }', {
        :err(''), :out('3' x 30)
    }, 'code in replacement part of s/// has correct scoping';
}

# https://github.com/Raku/old-issue-tracker/issues/5699
{
    throws-like { "".subst: /\w/, "", :x(my class SomeInvalidXParam {}.new) },
        X::Str::Match::x, 'giving .subst invalid args throws';
}

# https://github.com/Raku/old-issue-tracker/issues/5869
is-deeply (S:g/FAIL// with 'foo'), 'foo',
    'S:g/// returns original string on failure to match';

# https://github.com/Raku/old-issue-tracker/issues/5886
is-deeply (eager <a b c aab ac>.map: {S/a/x/}), <x b c xab xc>,
    'S/// can be used in map (does not reuse a container)';

# https://irclog.perlgeek.de/perl6-dev/2017-03-22#i_14308172
subtest 'List/Match result adverb handling' => {
    # Check that we can handle a bunch of adverb combinations that
    # can result in either a Match or a List of Matches in $/
    plan 3;

    group-of 2 => ':2nd:g' => {
        subtest 'S///' => {
            plan 3;
            is-deeply (S:2nd:g/./Z/ with 'abc'), 'aZc', 'return value';
            isa-ok    $/,                        Match, '$/ is Match';
            is-deeply $/.Str,                    'b',   '$/.Str';
        }
        subtest 's///' => {
            plan 4;
            my $v = 'abc';
            my $r = $v ~~ s:2nd:g/./Z/;
            is-deeply $v,        'aZc', 'result';
            cmp-ok    $r, '===', $/,    'return value';
            isa-ok    $/,        Match, '$/ is Match';
            is-deeply $/.Str,    'b',   '$/.Str';
        }
    }

    group-of 2 => ':x(1..3)' => {
        subtest 'S///' => {
            plan 3;
            is-deeply (S:x(1..3)/./Z/ with 'abcd'), 'ZZZd', 'return value';
            isa-ok    $/,                           List,    '$/ is List';
            is-deeply $/».Str,                      <a b c>, '$/».Str';
        }
        subtest 's///' => {
            plan 4;
            my $v = 'abcd';
            my $r = $v ~~ s:x(1..3):g/./Z/;
            is-deeply $v,        'ZZZd',  'result';
            cmp-ok    $r, '===', $/,      'return value';
            isa-ok    $/,        List,    '$/ is List';
            is-deeply $/».Str,   <a b c>, '$/».Str';
        }
    }

    group-of 2 => ':th(1, 3)' => {
        subtest 'S///' => {
            plan 3;
            is-deeply (S:th(1, 3)/./Z/ with 'abcd'), 'ZbZd', 'return value';
            isa-ok    $/,                           List,    '$/ is List';
            is-deeply $/».Str,                      <a c>,   '$/».Str';
        }
        subtest 's///' => {
            plan 4;
            my $v = 'abcd';
            my $r = $v ~~ s:th(1, 3):g/./Z/;
            is-deeply $v,        'ZbZd', 'result';
            cmp-ok    $r, '===', $/,     'return value';
            isa-ok    $/,        List,   '$/ is List';
            is-deeply $/».Str,   <a c>,  '$/».Str';
        }
    }
}

subtest '.subst(Str:D, Str:D)' => {
    plan 6;
    is-deeply 'abc'.subst('a',  'zo'),  'zobc',   'replace with longer';
    is-deeply 'abc'.subst('ab',  'z'),  'zc',     'replace with shorter';
    is-deeply 'abc'.subst('ab',  'xy'), 'xyc',    'replace with samelength';

    is-deeply 'a♥bc'.subst('♥',  'zo'), 'azobc',  'replace with longer (2)';
    is-deeply 'a♥bc'.subst('♥b',  'z'), 'azc',    'replace with shorter (2)';
    is-deeply 'a♥bc'.subst('a♥', '♦z'), '♦zbc',   'replace with samelength (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/6043
subtest '.subst with multi-match args set $/ to a List of matches' => {
    plan 2*(2+5);
    for 1234567, '1234567' -> $type {
        group-of 4 => "$type.^name().subst: :g" => {
          ($ = $type).subst(:g, /../, 'XX');
          isa-ok $/, List, '$/ is a List…';
          cmp-ok +$/, '==', 3, '…with 3 items…';
          is-deeply $/.map({.WHAT}).unique, (Match,).Seq, '…all are Match…';
          is-deeply $/.map(~*), <12 34 56>.map(*.Str), '…all have right values';
        }
        group-of 4 => ".subst: :x" => {
          ($ = $type).subst(:2x, /../, 'XX');
          isa-ok $/, List, '$/ is a List…';
          cmp-ok +$/, '==', 2, '…with 2 items…';
          is-deeply $/.map({.WHAT}).unique, (Match,).Seq, '…all are Match…';
          is-deeply $/.map(~*), <12 34>.map(*.Str), '…all have right values';
        }
        for <nth st nd rd th> -> $suffix {
          group-of 4 => ".subst: :$suffix" => {
              ($ = $type).subst(|($suffix => 1..3), /../, 'XX');
              isa-ok $/, List, '$/ is a List…';
              cmp-ok +$/, '==', 3, '…with 3 items…';
              is-deeply $/.map({.WHAT}).unique, (Match,).Seq, '…all are Match…';
              is-deeply $/.map(~*), <12 34 56>.map(*.Str),
                  '…all have right values';
          }
        }
    }
}

# https://github.com/rakudo/rakudo/issues/3358
{
    $_ = "12345";
    is-deeply ([3,4].map:{S{5}=$^a}), ('12343', '12344'),
        'Placeholder parameter in substitution assignment';

    $_ = "12345";
    is-deeply ([3,4].map:{S/5/$^a/}), ('12343', '12344'),
        'Placeholder parameter in substitution quoted';

    $_ = "12345";
    is-deeply ([3,4].map:{S{$^a}='X'}), ('12X45', '123X5'),
        'Placeholder parameter in substitution regex ({} quoter)';

    $_ = "12345";
    is-deeply ([3,4].map:{S/$^a/X/}), ('12X45', '123X5'),
        'Placeholder parameter in substitution regex (// quoter)';
}
 
# https://github.com/Raku/old-issue-tracker/issues/3515
lives-ok { BEGIN "a".subst: /a/, "b" }, '.subst in BEGIN does not die';

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
