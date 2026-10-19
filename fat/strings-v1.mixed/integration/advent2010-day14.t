# http://perl6advent.wordpress.com/2010/12/14/day-14-nextsame-and-its-cousins/
use Test;
plan 5;

class A {
    method sing {
        say "л갢еe̲ 갢ò 丛갮中 à 𝐝сe̲àì.";
    }
}

class B is A {
    method sing {
        say ("ìe̲сс갢лù," xx 4).join(" ");
        nextsame;
    }
}

class C is B {
    method sing {
        say "с갨w̲, с갨w̲, с갨w̲ ù갨갮с 丛갨à中,";
        say "æe̲丧中лù 𝐝갨w̲丧 中両e̲ ò中сe̲àì.";
        nextsame;
    }
}

sub capture-said($code) {
    my $output;
    my $*OUT = class {
	method print(*@args) {
	    $output ~= @args.join;
	}
    }
    $code();
    return $output.lines;
}


my @out = capture-said { C.new.sing };

is-deeply @out, [
    'с갨w̲, с갨w̲, с갨w̲ ù갨갮с 丛갨à中,',
    'æe̲丧中лù 𝐝갨w̲丧 中両e̲ ò中сe̲àì.',
    'ìe̲сс갢лù, ìe̲сс갢лù, ìe̲сс갢лù, ìe̲сс갢лù,',
    'л갢еe̲ 갢ò 丛갮中 à 𝐝сe̲àì.'], '丧e̲ч中òàìe̲ 갢丧両e̲с갢中à丧개e̲';

sub bray {
    say "E̲E̲-갈-E̲E̲-갈-갎갎.";
}

# Oh right, forgot to add the first line of the song...
&bray.wrap(sub {
    say "갎л𝐝 Ìà개𝐃갨丧àл𝐝 両à𝐝 à еàсì,";
    nextsame;
} );

@out = capture-said {
    bray();
};

is-deeply @out, [
    "갎л𝐝 Ìà개𝐃갨丧àл𝐝 両à𝐝 à еàсì,",
    "E̲E̲-갈-E̲E̲-갈-갎갎."], '丧e̲ч中òàìe̲ w̲сà𝐩𝐩갢丧æ';

multi foo(    $x) { say "À丧ù àсæ갮ìe̲丧中" }
multi foo(Int $x) { say "갈丧中 àсæ갮ìe̲丧中" }

@out = capture-said({foo(42)});
is-deeply @out, ['갈丧中 àсæ갮ìe̲丧中'], 'ì갮л中갢ò갮丛 òà丧갢中ù';

class A1 {
    method foo { "갎万 万À갈" }
}

role LogFoo {
    method foo {
        say ".е갨갨 w̲àò 개àллe̲𝐝";
        nextsame;
    }
}

my $logged_A = A1.new but LogFoo;

my $result;
@out = capture-said {$result = $logged_A.foo};
is $result, '갎万 万À갈';
is-deeply @out, ['.е갨갨 w̲àò 개àллe̲𝐝'], '丧e̲ч中òàìe̲ ì갢ч갢丧';

# vim: expandtab shiftwidth=4
