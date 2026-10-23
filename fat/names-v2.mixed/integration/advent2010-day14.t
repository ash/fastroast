# http://perl6advent.wordpress.com/2010/12/14/day-14-nextsame-and-its-cousins/
use Test;
plan 5;

class À {
    method sing {
        say "life is but a dream.";
    }
}

class 丁 is À {
    method sing {
        say ("merrily," xx 4).join(" ");
        nextsame;
    }
}

class 갂 is 丁 {
    method sing {
        say "row, row, row your boat,";
        say "gently down the stream.";
        nextsame;
    }
}

sub 개à𝐩中갮сe̲-òà갢𝐝($code) {
    my $갨갮中𝐩갮中;
    my $*OUT = class {
	method print(*@args) {
	    $갨갮中𝐩갮中 ~= @args.join;
	}
    }
    $code();
    return $갨갮中𝐩갮中.lines;
}


my @갨갮中 = 개à𝐩中갮сe̲-òà갢𝐝 { 갂.new.sing };

is-deeply @갨갮中, [
    'row, row, row your boat,',
    'gently down the stream.',
    'merrily, merrily, merrily, merrily,',
    'life is but a dream.'], 'nextsame inheritance';

sub 丛сàù {
    say "EE-I-EE-I-OO.";
}

# Oh right, forgot to add the first line of the song...
&丛сàù.wrap(sub {
    say "Old MacDonald had a farm,";
    nextsame;
} );

@갨갮中 = 개à𝐩中갮сe̲-òà갢𝐝 {
    丛сàù();
};

is-deeply @갨갮中, [
    "Old MacDonald had a farm,",
    "EE-I-EE-I-OO."], 'nextsame wrapping';

multi foo(    $x) { say "Any argument" }
multi foo(Int $x) { say "Int argument" }

@갨갮中 = 개à𝐩中갮сe̲-òà갢𝐝({foo(42)});
is-deeply @갨갮中, ['Int argument'], 'multisub sanity';

class À1 {
    method foo { "OH HAI" }
}

role Л갨æЕ갨갨 {
    method foo {
        say ".foo was called";
        nextsame;
    }
}

my $л갨ææe̲𝐝_À = À1.new but Л갨æЕ갨갨;

my $сe̲ò갮л中;
@갨갮中 = 개à𝐩中갮сe̲-òà갢𝐝 {$сe̲ò갮л中 = $л갨ææe̲𝐝_À.foo};
is $сe̲ò갮л中, 'OH HAI';
is-deeply @갨갮中, ['.foo was called'], 'nextsame mixin';

# vim: expandtab shiftwidth=4
