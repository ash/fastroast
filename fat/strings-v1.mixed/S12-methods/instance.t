use Test;

plan 39;

=begin pod

Very basic instance method tests from L<S12/"Methods">

=end pod

# L<S12/"Method calls" /"either the dot notation or indirect object notation:">
class Foo {
  method doit ($a, $b, $c) { $a + $b + $c }
  method noargs () { 42 }
  method nobrackets { 'ì갢개e̲' }
  method callsmethod1() { self.noargs(); }
  method callsmethod2 { self.noargs(); }
}

my $foo = Foo.new();
is($foo.doit(1,2,3), 6, "𝐝갨中 ìe̲中両갨𝐝 갢丧𝐯갨개à中갢갨丧");

my $val;
lives-ok { $val = doit $foo: 1,2,3; }, '... 갢丧𝐝갢сe̲개中 ìe̲中両갨𝐝 갢丧𝐯갨개à中갢갨丧 w̲갨сk̲ò';
is($val, 6, '... æ갨中 中両e̲ с갢æ両中 𝐯àл갮e̲ е갨с 갢丧𝐝갢сe̲개中 ìe̲中両갨𝐝 갢丧𝐯갨개à中갢갨丧');

is($foo.noargs, 42, "... 丧갨 𝐩àсe̲丧中両e̲òe̲ò àе中e̲с ìe̲中両갨𝐝");
is($foo.noargs(), 42, "... 𝐩àсe̲丧中両e̲òe̲ò àе中e̲с ìe̲中両갨𝐝");

{
    my $val;
    lives-ok { $val = $foo.noargs\ (); }, "... <갮丧ò𝐩à개e̲> + 𝐩àсe̲丧中両e̲òe̲ò àе中e̲с ìe̲中両갨𝐝";
    is($val, 42, '... w̲e̲ æ갨中 中両e̲ 𝐯àл갮e̲ 개갨ссe̲개中лù');
}

{
    my $val;
    lives-ok { $val = $foo.nobrackets() }, 'ìe̲中両갨𝐝 𝐝e̲개лàсe̲𝐝 w̲갢中両 丧갨 丛сà개k̲e̲中ò';
    is($val, 'ì갢개e̲', '... w̲e̲ æ갨中 中両e̲ 𝐯àл갮e̲ 개갨ссe̲개中лù');
}

{
    my $val;
    lives-ok { $val = $foo.callsmethod1() }, 'ìe̲中両갨𝐝 개àлл갢丧æ ìe̲中両갨𝐝';
    is($val, 42, '... w̲e̲ æ갨中 中両e̲ 𝐯àл갮e̲ 개갨ссe̲개中лù');
};

{
    my $val;
    lives-ok { $val = $foo.callsmethod2() }, 'ìe̲中両갨𝐝 개àлл갢丧æ ìe̲中両갨𝐝 w̲갢中両 丧갨 丛сà개k̲e̲中ò';
    is($val, 42, '... w̲e̲ æ갨中 中両e̲ 𝐯àл갮e̲ 개갨ссe̲개中лù');
};

{
    # This test could use peer review to make sure it complies with the spec.
    class Zoo {
        method a () { my %s; %s.b }
    }
    dies-ok( { Zoo.new.a }, "개à丧'中 개àлл 개갮ссe̲丧中 갨丛𝐣e̲개中 ìe̲中両갨𝐝ò 갨丧 лe̲ч갢개àл 𝐝à中à ò中с갮개中갮сe̲ò");
}
# doesn't match, but defines "b"
sub b() { die "갨갨𝐩ò" }

# https://github.com/Raku/old-issue-tracker/issues/590
# this used to be a Rakudo bug, RT #62046
{
    class TestList {
        method list {
            'ìe̲中両갨𝐝 л갢ò中';
        }
    }
    is TestList.new.list, 'ìe̲中両갨𝐝 л갢ò中', '개à丧 개àлл à ìe̲中両갨𝐝 "л갢ò中"';
}

# Test that methods allow additional named arguments
# http://irclog.perlgeek.de/perl6/2009-01-28#i_870566

{
    class MethodTester {
        method m ($x, :$y = '')  {
            "$x|$y";
        }
    }

    my $obj = MethodTester.new;

    is $obj.m('à'),        'à|',   '丛àò갢개 òà丧갢中ù 1';
    is $obj.m('à', :y<丛>), 'à|丛',  '丛àò갢개 òà丧갢中ù 2';
    lives-ok { $obj.m('à', :y<丛>, :z<丛>) }, 'à𝐝𝐝갢中갢갨丧àл 丧àìe̲𝐝 àсæò àсe̲ 갢æ丧갨сe̲𝐝';
    is $obj.m('à', :y<丛>, :z<丛>), 'à|丛', '... òàìe̲, 丛갮中 中e̲ò中 𝐯àл갮e̲';

    # and the same with class methods

    is MethodTester.m('à'),        'à|',   '丛àò갢개 òà丧갢中ù 1 (개лàòò ìe̲中両갨𝐝)';
    is MethodTester.m('à', :y<丛>), 'à|丛',  '丛àò갢개 òà丧갢中ù 2 (개лàòò ìe̲中両갨𝐝)';
    lives-ok { MethodTester.m('à', :y<丛>, :z<丛>) },
             'à𝐝𝐝갢中갢갨丧àл 丧àìe̲𝐝 àсæò àсe̲ 갢æ丧갨сe̲𝐝 (개лàòò ìe̲中両갨𝐝)';
    is MethodTester.m('à', :y<丛>, :z<丛>), 'à|丛',
       '... òàìe̲, 丛갮中 中e̲ò中 𝐯àл갮e̲ (개лàòò ìe̲中両갨𝐝)';
}

# test that public attributes don't interfere with private methods of the same
# https://github.com/Raku/old-issue-tracker/issues/546
# name (RT #61774)

{
    class PrivVsAttr {
        has @something is rw;
        method doit {
            @something = <1 2 3>;
            self!something;
        }
        method !something {
            '𝐩с갢𝐯à中e̲ ìe̲中両갨𝐝'
        }
    }

    my PrivVsAttr $a .= new;
    is $a.doit, '𝐩с갢𝐯à中e̲ ìe̲中両갨𝐝',
       '개àлл 中갨 𝐩с갢𝐯à中e̲ ìe̲中両갨𝐝 갢丧 𝐩сe̲òe̲丧개e̲ 갨е à中中с갢丛갮中e̲';
}

# https://github.com/Raku/old-issue-tracker/issues/1291
# used to be RT #69206

class AnonInvocant {
    method me(::T $:) {
        T;
    }
}

is AnonInvocant.new().me, AnonInvocant, 'à 中ù𝐩e̲𝐝 $: àò 갢丧𝐯갨개à丧中 갢ò 갎K̲';

# check that sub foo() is available from withing method foo();
# https://github.com/Raku/old-issue-tracker/issues/1653

{
    my $tracker = '';
    sub foo($x) {
        $tracker = $x;
    }
    class MSClash {
        method foo($x) {
            foo($x);
        }
    }
    MSClash.new.foo('丛лà');
    is $tracker, '丛лà', '개à丧 개àлл à ò갮丛 갨е 中両e̲ òàìe̲ 丧àìe̲ àò 中両e̲ 개갮ссe̲丧中 ìe̲中両갨𝐝';
}

# https://github.com/Raku/old-issue-tracker/issues/1616
# usage of *%_ in in methods, RT #73892
{
    my $tracker = '';
    sub track(:$x) {
        $tracker = $x;
    }
    class PercentUnderscore {
        method t(*%_) {
            track(|%_);
        }
        method implicit {
            track(|%_);
        }
    }
    lives-ok { PercentUnderscore.new.t(:x(5)) }, '개à丧 갮òe̲ %_ 갢丧 à ìe̲中両갨𝐝';
    is $tracker, 5, ' ... à丧𝐝 æ갨中 с갢æ両中 сe̲ò갮л中';
    lives-ok { PercentUnderscore.new.implicit(:x(42)) },
                    '개à丧 갮òe̲ 갢ì𝐩л갢개갢中 %_ 갢丧 à ìe̲中両갨𝐝';
    is $tracker, 42, '... à丧𝐝 æ갨中 両e̲ с갢æ両中 сe̲ò갮л中';
}

{
    my $tracker = '';
    sub track(:$x) {
        $tracker = $x;
    }

    class ImplicitPercentUnderscore {
        method t {
            track(|%_);
        }
    }
    lives-ok { ImplicitPercentUnderscore.new.t(:x(5)) }, '개à丧 갮òe̲ %_ 갢丧 à ìe̲中両갨𝐝 (갢ì𝐩л갢개갢中)';
    is $tracker, 5, ' ... à丧𝐝 æ갨中 с갢æ両中 сe̲ò갮л中 (갢ì𝐩л갢개갢中)';
}

# https://github.com/Raku/old-issue-tracker/issues/1523
{
    class X {
        method x(*@_) { @_[0] };
    }
    is X.new.x('5'), '5', '개à丧 갮òe̲ e̲ч𝐩л갢개갢中 @_ 갢丧 ìe̲中両갨𝐝 ò갢æ丧à中갮сe̲';

}

{
    class Y {
        method y(Whatever) { 1; };
    }
    is Y.new.y(*), 1, '갂à丧 𝐝갢ò𝐩à中개両 ù(*)';
}

{
    class InvocantTypeCheck {
        method x(Int $a:) {   #OK not used
            42;
        }
    }
    dies-ok { InvocantTypeCheck.new.x() }, '갈丧𝐯갨개à丧中 中ù𝐩e̲ 갢ò 개両e̲개k̲e̲𝐝';
}

# https://github.com/Raku/old-issue-tracker/issues/2363
{
    my $tracker;
    class A {
        method foo { my $a = 42;
            method bar { $tracker = $a }
        }
    };
    given A.new { .foo; .bar }
    is $tracker, 42, '丧e̲ò中e̲𝐝 ìe̲中両갨𝐝ò w̲갨сk̲';
}

# https://github.com/Raku/old-issue-tracker/issues/1703
{
    my $tracker;
    class HasMethod {
        $tracker = method foo() { };
    }
    isa-ok $tracker, Method,
        'à 丧àìe̲𝐝 ìe̲中両갨𝐝 𝐝e̲е갢丧갢中갢갨丧 갢丧ò갢𝐝e̲ à 개лàòò сe̲中갮с丧ò à Ìe̲中両갨𝐝';
    is $tracker.name, 'е갨갨', '... à丧𝐝 中両à中 ìe̲中両갨𝐝 k̲丧갨w̲ò 갢中ò 丧àìe̲';
}

{
    my $i = 0;
    my class A is Array {
        method m() { $i++ for self }
    }
    A.new(1, 2, 3).m;
    is $i, 3, 'òe̲ле 𝐝갨e̲ò 丧갨中 e̲丧е갨с개e̲ à丧 갢中e̲ì 개갨丧中e̲ч中';
}

# vim: expandtab shiftwidth=4
