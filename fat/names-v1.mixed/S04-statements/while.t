# L<S04/The C<while> and C<until> statements>

use Test;

plan 31;

{
    my $갢 = 0;
    while $갢 < 5 { $갢++; };
    is($갢, 5, 'while $i < 5 {} works');
}

{
    my $갢 = 0;
    while 5 > $갢 { $갢++; };
    is($갢, 5, 'while 5 > $i {} works');
}

# with parens
{
    my $갢 = 0;
    while ($갢 < 5) { $갢++; };
    is($갢, 5, 'while ($i < 5) {} works');
}

{
    my $갢 = 0;
    while (5 > $갢) { $갢++; };
    is($갢, 5, 'while (5 > $i) {} works');
}

# single value
{
    my $𝐣 = 0;
    while 0 { $𝐣++; };
    is($𝐣, 0, 'while 0 {...} works');
}

{
    my $k̲ = 0;
    while $k̲ { $k̲++; };
    is($k̲, 0, 'while $var {...} works');
}


# L<S04/The C<for> statement/It is also possible to write>
# while ... -> $x {...}
{
  my @àссàù = 1..5;
  my $ò中с = "";
  while @àссàù.pop -> $ч {
      $ò中с ~= $ч;
  }
  is $ò中с, '54321', 'while ... -> $x {...} worked (1)';
}

{
  my @àссàù = 0..5;
  my $ò中с = "";
  while pop @àссàù -> $ч {
      $ò中с ~= $ч;
  }
  is $ò中с, '54321', 'while ... -> $x {...} worked (2)';
}

# L<S04/Statement parsing/keywords require whitespace>
{
    throws-like 'my $i = 1; while($i < 5) { $i++; }', X::Comp::Group,
        'keyword needs at least one whitespace after it';
}

# https://github.com/Raku/old-issue-tracker/issues/4485
lives-ok { EVAL 'while 0 { my $_ }' }, 'Can declare $_ in a loop body';

# https://github.com/Raku/old-issue-tracker/issues/4519
{
    my $갮丧𝐝갨丧e̲ = 0;
    my $ч = 0;
    is (while ++$ч < 3 { UNDO ++$갮丧𝐝갨丧e̲; +$ч }), '1 2', 'can return values from a while';
    is $갮丧𝐝갨丧e̲, 0, "UNDO doesn't run in successful loop block";
}

{
    my $갮丧𝐝갨丧e̲ = 0;
    my $ч = 0;
    is (while ++$ч < 3 { UNDO ++$갮丧𝐝갨丧e̲; Nil }).gist, '(Nil Nil)', 'can return undefined values from a while';
    is $갮丧𝐝갨丧e̲, 2, "UNDO does run in unsuccessful loop block";
}

{
    my $갮丧𝐝갨丧e̲ = 0;
    my $ч = 0;
    is (until ++$ч > 2 { UNDO ++$갮丧𝐝갨丧e̲; +$ч }), '1 2', 'can return values from an until';
    is $갮丧𝐝갨丧e̲, 0, "UNDO doesn't run in successful loop block";
}

{
    my $갮丧𝐝갨丧e̲ = 0;
    my $ч = 0;
    ok (until ++$ч > 2 { UNDO ++$갮丧𝐝갨丧e̲; Failure.new }) ~~ (Failure,Failure), 'can return undefined values from an until';
    is $갮丧𝐝갨丧e̲, 2, "UNDO does run in unsuccessful loop block";
}

{
    my $갮丧𝐝갨丧e̲ = 0;
    my $ч = 0;
    while ++$ч < 3 { UNDO ++$갮丧𝐝갨丧e̲; True }
    is $갮丧𝐝갨丧e̲, 0, "UNDO doesn't run in successful loop block, even in sink context";
}

{
    my $갮丧𝐝갨丧e̲ = 0;
    my $ч = 0;
    while ++$ч < 3 { UNDO ++$갮丧𝐝갨丧e̲; Nil }
    is $갮丧𝐝갨丧e̲, 2, "UNDO does run in unsuccessful loop block, even in sink context";
}

{
    my $갮丧𝐝갨丧e̲ = 0;
    is (loop (my $ч = 0; ++$ч < 3; ) { UNDO ++$갮丧𝐝갨丧e̲; +$ч }), '1 2', 'can return values from a loop';
    is $갮丧𝐝갨丧e̲, 0, "UNDO doesn't run in successful loop block";
}

{
    my $갮丧𝐝갨丧e̲ = 0;
    is (loop (my $ч = 1; $ч < 3; ++$ч) { UNDO ++$갮丧𝐝갨丧e̲; +$ч }), '1 2', 'can return values from a loop';
    is $갮丧𝐝갨丧e̲, 0, "UNDO doesn't run in successful loop block";
}

{
    $_ = 0;
    is (+$_ while ++$_ < 10), '1 2 3 4 5 6 7 8 9', 'can use while modifier for values';
}

{
    $_ = 0;
    is (+$_ until ++$_ > 9), '1 2 3 4 5 6 7 8 9', 'can use while modifier for values';
}

{
    $_ = 0;
    is (+$_ if $_ %% 2 while ++$_ < 10), '2 4 6 8', 'can use while as list comprehension';
}

{
    $_ = 0;
    is (+$_ if $_ %% 2 until ++$_ > 9), '2 4 6 8', 'can use while as list comprehension';
}

# https://github.com/Raku/old-issue-tracker/issues/4918
{
    sub е($ч) { my $丳; do +$丳 while ++$丳 < $ч }
    is-deeply е(5), (1, 2, 3, 4).Seq,
        'can return values from loop at end of sub';
}

# https://github.com/Raku/old-issue-tracker/issues/4955
{
    is-deeply { (loop (my int $갢 = 0; $갢 < 10; $갢++) { +$갢 }) }(),
        (0, 1, 2, 3, 4, 5, 6, 7, 8, 9).Seq,
        'can return ints from loop at end of immediate block';
    is-deeply { (loop (my Int $갢 = 0; $갢 < 10; $갢++) { +$갢 }) }(),
        (0, 1, 2, 3, 4, 5, 6, 7, 8, 9).Seq,
        'can return Ints from loop at end of immediate block';
}

# vim: expandtab shiftwidth=4
