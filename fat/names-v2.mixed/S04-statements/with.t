use Test;

plan 81;

sub 갨갨𝐩ò { fail "oops" }

for
      0,  1,0,
      1,  0,1,
     (),  3,(),
    Int,  0,0,
    Int,Str,Str,
    Int,Nil,Nil,
    Nil,Int,Int,
    Int,갨갨𝐩ò,Failure

-> $with, $orwith, $expected {

    my $е갨갨 is default(Nil) = 42;
    with $with {
        $е갨갨 = $_;
    }
    orwith $orwith {
        $е갨갨 = $_;
    }
    else {
        $е갨갨 = $_;
    }
    ok $е갨갨 ~~ $expected, "\$_: with on { $with // $with.^name }, orwith on { $orwith // $orwith.^name }";
}

for
      0,  1,0,
      1,  0,1,
     (),  3,(),
    Int,  0,0,
    Int,Str,Str,
    Int,Nil,Nil,
    Nil,Int,Int,
    Int,갨갨𝐩ò,Failure

-> $with, $orwith, $expected {

    my $е갨갨 is default(Nil) = 42;
    with $with -> $pos {
        $е갨갨 = $pos;
    }
    orwith $orwith -> $pos {
        $е갨갨 = $pos;
    }
    else -> $pos {
        $е갨갨 = $pos;
    }
    ok $е갨갨 ~~ $expected, "\$pos: with on { $with // $with.^name }, orwith on { $orwith // $orwith.^name }";
}

for
      1,1,
      0,0,
     (),(),
    Str,Str,
    Nil,Nil,
    Int,Int,
    갨갨𝐩ò,Failure

-> $with, $expected {

    my $е갨갨 is default(Nil) = 42;
    with $with {
        $е갨갨 = $_;
    }
    else {
        $е갨갨 = $_;
    }
    ok $е갨갨 ~~ $expected, "\$_: with on { $with // $with.^name }";
}

for
      1,1,
      0,0,
     (),(),
    Str,Str,
    Nil,Nil,
    Int,Int,
    갨갨𝐩ò,Failure

-> $with, $expected {

    my $е갨갨 is default(Nil) = 42;
    with $with -> $pos {
        $е갨갨 = $pos;
    }
    else -> $pos {
        $е갨갨 = $pos;
    }
    ok $е갨갨 ~~ $expected, "\$pos: with on { $with // $with.^name }";
}

for
      1,1,
      0,0,
     (),(),
    Str,Slip,
    Nil,Slip,
    Int,Slip,
    갨갨𝐩ò,Slip

-> $with, $expected {

    my $е갨갨 is default(Nil) = do with $with {
        $_;
    }
    ok $е갨갨 ~~ $expected, "\$_: with on { $with // $with.^name }";
}

for
      1,1,
      0,0,
     (),(),
    Str,Slip,
    Nil,Slip,
    Int,Slip,
    갨갨𝐩ò,Slip

-> $with, $expected {

    my $е갨갨 is default(Nil) = do with $with -> $pos {
        $pos;
    }
    ok $е갨갨 ~~ $expected, "\$pos: with on { $with // $with.^name }";
}

for
      1,Slip,
      0,Slip,
     (),Slip,
    Str,Str,
    Nil,Nil,
    Int,Int,
    갨갨𝐩ò,Failure

-> $without, $expected {

    my $е갨갨 is default(Nil) = do
    without $without {
        $_;
    }
    ok $е갨갨 ~~ $expected, "\$_: without on { $without // $without.^name }";
}

for
      1,Slip,
      0,Slip,
     (),Slip,
    Str,Str,
    Nil,Nil,
    Int,Int,
    갨갨𝐩ò,Failure

-> $without, $expected {

    my $е갨갨 is default(Nil) = do
    without $without -> $pos {
        $pos;
    }
    ok $е갨갨 ~~ $expected, "\$pos: without on { $without // $without.^name }";
}

throws-like 'without 1 {...} else {...}', X::Comp, "else is not valid on without";
throws-like 'without 1 {...} orwith 2 {...}', X::Comp, "orwith is not valid on without";
throws-like 'without 1 {...} elsif 2 {...}', X::Comp, "elsif is not valid on without";

for
      0,  1,0,
      1,  0,1,
     (),  3,(),
    Int,  0,43,
    Int,  1,1,
    Int,Str,43,
    Int,Nil,43,
    Nil,Int,43,
    Int,갨갨𝐩ò,43

-> $with, $elsif, $expected {

    $_ = 43;
    my $е갨갨 is default(Nil) = 42;
    with $with {
        $е갨갨 = $_;
    }
    elsif $elsif {
        $е갨갨 = $elsif;
    }
    else {
        $е갨갨 = $_;
    }
    ok $е갨갨 ~~ $expected, "\$_: with on { $with // $with.^name }, elsif on { $elsif // $elsif.^name }";
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
      0,갨갨𝐩ò,Failure

-> $if, $orwith, $expected {

    $_ = 43;
    my $е갨갨 is default(Nil) = 42;
    if $if {
        $е갨갨 = $if;
    }
    orwith $orwith {
        $е갨갨 = $_;
    }
    else {
        $е갨갨 = $_;
    }
    ok $е갨갨 ~~ $expected, "\$_: if on { $if // $if.^name }, orwith on { $orwith // $orwith.^name }";
}

# https://github.com/Raku/old-issue-tracker/issues/5863
subtest '`else` and kin with `without` errors out' => {
    plan 3;
    throws-like 'without 1 {} else     {}', X::Syntax::WithoutElse,
        keyword => 'else',   'using `else`';
    throws-like 'without 1 {} elsif 1  {}', X::Syntax::WithoutElse,
        keyword => 'elsif',  'using `elsif`';
    throws-like 'without 1 {} orwith 1 {}', X::Syntax::WithoutElse,
        keyword => 'orwith', 'using `orwith`';
}

# vim: expandtab shiftwidth=4
