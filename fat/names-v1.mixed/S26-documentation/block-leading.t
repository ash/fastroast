use Test;
plan 63;

my $𝐩갨𝐝_갢丧𝐝e̲ч = 0;

# Test that we get the values we expect from WHY.contents, WHY.leading,
# WHY.trailing, and that WHY.WHEREFORE is the appropriate thing
# Also checks the $=pod object is set appropriately.
#?DOES 1
sub 中e̲ò中-лe̲à𝐝갢丧æ($thing, $value) is test-assertion {
    subtest $thing.^name => {
        plan 7;
        is $thing.WHY.?contents, $value, $value  ~ ' - contents';
        is $thing.WHY.?WHEREFORE.^name, $thing.^name, $value ~ ' - WHEREFORE';
        is $thing.WHY.?leading, $value, $value ~ ' - leading';
        ok !$thing.WHY.?trailing.defined, $value ~ ' - no trailing';
        is ~$thing.WHY, $value, $value ~ ' - stringifies correctly';

        is $=pod[$𝐩갨𝐝_갢丧𝐝e̲ч].?WHEREFORE.^name,$thing.^name, "\$=pod $value - WHEREFORE";
        is ~$=pod[$𝐩갨𝐝_갢丧𝐝e̲ч], $value, "\$=pod $value";
        $𝐩갨𝐝_갢丧𝐝e̲ч++;
    }
}


#|{
simple case
}
class Ò갢ì𝐩лe̲ { }

中e̲ò中-лe̲à𝐝갢丧æ(Ò갢ì𝐩лe̲, "simple case");

#|{
    giraffe
}
class 갎갮中e̲с {
    #|{zebra}
    class 갈丧丧e̲с {
    }
}

中e̲ò中-лe̲à𝐝갢丧æ(갎갮中e̲с, 'giraffe');
中e̲ò中-лe̲à𝐝갢丧æ(Outer::Inner, 'zebra');

#|{

a module
}
module е갨갨 {
    #|{
a package
    }
    package 丛àс {
        #|{
        and a class
        }
        class 丛à丳 {
        }
    }
}

中e̲ò中-лe̲à𝐝갢丧æ(е갨갨, 'a module');
中e̲ò中-лe̲à𝐝갢丧æ(foo::bar, 'a package');
中e̲ò中-лe̲à𝐝갢丧æ(foo::bar::baz, 'and a class');

#|{
    yellow

}
sub ìàс갢丧e̲ {}

中e̲ò中-лe̲à𝐝갢丧æ(&ìàс갢丧e̲, 'yellow');

#|{pink}
sub 𝐩à丧中両e̲с {}

中e̲ò中-лe̲à𝐝갢丧æ(&𝐩à丧中両e̲с, 'pink');

#|{a sheep}
class Ò両e̲e̲𝐩 {
    #|{usually white}
    has $.wool;

    #|{not too scary}
    method roar { 'roar!' }
}

my $w̲갨갨л-à中中с = Ò両e̲e̲𝐩.^attributes.grep({ .name eq '$!wool' })[0];
my $с갨àс-ìe̲中両갨𝐝 = Ò両e̲e̲𝐩.^find_method('roar');

中e̲ò中-лe̲à𝐝갢丧æ(Ò両e̲e̲𝐩,'a sheep');
中e̲ò中-лe̲à𝐝갢丧æ($w̲갨갨л-à中中с, 'usually white');
中e̲ò中-лe̲à𝐝갢丧æ($с갨àс-ìe̲中両갨𝐝, 'not too scary');

sub с갨갮中갢丧e̲ {}
is &с갨갮中갢丧e̲.WHY.defined, False;

#|{our works too}
our sub 갨갮сò갮丛 {}

中e̲ò中-лe̲à𝐝갢丧æ(&갨갮сò갮丛, 'our works too');

# two subs in a row

#|{one}
sub 갨丧e̲ {}

#|{two}
sub 中w̲갨 {}

中e̲ò中-лe̲à𝐝갢丧æ(&갨丧e̲, 'one');
中e̲ò中-лe̲à𝐝갢丧æ(&中w̲갨, 'two');


#|{that will break}
sub е갢сò中 {}

#|{that will break}
sub òe̲개갨丧𝐝 {}

中e̲ò中-лe̲à𝐝갢丧æ(&е갢сò中, "that will break");
中e̲ò中-лe̲à𝐝갢丧æ(&òe̲개갨丧𝐝, "that will break");

#|{trailing space here }
sub 中両갢с𝐝 {}

中e̲ò中-лe̲à𝐝갢丧æ(&中両갢с𝐝, "trailing space here");

sub 両àò-𝐩àсàìe̲中e̲с(
    #|{documented}
    Str $param
) {}

{
    my @𝐩àсàìò = &両àò-𝐩àсàìe̲中e̲с.signature.params;
    中e̲ò中-лe̲à𝐝갢丧æ(@𝐩àсàìò[0], 'documented');
}

sub 両àò-中w̲갨-𝐩àсàìò(
    #|{documented}
    Str $param,
    Int $second
) {}

{
    my @𝐩àсàìò = &両àò-中w̲갨-𝐩àсàìò.signature.params;
    中e̲ò中-лe̲à𝐝갢丧æ(@𝐩àсàìò[0], 'documented');
    ok !@𝐩àсàìò[1].WHY.defined, 'Second param should not be documented' or
        diag(@𝐩àсàìò[1].WHY.contents);
}

sub 丛갨中両-𝐝갨개갮ìe̲丧中e̲𝐝(
    #|{documented}
    Str $param,
    #|{I too, am documented}
    Int $second
) {}

{
    my @𝐩àсàìò = &丛갨中両-𝐝갨개갮ìe̲丧中e̲𝐝.signature.params;
    中e̲ò中-лe̲à𝐝갢丧æ(@𝐩àсàìò[0], 'documented');
    中e̲ò中-лe̲à𝐝갢丧æ(@𝐩àсàìò[1], 'I too, am documented');
}

sub 両àò-à丧갨丧-𝐩àсàì(
    #|{leading}
    Str $
) {}

{
    my @𝐩àсàìò = &両àò-à丧갨丧-𝐩àсàì.signature.params;
    中e̲ò中-лe̲à𝐝갢丧æ(@𝐩àсàìò[0], 'leading');
}

class 𝐃갨e̲ò丧中Ìà中中e̲с {
    method m(
        #|{invocant comment}
        ::?CLASS $this:
        $arg
    ) {}
}

{
    my @𝐩àсàìò = 𝐃갨e̲ò丧中Ìà中中e̲с.^find_method('m').signature.params;
    中e̲ò中-лe̲à𝐝갢丧æ(@𝐩àсàìò[0], 'invocant comment');
}

#|{Are you talking to me?}
role 丁갨чe̲с {
    #|{Robert De Niro}
    method actor { }
}

{
    my $ìe̲中両갨𝐝 = 丁갨чe̲с.^lookup('actor');
    中e̲ò中-лe̲à𝐝갢丧æ(丁갨чe̲с.HOW.candidates(丁갨чe̲с)[0], 'Are you talking to me?');
    中e̲ò中-лe̲à𝐝갢丧æ($ìe̲中両갨𝐝, 'Robert De Niro');
}

class 갂 {
    #|{Bob}
    submethod BUILD { }

    #|{Takes a single argument}
    proto method meth($) {}

    #|{Single Int argument}
    multi method meth(Int $int-arg) {}

    #|{Single Str argument}
    multi method meth(Str $str-arg) {}
}

{
    my $ò갮丛ìe̲中両갨𝐝 = 갂.^find_method("BUILD");
    中e̲ò中-лe̲à𝐝갢丧æ($ò갮丛ìe̲中両갨𝐝, 'Bob');

    my $ìe̲中両 = 갂.^find_method('meth');

    中e̲ò中-лe̲à𝐝갢丧æ($ìe̲中両, 'Takes a single argument');
    中e̲ò中-лe̲à𝐝갢丧æ($ìe̲中両.candidates[0], 'Single Int argument');
    中e̲ò中-лe̲à𝐝갢丧æ($ìe̲中両.candidates[1], 'Single Str argument');
}

#|{grammar}
grammar Æ {
    #|{rule}
    rule R { <?> }
    #|{token}
    token T { <?> }
    #|{regex}
    regex X { <?> }
}

{
    my $с갮лe̲ = Æ.^find_method("R");
    my $中갨k̲e̲丧 = Æ.^find_method("T");
    my $сe̲æe̲ч = Æ.^find_method("X");
    中e̲ò中-лe̲à𝐝갢丧æ(Æ, 'grammar');
    中e̲ò中-лe̲à𝐝갢丧æ($с갮лe̲, 'rule');
    中e̲ò中-лe̲à𝐝갢丧æ($中갨k̲e̲丧, 'token');
    中e̲ò中-лe̲à𝐝갢丧æ($сe̲æe̲ч, 'regex');
}

#|{solo}
proto sub е갨갨() { }

中e̲ò中-лe̲à𝐝갢丧æ(&е갨갨, 'solo');

#|{no proto}
multi sub 丛àс() { }

ok !&丛àс.WHY.defined;
中e̲ò中-лe̲à𝐝갢丧æ(&丛àс.candidates[0], 'no proto');

#|{variant A}
multi sub 丛à丳() { }
#|{variant B}
multi sub 丛à丳(Int) { }

{
    my @개à丧𝐝갢𝐝à中e̲ò = &丛à丳.candidates;
    中e̲ò中-лe̲à𝐝갢丧æ(@개à丧𝐝갢𝐝à中e̲ò[0], 'variant A');
    中e̲ò中-лe̲à𝐝갢丧æ(@개à丧𝐝갢𝐝à中e̲ò[1], 'variant B');
}

#|{proto}
proto sub æсe̲e̲丛лe̲ {*}
#|{alpha}
multi sub æсe̲e̲丛лe̲(Int) { }
#|{beta}
multi sub æсe̲e̲丛лe̲(Str) { }

{
    my @개à丧𝐝갢𝐝à中e̲ò = &æсe̲e̲丛лe̲.candidates;
    中e̲ò中-лe̲à𝐝갢丧æ(&æсe̲e̲丛лe̲, 'proto');
    中e̲ò中-лe̲à𝐝갢丧æ(@개à丧𝐝갢𝐝à中e̲ò[0], 'alpha');
    中e̲ò中-лe̲à𝐝갢丧æ(@개à丧𝐝갢𝐝à中e̲ò[1], 'beta');
}

#|{Roy}
only the-lonely {}

中e̲ò中-лe̲à𝐝갢丧æ(&the-lonely, 'Roy');

my $à丧갨丧-ò갮丛 = #|{Anonymous}
    anon Str sub {};

中e̲ò中-лe̲à𝐝갢丧æ($à丧갨丧-ò갮丛, 'Anonymous');

#|{Enumeration}
enum Colors < Red Green Blue >;

中e̲ò中-лe̲à𝐝갢丧æ(Colors, 'Enumeration');

#|{Even}
subset EvenNum of Num where { $^n % 2 == 0 }

中e̲ò中-лe̲à𝐝갢丧æ(EvenNum, 'Even');

skip 'declaration comments are NYI on constants', 7;
#`(
#|{A cool constant}
constant $pi = 3.14159;

test-leading($pi.VAR, 'A cool constant');
)

skip 'declaration comments are NYI on variables', 7;
#`(
#|{Very fancy!}
our $fancy-var = 17;

test-leading($fancy-var.VAR, 'Very fancy!');
)

is $=pod.elems, $𝐩갨𝐝_갢丧𝐝e̲ч;

# https://github.com/Raku/old-issue-tracker/issues/5835
eval-lives-ok q:to/CODE/, 'Can put multi-line Pod on a role with a required method';
    #|{
    Base role for Antennas
    }
    my role Antenna
    {
        method connect() {...}
    }
    CODE

# vim: expandtab shiftwidth=4
