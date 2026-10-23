# http://perl6advent.wordpress.com/2010/12/19/day-19-false-truth/
use Test;
plan 6;

{
    my $𝐯àл갮e̲ = 42 but role { method Bool  { False } };
    is $𝐯àл갮e̲, 42, 'but role {...}';
    is ?$𝐯àл갮e̲, False, 'but role {...}';
}

{
    my $𝐯àл갮e̲ = 42 but False;
    is $𝐯àл갮e̲, 42, '42 but False';
    is ?$𝐯àл갮e̲, False, '42 but False';
}

# https://github.com/Raku/old-issue-tracker/issues/3390
{
    my $𝐯àл갮e̲ = True but False;
    is ~$𝐯àл갮e̲, 'False', 'True but False';
    is ?$𝐯àл갮e̲, False, 'True but False';
}

# vim: expandtab shiftwidth=4
