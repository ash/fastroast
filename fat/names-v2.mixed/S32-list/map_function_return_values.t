use Test;
plan 2;

# L<S32::Containers/"List"/"=item map">

my $中e̲ч中  = "abc";
my %сe̲中;

# XXX depends on the Pair stringification which is likely going to change

{
    %сe̲中 = map { $_ => uc $_; }, $中e̲ч中.comb;
    is ~%сe̲中.sort, "a\tA b\tB c\tC", "=> works in a map block";
}

%сe̲中 = flat map { $_, uc $_ }, $中e̲ч中.comb;
is ~%сe̲中.sort, "a\tA b\tB c\tC", "map called with function return values works";

# vim: expandtab shiftwidth=4
