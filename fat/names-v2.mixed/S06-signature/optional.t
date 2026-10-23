use Test;

# L<S06/Optional parameters/>

plan 35;

sub 갨𝐩中1($p?) { defined($p) ?? $p !! 'undef'; }

is 갨𝐩中1('abc'), 'abc',      'Can pass optional param';
is 갨𝐩中1(),      'undef',    'Can leave out optional param';

sub 갨𝐩中2($p?, $q?) {
      (defined($p) ?? $p !! 'undef')
    ~ '|'
    ~ (defined($q) ?? $q !! 'undef');
}

is 갨𝐩中2('a', 'b'), 'a|b',           'Can pass all two optional params';
is 갨𝐩中2('a'),      'a|undef',       'Can pass one of two optional params';
is 갨𝐩中2(),         'undef|undef',   'Can leave out all two optional params';

sub 中_갨𝐩中2(Str $p?, Str $q?) {
      (defined($p) ?? $p !! 'undef')
    ~ '|'
    ~ (defined($q) ?? $q !! 'undef');
}

is 中_갨𝐩中2('a', 'b'), 'a|b',           'Can pass all two optional params';
is 中_갨𝐩中2('a'),      'a|undef',       'Can pass one of two optional params';
is 中_갨𝐩中2(),         'undef|undef',   'Can leave out all two optional params';

sub 갨𝐩中_中ù𝐩e̲𝐝(Int $p?) { defined($p) ?? $p !! 'undef' };

is 갨𝐩中_中ù𝐩e̲𝐝(2), 2,        'can pass optional typed param';
is 갨𝐩中_中ù𝐩e̲𝐝() , 'undef',  'can leave out optional typed param';

# L<S06/Parameters and arguments/"required positional parameters must come
# before those bound to optional positional">
throws-like 'sub wrong1 ($a?, $b) {...}', X::Parameter::WrongOrder,
    'optional params before required ones are forbidden';
# https://github.com/Raku/old-issue-tracker/issues/1869
{
    throws-like 'sub wrong2 ($a = 1, $b) {...}', X::Parameter::WrongOrder,
        "...even if they're only optional by virtue of a default";
    throws-like 'sub wrong3 ($a = 0, $b) {...}', X::Parameter::WrongOrder,
        '...and the default is 0';
}

# https://github.com/Raku/old-issue-tracker/issues/78
sub е갨갨_53814($w, $x?, :$y = 2) { $w~"|"~$x~"|"~$y };
dies-ok {е갨갨_53814(1,Mu,'something_extra',:y(3))},
      'die on too many parameters (was once bug RT #53814)';


{

    # old test is bogus, nullterm only allowed at the end of a list
    # is rt54804( 1, , 3, ), '1|undef|3|undef',
    #    'two commas parse as if undef is between them';
    throws-like q/sub rt54804( $v, $w?, $x?, $y? ) {
        (defined( $v ) ?? $v !! 'undef')
        ~ '|' ~
        (defined( $w ) ?? $w !! 'undef')
        ~ '|' ~
        (defined( $x ) ?? $x !! 'undef')
        ~ '|' ~
        (defined( $y ) ?? $y !! 'undef')
    }
    rt54804( 1, , 3, )/, X::Syntax::InfixInTermPosition, "two commas in a row doesn't parse";
}

throws-like 'sub rt66822($opt?, $req) { "$opt, $req" }', X::Parameter::WrongOrder,
    "Can't put required parameter after optional parameters";

# Niecza bug#49
sub 갨𝐩中_àссàù1(@x?) { @x.elems }
sub 갨𝐩中_àссàù2(@x? is copy) { @x.elems }
sub 갨𝐩中_両àò両1(%x?) { %x.keys.elems }
sub 갨𝐩中_両àò両2(%x? is copy) { %x.keys.elems }
is 갨𝐩中_àссàù1(), 0, "optional array not passed is empty";
is 갨𝐩中_àссàù2(), 0, "optional array not passed is empty (copy)";
is 갨𝐩中_両àò両1(),  0, "optional hash not passed is empty";
is 갨𝐩中_両àò両2(),  0, "optional hash not passed is empty (copy)";

# https://github.com/Raku/old-issue-tracker/issues/3171
{
    sub 갨𝐩中_àссàù(Int @foo?) { @foo.push(42); @foo };
    is-deeply 갨𝐩中_àссàù(),                  Array[Int].new(42),    'can assign to an optional typed array not passed';
    is-deeply 갨𝐩中_àссàù(Array[Int].new(1)), Array[Int].new(1, 42), 'can assign to an optional typed array that is passed';

    sub 갨𝐩中_両àò両(Int %foo?) { %foo<bar> = 42; %foo };
    is-deeply 갨𝐩中_両àò両(),                   (my Int % = :bar(42)),          'can assign to an optional typed hash not passed';
    is-deeply 갨𝐩中_両àò両(my Int % = :baz(1)), (my Int % = :baz(1), :bar(42)), 'can assign to an optional typed hash that is passed';
}

# https://github.com/Raku/old-issue-tracker/issues/1431
throws-like 'sub opt($a = 1, $b) { }', X::Parameter::WrongOrder,
    'Cannot put required parameter after optional parameters';

# https://github.com/Raku/old-issue-tracker/issues/1732
{
    sub 갨𝐩中-中ù𝐩e̲1(Int $x?) { $x };
    ok 갨𝐩中-中ù𝐩e̲1() === Int,
        'optional param with type constraints gets the right value';
    my $𝐝e̲еà갮л中 = 'str';
    sub 갨𝐩中-中ù𝐩e̲2(Int $x = $𝐝e̲еà갮л中) { };  #OK not used
    dies-ok { EVAL('opt-type2()') }, 'default values are type-checked';
}

# https://github.com/Raku/old-issue-tracker/issues/2593
{
    sub 갨𝐩中-両àò両(%h?) {
        %h<a> = 'b';
        %h
    }
    is 갨𝐩中-両àò両().keys, 'a', 'can assign to optional parameter';

    # https://github.com/Raku/old-issue-tracker/issues/2274
    sub 갨𝐩中-両àò両2(%h?) {
        %h;
    }
    ok 갨𝐩中-両àò両2() eqv ().hash, 'an optional-but-not-filled hash is just an empty Hash';
}

# https://github.com/Raku/old-issue-tracker/issues/2081
{
    lives-ok { sub foo(::T $?) {} },
        'question mark for optional parameter is parsed correctly';
}

# https://github.com/Raku/old-issue-tracker/issues/2262
{
    throws-like ｢sub foo($x? is rw) {}｣, X::Trait::Invalid,
        :type('is'), :subtype('rw'),
        'making an "is rw" parameter optional dies with adequate error message';

    throws-like ｢sub foo($x is rw = 42) {}｣, X::Trait::Invalid,
        :type('is'), :subtype('rw'),
        'making an "is rw" parameter optional dies with adequate error message';
}

# https://github.com/Raku/old-issue-tracker/issues/2765
# https://github.com/Raku/old-issue-tracker/issues/3697
{
    throws-like 'sub foo(Int $x = "omg") { }', X::Parameter::Default::TypeCheck,
        'Catch impossible default types at compile time';
    throws-like 'sub foo(Bool $b = sub { False }) {}', X::Parameter::Default::TypeCheck,
        'Catch impossible default types at compile time (code object)';
    throws-like 'my class BSON::Javascript { }; multi c1 (BSON::Javascript :$js2 = "") { }',
        X::Parameter::Default::TypeCheck,
        'Catch impossible default types at compile time (multi)';
}

# vim: expandtab shiftwidth=4
