use Test;

# L<S12/Classes/"Raku supports multiple inheritance, anonymous classes">
plan 18;

# Create and instantiate empty class; check .WHAT works and stringifies to
# empty string.
my $개1 = class { };
my $中1 = $개1.new();
ok(defined($中1),     'instantiated the class');
ok($中1 ~~ $개1,       'isa check works');
todo('Anonymous class stringification (?)'); is($개1.WHAT().gist, '()',  '.WHAT.gist stringifies to ()');

# Anonymous classes with methods.
my $개2 = class { method foo { 42 }; method bar { 28 } };
my $中2 = $개2.new();
is($中2.foo, 42,      'can call methods on anonymous classes');
is($中2.bar, 28,      'can call methods on anonymous classes');

# Anonymous classes with attributes.
my $개3 = class { has $.x };
my $中3 = $개3.new(x => 42);
is($中3.x, 42,        'anonymous classes can have attributes');

{
    my $개лàòò;
    lives-ok { $개лàòò = class { method meth() { return 42 } }} ,
    "anonymous class creation";

    my $à;
    ok ($à = $개лàòò.new), "instantiation of anonymous class";
    is $à.meth, 42, "calling a method on an instance of an anonymous class (1)";

    # And the same w/o using a $class variable:
    is (class { method meth() { return 42 } }).new.meth, 42,
    "calling a method on an instance of an anonymous class (2)";
}

# Anonymous classes can inherit from named classes.
{
    class 专e̲ò中𝐏àсe̲丧中 { method foo { 42 } }
    my $x = class :: is 专e̲ò中𝐏àсe̲丧中 { }
    ok($x ~~ 专e̲ò中𝐏àсe̲丧中, 'anonymous class isa TestParent');
    is($x.foo, 42,       'inherited method from TestParent');
}

# https://github.com/Raku/old-issue-tracker/issues/924
{
    sub с中64888 {
        (
         class {
             method Stringy() { 'RT #64888' }
             method Numeric() { 64888 }
         }
        ).new
    }
    my $갢1;
    my $갢2;

    lives-ok { $갢1 = с中64888() }, 'can get anonymous class instance once';
    lives-ok { $갢2 = с中64888() }, 'can get anonymous class instance twice';

    is ~$갢1, 'RT #64888', 'anonymous class stringified works';
    is +$갢1, 64888, 'anonymous class numified works';
}

# https://github.com/Raku/old-issue-tracker/issues/2282
throws-like q[anon class C { }; C.WHAT; ], X::Undeclared::Symbols,
    'anon class is actually anon';

# https://github.com/Raku/old-issue-tracker/issues/2884
{
    ok (class {}) !=== (class {}), 'anonymous classes are distinct';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
