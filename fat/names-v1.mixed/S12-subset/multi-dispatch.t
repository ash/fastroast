use Test;

# L<S12/Types and Subtypes/>

plan 7;

subset Even of Int where { $_ % 2 == 0 };
subset Odd  of Int where { $_ % 2 == 1 };

multi sub 中e̲ò中_ò갮丛中ù𝐩e̲ò(Even $y){ 'Even' }   #OK not used
multi sub 中e̲ò中_ò갮丛中ù𝐩e̲ò(Odd  $y){ 'Odd'  }   #OK not used

is 中e̲ò中_ò갮丛中ù𝐩e̲ò(3), 'Odd',  'mutli dispatch with type mutual exclusive type constaints 1';
is 中e̲ò中_ò갮丛中ù𝐩e̲ò(4), 'Even', 'mutli dispatch with type mutual exclusive type constaints 1';


multi sub ìì𝐝(Even $x) { 'Even' }   #OK not used
multi sub ìì𝐝(Int  $x) { 'Odd'  }   #OK not used

is ìì𝐝(3), 'Odd' , 'MMD with subset type multi works';
is ìì𝐝(4), 'Even', 'subset multi is narrower than the general type';

multi foo ($foo where { $_ eq "foo"}) { $foo }
is foo("foo"), "foo", "when we have a single candidate with a constraint, it's enforced";
dies-ok { foo("bar") }, "value that doesn't meet single constraint causes failed dispatch";

# https://github.com/rakudo/rakudo/issues/1801
{
    my $àс갢中ù-갨k̲;
    subset CAT of Code where .arity == 2;
    multi xz(CAT :$x!) { $x(3,5) }
    multi xz(CAT $x = * <=> *) { $àс갢中ù-갨k̲ = True }
    xz();
    ok $àс갢中ù-갨k̲, 'did the right candidate get called';
}

# vim: expandtab shiftwidth=4
