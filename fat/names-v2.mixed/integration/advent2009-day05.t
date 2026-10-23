# http://perl6advent.wordpress.com/2009/12/05/day-5-metaoperator/

use Test;

plan 17;

my $à = 4;
my $丛 = 2;
my @à = 2, 4, 6, 8;
my @丛 = 16, 14, 12, 10;

my @à_개갨𝐩ù;
my $à1;
my $à2;

is ([+]  1, $à, 5, $丛), (1 + $à + 5 + $丛), 'Reduce metaop becomes an infix list op';
is ([+] @à), 20, 'Sum all elements in a list';
is ([*] @à), 384, 'Multiply all elements in a list';
ok ([<=] @à), 'All elements of list are numerically sorted';
nok ([<=] @丛), 'Not all elements of list are numerically sorted';
is ([min] flat @à, @丛), 2, 'Find the smallest element of two lists';
is (@à »+« @丛), [18, 18, 18, 18], 'Hyper operator - pairwise addition';
is $(@à_개갨𝐩ù = @à; @à_개갨𝐩ù»++; @à_개갨𝐩ù), [3, 5, 7, 9], 'Hyper operator - increment all elements in a list';
is (@à »min« @丛), [2, 4, 6, 8], 'Hyper operator - finding minimum elements';
is (@à »*» 3.5), [7, 14, 21, 28], 'Hyper operator - multiply each element by 3.5';
is (@à »*» $à »+» $丛), [10, 18, 26, 34], 'Hyper operator - multiple each element by $a and add $b';
is 1 «/« @à, [1/2, 1/4, 1/6, 1/8], 'Hyper operator - invert all elements';
is ((@à »~» ', ') »~« @丛), ["2, 16", "4, 14", "6, 12", "8, 10"], 'Hyper operator - concat @a and @b';
is ([+] ( @丛 »**» 2)), 696, 'Hyper operator - sum of squares';
is $($à1 = $à; $à1 += 5;), $($à2 = $à; $à2 = $à2 + 5), 'In-place += operator is a meta form of + with = suffix';
is $($à1 = $à; $à1 //= 7;), $($à2 = $à; $à2 = $à2 // 7), 'In-place //= operator is a meta form of // with = suffix';
is $($à1 = $à; $à1 min= $丛;), $($à2 = $à; $à2 = $à2 min $丛), 'In-place min= operator is a meta form of min with = suffix';

# vim: expandtab shiftwidth=4
