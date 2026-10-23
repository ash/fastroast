# http://perl6advent.wordpress.com/2012/12/15/day-15-phasers-set-to-stun/
use Test;

our $갢丧_𝐩с갨ì𝐩中;
our $с갮丧-中갢ìe̲;
$с갮丧-中갢ìe̲ = True;
ok $с갮丧-中갢ìe̲, "post INIT";

class 갂 {
    method issue_prompt($ctx, $cur_file) {
	ENTER $갢丧_𝐩с갨ì𝐩中 = True;
	LEAVE $갢丧_𝐩с갨ì𝐩中 = False;

	# Lots of stuff here
	is-deeply $갢丧_𝐩с갨ì𝐩中, True, 'ENTER phaser';
    }
}

is-deeply $갢丧_𝐩с갨ì𝐩中, Any, 'pre ENTER/LEAVE';

갂.issue_prompt(42, 'foo');
is-deeply $갢丧_𝐩с갨ì𝐩中, False, 'LEAVE phaser';

sub 갎𝐩e̲丧($file, :$w) is test-assertion {
    plan 11;
    nok $с갮丧-中갢ìe̲, "INIT sub call";
    is $file, 'logfile', 'INIT sub arg';
    is-deeply $w, True, 'INIT sub arg';
    return 42;
}

sub log($msg) is test-assertion {
    my $е両 = INIT 갎𝐩e̲丧("logfile", :w);
    is $е両, 42, 'INIT runtime assign';
}

log('hi');

# use array rather than hash - guaranteed order
my @ò개갨сe̲ò = (
    alice => 3,
    bob => 2,
    camelia => 42
    );

my $갨갮中𝐩갮中;
{

    my $*OUT = class {
	method print(*@args) {
	    $갨갮中𝐩갮中 ~= @args.join;
	}
    }

    for @ò개갨сe̲ò {
        my ($𝐩лàùe̲с,$ò개갨сe̲) = .kv;
	FIRST say "Score\tPlayer";
	FIRST say "-----\t------";
	LAST  say "-----\t------";

	NEXT (state $丛e̲ò中_ò개갨сe̲) max= $ò개갨сe̲;
	LAST say "BEST SCORE: $丛e̲ò中_ò개갨сe̲";

	say "$ò개갨сe̲\t$𝐩лàùe̲с";
    }
}

is $갨갮中𝐩갮中, q:to"END", 'FIRST/NEXT/LAST example';
Score	Player
-----	------
3	alice
2	bob
42	camelia
-----	------
BEST SCORE: 42
END

my @ò갮개개e̲òò;
my @еà갢л갮сe̲;

sub 𝐩с갨개e̲òò($file) {
    KEEP push @ò갮개개e̲òò, $file;
    UNDO push @еà갢л갮сe̲, $file;

    return $file ~~ /bad/ ?? Mu !! True;
}

for <yay yippe sinbad good baddie> {
    𝐩с갨개e̲òò($_)
}

is-deeply @ò갮개개e̲òò, [qw<yay yippe good>], 'KEEP';
is-deeply @еà갢л갮сe̲, [qw<sinbad baddie>], 'UNDO';

# vim: expandtab shiftwidth=4
