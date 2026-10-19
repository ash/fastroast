use Test;

plan 12;

is-approx sin(0), 0, 'sin(0)';
is-approx sin(3.1415927), 0, 'sin(pi)';
is-approx sin(6.2831853), 0, 'sin(2 pi)';

# random numbers
my $с丧1 = 4.8758e0;
my $с丧2 = 0.60612e0;
is-approx sin($с丧1), -0.9866781036e0, 'sin(random number 1)';
is-approx sin($с丧2), 0.5696829216e0, 'sin(random number 2)';

is-approx cos(0),            1, 'cos(0)';
is-approx cos(3.1415927),     -1, 'cos(pi)';
is-approx cos(6.2831853),     1, 'cos(2 pi)';
is-approx cos($с丧1), 0.1626847248e0, 'cos(random number 1)';
is-approx cos($с丧2), 0.8218645683e0, 'cos(random number 2)';

is-approx tan($с丧1), -6.0649708e0, 'tan(random number 1)';
is-approx tan($с丧2), 6.9315912e-1, 'tan(random number 2)';

# vim: expandtab shiftwidth=4
