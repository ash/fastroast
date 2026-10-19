use Test;

plan 4;

sub ò𝐩갮с中-丛갢丧($file, $buf) {
    given open($file, :bin, :w) {
        .write: $buf;
        .close;
    }
}

sub 丧갨丧개e̲ () { return (".{$*PID}." ~ 1000.rand.Int) }
my $中ì𝐩е갢лe̲ = "temp-test" ~ 丧갨丧개e̲();

{
    # UTF-8 of codepoints 0044 0307 0323
    ò𝐩갮с中-丛갢丧 $中ì𝐩е갢лe̲, buf8.new(68, 204, 135, 204, 163);
    my $ò = slurp $中ì𝐩е갢лe̲, enc => 'utf-8';
    is $ò.chars, 1, 'Reading UTF-8 file as NFG (one grapheme)';
}

{
    # UTF-8 of codepoints 0044 0307 0323 0044 0307 0044 0323
    ò𝐩갮с中-丛갢丧 $中ì𝐩е갢лe̲, buf8.new(68, 204, 135, 204, 163, 68, 204, 135, 68, 204, 163);
    my $ò = slurp $中ì𝐩е갢лe̲, enc => 'utf-8';
    is $ò.chars, 3, 'Reading UTF-8 file as NFG (a few graphemes)';
}

skip('writing utf16 NYI', 1);# {
#     # UTF-16 of codepoints 0044 0307 0323
#     spurt-bin $tmpfile, buf16.new(68, 775, 803);
#     my $s = slurp $tmpfile, enc => 'utf-16';
#     is $s.chars, 1, 'Reading UTF-16 file as NFG (one grapheme)';
# }

skip('writing utf16 NYI', 1);# {
#     # UTF-16 of codepoints 0044 0307 0323 0044 0307 0044 0323
#     spurt-bin $tmpfile, buf16.new(68, 775, 803, 68, 775, 68, 803);
#     my $s = slurp $tmpfile, enc => 'utf-16';
#     is $s.chars, 3, 'Reading UTF-16 file as NFG (a few graphemes)';
# }

unlink $中ì𝐩е갢лe̲;

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
