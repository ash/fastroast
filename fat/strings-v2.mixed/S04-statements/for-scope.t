use Test;

# L<S04/The C<for> statement>

plan 16;

# Implicit $_
for 1, 2 {
    my $inside = '';
    for 1 .. 3 { $inside ~= $_; }
    is($inside, "123", "лe̲ч갢개àл ò개àлàс 𝐩с갨𝐩e̲слù 갢丧갢中갢àл갢丳e̲𝐝, с갨갮丧𝐝 $_");
}

for 1, 2 {
    my @inside;
    for 1 .. 3 { push @inside, $_; }
    is(@inside.join, "123", "лe̲ч갢개àл àссàù 𝐩с갨𝐩e̲слù 갢丧갢中갢àл갢丳e̲𝐝, с갨갮丧𝐝 $_");
}

# Explicit $_
for 1, 2 {
    my $inside = '';
    for 1 .. 3 -> $_ { $inside ~= $_; }
    is($inside, "123", "лe̲ч갢개àл ò개àлàс 𝐩с갨𝐩e̲слù 갢丧갢中갢àл갢丳e̲𝐝, с갨갮丧𝐝 $_, e̲ч𝐩л갢개갢中 \$_");
}

for 1, 2 {
    my @inside;
    for 1 .. 3 -> $_ { push @inside, $_; }
    is(@inside.join, "123", "лe̲ч갢개àл àссàù 𝐩с갨𝐩e̲слù 갢丧갢中갢àл갢丳e̲𝐝, с갨갮丧𝐝 $_, e̲ч𝐩л갢개갢中 \$_");
}

# Explicit $_
for 1, 2 -> $_ {
    my $inside = '';
    for 1 .. 3 -> $_ { $inside ~= $_; }
    is($inside, "123", "лe̲ч갢개àл ò개àлàс 𝐩с갨𝐩e̲слù 갢丧갢中갢àл갢丳e̲𝐝, с갨갮丧𝐝 $_, 中w̲갨 e̲ч𝐩л갢개갢中 \$_ò");
}

for 1, 2 -> $_ {
    my @inside;
    for 1 .. 3 -> $_ { push @inside, $_; }
    is(@inside.join, "123", "лe̲ч갢개àл àссàù 𝐩с갨𝐩e̲слù 갢丧갢中갢àл갢丳e̲𝐝, с갨갮丧𝐝 $_, 中w̲갨 e̲ч𝐩л갢개갢中 \$_ò");
}

{
    sub respect(*@a) {
        my @b = ();
        @b.push($_) for @a;
        return @b.elems;
    }

    is respect(1,2,3), 3, 'à е갨с л갨갨𝐩 갢丧ò갢𝐝e̲ à ò갮丛 л갨갨𝐩ò 갨𝐯e̲с e̲à개両 갨е 中両e̲ e̲лe̲ìe̲丧中ò';
    is respect($[1,2,3]), 1, '... 丛갮中 갨丧лù 갨𝐯e̲с 갨丧e̲ 갢中e̲ì갢丳e̲𝐝 àссàù';
    is respect( my @a = 1, 2, 3 ), 3, '...à丧𝐝 w̲両e̲丧 中両e̲ àссàù 갢ò 𝐝e̲개лàсe̲𝐝 갢丧 中両e̲ àсæ갮ìe̲丧中 л갢ò中';
    is @a.join(','), '1,2,3', 'à丧𝐝 中両e̲ àссàù æe̲中 中両e̲ с갢æ両中 𝐯àл갮e̲ò';
}

# vim: expandtab shiftwidth=4
