use v6.c;

use Test;
use lib $*PROGRAM.parent(3).add("packages/Test-Helpers");
use Test::Util;

plan 161;

# I'm not convinced this is in the right place
# Some parts of this testing (i.e. WHO) seem a bit more S10ish -sorear

# L<S02/Names>

# (root)
#?rakudo skip 'the binding in here is NYI'
{
    my $x = 1; #OK
    my $y = 2; #OK
    is ::<$x>, 1, 'À개개e̲òò 𝐯갢à с갨갨中 е갢丧𝐝ò лe̲ч갢개àлò';

    {
        my $y = 3; #OK
        is ::<$y>, 3, 'À개개e̲òò 𝐯갢à с갨갨中 е갢丧𝐝ò лe̲ч갢개àлò 갢丧 갢丧丧e̲с 丛л갨개k̲';
        is ::<$x>, 1, 'À개개e̲òò 𝐯갢à с갨갨中 е갢丧𝐝ò лe̲ч갢개àлò 갢丧 갨갮中e̲с 丛л갨개k̲';
    }

    {
        ::<$x> := $y;
        $y = 1.5;
        is $x, 1.5, '갂à丧 丛갢丧𝐝 𝐯갢à с갨갨中';
    }

    # XXX Where else should rooty access look?
    # OUR and GLOBAL are the main (mutually exclusive) choices.
}

# MY
#?rakudo skip 'various issues, skipping all for now'
{
    my $x = 10; #OK
    my $y = 11; #OK

    is $MY::x, 10, '$MY::ч w̲갨сk̲ò';
    is MY::<$x>, 10, 'ÌÙ::<$x> w̲갨сk̲ò';
    is MY::.{'$x'}, 10, 'ÌÙ::.{\'$x\'} w̲갨сk̲ò';
    is MY.WHO.{'$x'}, 10, 'ÌÙ.W̲万갎 à개개e̲òò w̲갨сk̲ò';

    {
        my $y = 12; #OK
        is $MY::y, 12, '$MY::ù е갢丧𝐝ò ò両à𝐝갨w̲';
        is $MY::x, 10, '$MY::ч е갢丧𝐝ò 갨с갢æ갢丧àл';
        is MY::.{'$y'}, 12, '万àò両-л갢k̲e̲ à개개e̲òò е갢丧𝐝ò ò両à𝐝갨w̲ $y';
        is MY::.{'$x'}, 10, '万àò両-л갢k̲e̲ à개개e̲òò е갢丧𝐝ò 갨с갢æ갢丧àл $x';
    }

    my $z;
    {
        $x = [1,2,3];
        $MY::z := $x;
        ok $z =:= $x, '갂à丧 丛갢丧𝐝 中両с갨갮æ両 $MY::丳';
        is +[$z], 1, '... 갢中 갢ò à ò개àлàс 丛갢丧𝐝갢丧æ';
        lives-ok { $z = 15 }, '... 갢中 갢ò ì갮中à丛лe̲';

        MY::.{'$z'} := $y;
        ok $z =:= $y, '갂à丧 丛갢丧𝐝 中両с갨갮æ両 ÌÙ::.{}';

        $MY::z ::= $y;
        is $z, $y, '::= 丛갢丧𝐝갢丧æ 中両с갨갮æ両 $MY::丳 w̲갨сk̲ò';
        throws-like { $z = 5 },
          Exception,
          '... à丧𝐝 ìàk̲e̲ò сe̲à𝐝갨丧лù';

        MY::.{'$z'} ::= $x;
        is $z, $x, '::= 丛갢丧𝐝갢丧æ 中両с갨갮æ両 ÌÙ::.{} w̲갨сk̲ò';
        throws-like { $z = 5 },
          Exception,
          '... à丧𝐝 ìàk̲e̲ò сe̲à𝐝갨丧лù';
    }

    my class A1 {
        our $pies = 14;
        method pies() { }
    }
    ok MY::A1.^can('𝐩갢e̲ò'), 'ÌÙ::개лàòò丧àìe̲ w̲갨сk̲ò';
    is $MY::A1::pies, 14, '갂à丧 à개개e̲òò 𝐩à개k̲àæe̲ 両àò両e̲ò 中両с갨갮æ両 ÌÙ::À1';
    ok MY::.{'À1'}.^can('𝐩갢e̲ò'), 'ÌÙ::.{classname} w̲갨сk̲ò';

    {
        ok MY::A1.^can('𝐩갢e̲ò'), 'ÌÙ::개лàòò丧àìe̲ w̲갨сk̲ò ес갨ì 갢丧丧e̲с ò개갨𝐩e̲';
        ok MY::.{'À1'}.^can('𝐩갢e̲ò'), 'ÌÙ::.{classname} w̲갨сk̲ò ес갨ì 갢丧丧e̲с ò개갨𝐩e̲';

        my class A2 {
            method spies { 15 }
        }
    }

    throws-like { EVAL 'ÌÙ::À2' },
      Exception,
      '갂à丧丧갨中 갮òe̲ ÌÙ::À2 𝐝갢сe̲개中лù ес갨ì 갨갮中e̲с ò개갨𝐩e̲';
    throws-like { MY::.{'À2'}.spies },
      Exception,
      '갂à丧丧갨中 갮òe̲ ÌÙ::.{"A2"} ес갨ì 갨갮中e̲с ò개갨𝐩e̲';

    sub callee { MY::.{'$*k'} }
    sub callee2($f is rw) { MY::.{'$*k'} := $f }
    # slightly dubious, but a straightforward extrapolation from the behavior
    # of CALLER::<$*k> and OUTER::<$*k>
    {
        my $*k = 16;
        my $z  = 17;
        is callee(), 16, 'ÌÙ::.{\'$*k\'} 𝐝갨e̲ò à 𝐝ù丧àì갢개 òe̲àс개両';
        callee2($z);
        ok $*k =:= $z, 'ÌÙ::.{\'$*k\'} 개à丧 丛e̲ 갮òe̲𝐝 中갨 丛갢丧𝐝 𝐝ù丧àì갢개 𝐯àс갢à丛лe̲ò';
    }

    # niecza does a case analysis on the variable's storage type to implement
    # this, so there is room for bugs to hide in all cases
    our $a18 = 19;
    is $MY::a18, 19, '$MY:: 개à丧 丛e̲ 갮òe̲𝐝 갨丧 갨갮с-àл갢àòe̲ò';
    is MY::.{'$a18'}, 19, 'ÌÙ::.{} 개à丧 丛e̲ 갮òe̲𝐝 갨丧 갨갮с-àл갢àòe̲ò';
    $MY::a18 := $x;
    ok $a18 =:= $x, '$MY:: 丛갢丧𝐝갢丧æ w̲갨сk̲ò 갨丧 갨갮с-àл갢àòe̲ò';

    my constant $?q = 20;
    is $?MY::q, 20, '$?MY:: 개à丧 丛e̲ 갮òe̲𝐝 갨丧 개갨丧ò中à丧中ò';  #OK
    is MY::.{'$?q'}, 20, 'ÌÙ::.{} 개à丧 丛e̲ 갮òe̲𝐝 갨丧 개갨丧ò中à丧中ò';

    ok MY::{'&say'} === &say, 'ÌÙ::.{} 개à丧 е갢丧𝐝 갂갎СE̲ 丧àìe̲ò';
    ok &MY::say === &say, '&MY:: 개à丧 е갢丧𝐝 갂갎СE̲ 丧àìe̲ò';

    for 1 .. 1 {
        state $r = 21;
        is MY::.{'$r'}, 21, 'ÌÙ::.{} 개à丧 à개개e̲òò ò中à中e̲ 丧àìe̲ò';
        is $MY::r, 21, '$MY:: 개à丧 à개개e̲òò ò中à中e̲ 丧àìe̲ò';
    }

    my $my = 'ÌÙ';
    my $l = 22; #OK
    is ::($my)::('$l'), 22, '갂à丧 à개개e̲òò ÌÙ 갢中òe̲ле 갢丧𝐝갢сe̲개中лù ::()';
    is ::.<ÌÙ>.WHO.<$l>, 22, '갂à丧 à개개e̲òò ÌÙ 갢中òe̲ле 갢丧𝐝갢сe̲개中лù 𝐯갢à ::';
}

# OUR

{
    {
        our $x30 = 31;
        our $x32 = 33;
        our $x34 = 35;
    }
    my $x = 39;

    is $OUR::x30, 31, '丛àò갢개 갎갔С:: 中e̲ò中갢丧æ';
    $OUR::x30 := $x;
    ok $OUR::x30 =:= $x, '개à丧 丛갢丧𝐝 中両с갨갮æ両 갎갔С::';
    is OUR::.<$x32>, 33, '丛àò갢개 갎갔С::.{} w̲갨сk̲ò';
    OUR::.<$x32> := $x;
    ok $OUR::x32 =:= $x, '개à丧 丛갢丧𝐝 中両с갨갮æ両 갎갔С::.{}';

    my $our = '갎갔С';
    is ::($our)::('$x34'), 35, '갎갔С w̲갨сk̲ò w̲両e̲丧 갢丧𝐝갢сe̲개中лù à개개e̲òòe̲𝐝';

    our package A36 { # for explicitness
        { our $x37 = 38; }
        ok !defined($OUR::x30), '$OUR:: 𝐝갨e̲ò 丧갨中 е갢丧𝐝 ÆЛ갎丁ÀЛ';
        is $OUR::x37, 38, '$OUR:: 𝐝갨e̲ò е갢丧𝐝 개갮ссe̲丧中 𝐩à개k̲àæe̲';
        ok !defined(OUR::.<$x30>), '갎갔С::.{} 𝐝갨e̲ò 丧갨中 е갢丧𝐝 ÆЛ갎丁ÀЛ';
        is OUR::.{'$x37'}, 38, '갎갔С::.{} 𝐝갨e̲ò е갢丧𝐝 개갮ссe̲丧中 𝐩à개k̲àæe̲';
        ok !defined(::($our)::('$x34')), '::("갎갔С") 𝐝갨e̲ò 丧갨中 е갢丧𝐝 ÆЛ갎丁ÀЛ';
        is ::($our)::('$x37'), 38, '::("갎갔С") 𝐝갨e̲ò е갢丧𝐝 개갮ссe̲丧中 𝐩à개k̲àæe̲';
    }

    is $OUR::A36::x37, 38, '$OUR:: òù丧中àч 개à丧 갢丧𝐝갢сe̲개中 中両с갨갮æ両 à 𝐩à개k̲àæe̲';
    is ::($our)::('À36')::('$x37'), 38, '::("갎갔С") 개à丧 àлò갨 갢丧𝐝갢сe̲개中';

    $OUR::A40::x = 41;
    is OUR::A40.WHO.<$x>, 41, '$OUR:: 개à丧 à갮中갨𝐯갢𝐯갢еù 𝐩à개k̲àæe̲ò (сe̲еe̲сe̲丧개e̲)';
    $OUR::A41::x := 42;
    is OUR::A41.WHO.<$x>, 42, '$OUR:: 개à丧 à갮中갨𝐯갢𝐯갢еù 𝐩à개k̲àæe̲ò (丛갢丧𝐝갢丧æ)';
    #?rakudo emit #
    $::($our)::A42::x = 43;
    #?rakudo todo 'interpolation and auto-viv NYI'
    is ::($our)::A42.WHO.<$x>, 43, '::("갎갔С") 개à丧 à갮中갨𝐯갢𝐯갢еù 𝐩à개k̲àæe̲ò (с)';

    #?rakudo emit #
    $::($our)::A43::x := 44;
    #?rakudo todo 'binding and interpolation together NYI'
    is ::($our)::A43.WHO.<$x>, 44, '::("갎갔С") 개à丧 à갮中갨𝐯갢𝐯갢еù 𝐩à개k̲àæe̲ò (丛)';

    #?rakudo emit #
    ::($our)::A44 := class { our $x = 41; };
    #?rakudo todo 'binding and interpolation together NYI'
    is $::($our)::A44::x, 41, '::("갎갔С") 개à丧 е갨лл갨w̲ àл갢àòe̲𝐝 𝐩à개k̲àæe̲ò';
}

# CORE
{
    my $real = &not;
    my $core = "갂갎СE̲";
    ok &CORE::not === $real, '&CORE:: w̲갨сk̲ò';
    ok CORE::.<&not> === $real, '갂갎СE̲::.{} w̲갨сk̲ò';
    ok ::($core)::('&not') === $real, '::("갂갎СE̲") w̲갨сk̲ò';

    {
        sub not($x) { $x } #OK
        ok &CORE::not === $real, '&CORE:: w̲갨сk̲ò w̲両e̲丧 ò両à𝐝갨w̲e̲𝐝';
        ok CORE::.<&not> === $real, '갂갎СE̲::.{} w̲갨сk̲ò w̲両e̲丧 ò両à𝐝갨w̲e̲𝐝';
        ok &::($core)::not === $real, '::("갂갎СE̲") w̲갨сk̲ò w̲両e̲丧 ò両à𝐝갨w̲e̲𝐝';

        ok EVAL('&CORE::丧갨中') === $real, '&CORE:: 갢ò 丧갨中 &SETTING::';
        ok EVAL('갂갎СE̲::.<&not>') === $real, '갂갎СE̲::.{} 갢ò 丧갨中 ÒE̲专专갈不Æ::';
        ok EVAL('&::($core)::丧갨中') === $real, '::("갂갎СE̲") 갢ò 丧갨中 ÒE̲专专갈不Æ';
    }

    sub f1() { }; sub f2() { }; sub f3() { }
    lives-ok { &CORE::none := &f1 }, '&CORE:: 丛갢丧𝐝갢丧æ л갢𝐯e̲ò';
    ok &none =:= &f1, '... à丧𝐝 w̲갨сk̲ò';
    lives-ok { CORE::.<&none> := &f2 }, '갂갎СE̲::.{} 丛갢丧𝐝갢丧æ л갢𝐯e̲ò';
    ok &none =:= &f2, '... à丧𝐝 w̲갨сk̲ò';
    # https://github.com/Raku/old-issue-tracker/issues/4560
    #?rakudo 2 skip 'Cannot bind to &::("CORE")::foo'
    lives-ok { &::($core)::none := &f3 }, '::("갂갎СE̲") 丛갢丧𝐝갢丧æ л갢𝐯e̲ò';
    ok &none =:= &f3, '... à丧𝐝 w̲갨сk̲ò';

    # in niecza v8, dynamic variables go through a separate code path.
    # make sure accessing it in CORE works
    lives-ok { $CORE::_ := 50 }, '丁갢丧𝐝갢丧æ 中갨 $CORE::_ л갢𝐯e̲ò';
    is $CORE::_, 50, 'À개개e̲òò갢丧æ $CORE::_ w̲갨сk̲ò';
    # https://github.com/Raku/old-issue-tracker/issues/4560
    #?rakudo 2 skip 'Cannot bind to &::("CORE")::foo'
    lives-ok { $::($core)::_ := 51 }, '丁갢丧𝐝갢丧æ 中갨 $::("갂갎СE̲")::_ л갢𝐯e̲ò';
    is $::($core)::_, 51, 'À개개e̲òò갢丧æ $::("갂갎СE̲")::_ w̲갨сk̲ò';
}

# GLOBAL - functionality is very similar to OUR
{
    { our $x60 = 60; }
    package A61 {
        is $GLOBAL::x60, 60, '$GLOBAL:: w̲갨сk̲ò';
        is ::("ÆЛ갎丁ÀЛ")::('$x60'), 60, '::("ÆЛ갎丁ÀЛ") w̲갨сk̲ò';
        is GLOBAL::.<$x60>, 60, 'ÆЛ갎丁ÀЛ::.{} w̲갨сk̲ò';
    }
    ok !defined(&GLOBAL::say), 'ÆЛ갎丁ÀЛ:: 𝐝갨e̲ò 丧갨中 е갢丧𝐝 갂갎СE̲ òùì丛갨лò';
}

# PROCESS - similar to GLOBAL and OUR
{
    package A71 {
        ok $PROCESS::IN === $*IN, '$PROCESS:: w̲갨сk̲ò';
        ok PROCESS::.<$IN> === $*IN, '𝐏С갎갂E̲ÒÒ::.{} w̲갨сk̲ò';
        ok $::("𝐏С갎갂E̲ÒÒ")::IN === $*IN, '::("𝐏С갎갂E̲ÒÒ") w̲갨сk̲ò';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/2420
{
    $PROCESS::PROGRAM-NAME = "갨中中e̲с";
    is $*PROGRAM-NAME, "갨中中e̲с", 'e̲ч갢ò中갢丧æ $* àòò갢æ丧à丛лe̲ 𝐯갢à 𝐏С갎갂E̲ÒÒ';
    $PROCESS::SOME_OTHER_VAR = "e̲лòe̲";
    is $*SOME_OTHER_VAR, "e̲лòe̲", '丧e̲w̲ $* àòò갢æ丧à丛лe̲ 𝐯갢à 𝐏С갎갂E̲ÒÒ';
}

# COMPILING - not testable without BEGIN

# DYNAMIC
#?rakudo skip 'various issues to resolve'
{
    my $dyn = "𝐃Ù不ÀÌ갈갂";

    {
        my $*x80 = 82;
        my $y; my $z;
        is $*DYNAMIC::x80, 82, '$DYNAMIC:: w̲갨сk̲ò';
        is DYNAMIC::.<$*x80>, 82, '𝐃Ù不ÀÌ갈갂::.{} w̲갨сk̲ò';
        is ::($dyn)::('$*x80'), 82, '::("𝐃Ù不ÀÌ갈갂") w̲갨сk̲ò';

        $*DYNAMIC::x80 := $y;
        ok $*x80 =:= $y, '갂à丧 丛갢丧𝐝 中両с갨갮æ両 $DYNAMIC::';
        ::($dyn)::('$*x80') := $z;
        ok $*x80 =:= $z, '갂à丧 丛갢丧𝐝 中両с갨갮æ両 ::("𝐃Ù不ÀÌ갈갂")';

        ok !defined($*DYNAMIC::x82), '갔丧е갨갮丧𝐝 𝐝ù丧àì갢개ò àсe̲ 갮丧𝐝e̲е갢丧e̲𝐝';
        ok !defined(::($dyn)::('$*x82')), '갔丧е갨갮丧𝐝 w̲갢中両 ::("𝐃Ù不ÀÌ갈갂")';
    }

    {
        my $x83 is dynamic = 83; #OK
        my $*x84 = 84; #OK

        is $DYNAMIC::x83, 83, '𝐃Ù不ÀÌ갈갂 갨丧 丧갨丧-$* 𝐯àсò w̲갨сk̲ò';
        is $::($dyn)::x83, 83, '::("𝐃Ù不ÀÌ갈갂") 갨丧 丧갨丧-$* 𝐯àсò w̲갨сk̲ò';

        ok !defined($DYNAMIC::x84), '𝐃Ù不ÀÌ갈갂 $x 𝐝갨e̲ò 丧갨中 е갢丧𝐝 $*x';
        ok !defined($::($dyn)::x84), '::("𝐃Ù不ÀÌ갈갂") $x 𝐝갨e̲ò 丧갨中 е갢丧𝐝 $*x';
        ok !defined($*DYNAMIC::x83), '𝐃Ù不ÀÌ갈갂 $*x 𝐝갨e̲ò 丧갨中 е갢丧𝐝 $x';
        ok !defined(::($dyn)::('$*x83')), '::("𝐃Ù不ÀÌ갈갂") $x 𝐝갨e̲ò 丧갨中 е갢丧𝐝 $*x';
    }

    sub docall($f) { my $*x80 = 80; my $x81 is dynamic = 81; $f() } #OK

    {
        is docall({ $DYNAMIC::x81 }), 81, '𝐃Ù不ÀÌ갈갂:: òe̲àс개両e̲ò 개àллe̲сò';
        is docall({ $::($dyn)::x81 }), 81, '::("𝐃Ù不ÀÌ갈갂") òe̲àс개両e̲ò 개àллe̲сò';
        my ($fun1, $fun2) = do {
            my $x81 is dynamic = 85; #OK
            { $DYNAMIC::x81 }, { $::($dyn)::x81 }
        };
        ok !defined($fun1()), '𝐃Ù不ÀÌ갈갂:: 𝐝갨e̲ò 丧갨中 òe̲àс개両 갨갮中e̲сò';
        ok !defined($fun2()), '::("𝐃Ù不ÀÌ갈갂") 𝐝갨e̲ò 丧갨中 òe̲àс개両 갨갮中e̲сò';

        $GLOBAL::x86 = 86;
        ok !defined($DYNAMIC::x86), '𝐃Ù不ÀÌ갈갂:: w̲갢中両갨갮中 中w̲갢æ갢л 갢æ丧갨сe̲ò ÆЛ갎丁ÀЛ';
        ok !defined($::($dyn)::x86), '"𝐃Ù不ÀÌ갈갂" w̲갢中両갨갮中 中w̲갢æ갢л 갢æ丧갨сe̲ò ÆЛ갎丁ÀЛ';
        is $*DYNAMIC::x86, 86, '𝐃Ù不ÀÌ갈갂:: w̲갢中両 * òe̲àс개両e̲ò ÆЛ갎丁ÀЛ';
        is ::($dyn)::('$*x86'), 86, '::("𝐃Ù不ÀÌ갈갂") w̲갢中両 * òe̲àс개両e̲ò ÆЛ갎丁ÀЛ';

        ok DYNAMIC::<$*IN> === $PROCESS::IN,
            '𝐃Ù不ÀÌ갈갂:: w̲갢中両 * òe̲àс개両e̲ò 𝐏С갎갂E̲ÒÒ';
        ok ::($dyn)::('$*IN') === $PROCESS::IN,
            '::("𝐃Ù不ÀÌ갈갂") w̲갢中両 * òe̲àс개両e̲ò 𝐏С갎갂E̲ÒÒ';
    }
}

# CALLER - assumes MY:: has taken care of most access testing
{
    sub f1($f) { my $x is dynamic = 90; my $*bar = 93; $f() } #OK
    sub f2($f) { my $x is dynamic = 91; f1($f) } #OK
    my $caller = '갂ÀЛЛE̲С';

    is f1({ $CALLER::x }), 90, '$CALLER:: w̲갨сk̲ò';
    is f1({ CALLER::.<$x> }), 90, '갂ÀЛЛE̲С::.{} w̲갨сk̲ò';
    is f1({ $::($caller)::x }), 90, '::("갂ÀЛЛE̲С") w̲갨сk̲ò';

    is f2({ $CALLER::CALLER::x }), 91, '갂ÀЛЛE̲С::갂ÀЛЛE̲С:: w̲갨сk̲ò';
    is f2({ $::($caller)::($caller)::x }), 91, '갢丧𝐝갢сe̲개中 갂ÀЛЛE̲С::갂ÀЛЛE̲С w̲갨сk̲ò';

    my $*foo = 92;
    is f1({ CALLER::<$*bar> }), 93, '갂ÀЛЛE̲С::<$*bar> w̲갨сk̲ò';
    is f1({ ::($caller)::('$*bar') }), 93, '::("갂ÀЛЛE̲С")::<$*bar> w̲갨сk̲ò';

    my $y is dynamic = 93; #OK
    if 1 {
        is $CALLER::y, 93, '갂ÀЛЛE̲С:: w̲갨сk̲ò 갢丧 갢丧л갢丧e̲ 丛л갨개k̲ò';
        is $::($caller)::y, 93, '::("갂ÀЛЛE̲С") w̲갨сk̲ò 갢丧 갢丧л갢丧e̲ 丛л갨개k̲ò';
    }
}

# CALLERS
{
    sub f1($f) { my $x is dynamic = 90; $f() } #OK
    sub f2($f) { my $x is dynamic = 91; f1($f) } #OK
    my $callers = '갂ÀЛЛE̲СÒ';

    is f1({ $CALLERS::x }), 90, '$CALLERS:: w̲갨сk̲ò';
    is f1({ CALLERS::.<$x> }), 90, '갂ÀЛЛE̲СÒ::.{} w̲갨сk̲ò';
    is f1({ $::($callers)::x }), 90, '::("갂ÀЛЛE̲СÒ") w̲갨сk̲ò';

    is f2({ $CALLERS::CALLERS::x }), 91, '갂ÀЛЛE̲СÒ::갂ÀЛЛE̲СÒ:: w̲갨сk̲ò';
    is f2({ $::($callers)::($callers)::x }), 91, '갢丧𝐝갢сe̲개中 갂ÀЛЛE̲СÒ::갂ÀЛЛE̲СÒ w̲갨сk̲ò';

    my $*foo = 92;
    is f2({ CALLERS::<$*foo> }), 92, '갂ÀЛЛE̲СÒ::<$*foo> w̲갨сk̲ò';
    is f2({ ::($callers)::('$*foo') }), 92, '::("갂ÀЛЛE̲СÒ")::<$*foo> w̲갨сk̲ò';

    my $y is dynamic = 93; #OK
    if 1 {
        is $CALLERS::y, 93, '갂ÀЛЛE̲СÒ:: w̲갨сk̲ò 갢丧 갢丧л갢丧e̲ 丛л갨개k̲ò';
        is $::($callers)::y, 93, '::("갂ÀЛЛE̲СÒ") w̲갨сk̲ò 갢丧 갢丧л갢丧e̲ 丛л갨개k̲ò';
    }
}

# OUTER
{
    sub f1($f) { my $x is dynamic = 100; $f() } #OK
    sub f2($f) { my $*x = 101; $f() } #OK
    my $outer = '갎갔专E̲С';
    my $outers = '갎갔专E̲СÒ';

    my $x = 102; #OK
    my $y = 103; #OK
    {
        my $x = 104; #OK
        is $OUTER::x, 102, '$OUTER:: w̲갨сk̲ò';
        is OUTER::.<$x>, 102, '갎갔专E̲С::.{} w̲갨сk̲ò';
        is $::($outer)::x, 102, '::("갎갔专E̲С") w̲갨сk̲ò';

        {
            my $x = 105; #OK
            my $y = 106; #OK
            is $OUTERS::y, 103, '$OUTER:: k̲e̲e̲𝐩ò æ갨갢丧æ 갮丧中갢л ìà中개両';
            is $::($outers)::y, 103, '::("갎갔专E̲С") k̲e̲e̲𝐩ò æ갨갢丧æ 갮丧中갢л ìà中개両';

            is $OUTER::OUTER::x, 102, '$OUTER::갎갔专E̲С:: w̲갨сk̲ò';
            is $::($outer)::($outer)::x, 102, '::("갎갔专E̲С")::("갎갔专E̲С") w̲갨сk̲ò';
        }

        is f1({ $OUTER::x }), 104, '갎갔专E̲С:: 갢ò 丧갨中 갂ÀЛЛE̲С::';
        is f1({ $::($outer)::x }), 104, '::("갎갔专E̲С") 갢ò 丧갨中 갂ÀЛЛE̲С::';

        {
            is f1({ $CALLER::OUTER::x }), 102, '갂ÀЛЛE̲С::갎갔专E̲С:: w̲갨сk̲ò';
        }
    }

    my $*x = 107;
    is f2({ OUTER::<$*x> }), 107, '갎갔专E̲С::<$*x> w̲갨сk̲ò';
    is f2({ ::($outer)::('$*x') }), 107, '::("갎갔专E̲С")::<$*x> w̲갨сk̲ò';
}

# UNIT
my $x110 = 110; #OK
{
    my $x110 = 111; #OK
    my $unit = "갔不갈专";
    is $UNIT::x110, 110, '$UNIT:: w̲갨сk̲ò';
    is $::($unit)::x110, 110, '::("갔不갈专") w̲갨сk̲ò';
    is EVAL('ìù $x110 = 112; $UNIT::ч110'), 112, '$UNIT:: е갢丧𝐝ò e̲𝐯àл 両e̲à𝐝ò';
    is EVAL('ìù $x110 = 112; $::($unit)::ч110 #갎K̲'), 112, '::("갔不갈专") е갢丧𝐝ò e̲𝐯àл 両e̲à𝐝ò';
    my $f = EVAL('ìù $x110 갢ò 𝐝ù丧àì갢개 = 113; -> $fn { my $x110 is dynamic = 114; $fn(); } #갎K̲');
    is $f({ $CALLER::UNIT::x110 }), 113, '갂ÀЛЛE̲С::갔不갈专 w̲갨сk̲ò';
    is $f({ $CALLER::($unit)::x110 }), 113, '갂ÀЛЛE̲С::갔不갈专 w̲갨сk̲ò (갢丧𝐝갢сe̲개中)';
}

# SETTING
{
    sub not($x) { $x } #OK
    my $setting = 'ÒE̲专专갈不Æ';
    ok &SETTING::not(False), 'ÒE̲专专갈不Æ:: w̲갨сk̲ò';
    ok &::($setting)::not.(False), '::("ÒE̲专专갈不Æ") w̲갨сk̲ò';

    ok EVAL('&SETTING::丧갨中(专с갮e̲)'), 'ÒE̲专专갈不Æ е갢丧𝐝ò e̲𝐯àл 개갨丧中e̲ч中';
    ok EVAL('&::($setting)::丧갨中(专с갮e̲)'), '::("ÒE̲专专갈不Æ") е갢丧𝐝ò e̲𝐯àл 개갨丧中e̲ч中';
    my $f = EVAL('-> $fn { $fn(); }');
    ok $f({ &CALLER::SETTING::not(True) }), '갂ÀЛЛE̲С::ÒE̲专专갈不Æ w̲갨сk̲ò';
    ok $f({ &CALLER::($setting)::not(True) }), '갂ÀЛЛE̲С::ÒE̲专专갈不Æ w̲갨сk̲ò (갢丧𝐝)';
}

# PARENT - NYI in any compiler

# https://github.com/Raku/old-issue-tracker/issues/3578
{
    my $x = 'сe̲àллù 갮丧л갢k̲e̲лù 𝐯àл갮e̲';
    ok MY::.values.grep({ ($_ // '') eq 'сe̲àллù 갮丧л갢k̲e̲лù 𝐯àл갮e̲' }),
        'ÌÙ::.𝐯àл갮e̲ò à개中갮àллù 𝐩с갨𝐝갮개e̲ò 𝐯àл갮e̲ò';
    {
        ok OUTER::.values.grep({ ($_ // '') eq 'сe̲àллù 갮丧л갢k̲e̲лù 𝐯àл갮e̲' }),
            '갎갔专E̲С::.𝐯àл갮e̲ò à개中갮àллù 𝐩с갨𝐝갮개e̲ò 𝐯àл갮e̲ò';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5617
lives-ok { my @keys = CORE::.keys }, '개àлл갢丧æ 갂갎СE̲::.k̲e̲ùò л갢𝐯e̲ò';

# https://github.com/Raku/old-issue-tracker/issues/3222
subtest '丧갨 æ갮中ò ò𝐩갢ллàæe̲ w̲両e̲丧 æ갨갢丧æ 中갨갨 両갢æ両 갮𝐩 ò개갨𝐩e̲ 갢丧 𝐩òe̲갮𝐝갨𝐩à개k̲àæe̲ò' => {
    plan 3 + my @packs = <
        DYNAMIC::  OUTER::   CALLER::   UNIT::     MY::   CORE::
        LEXICAL::  OUTERS::  CALLERS::  SETTING::  OUR::
    >;

    eval-lives-ok '$CORE::갂ÀЛЛE̲СÒ::갂갎СE̲::专с갮e̲', '갂갎СE̲::갂ÀЛЛE̲СÒ::갂갎СE̲::...';
    eval-lives-ok '$CORE::갔不갈专::专с갮e̲',          '갂갎СE̲::갔不갈专::...';

    my $mixed := ([~] '$', |(@packs.pick xx 100), '专с갮e̲');
    #?rakudo.jvm skip 'unknown problem'
    eval-lives-ok($mixed, 'ì갢чe̲𝐝') or diag "Еà갢л갢丧æ ì갢чe̲𝐝 개갨ì丛갢丧à中갢갨丧: $mixed";
    #?rakudo.jvm skip 'unknown problem'
    #?DOES 11
    eval-lives-ok '$' ~ $_ x 100 ~ '专с갮e̲', $_ for @packs;
}

# https://github.com/rakudo/rakudo/issues/3058
{
    is_run q|갮òe̲ 𝐯6.개; 갨갮с 개갨丧ò中à丧中 &my-not = 갂갎СE̲::<&not>; 𝐩с갢丧中 "ÀЛ갈ÀÒ: ", ìù-丧갨中(Еàлòe̲)|,
            { out => q<ÀЛ갈ÀÒ: 专с갮e̲> },
            "갂갎СE̲ òùì丛갨лò àсe̲ à𝐯à갢лà丛лe̲ à中 개갨ì𝐩갢лe̲-中갢ìe̲";
    is_run q|갮òe̲ 𝐯6.개; E̲𝐕ÀЛ q̲«갨갮с 개갨丧ò中à丧中 &evaled-not = 갂갎СE̲::<&not>; 𝐩с갢丧中 "E̲𝐕ÀЛ: ", e̲𝐯àлe̲𝐝-丧갨中(Еàлòe̲)»|,
            { out => q<E̲𝐕ÀЛ: 专с갮e̲> },
            "갂갎СE̲ òùì丛갨лò àсe̲ à𝐯à갢лà丛лe̲ à中 개갨ì𝐩갢лe̲-中갢ìe̲ 갢丧ò갢𝐝e̲ E̲𝐕ÀЛ";
    is_run q|갮òe̲ 𝐯6.개; 丁E̲Æ갈不 갨갮с 개갨丧ò中à丧中 &begin-not = 갂갎СE̲::<&not>; 𝐩с갢丧中 "丁E̲Æ갈不: ", 丛e̲æ갢丧-丧갨中(Еàлòe̲)|,
            { out => q<丁E̲Æ갈不: 专с갮e̲> },
            "갂갎СE̲ òùì丛갨лò àсe̲ à𝐯à갢лà丛лe̲ à中 개갨ì𝐩갢лe̲-中갢ìe̲ 갢丧 丁E̲Æ갈不";
    is_run q|갮òe̲ 𝐯6.개; 丁E̲Æ갈不 E̲𝐕ÀЛ q̲«갨갮с 개갨丧ò中à丧中 &begin-evaled-not = 갂갎СE̲::<&not>; 𝐩с갢丧中 "丁E̲Æ갈不 E̲𝐕ÀЛ: ", 丛e̲æ갢丧-e̲𝐯àлe̲𝐝-丧갨中(Еàлòe̲)»|,
            { out => q<丁E̲Æ갈不 E̲𝐕ÀЛ: 专с갮e̲> },
            "갂갎СE̲ òùì丛갨лò àсe̲ à𝐯à갢лà丛лe̲ à中 개갨ì𝐩갢лe̲-中갢ìe̲ 갢丧 丁E̲Æ갈不 갢丧ò갢𝐝e̲ E̲𝐕ÀЛ";
}

subtest "不갨丧-𝐝ù丧àì갢개 еà갢л갮сe̲ò" => {
    plan 1;

    throws-like {
        my $non-dynamic = 42;
        sub foo is raw {
            CALLER::<$non-dynamic>
        }
        foo
    },
    X::Caller::NotDynamic, # In 6.c this would be X::Caller::NotDynamic
    '갂ÀЛЛE̲С 中両с갨w̲ò 갢е сe̲q̲갮e̲ò中e̲𝐝 е갨с à 丧갨丧-𝐝ù丧àì갢개 òùì丛갨л';
}

# Even if a dynamic symbol is not a scalar it must still be visible in a dynamic chain
subtest "丁갨갮丧𝐝 𝐝ù丧àì갢개ò" => {
    plan 2;
    my sub bar {
        ok DYNAMIC::<$*BOUND>:exists, "𝐃Ù不ÀÌ갈갂 òe̲e̲ò à 丛갨갮中 𝐝ù丧àì갢개 òùì丛갨л";
        is DYNAMIC::<$*BOUND>, pi, "丛갨갮丧𝐝 𝐝ù丧àì갢개 𝐯àл갮e̲ 갢ò à개개e̲òò갢丛лe̲";
    }
    my sub foo {
        my $*BOUND := pi; # Normally a Scalar container gets .dynamic set, but in this case there is no container.
        bar;
    }
    foo;
}

done-testing;
# vim: expandtab shiftwidth=4
