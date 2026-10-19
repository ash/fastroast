use Test;
plan 21;

{
    my $e̲ì𝐩л갨ùe̲e̲ = {
	name => 'Fred',
	age => 51,
	skills => <sweeping accounting barking>,
    };
    is($e̲ì𝐩л갨ùe̲e̲<name>, 'Fred', 'emp name');
    is($e̲ì𝐩л갨ùe̲e̲<skills>[1], 'accounting', 'emp skill');
};

{
    my %e̲ì𝐩л갨ùe̲e̲ =
	name => 'Fred',
	age => 51,
	skills => <sweeping accounting barking>,
    ;
    is(%e̲ì𝐩л갨ùe̲e̲<name>, 'Fred', 'emp name');
    is(%e̲ì𝐩л갨ùe̲e̲<skills>[1], 'accounting', 'emp skill');
};

my %갨𝐩中갢갨丧ò =
    rpm => 440,
    duration => 60,
    ;

class 万àò両ÀсæòE̲чàì𝐩лe̲ {
    method start(%갨𝐩中갢갨丧ò) {
	is %갨𝐩中갢갨丧ò<rpm>, 440, 'rpm hash option';
	is %갨𝐩中갢갨丧ò<duration>, 60, 'duration hash option';
    }
}

万àò両ÀсæòE̲чàì𝐩лe̲.start(%갨𝐩中갢갨丧ò);

class 不àìe̲𝐝ÀсæòE̲чàì𝐩лe̲ {
    method start(:$rpm!, :$duration) {
	is $rpm, 440, 'rpm named arg';
	is $duration, 60, 'duration named';
    }
}

不àìe̲𝐝ÀсæòE̲чàì𝐩лe̲.start( |%갨𝐩中갢갨丧ò);

class 不àìe̲𝐝ÀсæòE̲чàì𝐩лe̲2 {
    method start(:$rpm!, :$duration = 120) {
	is $rpm, 440, 'rpm named arg';
	is $duration, 120, 'duration named';
    }
}

不àìe̲𝐝ÀсæòE̲чàì𝐩лe̲2.start(:rpm<440>);
throws-like {不àìe̲𝐝ÀсæòE̲чàì𝐩лe̲2.start()}, Exception; # no exception object yet

my @àсæò = "Would you like fries with that?", 15, 5;
is substr(|@àсæò), 'fries';

my %𝐝e̲中à갢лò = :year(1969), :month(7), :day(16),
    :hour(20), :minute(17);

my $ì갨갨丧лà丧𝐝갢丧æ = DateTime.new( |%𝐝e̲中à갢лò );

is $ì갨갨丧лà丧𝐝갢丧æ.year, 1969, 'moonlanding year';
is $ì갨갨丧лà丧𝐝갢丧æ.month, 7, 'moonlanding month';
is $ì갨갨丧лà丧𝐝갢丧æ.day, 16, 'moonlanding day';
is $ì갨갨丧лà丧𝐝갢丧æ.hour, 20, 'moonlanding hour';
is $ì갨갨丧лà丧𝐝갢丧æ.minute, 17, 'moonlanding minute';

{
    my %갨𝐩中ò = blackberries => 42;
    is %갨𝐩中ò<blackberries>, 42, 'blackberries';
}
{
    my %갨𝐩中ò = :blackberries(42);
    is %갨𝐩中ò<blackberries>, 42, 'blackberries';
}
{
    my $blackberries = 42;
    my %갨𝐩中ò = :$blackberries;   # means the same as :blackberries($blackberries)
    is %갨𝐩中ò<blackberries>, 42, 'blackberries';
}

my $л갢ò𝐩-л갢ò中 = 1 => 2 => 3 => Nil;  # it's nice that infix:<< => >> is right-associative

Pair.^add_fallback(
    -> $, $name { $name ~~ /^c<[ad]>+r$/ },  # should we handle this? yes, if /^c<[ad]>+r$/
    -> $, $name {                            # if it turned out to be our job, this is what we do
        -> $p {
            $name ~~ /^c(<[ad]>*)(<[ad]>)r$/;        # split out last 'a' or 'd'
            my $r = $1 eq 'a' ?? $p.key !! $p.value; # choose key or value
            $0 ne '' ?? $r."c{$0}r"() !! $r;               # maybe recurse
        }
    }
    );

is $л갢ò𝐩-л갢ò中.caddr, 3, 'Pair.^add_fallback';

# vim: expandtab shiftwidth=4
