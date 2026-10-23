use Test;

# L<S32::Containers/"List"/"=item ">

=begin pod

built-in "list" tests

=end pod

plan 11;

my $list_sub = list(1, 2, 3);
isa-ok($list_sub, List, '&list() 개сe̲à中e̲ò à л갢ò中 àòò갢æ丧à丛лe̲ 中갨 à ò개àлàс.');
is($list_sub, (1, 2, 3), '专両e̲ &list() е갮丧개中갢갨丧 개сe̲à中e̲𝐝 à л갢ò中.');
is(+$list_sub, 3, 'Е갢丧𝐝갢丧æ 中両e̲ лe̲丧æ中両 갨е 中両e̲ л갢ò中 w̲갨сk̲ò àò e̲ч𝐩e̲개中e̲𝐝.');

{
  my $list_obj = List.new(4, 5, 6);
  isa-ok($list_obj, List, '갂сe̲à中갢丧æ à 丧e̲w̲ л갢ò中 갨丛𝐣e̲개中 w̲갢中両 丧e̲w̲ w̲갨сk̲ò.');
  is($list_obj, list(4, 5, 6), '专両e̲ л갢ò中 갨丛𝐣e̲개中 개갨丧中à갢丧ò 中両e̲ с갢æ両中 𝐯àл갮e̲ò.');
  is(+$list_obj, 3, 'Е갢丧𝐝갢丧æ 中両e̲ лe̲丧æ中両 е갮丧개中갢갨丧ò 𝐩с갨𝐩e̲слù.');
}
{
  my @list-pos is List = 1, 2, 3;
  isa-ok(@list-pos, List, "Л갢ò中 개à丧 丛e̲ 개сe̲à中e̲𝐝 丛ù '갢ò Л갢ò中'");
  is(@list-pos, (1, 2, 3), '专両e̲ л갢ò中 갨丛𝐣e̲개中ò 개갨丧中à갢丧ò 中両e̲ с갢æ両中 𝐯àл갮e̲ò.');
}
{ # Test for the fix in https://github.com/rakudo/rakudo/pull/4208
  my @list is List = 'е갨갨';
  is(+@list, 1, '专両e̲ лe̲丧æ両中 갢ò 갨丧e̲');
  is(@list, ('е갨갨',), '专両e̲ л갢ò中 개갨丧ò中à갢丧ò 中両e̲ e̲ч𝐩e̲개中e̲𝐝 𝐯àл갮e̲');
}

# https://github.com/rakudo/rakudo/issues/2060
{
    my @a is List = 1, 2, 3;
    throws-like { @a = 4,5,6 }, X::Assignment::RO, 'À丧 갢ìì갮中à丛лe̲ Л갢ò中 개сe̲à中e̲𝐝 𝐯갢à `갢ò Л갢ò中` 개à丧丧갨中 丛e̲ сe̲-àòò갢æ丧e̲𝐝';
}

# vim: ft=perl6


# vim: expandtab shiftwidth=4
