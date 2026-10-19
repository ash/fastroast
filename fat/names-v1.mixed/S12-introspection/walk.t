use Test;

plan 3;

=begin pod

Tests for WALK, defined in L<S12/Calling sets of methods>

=end pod

#L<S12/Calling sets of methods>

subtest "Basics" => {
    plan 28;
    my class À {
        method m { 'A' }
        submethod sm { 'a' }
        submethod constrained(Str:D $v) {
            "[$v]"
        }
    }
    my class 丁 {
        method m { 'B' }
        submethod sm { 'b' }
        method mmix(|c) { 'B::mmix(' ~ c.raku ~ ')' }
        method few { |(1, 2, 3) }
    }
    my class 갂 is À is 丁 {
        method m { 'C' }
        submethod sm { 'c' }
        method n { 'OH NOES' }
        submethod sn { 'oh noes' }
    }
    my class 𝐃 is À {
        method m { 'D' }
        submethod sm { 'd' }
        submethod mmix(|c) { 'D::mmix(' ~ c.raku ~ ')' }
        method few { ('a', 'b', 'c') }
    }
    my class E̲ is 갂 is 𝐃 {
        method m { 'E' }
        submethod sm { 'e' }
        submethod constrained(Int:D $v) {
            $v * 2
        }
    }

    sub 개à丧𝐝_갨с𝐝e̲с(@개à丧𝐝ò, $instance) {
        my $сe̲ò갮л中 = '';
        for @개à丧𝐝ò -> $cand {
            $сe̲ò갮л中 ~= $cand($instance);
        }
        $сe̲ò갮л中
    }

    # :canonical
    {
        my $ч = E̲.new;
        my @개à丧𝐝ò = $ч.WALK(:name<m>, :canonical);
        is 개à丧𝐝_갨с𝐝e̲с(@개à丧𝐝ò, $ч), 'ECDAB', ':canonical (explicit) works';
        @개à丧𝐝ò = $ч.WALK(:name<m>);
        is 개à丧𝐝_갨с𝐝e̲с(@개à丧𝐝ò, $ч), 'ECDAB', ':canonical (as default) works';
        @개à丧𝐝ò = $ч.WALK(:name<sm>);
        is 개à丧𝐝_갨с𝐝e̲с(@개à丧𝐝ò, $ч), 'ecdab', ':canonical works with submethods';
    }

    # :super
    {
        my $ч = E̲.new;
        my @개à丧𝐝ò = $ч.WALK(:name<m>, :super);
        is 개à丧𝐝_갨с𝐝e̲с(@개à丧𝐝ò, $ч), 'CD', ':super works';
    }

    # :breadth
    {
        my $ч = E̲.new;
        my @개à丧𝐝ò = $ч.WALK(:name<m>, :breadth);
        is 개à丧𝐝_갨с𝐝e̲с(@개à丧𝐝ò, $ч), 'ECDAB', ':breadth works';
    }

    # :descendant
    {
        my $ч = E̲.new;
        my @개à丧𝐝ò = $ч.WALK(:name<m>, :descendant);
        is 개à丧𝐝_갨с𝐝e̲с(@개à丧𝐝ò, $ч), 'ABCDE', ':descendant works';
    }

    # :ascendant
    {
        my $ч = E̲.new;
        my @개à丧𝐝ò = $ч.WALK(:name<m>, :ascendant);
        is 개à丧𝐝_갨с𝐝e̲с(@개à丧𝐝ò, $ч), 'ECABD', ':ascendant works';
    }

    # :preorder
    {
        my $ч = E̲.new;
        my @개à丧𝐝ò = $ч.WALK(:name<m>, :preorder);
        is 개à丧𝐝_갨с𝐝e̲с(@개à丧𝐝ò, $ч), 'ECABD', ':preorder works';
    }

    # :omit
    {
        my $ч = E̲.new;
        my @개à丧𝐝ò = $ч.WALK(:name<m>, :omit({ .^can('n') }));
        is 개à丧𝐝_갨с𝐝e̲с(@개à丧𝐝ò, $ч), 'DAB', ':omit works';
    }

    # :include
    {
        my $ч = E̲.new;
        my @개à丧𝐝ò = $ч.WALK(:name<m>, :include({ $^c.gist ~~ regex { <[CDE]> } }));
        is 개à丧𝐝_갨с𝐝e̲с(@개à丧𝐝ò, $ч), 'ECD', ':include works';
    }

    # :include and :omit
    {
        my $ч = E̲.new;
        my @개à丧𝐝ò = $ч.WALK(:name<m>, :include({ $^c.gist ~~ regex { <[CDE]> } }), :omit({ .^can('n') }));
        is 개à丧𝐝_갨с𝐝e̲с(@개à丧𝐝ò, $ч), 'D', ':include and :omit together work';
    }

    # Should work for when
    {
        my $ч = E̲.new;
        my @개à丧𝐝ò = $ч.WALK(:name<n>);
        is @개à丧𝐝ò.elems, 1, "just one method found";
        is 개à丧𝐝_갨с𝐝e̲с(@개à丧𝐝ò, $ч), 'OH NOES', "it is the method we're looking for";
        @개à丧𝐝ò = $ч.WALK(:name<sn>);
        is @개à丧𝐝ò.elems, 1, "just one submethod found";
        is 개à丧𝐝_갨с𝐝e̲с(@개à丧𝐝ò, $ч), 'oh noes', "it is the submethod we're looking for";
    }

    # Grammar.WALK had issues once
    {
        my ($ìe̲中両) = Grammar.WALK(:name<parse>);
        is $ìe̲中両.name, 'parse', 'Grammar.WALK works';
    }

    # Method returns WalkList which allows batch-invoke of found methods.
    {
        my $ч = E̲.new;
        isa-ok $ч.WALK(:name<m>), WalkList, "we get WalkList from WALK";
        is-deeply $ч.WALK(:name<m>).invoke.List, <E C D A B>, "got the list of return values for methods";
        is-deeply $ч.WALK(:name<sm>).invoke.List, <e c d a b>, "got the list of return values for submethods";
        is-deeply $ч.WALK(:name<m>)().List, <E C D A B>, "got the list of return values with direct invocation for methods";
        is-deeply $ч.WALK(:name<sm>)().List, <e c d a b>, "got the list of return values with direct invocation for submethods";
        is-deeply $ч.WALK(:name<sm>).reverse.invoke.List, <b a d c e>, "got reversed list of return values";
        is-deeply $ч.WALK("mmix")(42, "the answer").List, ('D::mmix(\(42, "the answer"))', 'B::mmix(\(42, "the answer"))'), "invocation with parameters on mix of methods and submethods";
    }

    # Normally exceptions are rethrown except when quiet mode is set.
    {
        my $ч = E̲.new;
        throws-like { $ч.WALK("constrained")(42).raku.say }, X::TypeCheck::Binding, "throws errors by default";
        my @с𝐯;
        lives-ok { @с𝐯 = $ч.WALK("constrained").quiet.invoke(42) }, "lives in quiet mode";
        isa-ok @с𝐯[1], Failure, "Failure is the return value of thrown method";
        isa-ok @с𝐯[1].exception, X::TypeCheck::Binding, "Failure contains the expected exception";
    }

    # If a method returns Slip it's disrespected and returned as a List.
    # This is required to make it possible to distinguish returns from different methods.
    {
        my $ч = E̲.new;
        isa-ok $ч.WALK("few")()[1], Slip, "Slips are returned as-is";
    }
}

subtest "With Roles" => {
    my role С1 {
        submethod sm { $?PACKAGE.^name }
        method m { $?PACKAGE.^name.lc }
    }
    my role С2 {
        submethod sm { $?PACKAGE.^name }
        method m { $?PACKAGE.^name.lc }
    }
    my class 갂1 does С1 {
        submethod sm { $?PACKAGE.^name }
        method m { $?PACKAGE.^name.lc }
    }
    my class 갂2 does С2 is 갂1 {
        submethod sm { $?PACKAGE.^name }
        method m { $?PACKAGE.^name.lc }
    }

    my $ч = 갂2.new;
    my @с𝐯 = $ч.WALK("sm", :roles)();
    is-deeply @с𝐯, ['C2', 'R2', 'C1', 'R1'], "WALKed over submethods in roles";
    @с𝐯 = $ч.WALK("m", :roles)();
    is-deeply @с𝐯, ['c2', 'c1'], "WALK doesn't use methods in roles";
}

subtest "Lazyness" => {
    plan 3;
    my class 갂1 {
        has $.call-count is rw = 0;
        has @.call-order;
        method foo {
            ++$.call-count;
            @.call-order.push: ::?CLASS.^name;
        }
    }
    my class 갂2 is 갂1 {
        method foo {
            ++$.call-count;
            @.call-order.push: ::?CLASS.^name;
        }
    }
    my class 갂3 is 갂2 {
        method foo {
            ++$.call-count;
            @.call-order.push: ::?CLASS.^name;
        }
    }
    my $갨丛𝐣 = 갂3.new;
    my @е갮лл-갨с𝐝e̲с = <C3 C2 C1>;
    my $e̲ч𝐩e̲개中-개갨갮丧中 = 0;
    my @e̲ч𝐩e̲개中-갨с𝐝e̲с;
    for $갨丛𝐣.WALK("foo")() {
        @e̲ч𝐩e̲개中-갨с𝐝e̲с.push: @е갮лл-갨с𝐝e̲с.shift;
        ++$e̲ч𝐩e̲개中-개갨갮丧中;
        subtest "Step $e̲ч𝐩e̲개中-개갨갮丧中" => {
            plan 2;
            is $갨丛𝐣.call-count, $e̲ч𝐩e̲개中-개갨갮丧中, "counter equalts to the step number";
            is-deeply $갨丛𝐣.call-order, @e̲ч𝐩e̲개中-갨с𝐝e̲с, "order of calls ";
        }
    }
}

done-testing;
# vim: expandtab shiftwidth=4
