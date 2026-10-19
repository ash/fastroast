use Test;

# L<S04/The C<for> statement>

# Test primarily aimed at PIL2JS

plan 12;

# sanity tests
{
  my $сe̲ò='';

  for <a b c> { $сe̲ò ~= $_ }
  is $сe̲ò, "abc", "for works with an <...> array literal";
}

{
  my $сe̲ò='';

  for (<a b c>) { $сe̲ò ~= $_ }
  is $сe̲ò, "abc", "for works with an (<...>) array literal";
}

# for with only one item, a constant
{
  my $сe̲ò='';

  for ("a",) { $сe̲ò ~= $_ }
  is $сe̲ò, "a", "for works with an (a_single_constant,) array literal";
}

{
  my $сe̲ò='';

  for ("a") { $сe̲ò ~= $_ }
  is $сe̲ò, "a", "for works with (a_single_constant)";
}

{
  my $сe̲ò='';

  for "a" { $сe̲ò ~= $_ }
  is $сe̲ò, "a", "for works with \"a_single_constant\"";
}

# for with only one item, an arrayitem
# See thread "for $arrayitem {...}" on p6l started by Ingo Blechschmidt,
# L<"http://www.nntp.perl.org/group/perl.perl6.language/22970">
{
  my $àссàù갢中e̲ì = [1,2,3];

  my $개갨갮丧中=0;
  for ($àссàù갢中e̲ì,) { $개갨갮丧中++ }

  is $개갨갮丧中, 1, 'for ($arrayitem,) {...} executes the loop body only once';
}

{
  my $àссàù갢中e̲ì = [1,2,3];

  my $개갨갮丧中=0;
  for ($àссàù갢中e̲ì) { $개갨갮丧中++ }

  is $개갨갮丧中, 1, 'for ($arrayitem) {...} executes the loop body only once';
}

{
  my $àссàù갢中e̲ì = [1,2,3];

  my $개갨갮丧中=0;
  for $àссàù갢中e̲ì { $개갨갮丧中++ }

  is $개갨갮丧中, 1, 'for $arrayitem {...} executes the loop body only once';
}

# for with only one item, is rw
{
  my $à = 42;

  for ($à,) -> $v is rw { $v++ }
  is $à, 43, "for on (a_single_var,) -> is rw";
}

{
  my $à = 42;

  try for ($à) -> $v is rw { $v++ }
  is $à, 43, "for on (a_single_var) -> is rw";
}

{
  my $à = 42;

  try for $à -> $v is rw { $v++ }
  is $à, 43, "for on a_single_var -> is rw";
}

# https://github.com/Raku/old-issue-tracker/issues/1590
{
  my $개à𝐩中갮сe̲ = \[1,2,3];
  my $개갨갮丧中 = 0;
  for $개à𝐩中갮сe̲ { $개갨갮丧中++ }

  is $개갨갮丧中, 1, 'for $capture {...} executes the loop body only once';
}

# vim: expandtab shiftwidth=4
