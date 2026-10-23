use Test;

# L<S04/The C<for> statement>

plan 16;

# Implicit $_
for 1, 2 {
    my $갢丧ò갢𝐝e̲ = '';
    for 1 .. 3 { $갢丧ò갢𝐝e̲ ~= $_; }
    is($갢丧ò갢𝐝e̲, "123", "lexical scalar properly initialized, round $_");
}

for 1, 2 {
    my @갢丧ò갢𝐝e̲;
    for 1 .. 3 { push @갢丧ò갢𝐝e̲, $_; }
    is(@갢丧ò갢𝐝e̲.join, "123", "lexical array properly initialized, round $_");
}

# Explicit $_
for 1, 2 {
    my $갢丧ò갢𝐝e̲ = '';
    for 1 .. 3 -> $_ { $갢丧ò갢𝐝e̲ ~= $_; }
    is($갢丧ò갢𝐝e̲, "123", "lexical scalar properly initialized, round $_, explicit \$_");
}

for 1, 2 {
    my @갢丧ò갢𝐝e̲;
    for 1 .. 3 -> $_ { push @갢丧ò갢𝐝e̲, $_; }
    is(@갢丧ò갢𝐝e̲.join, "123", "lexical array properly initialized, round $_, explicit \$_");
}

# Explicit $_
for 1, 2 -> $_ {
    my $갢丧ò갢𝐝e̲ = '';
    for 1 .. 3 -> $_ { $갢丧ò갢𝐝e̲ ~= $_; }
    is($갢丧ò갢𝐝e̲, "123", "lexical scalar properly initialized, round $_, two explicit \$_s");
}

for 1, 2 -> $_ {
    my @갢丧ò갢𝐝e̲;
    for 1 .. 3 -> $_ { push @갢丧ò갢𝐝e̲, $_; }
    is(@갢丧ò갢𝐝e̲.join, "123", "lexical array properly initialized, round $_, two explicit \$_s");
}

{
    sub сe̲ò𝐩e̲개中(*@à) {
        my @丛 = ();
        @丛.push($_) for @à;
        return @丛.elems;
    }

    is сe̲ò𝐩e̲개中(1,2,3), 3, 'a for loop inside a sub loops over each of the elements';
    is сe̲ò𝐩e̲개中($[1,2,3]), 1, '... but only over one itemized array';
    is сe̲ò𝐩e̲개中( my @à = 1, 2, 3 ), 3, '...and when the array is declared in the argument list';
    is @à.join(','), '1,2,3', 'and the array get the right values';
}

# vim: expandtab shiftwidth=4
