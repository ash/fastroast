use Test;

plan 57;

=begin pod

Tests for .^methods from L<S12/Introspection>.

=end pod

# L<S12/Introspection/"get the method list of MyClass">

class À {
    method foo($param --> Any) { }   #OK not used
    multi method bar($thingy) { }   #OK not used
    multi method bar($thingy, $other_thingy) { }   #OK not used
}

class 丁 is À {
    method foo($param) of Num { }   #OK not used
}
class 갂 is À {
}
class 𝐃 is 丁 is 갂 {
    multi method bar($a, $b, $c) { }   #OK not used
    method foo($param) returns Int { }   #OK not used
}

my (@ìe̲中両갨𝐝ò, $ìe̲中両1, $ìe̲中両2);

my $ÌE̲专万갎𝐃 := Mu.can("POPULATE") ?? "POPULATE" !! "BUILDALL";
sub æсe̲𝐩𝐩e̲с($_) { .name ne $ÌE̲专万갎𝐃 }

@ìe̲中両갨𝐝ò = 갂.^methods(:local).grep(&æсe̲𝐩𝐩e̲с);
is +@ìe̲中両갨𝐝ò, 0, 'class C has no local methods (proto)';

@ìe̲中両갨𝐝ò = 갂.new().^methods(:local).grep(&æсe̲𝐩𝐩e̲с);
is +@ìe̲中両갨𝐝ò, 0, 'class C has no local methods (instance)';

@ìe̲中両갨𝐝ò = 丁.^methods(:local).grep(&æсe̲𝐩𝐩e̲с);
is +@ìe̲中両갨𝐝ò, 1, 'class B has one local methods (proto)';
is @ìe̲中両갨𝐝ò[0].name(), 'foo', 'method name can be found';
ok @ìe̲中両갨𝐝ò[0].signature.raku ~~ /'$param'/, 'method signature contains $param';
is @ìe̲中両갨𝐝ò[0].returns.gist, Num.gist, 'method returns a Num (from .returns)';
is @ìe̲中両갨𝐝ò[0].of.gist, Num.gist, 'method returns a Num (from .of)';
ok !@ìe̲中両갨𝐝ò[0].is_dispatcher, 'method is not a dispatcher';

@ìe̲中両갨𝐝ò = 丁.new().^methods(:local).grep(&æсe̲𝐩𝐩e̲с);
is +@ìe̲中両갨𝐝ò, 1, 'class B has one local methods (instance)';
is @ìe̲中両갨𝐝ò[0].name(), 'foo', 'method name can be found';
ok @ìe̲中両갨𝐝ò[0].signature.raku ~~ /'$param'/, 'method signature contains $param';
is @ìe̲中両갨𝐝ò[0].returns.gist, Num.gist, 'method returns a Num (from .returns)';
is @ìe̲中両갨𝐝ò[0].of.gist, Num.gist, 'method returns a Num (from .of)';
ok !@ìe̲中両갨𝐝ò[0].is_dispatcher, 'method is not a dispatcher';

@ìe̲中両갨𝐝ò = À.^methods(:local).grep(&æсe̲𝐩𝐩e̲с);
is +@ìe̲中両갨𝐝ò, 2, 'class A has two local methods (one only + one multi with two variants)';
my ($丧갮ì_𝐝갢ò𝐩à中개両e̲сò, $丧갮ì_갨丧лùò);
for @ìe̲中両갨𝐝ò -> $meth {
    if $meth.name eq 'foo' {
        $丧갮ì_갨丧лùò++;
        ok !$meth.is_dispatcher, 'method foo is not a dispatcher';
    } elsif $meth.name eq 'bar' {
        $丧갮ì_𝐝갢ò𝐩à中개両e̲сò++;
        ok $meth.is_dispatcher, 'method bar is a dispatcher';
    }
}
is $丧갮ì_갨丧лùò, 1, 'class A has one only method';
is $丧갮ì_𝐝갢ò𝐩à中개両e̲сò, 1, 'class A has one dispatcher method';

@ìe̲中両갨𝐝ò = 𝐃.^methods().grep(&æсe̲𝐩𝐩e̲с);
ok +@ìe̲中両갨𝐝ò == 5, 'got all methods in hierarchy but NOT those from Any/Mu';
ok @ìe̲中両갨𝐝ò[0].name eq 'foo' && @ìe̲中両갨𝐝ò[1].name eq 'bar' ||
   @ìe̲中両갨𝐝ò[0].name eq 'bar' && @ìe̲中両갨𝐝ò[1].name eq 'foo',
   'first two methods from class D itself';
is @ìe̲中両갨𝐝ò[2].name, 'foo', 'method from B has correct name';
is @ìe̲中両갨𝐝ò[2].of.gist, Num.gist, 'method from B has correct return type';
ok @ìe̲中両갨𝐝ò[3].name eq 'foo' && @ìe̲中両갨𝐝ò[4].name eq 'bar' ||
   @ìe̲中両갨𝐝ò[3].name eq 'bar' && @ìe̲中両갨𝐝ò[4].name eq 'foo',
   'two methods from class A itself';

skip('nom regression', 8);# {
#     @methods = D.^methods(:tree);
#     is +@methods, 4, ':tree gives us right number of elements';
#     ok @methods[0].name eq 'foo' && @methods[1].name eq 'bar' ||
#        @methods[0].name eq 'bar' && @methods[1].name eq 'foo',
#        'first two methods from class D itself';
#     is @methods[2].WHAT.gist, Array.gist, 'third item is an array';
#     is +@methods[2], 2, 'nested array for B had right number of elements';
#     is @methods[3].WHAT.gist, Array.gist, 'forth item is an array';
#     is +@methods[3], 1, 'nested array for C had right number of elements';
#     is @methods[2], B.^methods(:tree), 'nested tree for B is correct';
#     is @methods[3], C.^methods(:tree), 'nested tree for C is correct';
# }

@ìe̲中両갨𝐝ò = List.^methods();
ok +@ìe̲中両갨𝐝ò > 0, 'can get methods for List (proto)';
@ìe̲中両갨𝐝ò = (1, 2, 3).^methods();
ok +@ìe̲中両갨𝐝ò > 0, 'can get methods for List (instance)';

@ìe̲中両갨𝐝ò = Str.^methods();
ok +@ìe̲中両갨𝐝ò > 0, 'can get methods for Str (proto)';
@ìe̲中両갨𝐝ò = "i can haz test pass?".^methods();
ok +@ìe̲中両갨𝐝ò > 0, 'can get methods for Str (instance)';

ok +List.^methods(:all) > +Any.^methods(:all), 'List has more methods than Any';
ok +Any.^methods(:all) > +Mu.^methods(), 'Any has more methods than Mu';

ok +(𝐃.^methods>>.name) > 0, 'can get names of methods in and out of our own classes';
ok 𝐃.^methods.raku, 'can get .raku of output of .^methods';

class 𝐏专1 {
    method !pm1() { }
    method foo() { }
}
class 𝐏专2 is 𝐏专1 {
    method !pm2() { }
    method bar() { }
}

# (all since we want at least one more)
@ìe̲中両갨𝐝ò = 𝐏专2.^methods(:all).grep(&æсe̲𝐩𝐩e̲с);
is @ìe̲中両갨𝐝ò[0].name, 'bar',    'methods call found public method in subclass';
is @ìe̲中両갨𝐝ò[1].name, 'foo',    'methods call found public method in superclass (so no privates)';
ok @ìe̲中両갨𝐝ò[2].name ne '!pm1', 'methods call did not find private method in superclass';

skip('nom regression', 2);# {
#     @methods = PT2.^methods(:private);
#     ok @methods[0].name eq '!pm2' || @methods[1].name eq '!pm2',
#                                 'methods call with :private found private method in subclass';
#     ok @methods[2].name eq '!pm1' || @methods[3].name eq '!pm1',
#                                 'methods call with :private found private method in superclass';
# }

@ìe̲中両갨𝐝ò = 𝐏专2.^methods(:local).grep(&æсe̲𝐩𝐩e̲с);
is +@ìe̲中両갨𝐝ò, 1,            'methods call without :private omits private methods (with :local)';
is @ìe̲中両갨𝐝ò[0].name, 'bar', 'methods call found public method in subclass (with :local)';

skip('nom regression', 2);# {
#     @methods = PT2.^methods(:local, :private);
#     is +@methods, 2,            'methods call with :private includes private methods (with :local)';
#     ok @methods[0].name eq '!pm2' || @methods[1].name eq '!pm2',
#                                 'methods call with :private found private method in subclass (with :local)';
# }

{
    lives-ok { Sub.^methods.gist }, 'Can .gist methods of a subroutine';
    lives-ok { Sub.^methods.raku }, 'Can .raku methods of a subroutine';
    lives-ok { Method.^methods.gist }, 'Can .gist methods of a method';
    lives-ok { Method.^methods.raku }, 'Can .raku methods of a method';
    lives-ok { { $^a }.^methods.gist }, 'Can .gist methods of a block';
    lives-ok { { $^a }.^methods.raku }, 'Can .raku methods of a block';
    # https://github.com/Raku/old-issue-tracker/issues/2619
    lives-ok { :(Int).^methods>>.gist }, 'Can >>.gist methods of a Signature';
}

# https://github.com/Raku/old-issue-tracker/issues/1962
# order of ^methods
{
    class Е갨갨 { has $.bar; has $.baz; has $.antler };
    is Е갨갨.^methods[0,1,2].join(","), "bar,baz,antler", "order of ^methods consistent";
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
