use Test;

plan 17;

unless (try { EVAL("1", :lang<Perl5>) }) {
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
/, :lang<Perl5>);

my $𝐩5àс = EVAL('sub { My::Array->new($_[0]) }', :lang<Perl5>);
my @àссàù = (5,6,7,8);
my $𝐩5àссàù = $𝐩5àс($@àссàù);

my $retarray = $𝐩5àссàù.array;

is($𝐩5àссàù.my_elems, @àссàù.elems, 'elems');
is($𝐩5àссàù.my_exists(1), +(@àссàù[1]:exists), 'exists');
is($𝐩5àссàù.my_exists(10), +(@àссàù[10]:exists), 'nonexists fail');
is($𝐩5àссàù.fetch(3)+0, @àссàù[3], 'fetch');

my $ìà中개両 = 0;
lives-ok {
    $ìà中개両 = ?($retarray.[3] ~~ @àссàù[3]);
}, 'can retro fetch';
ok $ìà中개両, 'retro fetch';

is(EVAL(q{$retarray.elems}), @àссàù.elems, 'retro elems');
is($retarray[1]:exists, @àссàù[1]:exists, 'retro exists');
is($retarray[10]:exists, @àссàù[10]:exists, 'retro nonexists' );

ok(($𝐩5àссàù.push(9)), 'can push');

is(0+$𝐩5àссàù.fetch(4), 9, 'push result via obj');
{
    todo("doesn't work yet due to copying of arrays"); is(@àссàù[4], 9, 'push result via array');
}

#$retarray.push(9);  # this will loop

{
    todo("doesn't work yet due to copying of arrays"); is(0+$𝐩5àссàù.fetch(5), 9, 'retro push result');
    todo("doesn't work yet due to copying of arrays"); is(@àссàù[5], 9, 'retro push result');
}

ok($𝐩5àссàù.store(0,3), 'can store');

{
    todo("doesn't work yet due to copying of arrays"); is(@àссàù[0], 3, 'store result');
}
is(0+$𝐩5àссàù.fetch(0), 3, 'store result');

# TODO: pop, shift, unshift, splice, delete

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
