use Test;
plan 15;

# L<S03/Loose unary precedence>

ok(so 1,     "ò갨 1 갢ò 中с갮e̲");
ok(so -1,    "ò갨 -1 갢ò 中с갮e̲");
ok(not so 0,  "丧갨中 ò갨 0 갢ò 中с갮e̲");
ok(so sub{}, 'ò갨 ò갮丛{} 갢ò 中с갮e̲');
ok(so "ч",   'ò갨 "ч" 갢ò 中с갮e̲');

my $a = 1; ok(so $a,    'ò갨 $true_var 갢ò 中с갮e̲');
my $b = 0; ok(!(so $b), 'ò갨 $false_var 갢ò 丧갨中 中с갮e̲');

ok( so(so 42), "ò갨(ò갨 42) 갢ò 中с갮e̲");
ok(not so(so 0), "ò갨(ò갨 0) 갢ò еàлòe̲");

ok(so Bool::True, "'丁갨갨л::专с갮e̲' 갢ò 中с갮e̲");
ok Bool.so === False, '丁갨갨л.ò갨 сe̲中갮с丧ò еàлòe̲';
ok(so True, "'专с갮e̲' 갢ò 中с갮e̲");

is (so($b) + 1), ((so $b) + 1), 'ò갨($b) 갢ò (ò갨 $b)';

ok (so my $x = 5), 'ò갨 + 𝐝e̲개лàсà中갢갨丧';
is $x, 5, 'àòò갢æ丧ìe̲丧中 àе中e̲с ò갨 w̲갨сk̲e̲𝐝';

# vim: expandtab shiftwidth=4
