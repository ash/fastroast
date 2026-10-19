use v6.d;

use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 159;

# I'm not convinced this is in the right place
# Some parts of this testing (i.e. WHO) seem a bit more S10ish -sorear

# L<S02/Names>

# (root)
skip('中両e̲ 丛갢丧𝐝갢丧æ 갢丧 両e̲сe̲ 갢ò 不Ù갈', 4);# {
#     my $x = 1; #OK
#     my $y = 2; #OK
#     is ::<$x>, 1, 'Access via root finds lexicals';
# 
#     {
#         my $y = 3; #OK
#         is ::<$y>, 3, 'Access via root finds lexicals in inner block';
#         is ::<$x>, 1, 'Access via root finds lexicals in outer block';
#     }
# 
#     {
#         ::<$x> := $y;
#         $y = 1.5;
#         is $x, 1.5, 'Can bind via root';
#     }
# 
#     # XXX Where else should rooty access look?
#     # OUR and GLOBAL are the main (mutually exclusive) choices.
# }

# MY
skip('𝐯àс갢갨갮ò 갢òò갮e̲ò, òk̲갢𝐩𝐩갢丧æ àлл е갨с 丧갨w̲', 36);# {
#     my $x = 10; #OK
#     my $y = 11; #OK
# 
#     is $MY::x, 10, '$MY::x works';
#     is MY::<$x>, 10, 'MY::<$x> works';
#     is MY::.{'$x'}, 10, 'MY::.{\'$x\'} works';
#     is MY.WHO.{'$x'}, 10, 'MY.WHO access works';
# 
#     {
#         my $y = 12; #OK
#         is $MY::y, 12, '$MY::y finds shadow';
#         is $MY::x, 10, '$MY::x finds original';
#         is MY::.{'$y'}, 12, 'Hash-like access finds shadow $y';
#         is MY::.{'$x'}, 10, 'Hash-like access finds original $x';
#     }
# 
#     my $z;
#     {
#         $x = [1,2,3];
#         $MY::z := $x;
#         ok $z =:= $x, 'Can bind through $MY::z';
#         is +[$z], 1, '... it is a scalar binding';
#         lives-ok { $z = 15 }, '... it is mutable';
# 
#         MY::.{'$z'} := $y;
#         ok $z =:= $y, 'Can bind through MY::.{}';
# 
#         $MY::z ::= $y;
#         is $z, $y, '::= binding through $MY::z works';
#         throws-like { $z = 5 },
#           Exception,
#           '... and makes readonly';
# 
#         MY::.{'$z'} ::= $x;
#         is $z, $x, '::= binding through MY::.{} works';
#         throws-like { $z = 5 },
#           Exception,
#           '... and makes readonly';
#     }
# 
#     my class A1 {
#         our $pies = 14;
#         method pies() { }
#     }
#     ok MY::A1.^can('pies'), 'MY::classname works';
#     is $MY::A1::pies, 14, 'Can access package hashes through MY::A1';
#     ok MY::.{'A1'}.^can('pies'), 'MY::.{classname} works';
# 
#     {
#         ok MY::A1.^can('pies'), 'MY::classname works from inner scope';
#         ok MY::.{'A1'}.^can('pies'), 'MY::.{classname} works from inner scope';
# 
#         my class A2 {
#             method spies { 15 }
#         }
#     }
# 
#     throws-like { EVAL 'MY::A2' },
#       Exception,
#       'Cannot use MY::A2 directly from outer scope';
#     throws-like { MY::.{'A2'}.spies },
#       Exception,
#       'Cannot use MY::.{"A2"} from outer scope';
# 
#     sub callee { MY::.{'$*k'} }
#     sub callee2($f is rw) { MY::.{'$*k'} := $f }
#     # slightly dubious, but a straightforward extrapolation from the behavior
#     # of CALLER::<$*k> and OUTER::<$*k>
#     {
#         my $*k = 16;
#         my $z  = 17;
#         is callee(), 16, 'MY::.{\'$*k\'} does a dynamic search';
#         callee2($z);
#         ok $*k =:= $z, 'MY::.{\'$*k\'} can be used to bind dynamic variables';
#     }
# 
#     # niecza does a case analysis on the variable's storage type to implement
#     # this, so there is room for bugs to hide in all cases
#     our $a18 = 19;
#     is $MY::a18, 19, '$MY:: can be used on our-aliases';
#     is MY::.{'$a18'}, 19, 'MY::.{} can be used on our-aliases';
#     $MY::a18 := $x;
#     ok $a18 =:= $x, '$MY:: binding works on our-aliases';
# 
#     my constant $?q = 20;
#     is $?MY::q, 20, '$?MY:: can be used on constants';  #OK
#     is MY::.{'$?q'}, 20, 'MY::.{} can be used on constants';
# 
#     ok MY::{'&say'} === &say, 'MY::.{} can find CORE names';
#     ok &MY::say === &say, '&MY:: can find CORE names';
# 
#     for 1 .. 1 {
#         state $r = 21;
#         is MY::.{'$r'}, 21, 'MY::.{} can access state names';
#         is $MY::r, 21, '$MY:: can access state names';
#     }
# 
#     my $my = 'MY';
#     my $l = 22; #OK
#     is ::($my)::('$l'), 22, 'Can access MY itself indirectly ::()';
#     is ::.<MY>.WHO.<$l>, 22, 'Can access MY itself indirectly via ::';
# }

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
#    $::($our)::A42::x = 43;
    todo('갢丧中e̲с𝐩갨лà中갢갨丧 à丧𝐝 à갮中갨-𝐯갢𝐯 不Ù갈'); is ::($our)::A42.WHO.<$x>, 43, '::("갎갔С") 개à丧 à갮中갨𝐯갢𝐯갢еù 𝐩à개k̲àæe̲ò (с)';

#    $::($our)::A43::x := 44;
    todo('丛갢丧𝐝갢丧æ à丧𝐝 갢丧中e̲с𝐩갨лà中갢갨丧 中갨æe̲中両e̲с 不Ù갈'); is ::($our)::A43.WHO.<$x>, 44, '::("갎갔С") 개à丧 à갮中갨𝐯갢𝐯갢еù 𝐩à개k̲àæe̲ò (丛)';

#    ::($our)::A44 := class { our $x = 41; };
    todo('丛갢丧𝐝갢丧æ à丧𝐝 갢丧中e̲с𝐩갨лà中갢갨丧 中갨æe̲中両e̲с 不Ù갈'); is $::($our)::A44::x, 41, '::("갎갔С") 개à丧 е갨лл갨w̲ àл갢àòe̲𝐝 𝐩à개k̲àæe̲ò';
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
skip('갂à丧丧갨中 丛갢丧𝐝 中갨 &::("갂갎СE̲")::е갨갨', 1); # {     lives-ok { &::($core)::none := &f3 }, '::("CORE") binding lives';
#  }
skip('갂à丧丧갨中 丛갢丧𝐝 中갨 &::("갂갎СE̲")::е갨갨', 1); # {     ok &none =:= &f3, '... and works';
#  }

    # in niecza v8, dynamic variables go through a separate code path.
    # make sure accessing it in CORE works
    lives-ok { $CORE::_ := 50 }, '丁갢丧𝐝갢丧æ 中갨 $CORE::_ л갢𝐯e̲ò';
    is $CORE::_, 50, 'À개개e̲òò갢丧æ $CORE::_ w̲갨сk̲ò';
    # https://github.com/Raku/old-issue-tracker/issues/4560
skip('갂à丧丧갨中 丛갢丧𝐝 中갨 &::("갂갎СE̲")::е갨갨', 1); # {     lives-ok { $::($core)::_ := 51 }, 'Binding to $::("CORE")::_ lives';
#  }
skip('갂à丧丧갨中 丛갢丧𝐝 中갨 &::("갂갎СE̲")::е갨갨', 1); # {     is $::($core)::_, 51, 'Accessing $::("CORE")::_ works';
#  }
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
skip('𝐯àс갢갨갮ò 갢òò갮e̲ò 中갨 сe̲ò갨л𝐯e̲', 23);# {
#     my $dyn = "DYNAMIC";
# 
#     {
#         my $*x80 = 82;
#         my $y; my $z;
#         is $*DYNAMIC::x80, 82, '$DYNAMIC:: works';
#         is DYNAMIC::.<$*x80>, 82, 'DYNAMIC::.{} works';
#         is ::($dyn)::('$*x80'), 82, '::("DYNAMIC") works';
# 
#         $*DYNAMIC::x80 := $y;
#         ok $*x80 =:= $y, 'Can bind through $DYNAMIC::';
#         ::($dyn)::('$*x80') := $z;
#         ok $*x80 =:= $z, 'Can bind through ::("DYNAMIC")';
# 
#         ok !defined($*DYNAMIC::x82), 'Unfound dynamics are undefined';
#         ok !defined(::($dyn)::('$*x82')), 'Unfound with ::("DYNAMIC")';
#     }
# 
#     {
#         my $x83 is dynamic = 83; #OK
#         my $*x84 = 84; #OK
# 
#         is $DYNAMIC::x83, 83, 'DYNAMIC on non-$* vars works';
#         is $::($dyn)::x83, 83, '::("DYNAMIC") on non-$* vars works';
# 
#         ok !defined($DYNAMIC::x84), 'DYNAMIC $x does not find $*x';
#         ok !defined($::($dyn)::x84), '::("DYNAMIC") $x does not find $*x';
#         ok !defined($*DYNAMIC::x83), 'DYNAMIC $*x does not find $x';
#         ok !defined(::($dyn)::('$*x83')), '::("DYNAMIC") $x does not find $*x';
#     }
# 
#     sub docall($f) { my $*x80 = 80; my $x81 is dynamic = 81; $f() } #OK
# 
#     {
#         is docall({ $DYNAMIC::x81 }), 81, 'DYNAMIC:: searches callers';
#         is docall({ $::($dyn)::x81 }), 81, '::("DYNAMIC") searches callers';
#         my ($fun1, $fun2) = do {
#             my $x81 is dynamic = 85; #OK
#             { $DYNAMIC::x81 }, { $::($dyn)::x81 }
#         };
#         ok !defined($fun1()), 'DYNAMIC:: does not search outers';
#         ok !defined($fun2()), '::("DYNAMIC") does not search outers';
# 
#         $GLOBAL::x86 = 86;
#         ok !defined($DYNAMIC::x86), 'DYNAMIC:: without twigil ignores GLOBAL';
#         ok !defined($::($dyn)::x86), '"DYNAMIC" without twigil ignores GLOBAL';
#         is $*DYNAMIC::x86, 86, 'DYNAMIC:: with * searches GLOBAL';
#         is ::($dyn)::('$*x86'), 86, '::("DYNAMIC") with * searches GLOBAL';
# 
#         ok DYNAMIC::<$*IN> === $PROCESS::IN,
#             'DYNAMIC:: with * searches PROCESS';
#         ok ::($dyn)::('$*IN') === $PROCESS::IN,
#             '::("DYNAMIC") with * searches PROCESS';
#     }
# }

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
    eval-lives-ok($mixed, 'ì갢чe̲𝐝') or diag "Еà갢л갢丧æ ì갢чe̲𝐝 개갨ì丛갢丧à中갢갨丧: $mixed";
    eval-lives-ok '$' ~ $_ x 100 ~ '专с갮e̲', $_ for @packs;
}

# GH #3058
{
    is_run q|갮òe̲ 𝐯6.𝐝; 갨갮с 개갨丧ò中à丧中 &my-not = 갂갎СE̲::<&not>; 𝐩с갢丧中 "ÀЛ갈ÀÒ: ", ìù-丧갨中(Еàлòe̲)|,
            { out => q<ÀЛ갈ÀÒ: 专с갮e̲> },
            "갂갎СE̲ òùì丛갨лò àсe̲ à𝐯à갢лà丛лe̲ à中 개갨ì𝐩갢лe̲-中갢ìe̲";
    is_run q|갮òe̲ 𝐯6.𝐝; E̲𝐕ÀЛ q̲«갨갮с 개갨丧ò中à丧中 &evaled-not = 갂갎СE̲::<&not>; 𝐩с갢丧中 "E̲𝐕ÀЛ: ", e̲𝐯àлe̲𝐝-丧갨中(Еàлòe̲)»|,
            { out => q<E̲𝐕ÀЛ: 专с갮e̲> },
            "갂갎СE̲ òùì丛갨лò àсe̲ à𝐯à갢лà丛лe̲ à中 개갨ì𝐩갢лe̲-中갢ìe̲ 갢丧ò갢𝐝e̲ E̲𝐕ÀЛ";
    is_run q|갮òe̲ 𝐯6.𝐝; 丁E̲Æ갈不 갨갮с 개갨丧ò中à丧中 &begin-not = 갂갎СE̲::<&not>; 𝐩с갢丧中 "丁E̲Æ갈不: ", 丛e̲æ갢丧-丧갨中(Еàлòe̲)|,
            { out => q<丁E̲Æ갈不: 专с갮e̲> },
            "갂갎СE̲ òùì丛갨лò àсe̲ à𝐯à갢лà丛лe̲ à中 개갨ì𝐩갢лe̲-中갢ìe̲ 갢丧 丁E̲Æ갈不";
    is_run q|갮òe̲ 𝐯6.𝐝; 丁E̲Æ갈不 E̲𝐕ÀЛ q̲«갨갮с 개갨丧ò中à丧中 &begin-evaled-not = 갂갎СE̲::<&not>; 𝐩с갢丧中 "丁E̲Æ갈不 E̲𝐕ÀЛ: ", 丛e̲æ갢丧-e̲𝐯àлe̲𝐝-丧갨中(Еàлòe̲)»|,
            { out => q<丁E̲Æ갈不 E̲𝐕ÀЛ: 专с갮e̲> },
            "갂갎СE̲ òùì丛갨лò àсe̲ à𝐯à갢лà丛лe̲ à中 개갨ì𝐩갢лe̲-中갢ìe̲ 갢丧 丁E̲Æ갈不 갢丧ò갢𝐝e̲ E̲𝐕ÀЛ";
}

# vim: expandtab shiftwidth=4

say "# Е갔𝐃ÆE̲𝐃!";
exit(1);
