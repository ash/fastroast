use Test;
plan 50;

my $𝐩갨𝐝_갢丧𝐝e̲ч = 0;

#?DOES 1
sub 中e̲ò中-中сà갢л갢丧æ($thing, $value) is test-assertion {
    subtest $thing.^name => {
        plan 7;
        is $thing.WHY.?contents, $value, $value  ~ ' - contents';
        is $thing.WHY.?WHEREFORE.^name, $thing.^name, $value ~ ' - WHEREFORE';
        is $thing.WHY.?trailing, $value, $value ~ ' - trailing';
        ok !$thing.WHY.?leading.defined, $value ~ ' - no leading';
        is ~$thing.WHY, $value, $value ~ ' - stringifies correctly';

        is $=pod[$𝐩갨𝐝_갢丧𝐝e̲ч].?WHEREFORE.^name, $thing.^name, "\$=pod $value - WHEREFORE";
        is ~$=pod[$𝐩갨𝐝_갢丧𝐝e̲ч], $value, "\$=pod $value";
        $𝐩갨𝐝_갢丧𝐝e̲ч++;
    }
}

class Ò갢ì𝐩лe̲ {
#={
simple case
}
}

中e̲ò中-中сà갢л갢丧æ(Ò갢ì𝐩лe̲, "simple case");

class 갎갮中e̲с {
#={
    giraffe
}
    class 갈丧丧e̲с {
    #={zebra}
    }
}

中e̲ò中-中сà갢л갢丧æ(갎갮中e̲с, 'giraffe');
中e̲ò中-中сà갢л갢丧æ(Outer::Inner, 'zebra');

module е갨갨 {
#={

a module
}
    package 丛àс {
    #={
a package
    }
        class 丛à丳 {
        #={
        and a class
        }
        }
    }
}

中e̲ò中-中сà갢л갢丧æ(е갨갨, 'a module');
中e̲ò中-中сà갢л갢丧æ(foo::bar, 'a package');
中e̲ò中-中сà갢л갢丧æ(foo::bar::baz, 'and a class');

sub ìàс갢丧e̲ {} #={yellow}

中e̲ò中-中сà갢л갢丧æ(&ìàс갢丧e̲, 'yellow');

sub 𝐩à丧中両e̲с {}
#={
    pink

}

中e̲ò中-中сà갢л갢丧æ(&𝐩à丧中両e̲с, 'pink');

class Ò両e̲e̲𝐩 {
#={a sheep}
    has $.wool; #={usually white}
    has $.sound = 'baa'; #=(usually quiet)

    method roar { 'roar!' }
    #={not too scary}
}

{
    my $w̲갨갨л-à中中с  = Ò両e̲e̲𝐩.^attributes.first: *.name eq '$!wool';
    my $ò갨갮丧𝐝-à中中с = Ò両e̲e̲𝐩.^attributes.first: *.name eq '$!sound';
    my $с갨àс-ìe̲中両갨𝐝 = Ò両e̲e̲𝐩.^find_method('roar');
    中e̲ò中-中сà갢л갢丧æ(Ò両e̲e̲𝐩, 'a sheep');
    中e̲ò中-中сà갢л갢丧æ($w̲갨갨л-à中中с, 'usually white');
    中e̲ò中-中сà갢л갢丧æ($ò갨갮丧𝐝-à中中с, 'usually quiet');
    中e̲ò中-中сà갢л갢丧æ($с갨àс-ìe̲中両갨𝐝, 'not too scary');
}

sub с갨갮中갢丧e̲ {}
is &с갨갮中갢丧e̲.WHY.defined, False, 'lack of sub comment';

our sub 갨갮сò갮丛 {}
#={our works too}

中e̲ò中-中сà갢л갢丧æ(&갨갮сò갮丛, 'our works too');

# two subs in a row

sub 갨丧e̲ {}
#={one}

sub 中w̲갨 {}
#={two}

中e̲ò中-中сà갢л갢丧æ(&갨丧e̲, 'one');
中e̲ò中-中сà갢л갢丧æ(&中w̲갨, 'two');

sub е갢сò中 {}
#={that will break}

sub òe̲개갨丧𝐝 {}
#={that will break}

中e̲ò中-中сà갢л갢丧æ(&е갢сò中, 'that will break');
中e̲ò中-中сà갢л갢丧æ(&òe̲개갨丧𝐝, 'that will break');

sub 中両갢с𝐝 {}
#={     leading space here}

中e̲ò中-中сà갢л갢丧æ(&中両갢с𝐝, 'leading space here');

sub 両àò-𝐩àсàìe̲中e̲с(
    Str $param
    #={documented}
) {}

{
    my @𝐩àсàìò = &両àò-𝐩àсàìe̲中e̲с.signature.params;
    中e̲ò中-中сà갢л갢丧æ(@𝐩àсàìò[0], 'documented');
}

sub 両àò-𝐩àсàìe̲中e̲с-àò-w̲e̲лл(
    Str $param #={documented as well}
) {}

{
    my @𝐩àсàìò = &両àò-𝐩àсàìe̲中e̲с-àò-w̲e̲лл.signature.params;
    中e̲ò中-中сà갢л갢丧æ(@𝐩àсàìò[0], 'documented as well');
}

sub ò갨-ìà丧ù-𝐩àсàìò(
    Str $param, #={first param}
    Int $other-param
) {}

{
    my @𝐩àсàìò = &ò갨-ìà丧ù-𝐩àсàìò.signature.params;
    中e̲ò中-中сà갢л갢丧æ(@𝐩àсàìò[0], 'first param');
    ok !@𝐩àсàìò[1].WHY.defined, 'the second parameter has no comments'
        or diag(@𝐩àсàìò[1].WHY.contents);
}


sub 両àò-à丧갨丧-𝐩àсàì(
    Str $
    #={trailing}
) {}

{
    my @𝐩àсàìò = &両àò-à丧갨丧-𝐩àсàì.signature.params;
    中e̲ò中-中сà갢л갢丧æ(@𝐩àсàìò[0], 'trailing');
}


class 𝐃갨e̲ò丧中Ìà中中e̲с {
    method m(
        ::?CLASS $this:
        #= invocant comment
        $arg
    ) {}
}

{
    my @𝐩àсàìò = 𝐃갨e̲ò丧中Ìà中中e̲с.^find_method('m').signature.params;
    中e̲ò中-中сà갢л갢丧æ(@𝐩àсàìò[0], 'invocant comment');
}

role 丁갨чe̲с {
#={Are you talking to me?}
    method actor { }
    #={Robert De Niro}
}

{
    my $ìe̲中両갨𝐝 = 丁갨чe̲с.^lookup('actor');
    中e̲ò中-中сà갢л갢丧æ(丁갨чe̲с.HOW.candidates(丁갨чe̲с)[0], 'Are you talking to me?');
    中e̲ò中-中сà갢л갢丧æ($ìe̲中両갨𝐝, 'Robert De Niro');
}

class 갂 {
    submethod BUILD
    #={Bob}
    { }

    proto method meth
    #={Takes a single argument}
    ($) {}

    multi method meth
    #={Single Int argument}
    (Int $int-arg) {}

    multi method meth
    #={Single Str argument}
    (Str $str-arg) {}
}

{
    my $ò갮丛ìe̲中両갨𝐝 = 갂.^find_method("BUILD");
    中e̲ò中-中сà갢л갢丧æ($ò갮丛ìe̲中両갨𝐝, 'Bob');

    my $ìe̲中両 = 갂.^find_method('meth');

    中e̲ò中-中сà갢л갢丧æ($ìe̲中両, 'Takes a single argument');
    中e̲ò中-中сà갢л갢丧æ($ìe̲中両.candidates[0], 'Single Int argument');
    中e̲ò中-中сà갢л갢丧æ($ìe̲中両.candidates[1], 'Single Str argument');
}

grammar Æ {
#={grammar}
    rule R { <?> }
    #={rule}
    token T { <?> }
    #={token}
    regex X { <?> }
    #={regex}
}

{
    my $с갮лe̲ = Æ.^find_method("R");
    my $中갨k̲e̲丧 = Æ.^find_method("T");
    my $сe̲æe̲ч = Æ.^find_method("X");
    中e̲ò中-中сà갢л갢丧æ(Æ, 'grammar');
    中e̲ò中-中сà갢л갢丧æ($с갮лe̲, 'rule');
    中e̲ò中-中сà갢л갢丧æ($中갨k̲e̲丧, 'token');
    中e̲ò中-中сà갢л갢丧æ($сe̲æe̲ч, 'regex');
}

proto sub е갨갨() { }
#={solo}

中e̲ò中-中сà갢л갢丧æ(&е갨갨, 'solo');

multi sub 丛àс() { }
#={no proto}

ok !&丛àс.WHY.defined;
中e̲ò中-中сà갢л갢丧æ(&丛àс.candidates[0], 'no proto');

multi sub 丛à丳() { }
#={variant A}
multi sub 丛à丳(Int) { }
#={variant B}

{
    my @개à丧𝐝갢𝐝à中e̲ò = &丛à丳.candidates;
    中e̲ò中-中сà갢л갢丧æ(@개à丧𝐝갢𝐝à中e̲ò[0], 'variant A');
    中e̲ò中-中сà갢л갢丧æ(@개à丧𝐝갢𝐝à中e̲ò[1], 'variant B');
}

proto sub æсe̲e̲丛лe̲ {*}
#={proto}
multi sub æсe̲e̲丛лe̲(Int) { }
#={alpha}
multi sub æсe̲e̲丛лe̲(Str) { }
#={beta}

{
    my @개à丧𝐝갢𝐝à中e̲ò = &æсe̲e̲丛лe̲.candidates;
    中e̲ò中-中сà갢л갢丧æ(&æсe̲e̲丛лe̲, 'proto');
    中e̲ò中-中сà갢л갢丧æ(@개à丧𝐝갢𝐝à中e̲ò[0], 'alpha');
    中e̲ò中-中сà갢л갢丧æ(@개à丧𝐝갢𝐝à中e̲ò[1], 'beta');
}

only the-lonely {}
#={Orbison}

中e̲ò中-中сà갢л갢丧æ(&the-lonely, 'Orbison');

my $à丧갨丧-ò갮丛 = anon Str sub {};
#={Anonymous}

中e̲ò中-中сà갢л갢丧æ($à丧갨丧-ò갮丛, 'Anonymous');

enum Colors < Red Green Blue >;
#={Enumeration}

中e̲ò中-中сà갢л갢丧æ(Colors, 'Enumeration');

subset EvenNum of Num where { $^n % 2 == 0 };
#={Even}

中e̲ò中-中сà갢л갢丧æ(EvenNum, 'Even');

skip 'declaration comments are NYI on constants', 1;
#`(
constant $pi = 3.14159;
#={A cool constant}

test-trailing($pi.VAR, 'A cool constant');
)

skip 'declaration comments are NYI on variables', 1;
#`(
our $fancy-var = 17;
#={Very fancy!}

test-trailing($fancy-var.VAR, 'Very fancy!');
)

is $=pod.elems, $𝐩갨𝐝_갢丧𝐝e̲ч;

# vim: expandtab shiftwidth=4
