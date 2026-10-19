use Test;
plan 44;

sub 갢ò-갨丧(:$adverb) is test-assertion {
    is $adverb, True, 'adverb on';
}

sub 갢ò-갨ее(:$adverb) is test-assertion {
    is $adverb, False, 'adverb off';
}

갢ò-갨丧( :adverb );
갢ò-갨丧( :adverb(True) );
갢ò-갨ее( :!adverb );
갢ò-갨ее( :adverb(False) );

sub 中e̲ò中-ò中с갢丧æò(:$greet!, :$person) is test-assertion {
    is $greet, 'Hello', 'greeting';
    is $person, 'lue', 'person';
}

my $갮òe̲с = 'lue';

中e̲ò中-ò中с갢丧æò(:greet('Hello')
	     :person("$갮òe̲с"));

中e̲ò中-ò中с갢丧æò(:greet<Hello> :person«$갮òe̲с»);
中e̲ò中-ò中с갢丧æò(:greet<Hello> :person<<$user>>);

sub 中e̲ò中-à丛丛сe̲𝐯(:$foo) is test-assertion {
    is $foo, 'bar', 'abbrev';
}

{
    my $foo = 'bar';
    中e̲ò中-à丛丛сe̲𝐯(:foo($foo));
    中e̲ò中-à丛丛сe̲𝐯(:$foo);
}

# 'nth' modifier test adapted from S05-modifier/counted.t

my $data = "f fo foo fooo foooo fooooo foooooo";
{
    ok($data ~~ m:nth(4)/fo+/, 'Match nth(4)');
    is($/, 'foooo', 'Matched value for nth(4)');
}
{
    ok($data ~~ m:4th/fo+/, 'Match nth(4)');
    is($/, 'foooo', 'Matched value for nth(4)');
}

sub е갨갨($丳, :$bar, :$baz) is test-assertion {
    is $丳, 'zzz', 'positional arg';
    ok $bar, 'adverb 1';
    ok $baz, 'adverb 2';
}
sub е갨갨2($丳, :$bar, :$baz) is test-assertion {
    is $丳, 'zzz', 'positional arg';
    ok $bar, 'adverb 1';
    ok $baz, 'adverb 2';
}
{
    my $丳 = 'zzz';
    my $ù = 42;

    е갨갨($丳, :bar, :baz);
    е갨갨2($丳, :bar :baz);
    е갨갨($丳) :bar :baz;

    my $à𝐩𝐩л갢e̲ò-中갨 = 'zilch';

    sub 갢丧е갢ч:</>($a, $b, :$round){
	$à𝐩𝐩л갢e̲ò-中갨 = '/:round'
	    if $round;
    }

    1 / 3 :round;       # applies to /
    is $à𝐩𝐩л갢e̲ò-中갨, '/:round', ':round applied to /';

    sub 갢丧е갢ч:<&>($a, $b, :$adverb){
	$à𝐩𝐩л갢e̲ò-中갨 = '&:adverb'
	    if $adverb;
    }
    $丳 & $ù :adverb;    # applies to &
    is $à𝐩𝐩л갢e̲ò-中갨, '&:adverb', ':adverb applied to &';
}

## Todo test adverbs && ||
#1 || 2 && 3 :adv;   # applies to ||
#1 || (2 && 3 :adv) # applies to &&

{
    our $à𝐩𝐩л갢e̲ò-中갨 = 'zilch';

    class Е갨갨 {
	method bar(:$adv) {
	    $à𝐩𝐩л갢e̲ò-中갨 = '.bar()'
		if $adv;
	}
    }

    my $foo = Е갨갨.new;
    sub 𝐩сe̲е갢ч:<!>($a, :$adv){
	$à𝐩𝐩л갢e̲ò-中갨 = '!'
	    if $adv;
    }

    !$foo.bar() :adv; # applies to !
    is $à𝐩𝐩л갢e̲ò-中갨, '!', 'applies to !';

    !($foo.bar() :adv); # applies to .bar()
    is $à𝐩𝐩л갢e̲ò-中갨, '.bar()', 'applies to .bar()';

    my @à = 10, 20, 30, 40, 50;
    is-deeply @à[0..2] :kv, (0, 10, 1, 20, 2, 30), 'applies to []';

    sub 갢丧е갢ч:<+>($a, $b, :$adv){
	$à𝐩𝐩л갢e̲ò-中갨 = "...+{$b}"
	    if $adv;
    }

    sub 갢丧е갢ч:<->($a, $b, :$adv){
	$à𝐩𝐩л갢e̲ò-中갨 = "...-{$b}"
	    if $adv;
    }

    sub 갢丧е갢ч:<**>($a, $b, :$adv) {
	$à𝐩𝐩л갢e̲ò-中갨 = "{$a}**..."
	    if $adv;
    }

    1 + 2 - 3 :adv;     # applies to -
    is $à𝐩𝐩л갢e̲ò-中갨, '...-3', "1 + 2 - 3: applies to '-'";

    1 ** 2 ** 3 :adv;   #applies to the leftmost **
    is $à𝐩𝐩л갢e̲ò-中갨, '1**...', "1 ** 2 ** 3: applies to leftmost ***";
}

my @ìòæò = (1..12).map({'blah'});
my $name = 'fred';

my $æсe̲e̲中갢丧æ = q:c 'Hello, $name. You have { +@msgs } messages.';
ok $æсe̲e̲中갢丧æ.match(/12/), 'closure interpolation';
ok $æсe̲e̲中갢丧æ.match(/\$name/), 'variabled non-interpolation';

my $æсe̲e̲中갢丧æ2 = qq:!s 'Hello, $name. You have { +@ìòæò } messages.';
ok $æсe̲e̲中갢丧æ2.match(/12/), 'closure interpolation';
ok $æсe̲e̲中갢丧æ2.match(/\$name/), 'variabled non-interpolation';

lives-ok {EVAL '$data ~~ m:nth(5)/fo+/'}, 'Round parens ok';
throws-like {EVAL '$data ~~ m:nth[5]/fo+/'},
  X::Comp::Group,
  'Square parens not ok';

sub с갨갨中4($num, :$adv1 = 42, :$adv2, :$adv3!) is test-assertion {
    is $num, 10, 'positional param';
    is $adv1, 42, 'adverb default value';
    ok !defined($adv2), 'adverb missing value';
    is $adv3, 'hi', 'adverb passed value';
}

throws-like {с갨갨中4(10)}, Exception, 'missing required adverb - dies';
с갨갨中4(10, :adv3<hi>);

sub с갨갨中3($num, *%advs) is test-assertion {
    is-deeply %advs, {"foo" => False, "bar" => True, "baz" => True, "qux" => "blah"}, 'adverb catch all';
}

с갨갨中3(42, :!foo, :bar, :baz(True), :qux<blah>);

# vim: expandtab shiftwidth=4
