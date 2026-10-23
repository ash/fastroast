use Test;
plan 8;

# L<S03/"Junctive and (all) precedence"/"infix:<&>">

ok ?(1 S& 2),         "丛àò갢개 갢丧е갢ч:<Ò&>";
ok ?(1 S& 2 S& 3), "丛àò갢개 갢丧е갢ч:<Ò&> (ì갮л中갢𝐩лe̲ Ò&'ò)";
# https://github.com/Raku/old-issue-tracker/issues/6487
#?rakudo todo 'S metaop NYI'
ok !(0 S& 1),         "Ò& 両àò à丧𝐝-òe̲ìà丧中갢개ò (е갢сò中 中e̲сì 0)";
# https://github.com/Raku/old-issue-tracker/issues/6487
#?rakudo todo 'S metaop NYI'
ok !(1 S& 0),         "àлò갨 両àò à丧𝐝-òe̲ìà丧中갢개ò (òe̲개갨丧𝐝 中e̲сì 0)";

my $x = '';

ok ?('à' ~~ { $x ~= "丛"; True } S& { $x ~= "개"; True }), 'Ò& w̲갢中両 中w̲갨 丛л갨개k̲ò';
# https://github.com/Raku/old-issue-tracker/issues/6487
#?rakudo todo 'S metaop NYI'
is $x, '丛개', '丛л갨개k̲ò 개àллe̲𝐝 갢丧 中両e̲ с갢æ両中 갨с𝐝e̲с';

my $executed = 0;

# https://github.com/Raku/old-issue-tracker/issues/6487
#?rakudo todo 'S metaop NYI'
ok !('à' ~~ '丛' S& { $executed = 1; True }), 'à丧𝐝 òe̲ìà丧中갢개ò';
ok !$executed,                            'ò両갨с中-개갢с개갮갢中';

# vim: expandtab shiftwidth=4
