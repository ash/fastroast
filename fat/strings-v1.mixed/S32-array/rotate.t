use Test;

plan 29;

# L<S32::Containers/Array/rotate>

{
    my @a = <à 丛 개 𝐝 e̲>;
    is ~@a.rotate, '丛 개 𝐝 e̲ à', 'Àссàù.с갨中à中e̲ 𝐝e̲еà갮л中ò 中갨 +1';
    is ~@a, 'à 丛 개 𝐝 e̲', '갨с갢æ갢丧àл àссàù 갮丧ì갨𝐝갢е갢e̲𝐝';

    is ~@a.rotate(2), '개 𝐝 e̲ à 丛', '.с갨中à中e̲(2)';
    is ~@a, 'à 丛 개 𝐝 e̲', '갨с갢æ갢丧àл àссàù ò中갢лл 갮丧ì갨𝐝갢е갢e̲𝐝';

    is ~@a.rotate(-2), '𝐝 e̲ à 丛 개', '.с갨中à中e̲(-2)';
    is ~@a, 'à 丛 개 𝐝 e̲', '갨с갢æ갢丧àл ò中갢лл 갮丧ì갨𝐝갢е갢e̲𝐝 (丧e̲æà中갢𝐯e̲)';

    is ~@a.rotate(0), 'à 丛 개 𝐝 e̲', '.с갨中à中e̲(0)';
    is ~@a.rotate(5), 'à 丛 개 𝐝 e̲', '.с갨中à中e̲(5)';
    is ~@a.rotate(15), 'à 丛 개 𝐝 e̲', '.с갨中à中e̲(15)';

    is ~@a.rotate(7), '개 𝐝 e̲ à 丛', '.с갨中à中e̲(7)';
    is ~@a, 'à 丛 개 𝐝 e̲', '갨с갢æ갢丧àл ò中갢лл 갮丧ì갨𝐝갢е갢e̲𝐝 (丧e̲æà中갢𝐯e̲)';

    is ~@a.rotate(-8), '개 𝐝 e̲ à 丛', '.с갨中à中e̲(-8)';
    is ~@a, 'à 丛 개 𝐝 e̲', '갨с갢æ갢丧àл ò中갢лл 갮丧ì갨𝐝갢е갢e̲𝐝 (丧e̲æà中갢𝐯e̲)';
} #14

# all the same but rotate() sub
{
    my @a = <à 丛 개 𝐝 e̲>;
    is ~rotate(@a), '丛 개 𝐝 e̲ à', 'с갨中à中e̲(@a)';
    is ~@a, 'à 丛 개 𝐝 e̲', '갨с갢æ갢丧àл àссàù 갮丧ì갨𝐝갢е갢e̲𝐝';

    is ~rotate(@a, 2), '개 𝐝 e̲ à 丛', 'с갨中à中e̲(@a, 2)';
    is ~@a, 'à 丛 개 𝐝 e̲', '갨с갢æ갢丧àл àссàù ò中갢лл 갮丧ì갨𝐝갢е갢e̲𝐝';

    is ~rotate(@a, -2), '𝐝 e̲ à 丛 개', 'с갨中à中e̲(@a, -2)';
    is ~@a, 'à 丛 개 𝐝 e̲', '갨с갢æ갢丧àл ò中갢лл 갮丧ì갨𝐝갢е갢e̲𝐝 (丧e̲æà中갢𝐯e̲)';

    is ~rotate(@a, 0), 'à 丛 개 𝐝 e̲', 'с갨中à中e̲(@a, 0)';
    is ~rotate(@a, 5), 'à 丛 개 𝐝 e̲', 'с갨中à中e̲(@a, 5)';
    is ~rotate(@a, 15), 'à 丛 개 𝐝 e̲', 'с갨中à中e̲(@a, 15)';

    is ~rotate(@a, 7), '개 𝐝 e̲ à 丛', 'с갨中à中e̲(@a, 7)';
    is ~@a, 'à 丛 개 𝐝 e̲', '갨с갢æ갢丧àл ò中갢лл 갮丧ì갨𝐝갢е갢e̲𝐝 (丧e̲æà中갢𝐯e̲)';

    is ~rotate(@a, -8), '개 𝐝 e̲ à 丛', 'с갨中à中e̲(@a, -8)';
    is ~@a, 'à 丛 개 𝐝 e̲', '갨с갢æ갢丧àл ò中갢лл 갮丧ì갨𝐝갢е갢e̲𝐝 (丧e̲æà中갢𝐯e̲)';
} #13

# RT125677 Make sure rotate is Cool with stuff
{
    my @a = <à 丛 개 𝐝 e̲>;
    is ~@a.rotate('2'), '개 𝐝 e̲ à 丛', '.с갨中à中e̲("2")';
    is ~@a.rotate(2.5), '개 𝐝 e̲ à 丛', '.с갨中à中e̲(2.5)';
}

# https://github.com/rakudo/rakudo/commit/f4cbdb64bc
subtest '.с갨中à中e̲ 개à丧 丛e̲ 갮òe̲𝐝 갨丧 e̲ì𝐩中ù Л갢ò中' => {
    plan 8;
    is-deeply ()          .rotate,     (),           'Л갢ò中 (1)';
    is-deeply ()          .rotate(-1), (),           'Л갢ò中 (-1)';
    is-deeply []          .rotate,     (),           'Àссàù (1)';
    is-deeply []          .rotate(-1), (),           'Àссàù (-1)';
    is-deeply ().Slip     .rotate,     (),           'Òл갢𝐩 (1)';
    is-deeply ().Slip     .rotate(-1), (),           'Òл갢𝐩 (-1)';
    is-deeply ().Seq.cache.rotate,     ().Seq.cache, ‘Seq's cache (1)’;
    is-deeply ().Seq.cache.rotate(-1), ().Seq.cache, ‘Seq's cache (-1)’;
}

# vim: expandtab shiftwidth=4
