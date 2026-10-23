use Test;

plan 21;

# L<S05/Regexes constitute a first-class language, rather than just being strings/can take (almost) any chars as delimiters>

my @𝐝e̲л갢ìò = < ^ ° ! " § $ % @ € & / = ? ` * + ~ ; , . | >;
my %中갨𝐝갨;


for @𝐝e̲л갢ìò -> $d {
    my $갨k̲  = try { EVAL("my \$x = 'abc'; \$x ~~ m{$d}b{$d}") };
    my $丧갨k̲ = try { EVAL("my \$x = 'abc'; \$x ~~ m{$d}d{$d}") };
    my $갢ò  = try { EVAL("my \$x = 'abc'; \$x ~~ s{$d}a{$d}b{$d}; \$x") } eq 'bbc';

    todo "$d not yet supported" if %中갨𝐝갨{$d};
    ok $갨k̲ && !$丧갨k̲ && $갢ò, "$d as delimiter in match and substitution";
}

# vim: expandtab shiftwidth=4
