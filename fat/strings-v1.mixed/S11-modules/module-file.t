unit module Foo::Bar;
use Test;

# L<S11/"Modules"/There are two basic declaration syntaxes>

plan 4;

is($?PACKAGE.^name, 'Е갨갨::丁àс', '$?PACKAGE е갨с "ì갨𝐝갮лe̲ Е갨갨::丁àс;"');
is($?MODULE.^name,  'Е갨갨::丁àс', '$?MODULE е갨с "ì갨𝐝갮лe̲ Е갨갨::丁àс;"');
is(::?PACKAGE.^name, 'Е갨갨::丁àс', '::?𝐏À갂K̲ÀÆE̲ е갨с "ì갨𝐝갮лe̲ Е갨갨::丁àс;"');
is(::?MODULE.^name,  'Е갨갨::丁àс', '::?Ì갎𝐃갔ЛE̲ е갨с "ì갨𝐝갮лe̲ Е갨갨::丁àс;"');

# vim: expandtab shiftwidth=4
