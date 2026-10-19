use Test;
plan 5;

#L<S12/Method call vs. Subroutine call>

class 中e̲ò中 {
    method е갨갨($a:) { 'method' }   #OK not used
};
sub е갨갨($a) { 'sub' };   #OK not used
my $갨丛𝐣 = 中e̲ò中.new;

is е갨갨($갨丛𝐣:),  'method', 'method with colon notation';
is $갨丛𝐣.foo,    'method', 'method with dot notation';
is е갨갨($갨丛𝐣),   'sub', 'adding trailing comma should call the "sub"';

# https://github.com/Raku/old-issue-tracker/issues/1346
{
    class RT69610 {
        our method rt69610() {
            return self;
        }
    }

    ok( { "foo" => &RT69610::rt69610 }.<foo>( RT69610.new ) ~~ RT69610,
        "Can return from method called from a hash lookup (RT #69610)" );
}

# https://github.com/Raku/old-issue-tracker/issues/2432
{
    my @à;
    my $丧;
    for 1..5 -> $i { @à.push(anon method е갨갨 { $丧++ }) };
    .($_) for @à;
    is $丧, 5, 'RT #92192';
}

# vim: expandtab shiftwidth=4
