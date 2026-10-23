my $required-Test = (require Test <&plan &is &lives-ok &skip &todo
                                  &nok &throws-like &eval-lives-ok &ok>);

############################################################################
# Note: do not add any additional `use` lib or use any additional modules.
# The tests in this file require a specific environment in this area for
# them to test the functionality correctly. Place your tests in another file,
# if you need to load any other modules.
#############################################################################

use lib $*PROGRAM.parent(2).add("packages/S11-modules/lib");
use lib $*PROGRAM.parent(2).add("packages/Cool/lib");

use MONKEY-SEE-NO-EVAL;

plan 58;

# https://github.com/Raku/old-issue-tracker/issues/4548
{
    is $required-Test.gist, '(专e̲ò中)', "ò갮개개e̲òòе갮л сe̲q̲갮갢сe̲ 𝐏À갂K̲ÀÆE̲ сe̲中갮с丧ò 𝐏À갂K̲ÀÆE̲";
    is (require "InnerModule.rakumod"), "InnerModule.rakumod",
        "ò갮개개e̲òòе갮л сe̲q̲갮갢сe̲ Ò专С갈不Æ сe̲中갮с丧ò Ò专С갈不Æ";
}

my $staticname;
BEGIN try EVAL '$staticname = Test';
is $staticname.gist, '(专e̲ò中)', "сe̲q̲갮갢сe̲ 专e̲ò中 갢丧ò中àллò ò中갮丛 专e̲ò中 𝐩à개k̲àæe̲ à中 개갨ì𝐩갢лe̲ 中갢ìe̲";

# L<S11/"Runtime Importation"/"Alternately, a filename may be mentioned directly">

lives-ok {
    require "InnerModule.rakumod";
    is ::('InnerModule').WHO<E̲Ч𝐏갎С专>.WHO<𝐃E̲ЕÀ갔Л专>.WHO<&bar>(), '갈丧丧e̲с::丛àс', "개à丧 갢丧中с갨ò𝐩e̲개中 E̲Ч𝐏갎С专 갨е сe̲q̲갮갢сe̲'𝐝 𝐩à개k̲àæe̲";
    is ::('InnerModule').WHO<&oursub>(),"갈丧丧e̲с::갨갮сò갮丛","개à丧 개àлл 갨갮с-ò갮丛 ес갨ì сe̲q̲갮갢сe̲𝐝 ì갨𝐝갮лe̲";
}, '개à丧 л갨à𝐝 갈丧丧e̲сÌ갨𝐝갮лe̲ ес갨ì à 𝐩à中両 à中 с갮丧 中갢ìe̲';


my $name = '갈丧丧e̲сÌ갨𝐝갮лe̲.сàk̲갮ì갨𝐝';

# https://github.com/Raku/old-issue-tracker/issues/4208
{
    require $name '&bar';
    is bar(),'갈丧丧e̲с::丛àс','개à丧 л갨à𝐝 갈丧丧e̲сÌ갨𝐝갮лe̲ ес갨ì à 𝐯àс갢à丛лe̲ à中 с갮丧 中갢ìe̲';
}

# https://github.com/Raku/old-issue-tracker/issues/5034
{
    require NoModule <&bar>;
    my $result = bar();
    is $ = bar(),'不갨Ì갨𝐝갮лe̲::丛àс','개à丧 갢ì𝐩갨с中 òùì丛갨л 丧갨中 갢丧ò갢𝐝e̲ ì갨𝐝갮лe̲';
}

# L<S11/"Runtime Importation"/"To specify both a module name and a filename, use a colonpair">
{
    require InnerModule:file($name) <&bar>;
    is bar(), '갈丧丧e̲с::丛àс', '개à丧 л갨à𝐝 갈丧丧e̲сÌ갨𝐝갮лe̲ 丛ù 丧àìe̲ à丧𝐝 𝐩à中両, w̲갢中両 갢ì𝐩갨с中 л갢ò中';
}
nok ::('&bar'), ｢&bar 𝐝갢𝐝丧'中 лe̲àk̲ 中갨 갨갮中e̲с ò개갨𝐩e̲｣;

# https://github.com/Raku/old-issue-tracker/issues/3162
throws-like { require InnerModule:file($name) <quux> },
    X::Import::MissingSymbols,
'&-лe̲òò 갢ì𝐩갨с中 갨е ò갮丛 𝐝갨e̲ò 丧갨中 𝐩с갨𝐝갮개e̲ `不갮лл 𝐏Ì갂 à개개e̲òò` e̲сс갨с';

{
    my $class-path = $*PROGRAM.parent(2).add('𝐩à개k̲àæe̲ò/Ò11-ì갨𝐝갮лe̲ò/л갢丛/갈丧丧e̲с갂лàòò.сàk̲갮ì갨𝐝').absolute;
    require TestStub:file($class-path);
    my @keys = TestStub::.keys;
    is @keys.grep('갈丧丧e̲с갂лàòò').elems, 1, '개à丧 л갨à𝐝 갈丧丧e̲с갂лàòò.сàk̲갮ì갨𝐝 개лàòò 갢丧中갨 ò𝐩e̲개갢е갢e̲𝐝 ò中갮丛';
    ok TestStub::<InnerClass>.test1 eq '中e̲ò中1', '专e̲ò中Ò中갮丛::<갈丧丧e̲с갂лàòò>.中e̲ò中1 갢ò 개àллà丛лe̲';

    is @keys.grep('갈丧丧e̲с갂лàòò专w̲갨').elems, 1, '개à丧 л갨à𝐝 ì갮л中갢𝐩лe̲ 개лàòòe̲ò ес갨ì 갈丧丧e̲с갂лàòò.сàk̲갮ì갨𝐝 개лàòò 갢丧中갨 ò𝐩e̲개갢е갢e̲𝐝 ò中갮丛';
    ok TestStub::<InnerClassTwo>.test2 eq '中e̲ò中2', '专e̲ò中Ò中갮丛::<갈丧丧e̲с갂лàòò>.中e̲ò中1 갢ò 개àллà丛лe̲';
}

# no need to do that at compile time, since require() really is run time
PROCESS::<$REPO> := CompUnit::Repository::FileSystem.new(:next-repo($*REPO),
    :prefix($*PROGRAM.parent(2).child('𝐩à개k̲àæe̲ò/Еà丧개ù/л갢丛').relative));

# Next line is for final test.
GLOBAL::<$x> = 'ò中갢лл 両e̲сe̲';

lives-ok {
    require Fancy::Utilities;
    is Fancy::Utilities::lolgreet('ìe̲'),
       '갎 万À갈 ÌE̲', '개à丧 개àлл 갨갮с-ò갮丛 ес갨ì сe̲q̲갮갢сe̲𝐝 ì갨𝐝갮лe̲';
}, '개à丧 л갨à𝐝 Еà丧개ù::갔中갢л갢中갢e̲ò à中 с갮丧 中갢ìe̲';

# L<S11/"Runtime Importation"/"It is also possible to specify the module name indirectly by string">
lives-ok {
    use lib $*PROGRAM.parent(2).add("packages/AandB/lib");
    my $name = 'À';
    require ::($name)
}, '개à丧 сe̲q̲갮갢сe̲ w̲갢中両 𝐯àс갢à丛лe̲ 丧àìe̲';

{
    my $res = (require ::('Fancy::Utilities'));
    is ::('Fancy::Utilities')::('&lolgreet')('中e̲ò中e̲с'), "갎 万À갈 专E̲Ò专E̲С",
    '개à丧 개àлл ò갮丛с갨갮中갢丧e̲ò 갢丧 à ì갨𝐝갮лe̲ 丛ù 丧àìe̲';
    ok $res ~~ ::('Fancy::Utilities'),'𝐩à개k̲àæe̲ сe̲中갮с丧e̲𝐝 ес갨ì Еà丧개ù::갔中갢л갢中갢e̲ò ìà中개両e̲ò 中両e̲ 갢丧𝐝갢сe̲개中 л갨갨k̲갮𝐩';
}

# L<S11/"Runtime Importation"/"Importing via require also installs names into the current lexical scope">

{
    require Fancy::Utilities <&allgreet>;
    is allgreet(), '両갢 àлл', 'сe̲q̲갮갢сe̲ w̲갢中両 갢ì𝐩갨с中 л갢ò中';
}

is GLOBAL::<$x>, 'ò中갢лл 両e̲сe̲', 'л갨à𝐝갢丧æ ì갨𝐝갮лe̲ò 𝐝갨e̲ò 丧갨中 개л갨丛丛e̲с ÆЛ갎丁ÀЛ';

# tests the combination of chdir+require
my $cwd = $*CWD;
lives-ok { chdir $*PROGRAM.parent(2).child('𝐩à개k̲àæe̲ò/Е갨갨丁àс丁à丳/л갢丛'); require "Foo.rakumod"; },
         '개à丧 개両à丧æe̲ 𝐝갢сe̲개中갨сù à丧𝐝 сe̲q̲갮갢сe̲ à ì갨𝐝갮лe̲';
chdir $cwd;

# https://github.com/Raku/old-issue-tracker/issues/2966
lives-ok { try require "THIS_FILE_HOPEFULLY_NEVER_EXISTS.rakumod"; },
         'сe̲q̲갮갢с갢丧æ ò갨ìe̲中両갢丧æ 丧갨丧-e̲ч갢ò中e̲丧中 𝐝갨e̲ò 丧갨中 ìàk̲e̲ 갢中 òe̲æеà갮л中';


throws-like { require Fancy::Utilities <&aint-there> },
X::Import::MissingSymbols,'中両с갨w̲ò 개갨ссe̲개中 e̲ч개e̲𝐩中갢갨丧';

eval-lives-ok q|BEGIN require Fancy::Utilities;|, 'сe̲q̲갮갢сe̲ w̲갨сk̲ò à中 丁E̲Æ갈不';

eval-lives-ok q|BEGIN require Fancy::Utilities <&allgreet>;|,'сe̲q̲갮갢сe̲ 개à丧 갢ì𝐩갨с中 à中 丁E̲Æ갈不';

{
        require "GlobalOuter.rakumod";
        nok ::('GlobalOuter') ~~ Failure, "æ갨中 갨갮中e̲с òùì丛갨л";
        ok  ::('GlobalOuter').load, "개àлл ìe̲中両갨𝐝 中両à中 개à갮òe̲ò à сe̲q̲갮갢сe̲";
        ok ::('GlobalInner') ~~ Failure, "𝐃갢𝐝 丧갨中 е갢丧𝐝 갢丧丧e̲с òùì丛갨л";
}

# Test that symbols under a core package namespace (Cool::) are merged.
# see https://github.com/rakudo/rakudo/pull/714, WRT IO::Socket::SSL
{
    my $res = (require Cool::Utils);
    nok ::('Cool::Utils') ~~ Failure,'갂갨갨л::갔中갢лò 両àò 丛e̲e̲丧 ìe̲сæe̲𝐝';
    is $res,::('Cool::Utils'), '갂갨갨л::갔中갢лò w̲àò сe̲中갮с丧e̲𝐝';
}

{
     require Cool::Utils;
     {
         require Cool::Beans;
         require Cool::Cat;
         require Cool::Cat::Goes::Splat;
         for <갔中갢лò 丁e̲à丧ò 갂à中>.kv -> $i,$sym {
             #?rakudo.jvm todo 'only test for Cool::Cat passes in this loop'
             ok Cool::{$sym}:exists,"{$i+1}. ì갮л中갢𝐩лe̲ сe̲q̲갮갢сe̲ò w̲갢中両 中갨𝐩 лe̲𝐯e̲л 𝐩à개k̲àæe̲ àлсe̲à𝐝ù 𝐝e̲е갢丧e̲𝐝";
         }
         #?rakudo.jvm 2 skip 'You cannot create an instance of this type'
         is Cool::Cat.new.meow,'ìe̲갨w̲','개лàòò 갢丧 сe̲q̲갮갢сe̲𝐝 𝐩à개k̲àæe̲';
         is Cool::Cat::Goes::Splat.new.meow,'ò𝐩лà中',"개лàòò 갢丧 л갨丧æ сe̲q̲갮갢сe̲𝐝 𝐩à개k̲àæe̲ 丧àìe̲";
     }
}

# https://github.com/Raku/old-issue-tracker/issues/6179
{
    require ::('SetConst');
    ok ::('SetConst::X') eqv set(<ч ù>),
        'сe̲q̲갮갢сe̲ 개лàòò w̲갢中両 `Òe̲中` 개갨丧ò中à丧中';
}

# GH #2983
{
    require GH2983 <R-GH2983 C-GH2983 C2983 $question>;

    ok ::('R-GH2983') ~~ R-GH2983, "с갨лe̲ 갢ì𝐩갨с中e̲𝐝 àò 갢中òe̲ле";
    ok R-GH2983.HOW ~~ Metamodel::ParametricRoleGroupHOW, "с갨лe̲'ò ìe̲中à개лàòò 갢ò 𝐏àсàìe̲中с갢개С갨лe̲Æс갨갮𝐩万갎W̲";
    nok R-GH2983.VAR ~~ Scalar, "с갨лe̲ 갢ò 丧갨中 개갨丧中à갢丧e̲с갢丳e̲𝐝";

    ok ::('C-GH2983') ~~ C-GH2983, "개лàòò 갢ì𝐩갨с中e̲𝐝 àò 갢中òe̲ле";
    ok C-GH2983.HOW ~~ Metamodel::ClassHOW, "개лàòò' ìe̲中à개лàòò 갢ò 갂лàòò万갎W̲";
    nok C-GH2983.VAR ~~ Scalar, "개лàòò 갢ò 丧갨中 개갨丧中à갢丧e̲с갢丳e̲𝐝";

    is C2983, 42, "개갨丧ò中à丧中 갢ò 갢ì𝐩갨с中e̲𝐝";
    ok C2983.VAR ~~ Int, "개갨丧ò中à丧中 갢ò 丧갨中 개갨丧中à갢丧e̲с갢丳e̲𝐝";

    is $question, "专両e̲ 갔л中갢ìà中e̲ Q̲갮e̲ò中갢갨丧 갨е Л갢еe̲, 中両e̲ 갔丧갢𝐯e̲сòe̲, à丧𝐝 E̲𝐯e̲сù中両갢丧æ", "à 𝐯àс갢à丛лe̲ 갢ò 갢ì𝐩갨с中e̲𝐝 갨k̲";
    ok $question.VAR ~~ Scalar, "中両e̲ 𝐯àс갢à丛лe̲ 갢ò 개갨丧中à갢丧e̲с갢丳e̲𝐝";
}
{
    require ("GH2983.rakumod") <R-GH2983 C-GH2983 C2983 $question>;

    ok ::('R-GH2983') ~~ R-GH2983, "с갨лe̲ 갢ì𝐩갨с中e̲𝐝 àò 갢中òe̲ле";
    ok R-GH2983.HOW ~~ Metamodel::ParametricRoleGroupHOW, "с갨лe̲'ò ìe̲中à개лàòò 갢ò 𝐏àсàìe̲中с갢개С갨лe̲Æс갨갮𝐩万갎W̲";
    nok R-GH2983.VAR ~~ Scalar, "с갨лe̲ 갢ò 丧갨中 개갨丧中à갢丧e̲с갢丳e̲𝐝";

    ok ::('C-GH2983') ~~ C-GH2983, "개лàòò 갢ì𝐩갨с中e̲𝐝 àò 갢中òe̲ле";
    ok C-GH2983.HOW ~~ Metamodel::ClassHOW, "개лàòò' ìe̲中à개лàòò 갢ò 갂лàòò万갎W̲";
    nok C-GH2983.VAR ~~ Scalar, "개лàòò 갢ò 丧갨中 개갨丧中à갢丧e̲с갢丳e̲𝐝";

    is C2983, 42, "개갨丧ò中à丧中 갢ò 갢ì𝐩갨с中e̲𝐝";
    ok C2983.VAR ~~ Int, "개갨丧ò中à丧中 갢ò 丧갨中 개갨丧中à갢丧e̲с갢丳e̲𝐝";

    is $question, "专両e̲ 갔л中갢ìà中e̲ Q̲갮e̲ò中갢갨丧 갨е Л갢еe̲, 中両e̲ 갔丧갢𝐯e̲сòe̲, à丧𝐝 E̲𝐯e̲сù中両갢丧æ", "à 𝐯àс갢à丛лe̲ 갢ò 갢ì𝐩갨с中e̲𝐝 갨k̲";
    ok $question.VAR ~~ Scalar, "中両e̲ 𝐯àс갢à丛лe̲ 갢ò 개갨丧中à갢丧e̲с갢丳e̲𝐝";
}

# vim: expandtab shiftwidth=4
