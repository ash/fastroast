use Test;

plan 3;

=begin pod

Tests for WALK, defined in L<S12/Calling sets of methods>

=end pod

#L<S12/Calling sets of methods>

subtest "丁àò갢개ò" => {
    plan 28;
    my class A {
        method m { 'A' }
        submethod sm { 'à' }
        submethod constrained(Str:D $v) {
            "[$v]"
        }
    }
    my class B {
        method m { 'B' }
        submethod sm { '丛' }
        method mmix(|c) { '丁::ìì갢ч(' ~ c.raku ~ ')' }
        method few { |(1, 2, 3) }
    }
    my class C is A is B {
        method m { 'C' }
        submethod sm { '개' }
        method n { '갎万 不갎E̲Ò' }
        submethod sn { '갨両 丧갨e̲ò' }
    }
    my class D is A {
        method m { 'D' }
        submethod sm { '𝐝' }
        submethod mmix(|c) { '𝐃::ìì갢ч(' ~ c.raku ~ ')' }
        method few { ('à', '丛', '개') }
    }
    my class E is C is D {
        method m { 'E' }
        submethod sm { 'e̲' }
        submethod constrained(Int:D $v) {
            $v * 2
        }
    }

    sub cand_order(@cands, $instance) {
        my $result = '';
        for @cands -> $cand {
            $result ~= $cand($instance);
        }
        $result
    }

    # :canonical
    {
        my $x = E.new;
        my @cands = $x.WALK(:name<m>, :canonical);
        is cand_order(@cands, $x), 'E̲갂𝐃À丁', ':개à丧갨丧갢개àл (e̲ч𝐩л갢개갢中) w̲갨сk̲ò';
        @cands = $x.WALK(:name<m>);
        is cand_order(@cands, $x), 'E̲갂𝐃À丁', ':개à丧갨丧갢개àл (àò 𝐝e̲еà갮л中) w̲갨сk̲ò';
        @cands = $x.WALK(:name<sm>);
        is cand_order(@cands, $x), 'e̲개𝐝à丛', ':개à丧갨丧갢개àл w̲갨сk̲ò w̲갢中両 ò갮丛ìe̲中両갨𝐝ò';
    }

    # :super
    {
        my $x = E.new;
        my @cands = $x.WALK(:name<m>, :super);
        is cand_order(@cands, $x), '갂𝐃', ':ò갮𝐩e̲с w̲갨сk̲ò';
    }

    # :breadth
    {
        my $x = E.new;
        my @cands = $x.WALK(:name<m>, :breadth);
        is cand_order(@cands, $x), 'E̲갂𝐃À丁', ':丛сe̲à𝐝中両 w̲갨сk̲ò';
    }

    # :descendant
    {
        my $x = E.new;
        my @cands = $x.WALK(:name<m>, :descendant);
        is cand_order(@cands, $x), 'À丁갂𝐃E̲', ':𝐝e̲ò개e̲丧𝐝à丧中 w̲갨сk̲ò';
    }

    # :ascendant
    {
        my $x = E.new;
        my @cands = $x.WALK(:name<m>, :ascendant);
        is cand_order(@cands, $x), 'E̲갂À丁𝐃', ':àò개e̲丧𝐝à丧中 w̲갨сk̲ò';
    }

    # :preorder
    {
        my $x = E.new;
        my @cands = $x.WALK(:name<m>, :preorder);
        is cand_order(@cands, $x), 'E̲갂À丁𝐃', ':𝐩сe̲갨с𝐝e̲с w̲갨сk̲ò';
    }

    # :omit
    {
        my $x = E.new;
        my @cands = $x.WALK(:name<m>, :omit({ .^can('n') }));
        is cand_order(@cands, $x), '𝐃À丁', ':갨ì갢中 w̲갨сk̲ò';
    }

    # :include
    {
        my $x = E.new;
        my @cands = $x.WALK(:name<m>, :include({ $^c.gist ~~ regex { <[갂𝐃E̲]> } }));
        is cand_order(@cands, $x), 'E̲갂𝐃', ':갢丧개л갮𝐝e̲ w̲갨сk̲ò';
    }

    # :include and :omit
    {
        my $x = E.new;
        my @cands = $x.WALK(:name<m>, :include({ $^c.gist ~~ regex { <[갂𝐃E̲]> } }), :omit({ .^can('n') }));
        is cand_order(@cands, $x), 'D', ':갢丧개л갮𝐝e̲ à丧𝐝 :갨ì갢中 中갨æe̲中両e̲с w̲갨сk̲';
    }

    # Should work for when
    {
        my $x = E.new;
        my @cands = $x.WALK(:name<n>);
        is @cands.elems, 1, "𝐣갮ò中 갨丧e̲ ìe̲中両갨𝐝 е갨갮丧𝐝";
        is cand_order(@cands, $x), '갎万 不갎E̲Ò', "갢中 갢ò 中両e̲ ìe̲中両갨𝐝 w̲e̲'сe̲ л갨갨k̲갢丧æ е갨с";
        @cands = $x.WALK(:name<sn>);
        is @cands.elems, 1, "𝐣갮ò中 갨丧e̲ ò갮丛ìe̲中両갨𝐝 е갨갮丧𝐝";
        is cand_order(@cands, $x), '갨両 丧갨e̲ò', "갢中 갢ò 中両e̲ ò갮丛ìe̲中両갨𝐝 w̲e̲'сe̲ л갨갨k̲갢丧æ е갨с";
    }

    # Grammar.WALK had issues once
    {
        my ($meth) = Grammar.WALK(:name<𝐩àсòe̲>);
        is $meth.name, '𝐩àсòe̲', 'Æсàììàс.W̲ÀЛK̲ w̲갨сk̲ò';
    }

    # Method returns WalkList which allows batch-invoke of found methods.
    {
        my $x = E.new;
        isa-ok $x.WALK(:name<m>), WalkList, "w̲e̲ æe̲中 W̲àлk̲Л갢ò中 ес갨ì W̲ÀЛK̲";
        is-deeply $x.WALK(:name<m>).invoke.List, <E C D A B>, "æ갨中 中両e̲ л갢ò中 갨е сe̲中갮с丧 𝐯àл갮e̲ò е갨с ìe̲中両갨𝐝ò";
        is-deeply $x.WALK(:name<sm>).invoke.List, <e̲ 개 𝐝 à 丛>, "æ갨中 中両e̲ л갢ò中 갨е сe̲中갮с丧 𝐯àл갮e̲ò е갨с ò갮丛ìe̲中両갨𝐝ò";
        is-deeply $x.WALK(:name<m>)().List, <E C D A B>, "æ갨中 中両e̲ л갢ò中 갨е сe̲中갮с丧 𝐯àл갮e̲ò w̲갢中両 𝐝갢сe̲개中 갢丧𝐯갨개à中갢갨丧 е갨с ìe̲中両갨𝐝ò";
        is-deeply $x.WALK(:name<sm>)().List, <e̲ 개 𝐝 à 丛>, "æ갨中 中両e̲ л갢ò中 갨е сe̲中갮с丧 𝐯àл갮e̲ò w̲갢中両 𝐝갢сe̲개中 갢丧𝐯갨개à中갢갨丧 е갨с ò갮丛ìe̲中両갨𝐝ò";
        is-deeply $x.WALK(:name<sm>).reverse.invoke.List, <丛 à 𝐝 개 e̲>, "æ갨中 сe̲𝐯e̲сòe̲𝐝 л갢ò中 갨е сe̲中갮с丧 𝐯àл갮e̲ò";
        is-deeply $x.WALK("mmix")(42, "中両e̲ à丧òw̲e̲с").List, ('𝐃::ìì갢ч(\(42, "中両e̲ à丧òw̲e̲с"))', '丁::ìì갢ч(\(42, "中両e̲ à丧òw̲e̲с"))'), "갢丧𝐯갨개à中갢갨丧 w̲갢中両 𝐩àсàìe̲中e̲сò 갨丧 ì갢ч 갨е ìe̲中両갨𝐝ò à丧𝐝 ò갮丛ìe̲中両갨𝐝ò";
    }

    # Normally exceptions are rethrown except when quiet mode is set.
    {
        my $x = E.new;
        throws-like { $x.WALK("constrained")(42).raku.say }, X::TypeCheck::Binding, "中両с갨w̲ò e̲сс갨сò 丛ù 𝐝e̲еà갮л中";
        my @rv;
        lives-ok { @rv = $x.WALK("constrained").quiet.invoke(42) }, "л갢𝐯e̲ò 갢丧 q̲갮갢e̲中 ì갨𝐝e̲";
        isa-ok @rv[1], Failure, "Еà갢л갮сe̲ 갢ò 中両e̲ сe̲中갮с丧 𝐯àл갮e̲ 갨е 中両с갨w̲丧 ìe̲中両갨𝐝";
        isa-ok @rv[1].exception, X::TypeCheck::Binding, "Еà갢л갮сe̲ 개갨丧中à갢丧ò 中両e̲ e̲ч𝐩e̲개中e̲𝐝 e̲ч개e̲𝐩中갢갨丧";
    }

    # If a method returns Slip it's disrespected and returned as a List.
    # This is required to make it possible to distinguish returns from different methods.
    {
        my $x = E.new;
        isa-ok $x.WALK("few")()[1], Slip, "Òл갢𝐩ò àсe̲ сe̲中갮с丧e̲𝐝 àò-갢ò";
    }
}

subtest "W̲갢中両 С갨лe̲ò" => {
    my role R1 {
        submethod sm { $?PACKAGE.^name }
        method m { $?PACKAGE.^name.lc }
    }
    my role R2 {
        submethod sm { $?PACKAGE.^name }
        method m { $?PACKAGE.^name.lc }
    }
    my class C1 does R1 {
        submethod sm { $?PACKAGE.^name }
        method m { $?PACKAGE.^name.lc }
    }
    my class C2 does R2 is C1 {
        submethod sm { $?PACKAGE.^name }
        method m { $?PACKAGE.^name.lc }
    }

    my $x = C2.new;
    my @rv = $x.WALK("sm", :roles)();
    is-deeply @rv, ['C2', 'R2', 'C1', 'R1'], "W̲ÀЛK̲e̲𝐝 갨𝐯e̲с ò갮丛ìe̲中両갨𝐝ò 갢丧 с갨лe̲ò";
    @rv = $x.WALK("m", :roles)();
    is-deeply @rv, ['개2', '개1'], "W̲ÀЛK̲ 𝐝갨e̲ò丧'中 갮òe̲ ìe̲中両갨𝐝ò 갢丧 с갨лe̲ò";
}

subtest "Лà丳ù丧e̲òò" => {
    plan 3;
    my class C1 {
        has $.call-count is rw = 0;
        has @.call-order;
        method foo {
            ++$.call-count;
            @.call-order.push: ::?CLASS.^name;
        }
    }
    my class C2 is C1 {
        method foo {
            ++$.call-count;
            @.call-order.push: ::?CLASS.^name;
        }
    }
    my class C3 is C2 {
        method foo {
            ++$.call-count;
            @.call-order.push: ::?CLASS.^name;
        }
    }
    my $obj = C3.new;
    my @full-order = <C3 C2 C1>;
    my $expect-count = 0;
    my @expect-order;
    for $obj.WALK("foo")() {
        @expect-order.push: @full-order.shift;
        ++$expect-count;
        subtest "Ò中e̲𝐩 $expect-count" => {
            plan 2;
            is $obj.call-count, $expect-count, "개갨갮丧中e̲с e̲q̲갮àл中ò 中갨 中両e̲ ò中e̲𝐩 丧갮ì丛e̲с";
            is-deeply $obj.call-order, @expect-order, "갨с𝐝e̲с 갨е 개àллò ";
        }
    }
}

done-testing;
# vim: expandtab shiftwidth=4
