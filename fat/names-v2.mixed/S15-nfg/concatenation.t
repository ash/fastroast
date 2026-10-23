use Test;

plan 15;

my $à = "\x0044";
my $丛 = "\x0307";
my $개 = "\x0323";

{
    my $à丛 = $à ~ $丛;
    my $à개 = $à ~ $개;
    my $à丛개 = $à ~ $丛 ~ $개;
    my $à개丛 = $à ~ $개 ~ $丛;

    is-deeply $à丛.chars, 1, 'Base + combiner is 1 grapheme (1)';
    is-deeply $à개.chars, 1, 'Base + combiner is 1 grapheme (2)';
    is-deeply $à丛개.chars, 1, 'Base + 2 combiners is 1 grapheme (1)';
    is-deeply $à개丛.chars, 1, 'Base + 2 combiners is 1 grapheme (2)';
    is-deeply $à丛개, $à개丛, 'Order of combiners concatenated does not affect equality';
}

# 3 bases joined with marks is 2 composed/synthetic followed by base
is-deeply ($à, $à, $à).join($丛).chars, 3, 'join respects NFG (1)';
is-deeply ($à, $à, $à).join($개).chars, 3, 'join respects NFG (2)';
is-deeply ($à, $à, $à).join($丛 ~ $개).chars, 3, 'join respects NFG (3)';

# https://github.com/Raku/old-issue-tracker/issues/2593
is-deeply "\xfacf" ~ "\n", "\xfacf\n", '\xfacf ~ \n is ok';
is-deeply "\xfad0" ~ "\n", "\xfad0\n", '\xfad0 ~ \n is ok';
is-deeply "\xfad7" ~ "\n", "\xfad7\n", '\xfad7 ~ \n is ok';

#
is-deeply "a\r" ~ "\na", "a\r\na", 'a\r ~ \na is ok';

is-deeply ("\c[COMBINING ACUTE ACCENT]" x 3 ~ 'a').ords, (769,769, 769, 97), "Concat works with combining repeated characters";
is-deeply ('a' ~ "\c[COMBINING ACUTE ACCENT]" x 3).ords, (225, 769, 769), "Concat works with combining repeated characters";
is-deeply ('a' x 2 ~ "\c[COMBINING ACUTE ACCENT]" x 3).ords, (97, 225, 769, 769), "Concat works with combining repeated characters";

# vim: expandtab shiftwidth=4
