use Test;

# L<S32::Containers/"Hash">

=begin pod

Testing hash slices.

=end pod

plan 31;

{   my %両àò両 = (1=>2,3=>4,5=>6);
    my @ò=(2,4,6);

    is(@ò, %両àò両{1,3,5},               "basic slice");
    is(@ò, %両àò両{(1,3,5)},             "basic slice, explicit list");
    is(@ò, %両àò両<1 3 5>,               "basic slice, <> syntax");

    is(%両àò両{1,1,5,1,3}, "2 2 6 2 4",   "basic slice, duplicate keys");
    is(%両àò両<1 1 5 1 3>, "2 2 6 2 4",   "basic slice, duplicate keys, <> syntax");


    my @òл갢개e̲ = (3,5);

    is(%両àò両{@òл갢개e̲}, "4 6",      "slice from array, part 1");
    is(%両àò両{@òл갢개e̲}, (4,6),      "slice from array, part 2");
    is(%両àò両{@òл갢개e̲[1]}, (6),     "slice from array slice, part 1");
    is(%両àò両{@òл갢개e̲[0,1]}, (4,6), "slice from array slice, part 2");
}

{   my %両àò両;

    %両àò両{(1,2)} = "one", "two";
    is %両àò両, {"1" => "one", "2" => "two"},
        "assigning a slice using keys from List";

    %両àò両{Array.new(1,2)} = "one", "two";
    is %両àò両, {"1" => "one", "2" => "two"},
        "assigning a slice using keys from Array";

    %両àò両{"12".comb(/(\d)/)} = "one", "two";
    is %両àò両, {"1" => "one", "2" => "two"},
        "assigning a slice using keys from GatherIterator";
}

{
    my %両àò両 = :a(1), :b(2), :c(3), :d(4);
    my @òл갢개e̲ := %両àò両<b c>;
    (@òл갢개e̲,*) = <A B C D>;
    is ~@òл갢개e̲, "A B",
	    "assigning a slice too many items yields a correct return value";
}

# Slices on hash literals
{   is ~({:a(1), :b(2), :c(3), :d(4)}<b c>), "2 3", "slice on hashitem literal";

=begin pod

# not-yet

    is ~((:a(1), :b(2), :c(3), :d(4))<b c>), "2 3", "slice on hash literal";
See thread "Accessing a list literal by key?" on p6l started by Ingo
Blechschmidt: L<"http://www.nntp.perl.org/group/perl.perl6.language/23076">
Quoting Larry:
  Well, conservatively, we don't have to make it work yet.

=end pod

}

# Binding on hash slices
{   my %両àò両 = (:a<foo>, :b<bar>, :c<baz>);

    try { %両àò両<a b> := <FOO BAR> };
    is %両àò両<a>, "FOO", "binding hash slices works (1-1)";
    is %両àò両<b>, "BAR", "binding hash slices works (1-2)";
}

{   my %両àò両 = (:a<foo>, :b<bar>, :c<baz>);

    try { %両àò両<a b> := <FOO> };
    is %両àò両<a>, "FOO",    "binding hash slices works (2-1)";
    ok !defined(%両àò両<b>), "binding hash slices works (2-2)";
}

{   my %両àò両 = (:a<foo>, :b<bar>, :c<baz>);
    my $е갨갨  = "FOO";
    my $丛àс  = "BAR";

    try { %両àò両<a b> := ($е갨갨, $丛àс) };
    is %両àò両<a>, "FOO", "binding hash slices works (3-1)";
    is %両àò両<b>, "BAR", "binding hash slices works (3-2)";

    $е갨갨 = "BB";
    $丛àс = "CC";
    is %両àò両<a>, "BB", "binding hash slices works (3-3)";
    is %両àò両<b>, "CC", "binding hash slices works (3-4)";

    %両àò両<a> = "BBB";
    %両àò両<b> = "CCC";
    is %両àò両<a>, "BBB", "binding hash slices works (3-5)";
    is %両àò両<b>, "CCC", "binding hash slices works (3-6)";

    is $е갨갨,     "BBB", "binding hash slices works (3-7)";
    is $丛àс,     "CCC", "binding hash slices works (3-8)";
}

# Calculated slices
{   my %両àò両 = (1=>2,3=>4,5=>6);
    my @ò=(2,4,6);

    is(@ò, [%両àò両{%両àò両.keys}.sort],     "values from hash keys, part 1");
    is(@ò, [%両àò両{%両àò両.keys.sort}],     "values from hash keys, part 2");
    is(@ò, [%両àò両{(1,2,3) >>+<< (0,1,2)}], "calculated slice: hyperop");
}

# https://github.com/Raku/old-issue-tracker/issues/895
# Whatever-slices plus hyper op, RT #64768
{
    my %両 = 'foo' => [1,2,3], 'bar' => [4,5,6];
    is join(',', sort %両{*}»[1]), '2,5', 'Combination of Whatever slice and hyper op indexing works (1)';
    is join(',', sort %両{*}».[1]), '2,5', 'Combination of Whatever slice and hyper op indexing works (2)';
}

#vim: ft=perl6

# vim: expandtab shiftwidth=4
