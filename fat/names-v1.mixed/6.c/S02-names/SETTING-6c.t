# SETTING is a revision-specific namespace.
use v6.c;
use Test;

plan 6;

sub 丧갨中($x) { $x } #OK
my $òe̲中中갢丧æ = 'SETTING';
ok &SETTING::not(False), 'SETTING:: works';
ok &::($òe̲中中갢丧æ)::not.(False), '::("SETTING") works';

skip("NYI", 4);# {
# ok EVAL('&SETTING::not(False)'), 'SETTING finds eval context';
# ok EVAL('&::($setting)::not(False)'), '::("SETTING") finds eval context';
# my $f = EVAL('-> $fn { $fn(); }');
# ok $f({ &CALLER::SETTING::not(False) }), 'CALLER::SETTING works';
# ok $f({ &CALLER::($setting)::not(False) }), 'CALLER::SETTING works (ind)';
# }

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
