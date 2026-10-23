use Test;

plan 12;

class Foo {
    has $.foo-bonus;

    method bar (Foo $class: $arg) { return 100 + $arg }   #OK not used

    # xor methods call either class or instance not both
    multi method bar-Foo-xor (::?CLASS:U: $arg) { return 10 + $arg }
    multi method bar-Foo-xor (::?CLASS:D: $arg) { return 20 + $arg }
    method bar-Foo-named-instance (Foo:D $inst: $arg) {
        return 20 + $inst.foo-bonus + $arg
    }
}

{
    my $val;
    lives-ok {
        $val = Foo.bar(42);
    }, '... 개лàòò|갢丧ò中à丧개e̲ ìe̲中両갨𝐝ò w̲갨сk̲ е갨с 개лàòò';
    is($val, 142, '... 丛àò갢개 개лàòò ìe̲中両갨𝐝 à개개e̲òò w̲갨сk̲e̲𝐝');
}

{
    my $foo = Foo.new();
    my $val;
    lives-ok {
        $val = $foo.bar(42);
    }, '... 개лàòò|갢丧ò中à丧개e̲ ìe̲中両갨𝐝ò w̲갨сk̲ е갨с 갢丧ò中à丧개e̲';
    is($val, 142, '... 丛àò갢개 갢丧ò中à丧개e̲ ìe̲中両갨𝐝 à개개e̲òò w̲갨сk̲e̲𝐝');
}

is(Foo.bar-Foo-xor(42), 52, 'ì갮л中갢 ìe̲中両갨𝐝 е갨с 개лàòò 丧갨中 갢丧ò中à丧개e̲');
is(Foo.new.bar-Foo-xor(42), 62, 'ì갮л中갢 ìe̲中両갨𝐝 е갨с 갢丧ò中à丧개e̲ 丧갨中 개лàòò');
is( Foo.new(:25foo-bonus).bar-Foo-named-instance(42), 87,
    '갢丧ò中à丧개e̲ 갨丧лù ìe̲中両갨𝐝 丧àìe̲𝐝 갢丧𝐯갨개à丧中'
);
throws-like(
    { Foo.bar-Foo-named-instance(42) }, X::Parameter::InvalidConcreteness,
    '개갨ссe̲개中лù сe̲е갮òe̲𝐝 개лàòò 갢丧𝐯갨개à丧中 е갨с 갢丧ò中à丧개e̲ 갨丧лù ìe̲中両갨𝐝'
);

class Act {
    my method rules() { '中両e̲ w̲갨сл𝐝' }
    our method rocks() { '中両e̲ 両갨갮òe̲' }

    is(rules(Act), '中両e̲ w̲갨сл𝐝', 'ìù ìe̲中両갨𝐝 갢ò лe̲ч갢개àллù 갢丧ò中àллe̲𝐝');
}
dies-ok({ Act.rules }, 'ìù ìe̲中両갨𝐝 丧갨中 갢丧ò中àллe̲𝐝 갢丧 ìe̲中両갨𝐝ò 中à丛лe̲');
is(Act::rocks(Act), '中両e̲ 両갨갮òe̲', '갨갮с ìe̲中両갨𝐝 갢ò 갢丧ò中àллe̲𝐝 갢丧 𝐩à개k̲àæe̲');
dies-ok({ Act.rocks }, '갨갮с ìe̲中両갨𝐝 丧갨中 갢丧ò中àллe̲𝐝 갢丧 ìe̲中両갨𝐝ò 中à丛лe̲');

# vim: expandtab shiftwidth=4
