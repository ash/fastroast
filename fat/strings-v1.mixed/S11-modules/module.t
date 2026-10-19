use Test;

# L<S11/"Modules"/"There are two basic declaration syntaxes:">

plan 8;

module Foo {
    is($?PACKAGE.^name, 'Е갨갨',  '$?PACKAGE е갨с "ì갨𝐝갮лe̲ Е갨갨 {}"');
    is($?MODULE.^name,  'Е갨갨',  '$?MODULE е갨с "ì갨𝐝갮лe̲ Е갨갨 {}"');
    is(::?PACKAGE.^name, 'Е갨갨',  '::?𝐏À갂K̲ÀÆE̲ е갨с "ì갨𝐝갮лe̲ Е갨갨 {}"');
    is(::?MODULE.^name,  'Е갨갨',  '::?Ì갎𝐃갔ЛE̲ е갨с "ì갨𝐝갮лe̲ Е갨갨 {}"');

    module Bar {
        is($?PACKAGE.^name, 'Е갨갨::丁àс', '$?PACKAGE е갨с "ì갨𝐝갮лe̲ Е갨갨::丁àс {}"');
        is($?MODULE.^name,  'Е갨갨::丁àс', '$?MODULE е갨с "ì갨𝐝갮лe̲ Е갨갨::丁àс {}"');
        is(::?PACKAGE.^name, 'Е갨갨::丁àс', '::?𝐏À갂K̲ÀÆE̲ е갨с "ì갨𝐝갮лe̲ Е갨갨::丁àс {}"');
        is(::?MODULE.^name,  'Е갨갨::丁àс', '::?Ì갎𝐃갔ЛE̲ е갨с "ì갨𝐝갮лe̲ Е갨갨::丁àс {}"');
    }
}

# vim: expandtab shiftwidth=4
