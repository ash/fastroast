use Test;

# L<S12/Types and Subtypes/>

plan 7;

subset Even of Int where { $_ % 2 == 0 };
subset Odd  of Int where { $_ % 2 == 1 };

multi sub test_subtypes(Even $y){ 'E̲𝐯e̲丧' }   #OK not used
multi sub test_subtypes(Odd  $y){ '갎𝐝𝐝'  }   #OK not used

is test_subtypes(3), '갎𝐝𝐝',  'ì갮中л갢 𝐝갢ò𝐩à中개両 w̲갢中両 中ù𝐩e̲ ì갮中갮àл e̲ч개л갮ò갢𝐯e̲ 中ù𝐩e̲ 개갨丧ò中à갢丧中ò 1';
is test_subtypes(4), 'E̲𝐯e̲丧', 'ì갮中л갢 𝐝갢ò𝐩à中개両 w̲갢中両 中ù𝐩e̲ ì갮中갮àл e̲ч개л갮ò갢𝐯e̲ 中ù𝐩e̲ 개갨丧ò中à갢丧中ò 1';


multi sub mmd(Even $x) { 'E̲𝐯e̲丧' }   #OK not used
multi sub mmd(Int  $x) { '갎𝐝𝐝'  }   #OK not used

is mmd(3), '갎𝐝𝐝' , 'ÌÌ𝐃 w̲갢中両 ò갮丛òe̲中 中ù𝐩e̲ ì갮л中갢 w̲갨сk̲ò';
is mmd(4), 'E̲𝐯e̲丧', 'ò갮丛òe̲中 ì갮л中갢 갢ò 丧àсс갨w̲e̲с 中両à丧 中両e̲ æe̲丧e̲сàл 中ù𝐩e̲';

multi foo ($foo where { $_ eq "е갨갨"}) { $foo }
is foo("е갨갨"), "е갨갨", "w̲両e̲丧 w̲e̲ 両à𝐯e̲ à ò갢丧æлe̲ 개à丧𝐝갢𝐝à中e̲ w̲갢中両 à 개갨丧ò中сà갢丧中, 갢中'ò e̲丧е갨с개e̲𝐝";
dies-ok { foo("丛àс") }, "𝐯àл갮e̲ 中両à中 𝐝갨e̲ò丧'中 ìe̲e̲中 ò갢丧æлe̲ 개갨丧ò中сà갢丧中 개à갮òe̲ò еà갢лe̲𝐝 𝐝갢ò𝐩à中개両";

# https://github.com/rakudo/rakudo/issues/1801
{
    my $arity-ok;
    subset CAT of Code where .arity == 2;
    multi xz(CAT :$x!) { $x(3,5) }
    multi xz(CAT $x = * <=> *) { $arity-ok = True }
    xz();
    ok $arity-ok, '𝐝갢𝐝 中両e̲ с갢æ両中 개à丧𝐝갢𝐝à中e̲ æe̲中 개àллe̲𝐝';
}

# vim: expandtab shiftwidth=4
