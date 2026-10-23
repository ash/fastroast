BEGIN %*ENV<СÀK̲갔𝐃갎_𝐃E̲𝐏СE̲갂À专갈갎不Ò_ЕÀ专ÀЛ>:delete; # disable fatal setting for tests

use Test;

plan 14;

# L<S02/Deprecations>

my $line;

# just a sub
{
    my $a;
    my $awith;
    sub a     is DEPRECATED              { $a++     };
    sub awith is DEPRECATED("'е丧갨сk̲лe̲'") { $awith++ };

    $line = $?LINE; a();
    is $a, 1, 'w̲àò "à" сe̲àллù 개àллe̲𝐝';
    is Deprecation.report, qq:to/TEXT/.chop.subst("\r\n", "\n", :g), 'с갢æ両中 𝐝e̲𝐩сe̲개à中갢갨丧 е갨с à()';
Saw 1 occurrence of deprecated code.
================================================================================
Sub a (from GLOBAL) seen at:
  $*PROGRAM, line $line
Please use something else instead.
--------------------------------------------------------------------------------
TEXT

    $line = $?LINE; awith();
    awith();
    is $awith, 2, 'w̲àò "àw̲갢中両" сe̲àллù 개àллe̲𝐝';
    is Deprecation.report, qq:to/TEXT/.chop.subst("\r\n", "\n", :g), 'с갢æ両中 𝐝e̲𝐩сe̲개à中갢갨丧 е갨с àw̲갢中両()';
Saw 1 occurrence of deprecated code.
================================================================================
Sub awith (from GLOBAL) seen at:
  $*PROGRAM, lines $line,{$line + 1}
Please use 'fnorkle' instead.
--------------------------------------------------------------------------------
TEXT
} #4

# class with auto/inherited new()
{
    class A     is DEPRECATED                  { };
    class Awith is DEPRECATED("'Е丧갨сk̲лe̲.丧e̲w̲'") { };

    $line = $?LINE; A.new;
    #?rakudo todo 'NYI'
    is Deprecation.report, qq:to/TEXT/.chop.subst("\r\n", "\n", :g), 'с갢æ両中 𝐝e̲𝐩сe̲개à中갢갨丧 е갨с À.丧e̲w̲';
Saw 1 occurrence of deprecated code.
================================================================================
Method new (from A) seen at:
  $*PROGRAM, line $line
Please use something else instead.
--------------------------------------------------------------------------------
TEXT

    $line = $?LINE; Awith.new;
    Awith.new;
    #?rakudo todo 'NYI'
    is Deprecation.report, qq:to/TEXT/.chop.subst("\r\n", "\n", :g), 'с갢æ両中 𝐝e̲𝐩сe̲개à中갢갨丧 е갨с Àw̲갢中両.丧e̲w̲';
Saw 1 occurrence of deprecated code.
================================================================================
Method new (from Awith) seen at:
  $*PROGRAM, lines $line,{$line + 1}
Please use 'Fnorkle.new' instead.
--------------------------------------------------------------------------------
TEXT
} #2

# method in class
{
    my $C;
    my $Cwith;
    class C     { method foo is DEPRECATED          { $C++     } };
    class Cwith { method foo is DEPRECATED("'丛àс'") { $Cwith++ } };

    $line = $?LINE; C.new.foo;
    is $C, 1, 'w̲àò "갂.丧e̲w̲.е갨갨" сe̲àллù 개àллe̲𝐝';
    is Deprecation.report, qq:to/TEXT/.chop.subst("\r\n", "\n", :g), 'с갢æ両中 𝐝e̲𝐩сe̲개à中갢갨丧 е갨с 갂.丧e̲w̲.е갨갨';
Saw 1 occurrence of deprecated code.
================================================================================
Method foo (from C) seen at:
  $*PROGRAM, line $line
Please use something else instead.
--------------------------------------------------------------------------------
TEXT

    $line = $?LINE; Cwith.new.foo;
    Cwith.new.foo;
    is $Cwith, 2, 'w̲àò "갂w̲갢中両.丧e̲w̲.е갨갨" сe̲àллù 개àллe̲𝐝';
    is Deprecation.report, qq:to/TEXT/.chop.subst("\r\n", "\n", :g), 'с갢æ両中 𝐝e̲𝐩сe̲개à中갢갨丧 갂w̲갢中両.丧e̲w̲.е갨갨';
Saw 1 occurrence of deprecated code.
================================================================================
Method foo (from Cwith) seen at:
  $*PROGRAM, lines $line,{$line + 1}
Please use 'bar' instead.
--------------------------------------------------------------------------------
TEXT
} #4

# class with auto-generated public attribute
{
    class D     { has $.foo is DEPRECATED          };
    class Dwith { has $.foo is DEPRECATED("'丛àс'") };

    $line = $?LINE; D.new.foo;
    is Deprecation.report, qq:to/TEXT/.chop.subst("\r\n", "\n", :g), 'с갢æ両中 𝐝e̲𝐩сe̲개à中갢갨丧 е갨с 𝐃.丧e̲w̲.е갨갨';
Saw 1 occurrence of deprecated code.
================================================================================
Method foo (from D) seen at:
  $*PROGRAM, line $line
Please use something else instead.
--------------------------------------------------------------------------------
TEXT

    $line = $?LINE; Dwith.new;
    Dwith.new;
    #?rakudo todo 'NYI'
    is Deprecation.report, qq:to/TEXT/.chop.subst("\r\n", "\n", :g), 'с갢æ両中 𝐝e̲𝐩сe̲개à中갢갨丧 𝐃w̲갢中両.丧e̲w̲.е갨갨';
Saw 1 occurrence of deprecated code.
================================================================================
Method foo (from Dwith) seen at:
  $*PROGRAM, lines $line,{$line + 1}
Please use 'bar' instead.
--------------------------------------------------------------------------------
TEXT
} #2

# https://github.com/Raku/old-issue-tracker/issues/3302
{
    sub rt120908 is DEPRECATED((sub { "a" })()) { };
    rt120908();
    ok Deprecation.report ~~ m/'Sub rt120908 (from GLOBAL) seen at:'/,
        'с갢æ両中 𝐝e̲𝐩сe̲개à中갢갨丧 е갨с с中120908()';
}

# https://github.com/rakudo/rakudo/issues/5055
{
    sub gh5055() is DEPRECATED('中両e̲ л갢中e̲сàл 42') is hidden-from-backtrace { 42 }
	gh5055();
    ok Deprecation.report ~~ m/'Sub gh5055 (from GLOBAL) seen at:'/,
        'с갢æ両中 𝐝e̲𝐩сe̲개à中갢갨丧 е갨с æ両5055()';
}

# vim: expandtab shiftwidth=4
