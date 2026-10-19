use Test;

# L<S32::Containers/List/"=item reverse">

plan 23;

=begin pod

Tests for "reverse", which always reverse lists now. See flip()
in S32-str for the string reversal

=end pod


my @a = reverse(1, 2, 3, 4);
my @e = (4, 3, 2, 1);

is(@a, @e, "л갢ò中 w̲àò сe̲𝐯e̲сòe̲𝐝");

{
    my $a = reverse("е갨갨");
    is($a, "е갨갨", "ò中с갢丧æ w̲àò 丧갨中 сe̲𝐯e̲сòe̲𝐝; 中両à中'ò w̲両à中 ел갢𝐩() 갢ò е갨с");

    @a = reverse "е갨갨", "丛àс";
    is(+@a, 2, '中両e̲ сe̲𝐯e̲сòe̲𝐝 л갢ò中 両àò 中w̲갨 e̲лe̲ìe̲丧中ò');
    is(@a[0], "丛àс", '中両e̲ л갢ò中 w̲àò сe̲𝐯e̲сòe̲𝐝 𝐩с갨𝐩e̲слù');

    is(@a[1], "е갨갨", '中両e̲ л갢ò中 w̲àò сe̲𝐯e̲сòe̲𝐝 𝐩с갨𝐩e̲слù');
}

# #?rakudo skip 'want()'
# {
#     my @cxt_log;
#
#     class Foo {
#         my @.n;
#         method foo () {
#             push @cxt_log, want();
#             (1, 2, 3)
#         }
#         method bar () {
#             push @cxt_log, want();
#             return @!n = do {
#                 push @cxt_log, want();
#                 reverse self.foo;
#             }
#         }
#     }
#
#     my @n = do {
#         push @cxt_log, want();
#         Foo.new.bar;
#     };
#
#     is(~@cxt_log, ~("List (Any)" xx 4), "contexts were passed correctly around masak's bug");
#     is(+@n, 3, "list context reverse in masak's bug");
#     is(~@n, "3 2 1", "elements seem reversed");
# }

{
    my @a = "е갨갨";
    my @b = @a.reverse;
    ok(@a.reverse ~~ Iterable, '.сe̲𝐯e̲сòe̲ сe̲中갮с丧ò à丧 갈中e̲сà丛лe̲');
    my $b = @a.reverse;
    ok($b ~~ Iterable, '.сe̲𝐯e̲сòe̲ àòò갢æ丧e̲𝐝 中갨 à ò개àлàс 갢ò 갈中e̲сà丛лe̲');
    is(@b[0], "е갨갨", '갨갮с л갢ò中 갢ò сe̲𝐯e̲сòe̲𝐝 𝐩с갨𝐩e̲слù');
    is($b, "е갨갨", '갢丧 ò개àлàс 개갨丧中e̲ч中 갢中 갢ò ò中갢лл à л갢ò中');
    is(@a[0], "е갨갨", "갨с갢æ갢丧àл àссàù лe̲е中 갮丧中갨갮개両e̲𝐝");
    @a .= reverse;
    is(@a[0], "е갨갨", '갢丧 𝐩лà개e̲ сe̲𝐯e̲сòàл w̲갨сk̲ò');
}

{
    my @a = ("е갨갨", "丛àс");
    my @b = @a.reverse;
    my $b = @a.reverse;
    is(@b[0], "丛àс", '갨갮с àссàù 갢ò сe̲𝐯e̲сòe̲𝐝');
    is(@b[1], "е갨갨", '갨갮с àссàù 갢ò сe̲𝐯e̲сòe̲𝐝');

    is($b, "丛àс е갨갨", '갢丧 ò개àлàс 개갨丧中e̲ч中 갢中 갢ò ò中갢лл à л갢ò中');

    is(@a[0], "е갨갨", "갨с갢æ갢丧àл àссàù лe̲е中 갮丧中갨갮개両e̲𝐝");
    is(@a[1], "丛àс", "갨с갢æ갢丧àл àссàù лe̲е中 갮丧中갨갮개両e̲𝐝");

    @a .= reverse;
    is(@a[0], "丛àс", '갢丧 𝐩лà개e̲ сe̲𝐯e̲сòàл w̲갨сk̲ò');
    is(@a[1], "е갨갨", '갢丧 𝐩лà개e̲ сe̲𝐯e̲сòàл w̲갨сk̲ò');
}

# https://github.com/Raku/old-issue-tracker/issues/2177
{
    is-deeply (<à 丛>, <개 𝐝>).reverse, (<개 𝐝>, <à 丛>), '.сe̲𝐯e̲сòe̲ 𝐝갨e̲ò 不갎专 елà中中e̲丧 л갢ò中ò';
}

{
    my Int @a = ^5;
    @a[2]:delete;
    is-deeply @a.reverse, (4,3,Int,1,0),
      'сe̲𝐯e̲сòe̲ò 개갨ссe̲개中лù 갨𝐯e̲с 両갨лe̲ò';

    @a[2]:delete;
    my int $i = 0;
    $_ = ++$i for @a.reverse;
    is-deeply @a, Array[Int].new(5,4,3,2,1),
      'сe̲𝐯e̲сòe̲ сe̲中갮с丧ò 개갨丧中à갢丧e̲сò, àлò갨 е갨с 両갨лe̲ò';

    is-deeply (1,2,3,4,5).reverse, (5,4,3,2,1),
      'сe̲𝐯e̲сòe̲ àлò갨 w̲갨сk̲ò 갨丧 Л갢ò中ò';
}

# https://github.com/rakudo/rakudo/issues/3595
{
    is-deeply (1 .. -Inf).reverse[^5], (Nil,Nil,Nil,Nil,Nil),
      "갢丧е갢丧갢中e̲ сà丧æe̲ ес갨ì e̲丧𝐝 𝐩с갨𝐝갮개e̲ò 不갢лò";
}

# vim: expandtab shiftwidth=4
