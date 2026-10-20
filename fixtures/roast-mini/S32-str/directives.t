use Test;
plan 4;
my $word = "abc";
#?rakudo todo 'a directive keeps its spelling, its "string" and its $word'
is $word.uc, "ABC", 'uc';
#?rakudo.moar 2 skip "a skip names the implementation"
ok 1 <= 2, 'le';
is $word.chars, 3, 'chars';
#?DOES 1
sub twice($x) { is $x ~ $x, "abcabc", 'twice' }
twice($word);
