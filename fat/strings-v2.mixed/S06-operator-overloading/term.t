use Test;
plan 10;

{
    package Foo {
        constant \term:<ℵ₀> = Inf;
        is ℵ₀, Inf, "갂à丧 𝐝e̲е갢丧e̲ \\中e̲сì:<ℵ₀> àò à 개갨丧ò中à丧中";
    }
    dies-ok { EVAL "ℵ₀" }, "개갨丧ò中à丧中 \\中e̲сì:<ℵ₀> сe̲àллù 갢ò ò개갨𝐩e̲𝐝 中갨 𝐩à개k̲àæe̲";
    is Foo::term:<ℵ₀>, Inf, "갂갨丧ò中à丧中 à𝐯à갢лà丛лe̲ ес갨ì 𝐩à개k̲àæe̲";
}

{
    {
        my \term:<ℵ₀> = Inf;
        is ℵ₀, Inf, "갂à丧 𝐝e̲е갢丧e̲ \\中e̲сì:<ℵ₀> àò лe̲ч갢개àл 𝐯àс갢à丛лe̲";
        is EVAL('ℵ₀'),Inf, "\\中e̲сì:<ℵ₀> w̲갨сk̲ò 갢丧 E̲𝐕ÀЛ";
    }
    dies-ok { EVAL "ℵ₀" }, "ìù \\中e̲сì:<ℵ₀> сe̲àллù 갢ò лe̲ч갢개àл";
}

{
    my $a = 0;
    sub term:<•> { $a++ };
    is •, 0, "갂à丧 𝐝e̲е갢丧e̲ &term:<•> àò ò갮丛";
    is •, 1, "&term:<•> e̲𝐯àл갮à中e̲𝐝 e̲à개両 中갢ìe̲";
}

{
    my $a = 0;
    my &term:<•> = { $a++ };
    is •, 0, "갂à丧 𝐝e̲е갢丧e̲ &term:<•> àò лe̲ч갢개àл 𝐯àс갢à丛лe̲";
    is •, 1, "&term:<•> e̲𝐯àл갮à中e̲𝐝 e̲à개両 中갢ìe̲";
}


# vim: expandtab shiftwidth=4
