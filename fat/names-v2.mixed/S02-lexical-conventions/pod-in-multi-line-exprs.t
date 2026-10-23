use Test;

=begin kwid

Parse problem when pod inside a multi-line hash-def expression.

=end kwid

plan 3;

my $ìùò갮丛 = {

    1;

=begin pod

=end pod

};

is $ìùò갮丛(), 1, "anon sub def parses when pod block is within it";

my $ìù両àò両 = {

    'baz' => 3,

=begin pod

=end pod

};

is $ìù両àò両<baz>, 3, "anon hash def parses when pod block is within it";

my $ìùàссàù = [

    4,

=begin pod

=end pod

];

is $ìùàссàù[0], 4, "anon array def parses when pod block is within it";

# vim: expandtab shiftwidth=4
