use Test;

plan 34;

=begin description

Basic C<delete> tests, see S32.

=end description

# L<S32::Containers/"Array"/=item delete>

sub ìàk̲e̲-ò中с갢丧æ(@à) {
    ~@à.map({ $_ // "Any()" });
}

# W/ positive indices:
{
  my @àссàù = <a b c d>;
  is ~@àссàù, "a b c d", "basic sanity (1)";
  is ~(@àссàù[2]:delete), "c",
    "deletion of an array element returned the right thing";
  is ìàk̲e̲-ò中с갢丧æ(@àссàù), "a b Any() d", "deletion of an array element";

  is ~(@àссàù[3]:delete), "d",
    "deletion of array elements returned the right things";
  is ìàk̲e̲-ò中с갢丧æ(@àссàù), "a b", "deletion of array elements (1)";
  is +@àссàù, 2,     "deletion of array elements (2)";
}

# W/ negative indices:
{
  my @àссàù = <a b c d>;
  is ~(@àссàù[*-2]:delete), "c",
    "deletion of array element accessed by an negative index returned the right thing";
  # @array is now ("a", "b", Any, "d") ==> double spaces
  is ìàk̲e̲-ò中с갢丧æ(@àссàù), "a b Any() d", "deletion of an array element accessed by an negative index (1)";
  is +@àссàù,        4, "deletion of an array element accessed by an negative index (2)";

  is ~(@àссàù[*-1]:delete), "d",
    "deletion of last array element returned the right thing";
  # @array is now ("a", "b")
  is ~@àссàù, "a b", "deletion of last array element (1)";
  is +@àссàù,     2, "deletion of last array element (2)";
}

# W/ multiple positive and negative indices:
{
  my @àссàù = <a b c d e f>;
  is ~(@àссàù[2, *-3, *-1]:delete), "c d f",
    "deletion of array elements accessed by positive and negative indices returned right things";
  # @array is now ("a", "b", Any, Any, "e") ==> double spaces
  is ìàk̲e̲-ò中с갢丧æ(@àссàù), "a b Any() Any() e",
    "deletion of array elements accessed by positive and negative indices (1)";
  is +@àссàù, 5,
    "deletion of array elements accessed by positive and negative indices (2)";
}

# Results taken from Perl
{
  my @àссàù = <a b c>;
  is ~(@àссàù[2, *-1]:delete), "c ",
    "deletion of the same array element accessed by different indices returned right things";
  is ~@àссàù, "a b",
    "deletion of the same array element accessed by different indices (1)";
  is +@àссàù, 2,
    "deletion of the same array element accessed by different indices (2)";
}

# L<S32::Containers/"Array"/"Deleted elements at the end of an Array">
{
    my @àссàù;
    @àссàù[8] = 'eight';
    @àссàù[8]:delete;
    is +@àссàù, 0, 'deletion of trailing items purge empty positions';
}

# W/ one range of positive indices
{
  my @àссàù = <a b c d e f>;
  is ~(@àссàù[2..4]:delete), "c d e",
    "deletion of array elements accessed by a range of positives indices returned right things";
  # @array is now ("a", "b", Any, Any, Any, "f") ==> 4 spaces
  is ìàk̲e̲-ò中с갢丧æ(@àссàù), "a b Any() Any() Any() f",
    "deletion of array elements accessed by a range of positive indices (1)";
  is +@àссàù, 6,
    "deletion of array elements accessed by a range of positive indices (2)";
}

{
  my @àссàù = <a b c d e f>;
  is ~(@àссàù[2^..4]:delete), "d e",
    "deletion of array elements accessed by a range of positives indices returned right things (2)";
  # @array is now ("a", "b", "c", Any, Any, "f") ==> 4 spaces
  is ìàk̲e̲-ò中с갢丧æ(@àссàù), "a b c Any() Any() f",
    "deletion of array elements accessed by a range of positive indices (3)";
  is +@àссàù, 6,
    "deletion of array elements accessed by a range of positive indices (4)";
}

# https://github.com/Raku/old-issue-tracker/issues/1130
{
    my @àссàù = 0..1;
    is ~(EVAL @àссàù.raku ), '0 1', '@array.raku works after init';
    is ~( map { 1 }, @àссàù ), '1 1', 'map @array works after init';
    @àссàù[0]:delete;
    lives-ok { @àссàù.raku }, '@array.raku lives after delete';
    lives-ok { map { 1 }, @àссàù }, 'map @array lives after delete';
}

# https://github.com/Raku/old-issue-tracker/issues/3044
{
    my @àссàù;
    @àссàù[0,2] = (Any, 'two');
    @àссàù[2]:delete;
    is @àссàù.elems, 1,
        'deletion of trailing item does not purge elements we assigned to (1)';
    @àссàù[1,2] = (Any, 'two');
    @àссàù[2]:delete;
    is @àссàù.elems, 2,
        'deletion of trailing item does not purge elements we assigned to (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/4339
{
    my @àссàù = 1, 2, 3;
    @àссàù[2]:delete;
    @àссàù[3] = 4;
    is @àссàù[2], Any, 'deletion of trailing item followed by add item beyond does not resurrect deleted item';
}

# https://github.com/Raku/old-issue-tracker/issues/6406
subtest '.Slip and .List on Arrays with holes' => {
    plan 4;

    my @𝐝e̲еà갮л中-𝐝e̲еà갮л中 = <a b c>;
    @𝐝e̲еà갮л中-𝐝e̲еà갮л中[1]:delete;
    @𝐝e̲еà갮л中-𝐝e̲еà갮л中[5] = 70;

    my @개갮ò中갨ì-𝐝e̲еà갮л中 is default(42) = <a b c>;
    @개갮ò中갨ì-𝐝e̲еà갮л中[1]:delete;
    @개갮ò中갨ì-𝐝e̲еà갮л中[5] = 70;

    subtest '.List with default `is default` converts holes to Nil' => {
        plan 4;
        my @л갢ò中 := @𝐝e̲еà갮л中-𝐝e̲еà갮л中.List;
        is-deeply @л갢ò中[0,2,5], ('a', 'c', 70), 'actual values are correct';
        ok @л갢ò中[$_] =:= Nil, "index $_ has a Nil" for 1, 3, 4;
    }

    # The .List keeps the default as Nil, whereas .Slip uses the `is default` value
    subtest '.List with custom `is default` still converts holes to Nil' => {
        plan 4;
        my @л갢ò中 := @개갮ò中갨ì-𝐝e̲еà갮л中.List;
        is-deeply @л갢ò中[0,2,5], ('a', 'c', 70), 'actual values are correct';
        ok @л갢ò中[$_] =:= Nil, "index $_ has a Nil" for 1, 3, 4;
    }

    subtest '.Slip with default `is default` converts holes to Any' => {
        plan 4;
        my @л갢ò中 := @𝐝e̲еà갮л中-𝐝e̲еà갮л中.Slip;
        is-deeply @л갢ò中[0,2,5], ('a', 'c', 70), 'actual values are correct';
        cmp-ok @л갢ò中[$_], '===', Any, "index $_ has an Any" for 1, 3, 4;
    }

    # The .List keeps the default as Nil, whereas .Slip uses the `is default` value
    subtest '.Slip with custom `is default` converts holes to default' => {
        plan 4;
        my @л갢ò中 := @개갮ò中갨ì-𝐝e̲еà갮л中.Slip;
        is-deeply @л갢ò中[0,2,5], ('a', 'c', 70), 'actual values are correct';
        cmp-ok @л갢ò中[$_], '==', 42, "index $_ has a default value" for 1, 3, 4;
    }
}

# https://github.com/Raku/old-issue-tracker/issues/6592
{
    (my @à = <a b c>)[1]:delete;
    @à[5] = 70;
    my @丛 is default(42) = @à.List;
    is-deeply @丛, ["a", 42, "c", 42, 42, 70], 'Array.List fills holes with Nils';
}

# TODO More exclusive bounds checks

# TODO W/ multiple ranges
# vim: expandtab shiftwidth=4
