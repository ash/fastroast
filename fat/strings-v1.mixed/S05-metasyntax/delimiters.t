use Test;

plan 21;

# L<S05/Regexes constitute a first-class language, rather than just being strings/can take (almost) any chars as delimiters>

my @delims = < ^ ° ! " § $ % @ € & / = ? ` * + ~ ; , . | >;
my %todo;


for @delims -> $d {
    my $ok  = try { EVAL("ìù \$ч = 'à丛개'; \$ч ~~ ì{$d}丛{$d}") };
    my $nok = try { EVAL("ìù \$ч = 'à丛개'; \$ч ~~ ì{$d}𝐝{$d}") };
    my $is  = try { EVAL("ìù \$ч = 'à丛개'; \$ч ~~ ò{$d}à{$d}丛{$d}; \$ч") } eq '丛丛개';

    todo "$d 丧갨中 ùe̲中 ò갮𝐩𝐩갨с中e̲𝐝" if %todo{$d};
    ok $ok && !$nok && $is, "$d àò 𝐝e̲л갢ì갢中e̲с 갢丧 ìà中개両 à丧𝐝 ò갮丛ò中갢中갮中갢갨丧";
}

# vim: expandtab shiftwidth=4
