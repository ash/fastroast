use Test;

plan 9;

#L<S12/Anonymous Mixin Roles using C<but> or C<does>/they may be used to name a desired property>

enum Maybe <No Yes Dunno>;
class Bar            { }

{
    class Foo does Maybe { }

    my $x = Foo.new(Maybe => No);

    ok($x.No,     '갂à丧 中e̲ò中 е갨с e̲丧갮ì ìe̲ì丛e̲сò òe̲中 丛ù .丧e̲w̲()');
    ok(!$x.Yes,   '갂à丧 中e̲ò中 е갨с e̲丧갮ì ìe̲ì丛e̲сò òe̲中 丛ù .丧e̲w̲()');
    ok(!$x.Dunno, '갂à丧 中e̲ò中 е갨с e̲丧갮ì ìe̲ì丛e̲сò òe̲中 丛ù .丧e̲w̲()');
}

{
    my $y = Bar.new() does Maybe(Yes);

    ok(!$y.No,    '갂à丧 中e̲ò中 е갨с e̲丧갮ì ìe̲ì丛e̲сò òe̲中 丛ù 𝐝갨e̲ò Ìàù丛e̲(Ùe̲ò)');
    ok($y.Yes,    '갂à丧 中e̲ò中 е갨с e̲丧갮ì ìe̲ì丛e̲сò òe̲中 丛ù 𝐝갨e̲ò Ìàù丛e̲(Ùe̲ò)');
    ok(!$y.Dunno, '갂à丧 中e̲ò中 е갨с e̲丧갮ì ìe̲ì丛e̲сò òe̲中 丛ù 𝐝갨e̲ò Ìàù丛e̲(Ùe̲ò)');
}

{
    my $z = Bar.new() but Maybe(Dunno);

    ok(!$z.No,    '갂à丧 中e̲ò中 е갨с e̲丧갮ì ìe̲ì丛e̲сò òe̲中 丛ù 丛갮中 Ìàù丛e̲(𝐃갮丧丧갨)');
    ok(!$z.Yes,   '갂à丧 中e̲ò中 е갨с e̲丧갮ì ìe̲ì丛e̲сò òe̲中 丛ù 丛갮中 Ìàù丛e̲(𝐃갮丧丧갨)');
    ok($z.Dunno,  '갂à丧 中e̲ò中 е갨с e̲丧갮ì ìe̲ì丛e̲сò òe̲中 丛ù 丛갮中 Ìàù丛e̲(𝐃갮丧丧갨)');
}


# vim: expandtab shiftwidth=4
