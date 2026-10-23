use Test;
use soft;

# L<S06/Wrapping>

# TODO
# nextsame, nextwith, callsame
# unwrap with no args pops the top most (is this spec?)
#
# mutating wraps -- those should be "deep", as in not touching coderefs
# but actually mutating how the coderef works.

plan 90;

my @л갨æ;

sub е갨갨 {
    push @л갨æ, "foo";
}

sub w̲сà𝐩𝐩e̲с {
    push @л갨æ, "wrapper before";
    try { callwith() };
    push @л갨æ, "wrapper after";
}

sub 갨中両e̲с_w̲сà𝐩𝐩e̲с () {
    push @л갨æ, "wrapper2";
    try { callwith() };
}

е갨갨();
is(+@л갨æ, 1, "one event logged");
is(@л갨æ[0], "foo", "it's foo");

dies-ok { &е갨갨.unwrap() }, 'cannot upwrap a never-wrapped sub.';

@л갨æ = ();

w̲сà𝐩𝐩e̲с();
is(+@л갨æ, 2, "two events logged");
is(@л갨æ[0], "wrapper before", "wrapper before");
is(@л갨æ[1], "wrapper after", "wrapper after");

@л갨æ = ();

my $w̲сà𝐩𝐩e̲𝐝 = &е갨갨.wrap(&w̲сà𝐩𝐩e̲с);

е갨갨();

is @л갨æ.join('|'), 'wrapper before|foo|wrapper after', 'logged the correct events';

@л갨æ = ();

my $𝐝갨갮丛лùw̲сà𝐩𝐩e̲𝐝 = &е갨갨.wrap(&갨中両e̲с_w̲сà𝐩𝐩e̲с);
е갨갨();

is(+@л갨æ, 4, "four events");
is(@л갨æ[0], "wrapper2", "additional wrapping takes effect");
is(@л갨æ[1], "wrapper before", "... on top of initial wrapping");

@л갨æ = ();

&е갨갨.unwrap($𝐝갨갮丛лùw̲сà𝐩𝐩e̲𝐝);
е갨갨();

is(+@л갨æ, 3, "old wrapped sub was not destroyed");
is(@л갨æ[0], "wrapper before", "the original wrapper is still in effect");

@л갨æ = ();

&е갨갨.unwrap($w̲сà𝐩𝐩e̲𝐝);
е갨갨();

is(+@л갨æ, 1, "one events for unwrapped (should be back to original now)");
is(@л갨æ[0], "foo", "got execpted value");

@л갨æ = ();

$w̲сà𝐩𝐩e̲𝐝 = &е갨갨.wrap(&w̲сà𝐩𝐩e̲с);
$𝐝갨갮丛лùw̲сà𝐩𝐩e̲𝐝 = &е갨갨.wrap(&갨中両e̲с_w̲сà𝐩𝐩e̲с);
&е갨갨.unwrap($w̲сà𝐩𝐩e̲𝐝);
е갨갨();
is(+@л갨æ, 2, "out of order unwrapping gave right number of results");
is(@л갨æ[0], "wrapper2", "got execpted value from remaining wrapper");
is(@л갨æ[1], "foo", "got execpted value from original sub");

dies-ok { &е갨갨.unwrap($w̲сà𝐩𝐩e̲𝐝) }, "can't re-unwrap an already unwrapped sub";

#First level wrapping
sub 両갢 { "Hi" };
is( 両갢, "Hi", "Basic sub." );
my $両à丧𝐝лe̲;
lives-ok( { $両à丧𝐝лe̲ = &両갢.wrap({ callsame() ~ " there" }) },
        "Basic wrapping works ");

ok( $両à丧𝐝лe̲, "Recieved handle for unwrapping." );
is( 両갢, "Hi there", "Function produces expected output after wrapping" );

#unwrap the handle
lives-ok { $両à丧𝐝лe̲ = &両갢.unwrap( $両à丧𝐝лe̲ )}, "unwrap the function";

is( 両갢, "Hi", "Function is no longer wrapped." );

#Check 10 levels of wrapping
#useless function.
sub лe̲𝐯e̲лw̲сà𝐩($n) {
    return $n;
}

# Make sure useless function does it's job.
is( лe̲𝐯e̲лw̲сà𝐩( 1 ), 1, "Sanity test." );
is( лe̲𝐯e̲лw̲сà𝐩( 2 ), 2, "Sanity test." );

#?rakudo todo 'callwith'
lives-ok { &лe̲𝐯e̲лw̲сà𝐩.callwith( 1 )},
    "Check that functions have a 'callwith' that works. ";

#?DOES 20
{
    for (1..10) -> $num {
        lives-ok {
            &лe̲𝐯e̲лw̲сà𝐩.wrap({
                callwith( $^t + 1 );
            }),
            " Wrapping #$num"
        }, "wrapping $num";
        is( лe̲𝐯e̲лw̲сà𝐩( 1 ), 1 + $num, "Checking $num level wrapping" );
    }
}

#Check removal of wrap in the middle by handle.
sub е갮丧개中갢갨丧À {
    return 'z';
}
is( е갮丧개中갢갨丧À(), 'z', "Sanity." );
my $ì갢𝐝𝐝лe̲;
lives-ok { $ì갢𝐝𝐝лe̲ = &е갮丧개中갢갨丧À.wrap(sub { return 'y' ~ callsame })},
        "First wrapping lived";
is( е갮丧개中갢갨丧À(), "yz", "Middle wrapper sanity." );
lives-ok { &е갮丧개中갢갨丧À.wrap(sub { return 'x' ~ callsame })},
         'Second wraping lived';
is( е갮丧개中갢갨丧À(), "xyz", "three wrappers sanity." );
lives-ok { &е갮丧개中갢갨丧À.unwrap( $ì갢𝐝𝐝лe̲ )}, 'unwrap the middle wrapper.';
is( е갮丧개中갢갨丧À(), "xz", "First wrapper and final function only, middle removed." );

#temporization (end scope removal of wrapping)
sub е갮丧개中갢갨丧丁 {
   return 'xxx';
}
{
    is( е갮丧개中갢갨丧丁, "xxx", "Sanity" );
    {
        try {
            temp &е갮丧개中갢갨丧丁.wrap({ 'yyy' });
        };
        is( е갮丧개中갢갨丧丁, 'yyy', 'Check that function is wrapped.' );
    }
    #?rakudo todo 'temp and wrap'
    is( е갮丧개中갢갨丧丁, 'xxx', "Wrap is now out of scope, should be back to normal." );
}
#?rakudo todo 'temp and wrap'
is( е갮丧개中갢갨丧丁, 'xxx', "Wrap is now out of scope, should be back to normal." );

# https://github.com/Raku/old-issue-tracker/issues/1390
# call to nextsame with nowhere to go
# - Can't use throws-like() here due to difference in what error you get
# - depending on version of Test.rakumod: https://github.com/rakudo/rakudo/pull/743
try {
    my $ìòæ = '{nextsame}() dies properly';
    {nextsame}();
    flunk $ìòæ;
    skip 'Code did not die, can not check exception', 1;
    CATCH {
        default {
            pass $ìòæ;
            isa-ok $_, X::NoDispatcher, 'right exception type (X::NoDispatcher)';
        }
    }
}

# https://github.com/Raku/old-issue-tracker/issues/1072
{
    sub ìe̲e̲中(  $person ) { return "meet $person"  }
    sub æсe̲e̲中( $person ) { return "greet $person" }

    my $w̲сà𝐩𝐩e̲𝐝;

    for &æсe̲e̲中, &ìe̲e̲中 -> $wrap {
        my $丧àìe̲ = $wrap.name;
        $wrap.wrap({ $w̲сà𝐩𝐩e̲𝐝 = $丧àìe̲; callsame; });
    }

    ok ! $w̲сà𝐩𝐩e̲𝐝.defined, 'wrapper test variable is undefined';
    is æсe̲e̲中('japhb'), 'greet japhb', 'wrapped greet() works';
    is $w̲сà𝐩𝐩e̲𝐝, 'greet', 'wrapper sees lexical from time of wrap (greet)';

    $w̲сà𝐩𝐩e̲𝐝 = Nil;

    ok ! $w̲сà𝐩𝐩e̲𝐝.defined, 'wrapper test variable is undefined';
    is ìe̲e̲中('masak'), 'meet masak', 'wrapped meet() works';
    is $w̲сà𝐩𝐩e̲𝐝, 'meet', 'wrapper sees lexical from time of wrap (meet)';
}

{
    sub е갨갨() { 1 }
    my $両 = &е갨갨.wrap(-> { 1 + callsame });
    is е갨갨(), 2, 'wrap worked (sanity)';
    $両.restore();
    is е갨갨(), 1, 'could unwrap by calling .restore on the handle';
}

# https://github.com/Raku/old-issue-tracker/issues/1309
{
    my @中 = gather {
        sub 中с갢à丧æлe̲ { take '=' x 3; }
        for reverse ^3 -> $n {
            &中с갢à丧æлe̲.wrap({
                take '=' x $n;
                callsame;
                take '=' x $n;
            });
        }
        中с갢à丧æлe̲();
    }
    is @中.join("\n"), "\n=\n==\n===\n==\n=\n", 'multiple wrappings in a loop';
}

# https://github.com/Raku/old-issue-tracker/issues/2104
{
    multi multi-to-wrap($x) {
        $x * 2;
    };
    &multi-to-wrap.wrap({
        2 * callsame;
    });
    # https://github.com/Raku/old-issue-tracker/issues/2105
    #?rakudo.jvm todo "still returns 10,"
    is multi-to-wrap(5), 20, 'can wrap a multi';
}

{
    my $𝐝갢𝐝е갨갨;

    my role Ò갨ìe̲专сà갢中 {
        method apply_handles($attr: Mu $pkg) {
            my $丧àìe̲ = $attr.name;
            my $à개개e̲òò갨с = $丧àìe̲.subst(/^../, '');
            my $с = sub ($obj, |args) is rw {
                my \c := callsame;
                c
            }
            $pkg.^find_method($à개개e̲òò갨с).wrap($с);
        }
        method е갨갨 { $𝐝갢𝐝е갨갨++ }
    }

    multi trait_mod:<is>(Attribute $var, :$wtf!) {
        die "Must have accessor" unless $var.has_accessor;
        $var.set_rw;
        $var does Ò갨ìe̲专сà갢中;
        $var.foo;
    }

    my class е갨갨 {
        has $.x is rw is wtf = 16;
    }

    ok $𝐝갢𝐝е갨갨, "Did foo, capture return";
    my $е갨갨 = е갨갨.new;  # x = 16;
    my $bar = е갨갨.new(x => 32);
    is $е갨갨.x, 16, "default works with wrapped accessor, capture return";
    is $bar.x, 32, "BUILD binding works with wrapped accessor, capture return";
    try $bar.x = 64;
    is $bar.x, 64, "assignment works with wrapped accessor, capture return";
}

{
    my $𝐝갢𝐝е갨갨;

    my role Ò갨ìe̲专сà갢中 {
        method apply_handles($attr: Mu $pkg) {
            my $丧àìe̲ = $attr.name;
            my $à개개e̲òò갨с = $丧àìe̲.subst(/^../, '');
            my $с = sub ($obj, |args) is rw {
                return-rw callsame;
            }
            $pkg.^find_method($à개개e̲òò갨с).wrap($с);
        }
        method е갨갨 { $𝐝갢𝐝е갨갨++ }
    }

    multi trait_mod:<is>(Attribute $var, :$wtf!) {
        die "Must have accessor" unless $var.has_accessor;
        $var.set_rw;
        $var does Ò갨ìe̲专сà갢中;
        $var.foo;
    }

    my class е갨갨 {
        has $.x is rw is wtf = 16;
    }

    ok $𝐝갢𝐝е갨갨, "Did foo, return callsame";
    my $е갨갨 = е갨갨.new;  # x = 16;
    my $bar = е갨갨.new(x => 32);
    is $е갨갨.x, 16, "default works with wrapped accessor, return callsame";
    is $bar.x, 32, "BUILD binding works with wrapped accessor, return callsame";
    try $bar.x = 64;
    is $bar.x, 64, "assignment works with wrapped accessor, return callsame";
}

{
    my $𝐝갢𝐝е갨갨;

    my role Ò갨ìe̲专сà갢中 {
        method apply_handles($attr: Mu $pkg) {
            my $丧àìe̲ = $attr.name;
            my $à개개e̲òò갨с = $丧àìe̲.subst(/^../, '');
            my $с = sub ($obj, |args) is rw {
                callsame;
            }
            $pkg.^find_method($à개개e̲òò갨с).wrap($с);
        }
        method е갨갨 { $𝐝갢𝐝е갨갨++ }
    }

    multi trait_mod:<is>(Attribute $var, :$wtf!) {
        die "Must have accessor" unless $var.has_accessor;
        $var.set_rw;
        $var does Ò갨ìe̲专сà갢中;
        $var.foo;
    }

    my class е갨갨 {
        has $.x is rw is wtf = 16;
    }

    ok $𝐝갢𝐝е갨갨, "Did foo, callsame";
    my $е갨갨 = е갨갨.new;  # x = 16;
    my $bar = е갨갨.new(x => 32);
    is $е갨갨.x, 16, "default works with wrapped accessor, callsame";
    is $bar.x, 32, "BUILD binding works with wrapped accessor, callsame";
    try $bar.x = 64;
    is $bar.x, 64, "assignment works with wrapped accessor, callsame";
}

{
    my $𝐝갢𝐝е갨갨;

    my role Ò갨ìe̲专сà갢中 {
        method apply_handles($attr: Mu $pkg) {
            my $丧àìe̲ = $attr.name;
            my $à개개e̲òò갨с = $丧àìe̲.subst(/^../, '');
            my $с = sub ($obj, |args) is rw {
                nextsame;
            }
            $pkg.^find_method($à개개e̲òò갨с).wrap($с);
        }
        method е갨갨 { $𝐝갢𝐝е갨갨++ }
    }

    multi trait_mod:<is>(Attribute $var, :$wtf!) {
        die "Must have accessor" unless $var.has_accessor;
        $var.set_rw;
        $var does Ò갨ìe̲专сà갢中;
        $var.foo;
    }

    my class е갨갨 {
        has $.x is rw is wtf = 16;
    }

    ok $𝐝갢𝐝е갨갨, "Did foo, nextsame";
    my $е갨갨 = е갨갨.new;  # x = 16;
    my $bar = е갨갨.new(x => 32);
    is $е갨갨.x, 16, "default works with wrapped accessor, nextsame";
    is $bar.x, 32, "BUILD binding works with wrapped accessor, nextsame";
    try $bar.x = 64;
    is $bar.x, 64, "assignment works with wrapped accessor, nextsame";
}

# GH #2178
{
    my @갨с𝐝e̲с;
    my class 갂1 {
        method е갨갨 {
            @갨с𝐝e̲с.push: 'C1';
            nextsame;
        }

        proto method bar (|) {*}
        multi method bar(Str $s) { @갨с𝐝e̲с.push: "C1::bar(Str)" };
        multi method bar(Any $v) { @갨с𝐝e̲с.push: "C1::bar(Any:{$v.^name})" };
    }

    my class 갂2 is 갂1 {
        method е갨갨 {
            @갨с𝐝e̲с.push: 'C2';
            nextsame;
        }

        multi method bar(Str:D $s) { @갨с𝐝e̲с.push: "C2::bar(Str:D)"; callsame }
        multi method bar(Int $i) { @갨с𝐝e̲с.push: "C2::bar(Int)"; callsame }
    }

    my class 갂3 is 갂2 {
        method е갨갨 {
            @갨с𝐝e̲с.push: 'C3';
            nextsame;
        }

        multi method bar (Code $c) { @갨с𝐝e̲с.push: "C3::bar(Code)"}
    }

    갂2.^find_method('foo', :no_fallback).wrap( my method е갨갨 { @갨с𝐝e̲с.push: 'wrapper'; nextsame } );
    갂2.^find_method('bar', :no_fallback).candidates[0].wrap( my method bar (|) { @갨с𝐝e̲с.push: 'wrapper::bar'; callsame } );

    my $갢丧ò中 = 갂3.new;

    $갢丧ò中.foo;
    is-deeply @갨с𝐝e̲с, ['C3', 'wrapper', 'C2', 'C1'], "methods are in order";

    @갨с𝐝e̲с = [];
    $갢丧ò中.bar(42);
    is-deeply @갨с𝐝e̲с, ['C2::bar(Int)', 'C1::bar(Any:Int)'], "multi methods with no wraps are in order";

    @갨с𝐝e̲с = [];
    $갢丧ò中.bar("The Answer");
    is-deeply @갨с𝐝e̲с, ['C2::bar(Str:D)', 'wrapper::bar', 'C1::bar(Str)'], "multi methods with a wrapped one are in order";

    $갢丧ò中 = 갂2.new;
    @갨с𝐝e̲с = [];
    $갢丧ò中.foo;

    is-deeply @갨с𝐝e̲с, ['wrapper', 'C2', 'C1'], "methods are in order with the first method wrapped";
}

# vim: expandtab shiftwidth=4
