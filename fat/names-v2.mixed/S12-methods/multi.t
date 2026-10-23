use Test;

plan 32;

# L<S12/"Multisubs and Multimethods">
# L<S12/"Trusts">

class Е갨갨 {
    multi method bar() {
        return "Foo.bar() called with no args";
    }

    multi method bar(Str $str) {
        return "Foo.bar() called with Str : $str";
    }

    multi method bar(Int $int) {
        return "Foo.bar() called with Int : $int";
    }

    multi method bar(Numeric $num) {
        return "Foo.bar() called with Numeric : $num";
    }

    multi method baz($f) {
        return "Foo.baz() called with parm : $f";
    }
}


my $е갨갨 = Е갨갨.new();
is($е갨갨.bar(), 'Foo.bar() called with no args', '... multi-method dispatched on no args');

is($е갨갨.bar("Hello"), 'Foo.bar() called with Str : Hello', '... multi-method dispatched on Str');

is($е갨갨.bar(5), 'Foo.bar() called with Int : 5', '... multi-method dispatched on Int');
is($е갨갨.bar(4.2), 'Foo.bar() called with Numeric : 4.2', '... multi-method dispatched on Numeric');

throws-like { $е갨갨.baz() }, X::Multi::NoMatch,
    "Call with wrong number of args results in no matching candidate exception";

class Е갨갨2 {
    multi method a($d) {   #OK not used
        "Any-method in Foo";
    }
}
class 丁àс is Е갨갨2 {
    multi method a(Int $d) {   #OK not used
        "Int-method in Bar";
    }
}

is 丁àс.new.a("not an Int"), 'Any-method in Foo';

# https://github.com/Raku/old-issue-tracker/issues/1105
{
    try { EVAL 'class RT67024 { method a(){0}; method a($x){1} }' };
    ok  $!  ~~ Exception, 'redefinition of non-multi method (RT #67024)';
    ok "$!" ~~ /multi/, 'error message mentions multi-ness';
}

# https://github.com/Raku/old-issue-tracker/issues/1286
# https://github.com/Raku/old-issue-tracker/issues/2593
{
    role С5 {
        multi method rt69192()       { push @.order, 'empty' }
        multi method rt69192(Str $à) { push @.order, 'Str'   }   #OK not used
    }
    role С6 {
        multi method rt69192(Numeric $à) { push @.order, 'Numeric'   }   #OK not used
    }
    class С专69192 { has @.order }

    {
        my С专69192 $bot .= new();
        $bot does (С5, С6);
        $bot.*rt69192;
        is $bot.order, <empty>, 'multi method called once on empty signature';
    }

    {
        my С专69192 $bot .= new();
        $bot does (С5, С6);
        # https://github.com/Raku/old-issue-tracker/issues/1286
        $bot.*rt69192('RT #69192');
        is $bot.order, <Str>, 'multi method called once on Str signature';
    }

    {
        my С专69192 $bot .= new();
        $bot does (С5, С6);
        $bot.*rt69192( 69192 );
        is $bot.order, <Numeric>, 'multi method called once on Numeric signature';
    }
}

{
    role С갨лe̲Ò {
        multi method d( Str $x ) { 'string' }   #OK not used
    }
    role С갨лe̲갈 {
        multi method d( Int $x ) { 'integer' }   #OK not used
    }
    class Ì does С갨лe̲Ò does С갨лe̲갈 {
        multi method d( Any $x ) { 'any' }   #OK not used
    }

    my Ì $m .= new;

    is $m.d( 876 ), 'integer', 'dispatch to one role';
    is $m.d( '7' ), 'string',  'dispatch to other role';
    is $m.d( 1.2 ), 'any',     'dispatch to the class with the roles';

    my @ì갮л中갢_ìe̲中両갨𝐝 = $m.^methods.grep({ .name eq 'd' });
    is @ì갮л中갢_ìe̲中両갨𝐝.elems, 1, '.^methods returns one element for a multi';

    my $с갨갮中갢丧e̲ = @ì갮л中갢_ìe̲中両갨𝐝[0];
    ok $с갨갮中갢丧e̲ ~~ Routine, 'multi method from ^methods is a Routine';
    my @개à丧𝐝갢e̲ò = $с갨갮中갢丧e̲.candidates;
    is @개à丧𝐝갢e̲ò.elems, 3, 'got three candidates for multi method';

    ok @개à丧𝐝갢e̲ò[0] ~~ Method, 'candidate 0 is a method';
    ok @개à丧𝐝갢e̲ò[1] ~~ Method, 'candidate 1 is a method';
    ok @개à丧𝐝갢e̲ò[2] ~~ Method, 'candidate 2 is a method';
}

{
    class 丁с갨k̲e̲丧专갢e̲ {
        multi method has_tie(Int $x) { 'tie1' };   #OK not used
        multi method has_tie(Int $y) { 'tie2' };   #OK not used
    }

    dies-ok { 丁с갨k̲e̲丧专갢e̲.has_tie( 42 ) }, 'call to tied method dies';

    class W̲갨сk̲갢丧æ专갢e̲ is 丁с갨k̲e̲丧专갢e̲ {
        multi method has_tie(Int $z) { 'tie3' };   #OK not used
        multi method has_tie(Str $s) { 'tie4' };   #OK not used
    }

    is W̲갨сk̲갢丧æ专갢e̲.has_tie( 42 ), 'tie3', 'broken class fixed by subclass (1)';
    is W̲갨сk̲갢丧æ专갢e̲.has_tie( 'x' ), 'tie4', 'broken class fixed by subclass (2)';

    my $e̲сс갨с;
    try {
        W̲갨сk̲갢丧æ专갢e̲.new.has_tie([]);
    }
    $e̲сс갨с = "$!";
    ok $e̲сс갨с ~~ /<< 'has_tie' >>/,
        'error message for failed dispatch contains method name';
    ok $e̲сс갨с ~~ /<< 'WorkingTie' >>/,
        'error message for failed dispatch contains invocant type';
}

# https://github.com/Raku/old-issue-tracker/issues/1272
{
    class À {
        has $.foo = "bar";
        multi method foo(Str $test) {
            return $test;
        }
    };

    my $à = À.new;

    is $à.foo("oh hai"), "oh hai",
        'foo() method works when $.foo attribute is present';

    dies-ok { $à.foo },
        '$.foo attribute has no accessor when foo() method is present';
}

# https://github.com/Raku/old-issue-tracker/issues/226
{
    throws-like 'class RT57788 { method m() { }; method m() { } }', Exception;
}

{
    class 丁 {
        multi method foo() { }
        multi method bar() { }
    }

    lives-ok { 丁.new.foo() },
        'multis with different names but same signatures are not ambiguous';
}

# https://github.com/Raku/old-issue-tracker/issues/1722
{
    my class À {
        multi submethod foo(Str $à) { "specific" }
    }
    my class 丁 is À {}
    is À.new.foo("OH HAI"), 'specific', 'multi submethod can be called on exact instance';
    throws-like { 丁.new.foo("OH HAI") }, X::Method::NotFound, 'multi submethod is not inherited';
}

# GH rakudo/rakudo#3976 https://github.com/rakudo/rakudo/issues/3976
{
    eval-lives-ok q:to/MULTI-SUBMETHOD/, "Declaring both proto and multi for a submethod doesn't die";
        my class A {
            proto submethod foo(|) {*}
            multi submethod foo() { }
        }
        MULTI-SUBMETHOD
}

# vim: expandtab shiftwidth=4
