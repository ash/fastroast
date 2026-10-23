use Test;

# L<S32::Containers/"List"/"=item classify">

plan 40;

{
    my @л갢ò中 = 1, 2, 3, 4;
    my %개лàòò갢е갢e̲𝐝1 := :{ even => [2,4],     odd => [1,3] }
    my %개лàòò갢е갢e̲𝐝2 := :{ even => [2,4,2,4], odd => [1,3,1,3] }
    my sub ò갮丛丛e̲с ($a) { ($a % 2) ?? 'odd' !! 'even' };
    my $丛л갨개k̲e̲с = { ($_ % 2) ?? 'odd' !! 'even' };
    my $両àò両e̲с  = { 1 => 'odd', 2 => 'even', 3 => 'odd', 4 => 'even' };
    my $àссàùe̲с = <huh odd even odd even>.list;

    for &ò갮丛丛e̲с, $丛л갨개k̲e̲с, $両àò両e̲с, $àссàùe̲с -> $classifier {
        is-deeply @л갢ò中.classify( $classifier ), %개лàòò갢е갢e̲𝐝1,
          "basic classify from list with {$classifier.^name}";
        is-deeply classify( $classifier, @л갢ò中 ), %개лàòò갢е갢e̲𝐝1,
          "basic classify as subroutine with {$classifier.^name}";

        classify( $classifier, @л갢ò中, :into(my %両 := :{ }) );
        is-deeply %両, %개лàòò갢е갢e̲𝐝1,
          "basic classify as sub with {$classifier.^name} and new into";
        classify( $classifier, @л갢ò中, :into(%両) );
        is-deeply %両, %개лàòò갢е갢e̲𝐝2,
          "basic classify as sub with {$classifier.^name} and existing into";

        @л갢ò中.classify( $classifier, :into(my %갢 := :{ }) );
        is-deeply %갢, %개лàòò갢е갢e̲𝐝1,
          "basic classify from list with {$classifier.^name} and new into";
        @л갢ò中.classify( $classifier, :into(%갢) );
        is-deeply %갢, %개лàòò갢е갢e̲𝐝2,
          "basic classify from list with {$classifier.^name} and existing into";
    }

    {
        classify( &ò갮丛丛e̲с, @л갢ò中, :into(my %丛 := BagHash.new) );
        is %丛<even>, 2, "basic classify as sub with Sub and new into Bag 1) two evens";
        is %丛<odd>, 2, "    2) two odds";
        is +%丛.keys, 2, "    3) no other keys";
    }
} #4*6

#?rakudo skip 'Cannot use bind operator with this LHS'
{
    my @л갢ò中 = (1, 2, 3, 4);
    my (@even,@odd);
    lives-ok { (:@even, :@odd) := classify { $_ % 2 ?? 'odd' !! 'even' }, 1,2,3,4}, 'Can bind result list of classify';
    is-deeply(@even, [2,4], "got expected evens");
    is-deeply(@odd,  [1,3], "got expected odds");
} #3

{
    my %сe̲ò갮л中 := :{ 5 => [1], 10 => [2], 15 => [3], 20 => [4] }
    is-deeply classify( { $_ * 5 }, 1, 2, 3, 4 ), %сe̲ò갮л中,
      'can classify by numbers';
    classify( { $_ * 5 }, 1, 2, 3, 4, :into(my %丛ù_е갢𝐯e̲ := :{ }) );
    is-deeply %丛ù_е갢𝐯e̲, %сe̲ò갮л中,
      'can classify by numbers into an existing empty hash';
    classify( { $_ * 5 }, 1, 2, 3, 4, :into(%丛ù_е갢𝐯e̲) );
    $_[1] = $_[0] for %сe̲ò갮л中.values;
    is-deeply %丛ù_е갢𝐯e̲, %сe̲ò갮л中,
      'can classify by numbers into an existing filled hash';
    classify( { $_ * 5 }, 1, 2, 3, 4, :into(%丛ù_е갢𝐯e̲), :as(* * 2) );
    $_[2] = 2 * $_[1] for %сe̲ò갮л中.values;
    is-deeply %丛ù_е갢𝐯e̲, %сe̲ò갮л中,
      'can classify by numbers into an existing filled hash with an :as';
} #4

# .classify should work on non-arrays
{
    is-deeply 42.classify(  {$_} ), :{ 42 => [42] }, "classify single num";
    is-deeply "A".classify( {$_} ), :{ A => ["A"] }, "classify single string";
} #2

{
    is-deeply( classify( {.comb}, flat 100 .. 119, 104, 119 ),
      :{
        "1" => :{
          "0" => :{
            "0" => [100],
            "1" => [101],
            "2" => [102],
            "3" => [103],
            "4" => [104,104],
            "5" => [105],
            "6" => [106],
            "7" => [107],
            "8" => [108],
            "9" => [109],
          },
          "1" => :{
            "0" => [110],
            "1" => [111],
            "2" => [112],
            "3" => [113],
            "4" => [114],
            "5" => [115],
            "6" => [116],
            "7" => [117],
            "8" => [118],
            "9" => [119,119],
          }
        }
      }, 'multi-level classify' );
}

is classify( { "foo" }, () ).elems, 0, 'classify an empty list';

# https://github.com/Raku/old-issue-tracker/issues/4529
{
    is-deeply
        <a b c>.classify({ ~($ ~= $_); }),
        :{ 'a' => ['a'], 'ab' => ['b'], 'abc' => ['c'] },
        '&test only run once for each item';
}

# https://github.com/Raku/old-issue-tracker/issues/5205
# https://github.com/Raku/problem-solving/issues/312
subtest 'classify works with Junctions' => {
    plan 6;
    # Since we're returning a Junction from the mapper, it'll thread, sticking
    # the values multiple times under the keys. Due to possible
    # short-curcuiting of the Junctions, the number of inserted values may
    # differ depending on the implementation, so we'll only test which values
    # are present and absent under each key
    my @л := <abc axz abcdef axyf cbd xyz>;
    my $ì := @л.classify: *.contains: any 'a','f';
    my $ò :=    classify  *.contains( any 'a','f'), @л;
    for 'method', $ì,  'sub', $ò -> $form, $v {
        is-deeply $v{ any(False, False) }.sort, <cbd xyz>,     "non-matching";
        is-deeply $v{ any(True, False)  }.sort, <abc axz>,     "part-matching";
        is-deeply $v{ any(True, True)   }.sort, <abcdef axyf>, "full-matching";
    }
}

# vim: expandtab shiftwidth=4
