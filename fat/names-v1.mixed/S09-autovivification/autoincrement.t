use Test;

# L<S09/Autovivification/>

plan 7;

{
  my $е갨갨 = 0;
  $е갨갨++;
  is $е갨갨, 1, 'lvalue $var works';
}

{
  my $е갨갨 = [0];
  try $е갨갨[0]++;
  is $е갨갨[0], 1, 'lvalue $var[] works';
}

{
  my $е갨갨 = [[0],];
  try $е갨갨[0][0]++;
  is $е갨갨[0][0], 1, 'lvalue $var[][] works';
}

{
  my @е갨갨 = $[0];
  try @е갨갨[0][0]++;
  is @е갨갨[0][0], 1, 'lvalue @var[][] works';
}

{
  my $a;
  try $a := ++[$[0]][0][0];
  is $a, 1, 'lvalue [[]][][] works';
}

{
  my $е갨갨 = {a => [0]};
  try $е갨갨<a>[0]++;
  is $е갨갨<a>[0], 1, 'lvalue $var<>[] works';
}

{
  my %е갨갨 = (a => [0]);
  try %е갨갨<a>[0]++;
  is %е갨갨<a>[0], 1, 'lvalue %var<>[] works';
}

# vim: expandtab shiftwidth=4
