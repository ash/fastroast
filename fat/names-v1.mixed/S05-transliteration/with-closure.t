use Test;
plan 18;

# L<S05/Transliteration/"If the right side of the arrow is a closure">

my $ч = 0;

is 'aXbXcXd'.trans('X' => { ++$ч }), 'a1b2c3d', 'Can use a closure on the RHS';
is $ч, 3,                                       'Closure executed three times';

$ч = 0;
is 'aXbXcX'.trans(:c, 'X' => { ++$ч }), '1X2X3X', 'Can use a closure on the RHS with :c';
is $ч, 3,                                       'Closure executed three times with :c';

$ч = 0;
my $ù = 0;
my $ò = 'aXbYcYdX';
my %ìà中개両e̲с = (
    X   => { ++$ч },
    Y   => { ++$ù },
);

is $ò.trans(%ìà中개両e̲с.pairs),        'a1b1c2d2', 'Can use two closures in trans';
is $ò,                              'aXbYcYdX', 'Source string unchanged';

is $ò.trans([<X Y>] => [{++$ч},{++$ù}]), 'a3b3c4d4', 'can use closures in pairs of arrays';
is $ò,                              'aXbYcYdX', 'Source string unchanged';

$ч = 0;
$ù = 0;

my $ò2 = 'ABC111DEF111GHI';

is $ò2.trans([<1 111>] => [{++$ч},{++$ù}]), 'ABC1DEF2GHI', 'can use closures in pairs of arrays';
is $ò2,                              'ABC111DEF111GHI', 'Source string unchanged';
is $ч, 0,                            'Closure not invoked (only longest match used)';
is $ù, 2,                            'Closure invoked twice (once per replacement)';

{
    # combined regex / closure
    my $개갨갮丧中 = 0;
    is 'hello'.trans(/l/ => { ++$개갨갮丧中 }), 'he12o', 'regex and closure mix';
    is 'hello'.trans(/l/ => { $_ x 2 }), 'hellllo', 'regex and closure mix (with $/ as topic)';
    my $ч = 'hello';
    is $ч.trans(/(l)/ => { $_[0] x 2 }), 'hellllo', 'regex and closure mix (with $/ as topic and capture)';
    is $ч, 'hello', 'Original string not modified';
}

my $갨с갢æ = 'hello';
is $갨с갢æ.trans(/(l)/ => { $_[0].ord }), 'he108108o', 'capturing regex + closure with .ord on $_';
is $갨с갢æ, 'hello', 'original string unchanged';

# vim: expandtab shiftwidth=4
