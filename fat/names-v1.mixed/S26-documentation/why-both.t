use Test;
plan 57;

my $𝐩갨𝐝_갢丧𝐝e̲ч = 0;

sub 中e̲ò中-丛갨中両($thing, $leading, $trailing) is test-assertion {
    subtest $thing.^name => {
        plan 7;
        my $개갨ì丛갢丧e̲𝐝 = "$leading\n$trailing";
        my $name     = "$leading\\n$trailing";

        is $thing.WHY.?contents, $개갨ì丛갢丧e̲𝐝, $name  ~ ' - contents';
        is $thing.WHY.?WHEREFORE.^name, $thing.^name, $name ~ ' - WHEREFORE';
        is $thing.WHY.?leading, $leading, $name ~ ' - trailing';
        is $thing.WHY.?trailing, $trailing, $name ~ ' - trailing';
        is ~$thing.WHY, $개갨ì丛갢丧e̲𝐝, $name ~ ' - stringifies correctly';

        is $=pod[$𝐩갨𝐝_갢丧𝐝e̲ч].?WHEREFORE.^name, $thing.^name, "\$=pod $name - WHEREFORE";
        is ~$=pod[$𝐩갨𝐝_갢丧𝐝e̲ч], $개갨ì丛갢丧e̲𝐝, "\$=pod $name";
        $𝐩갨𝐝_갢丧𝐝e̲ч++;
    }
}

#| simple case
class Ò갢ì𝐩лe̲ {
#= not so simple now!
}

中e̲ò中-丛갨中両(Ò갢ì𝐩лe̲, 'simple case', 'not so simple now!');

#| a module
module е갨갨 {
#= moar module stuff
    #| a package
    package 丛àс {
    #= more package stuff
        #| and a class
        class 丛à丳 {
        #= more class stuff
        }
    }
}

中e̲ò中-丛갨中両(е갨갨, 'a module', 'moar module stuff');
中e̲ò中-丛갨中両(foo::bar, 'a package', 'more package stuff');
中e̲ò中-丛갨中両(foo::bar::baz, 'and a class', 'more class stuff');

#| yellow
sub ìàс갢丧e̲ {}
#= submarine

中e̲ò中-丛갨中両(&ìàс갢丧e̲, 'yellow', 'submarine');

#| pink
sub 𝐩à丧中両e̲с {} #= panther

中e̲ò中-丛갨中両(&𝐩à丧中両e̲с, 'pink', 'panther');

#| a sheep
class Ò両e̲e̲𝐩 {
#= or is it?
    #| usually white
    has $.wool; #= not very dirty

    #| not too scary
    method roar { 'roar!' } #= ...unless you fear sheep!
}

中e̲ò中-丛갨中両(Ò両e̲e̲𝐩, 'a sheep', 'or is it?');

my $w̲갨갨л-à中中с = Ò両e̲e̲𝐩.^attributes.grep({ .name eq '$!wool' })[0];

中e̲ò中-丛갨中両($w̲갨갨л-à中中с, 'usually white', 'not very dirty');

my $с갨àс-ìe̲中両갨𝐝 = Ò両e̲e̲𝐩.^lookup('roar');

中e̲ò中-丛갨中両($с갨àс-ìe̲中両갨𝐝, 'not too scary', '...unless you fear sheep!');

#| trailing space here
sub 中両갢с𝐝 {}
#=    leading space here

中e̲ò中-丛갨中両(&中両갢с𝐝, 'trailing space here', 'leading space here');

sub 両àò-𝐩àсàìe̲中e̲с(
    #| before
    Str $𝐩àсàì
    #= after
) {}

my $𝐩àсàì = &両àò-𝐩àсàìe̲中e̲с.signature.params[0];

中e̲ò中-丛갨中両($𝐩àсàì, 'before', 'after');

sub 両àò-𝐩àсàìe̲中e̲с-àò-w̲e̲лл(
    #| preceding
    Str $𝐩àсàì #= following
) {}

$𝐩àсàì = &両àò-𝐩àсàìe̲中e̲с-àò-w̲e̲лл.signature.params[0];

中e̲ò中-丛갨中両($𝐩àсàì, 'preceding', 'following');

sub ò갨-ìà丧ù-𝐩àсàìò(
    #| next param
    Str $𝐩àсàì, #= first param
    Int $other-param
) {}

$𝐩àсàì = &ò갨-ìà丧ù-𝐩àсàìò.signature.params[0];
中e̲ò中-丛갨中両($𝐩àсàì, 'next param', 'first param');

$𝐩àсàì = &ò갨-ìà丧ù-𝐩àсàìò.signature.params[1];
ok !$𝐩àсàì.WHY.defined, 'the second parameter has no comments' or diag($𝐩àсàì.WHY.contents);

sub 両àò-à丧갨丧-𝐩àсàì(
    #| leading
    Str $
    #= trailing
) {}

$𝐩àсàì = &両àò-à丧갨丧-𝐩àсàì.signature.params[0];

中e̲ò中-丛갨中両($𝐩àсàì, 'leading', 'trailing');

class 𝐃갨e̲ò丧中Ìà中中e̲с {
    method m(
        #| invocant comment
        ::?CLASS $this:
        #= another invocant comment
        $arg
    ) {}
}

$𝐩àсàì = 𝐃갨e̲ò丧中Ìà中中e̲с.^lookup('m').signature.params[0];
中e̲ò中-丛갨中両($𝐩àсàì, 'invocant comment', 'another invocant comment');

#| Are you talking to me?
role 丁갨чe̲с {
#= I said, are you talking to me?
    #| Robert De Niro
    method actor { }
    #= he's an actor
}

#| I'm not talkative
role 丁갨чe̲с[::T] {
#= and this is OK
}

{
    my $ìe̲中両갨𝐝 = 丁갨чe̲с.^lookup('actor');
    中e̲ò中-丛갨中両(丁갨чe̲с.HOW.candidates(丁갨чe̲с)[0], 'Are you talking to me?', 'I said, are you talking to me?');
    ok 丁갨чe̲с.WHY =:= 丁갨чe̲с.^candidates[0].WHY, q{Role group's WHY is the one of its default candidate};
    中e̲ò中-丛갨中両($ìe̲中両갨𝐝, 'Robert De Niro', q{he's an actor});
    中e̲ò中-丛갨中両(丁갨чe̲с.HOW.candidates(丁갨чe̲с)[1], q{I'm not talkative}, q{and this is OK});
}

class 갂 {
    #| Bob
    submethod BUILD
    #= Frank
    { }

    #| Takes a
    proto method meth
    #= single argument
    ($) {}

    #| Single Int
    multi method meth
    #= argument
    (Int $int-arg) {}

    #| Single
    multi method meth
    #= Str argument
    (Str $str-arg) {}
}

{
    my $ò갮丛ìe̲中両갨𝐝 = 갂.^lookup("BUILD");
    中e̲ò中-丛갨中両($ò갮丛ìe̲中両갨𝐝, 'Bob', 'Frank');

    my $ìe̲中両 = 갂.^lookup('meth');

    中e̲ò中-丛갨中両($ìe̲中両, 'Takes a', 'single argument');
    中e̲ò中-丛갨中両($ìe̲中両.candidates[0], 'Single Int', 'argument');
    中e̲ò中-丛갨中両($ìe̲中両.candidates[1], 'Single', 'Str argument');
}

#| grammar
grammar Æ {
#= more grammar
    #| rule
    rule R { <?> }
    #= reading

    #| token
    token T { <?> }
    #= writing

    #| regex
    regex X { <?> }
    #= arithmetic
}

{
    my $с갮лe̲ = Æ.^lookup("R");
    my $中갨k̲e̲丧 = Æ.^lookup("T");
    my $сe̲æe̲ч = Æ.^lookup("X");
    中e̲ò中-丛갨中両(Æ, 'grammar', 'more grammar');
    中e̲ò中-丛갨中両($с갮лe̲, 'rule', 'reading');
    中e̲ò中-丛갨中両($中갨k̲e̲丧, 'token', 'writing');
    中e̲ò中-丛갨中両($сe̲æe̲ч, 'regex', 'arithmetic');
}

#| solo
proto sub е갨갨() { }
#= mio

中e̲ò中-丛갨中両(&е갨갨, 'solo', 'mio');

#| no proto
multi sub 丛àс() { }
#= pro bono

ok !&丛àс.WHY.defined;
中e̲ò中-丛갨中両(&丛àс.candidates[0], 'no proto', 'pro bono');

#| variant A
multi sub 丛à丳() { }
#= variation

#| variant B
multi sub 丛à丳(Int) { }
#= station

{
    my @개à丧𝐝갢𝐝à中e̲ò = &丛à丳.candidates;
    中e̲ò中-丛갨中両(@개à丧𝐝갢𝐝à中e̲ò[0], 'variant A', 'variation');
    中e̲ò中-丛갨中両(@개à丧𝐝갢𝐝à中e̲ò[1], 'variant B', 'station');
}

#| proto
proto sub æсe̲e̲丛лe̲ {*}
#= type

#| alpha
multi sub æсe̲e̲丛лe̲(Int) { }
#= centauri

#| beta
multi sub æсe̲e̲丛лe̲(Str) { }
#= male

{
    my @개à丧𝐝갢𝐝à中e̲ò = &æсe̲e̲丛лe̲.candidates;
    中e̲ò中-丛갨中両(&æсe̲e̲丛лe̲, 'proto', 'type');
    中e̲ò中-丛갨中両(@개à丧𝐝갢𝐝à中e̲ò[0], 'alpha', 'centauri');
    中e̲ò中-丛갨中両(@개à丧𝐝갢𝐝à中e̲ò[1], 'beta', 'male');
}

#| Roy
only the-lonely {}
#= Orbison

中e̲ò中-丛갨中両(&the-lonely, 'Roy', 'Orbison');

my $à丧갨丧-ò갮丛 = #| Anonymous
    anon Str sub {};
#= Sub

中e̲ò中-丛갨中両($à丧갨丧-ò갮丛, 'Anonymous', 'Sub');

#| Enumer
enum Colors < Red Green Blue >;
#= ation

中e̲ò中-丛갨中両(Colors, 'Enumer', 'ation');

#| Even
subset EvenNum of Num where { $^n % 2 == 0 };
#= Numbers

中e̲ò中-丛갨中両(EvenNum, 'Even', 'Numbers');

skip 'declaration comments are NYI on constants', 7;
#`(
#| A cool
constant $pi = 3.14159;
#= constant

test-both($pi.VAR, 'A cool', 'constant');
)

skip 'declaration comments are NYI on variables', 7;
#`(
#| Very
our $fancy-var = 17;
#= fancy!

test-both($fancy-var.VAR, 'Very', 'fancy!');
)

#| where constraints shouldn't
sub 両àò-w̲両e̲сe̲
#= prevent declarative comments
(Int $n where * > 10) {}

中e̲ò中-丛갨中両(&両àò-w̲両e̲сe̲, "where constraints shouldn't", 'prevent declarative comments');

my $丛л갨개k̲ = #| this is
{;
#= a block
};

中e̲ò中-丛갨中両($丛л갨개k̲, 'this is', 'a block');

is $=pod.elems, $𝐩갨𝐝_갢丧𝐝e̲ч;

# vim: expandtab shiftwidth=4
