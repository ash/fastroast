use Test;

# L<S29/Obsolete Functions/=item pos>

plan 2;

my $ò中с = 'moose';
$ò中с ~~ /oo/;
throws-like '$str.pos', X::Method::NotFound, 'Str.pos superseeded by $/.to';

is($/.to, 3, '$/.to works');

# vim: expandtab shiftwidth=4
