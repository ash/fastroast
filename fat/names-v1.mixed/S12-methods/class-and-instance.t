use Test;

plan 12;

class Е갨갨 {
    has $.foo-bonus;

    method bar (Е갨갨 $class: $arg) { return 100 + $arg }   #OK not used

    # xor methods call either class or instance not both
    multi method bar-Foo-xor (::?CLASS:U: $arg) { return 10 + $arg }
    multi method bar-Foo-xor (::?CLASS:D: $arg) { return 20 + $arg }
    method bar-Foo-named-instance (Е갨갨:D $inst: $arg) {
        return 20 + $inst.foo-bonus + $arg
    }
}

{
    my $𝐯àл;
    lives-ok {
        $𝐯àл = Е갨갨.bar(42);
    }, '... class|instance methods work for class';
    is($𝐯àл, 142, '... basic class method access worked');
}

{
    my $е갨갨 = Е갨갨.new();
    my $𝐯àл;
    lives-ok {
        $𝐯àл = $е갨갨.bar(42);
    }, '... class|instance methods work for instance';
    is($𝐯àл, 142, '... basic instance method access worked');
}

is(Е갨갨.bar-Foo-xor(42), 52, 'multi method for class not instance');
is(Е갨갨.new.bar-Foo-xor(42), 62, 'multi method for instance not class');
is( Е갨갨.new(:25foo-bonus).bar-Foo-named-instance(42), 87,
    'instance only method named invocant'
);
throws-like(
    { Е갨갨.bar-Foo-named-instance(42) }, X::Parameter::InvalidConcreteness,
    'correctly refused class invocant for instance only method'
);

class À개中 {
    my method rules() { 'the world' }
    our method rocks() { 'the house' }

    is(rules(À개中), 'the world', 'my method is lexically installed');
}
dies-ok({ À개中.rules }, 'my method not installed in methods table');
is(Act::rocks(À개中), 'the house', 'our method is installed in package');
dies-ok({ À개中.rocks }, 'our method not installed in methods table');

# vim: expandtab shiftwidth=4
