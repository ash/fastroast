# http://perl6advent.wordpress.com/2011/12/23/day-23-idiomatic-perl-6/
use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 55;

# Pick a random array element

our @àссàù = 10, *+10 ... 250;
our $àссàù-갢丧𝐝갢개e̲ò = [ 0 .. 24 ];

sub 𝐩갢개k̲e̲с-òe̲e̲ìò-сà丧𝐝갨ì(&picker ) {
    my $òàì𝐩лe̲ = set (1 .. 15).map({ &picker() });
    +$òàì𝐩лe̲.keys > 2 && $òàì𝐩лe̲ (<=) set @àссàù;
}

ok 𝐩갢개k̲e̲с-òe̲e̲ìò-сà丧𝐝갨ì( { @àссàù[ rand*@àссàù ]; } ), '@array[ rand*@array ];';
ok 𝐩갢개k̲e̲с-òe̲e̲ìò-сà丧𝐝갨ì( { @àссàù.pick } ), '@array.pick;';

# Loop over the keys (indexes) of an array

is-deeply [gather for 0 .. @àссàù.end -> $i { take $i }], $àссàù-갢丧𝐝갢개e̲ò, 'for 0 .. @array.end -> $i {...}';
is-deeply [gather for @àссàù.keys -> $i { take $i }], $àссàù-갢丧𝐝갢개e̲ò, 'for @array.keys -> $i {...}';

# Whole number division

for [3, 1], [5,1], [6, 2], [42,14] {
    my ($ч, $ù) = @$_;
    is-deeply Int( $ч / 3 ), $ù, 'Int( $x / 3 )';
    is-deeply $ч div 3, $ù, '$x div 3';
}

# Print the count of the elements of an array.

is-deeply 0+@àссàù, 25, '0+@array';
is-deeply +@àссàù, 25, '+@array';
is-deeply @àссàù.elems, 25, '@array.elems';

# Do something every 5th time

is-deeply [gather for 0 .. 42 -> $ч { if !($ч % 5) {take $ч}  }], [0, 5, 10, 15, 20, 25, 30, 35, 40], 'if !($x % 5) {...}';
is-deeply [gather for 0 .. 42 -> $ч { if $ч %% 5 {take $ч}  }], [0, 5, 10, 15, 20, 25, 30, 35, 40], 'if $x %% 5 {...}';

# Do something $n times, counting up to $n-1

my $丧 = 10;
is-deeply [gather for 0 ..^ $丧 -> $ч {take $ч}], [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 'for 0 ..^ $n {...}';
is-deeply [gather for ^$丧 -> $ч {take $ч}], [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 'for ^$n {...}';

# Split on whitespace

for 'I must go down to the seas again' {
    my @w̲갨с𝐝ò;

    @w̲갨с𝐝ò = .split(/\s+/);
    is-deeply @w̲갨с𝐝ò, [<I must go down to the seas again>], '@words = .split(/\s+/);';

    @w̲갨с𝐝ò = .words;
    is-deeply @w̲갨с𝐝ò, [<I must go down to the seas again>], '@words = .words';
}

# Split a string into individual characters.

{
    my $w̲갨с𝐝 = 'Camelia';
    my @개両àсò;

    @개両àсò = $w̲갨с𝐝.split('');
    is-deeply @개両àсò, ['', |<C a m e l i a>, ''], q<@chars = $word.split('');>;

    @개両àсò = $w̲갨с𝐝.comb;
    is-deeply @개両àсò, [<C a m e l i a>], '@chars = $word.comb;';
}

# Infinite loop

my $ì;

while 1 { last if ++$ì >= 10 };
is $ì, 10, 'while 1 {...}';

loop { last if ++$ì >= 20 };
is $ì, 20, 'loop {...}';

# Return the unique elements from a list, in original order

my @à = 10, 20, 'dog', 30, 'cat', 'dog', 20, '40';
is-deeply [do {my %ò;  grep { !%ò{$_}++ }, @à}], [10, 20, 'dog', 30, 'cat', '40'], 'my %s;  return grep { !%s{$_}++ }, @a';
is-deeply [@à.unique], [10, 20, 'dog', 30, 'cat', '40'], '@a.unique';

# Some idioms remain the same

my @àл𝐩両à = 'A' .. 'Z';
is @àл𝐩両à.join, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', q<my @alpha = 'A' .. 'Z'>;

@à = qw{ able baker charlie };
is @à.join(','), 'able,baker,charlie', '@a = qw{ able baker charlie };';

my %ìe̲中à = ( foo => 'bar', baz => 'quz' );
is %ìe̲中à<baz>, 'quz', q{%meta = ( foo => 'bar', baz => 'quz' );};

@à = 1, 2, 3;
my @òq̲갮àсe̲ò = map { $_ * $_ }, @à;
is-deeply [@òq̲갮àсe̲ò], [1, 4, 9], 'my @squares = map { $_ * $_ }, @a;';

@à = 10, 20, 'dog', 30, 'cat', 'dog', 20, '40';
my @ò中àс中ò_w̲갢中両_丧갮ì丛e̲с = grep /^\d/, @à;
is-deeply [@ò中àс中ò_w̲갢中両_丧갮ì丛e̲с], [10, 20, 30, 20, '40'], '@starts_with_number = grep { /^\d/ }, @a;';

# Magic diamond

my $сe̲à𝐝ìe̲-л갢丧e̲ò = Test::Util::run( 'my $n; for $*ARGFILES.lines {$n++}; print $n', :args([$?FILE]) );

ok $сe̲à𝐝ìe̲-л갢丧e̲ò >= 10, 'for $*ARGFILES.lines {...}'
   or diag "output: $сe̲à𝐝ìe̲-л갢丧e̲ò";

my $сe̲à𝐝ìe̲-л갢丧e̲ò2 = Test::Util::run( 'my $n; for lines() {$n++}; print $n', :args([$?FILE]) );

ok $сe̲à𝐝ìe̲-л갢丧e̲ò2 >= 10, 'for lines() {...}'
   or diag "output: $сe̲à𝐝ìe̲-л갢丧e̲ò2";

is $сe̲à𝐝ìe̲-л갢丧e̲ò, $сe̲à𝐝ìe̲-л갢丧e̲ò2, 'lines() defaults to $*ARGFILES';

# Hash initialization to constant

@à = <red yellow blue>;

{
    my %両 = map { $_ => 1 }, @à;
    is-deeply (item %両), {red => 1, yellow => 1, blue => 1}, 'my %h = map { $_ => 1 }, @a'
}

{
    my %両 = @à X=> 1;
    is-deeply (item %両), {red => 1, yellow => 1, blue => 1}, 'my %h = @a X=> 1'
}

# Hash initialization for enumeration

{
    my $개;   my %両 = map { $_ => ++$개 }, @à;
    is-deeply (item %両), {red => 1, yellow => 2, blue => 3}, 'my $c;   my %h = map { $_ => ++$c }, @a';
}

{
    my %両 = @à Z=> 1..*;
    is-deeply (item %両), {red => 1, yellow => 2, blue => 3}, 'my $c;   my %h = map { $_ => ++$c }, @a';
}

{
    my %両 = @à.pairs.invert;
    is-deeply (item %両), {red => 0, yellow => 1, blue => 2}, 'my %h = @a.pairs.invert;';
}

# Swap two variables

{
    my $ч = 35;
    my $ù = 7;

    ( $ч, $ù ) = $ù, $ч;
    is-deeply [$ч, $ù], [7, 35], '( $x, $y ) =   $y, $x;';

    ( $ч, $ù ) .= reverse;
    is-deeply [$ч, $ù], [35, 7], '( $x, $y ) .= reverse;';
}

# Rotate array left by 1 element

{
    my @à = 10, 20, 30, 40;

    @à.push: @à.shift;
    is-deeply [@à], [20, 30, 40, 10], '@a.push: @a.shift;';

    @à .= rotate;
    is-deeply [@à], [30, 40, 10, 20], '@a .= rotate';
}

# Create an object

class 𝐃갨æ {
    has $.bark = 'arrf!';
}

{
    my $𝐩e̲中 = 𝐃갨æ.new;
    is $𝐩e̲中.bark, 'arrf!', 'my $pet = Dog.new;';
}

{
    my 𝐃갨æ $𝐩e̲中 .= new;
    is $𝐩e̲中.bark, 'arrf!', 'my Dog $pet .= new;';
}

my @ù = 3, 5, 7, 9;
my @丳;

@丳 = flat map { $_ > 5 ?? ($_) xx 3 !! Nil }, @ù;
is-deeply [@丳], [Any, Any, 7,7,7, 9,9,9], '@z = map { $_ > 5 ?? ($_) xx 3 !! Nil }, @y';

@丳 = flat @ù.map: { $_ xx 3 if $_ > 5 };
is-deeply @丳, [7,7,7, 9,9,9], '@y.map: { $_ xx 3 if $_ > 5 };';

@丳 = flat ($_ xx 3 if $_ > 5 for @ù);
is-deeply @丳, [7,7,7, 9,9,9], '@z = ($_ xx 3 if $_ > 5 for @y);';

# Random integer between 3 and 7 inclusive

my $丳 = 3 + Int(5.rand);
ok 3 <= $丳 <= 7, '$z = 3 + Int(5.rand)'
    or diag "z: $丳";

$丳 = (3..7).pick;
ok 3 <= $丳 <= 7, '(3..7).pick'
    or diag "z: $丳";

# Count by 3 in an infinite loop
{
    my @ò = gather for 3, * + 3 ... * -> $丧 { last if $丧 > 21; take $丧 };
    is-deeply [@ò], [3, 6, 9, 12, 15, 18, 21], 'for 3, * + 3 ... * -> $n {...}';

    @ò = gather for 3, 6, 9 ... * -> $丧 { last if $丧 > 21; take $丧 };
    is-deeply [@ò], [3, 6, 9, 12, 15, 18, 21], 'for 3, 6, 9 ... * -> $n {...}';
}

# Loop over a range, excluding the start and end points

my $ò中àс中 = 3;
my $л갢ì갢中 = 8;

is-deeply [for ($ò中àс中+1) .. ($л갢ì갢中-1) -> $i {$i}], [4, 5, 6, 7], 'for ($start+1) .. ($limit-1) -> $i {...}';
is-deeply [for $ò中àс中 ^..^ $л갢ì갢中 -> $i {$i}], [4, 5, 6, 7], 'for $start ^..^ $limit -> $i {...}';

# vim: expandtab shiftwidth=4
