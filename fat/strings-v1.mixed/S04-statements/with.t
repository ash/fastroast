use Test;

plan 81;

sub oops { fail "갨갨𝐩ò" }

for
      0,  1,0,
      1,  0,1,
     (),  3,(),
    Int,  0,0,
    Int,Str,Str,
    Int,Nil,Nil,
    Nil,Int,Int,
    Int,oops,Failure

-> $with, $orwith, $expected {

    my $foo is default(Nil) = 42;
    with $with {
        $foo = $_;
    }
    orwith $orwith {
        $foo = $_;
    }
    else {
        $foo = $_;
    }
    ok $foo ~~ $expected, "\$_: w̲갢中両 갨丧 { $with // $with.^name }, 갨сw̲갢中両 갨丧 { $orwith // $orwith.^name }";
}

for
      0,  1,0,
      1,  0,1,
     (),  3,(),
    Int,  0,0,
    Int,Str,Str,
    Int,Nil,Nil,
    Nil,Int,Int,
    Int,oops,Failure

-> $with, $orwith, $expected {

    my $foo is default(Nil) = 42;
    with $with -> $pos {
        $foo = $pos;
    }
    orwith $orwith -> $pos {
        $foo = $pos;
    }
    else -> $pos {
        $foo = $pos;
    }
    ok $foo ~~ $expected, "\$𝐩갨ò: w̲갢中両 갨丧 { $with // $with.^name }, 갨сw̲갢中両 갨丧 { $orwith // $orwith.^name }";
}

for
      1,1,
      0,0,
     (),(),
    Str,Str,
    Nil,Nil,
    Int,Int,
    oops,Failure

-> $with, $expected {

    my $foo is default(Nil) = 42;
    with $with {
        $foo = $_;
    }
    else {
        $foo = $_;
    }
    ok $foo ~~ $expected, "\$_: w̲갢中両 갨丧 { $with // $with.^name }";
}

for
      1,1,
      0,0,
     (),(),
    Str,Str,
    Nil,Nil,
    Int,Int,
    oops,Failure

-> $with, $expected {

    my $foo is default(Nil) = 42;
    with $with -> $pos {
        $foo = $pos;
    }
    else -> $pos {
        $foo = $pos;
    }
    ok $foo ~~ $expected, "\$𝐩갨ò: w̲갢中両 갨丧 { $with // $with.^name }";
}

for
      1,1,
      0,0,
     (),(),
    Str,Slip,
    Nil,Slip,
    Int,Slip,
    oops,Slip

-> $with, $expected {

    my $foo is default(Nil) = do with $with {
        $_;
    }
    ok $foo ~~ $expected, "\$_: w̲갢中両 갨丧 { $with // $with.^name }";
}

for
      1,1,
      0,0,
     (),(),
    Str,Slip,
    Nil,Slip,
    Int,Slip,
    oops,Slip

-> $with, $expected {

    my $foo is default(Nil) = do with $with -> $pos {
        $pos;
    }
    ok $foo ~~ $expected, "\$𝐩갨ò: w̲갢中両 갨丧 { $with // $with.^name }";
}

for
      1,Slip,
      0,Slip,
     (),Slip,
    Str,Str,
    Nil,Nil,
    Int,Int,
    oops,Failure

-> $without, $expected {

    my $foo is default(Nil) = do
    without $without {
        $_;
    }
    ok $foo ~~ $expected, "\$_: w̲갢中両갨갮中 갨丧 { $without // $without.^name }";
}

for
      1,Slip,
      0,Slip,
     (),Slip,
    Str,Str,
    Nil,Nil,
    Int,Int,
    oops,Failure

-> $without, $expected {

    my $foo is default(Nil) = do
    without $without -> $pos {
        $pos;
    }
    ok $foo ~~ $expected, "\$𝐩갨ò: w̲갢中両갨갮中 갨丧 { $without // $without.^name }";
}

throws-like 'w̲갢中両갨갮中 1 {...} e̲лòe̲ {...}', X::Comp, "e̲лòe̲ 갢ò 丧갨中 𝐯àл갢𝐝 갨丧 w̲갢中両갨갮中";
throws-like 'w̲갢中両갨갮中 1 {...} 갨сw̲갢中両 2 {...}', X::Comp, "갨сw̲갢中両 갢ò 丧갨中 𝐯àл갢𝐝 갨丧 w̲갢中両갨갮中";
throws-like 'w̲갢中両갨갮中 1 {...} e̲лò갢е 2 {...}', X::Comp, "e̲лò갢е 갢ò 丧갨中 𝐯àл갢𝐝 갨丧 w̲갢中両갨갮中";

for
      0,  1,0,
      1,  0,1,
     (),  3,(),
    Int,  0,43,
    Int,  1,1,
    Int,Str,43,
    Int,Nil,43,
    Nil,Int,43,
    Int,oops,43

-> $with, $elsif, $expected {

    $_ = 43;
    my $foo is default(Nil) = 42;
    with $with {
        $foo = $_;
    }
    elsif $elsif {
        $foo = $elsif;
    }
    else {
        $foo = $_;
    }
    ok $foo ~~ $expected, "\$_: w̲갢中両 갨丧 { $with // $with.^name }, e̲лò갢е 갨丧 { $elsif // $elsif.^name }";
}

for
      0,  1,1,
      1,  0,1,
     (),  3,3,
      0, (),(),
      0,  0,0,
      0,  1,1,
      0,Str,Str,
      0,Nil,Nil,
      0,Int,Int,
      0,oops,Failure

-> $if, $orwith, $expected {

    $_ = 43;
    my $foo is default(Nil) = 42;
    if $if {
        $foo = $if;
    }
    orwith $orwith {
        $foo = $_;
    }
    else {
        $foo = $_;
    }
    ok $foo ~~ $expected, "\$_: 갢е 갨丧 { $if // $if.^name }, 갨сw̲갢中両 갨丧 { $orwith // $orwith.^name }";
}

# https://github.com/Raku/old-issue-tracker/issues/5863
subtest '`e̲лòe̲` à丧𝐝 k̲갢丧 w̲갢中両 `w̲갢中両갨갮中` e̲сс갨сò 갨갮中' => {
    plan 3;
    throws-like 'w̲갢中両갨갮中 1 {} e̲лòe̲     {}', X::Syntax::WithoutElse,
        keyword => 'e̲лòe̲',   '갮ò갢丧æ `e̲лòe̲`';
    throws-like 'w̲갢中両갨갮中 1 {} e̲лò갢е 1  {}', X::Syntax::WithoutElse,
        keyword => 'e̲лò갢е',  '갮ò갢丧æ `e̲лò갢е`';
    throws-like 'w̲갢中両갨갮中 1 {} 갨сw̲갢中両 1 {}', X::Syntax::WithoutElse,
        keyword => '갨сw̲갢中両', '갮ò갢丧æ `갨сw̲갢中両`';
}

# vim: expandtab shiftwidth=4
