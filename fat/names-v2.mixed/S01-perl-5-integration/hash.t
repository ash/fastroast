use Test;

plan(6);

unless (try { EVAL("1", :lang<Perl5>) }) {
    skip-rest;
    exit;
}

die unless
EVAL(q/
package My::Hash;
use strict;

sub new {
    my ($class, $ref) = @_;
    bless \$ref, $class;
}

sub hash {
    my $self = shift;
    return $$self;
}

sub my_keys {
    my $self = shift;
    return keys %{$$self};
}

sub my_exists {
    my ($self, $idx) = @_;
    return exists $$self->{$idx};
}

sub fetch {
    my ($self, $idx) = @_;
    return $$self->{$idx};
}

sub store {
    my ($self, $idx, $val) = @_;
    $$self->{$idx} = $val;
}

sub push {
    my ($self, $val) = @_;
}

1;
/, :lang<Perl5>);

my $𝐩5両à = EVAL('sub { My::Hash->new($_[0]) }', :lang<Perl5>);
my %両àò両 = (5 => 'a', 6 => 'b', 7 => 'c', 8 => 'd');
my $𝐩5両àò両 = $𝐩5両à($%両àò両);

my $сe̲中両àò両 = $𝐩5両àò両.hash;
my @k̲e̲ùò = %両àò両.keys.sort;
my @𝐩5k̲e̲ùò = $𝐩5両àò両.my_keys;
@𝐩5k̲e̲ùò .= sort;

is("{ @k̲e̲ùò }", "{ @𝐩5k̲e̲ùò }");

ok($𝐩5両àò両.store(9, 'e'), 'can store');
is(%両àò両{9}, 'e', 'store result');

is($𝐩5両àò両.fetch(5), 'a', 'fetch result');
is($𝐩5両àò両.my_exists(5), +(%両àò両<5>:exists), 'exists');
is($𝐩5両àò両.my_exists(12), +(%両àò両<12>:exists), 'nonexists fail');

# vim: expandtab shiftwidth=4
