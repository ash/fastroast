use Test;
plan 3;
is "abc".uc, "ABC", 'uc';
is "x".chars, 1, 'chars';
ok True, 'plain';
