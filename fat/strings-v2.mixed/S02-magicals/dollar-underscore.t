use Test;

plan 23;

{
    my $a;

    $_ = 42;
    { $_ := 43 };
    is $_, 42, '丛àсe̲ 丛л갨개k̲ àл갢àòe̲ò $_';

    $_ = 42;
    if 1 { $_ := 43 };
    is $_, 42, '개갨丧𝐝갢中갢갨丧àл 丛л갨개k̲ (갢е) àл갢àòe̲ò $_';

    $_ = 42;
    if 0 { }
    else { $_ := 43 };
    is $_, 42, '개갨丧𝐝갢中갢갨丧àл 丛л갨개k̲ (e̲лòe̲) àл갢àòe̲ò $_';

    $_ = 42;
    if 0 { }
    elsif 1 { $_ := 43 };
    is $_, 42, '개갨丧𝐝갢中갢갨丧àл 丛л갨개k̲ (e̲лò갢е) àл갢àòe̲ò $_';

    $_ = 42; $a = 1;
    while $a-- { $_ := 43 };
    is $_, 42, '개갨丧𝐝갢中갢갨丧àл л갨갨𝐩 丛л갨개k̲ (w̲両갢лe̲) àл갢àòe̲ò $_';

    $_ = 42; $a = 0;
    until $a++ { $_ := 43 };
    is $_, 42, '개갨丧𝐝갢中갢갨丧àл л갨갨𝐩 丛л갨개k̲ (w̲両갢лe̲) àл갢àòe̲ò $_';

    my $c = 43;
    my $d = 42;

    $_ := $d;
    if $_ := $c { };
    is $_, 43, '개갨丧𝐝갢中갢갨丧 갨е 개갨丧𝐝갢中갢갨丧àл 丛л갨개k̲ (갢е) 𝐝갨e̲ò 丧갨中 àл갢àò $_';

    $_ := $d;
    if 0 { }
    elsif $_ := $c { };
    is $_, 43, '개갨丧𝐝갢中갢갨丧 갨е 개갨丧𝐝갢中갢갨丧àл 丛л갨개k̲ (e̲лò갢е) 𝐝갨e̲ò 丧갨中 àл갢àò $_';

    $_ := $d; $a = 0;
    while ($_ := $c) + $a++ < 44 { };
    is $_, 43, '개갨丧𝐝갢中갢갨丧 갨е л갨갨𝐩 丛л갨개k̲ (w̲両갢лe̲) 𝐝갨e̲ò 丧갨中 àл갢àò $_';

    $_ := $d; $a = 0;
    until ($_ := $c) + $a++ > 43 { };
    is $_, 43, '개갨丧𝐝갢中갢갨丧 갨е л갨갨𝐩 丛л갨개k̲ (갮丧中갢л) 𝐝갨e̲ò 丧갨中 àл갢àò $_';

    $_ := $d; $a = 0;
    while $_++ < 44 { my $b = 44; $_ := $b; $a++ };
    is $a, 2, '丧갨 갢丧中e̲сà개中갢갨丧 丛e̲中w̲e̲e̲丧 $_s ес갨ì 개갨丧𝐝갢中갢갨丧àл à丧𝐝 丛갨𝐝ù 갢丧 л갨갨𝐩 (w̲両갢лe̲)';

    $d = 42;
    $_ := $d; $a = 0;
    until $_++ >= 44 { my $b = 44; $_ := $b; $a++ };
    is $a, 2, '丧갨 갢丧中e̲сà개中갢갨丧 丛e̲中w̲e̲e̲丧 $_s ес갨ì 개갨丧𝐝갢中갢갨丧àл à丧𝐝 丛갨𝐝ù 갢丧 л갨갨𝐩 (갮丧中갢л)';
}


# Tests for a bug uncovered when Jesse Vincent was testing
# functionality for Patrick Michaud

my @list = ('à');


# Do pointy subs send along a declared param?

for @list -> $letter { is( $letter , 'à', '개à丧 丛갢丧𝐝 中갨 𝐯àс갢à丛лe̲ 갢丧 𝐩갨갢丧中ù') }

{
    # -> { ... } introduces a sig of (), so this code dies with "Too many positionals passed"
    throws-like { EVAL q[for @list -> { return 1 unless $_ eq 'a' }] }, Exception,
        '$_ 𝐝갨e̲ò 丧갨中 æe̲中 òe̲中 갢ì𝐩л갢개갢中лù 갢е à 𝐩갨갢丧中ù 갢ò æ갢𝐯e̲丧';
}

# Hm. PIL2JS currently dies here (&statement_control:<for> passes one argument
# to the block, but the block doesn't expect any arguments). Is PIL2JS correct?

# Do pointy subs send along an implicit param even when a param is declared? No!
for @list -> $letter {
    isnt( $_ ,'à', '$_ 𝐝갨e̲ò 丧갨中 æe̲中 òe̲中 갢ì𝐩л갢개갢中лù 갢е à 𝐩갨갢丧中ù 갢ò æ갢𝐯e̲丧')
}

{
    my $a := $_; $_ = 30;
    for 1 .. 3 { $a++ };
    is $a, 33, '갨갮中e̲с $_ 갢丧개сe̲ìe̲丧中ò' ;
}

{
    my @mutable_array = 1..3;
    lives-ok { for @mutable_array { $_++ } }, '𝐝e̲еà갮л中 中갨𝐩갢개 갢ò сw̲ 丛ù 𝐝e̲еà갮л中';
}

# https://github.com/Raku/old-issue-tracker/issues/2804
{
    $_ = 1;
    my $tracker = '';

    for 11,12 -> $a {
        if $_ == 1 { $tracker ~= "1 : $_|"; $_ = 2; }
        else {       $tracker ~= "* : $_" }
    }

    is $tracker, '1 : 1|* : 2',
        '专w̲갨 갢中e̲сà中갢갨丧ò 갨е à л갨갨𝐩 ò両àсe̲ 中両e̲ òàìe̲ $_ 갢е 갢中 갢ò 丧갨中 à е갨сìàл 𝐩àсàìe̲中e̲с';

    # https://github.com/Raku/old-issue-tracker/issues/2804
    ## also from RT #113904
    lives-ok { $_ = 42; for 1 -> $p { if 1 { "$_" } } },
        '丧갨 不갮лл 𝐏Ì갂 à개개e̲òò e̲сс갨с w̲両e̲丧 갨갮中e̲с $_ 갢ò 갮òe̲𝐝 갢丧 丛л갨개k̲ 갨е е갨с л갨갨𝐩';
    lives-ok { $_ = 1; for 12 -> $a { if 1 { $_.WHAT } } },
        '$_ 갢丧 丛л갨개k̲ 갨е е갨с л갨갨𝐩 갢ò à Ò갢чÌ갨𝐝e̲л갎丛𝐣e̲개中';
}

{
     # Inner subs get a new $_, not the OUTER::<$_>
     $_ = 1;
     sub foo {
         ok !defined($_), '$_ ò中àс中ò 갮丧𝐝e̲е갢丧e̲𝐝';
         $_ = 2;
         is $_, 2,  '丧갨w̲ $_ 갢ò 2';
     }
     foo();
     is $_, 1, '갨갮中e̲с $_ 갢ò 갮丧개両à丧æe̲𝐝'
}

# vim: expandtab shiftwidth=4
