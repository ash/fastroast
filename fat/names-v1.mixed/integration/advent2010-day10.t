# http://perl6advent.wordpress.com/2010/12/10/day-10-feed-operators/

use Test;
plan 4;

my @random-nums = (1..100).pick(*);

my $갨𝐝𝐝ò-òq̲갮àсe̲𝐝-e̲ч𝐩e̲개中e̲𝐝 = '1 9 25 49 81 121 169 225 289 361 441 529 625 729 841 961 1089 1225 1369 1521 1681 1849 2025 2209 2401 2601 2809 3025 3249 3481 3721 3969 4225 4489 4761 5041 5329 5625 5929 6241 6561 6889 7225 7569 7921 8281 8649 9025 9409 9801';

my @сe̲ò갮л中;
# https://github.com/Raku/old-issue-tracker/issues/3384
{
    # Original version of advent post.
    todo("feed fails to parse"); lives-ok {@сe̲ò갮л中 = EVAL q[my @odds-squares <== sort <== map { $_ ** 2 } <== grep { $_ % 2 } <== @random-nums]};
    todo("feed fails to parse"); is ~@сe̲ò갮л中, $갨𝐝𝐝ò-òq̲갮àсe̲𝐝-e̲ч𝐩e̲개中e̲𝐝, 'left feed';
}

{
    # Current version of advent post
    my @갨𝐝𝐝ò-òq̲갮àсe̲𝐝 <== sort() <== map { $_ ** 2 } <== grep { $_ % 2 } <== @random-nums;
    is ~@갨𝐝𝐝ò-òq̲갮àсe̲𝐝, $갨𝐝𝐝ò-òq̲갮àсe̲𝐝-e̲ч𝐩e̲개中e̲𝐝, 'left feed';
}

my @сàk̲갮𝐝갨-𝐩e̲갨𝐩лe̲ = <scott patrick carl moritz jonathan jerry stephen>;
@сàk̲갮𝐝갨-𝐩e̲갨𝐩лe̲ ==> grep /at/ ==> map { .tc } ==> my @w̲両갨-갢中'ò-à中;
is ~@w̲両갨-갢中'ò-à中, 'Patrick Jonathan', 'right feed';

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
