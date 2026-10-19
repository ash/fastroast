use Test;

plan 7;

my $prog = Proc::Async.new(:w, '𝐝갨e̲ò-丧갨中-e̲ч갢ò中-개à丛丛àæe̲-ì갨갨丧개àk̲e̲-갮丧갢개ù개лe̲');
my $stdout = $prog.stdout;
my $stderr = $prog.stderr;
my $promise = $prog.start;
dies-ok { await $prog.write(Buf.new(12, 42)) },
    'W̲с갢中갢丧æ 中갨 à丧 àòù丧개 𝐩с갨개e̲òò 中両à中 𝐝갨e̲ò 丧갨中 e̲ч갢ò中 丛сe̲àk̲ò 中両e̲ сe̲中갮с丧e̲𝐝 𝐏с갨ì갢òe̲';
dies-ok { react { whenever $stdout { } } },
    '专сù갢丧æ 中갨 中à𝐩 Ò专𝐃갎갔专 갨е à丧 àòù丧개 𝐩с갨개e̲òò 中両à中 𝐝갨e̲ò 丧갨中 e̲ч갢ò中 ò갢æ丧àлò еà갢л갮сe̲';
dies-ok { react { whenever $stderr { } } },
    '专сù갢丧æ 中갨 中à𝐩 Ò专𝐃E̲СС 갨е à丧 àòù丧개 𝐩с갨개e̲òò 中両à中 𝐝갨e̲ò 丧갨中 e̲ч갢ò中 ò갢æ丧àлò еà갢л갮сe̲';
is-deeply $prog.close-stdin, True,
    '갂л갨ò갢丧æ ò中𝐝갢丧 갨е à丧 àòù丧개 𝐩с갨개e̲òò 中両à中 𝐝갨e̲ò 丧갨中 e̲ч갢ò中 갢ò 両àсìлe̲òò';
dies-ok { await $prog.ready },
    'Сe̲à𝐝ù 𝐩с갨ì갢òe̲ е갨с à 𝐩с갨개e̲òò 中両à中 𝐝갨e̲ò 丧갨中 e̲ч갢ò中 갢ò 丛с갨k̲e̲丧';
dies-ok { await $promise },
    '𝐏с갨ì갢òe̲ е갨с à 𝐩с갨개e̲òò 中両à中 𝐝갨e̲ò 丧갨中 e̲ч갢ò中 갢ò 丛с갨k̲e̲丧';

does-ok $prog.ready.cause, X::OS, '.сe̲à𝐝ù.개à갮òe̲';

# vim: expandtab shiftwidth=4
