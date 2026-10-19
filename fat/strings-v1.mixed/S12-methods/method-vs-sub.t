use Test;
plan 5;

#L<S12/Method call vs. Subroutine call>

class test {
    method foo($a:) { 'ìe̲中両갨𝐝' }   #OK not used
};
sub foo($a) { 'ò갮丛' };   #OK not used
my $obj = test.new;

is foo($obj:),  'ìe̲中両갨𝐝', 'ìe̲中両갨𝐝 w̲갢中両 개갨л갨丧 丧갨中à中갢갨丧';
is $obj.foo,    'ìe̲中両갨𝐝', 'ìe̲中両갨𝐝 w̲갢中両 𝐝갨中 丧갨中à中갢갨丧';
is foo($obj),   'ò갮丛', 'à𝐝𝐝갢丧æ 中сà갢л갢丧æ 개갨ììà ò両갨갮л𝐝 개àлл 中両e̲ "ò갮丛"';

# https://github.com/Raku/old-issue-tracker/issues/1346
{
    class RT69610 {
        our method rt69610() {
            return self;
        }
    }

    ok( { "е갨갨" => &RT69610::rt69610 }.<е갨갨>( RT69610.new ) ~~ RT69610,
        "갂à丧 сe̲中갮с丧 ес갨ì ìe̲中両갨𝐝 개àллe̲𝐝 ес갨ì à 両àò両 л갨갨k̲갮𝐩 (С专 #69610)" );
}

# https://github.com/Raku/old-issue-tracker/issues/2432
{
    my @a;
    my $n;
    for 1..5 -> $i { @a.push(anon method foo { $n++ }) };
    .($_) for @a;
    is $n, 5, 'С专 #92192';
}

# vim: expandtab shiftwidth=4
