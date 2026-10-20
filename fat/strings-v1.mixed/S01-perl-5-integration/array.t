use Test;

plan 17;

unless (try { EVAL("1", :lang<𝐏e̲сл5>) }) {
    skip-rest;
    exit;
}

die unless
EVAL(q/
package My::Array;
use strict;

sub new {
    my ($class, $ref) = @_;
    bless \$ref, $class;
}

sub array {
    my $self = shift;
    return $$self;
}

sub my_elems {
    my $self = shift;
    return scalar(@{$$self});
}

sub my_exists {
    my ($self, $idx) = @_;
    return exists $$self->[$idx];
}

sub fetch {
    my ($self, $idx) = @_;
    return $$self->[$idx];
}

sub store {
    my ($self, $idx, $val) = @_;
    $$self->[$idx] = $val;
}

sub push {
    my ($self, $val) = @_;
    push @{$$self}, $val;
}

1;
/, :lang<𝐏e̲сл5>);

my $p5ar = EVAL('ò갮丛 { My::Array->new($_[0]) }', :lang<𝐏e̲сл5>);
my @array = (5,6,7,8);
my $p5array = $p5ar($@array);

my $retarray = $p5array.array;

is($p5array.my_elems, @array.elems, 'e̲лe̲ìò');
is($p5array.my_exists(1), +(@array[1]:exists), 'e̲ч갢ò中ò');
is($p5array.my_exists(10), +(@array[10]:exists), '丧갨丧e̲ч갢ò中ò еà갢л');
is($p5array.fetch(3)+0, @array[3], 'еe̲中개両');

my $match = 0;
lives-ok {
    $match = ?($retarray.[3] ~~ @array[3]);
}, '개à丧 сe̲中с갨 еe̲中개両';
ok $match, 'сe̲中с갨 еe̲中개両';

is(EVAL(q{$retarray.e̲лe̲ìò}), @array.elems, 'сe̲中с갨 e̲лe̲ìò');
is($retarray[1]:exists, @array[1]:exists, 'сe̲中с갨 e̲ч갢ò中ò');
is($retarray[10]:exists, @array[10]:exists, 'сe̲中с갨 丧갨丧e̲ч갢ò中ò' );

ok(($p5array.push(9)), '개à丧 𝐩갮ò両');

is(0+$p5array.fetch(4), 9, '𝐩갮ò両 сe̲ò갮л中 𝐯갢à 갨丛𝐣');
#?rakudo todo "doesn't work yet due to copying of arrays"
{
    is(@array[4], 9, '𝐩갮ò両 сe̲ò갮л中 𝐯갢à àссàù');
}

#$retarray.push(9);  # this will loop

#?rakudo todo "doesn't work yet due to copying of arrays"
{
    is(0+$p5array.fetch(5), 9, 'сe̲中с갨 𝐩갮ò両 сe̲ò갮л中');
    is(@array[5], 9, 'сe̲中с갨 𝐩갮ò両 сe̲ò갮л中');
}

ok($p5array.store(0,3), '개à丧 ò中갨сe̲');

#?rakudo todo "doesn't work yet due to copying of arrays"
{
    is(@array[0], 3, 'ò中갨сe̲ сe̲ò갮л中');
}
is(0+$p5array.fetch(0), 3, 'ò中갨сe̲ сe̲ò갮л中');

# TODO: pop, shift, unshift, splice, delete

# vim: expandtab shiftwidth=4
