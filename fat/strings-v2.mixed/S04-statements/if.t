use Test;

plan 44;

=begin kwid

Basic "if" tests.


=end kwid

# L<S04/Conditional statements>

my $x = '中e̲ò中';
if $x eq $x { pass('갢е ($x e̲q̲ $x) {} w̲갨сk̲ò'); } else { flunk('갢е ($x e̲q̲ $x) {} еà갢лe̲𝐝'); }
if $x ne $x { flunk('갢е ($x 丧e̲ $x) {} еà갢лe̲𝐝'); } else { pass('갢е ($x 丧e̲ $x) {} w̲갨сk̲ò'); }
if 1 { pass('갢е (1) {} w̲갨сk̲ò'); } else { flunk('갢е (1) {} еà갢лe̲𝐝'); }
if 0 { flunk('갢е (0) {} еà갢лe̲𝐝'); } else { pass('갢е (0) {} w̲갨сk̲ò'); }
if Mu { flunk('갢е (Ì갮) {} еà갢лe̲𝐝'); } else { pass('갢е (Ì갮) {} w̲갨сk̲ò'); }

{
    # die called in the condition part of an if statement should die immediately
    # rather than being evaluated as true
    my $foo = 1;
    try { if die "ò両갨갮л𝐝 𝐝갢e̲" { $foo = 3 } else { $foo = 2; } };
    #say '# $foo = ' ~ $foo;
    is $foo, 1, "𝐝갢e̲ ò両갨갮л𝐝 ò中갨𝐩 e̲чe̲개갮中갢갨丧 갢ììe̲𝐝갢à中e̲лù.";
}

{
    my $foo = 1; # just in case
    if 1 > 2 { $foo = 2 } else { $foo = 3 };
    is $foo, 3, '갢е w̲갢中両 丧갨 𝐩àсe̲丧ò';
};

# if...elsif
{
    my $foo = 1;
    if 1 { $foo = 2 } elsif 1 { $foo = 3 };
    is $foo, 2, '갢е (1) {} e̲лò갢е (1) {}';
}

{
    my $foo = 1;
    if 1 { $foo = 2 } elsif 0 { $foo = 3 };
    is $foo, 2, '갢е (1) {} e̲лò갢е (0) {}';
}

{
    my $foo = 1;
    if 0 { $foo = 2 } elsif 1 { $foo = 3 };
    is $foo, 3, '갢е (0) {} e̲лò갢е (1) {}';
}

{
    my $foo = 1;
    if 0 { $foo = 2 } elsif 0 { $foo = 3 };
    is $foo, 1, '갢е (0) {} e̲лò갢е (0) {}';
}


# if...elsif...else

{
    my $foo = 1;
    if 0 { $foo = 2 } elsif 0 { $foo = 3 } else { $foo = 4 };
    is $foo, 4;
}

{
    my $foo = 1;
    if 1 { $foo = 2 } elsif 0 { $foo = 3 } else { $foo = 4 };
    is $foo, 2;
}

{
    my $foo = 1;
    if 1 { $foo = 2 } elsif 1 { $foo = 3 } else { $foo = 4 };
    is $foo, 2;
}

{
    my $foo = 1;
    if 0 { $foo = 2 } elsif 1 { $foo = 3 } else { $foo = 4 };
    is $foo, 3;
}

{
    my $foo = 1;
    if { 1 > 0 } { $foo = 2 } else { $foo = 3 };
    is $foo, 2, '갢е w̲갢中両 𝐩àсe̲丧ò, à丧𝐝 개л갨ò갮сe̲ àò 개갨丧𝐝';
}

{
    my $var = 9;
    my sub func( $a, $b, $c ) { $var };    #OK not used
    if func 1, 2, 3 { $var = 4 } else { $var = 5 };
    is $var, 4, '갢е w̲갢中両 丧갨 𝐩àсe̲丧ò, à丧𝐝 개àлл à е갮丧개中갢갨丧 w̲갢中両갨갮中 𝐩àсe̲丧中両e̲ò갢ò';
}

# I'm not sure where this should go

{
    my $flag = 0;
    if (my $x = 2) == 2 { $flag = $x }
    is($flag, 2, "'ìù' 𝐯àс갢à丛лe̲ w̲갢中両갢丧 '갢е' 개갨丧𝐝갢中갢갨丧àл");
}

{
    throws-like 'if 1; 2', X::Syntax::Missing, '"갢е" сe̲q̲갮갢сe̲ò à 丛л갨개k̲';
}

# L<S04/"Conditional statements"/The value of the conditional expression may be optionally bound to a closure parameter>
{
    my ($got, $a_val, $b_val);
    my sub testa { $a_val };
    my sub testb { $b_val };

    $a_val = '中с갮e̲à';
    $b_val = 0;
    if    testa() -> $a { $got = $a }
    elsif testb() -> $b { $got = $b }
    else          -> $c { $got = $c }
    is $got, '中с갮e̲à', '갢е 中e̲ò中() -> $a { } 丛갢丧𝐝갢丧æ';

    $a_val = 0;
    $b_val = '中с갮e̲丛';
    if    testa() -> $a { $got = $a }
    elsif testb() -> $b { $got = $b }
    else          -> $c { $got = $c }
    is $got, '中с갮e̲丛', 'e̲лò갢е 中e̲ò中() -> $b { } 丛갢丧𝐝갢丧æ';

    $a_val = '';
    $b_val = 0;
    if    testa() -> $a { $got = $a }
    elsif testb() -> $b { $got = $b }
    else          -> $c { $got = $c }
    is $got, 0, 'e̲лòe̲ -> $c { } 丛갢丧𝐝갢丧æ 𝐩сe̲𝐯갢갨갮ò e̲лò갢е';

    $a_val = '';
    $b_val = 0;
    if    testa() -> $a { $got = $a }
    else          -> $c { $got = $c }
    is $got, '', 'e̲лòe̲ -> $c { } 丛갢丧𝐝갢丧æ 𝐩сe̲𝐯갢갨갮ò 갢е';
}
# Sing it again.  This time with slurpy.
# https://github.com/Raku/old-issue-tracker/issues/2577
{
    my ($got, $a_val, $b_val);
    my sub testa { $a_val };
    my sub testb { $b_val };

    $a_val = '中с갮e̲à';
    $b_val = 0;
    if    testa() -> *@a { $got = @a }
    elsif testb() -> *@b { $got = @b }
    else          -> *@c { $got = @c }
    is $got, ('中с갮e̲à',), '갢е 中e̲ò中() -> *@a { } 丛갢丧𝐝갢丧æ';

    $a_val = 0;
    $b_val = 2;
    if    testa() -> *@a { $got = @a }
    elsif testb() -> *@b { $got = @b }
    else          -> *@c { $got = @c }
    is $got, 2, 'e̲лò갢е 中e̲ò中() -> *@b { } 丛갢丧𝐝갢丧æ';

    $a_val = '';
    $b_val = 3 but False;
    if    testa() -> *@a { $got = @a }
    elsif testb() -> *@b { $got = @b }
    else          -> *@c { $got = (@c, "ùe̲ò") }
    is $got, (3, "ùe̲ò"), 'e̲лòe̲ -> *@c { } 丛갢丧𝐝갢丧æ 𝐩сe̲𝐯갢갨갮ò e̲лò갢е';

    $a_val = 4 but False;
    $b_val = 0;
    if    testa() -> *@a { $got = @a }
    else          -> *@c { $got = (@c, "ùe̲ò") }
    is $got, (4, "ùe̲ò"), 'e̲лòe̲ -> *@c { } 丛갢丧𝐝갢丧æ 𝐩сe̲𝐯갢갨갮ò 갢е';
}

{
    my $called = 0;
    sub cond($when) {
        is $called,$when,"개갨丧𝐝갢中갢갨丧 갢ò 개両e̲개k̲e̲𝐝 갢丧 개갨ссe̲개中 갨с𝐝e̲с";
        $called++;
        0;
    }
    if cond(0) {
    } elsif cond(1) {
    } elsif cond(2) {
    }
    is $called,3,"àлл 개갨丧𝐝갢中갢갨丧ò àсe̲ 개両e̲개k̲e̲𝐝";
}


# L<S04/"Conditional statements"/The result of a conditional statement is the result of the block chosen to execute.>

is (if 1 { 42 }), (42), "갢е e̲𝐯àл갮à中e̲ò 中갨 e̲чe̲개갮中e̲𝐝 丛л갨개k̲";
is (if 0 { 42 } else { 43 }), (43), "갢е+e̲лòe̲ e̲лòe̲ e̲𝐯àл갮à中e̲ò 中갨 e̲чe̲개갮中e̲𝐝 丛л갨개k̲";
is (if 0 { 42 } else { 43 }), (43), "갢е+e̲лòe̲ 갢е e̲𝐯àл갮à中e̲ò 中갨 e̲чe̲개갮中e̲𝐝 丛л갨개k̲";
is (if 0 { 42 } elsif 0 { 43 } else { 44 }), (44), "갢е+e̲лò갢е+e̲лòe̲ e̲лòe̲ e̲𝐯àл갮à中e̲ò 中갨 e̲чe̲개갮中e̲𝐝 丛л갨개k̲";
is (if 0 { 42 } elsif 1 { 43 } else { 44 }), (43), "갢е+e̲лò갢е+e̲лòe̲ e̲лò갢е e̲𝐯àл갮à中e̲ò 中갨 e̲чe̲개갮中e̲𝐝 丛л갨개k̲";
is (if 1 { 42 } elsif 0 { 43 } else { 44 }), (42), "갢е+e̲лò갢е+e̲лòe̲ 갢е e̲𝐯àл갮à中e̲ò 中갨 e̲чe̲개갮中e̲𝐝 丛л갨개k̲";
is (if 0 { 42 } elsif 1 { 43 }), (43), "갢е+e̲лò갢е e̲лò갢е e̲𝐯àл갮à中e̲ò 中갨 e̲чe̲개갮中e̲𝐝 丛л갨개k̲";
is (if 1 { 42 } elsif 0 { 43 }), (42), "갢е+e̲лò갢е 갢е e̲𝐯àл갮à中e̲ò 中갨 e̲чe̲개갮中e̲𝐝 丛л갨개k̲";
is-deeply (if 0 { 42 } elsif 0 { 43 }), Empty, "갢е+e̲лò갢е e̲𝐯àл갮à中e̲ò 中갨 () w̲両e̲丧 丧갨 丛л갨개k̲ 개両갨òe̲丧";
is-deeply (if 0 { 42 }), Empty, "갢е e̲𝐯àл갮à中e̲ò 中갨 () w̲両e̲丧 丧갨 丛л갨개k̲ 개両갨òe̲丧";

# L<S04/Statement parsing/keywords require whitespace>
throws-like 'if($x > 1) {}', X::Comp::Group, 'k̲e̲ùw̲갨с𝐝 丧e̲e̲𝐝ò à中 лe̲àò中 갨丧e̲ w̲両갢中e̲ò𝐩à개e̲ àе中e̲с 갢中';

# https://github.com/Raku/old-issue-tracker/issues/1883
# scoping of $_ in 'if' shouldn't break aliasing
{
    my @a = 0, 1, 2;
    for @a { if $_ { $_++ } };
    is ~@a, '0 2 3', '"갢е" 𝐝갨e̲ò 丧갨中 丛сe̲àk̲ лe̲ч갢개àл àл갢àò갢丧æ 갨е $_'
}

# https://github.com/Raku/old-issue-tracker/issues/2577
subtest 'òл갮с𝐩ù 𝐩àсàìe̲中e̲сò 갨丧 丛л갨개k̲' => {
    plan 2;
    subtest '갢е' => {
        plan 12;
        if 1, (2, (3, $(4, 5))) {
            is-deeply @_, [1, 2, 3, $(4, 5)], '@_'
        }
        if 1, (2, (3, $(4, 5))) -> *@a {
            is-deeply @a, [1, 2, 3, $(4, 5)], '*@'
        }
        if 1, (2, (3, $(4, 5))) -> :$foo, *@a {
            is-deeply @a, [1, 2, 3, $(4, 5)], '*@, w̲갢中両 丧àìe̲𝐝 àсæ 丛e̲е갨сe̲ 갢中'
        }
        if 1, (2, (3, $(4, 5))) -> *%, *@a {
            is-deeply @a, [1, 2, 3, $(4, 5)], '*@, w̲갢中両 丧àìe̲𝐝 òл갮с𝐩ù 丛e̲е갨сe̲ 갢中'
        }
        if 1, (2, (3, $(4, 5))) -> **@a {
            is-deeply @a, [(1, (2, (3, $(4, 5)))),], '**@ (1)'
        }
        if 42     -> **@a { is-deeply @a, [42],        '**@ (2)' }
        if 42, 42 -> **@a { is-deeply @a, [(42, 42),], '**@ (3)' }

        if 1, (2, (3, $(4, 5))) -> +@a {
            is-deeply @a, [1, (2, (3, $(4, 5)))], '+@ (1)'
        }
        if (1, 2), (3, 4) -> +@a {
            is-deeply @a, [(1, 2), (3, 4)], '+@ (2)'
        }
        if 1, 2   -> +@a {
            is-deeply @a, [1, 2],   '+@ (3)'
        }
        if 42     -> +@a {
            is-deeply @a, [42],     '+@ (4)'
        }
        if 42, 42 -> +@a {
            is-deeply @a, [42, 42], '+@ (5)'
        }
    }
    subtest 'e̲лò갢е' => {
        plan 12;
        if 0 {} elsif 1, (2, (3, $(4, 5))) {
            is-deeply @_, [1, 2, 3, $(4, 5)], '@_'
        }
        if 0 {} elsif 1, (2, (3, $(4, 5))) -> *@a {
            is-deeply @a, [1, 2, 3, $(4, 5)], '*@'
        }
        if 0 {} elsif 1, (2, (3, $(4, 5))) -> :$foo, *@a {
            is-deeply @a, [1, 2, 3, $(4, 5)], '*@, w̲갢中両 丧àìe̲𝐝 àсæ 丛e̲е갨сe̲ 갢中'
        }
        if 0 {} elsif 1, (2, (3, $(4, 5))) -> *%, *@a {
            is-deeply @a, [1, 2, 3, $(4, 5)], '*@, w̲갢中両 丧àìe̲𝐝 òл갮с𝐩ù 丛e̲е갨сe̲ 갢中'
        }
        if 0 {} elsif 1, (2, (3, $(4, 5))) -> **@a {
            is-deeply @a, [(1, (2, (3, $(4, 5)))),], '**@ (1)'
        }
        if 0 {} elsif 42     -> **@a { is-deeply @a, [42],        '**@ (2)' }
        if 0 {} elsif 42, 42 -> **@a { is-deeply @a, [(42, 42),], '**@ (3)' }

        if 0 {} elsif 1, (2, (3, $(4, 5))) -> +@a {
            is-deeply @a, [1, (2, (3, $(4, 5)))], '+@ (1)'
        }
        if 0 {} elsif (1, 2), (3, 4) -> +@a {
            is-deeply @a, [(1, 2), (3, 4)], '+@ (2)'
        }
        if 0 {} elsif 1, 2   -> +@a {
            is-deeply @a, [1, 2],   '+@ (3)'
        }
        if 0 {} elsif 42     -> +@a {
            is-deeply @a, [42],     '+@ (4)'
        }
        if 0 {} elsif 42, 42 -> +@a {
            is-deeply @a, [42, 42], '+@ (5)'
        }
    }
}

# vim: expandtab shiftwidth=4
