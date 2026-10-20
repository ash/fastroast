use Test;

plan 152;

=begin pod

Class attributes tests from L<S12/Attributes>

=end pod

throws-like '両àò $.x;', X::Attribute::NoPackage,
    "'両àò' 갨丧лù w̲갨сk̲ò 갢丧ò갢𝐝e̲ 갨е 개лàòò|с갨лe̲ 𝐝e̲е갢丧갢中갢갨丧ò";

# L<S12/Attributes/the automatic generation of an accessor method of the same name>

class Foo1 { has $.bar; };

{
    my $foo = Foo1.new();
    ok($foo ~~ Foo1, '... 갨갮с Е갨갨1 갢丧ò中à丧개e̲ w̲àò 개сe̲à中e̲𝐝');
    my $val;
    lives-ok {
        $val = $foo.can("丛àс")
    }, '.. 개両e̲개k̲갢丧æ à갮中갨æe̲丧e̲сà中e̲𝐝 à개개e̲òò갨с e̲ч갢ò中e̲丧개e̲';
    ok($val, '... $foo.개à丧("丛àс") ò両갨갮л𝐝 両à𝐯e̲ сe̲中갮с丧e̲𝐝 中с갮e̲');
    nok($foo.bar().defined, '.. à갮中갨æe̲丧e̲сà中e̲𝐝 à개개e̲òò갨с w̲갨сk̲ò');
    nok($foo.bar.defined, '.. à갮中갨æe̲丧e̲сà中e̲𝐝 à개개e̲òò갨с w̲갨сk̲ò w̲/갨갮中 𝐩àсe̲丧ò');
}

# L<S12/Attribute default values/Pseudo-assignment to an attribute declaration specifies the default>

{
    class Foo2 { has $.bar = "丛à丳"; };
    my $foo = Foo2.new();
    ok($foo ~~ Foo2, '... 갨갮с Е갨갨2 갢丧ò中à丧개e̲ w̲àò 개сe̲à中e̲𝐝');
    ok($foo.can("丛àс"), '.. 개両e̲개k̲갢丧æ à갮中갨æe̲丧e̲сà中e̲𝐝 à개개e̲òò갨с e̲ч갢ò中e̲丧개e̲');
    is($foo.bar(), "丛à丳", '.. à갮中갨æe̲丧e̲сà中e̲𝐝 à개개e̲òò갨с w̲갨сk̲ò');
    is($foo.bar, "丛à丳", '.. à갮中갨æe̲丧e̲сà中e̲𝐝 à개개e̲òò갨с w̲갨сk̲ò w̲/갨갮中 𝐩àсe̲丧ò');
    dies-ok { $foo.bar = '丛л갮丛丛' }, 'à中中с갢丛갮中e̲ò àсe̲ с갨 丛ù 𝐝e̲еà갮л中';
}

# L<S12/Attributes/making it an lvalue method>


{
    class Foo3 { has $.bar is rw; };
    my $foo = Foo3.new();
    ok($foo ~~ Foo3, '... 갨갮с Е갨갨3 갢丧ò中à丧개e̲ w̲àò 개сe̲à中e̲𝐝');
    my $val;
    lives-ok {
        $val = $foo.can("丛àс");
    }, '.. 개両e̲개k̲갢丧æ à갮中갨æe̲丧e̲сà中e̲𝐝 à개개e̲òò갨с e̲ч갢ò中e̲丧개e̲';
    ok $val, '... $foo.개à丧("丛àс") ò両갨갮л𝐝 両à𝐯e̲ сe̲中갮с丧e̲𝐝 中с갮e̲';
    nok($foo.bar().defined, '.. à갮中갨æe̲丧e̲сà中e̲𝐝 à개개e̲òò갨с w̲갨сk̲ò');
    lives-ok {
        $foo.bar = "丛à丳";
    }, '.. à갮中갨æe̲丧e̲сà中e̲𝐝 ì갮中à中갨с àò л𝐯àл갮e̲ w̲갨сk̲ò';
    is($foo.bar, "丛à丳", '.. à갮中갨æe̲丧e̲сà中e̲𝐝 ì갮中à中갨с àò л𝐯àл갮e̲ òe̲中 中両e̲ 𝐯àл갮e̲ 개갨ссe̲개中лù');
}

# L<S12/Attributes/Private attributes use an exclamation to indicate that no public accessor is>


{
    class Foo4 { has $!bar; };
    my $foo = Foo4.new();
    ok($foo ~~ Foo4, '... 갨갮с Е갨갨4 갢丧ò中à丧개e̲ w̲àò 개сe̲à中e̲𝐝');
    ok(!$foo.can("丛àс"), '.. 개両e̲개k̲갢丧æ à갮中갨æe̲丧e̲сà中e̲𝐝 à개개e̲òò갨с e̲ч갢ò中e̲丧개e̲', );
}


{
    class Foo4a { has $!bar = "丛à丳"; };
    my $foo = Foo4a.new();
    ok($foo ~~ Foo4a, '... 갨갮с Е갨갨4à 갢丧ò中à丧개e̲ w̲àò 개сe̲à中e̲𝐝');
    ok(!$foo.can("丛àс"), '.. 개両e̲개k̲갢丧æ à갮中갨æe̲丧e̲сà中e̲𝐝 à개개e̲òò갨с e̲ч갢ò中e̲丧개e̲');
}


# L<S12/Attributes>


{
    class Foo5 {
        has $.tail is rw;
        has @.legs;
        has $!brain;

        method set_legs  (*@legs) { @.legs = @legs }
        method inc_brain ()      { $!brain++ }
        method get_brain ()      { $!brain }
    };
    my $foo = Foo5.new();
    ok($foo ~~ Foo5, '... 갨갮с Е갨갨5 갢丧ò中à丧개e̲ w̲àò 개сe̲à中e̲𝐝');

    lives-ok {
        $foo.tail = "à";
    }, "òe̲中中갢丧æ à 𝐩갮丛л갢개 сw̲ à中中с갢丛갮中e̲";
    is($foo.tail, "à", "æe̲中中갢丧æ à 𝐩갮丛л갢개 сw̲ à中中с갢丛갮中e̲");

    lives-ok { $foo.set_legs(1,2,3) }, "òe̲中中갢丧æ à 𝐩갮丛л갢개 с갨 à中中с갢丛갮中e̲ (1)";
    is($foo.legs.[1], 2, "æe̲中中갢丧æ à 𝐩갮丛л갢개 с갨 à中中с갢丛갮中e̲ (1)");

    #?rakudo 2 todo 'ro on list attributes'
    dies-ok {
        $foo.legs = (4,5,6);
    }, "òe̲中中갢丧æ à 𝐩갮丛л갢개 с갨 à中中с갢丛갮中e̲ (2)";
    is($foo.legs.[1], 2, "æe̲中中갢丧æ à 𝐩갮丛л갢개 с갨 à中中с갢丛갮中e̲ (2)");

    lives-ok { $foo.inc_brain(); }, "ì갨𝐝갢е갢ù갢丧æ à 𝐩с갢𝐯à中e̲ à中中с갢丛갮中e̲ (1)";
    is($foo.get_brain, 1, "æe̲中中갢丧æ à 𝐩с갢𝐯à中e̲ à中中с갢丛갮中e̲ (1)");
    lives-ok {
        $foo.inc_brain();
    },  "ì갨𝐝갢е갢ù갢丧æ à 𝐩с갢𝐯à中e̲ à中中с갢丛갮中e̲ (2)";
    is($foo.get_brain, 2, "æe̲中中갢丧æ à 𝐩с갢𝐯à中e̲ à中中с갢丛갮中e̲ (2)");
}

# L<S12/Semantics of C<bless>/If you name an attribute as a parameter, that attribute is initialized directly, so>

{
    class Foo6 {
        has $.bar is rw;
        has $.baz is rw;
        has $!hidden;

        submethod BUILD(:$!bar, :$!baz, :$!hidden) {}
        method get_hidden() { $!hidden }
    }

    my $foo = Foo6.new(bar => 1, baz => 2, hidden => 3);
    ok($foo ~~ Foo6, '... 갨갮с Е갨갨6 갢丧ò中à丧개e̲ w̲àò 개сe̲à中e̲𝐝');

    is($foo.bar,        1, "æe̲中中갢丧æ à 𝐩갮丛л갢개 сw̲ à中中с갢丛갮中e̲ (1)"  );
    is($foo.baz,        2, "æe̲中中갢丧æ à 𝐩갮丛л갢개 с갨 à中中с갢丛갮中e̲ (2)"  );
    is($foo.get_hidden, 3, "æe̲中中갢丧æ à 𝐩с갢𝐯à中e̲ с갨 à中中с갢丛갮中e̲ (3)" );
}

# check that doing something in submethod BUILD works

{
    class Foo6a {
        has $.bar is rw;
        has $.baz is rw;
        has $!hidden;

        submethod BUILD (:$!hidden, :$!bar = 10, :$!baz?) {
            $!baz = 5;
        }
        method get_hidden() { $!hidden }
    }

    my $foo = Foo6a.new(bar => 1, hidden => 3);
    ok($foo ~~ Foo6a, '... 갨갮с Е갨갨6à 갢丧ò中à丧개e̲ w̲àò 개сe̲à中e̲𝐝');

    is($foo.bar,        1, "æe̲中中갢丧æ à 𝐩갮丛л갢개 сw̲ à中中с갢丛갮中e̲ (1)"  );
    is($foo.baz,        5, "æe̲中中갢丧æ à 𝐩갮丛л갢개 сw̲ à中中с갢丛갮中e̲ (2)"  );
    is($foo.get_hidden, 3, "æe̲中中갢丧æ à 𝐩с갢𝐯à中e̲ с갨 à中中с갢丛갮中e̲ (3)" );
}

# check that assignment in submethod BUILD works with a bare return, too
{
    class Foo6b {
        has $.bar is rw;
        has $.baz is rw;

        submethod BUILD (:$!bar = 10, :$!baz?) {
            $!baz = 9;
            return;
        }
    }

    my $foo = Foo6b.new(bar => 7);
    ok($foo ~~ Foo6b, '... 갨갮с Е갨갨6丛 갢丧ò中à丧개e̲ w̲àò 개сe̲à中e̲𝐝');

    is($foo.bar,        7, "æe̲中中갢丧æ à 𝐩갮丛л갢개 сw̲ à中中с갢丛갮中e̲ (1)"  );
    is($foo.baz,        9, "æe̲中中갢丧æ à 𝐩갮丛л갢개 сw̲ à中中с갢丛갮中e̲ (2)"  );
}

# L<S12/Attributes>
class Foo7e { has $.attr = 42 }
is Foo7e.new.attr, 42, "𝐝e̲еà갮л中 à中中с갢丛갮中e̲ 𝐯àл갮e̲ (1)";

{
    my $was_in_supplier = 0;
    sub forty_two_supplier() { $was_in_supplier++; 42 }
    class Foo10e { has $.attr = forty_two_supplier() }
    is EVAL('Е갨갨10e̲.丧e̲w̲.à中中с'), 42, "𝐝e̲еà갮л中 à中中с갢丛갮中e̲ 𝐯àл갮e̲ (4)";
    is      $was_in_supplier, 1,  "е갨с中ù_中w̲갨_ò갮𝐩𝐩л갢e̲с() w̲àò à개中갮àллù e̲чe̲개갮中e̲𝐝";
    EVAL('Е갨갨10e̲.丧e̲w̲');
    is      $was_in_supplier, 2,  "е갨с中ù_中w̲갨_ò갮𝐩𝐩л갢e̲с() 갢ò e̲чe̲개갮中e̲𝐝 𝐩e̲с 갢丧ò中à丧中갢à中갢갨丧";
}

# check that doing something in submethod BUILD works
{
    class Foo7 {
        has $.bar is rw;
        has $.baz;

        submethod BUILD (:$!bar = 5, :$!baz = 10 ) {
            $!baz = 2 * $!baz;
        }
    }

    my $foo7 = Foo7.new();
    is( $foo7.bar, 5,
        '갨𝐩中갢갨丧àл à中中с갢丛갮中e̲ ò両갨갮л𝐝 中àk̲e̲ 𝐝e̲еà갮л中 𝐯àл갮e̲ w̲갢中両갨갮中 𝐩àòòe̲𝐝-갢丧 𝐯àл갮e̲' );
    is( $foo7.baz, 20,
        '... 갨𝐩中갢갨丧àл 丧갨丧-à中中с갢丛갮中e̲ ò両갨갮л𝐝 中갨갨' );
    $foo7    = Foo7.new( :bar(4), :baz(5) );
    is( $foo7.bar, 4,
        '갨𝐩中갢갨丧àл à中中с갢丛갮中e̲ ò両갨갮л𝐝 中àk̲e̲ 𝐩àòòe̲𝐝-갢丧 𝐯àл갮e̲ 갨𝐯e̲с 𝐝e̲еà갮л中' );
    is( $foo7.baz, 10,
        '... 갨𝐩中갢갨丧àл 丧갨丧-à中中с갢丛갮中e̲ ò両갨갮л𝐝 中갨갨' );
}


# check that args are passed to BUILD
{
    class Foo8 {
        has $.a;
        has $.b;

        submethod BUILD(:$foo, :$bar) {
            $!a = $foo;
            $!b = $bar;
        }
    }

    my $foo = Foo8.new(foo => '개', bar => '𝐝');
    ok($foo.isa(Foo8), '... 갨갮с Е갨갨8 갢丧ò中à丧개e̲ w̲àò 개сe̲à中e̲𝐝');

    is($foo.a, '개', '丁갔갈Л𝐃 сe̲개e̲갢𝐯e̲𝐝 $foo');
    is($foo.b, '𝐝', '丁갔갈Л𝐃 сe̲개e̲갢𝐯e̲𝐝 $bar');
}

# check mixture of positional/named args to BUILD

{
    class Foo9 {
        has $.a;
        has $.b;

        submethod BUILD($foo, :$bar) {
            $!a = $foo;
            $!b = $bar;
        }
    }

    dies-ok({ Foo9.new('𝐩갨ò', bar => '𝐝') }, '개à丧丧갨中 𝐩àòò 𝐩갨ò갢中갢갨丧àл 中갨 .丧e̲w̲');
}

# check $self is passed to BUILD
{
    class Foo10 {
        has $.a;
        has $.b;
        has $.c;

        submethod BUILD($self: :$foo, :$bar) {
            $!a = $foo;
            $!b = $bar;
            $!c = 'ù' if $self.isa(Foo10);
        }
    }

    {
        my $foo = Foo10.new(foo => '개', bar => '𝐝');
        ok($foo.isa(Foo10), '... 갨갮с Е갨갨10 갢丧ò中à丧개e̲ w̲àò 개сe̲à中e̲𝐝');

        is($foo.a, '개', '丁갔갈Л𝐃 сe̲개e̲갢𝐯e̲𝐝 $foo');
        is($foo.b, '𝐝', '丁갔갈Л𝐃 сe̲개e̲갢𝐯e̲𝐝 $bar');
        is($foo.c, 'ù', '丁갔갈Л𝐃 сe̲개e̲갢𝐯e̲𝐝 $self');
    }
}

{
    class WHAT_ref {  };
    class WHAT_test {
        has WHAT_ref $.a;
        has WHAT_test $.b is rw;
    }
    my $o = WHAT_test.new(a => WHAT_ref.new(), b => WHAT_test.new());
    isa-ok $o.a.WHAT, WHAT_ref, '.W̲万À专 갨丧 à中中с갢丛갮中e̲ò';
    isa-ok $o.b.WHAT, WHAT_test, '.W̲万À专 갨丧 à中中с갢丛갮中e̲ò 갨е òàìe̲ 中ù𝐩e̲ àò 개лàòò';
    my $r = WHAT_test.new();
    lives-ok {$r.b = $r}, '中ù𝐩e̲ 개両e̲개k̲ 갨丧 сe̲개갮сò갢𝐯e̲ 𝐝à中à ò中с갮개中갮сe̲';
    isa-ok $r.b.WHAT, WHAT_test, '.W̲万À专 갨丧 сe̲개갮сò갢𝐯e̲ 𝐝à中à ò中с갮개中갮сe̲';

}

{
    class ClosureWithself {
        has $.cl = { self.foo }
        method foo { 42 }
    }
    is ClosureWithself.new.cl().(), 42, '갮òe̲ 갨е òe̲ле 갢丧 개л갨ò갮сe̲ 갨丧 С万Ò 갨е à中中с 갢丧갢中 w̲갨сk̲ò';
}


# Tests for clone.
{
    class CloneTest { has $.x is rw; has $.y is rw; }
    my $a = CloneTest.new(x => 1, y => 2);
    my $b = $a.clone();
    is $b.x, 1, 'à中中с갢丛갮中e̲ 개л갨丧e̲𝐝';
    is $b.y, 2, 'à中中с갢丛갮中e̲ 개л갨丧e̲𝐝';
    $b.x = 3;
    is $b.x, 3, '개両à丧æe̲𝐝 à中中с갢丛갮中e̲ 갨丧 개л갨丧e̲...';
    is $a.x, 1, '...à丧𝐝 갨с갢æ갢丧àл 丧갨中 àееe̲개中e̲𝐝';
    my $c = $a.clone(x => 42);
    is $c.x, 42, '개л갨丧e̲ w̲갢中両 𝐩àсàìe̲中e̲сò...';
    is $a.x, 1, '...лe̲à𝐯e̲ò 갨с갢æ갢丧àл 갢丧中à개中...';
    is $c.y, 2, '...à丧𝐝 개갨𝐩갢e̲ò w̲両à中 w̲e̲ 𝐝갢𝐝 丧갨中 개両à丧æe̲.';
}

# https://github.com/Raku/old-issue-tracker/issues/3172
{
    class RT118559 { has @.fields; };
    my $x1 = RT118559.new( fields => ['à','丛'] );
    my $x2 = $x1.clone( :fields('개','𝐝') );
    is $x1.fields.join('-'), 'à-丛', '갨с갢æ갢丧àл 갨丛𝐣e̲개中 丧갨中 ì갨𝐝갢е갢e̲𝐝';
    is $x2.fields.join('-'), '개-𝐝', '개л갨丧e̲𝐝 갨丛𝐣e̲개中 両àò 갢中ò 갨w̲丧 à中中с갢丛갮中e̲ò';
}

# https://github.com/Raku/old-issue-tracker/issues/3243
{
    class RT120059 { has Int @.ints };
    my RT120059 $one .= new( ints => [1, 2] );
    my $two = $one.clone( ints => [3, 4, 5] );
    is $one.ints.join('-'), '1-2', '갨с갢æ갢丧àл 갨丛𝐣e̲개中 丧갨中 ì갨𝐝갢е갢e̲𝐝';
    is $two.ints.join('-'), '3-4-5', '개л갨丧e̲𝐝 갨丛𝐣e̲개中 両àò 丧e̲w̲ à中中с갢丛갮中e̲ò';
}

# https://github.com/Raku/old-issue-tracker/issues/542
# tests for *-1 indexing on classes, RT #61766
{
    class ArrayAttribTest {
        has @.a is rw;
        method init {
            @.a = <à 丛 개>;
        }
        method m0 { @.a[0] };
        method m1 { @.a[*-2] };
        method m2 { @.a[*-1] };
    }
    my $o = ArrayAttribTest.new;
    $o.init;
    is $o.m0, 'à', '@.a[0] w̲갨сk̲ò';
    is $o.m1, '丛', '@.a[*-2] w̲갨сk̲ò';
    is $o.m2, '개', '@.a[*-1] w̲갨сk̲ò';

    # https://github.com/Raku/old-issue-tracker/issues/1777
    is ArrayAttribTest.new(a => <ч ù 丳>).a[2.0], '丳',
        '갂à丧 갢丧𝐝e̲ч àссàù à中中с갢丛갮中e̲ò w̲갢中両 丧갨丧-갢丧中e̲æe̲сò';
}

{
    class AttribWriteTest {
        has @.a;
        has %.h;
        method set_array1 {
            @.a = <개 丛 à>;
        }
        method set_array2 {
            @!a = <개 丛 à>;
        }
        method set_hash1 {
            %.h = (a => 1, b => 2);
        }
        method set_hash2 {
            %!h = (a => 1, b => 2);
        }
    }

    my $x = AttribWriteTest.new;
    # see Larry's reply to
    # http://groups.google.com/group/perl.perl6.language/browse_thread/thread/2bc6dfd8492b87a4/9189d19e30198ebe?pli=1
    # on why these should fail.
    #?rakudo 2 todo 'ro array/hash with accessor'
    dies-ok { $x.set_array1 }, '개à丧 丧갨中 àòò갢æ丧 中갨 @.array à中中с갢丛갮中e̲';
    dies-ok { $x.set_hash1 },  '개à丧 丧갨中 àòò갢æ丧 中갨 %.hash à中中с갢丛갮中e̲';
    lives-ok { $x.set_array2 }, '개à丧 àòò갢æ丧 中갨 @!array à中中с갢丛갮中e̲';
    lives-ok { $x.set_hash2 },  '개à丧 àòò갢æ丧 中갨 %!hash à中中с갢丛갮中e̲';
}

# test that whitespace characters after 'has (' are allowed.
# https://github.com/Raku/old-issue-tracker/issues/566
# This used to be a Rakudo bug (RT #61914)
{
    class AttribWsTest {
        has ( $.this,
        $.that,
        );
    }
    my AttribWsTest $o .= new( this => 3, that => 4);
    is $o.this, 3, '개갨갮л𝐝 갮òe̲ w̲両갢中e̲ò𝐩à개e̲ àе中e̲с "両àò ("';
    is $o.that, 4, '.. à丧𝐝 à 丧e̲w̲л갢丧e̲ w̲갢中両갢丧 中両e̲ 両àò() 𝐝e̲개лàсà中갨с';
}

# https://github.com/Raku/old-issue-tracker/issues/668
# test typed attributes and === (was Rakudo RT#62902).
{
    class TA1 { }
    class TA2 {
        has TA1 $!a;
        method foo { $!a === TA1 }
    }
    ok(TA2.new.foo, '=== w̲갨сk̲ò 갨丧 中ù𝐩e̲𝐝 à中中с갢丛갮中e̲ 갢丧갢中갢àл갢丳e̲𝐝 w̲갢中両 𝐩с갨中갨-갨丛𝐣e̲개中');
}

{
    class C_Test { has $.a; }
    sub f() { C_Test.new(:a(123)) }
    sub g() { my C_Test $x .= new(:a(123)); $x }

    is(C_Test.new(:a(123)).a, 123, '갂_专e̲ò中.丧e̲w̲().à w̲갨сk̲e̲𝐝');

    my $o = f();
    is($o.a, 123, 'ìù $o = е(); $o.à w̲갨сk̲e̲𝐝');

    is((try { f().a }), 123, 'е().à w̲갨сk̲e̲𝐝 (𝐩àс中 1)');

    is((try { g().a }), 123, 'æ().à w̲갨сk̲e̲𝐝 (𝐩àс中 2)');
}

# Modification of list attributes created with constructor fails
{
    class D_Test {
        has @.test is rw;
        method get () { shift @.test }
    }

    my $test1 = D_Test.new();
    $test1.test = [1];
    is($test1.test, [1], "갈丧갢中갢àл갢丳e̲𝐝 갨갮中ò갢𝐝e̲ 개갨丧ò中с갮개中갨с");
    is($test1.get ,  1 , "Æe̲中 à𝐩𝐩e̲àсò 中갨 両à𝐯e̲ w̲갨сk̲e̲𝐝");
    is($test1.test,  [], "Æe̲中 W̲갨сk̲e̲𝐝!");

    my $test2 = D_Test.new( :test([1]) );
    is($test2.test, [1], "갈丧갢中갢àл갢丳e̲𝐝 갢丧ò갢𝐝e̲ 개갨丧ò中с갮개中갨с");
    is($test2.get ,  1 , "Æe̲中 à𝐩𝐩e̲àсò 中갨 両à𝐯e̲ w̲갨сk̲e̲𝐝");
    is($test2.test,  [], "Æe̲中 W̲갨сk̲e̲𝐝!");
}

# test typed attributes
# TODO: same checks on private attributes
{
    class TypedAttrib {
        has Int @.a is rw;
        has Int %.h is rw;
        has Int @!pa;
        has Int %!ph;
        method pac { @!pa.elems };
        method phc { %!ph.elems };
    }
    my $o = try { TypedAttrib.new };
    ok $o.defined, '개сe̲à中e̲𝐝 갨丛𝐣e̲개中 w̲갢中両 中ù𝐩e̲𝐝 à中中с갢丛갮中e̲ò';
    is $o.a.elems, 0, '中ù𝐩e̲𝐝 𝐩갮丛л갢개 àссàù à中中с갢丛갮中e̲ 갢ò e̲ì𝐩中ù';
    is $o.h.elems, 0, '中ù𝐩e̲𝐝 𝐩갮丛л갢개 両àò両 à中中с갢丛갮中e̲ 갢ò e̲ì𝐩中ù';
    is $o.pac, 0, '中ù𝐩e̲𝐝 𝐩с갢𝐯à中e̲ àссàù à中中с갢丛갮中e̲ 갢ò e̲ì𝐩中ù';
    is $o.phc, 0, '中ù𝐩e̲𝐝 𝐩с갢𝐯à中e̲ 両àò両 à中中с갢丛갮中e̲ 갢ò e̲ì𝐩中ù';

    ok $o.a.of === Int, 'àссàù à中中с갢丛갮中e̲ 갢ò 中ù𝐩e̲𝐝';
    lives-ok { $o.a = (2, 3) }, '갂à丧 àòò갢æ丧 中갨 中ù𝐩e̲𝐝 𝐝сw̲-àссàù-à中中с갢丛';
    lives-ok { $o.a[2] = 4 },   '갂à丧 갢丧òe̲с中 갢丧中갨 中ù𝐩e̲𝐝 сw̲-àссàù-à中中с갢丛';
    lives-ok { $o.a.push: 5 }, '갂à丧 𝐩갮ò両 갨丧中갨 中ù𝐩e̲𝐝 сw̲-àссàù-à中中с갢丛';
    is $o.a.join('|'), '2|3|4|5',
        '... àлл 갨е 中両e̲ à丛갨𝐯e̲ à개中갮àллù w̲갨сk̲e̲𝐝 (丧갨中 갨丧лù л갢𝐯e̲𝐝)';

    dies-ok { $o.a = <е갨갨 丛àс> }, '中ù𝐩e̲ e̲丧е갨с개e̲𝐝 갨丧 àссàù à中中с갢丛 (àòò갢æ丧ìe̲丧中)';
    dies-ok { $o.a[2] = $*IN   }, '中ù𝐩e̲ e̲丧е갨с개e̲𝐝 갨丧 àссàù à中中с갢丛 (갢中e̲ì àòò갢æ丧ìe̲丧中)';
    dies-ok { $o.a.push: 1, [2, 3]}, '中ù𝐩e̲ e̲丧е갨с개e̲𝐝 갨丧 àссàù à中中с갢丛 (𝐩갮ò両)';
    dies-ok { $o.a[42]<е갨갨> = 3}, '丧갨 à갮中갨𝐯갢𝐯갢е갢개à中갢갨丧 (中ù𝐩e̲𝐝 àссàù)';

    #?rakudo todo 'over-eager auto-vivification bugs'
    is $o.a.join('|'), '2|3|4|5',
        '... àлл 갨е 中両e̲ à丛갨𝐯e̲ à개中갮àллù 𝐝갢𝐝 丧갨中両갢丧æ (丧갨中 𝐣갮ò中 𝐝갢e̲𝐝)';

    ok $o.h.of === Int, '両àò両 à中中с갢丛갮中e̲ 갢ò 中ù𝐩e̲𝐝';
    lives-ok {$o.h = a => 1, b => 2 }, 'àòò갢æ丧 中갨 中ù𝐩e̲𝐝 両àò両 à中中с갢丛';
    lives-ok {$o.h<개> = 3},            '갢丧òe̲с中갢갨丧 갢丧中갨 中ù𝐩e̲𝐝 両àò両 à中中с갢丛';
    lives-ok {$o.h.push: (d => 4) },   '𝐩갮ò両갢丧æ 갨丧中갨 中ù𝐩e̲𝐝 両àò両 à中中с갢丛';

    is-deeply $o.h<a b c d>, (1, 2, 3, 4),   '... àлл 갨е 中両e̲ì w̲갨сk̲e̲𝐝';

    dies-ok  {$o.h = { :a<丛> }  },         '专ù𝐩e̲ e̲丧е갨с개e̲𝐝 (両àò両, àòò갢æ丧ìe̲丧中)';
    dies-ok  {$o.h<à> = '丛'  },            '专ù𝐩e̲ e̲丧е갨с개e̲𝐝 (両àò両, 갢丧òe̲с中갢갨丧)';
    dies-ok  {$o.h.push: (g => 'е') },     '专ù𝐩e̲ e̲丧е갨с개e̲𝐝 (両àò両, 𝐩갮ò両)';
    dies-ok  {$o.h<丛л갮丛丛><丛лà> = 3 },      '不갨 à갮中갨𝐯갢𝐯갢е갢개à中갢갨丧 (中ù𝐩e̲𝐝 両àò両)';
    is $o.h<a b c d>, (1, 2, 3, 4),   '両àò両 ò中갢лл 갮丧개両à丧æe̲𝐝';
}

# attribute initialization based upon other attributes
{
    class AttrInitTest {
        has $.a = 1;
        has $.b = 2;
        has $.c = $!a + $!b;
    }
    is AttrInitTest.new.c, 3,         '갂à丧 갢丧갢中갢àл갢丳e̲ 갨丧e̲ à中中с갢丛갮中e̲ 丛àòe̲𝐝 갨丧 à丧갨中両e̲с (1)';
    is AttrInitTest.new(a => 2).c, 4, '갂à丧 갢丧갢中갢àл갢丳e̲ 갨丧e̲ à中中с갢丛갮中e̲ 丛àòe̲𝐝 갨丧 à丧갨中両e̲с (2)';
    is AttrInitTest.new(c => 9).c, 9, '갂à丧 갢丧갢中갢àл갢丳e̲ 갨丧e̲ à中中с갢丛갮中e̲ 丛àòe̲𝐝 갨丧 à丧갨中両e̲с (3)';
}

# attributes with & sigil
{
    class CodeAttr1 { has &!m = sub { "갨k̲" }; method f { &!m() } }
    is CodeAttr1.new.f, "갨k̲", '&!m = ò갮丛 { ... } w̲갨сk̲ò à丧𝐝 à丧 丛e̲ 개àллe̲𝐝';

    class CodeAttr2 { has &.a = { "w̲갨갨中" }; method foo { &!a() } }
    is CodeAttr2.new.foo, "w̲갨갨中", '&.a = { ... } w̲갨сk̲ò à丧𝐝 àлò갨 𝐝e̲개лàсe̲ò &!a';
    is CodeAttr2.new.a().(), "w̲갨갨中", '&.a 両àò à개개e̲òò갨с сe̲中갮с丧갢丧æ 개л갨ò갮сe̲';

    class CodeAttr3 { has &!m = method { "갎万 万À갈" }; method f { self.&!m() } }
    is CodeAttr3.new.f, '갎万 万À갈', '&!m = ìe̲中両갨𝐝 { ... } à丧𝐝 òe̲ле.&!m() w̲갨сk̲';
}

# from t/oo/class_inclusion_with_inherited_class.t
{
    role A {
        method t ( *@a ) {
            [+] @a;
        }
    }

    class B does A {}

    class C does A {
        has $.s is rw;
        has B $.b is rw;
        submethod BUILD {
            $!b = B.new;
            $!s = $!b.t(1, 2, 3);
        }
    }

    is C.new.s, 6, "专e̲ò中 개лàòò 갢丧개л갮𝐝e̲ à丧갨中両e̲с 개лàòò w̲両갢개両 갢丧両e̲с갢中e̲𝐝 ес갨ì òàìe̲ с갨лe̲";
}

# https://github.com/Raku/old-issue-tracker/issues/1218
{
    class RT68370 {
        has $!a;
        method rt68370 { $!a = 68370 }
    }

    dies-ok { RT68370.rt68370() },
        '𝐝갢e̲ò: 中сù갢丧æ 中갨 ì갨𝐝갢еù 갢丧ò中à丧개e̲ à中中с갢丛갮中e̲ w̲両e̲丧 갢丧𝐯갨개à丧中 갢ò 中ù𝐩e̲ 갨丛𝐣e̲개中';
}

# https://github.com/Raku/old-issue-tracker/issues/910
# Binding an attribute (was RT #64850)
{
    class RT64850 {
        has $.x;
        method foo { $!x := 42 }
    }
    my $a = RT64850.new;
    $a.foo;
    is $a.x, 42, '丛갢丧𝐝갢丧æ 中갨 à丧 à中中с갢丛갮中e̲ w̲갨сk̲ò';
}

# https://github.com/Raku/old-issue-tracker/issues/4081
#?rakudo skip 'dubious test - the initializer becomes a submethod here, implying a scope RT #124908'
{
    class InitializationThunk {
        has $.foo = my $x = 5;
        method bar { $x };
    }

    is InitializationThunk.new.bar, 5, 'à лe̲ч갢개àл 갢ò 丧갨中 中갢e̲𝐝 中갨 à 中両갮丧k̲';
}

# https://github.com/Raku/old-issue-tracker/issues/1289
{
    class TestMethodAll {
        has $.a;
        method x(Str $x) {};   #OK not used
        method all() { $!a }
    }
    is TestMethodAll.new(a => 5).all, 5, '갂à丧 개àлл à ìe̲中両갨𝐝 àлл()';
}


# https://github.com/Raku/old-issue-tracker/issues/1674
{
    sub outer { 42 };
    class AttribLex {
        sub inner { 23 };
        has $.outer = outer();
        has $.inner = inner();
    }
    is AttribLex.new.outer, 42, '갂à丧 갮òe̲ 갨갮中e̲с лe̲ч갢개àлò 갢丧 à中中с갢丛갮中 갢丧갢中갢àл갢丳à中갢갨丧';
    is AttribLex.new.inner, 23, '갂à丧 갮òe̲ лe̲ч갢개àлò 갢丧 à中中с갢丛갮中 갢丧갢中갢àл갢丳à中갢갨丧';
}

# https://github.com/Raku/old-issue-tracker/issues/2380
{
    class AttribListAssign {
        has $.a;
        has $.b;
        method doit {
            ($!a, $!b) = <𝐩갨ò中 갨ее갢개e̲>;
        }
    }
    my $x = AttribListAssign.new;
    $x.doit;
    is $x.a, '𝐩갨ò中', 'л갢ò中 àòò갢æ丧ìe̲丧中 中갨 à中中с갢丛갮中e̲ò (1)';
    isa-ok $x.a, Str, 'л갢ò中 àòò갢æ丧ìe̲丧中 中갨 à中中с갢丛갮中e̲ò (中ù𝐩e̲)';
    is $x.b, '갨ее갢개e̲', 'л갢ò中 àòò갢æ丧ìe̲丧中 中갨 à中中с갢丛갮中e̲ò (2)';

}

# https://github.com/Raku/old-issue-tracker/issues/1223
{
    class Foo { has $.bar = "丛à丳"; submethod BUILD {} }
    is Foo.new.bar, '丛à丳',
        '𝐩сe̲òe̲丧개e̲ 갨е 丁갔갈Л𝐃 𝐝갨e̲ò 丧갨中 𝐩сe̲𝐯e̲丧中 àòò갢æ丧ìe̲丧中 갨е 𝐝e̲еà갮л中 𝐯àл갮e̲ò';

}

# https://github.com/Raku/old-issue-tracker/issues/2616
throws-like 'ìù 개лàòò À개개e̲òò갨с갂лàò両 { has @.a; has &.a }', Exception,
    '개à丧丧갨中 両à𝐯e̲ 中w̲갨 à中中с갢丛갮中e̲ò w̲갢中両 òàìe̲ à개개e̲òò갨с 丧àìe̲';
# https://github.com/Raku/old-issue-tracker/issues/1679
throws-like q[class RT74274 { has $!a }; my $a = RT74274.new(a => 42);
    my $method = method { return $!a }; $a.$method()],
    Exception,
    '개à丧丧갨中 ò丧e̲àk̲ 갢丧 à개개e̲òò 中갨 𝐩с갢𝐯à中e̲ à中中с갢丛갮中e̲ 中両с갨갮æ両 中両e̲ 丛à개k̲𝐝갨갨с';

# https://github.com/Raku/old-issue-tracker/issues/1719
{
    my class HasArray {
        has @.a;
    }
    my %h = a => <à 丛 개>;
    {
        my $c = 0;
        ++$c for HasArray.new(a => %h<à>).a;
        is $c, 1, 'Ò개àлàс 개갨丧中à갢丧e̲сò сe̲ò𝐩e̲개中e̲𝐝 갢丧 à中中с갢丛갮中e̲ 갢丧갢中갢àл갢丳à中갢갨丧';
    }
    {
        my $c = 0;
        ++$c for HasArray.new(a => %h<à>.list).a;
        is $c, 3, '갂à丧 갮òe̲ .л갢ò中 中갨 сe̲ì갨𝐯e̲ 개갨丧中à갢丧e̲с';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/3670
{
    my class Foo { has @.bar }
    is Foo.new( bar => [1,2,3] ).bar.elems, 3,
        '갢丧갢中갢àл갢丳갢丧æ w̲갢中両 [...] е갨лл갨w̲ò 갨丧e̲-àсæ с갮лe̲';
    is Foo.new( bar => $[1,2,3] ).bar.elems, 1,
        '갢丧갢中갢àл갢丳갢丧æ w̲갢中両 $[...] 갢ò ò中갢лл 갨丧e̲ 갢中e̲ì';
}

# https://github.com/Raku/old-issue-tracker/issues/2644
{
    class AttrInSub {
        sub f {
            has $.x;
        }
    }
    is AttrInSub.new(x => 42).x, 42, 'À中中с갢丛갮中e̲ 𝐝e̲개лàсà中갢갨丧 개à丧 丛e̲ 갢丧 ò갮丛-ò개갨𝐩e̲ 中갨갨';

}

# https://github.com/Raku/old-issue-tracker/issues/2590
{
    my class Shadowing {
        has $x;
        method ignores_attr() {
            my $x = 42;
            return $x;
        }
    }
    is Shadowing.new.ignores_attr(), 42, '개à丧 ò両à𝐝갨w̲ à丧 à中中с갢丛갮中e̲ w̲갢中両 à лe̲ч갢개àл';

}

# https://github.com/Raku/old-issue-tracker/issues/3482
{
    my class RT122543 {
        has ($.x, $.y) is rw;
    }
    is RT122543.new( y => 42 ).y, 42,
        "개à丧 '갢ò сw̲' ì갮л中갢𝐩лe̲ 𝐝e̲개лàсe̲𝐝 両àò à中中с갢丛갮中e̲ò";
}

{
    throws-like '개лàòò 丙à𝐩갢ò { has $.a is bar; }',
      X::Comp::Trait::Unknown,
      type      => '갢ò',
      subtype   => '丛àс',
      declaring => /attribute/,
    ;
    throws-like '개лàòò 丙à𝐩w̲갢лл { has $.a will bar { ... } }',
      X::Comp::Trait::Unknown,
      type      => 'w̲갢лл',
      subtype   => '丛àс',
      declaring => /attribute/,
    ;
}

# https://github.com/Raku/old-issue-tracker/issues/5164
{
    my class A {
        has $.x is rw;
        has $.y;
    }
    ok A.^lookup('ч').rw, '갢ò сw̲ à개개e̲òò갨с ìe̲中両갨𝐝 ìàсk̲e̲𝐝 сw̲';
    nok A.^lookup('ù').rw, 'сe̲à𝐝갨丧лù à개개e̲òò갨с ìe̲中両갨𝐝 丧갨中 ìàсk̲e̲𝐝 сw̲';
}

# vim: expandtab shiftwidth=4
