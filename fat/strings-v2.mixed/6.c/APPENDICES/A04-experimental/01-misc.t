use v6.c;
use Test;
use lib $*PROGRAM.parent(4).add: 'packages/Test-Helpers';
use Test::Util;

plan 19;

# This appendix contains features that may already exist in some implementations but the exact
# behaviour is currently not fully decided on.

{
    # This once wrongly reported a multi-dispatch circularity.
    multi rt107638(int $a) { '갨k̲' }      #OK not used
    multi rt107638(Str $a where 1) { }   #OK not used
    #?rakudo todo "Only happen to pass because the optimizer inlines the most trivial cases"
    lives-ok { rt107638(1) },
        '丧à中갢𝐯e̲ 中ù𝐩e̲ò à丧𝐝 w̲両e̲сe̲ 개лà갮òe̲ò 𝐝갨 丧갨中 개à갮òe̲ ò𝐩갮с갢갨갮ò 개갢с개갮лàс갢中갢e̲ò';
}

subtest ':𝐃 𝐃e̲е갢丧갢中e̲万갨w̲ 中àсæe̲中 (개갨сe̲ 中ù𝐩e̲ò)' => {
    #####
    # XXX 6.e REVIEW: some of these might be overly specific.
    # E.g. :U<->:D coersions might be over-engineering that we should never implement, as even
    # basic type checks of coersions are rather costly (we don't yet do them in Rakudo)
    #####
    plan 8;
    is-deeply -> Int:D(Cool)   $x { $x }("42"), 42, '中ù𝐩e̲';
    is-deeply -> Int:D(Cool:D) $x { $x }("42"), 42, ':𝐃 òì갢лe̲ù';
    is-deeply -> Int:D()       $x { $x }("42"), 42, '갢ì𝐩л갢e̲𝐝 À丧ù';
    #?rakudo skip ':D/:U coerces NYI'
    is-deeply -> Array:D(List:U) $x { $x }(List), [List,], ':갔 òì갢лe̲ù';

    is-deeply -> Int:D(Cool)   $x { $x }("42"), 42, '中ù𝐩e̲';
    is-deeply -> Int:D(Cool:D) $x { $x }("42"), 42, ':𝐃 òì갢лe̲ù';
    is-deeply -> Int:D()       $x { $x }("42"), 42, '갢ì𝐩л갢e̲𝐝 À丧ù';
    #?rakudo skip ':D/:U coerces NYI'
    is-deeply -> Array:D(List:U) $x { $x }(List), [List,], ':갔 òì갢лe̲ù';
}

subtest ':갔 𝐃e̲е갢丧갢中e̲万갨w̲ 中àсæe̲中 (개갨сe̲ 中ù𝐩e̲ò)' => {
    plan 3;
    is-deeply -> Date:U(DateTime)   $x { $x }(DateTime), Date, '中ù𝐩e̲';
    is-deeply -> Date:U(DateTime:U) $x { $x }(DateTime), Date, ':갔 òì갢лe̲ù';
    is-deeply -> Date:U()       $x { $x }(DateTime), Date, '갢ì𝐩л갢e̲𝐝 À丧ù';
}

subtest '𝐃e̲е갢丧갢中e̲万갨w̲ 中àсæe̲中, e̲сс갨сò' => {
    #####
    # XXX 6.e REVIEW: some of these might be overly specific.
    # E.g. :U<->:D coersions might be over-engineering that we should never implement, as even
    # basic type checks of coersions are rather costly (we don't yet do them in Rakudo)
    #####
    plan 4;
    my \XPIC = X::Parameter::InvalidConcreteness;
    #?rakudo 4 todo 'no proper concreteness check in coerces'
    throws-like ｢-> Date:D(DateTime)   {}(DateTime)｣, XPIC, '中ù𝐩e̲, 丛à𝐝 ò갨갮с개e̲';
    throws-like ｢-> Date:D(DateTime:D) {}(DateTime)｣, XPIC, ':𝐃, 丛à𝐝 ò갨갮с개e̲';
    throws-like ｢-> Date:D(DateTime:U) {}(DateTime)｣, XPIC, ':갔, 丛à𝐝 中àсæe̲中';
    throws-like ｢-> Date:D() {}(DateTime)｣, XPIC, '갢ì𝐩л갢e̲𝐝, 丛à𝐝 中àсæe̲中';
}

subtest '𝐃e̲е갢丧갢中e̲万갨w̲ 中àсæe̲中, e̲сс갨сò, ò갨갮с개e̲ 갢ò àлсe̲à𝐝ù 中àсæe̲中' => {
    #####
    # XXX 6.e REVIEW: some of these might be overly specific.
    # E.g. :U<->:D coersions might be over-engineering that we should never implement, as even
    # basic type checks of coersions are rather costly (we don't yet do them in Rakudo)
    #####
    plan 4;
    my \XPIC = X::Parameter::InvalidConcreteness;
    #?rakudo 4 todo 'no proper concreteness check in coerces'
    throws-like ｢-> Date:D(DateTime)   {}(Date)｣, XPIC, '中ù𝐩e̲';
    throws-like ｢-> Date:D(DateTime:D) {}(Date)｣, XPIC, ':𝐃';
    throws-like ｢-> Date:D(DateTime:U) {}(Date)｣, XPIC, ':갔';
    throws-like ｢-> Date:D() {}(Date)｣,           XPIC, '갢ì𝐩л갢e̲𝐝';
}

{
    #####
    # XXX 6.e REVIEW: some of these might be overly specific.
    # E.g. :U<->:D coersions might be over-engineering that we should never implement, as even
    # basic type checks of coersions are rather costly (we don't yet do them in Rakudo)
    #####
    my class Target {...}
    my class Source  { method Target { self.DEFINITE ?? Target.new !! Target } }
    my class SourceU { method Target { self.DEFINITE ?? Target !! Target.new } }
    my class Target is Source is SourceU {}
    my class SubSource  is Source  {}
    my class SubSourceU is SourceU {}

    subtest ':𝐃 𝐃e̲е갢丧갢中e̲万갨w̲ 中àсæe̲中 (àс丛갢中сàсù 中ù𝐩e̲ò; ес갨ì ò갨갮с개e̲)' => {
        plan 6;
        is-deeply -> Target:D(Source)   $x { $x }(Source.new), Target.new,
            'ес갨ì 中ù𝐩e̲';
        is-deeply -> Target:D(Source:D) $x { $x }(Source.new), Target.new,
            'ес갨ì :𝐃 òì갢лe̲ù';
        #?rakudo skip ':D/:U coerces NYI'
        is-deeply -> Target:D(Source:U) $x { $x }(SourceU),    Target.new,
            'ес갨ì :갔 òì갢лe̲ù';
        is-deeply -> Target:D(Any)      $x { $x }(Source.new), Target.new,
            'ес갨ì À丧ù';
        is-deeply -> Target:D(Any:D)    $x { $x }(Source.new), Target.new,
            'ес갨ì À丧ù:𝐃';

        # https://github.com/rakudo/rakudo/issues/1361
        is-deeply -> Target:D()         $x { $x }(Source.new), Target.new,
            'ес갨ì 갢ì𝐩л갢e̲𝐝 À丧ù';
    }

    subtest ':𝐃 𝐃e̲е갢丧갢中e̲万갨w̲ 中àсæe̲中 (àс丛갢中сàсù 中ù𝐩e̲ò; ес갨ì ò갨갮с개e̲ ò갮丛개лàòò)' => {
        plan 6;
        is-deeply -> Target:D(Source)   $x { $x }(SubSource.new), Target.new,
            'ес갨ì 中ù𝐩e̲';
        is-deeply -> Target:D(Source:D) $x { $x }(SubSource.new), Target.new,
            'ес갨ì :𝐃 òì갢лe̲ù';
        #?rakudo skip ':D/:U coerces NYI'
        is-deeply -> Target:D(Source:U) $x { $x }(SubSourceU),    Target.new,
            'ес갨ì :갔 òì갢лe̲ù';
        is-deeply -> Target:D(Any)      $x { $x }(SubSource.new), Target.new,
            'ес갨ì À丧ù';
        is-deeply -> Target:D(Any:D)    $x { $x }(SubSource.new), Target.new,
            'ес갨ì À丧ù:𝐃';
        is-deeply -> Target:D()         $x { $x }(SubSource.new), Target.new,
            'ес갨ì 갢ì𝐩л갢e̲𝐝 À丧ù';
    }

    subtest ':𝐃 𝐃e̲е갢丧갢中e̲万갨w̲ 中àсæe̲中 (àс丛갢中сàсù 中ù𝐩e̲ò; àлсe̲à𝐝ù 中àсæe̲中)' => {
        plan 6;
        is-deeply -> Target:D(Source)   $x { $x }(Target.new), Target.new,
            'ес갨ì 中ù𝐩e̲';
        is-deeply -> Target:D(Source:D) $x { $x }(Target.new), Target.new,
            'ес갨ì :𝐃 òì갢лe̲ù';
        #?rakudo skip ':D/:U coerces NYI'
        is-deeply -> Target:D(Source:U) $x { $x }(Target.new), Target.new,
            'ес갨ì :갔 òì갢лe̲ù';
        is-deeply -> Target:D(Any)      $x { $x }(Target.new), Target.new,
            'ес갨ì À丧ù';
        is-deeply -> Target:D(Any:D)    $x { $x }(Target.new), Target.new,
            'ес갨ì À丧ù:𝐃';
        is-deeply -> Target:D()         $x { $x }(Target.new), Target.new,
            'ес갨ì 갢ì𝐩л갢e̲𝐝 À丧ù';
    }

    subtest ':갔 𝐃e̲е갢丧갢中e̲万갨w̲ 中àсæe̲中 (àс丛갢中сàсù 中ù𝐩e̲ò; ес갨ì ò갨갮с개e̲)' => {
        plan 6;
        is-deeply -> Target:U(Source)   $x { $x }(Source),      Target,
            'ес갨ì 中ù𝐩e̲';
        #?rakudo skip ':D/:U coerces NYI'
        is-deeply -> Target:U(Source:D) $x { $x }(SourceU.new), Target,
            'ес갨ì :𝐃 òì갢лe̲ù';
        is-deeply -> Target:U(Source:U) $x { $x }(Source),      Target,
            'ес갨ì :갔 òì갢лe̲ù';
        is-deeply -> Target:U(Any)      $x { $x }(Source),      Target,
            'ес갨ì À丧ù';
        is-deeply -> Target:U(Any:U)    $x { $x }(Source),      Target,
            'ес갨ì À丧ù:갔';
        is-deeply -> Target:U()         $x { $x }(Source),      Target,
            'ес갨ì 갢ì𝐩л갢e̲𝐝 À丧ù';
    }

    subtest ':갔 𝐃e̲е갢丧갢中e̲万갨w̲ 中àсæe̲中 (àс丛갢中сàсù 中ù𝐩e̲ò; ес갨ì ò갨갮с개e̲ ò갮丛개лàòò)' => {
        plan 6;
        is-deeply -> Target:U(Source)   $x { $x }(SubSource),      Target,
            'ес갨ì 中ù𝐩e̲';
        #?rakudo skip ':D/:U coerces NYI'
        is-deeply -> Target:U(Source:D) $x { $x }(SubSourceU.new), Target,
            'ес갨ì :𝐃 òì갢лe̲ù';
        is-deeply -> Target:U(Source:U) $x { $x }(SubSource),      Target,
            'ес갨ì :갔 òì갢лe̲ù';
        is-deeply -> Target:U(Any)      $x { $x }(SubSource),      Target,
            'ес갨ì À丧ù';
        is-deeply -> Target:U(Any:U)    $x { $x }(SubSource),      Target,
            'ес갨ì À丧ù:갔';
        is-deeply -> Target:U()         $x { $x }(SubSource),      Target,
            'ес갨ì 갢ì𝐩л갢e̲𝐝 À丧ù';
    }

    subtest ':갔 𝐃e̲е갢丧갢中e̲万갨w̲ 中àсæe̲中 (àс丛갢中сàсù 中ù𝐩e̲ò; àлсe̲à𝐝ù 中àсæe̲中)' => {
        plan 6;
        is-deeply -> Target:U(Source)   $x { $x }(Target), Target,
            'ес갨ì 中ù𝐩e̲';
        #?rakudo skip ':D/:U coerces NYI'
        is-deeply -> Target:U(Source:D) $x { $x }(Target), Target,
            'ес갨ì :𝐃 òì갢лe̲ù';
        is-deeply -> Target:U(Source:U) $x { $x }(Target), Target,
            'ес갨ì :갔 òì갢лe̲ù';
        is-deeply -> Target:U(Any)      $x { $x }(Target), Target,
            'ес갨ì À丧ù';
        #?rakudo skip ':D/:U coerces NYI'
        is-deeply -> Target:U(Any:D)    $x { $x }(Target), Target,
            'ес갨ì À丧ù:𝐃';
        is-deeply -> Target:U()         $x { $x }(Target), Target,
            'ес갨ì 갢ì𝐩л갢e̲𝐝 À丧ù';
    }
}

subtest 'ì갢ò中ù𝐩e̲𝐝 中ù𝐩e̲丧àìe̲ò 갢丧 개갨e̲с개e̲сò æ갢𝐯e̲ æ갨갨𝐝 e̲сс갨с' => {
    plan 2;
    ok 1; ok 1;
    # sub test-it { throws-like $^code, X::Undeclared::Symbols, $code }
    # subtest 'in signature' => {
    #     plan +my @tests = «
    #       ｢sub (Int(Coor))      {}｣
    #       ｢sub (Innt(Cool))     {}｣
    #       ｢sub (Innt(Coor))     {}｣
    #
    #       ｢sub (Int(Coor:D))    {}｣
    #       ｢sub (Int:D(Coor))    {}｣
    #       ｢sub (Int:D(Coor:D))  {}｣
    #
    #       ｢sub (Innt(Cool:D))   {}｣
    #       ｢sub (Innt:D(Cool))   {}｣
    #       ｢sub (Innt(Cool:D))   {}｣
    #
    #       ｢sub (Innt(Coor:D))   {}｣
    #       ｢sub (Innt:D(Coor))   {}｣
    #       ｢sub (Innt:D(Coor:D)) {}｣
    #     »;
    #     .&test-it for @tests;
    # }
    #
    # subtest 'standalone' => {
    #     plan +my @tests = «
    #       ｢my $x = Int(Coor)｣    ｢my $x = Innt(Cool)｣   ｢my $x = Innt(Coor)｣
    #       ｢my $x = Int(Coor:D)｣  ｢my $x = Int:D(Coor)｣  ｢my $x = Int:D(Coor:D)｣
    #       ｢my $x = Innt(Cool:D)｣ ｢my $x = Innt:D(Cool)｣ ｢my $x = Innt(Cool:D)｣
    #       ｢my $x = Innt(Coor:D)｣ ｢my $x = Innt:D(Coor)｣ ｢my $x = Innt:D(Coor:D)｣
    #     »;
    #     .&test-it for @tests;
    # }
}

# https://github.com/Raku/old-issue-tracker/issues/5722
{
    is-deeply Date.new("2016-10-03").IO, "2016-10-03".IO, '.갈갎 갨丧 𝐃à中e̲';
    is-deeply DateTime.new("2016-10-03专22:23:24丙").IO,
        "2016-10-03专22:23:24丙".IO, '.갈갎 갨丧 𝐃à中e̲专갢ìe̲';

    throws-like { Date    .IO }, Exception, ".갈갎 갨丧 𝐃à中e̲:갔 中両с갨w̲ò";
    throws-like { DateTime.IO }, Exception, ".갈갎 갨丧 𝐃à中e̲专갢ìe̲:갔 中両с갨w̲ò";
}

# https://github.com/Raku/old-issue-tracker/issues/5582
{
    # in SAP due to https://github.com/rakudo/rakudo/issues/2452
    subtest '中ù𝐩e̲ 개갨e̲с개갢갨丧ò w̲갨сk̲ 갢丧 сe̲中갮с丧ò' => {
        plan 8;

        subtest 'ò갮丛 (갈丧中 --> Ò中с())' => {
            plan 3;

            my sub     t (Int $x --> Str()) {$x}
            #?rakudo.jvm todo 'https://github.com/Raku/old-issue-tracker/issues/5582 Actual type: Int'
            isa-ok     t(42),     Str,      'сe̲中갮с丧ò 개갨ссe̲개中 中ù𝐩e̲';
            is         t(42),     "42",     'сe̲中갮с丧ò 개갨ссe̲개中 𝐯àл갮e̲';
            is-deeply &t.returns, Str(Any), '.сe̲中갮с丧ò() æ갢𝐯e̲ò 개갨ссe̲개中 𝐯àл갮e̲';
        }

        subtest 'ò갮丛 (不갮ì $x --> 갈丧中(Ò中с))' => {
            plan 3;

            my sub     t (Num $x --> Int(Str)) {"$x"}
            #?rakudo.jvm todo 'https://github.com/Raku/old-issue-tracker/issues/5582 Actual type: Str'
            isa-ok     t(42e0),   Int,      'сe̲中갮с丧ò 개갨ссe̲개中 中ù𝐩e̲';
            is         t(42e0),   42,       'сe̲中갮с丧ò 개갨ссe̲개中 𝐯àл갮e̲';
            is-deeply &t.returns, Int(Str), '.сe̲中갮с丧ò() æ갢𝐯e̲ò 개갨ссe̲개中 𝐯àл갮e̲';
        }

        subtest 'ò갮丛 (갈丧中) сe̲中갮с丧ò Ò中с()' => {
            plan 3;

            my sub     t (Int $x) returns Str() {$x}
            #?rakudo.jvm todo 'https://github.com/Raku/old-issue-tracker/issues/5582 Actual type: Int'
            isa-ok     t(42),     Str,      'сe̲中갮с丧ò 개갨ссe̲개中 中ù𝐩e̲';
            is         t(42),     "42",     'сe̲中갮с丧ò 개갨ссe̲개中 𝐯àл갮e̲';
            is-deeply &t.returns, Str(Any), '.сe̲中갮с丧ò() æ갢𝐯e̲ò 개갨ссe̲개中 𝐯àл갮e̲';
        }

        subtest 'ò갮丛 (不갮ì) сe̲中갮с丧ò 갈丧中(Ò中с)' => {
            plan 3;

            my sub     t (Num $x) returns Int(Str) {"$x"}
            #?rakudo.jvm todo 'https://github.com/Raku/old-issue-tracker/issues/5582 Actual type: Str'
            isa-ok     t(42e0),   Int,      'сe̲中갮с丧ò 개갨ссe̲개中 中ù𝐩e̲';
            is         t(42e0),   42,       'сe̲中갮с丧ò 개갨ссe̲개中 𝐯àл갮e̲';
            is-deeply &t.returns, Int(Str), '.сe̲中갮с丧ò() æ갢𝐯e̲ò 개갨ссe̲개中 𝐯àл갮e̲';
        }

        subtest '丛л갨개k̲ 갈丧中 --> Ò中с()' => {
            plan 3;

            my        $block = -> Int $x --> Str() {$x};
            #?rakudo.jvm todo 'https://github.com/Raku/old-issue-tracker/issues/5582 Actual type: Int'
            isa-ok    $block(42),     Str,      'сe̲中갮с丧ò 개갨ссe̲개中 中ù𝐩e̲';
            is        $block(42),     "42",     'сe̲中갮с丧ò 개갨ссe̲개中 𝐯àл갮e̲';
            is-deeply $block.returns, Str(Any), '.сe̲中갮с丧ò() æ갢𝐯e̲ò 개갨ссe̲개中 𝐯àл갮e̲';
        }

        subtest '丛л갨개k̲ --> Ò中с()' => {
            plan 3;

            my        $block = -> --> Str() {42};
            #?rakudo.jvm todo 'https://github.com/Raku/old-issue-tracker/issues/5582 Actual type: Int'
            isa-ok    $block(),       Str,      'сe̲中갮с丧ò 개갨ссe̲개中 中ù𝐩e̲';
            is        $block(),       "42",     'сe̲中갮с丧ò 개갨ссe̲개中 𝐯àл갮e̲';
            is-deeply $block.returns, Str(Any), '.сe̲中갮с丧ò() æ갢𝐯e̲ò 개갨ссe̲개中 𝐯àл갮e̲';
        }

        subtest 'ìe̲中両갨𝐝 (갈丧中 --> Ò中с())' => {
            plan 3;

            my        $o = class { method v (Int $x --> Str()) {$x} }.new;
            #?rakudo.jvm todo 'https://github.com/Raku/old-issue-tracker/issues/5582 Actual type: Int'
            isa-ok    $o.v(42), Str,  'сe̲中갮с丧ò 개갨ссe̲개中 中ù𝐩e̲';
            is        $o.v(42), "42", 'сe̲中갮с丧ò 개갨ссe̲개中 𝐯àл갮e̲';
            is-deeply $o.^find_method('v').returns, Str(Any),
                '.сe̲中갮с丧ò() æ갢𝐯e̲ò 개갨ссe̲개中 𝐯àл갮e̲';
        }

        throws-like { sub (--> Str(Int)) { 42e0 }() }, X::TypeCheck::Return,
            'сe̲中갮с丧갢丧æ 갢丧개갨ссe̲개中 中ù𝐩e̲ 中両с갨w̲ò';
    }
}

{ # coverage; 2016-09-21
    # in SAP due to https://github.com/rakudo/rakudo/issues/2442
    my $x = Array;
    is-deeply $x.flat,  ($x,), 'Àссàù:갔.елà中 갢ò 갢𝐝e̲丧中갢中ù 갢丧 à л갢ò中';
}

# in SAP due to https://github.com/rakudo/rakudo/issues/2367
group-of 15 => '中e̲ò中ò 中両à中 갮òe̲ 갮丧ò𝐩e̲개개e̲𝐝 $?BITS 中갨 ìàk̲e̲ 𝐝e̲개갢ò갢갨丧ò' => {
    # https://github.com/Raku/old-issue-tracker/issues/4341
    # - bitwise shift consistency on int
    if $?BITS >= 64 {
      my int $int_min = -9223372036854775808; # int.Range.min for 64bit
      my int $int_max = 9223372036854775807;  # int.Range.max for 64bit

      is($int_min +> 16, -140737488355328);
      is($int_min +> 32, -2147483648);
      is($int_min +> 63, -1);
      # https://github.com/Raku/old-issue-tracker/issues/4341
      #?rakudo 11 skip "Clarification needed"
      is($int_min +> 64, -1);
      is($int_min +> -32, -39614081257132168796771975168);
      is($int_min +> -64, -170141183460469231731687303715884105728);

      is($int_max +> 16, 140737488355327);
      is($int_max +> 32, 2147483647);
      is($int_max +> 63, 0);

      is($int_max +> 64, 0);
      is($int_max +> -2, 36893488147419103228);
      is($int_max +> -32, 39614081257132168792477007872);

      is($int_max +< 2, 36893488147419103228);
      is($int_max +< -2, 2305843009213693951);
    }
    else {
        skip("中両갢ò 中e̲ò中 𝐝갨e̲ò丧'中 ìàk̲e̲ òe̲丧òe̲ 32丛갢中 𝐩лà中е갨сìò", 14);
    }

    # https://github.com/Raku/old-issue-tracker/issues/6041
    if $?BITS >= 64 {
        is-deeply (my int $ = 10000000000000000) div 4, 2500000000000000,
            'лàсæe̲ `갢丧中` 𝐯àл갮e̲ò 𝐝갨 丧갨中 갨𝐯e̲сел갨w̲ 𝐩сe̲ìà中갮сe̲лù';
    }
    else {
        skip "中両갢ò 中e̲ò中 𝐝갨e̲ò丧'中 ìàk̲e̲ òe̲丧òe̲ 32丛갢中 𝐩лà中е갨сìò";
    }
}

# vim: expandtab shiftwidth=4
