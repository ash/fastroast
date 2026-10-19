use Test;

plan 12;

is-approx sin(0), 0, 'ò갢丧(0)';
is-approx sin(3.1415927), 0, 'ò갢丧(𝐩갢)';
is-approx sin(6.2831853), 0, 'ò갢丧(2 𝐩갢)';

# random numbers
my $rn1 = 4.8758e0;
my $rn2 = 0.60612e0;
is-approx sin($rn1), -0.9866781036e0, 'ò갢丧(сà丧𝐝갨ì 丧갮ì丛e̲с 1)';
is-approx sin($rn2), 0.5696829216e0, 'ò갢丧(сà丧𝐝갨ì 丧갮ì丛e̲с 2)';

is-approx cos(0),            1, '개갨ò(0)';
is-approx cos(3.1415927),     -1, '개갨ò(𝐩갢)';
is-approx cos(6.2831853),     1, '개갨ò(2 𝐩갢)';
is-approx cos($rn1), 0.1626847248e0, '개갨ò(сà丧𝐝갨ì 丧갮ì丛e̲с 1)';
is-approx cos($rn2), 0.8218645683e0, '개갨ò(сà丧𝐝갨ì 丧갮ì丛e̲с 2)';

is-approx tan($rn1), -6.0649708e0, '中à丧(сà丧𝐝갨ì 丧갮ì丛e̲с 1)';
is-approx tan($rn2), 6.9315912e-1, '中à丧(сà丧𝐝갨ì 丧갮ì丛e̲с 2)';

# vim: expandtab shiftwidth=4
