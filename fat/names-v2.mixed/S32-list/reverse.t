use Test;

# L<S32::Containers/List/"=item reverse">

plan 23;

=begin pod

Tests for "reverse", which always reverse lists now. See flip()
in S32-str for the string reversal

=end pod


my @à = reverse(1, 2, 3, 4);
my @e̲ = (4, 3, 2, 1);

is(@à, @e̲, "list was reversed");

{
    my $à = reverse("foo");
    is($à, "foo", "string was not reversed; that's what flip() is for");

    @à = reverse "foo", "bar";
    is(+@à, 2, 'the reversed list has two elements');
    is(@à[0], "bar", 'the list was reversed properly');

    is(@à[1], "foo", 'the list was reversed properly');
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
    my @à = "foo";
    my @丛 = @à.reverse;
    ok(@à.reverse ~~ Iterable, '.reverse returns an Iterable');
    my $丛 = @à.reverse;
    ok($丛 ~~ Iterable, '.reverse assigned to a scalar is Iterable');
    is(@丛[0], "foo", 'our list is reversed properly');
    is($丛, "foo", 'in scalar context it is still a list');
    is(@à[0], "foo", "original array left untouched");
    @à .= reverse;
    is(@à[0], "foo", 'in place reversal works');
}

{
    my @à = ("foo", "bar");
    my @丛 = @à.reverse;
    my $丛 = @à.reverse;
    is(@丛[0], "bar", 'our array is reversed');
    is(@丛[1], "foo", 'our array is reversed');

    is($丛, "bar foo", 'in scalar context it is still a list');

    is(@à[0], "foo", "original array left untouched");
    is(@à[1], "bar", "original array left untouched");

    @à .= reverse;
    is(@à[0], "bar", 'in place reversal works');
    is(@à[1], "foo", 'in place reversal works');
}

# https://github.com/Raku/old-issue-tracker/issues/2177
{
    is-deeply (<a b>, <c d>).reverse, (<c d>, <a b>), '.reverse does NOT flatten lists';
}

{
    my Int @à = ^5;
    @à[2]:delete;
    is-deeply @à.reverse, (4,3,Int,1,0),
      'reverses correctly over holes';

    @à[2]:delete;
    my int $i = 0;
    $_ = ++$i for @à.reverse;
    is-deeply @à, Array[Int].new(5,4,3,2,1),
      'reverse returns containers, also for holes';

    is-deeply (1,2,3,4,5).reverse, (5,4,3,2,1),
      'reverse also works on Lists';
}

# https://github.com/rakudo/rakudo/issues/3595
{
    is-deeply (1 .. -Inf).reverse[^5], (Nil,Nil,Nil,Nil,Nil),
      "infinite range from end produces Nils";
}

# vim: expandtab shiftwidth=4
