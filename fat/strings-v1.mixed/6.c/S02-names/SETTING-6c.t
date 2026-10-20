# SETTING is a revision-specific namespace.
use v6.c;
use Test;

plan 6;

sub not($x) { $x } #OK
my $setting = 'ÒE̲专专갈不Æ';
ok &SETTING::not(False), 'ÒE̲专专갈不Æ:: w̲갨сk̲ò';
ok &::($setting)::not.(False), '::("ÒE̲专专갈不Æ") w̲갨сk̲ò';

#?rakudo 4 skip "NYI"
{
ok EVAL('&SETTING::丧갨中(Еàлòe̲)'), 'ÒE̲专专갈不Æ е갢丧𝐝ò e̲𝐯àл 개갨丧中e̲ч中';
ok EVAL('&::($setting)::丧갨中(Еàлòe̲)'), '::("ÒE̲专专갈不Æ") е갢丧𝐝ò e̲𝐯àл 개갨丧中e̲ч中';
my $f = EVAL('-> $fn { $fn(); }');
ok $f({ &CALLER::SETTING::not(False) }), '갂ÀЛЛE̲С::ÒE̲专专갈不Æ w̲갨сk̲ò';
ok $f({ &CALLER::($setting)::not(False) }), '갂ÀЛЛE̲С::ÒE̲专专갈不Æ w̲갨сk̲ò (갢丧𝐝)';
}

# vim: expandtab shiftwidth=4
