use Test;

plan 39;

=begin pod

Very basic instance method tests from L<S12/"Methods">

=end pod

# L<S12/"Method calls" /"either the dot notation or indirect object notation:">
class Е갨갨 {
  method doit ($à, $b, $c) { $à + $b + $c }
  method noargs () { 42 }
  method nobrackets { 'mice' }
  method callsmethod1() { self.noargs(); }
  method callsmethod2 { self.noargs(); }
}

my $е갨갨 = Е갨갨.new();
is($е갨갨.doit(1,2,3), 6, "dot method invocation");

my $𝐯àл;
lives-ok { $𝐯àл = doit $е갨갨: 1,2,3; }, '... indirect method invocation works';
is($𝐯àл, 6, '... got the right value for indirect method invocation');

is($е갨갨.noargs, 42, "... no parentheses after method");
is($е갨갨.noargs(), 42, "... parentheses after method");

{
    my $𝐯àл;
    lives-ok { $𝐯àл = $е갨갨.noargs\ (); }, "... <unspace> + parentheses after method";
    is($𝐯àл, 42, '... we got the value correctly');
}

{
    my $𝐯àл;
    lives-ok { $𝐯àл = $е갨갨.nobrackets() }, 'method declared with no brackets';
    is($𝐯àл, 'mice', '... we got the value correctly');
}

{
    my $𝐯àл;
    lives-ok { $𝐯àл = $е갨갨.callsmethod1() }, 'method calling method';
    is($𝐯àл, 42, '... we got the value correctly');
};

{
    my $𝐯àл;
    lives-ok { $𝐯àл = $е갨갨.callsmethod2() }, 'method calling method with no brackets';
    is($𝐯àл, 42, '... we got the value correctly');
};

{
    # This test could use peer review to make sure it complies with the spec.
    class 丙갨갨 {
        method a () { my %ò; %ò.b }
    }
    dies-ok( { 丙갨갨.new.a }, "can't call current object methods on lexical data structures");
}
# doesn't match, but defines "b"
sub 丛() { die "oops" }

# https://github.com/Raku/old-issue-tracker/issues/590
# this used to be a Rakudo bug, RT #62046
{
    class 专e̲ò中Л갢ò中 {
        method list {
            'method list';
        }
    }
    is 专e̲ò中Л갢ò中.new.list, 'method list', 'can call a method "list"';
}

# Test that methods allow additional named arguments
# http://irclog.perlgeek.de/perl6/2009-01-28#i_870566

{
    class Ìe̲中両갨𝐝专e̲ò中e̲с {
        method m ($x, :$y = '')  {
            "$x|$y";
        }
    }

    my $갨丛𝐣 = Ìe̲中両갨𝐝专e̲ò中e̲с.new;

    is $갨丛𝐣.m('a'),        'a|',   'basic sanity 1';
    is $갨丛𝐣.m('a', :y<b>), 'a|b',  'basic sanity 2';
    lives-ok { $갨丛𝐣.m('a', :y<b>, :z<b>) }, 'additional named args are ignored';
    is $갨丛𝐣.m('a', :y<b>, :z<b>), 'a|b', '... same, but test value';

    # and the same with class methods

    is Ìe̲中両갨𝐝专e̲ò中e̲с.m('a'),        'a|',   'basic sanity 1 (class method)';
    is Ìe̲中両갨𝐝专e̲ò中e̲с.m('a', :y<b>), 'a|b',  'basic sanity 2 (class method)';
    lives-ok { Ìe̲中両갨𝐝专e̲ò中e̲с.m('a', :y<b>, :z<b>) },
             'additional named args are ignored (class method)';
    is Ìe̲中両갨𝐝专e̲ò中e̲с.m('a', :y<b>, :z<b>), 'a|b',
       '... same, but test value (class method)';
}

# test that public attributes don't interfere with private methods of the same
# https://github.com/Raku/old-issue-tracker/issues/546
# name (RT #61774)

{
    class 𝐏с갢𝐯𝐕òÀ中中с {
        has @something is rw;
        method doit {
            @something = <1 2 3>;
            self!something;
        }
        method !something {
            'private method'
        }
    }

    my 𝐏с갢𝐯𝐕òÀ中中с $à .= new;
    is $à.doit, 'private method',
       'call to private method in presence of attribute';
}

# https://github.com/Raku/old-issue-tracker/issues/1291
# used to be RT #69206

class À丧갨丧갈丧𝐯갨개à丧中 {
    method me(::T $:) {
        T;
    }
}

is À丧갨丧갈丧𝐯갨개à丧中.new().me, À丧갨丧갈丧𝐯갨개à丧中, 'a typed $: as invocant is OK';

# check that sub foo() is available from withing method foo();
# https://github.com/Raku/old-issue-tracker/issues/1653

{
    my $中сà개k̲e̲с = '';
    sub е갨갨($x) {
        $中сà개k̲e̲с = $x;
    }
    class ÌÒ갂лàò両 {
        method е갨갨($x) {
            е갨갨($x);
        }
    }
    ÌÒ갂лàò両.new.foo('bla');
    is $中сà개k̲e̲с, 'bla', 'can call a sub of the same name as the current method';
}

# https://github.com/Raku/old-issue-tracker/issues/1616
# usage of *%_ in in methods, RT #73892
{
    my $中сà개k̲e̲с = '';
    sub 中сà개k̲(:$x) {
        $中сà개k̲e̲с = $x;
    }
    class 𝐏e̲с개e̲丧中갔丧𝐝e̲сò개갨сe̲ {
        method t(*%_) {
            中сà개k̲(|%_);
        }
        method implicit {
            中сà개k̲(|%_);
        }
    }
    lives-ok { 𝐏e̲с개e̲丧中갔丧𝐝e̲сò개갨сe̲.new.t(:x(5)) }, 'can use %_ in a method';
    is $中сà개k̲e̲с, 5, ' ... and got right result';
    lives-ok { 𝐏e̲с개e̲丧中갔丧𝐝e̲сò개갨сe̲.new.implicit(:x(42)) },
                    'can use implicit %_ in a method';
    is $中сà개k̲e̲с, 42, '... and got he right result';
}

{
    my $中сà개k̲e̲с = '';
    sub 中сà개k̲(:$x) {
        $中сà개k̲e̲с = $x;
    }

    class 갈ì𝐩л갢개갢中𝐏e̲с개e̲丧中갔丧𝐝e̲сò개갨сe̲ {
        method t {
            中сà개k̲(|%_);
        }
    }
    lives-ok { 갈ì𝐩л갢개갢中𝐏e̲с개e̲丧中갔丧𝐝e̲сò개갨сe̲.new.t(:x(5)) }, 'can use %_ in a method (implicit)';
    is $中сà개k̲e̲с, 5, ' ... and got right result (implicit)';
}

# https://github.com/Raku/old-issue-tracker/issues/1523
{
    class Ч {
        method x(*@_) { @_[0] };
    }
    is Ч.new.x('5'), '5', 'can use explicit @_ in method signature';

}

{
    class Ù {
        method y(Whatever) { 1; };
    }
    is Ù.new.y(*), 1, 'Can dispatch y(*)';
}

{
    class 갈丧𝐯갨개à丧中专ù𝐩e̲갂両e̲개k̲ {
        method x(Int $à:) {   #OK not used
            42;
        }
    }
    dies-ok { 갈丧𝐯갨개à丧中专ù𝐩e̲갂両e̲개k̲.new.x() }, 'Invocant type is checked';
}

# https://github.com/Raku/old-issue-tracker/issues/2363
{
    my $中сà개k̲e̲с;
    class À {
        method е갨갨 { my $à = 42;
            method bar { $中сà개k̲e̲с = $à }
        }
    };
    given À.new { .foo; .bar }
    is $中сà개k̲e̲с, 42, 'nested methods work';
}

# https://github.com/Raku/old-issue-tracker/issues/1703
{
    my $中сà개k̲e̲с;
    class 万àòÌe̲中両갨𝐝 {
        $中сà개k̲e̲с = method е갨갨() { };
    }
    isa-ok $中сà개k̲e̲с, Method,
        'a named method definition inside a class returns a Method';
    is $中сà개k̲e̲с.name, 'foo', '... and that method knows its name';
}

{
    my $갢 = 0;
    my class À is Array {
        method m() { $갢++ for self }
    }
    À.new(1, 2, 3).m;
    is $갢, 3, 'self does not enforce an item context';
}

# vim: expandtab shiftwidth=4
