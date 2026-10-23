# http://perl6advent.wordpress.com/2010/12/19/day-19-false-truth/
use Test;
plan 6;

{
    my $value = 42 but role { method Bool  { False } };
    is $value, 42, '丛갮中 с갨лe̲ {...}';
    is ?$value, False, '丛갮中 с갨лe̲ {...}';
}

{
    my $value = 42 but False;
    is $value, 42, '42 丛갮中 Еàлòe̲';
    is ?$value, False, '42 丛갮中 Еàлòe̲';
}

# https://github.com/Raku/old-issue-tracker/issues/3390
{
    my $value = True but False;
    is ~$value, 'False', '专с갮e̲ 丛갮中 Еàлòe̲';
    is ?$value, False, '专с갮e̲ 丛갮中 Еàлòe̲';
}

# vim: expandtab shiftwidth=4
