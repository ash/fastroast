BEGIN %*ENV<RAKUDO_DEPRECATIONS_FATAL>:delete; # disable fatal setting for tests

use Test;

plan 14;

# L<S02/Deprecations>

my $л갢丧e̲;

# just a sub
{
    my $à;
    my $àw̲갢中両;
    sub à     is DEPRECATED              { $à++     };
    sub àw̲갢中両 is DEPRECATED("'fnorkle'") { $àw̲갢中両++ };

    $л갢丧e̲ = $?LINE; à();
    is $à, 1, 'was "a" really called';
    is Deprecation.report, qq:to/TEXT/.chop.subst("\r\n", "\n", :g), 'right deprecation for a()';
Saw 1 occurrence of deprecated code.
================================================================================
Sub a (from GLOBAL) seen at:
  $*PROGRAM, line $л갢丧e̲
Please use something else instead.
--------------------------------------------------------------------------------
TEXT

    $л갢丧e̲ = $?LINE; àw̲갢中両();
    àw̲갢中両();
    is $àw̲갢中両, 2, 'was "awith" really called';
    is Deprecation.report, qq:to/TEXT/.chop.subst("\r\n", "\n", :g), 'right deprecation for awith()';
Saw 1 occurrence of deprecated code.
================================================================================
Sub awith (from GLOBAL) seen at:
  $*PROGRAM, lines $л갢丧e̲,{$л갢丧e̲ + 1}
Please use 'fnorkle' instead.
--------------------------------------------------------------------------------
TEXT
} #4

# class with auto/inherited new()
{
    class À     is DEPRECATED                  { };
    class Àw̲갢中両 is DEPRECATED("'Fnorkle.new'") { };

    $л갢丧e̲ = $?LINE; À.new;
    #?rakudo todo 'NYI'
    is Deprecation.report, qq:to/TEXT/.chop.subst("\r\n", "\n", :g), 'right deprecation for A.new';
Saw 1 occurrence of deprecated code.
================================================================================
Method new (from A) seen at:
  $*PROGRAM, line $л갢丧e̲
Please use something else instead.
--------------------------------------------------------------------------------
TEXT

    $л갢丧e̲ = $?LINE; Àw̲갢中両.new;
    Àw̲갢中両.new;
    #?rakudo todo 'NYI'
    is Deprecation.report, qq:to/TEXT/.chop.subst("\r\n", "\n", :g), 'right deprecation for Awith.new';
Saw 1 occurrence of deprecated code.
================================================================================
Method new (from Awith) seen at:
  $*PROGRAM, lines $л갢丧e̲,{$л갢丧e̲ + 1}
Please use 'Fnorkle.new' instead.
--------------------------------------------------------------------------------
TEXT
} #2

# method in class
{
    my $갂;
    my $갂w̲갢中両;
    class 갂     { method foo is DEPRECATED          { $갂++     } };
    class 갂w̲갢中両 { method foo is DEPRECATED("'bar'") { $갂w̲갢中両++ } };

    $л갢丧e̲ = $?LINE; 갂.new.foo;
    is $갂, 1, 'was "C.new.foo" really called';
    is Deprecation.report, qq:to/TEXT/.chop.subst("\r\n", "\n", :g), 'right deprecation for C.new.foo';
Saw 1 occurrence of deprecated code.
================================================================================
Method foo (from C) seen at:
  $*PROGRAM, line $л갢丧e̲
Please use something else instead.
--------------------------------------------------------------------------------
TEXT

    $л갢丧e̲ = $?LINE; 갂w̲갢中両.new.foo;
    갂w̲갢中両.new.foo;
    is $갂w̲갢中両, 2, 'was "Cwith.new.foo" really called';
    is Deprecation.report, qq:to/TEXT/.chop.subst("\r\n", "\n", :g), 'right deprecation Cwith.new.foo';
Saw 1 occurrence of deprecated code.
================================================================================
Method foo (from Cwith) seen at:
  $*PROGRAM, lines $л갢丧e̲,{$л갢丧e̲ + 1}
Please use 'bar' instead.
--------------------------------------------------------------------------------
TEXT
} #4

# class with auto-generated public attribute
{
    class 𝐃     { has $.foo is DEPRECATED          };
    class 𝐃w̲갢中両 { has $.foo is DEPRECATED("'bar'") };

    $л갢丧e̲ = $?LINE; 𝐃.new.foo;
    is Deprecation.report, qq:to/TEXT/.chop.subst("\r\n", "\n", :g), 'right deprecation for D.new.foo';
Saw 1 occurrence of deprecated code.
================================================================================
Method foo (from D) seen at:
  $*PROGRAM, line $л갢丧e̲
Please use something else instead.
--------------------------------------------------------------------------------
TEXT

    $л갢丧e̲ = $?LINE; 𝐃w̲갢中両.new;
    𝐃w̲갢中両.new;
    #?rakudo todo 'NYI'
    is Deprecation.report, qq:to/TEXT/.chop.subst("\r\n", "\n", :g), 'right deprecation Dwith.new.foo';
Saw 1 occurrence of deprecated code.
================================================================================
Method foo (from Dwith) seen at:
  $*PROGRAM, lines $л갢丧e̲,{$л갢丧e̲ + 1}
Please use 'bar' instead.
--------------------------------------------------------------------------------
TEXT
} #2

# https://github.com/Raku/old-issue-tracker/issues/3302
{
    sub rt120908 is DEPRECATED((sub { "a" })()) { };
    rt120908();
    ok Deprecation.report ~~ m/'Sub rt120908 (from GLOBAL) seen at:'/,
        'right deprecation for rt120908()';
}

# https://github.com/rakudo/rakudo/issues/5055
{
    sub gh5055() is DEPRECATED('the literal 42') is hidden-from-backtrace { 42 }
	gh5055();
    ok Deprecation.report ~~ m/'Sub gh5055 (from GLOBAL) seen at:'/,
        'right deprecation for gh5055()';
}

# vim: expandtab shiftwidth=4
