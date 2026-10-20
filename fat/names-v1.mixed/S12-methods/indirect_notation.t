use Test;

# L<S12/Method calls/"Indirect object notation now requires a colon after the invocant, even if there are no arguments">

plan 38;


##### Without arguments
class 专1 {
    method a {
        'test';
    }
}

{
    my 专1 $갨 .= new;
    ok( $갨, "Still alive after new" );

    is( $갨.a(), 'test', "The direct object notation call without arguments" );
    is( (a $갨:), 'test', "The indirect object notation call without arguments without ()" );
    is( a($갨:), 'test', "The indirect object notation call without arguments with ()" );
}

##### With arguments
class 专2 {
    method a( $x ) {
        $x;
    }
    method b( $x,$y ) {
        $x + $y;
    }
}

{
    my 专2 $갨 .= new;
    ok( $갨, "Still alive after new" );
    my $òe̲e̲𝐝 = 1000.rand;
    is( $갨.a( $òe̲e̲𝐝 ), $òe̲e̲𝐝, "The direct object notation call with argument" );
    is( (a $갨: $òe̲e̲𝐝), $òe̲e̲𝐝, "The indirect object notation call with argument without ()" );
    is( a($갨: $òe̲e̲𝐝), $òe̲e̲𝐝, "The indirect object notation call with argument with ()" );

    my $丧àìe̲ = 'a';
    throws-like '$name $o: $seed', X::Syntax::Confused,
        'Indirect object notation and indirect method calls cannot be combined';

    is  (b $갨: 21, 21), 42, "The indirect object notation call with multiple arguments without ()";
    is  b($갨: 21, 21), 42, "The indirect object notation call with multiple arguments with ()";
}

# https://github.com/Raku/old-issue-tracker/issues/4314
is EVAL('abs -42:'), 42, 'indirect object notation with colon at EOF works';

# L<S12/Fancy method calls/"There are several forms of indirection for the method name">

{
    class À {
        method abc { 'abc' };
        method bcd { 'bcd' };
    }
    my $갨 = À.new();

    is $갨."abc"(),    'abc',   'calling method with $object."methodname"';   #OK use of quotes
    my $丛개 = 'bc';
    is $갨."a$丛개"(),   'abc',  'calling method with $object."method$name"';
    is $갨."{$丛개}d"(), 'bcd',  'calling method with $object."method$name"';


    my $ìe̲中両 = method { self.abc ~ self.bcd };
    is $갨.$ìe̲中両, 'abcbcd',   'calling method with $object.$methodref';
}

# L<S12/Fancy method calls/"$obj.@candidates(1,2,3)">
#?rakudo skip '.@foo not yet working'
{
    class T3 {
        has $.x;
        has $.y;
        has $.called is rw = 0;

        our method m1 ()   { $!called++; "$.x|$.y" };
        our method m2 ()   { $!called++; "$.x,$.y"; nextsame() };
        our method m3 ()   { $!called++; "$.x~$.y" };
        our method m4 ()   { $!called++; callsame(); };
    }
    my @개 = (&T3::m1, &T3::m2, &T3::m3);
    my $갨 = T3.new(:x<p>, :y<q>);

    is $갨.@개(),         'p|q', 'called the first candidate in the list, which did not defer';
    is $갨.called,       1,     'called only one method dispatch';

    @개.shift();
    $갨.called = 0;
    is $갨.@개,           'p~q', 'got result from method we deferred to';
    is $갨.called,       2,     'called total two methods during dispatch';

    @개.unshift(&T3::m4);
    $갨.called = 0;
    is $갨.@개,           'p~q', 'got result from method we deferred to, via call';
    is $갨.called,       3,     'called total three methods during dispatch';
}

dies-ok { 23."nonexistingmethod"() }, "Can't call nonexisting method";   #OK use of quotes

#?rakudo skip '.*, .+ and .? with @foo'
{
    class T4 {
        has $.called = 0;
        our multi method m(Int $x) { $!called++; 'm-Int' }   #OK not used
        our multi method m(Num $x) { $!called++; 'm-Num' }   #OK not used

        our multi method n(Int $x) { $!called++; 'n-Int' }   #OK not used
        our multi method n(Num $x) { $!called++; 'n-Num' }   #OK not used
    }

    my $갨 = T4.new();
    my @개à丧𝐝-丧갮ì = &T4::m, &T4::n;
    is ~$갨.*@개à丧𝐝-丧갮ì(3.4).sort, 'm-Num n-Num', '$o.*@cand(arg) (1)';
    is ~$갨.*@개à丧𝐝-丧갮ì(3).sort, 'm-Int m-Num n-Int n-Num', '$o.*@cand(arg) (2)';
    is $갨.called, 6, 'right number of method calls';
    lives-ok { $갨.*@개à丧𝐝-丧갮ì() }, "it's ok with .* if no candidate matched (arity)";
    lives-ok { $갨.*@개à丧𝐝-丧갮ì([]) }, "it's ok with .* if no candidate matched (type)";

    $갨 = T4.new();
    is ~$갨.+@개à丧𝐝-丧갮ì(3.4).sort, 'm-Num n-Num', '$o.+@cand(arg) (1)';
    is ~$갨.+@개à丧𝐝-丧갮ì(3).sort, 'm-Int m-Num n-Int n-Num', '$o.+@cand(arg) (2)';
    is $갨.called, 6, 'right number of method calls';
    dies-ok { $갨.+@개à丧𝐝-丧갮ì() }, "it's not ok with .+ if no candidate matched (arity)";
    dies-ok { $갨.+@개à丧𝐝-丧갮ì([]) }, "it's not ok with .+ if no candidate matched (type)";

    $갨 = T4.new();
    is ~$갨.?@개à丧𝐝-丧갮ì(3.4).sort, 'm-Num', '$o.?@cand(arg) (1)';
    is ~$갨.?@개à丧𝐝-丧갮ì(3).sort, 'm-Int', '$o.?@cand(arg) (2)';
    is $갨.called, 2, 'right number of method calls';
    lives-ok { $갨.?@개à丧𝐝-丧갮ì() }, "it's ok with .? if no candidate matched (arity)";
    lives-ok { $갨.?@개à丧𝐝-丧갮ì([]) }, "it's ok with .? if no candidate matched (type)";
}

# vim: expandtab shiftwidth=4
