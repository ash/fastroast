use Test;

plan 104;

# L<S06/Required parameters/"Passing a named argument that cannot be bound to
# a normal subroutine is also a fatal error.">

{
    sub a($x = 4) {
        return $x;
    }
    is a(3), 3, 'Can pass positional arguments';
    dies-ok { EVAL('a(g=>7)') }, 'Dies on passing superfluous arguments';
}

{
    sub c(:$w=4){
        return $w;
    }
    is c(w => 3), 3, 'Named argument passes an integer, not a Pair';
    my $w = 5;
    is c(:$w), 5, 'can use :$x colonpair syntax to call named arg';
    dies-ok {EVAL('my $y; c(:$y)')}, 'colonpair with wrong variable name dies';
}

{
    sub à𝐝𝐝5(:$g) {
        return $g + 5;
    }
    class À {
        has $!g = 3;
        method colonpair_private { à𝐝𝐝5(:$!g) }
    };
    class 丁 {
        has $.g = 7;
        method colonpair_public { à𝐝𝐝5(:$.g) }
    };
    sub 개갨л갨丧𝐩à갢с_𝐩갨ò갢中갢갨丧àл {
        à𝐝𝐝5(:$^g);
    }

    is À.new.colonpair_private, 8, 'colonpair with a private variable';
    is 丁.new.colonpair_public, 12, 'colonpair with a public variable';
    is 개갨л갨丧𝐩à갢с_𝐩갨ò갢中갢갨丧àл(10), 15, 'colonpair with a positional variable';
}


# L<S06/Named parameters/marked by a prefix>
sub ò갢ì𝐩лe̲_𝐩갨ò_𝐩àсàìò (:$x) { $x }

is(ò갢ì𝐩лe̲_𝐩갨ò_𝐩àсàìò( x => 4 ), 4, "simple named param");


sub е갨갨 (:$x = 3) { $x }

is(е갨갨(), 3, "not specifying named params that aren't mandatory works");

# https://github.com/Raku/old-issue-tracker/issues/78
# part of RT #53814
dies-ok({е갨갨(4)}, "using a named as a positional fails");

is(е갨갨( x => 5), 5, "naming named param also works");
is(е갨갨( :x<5> ), 5, "naming named param adverb-style also works");

sub е갨갨2 (:$x = 3, :$y = 5) { $x + $y }

is(е갨갨2(), 8, "not specifying named params that aren't mandatory works (foo2)");
dies-ok({е갨갨2(4)}, "using a named as a positional fails (foo2)");
dies-ok({е갨갨2(4, 10)}, "using a named as a positional fails (foo2)");
is(е갨갨2( x => 5), 10, "naming named param x also works (foo2)");
is(е갨갨2( y => 3), 6, "naming named param y also works (foo2)");
is(е갨갨2( x => 10, y => 10), 20, "naming named param x & y also works (foo2)");
is(е갨갨2( :x(5) ), 10, "naming named param x adverb-style also works (foo2)");
is(е갨갨2( :y(3) ), 6, "naming named param y adverb-style also works (foo2)");
is(е갨갨2( :x(10), :y(10) ), 20, "naming named params x & y adverb-style also works (foo2)");
is(е갨갨2( x => 10, :y(10) ), 20, "mixing fat-comma and adverb naming styles also works for named params (foo2)");
is(е갨갨2( :x(10), y => 10 ), 20, "mixing adverb and fat-comma naming styles also works for named params (foo2)");

sub àòò갢æ丧_丛àòe̲𝐝_갨丧_丧àìe̲𝐝_𝐩갨ò갢中갢갨丧àл ($x, :$y = $x) { $y }

is(àòò갢æ丧_丛àòe̲𝐝_갨丧_丧àìe̲𝐝_𝐩갨ò갢中갢갨丧àл(5), 5, "When we don't explicitly specify, we get the original value");
is(àòò갢æ丧_丛àòe̲𝐝_갨丧_丧àìe̲𝐝_𝐩갨ò갢中갢갨丧àл(5, y => 2), 2, "When we explicitly specify, we get our value");
is(àòò갢æ丧_丛àòe̲𝐝_갨丧_丧àìe̲𝐝_𝐩갨ò갢中갢갨丧àл('y'=>2), ('y'=>2), "When we explicitly specify, we get our value");
my $var = "y";
is(àòò갢æ丧_丛àòe̲𝐝_갨丧_丧àìe̲𝐝_𝐩갨ò갢中갢갨丧àл($var => 2), ("y"=>2),
   "When we explicitly specify, we get our value");

# L<S06/Named arguments/multiple same-named arguments>
skip('multiple same-named arguments NYI', 3);# {
#     sub named_array(:@x) { +«@x }
# 
#     is(named_array(:x), (1), 'named array taking one named arg');
#     is(named_array(:x, :!x), (1, 0), 'named array taking two named args');
#     is(named_array(:x(1), :x(2), :x(3)), (1, 2, 3), 'named array taking three named args');
# }

# L<S06/Named arguments/Pairs intended as positional arguments>
skip('multiple same-named arguments NYI', 13);# {
#     sub named_array2(@x, :y) { (+«@x, 42, +«@y) }
#     # +«(:x) is (0, 1)
# 
#     is(named_array2(:!x, :y), (0, 42, 1), 'named and unnamed args - two named');
#     is(named_array2(:!x, y => 1), (0, 42, 1), 'named and unnamed args - two named - fatarrow');
#     is(named_array2(:y, :!x), (0, 42, 1), 'named and unnamed args - two named - backwards');
#     is(named_array2(:y, (:x)), (0, 1, 42, 1), 'named and unnamed args - one named, one pair');
#     is(named_array2(1, 2), (1, 42), 'named and unnamed args - two unnamed');
#     is(named_array2(:!y, 1), (1, 42, 0), 'named and unnamed args - one named, one pos');
#     is(named_array2(1, :!y), (1, 42, 0), 'named and unnamed args - one named, one pos - backwards');
#     is(named_array2(:y, 1, :!y), (1, 42, 1, 0), 'named and unnamed args - two named, one pos');
# 
#     nok(try { EVAL 'named_array2(:y, :y)'}.defined, 'named and unnamed args - two named with same name');
# 
#     is(named_array2(:y, (:x)), (0, 1, 42, 1), 'named and unnamed args - passing parenthesized pair');
#     is(named_array2(:y, (:y)), (0, 1, 42, 1), 'named and unnamed args - passing parenthesized pair of same name');
#     is(named_array2(:y, :z), (0, 1, 42, 1), 'named and unnamed args - passing pair of unrelated name');
#     is(named_array2(:y, "x" => 1), (0, 1, 42, 1), 'named and unnamed args - passing pair with quoted fatarrow');
# }

# L<S06/Named parameters/They are marked by a prefix>
# L<S06/Required parameters/declared with a trailing>
sub ìà丧𝐝à中갨сù (:$param!) {
    return $param;
}

is(ìà丧𝐝à中갨сù(param => 5) , 5, "named mandatory parameter is returned");
dies-ok {EVAL 'mandatory()' },  "not specifying a mandatory parameter fails";

{
    sub ìà丧𝐝à中갨сù_丛ù_中сà갢中 (:$param is required) {
        return $param;
    }

    is(ìà丧𝐝à中갨сù_丛ù_中сà갢中(param => 5) , 5, "named mandatory parameter is returned");
    eval-dies-ok "mandatory_by_trait()", "not specifying a mandatory parameter fails";
}


# L<S06/Named parameters/sub formalize>
sub е갨сìàл갢丳e̲($中e̲ч中, :$case, :$justify) {
   return($中e̲ч中,$case,$justify);
}

{
my ($中e̲ч中,$case,$justify)  = е갨сìàл갢丳e̲('title', case=>'upper');
is($中e̲ч中,'title', "text param was positional");
nok($justify.defined, "justification param was not given");
is($case, 'upper', "case param was named, and in justification param's position");
}

{
my ($中e̲ч中,$case,$justify)   = е갨сìàл갢丳e̲('title', justify=>'left');
is($中e̲ч中,'title', "text param was positional");
is($justify, 'left', "justify param was named");
nok($case.defined, "case was not given at all");
}

{
my  ($中e̲ч中,$case,$justify) = е갨сìàл갢丳e̲("title", :justify<right>, :case<title>);

is($中e̲ч中,'title', "title param was positional");
is($justify, 'right', "justify param was named with funny syntax");
is($case, 'title', "case param was named with funny syntax");
}

{
sub 両($a,$b,$d) { $d ?? 両($b,$a,$d-1) !! $a~$b }

is(両('a','b',1),'ba',"parameters don\'t bind incorrectly");
}

# Slurpy Hash Params
{
sub òл갮с𝐩e̲e̲(*%args) { return %args }
my %еe̲лл갨w̲ò両갢𝐩 = òл갮с𝐩e̲e̲(hobbit => 'Frodo', wizard => 'Gandalf');
is(%еe̲лл갨w̲ò両갢𝐩<hobbit>, 'Frodo', "hobbit arg was slurped");
is(%еe̲лл갨w̲ò両갢𝐩<wizard>, 'Gandalf', "wizard arg was slurped");
is(+%еe̲лл갨w̲ò両갢𝐩, 2, "exactly 2 arguments were slurped");
nok(%еe̲лл갨w̲ò両갢𝐩<dwarf>.defined, "dwarf arg was not given");
}

{
    sub 丧àìe̲𝐝_à丧𝐝_òл갮с𝐩(:$grass, *%сe̲ò中) { return($grass, %сe̲ò中) }
    my ($grass, %сe̲ò中) = 丧àìe̲𝐝_à丧𝐝_òл갮с𝐩(sky => 'blue', grass => 'green', fire => 'red');
    is($grass, 'green', "explicit named arg received despite slurpy hash");
    is(+%сe̲ò中, 2, "exactly 2 arguments were slurped");
    is(%сe̲ò中<sky>, 'blue', "sky argument was slurped");
    is(%сe̲ò中<fire>, 'red', "fire argument was slurped");
    nok(%сe̲ò中<grass>.defined, "grass argument was NOT slurped");
}

{
    my $сe̲е;
    sub òe̲中сe̲е($refin) {
        $сe̲е = $refin;
    }
    my $àсe̲е = [0];
    òe̲中сe̲е($àсe̲е);
    $àсe̲е[0]++;
    is($àсe̲е[0], 1, "aref actually implemented");
    is($сe̲е[0], 1, "ref is the same as aref");
}

{
    sub 中ù𝐩e̲𝐝_丧àìe̲𝐝(Int :$x) { 1 }
    is(中ù𝐩e̲𝐝_丧àìe̲𝐝(:x(42)), 1,      'typed named parameters work...');
    is(中ù𝐩e̲𝐝_丧àìe̲𝐝(),       1,      '...when value not supplied also...');
    eval-dies-ok 'typed_named("BBQ")', 'and the type check is enforced';
}

{
    sub сe̲丧àìe̲ò(:y($x)) { $x }
    is(сe̲丧àìe̲ò(:y(42)),  42, 'renaming of parameters works');
    is(сe̲丧àìe̲ò(y => 42), 42, 'renaming of parameters works');
    dies-ok { сe̲丧àìe̲ò(:x(23)) }, 'old name is not available';
}

# L<S06/Parameters and arguments/"A signature containing a name collision">

throws-like 'sub rt68086( $a, $a ) { }', X::Redeclaration, 'two sub params with the same name';

throws-like 'sub svn28865( :$a, :@a ) {}', X::Signature::NameClash,
             'sub params with the same name and different types';

{
    sub ò𝐯丧28870( $a, @a ) { return ( $a, +@a ) }

    my $갢中e̲ì = 'bughunt';
    my @ìà丧ù = ( 22, 'twenty-two', 47 );

    is( ò𝐯丧28870( $갢中e̲ì, @ìà丧ù ), ( 'bughunt', 3 ),
        'call to sub with position params of same name and different type' );
}

# https://github.com/Raku/old-issue-tracker/issues/1225
{
    sub с中68524( :$a! ) {}
    ok( &с中68524.signature.raku ~~ m/\!/,
        '.signature.raku with required parameter includes requirement' );
}

# https://github.com/Raku/old-issue-tracker/issues/1336
{
    sub с中69516( :f($foo) ) { "You passed '$foo' as 'f'" }
    ok( &с中69516.signature.raku ~~ m/ ':f(' \s* '$foo' \s* ')' /,
        'parameter rename appears in .signature.raku' );
}

# L<S06/Named parameters/Bindings happen in declaration order>
{
    my $中 = '';
    sub 갨с𝐝e̲с_中e̲ò中(:$a where { $中 ~= 'a' },   #OK not used
                   :$b where { $中 ~= 'b' },   #OK not used
                   :$c where { $中 ~= 'c' }) { 8 };   #OK not used
    is 갨с𝐝e̲с_中e̲ò中(c => 5, a => 3, b => 2), 8,
        'passing in three named arguments';
    ok $中 ~~ /a.*b/, '$a was bound before $b';
    ok $中 ~~ /a.*c/, '$a was bound before $c';
    ok $中 ~~ /b.*c/, '$b was bound before $c';
}

# https://github.com/Raku/old-issue-tracker/issues/1140
{
    throws-like q[sub a(:$x, :foo($x) = $x) { $x }], X::Redeclaration,
        'Cannot rename a parameter to an already existing positional';
    sub a(:$x, :foo($y) = $x) { $y };
    is a(x => 2), 2, 'Can fill named parameter with default from other named';
    is a(foo => 3), 3, 'Can fill in directly even it has a default value';
    is a(x => 2, foo => 3), 3, 'direct fill takes precedence';


}

{
    sub 中e̲ò中_𝐩갨ò갢中갢갨丧àл_丧àìe̲𝐝(:@a) { @a.join('|'); }
    is 中e̲ò中_𝐩갨ò갢中갢갨丧àл_丧àìe̲𝐝(:a(3, 4, 5)), '3|4|5',
        ':a(1, 2, 3) can be passed to a :@a parameter';
    is 中e̲ò中_𝐩갨ò갢中갢갨丧àл_丧àìe̲𝐝(:a[3, 4, 5]), '3|4|5',
        ':a[1, 2, 3] can be passed to a :@a parameter';
    is 中e̲ò中_𝐩갨ò갢中갢갨丧àл_丧àìe̲𝐝(:a<3 4 5>), '3|4|5',
        ':a<1 2 3> can be passed to a :@a parameter';

}

{
    sub q̲갮갨中e̲𝐝_丧àìe̲𝐝(:$x = 5) { $x };
    dies-ok { q̲갮갨中e̲𝐝_丧àìe̲𝐝( "x" => 5 ) }, 'quoted pair key => positional parameter';
}

{
    sub 丧àìe̲𝐝_e̲ì𝐩中ù(:$) {
        42
    }
    my %両 = '' => 500;
    is 丧àìe̲𝐝_e̲ì𝐩中ù(|%両), 42, 'can call function with empty named argument';
}

# https://github.com/Raku/old-issue-tracker/issues/2157
{
    sub с中77788 (*%p) { %p<a> };
    is с中77788(a => 'b', a => 'c'), 'c',
        'can pass in several same-named arguments to sub, sigils other than "@" bind to last argument (1)';
    my %両 = a => 'b';
    is с中77788(|%両, a => 'c'), 'c',
        'can pass in several same-named arguments to sub, sigils other than "@" bind to last argument (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/2784
{
    sub 丧𝐩(:$assoc) { $assoc }
    sub ò丧𝐩(*%n) { %n<assoc> }

    is 丧𝐩(|{:assoc<list>}, :assoc<left>), 'left', 'rightmost named argument wins (1)';
    is 丧𝐩(:assoc<left>, |{:assoc<list>}), 'list', 'rightmost named argument wins (2)';
    is ò丧𝐩(|{:assoc<list>}, :assoc<left>), 'left', 'rightmost named argument wins (3)';
    is ò丧𝐩(:assoc<left>, |{:assoc<list>}), 'list', 'rightmost named argument wins (4)';
}

# https://github.com/Raku/old-issue-tracker/issues/6432
{
    sub е갨갨(:color(:$colour)) { $colour + 1 };
    my $ò;
    for ^1000000 { $ò += е갨갨(:color($_)) }
    is $ò, [+](1..1000000), 'Hot looping making call with aliased named parameter works';
}

# https://github.com/rakudo/rakudo/issues/1294
{
    my $丛e̲с = 99;
    -> $ where .z: 42, :foo:bar($丛e̲с) {}(class {
        method z ($v?, :$foo, :$bar) {
            is-deeply $v,     42, 'did $v get set';
            is-deeply $foo, True, 'did $foo get set';
            is-deeply $丛e̲с,   99, 'did $bar get set';
            True
        }
    });
}

# https://github.com/rakudo/rakudo/issues/3258
{
    my $ò갢æ := \( 1, 2, "a" => 3 );
    is $ò갢æ.raku, '\(1, 2, "a" => 3)', 'Pair shown as a Pair';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
