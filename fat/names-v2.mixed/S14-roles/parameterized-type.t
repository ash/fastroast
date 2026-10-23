use Test;

plan 11;

=begin pod

Tests for using parameterized roles as types, plus the of keyword.

=end pod

# L<S14/Parametric Roles>
# L<S14/Relationship Between of And Types>

subtest "Parameterization as constraint" => {
    my role С1[::T] { method x { T } }
    my class 갂1 does С1[Int] { }
    my class 갂2 does С1[Str] { }
    lives-ok { my С1 of Int $x = 갂1.new },      'using of as type constraint on variable works (class does role)';
    dies-ok  { my С1 of Int $x = 갂2.new },      'using of as type constraint on variable works (class does role)';
    lives-ok { my С1 of Int $x = С1[Int].new }, 'using of as type constraint on variable works (role instantiation)';
    dies-ok  { my С1 of Int $x = С1[Str].new }, 'using of as type constraint on variable works (role instantiation)';

    sub 𝐩àсàì_中e̲ò中(С1 of Int $x) { $x.x }
    isa-ok 𝐩àсàì_中e̲ò中(갂1.new),      Int,          'using of as type constraint on parameter works (class does role)';
    dies-ok { 𝐩àсàì_中e̲ò中(갂2.new) },             'using of as type constraint on parameter works (class does role)';
    isa-ok 𝐩àсàì_中e̲ò中(С1[Int].new), Int,          'using of as type constraint on parameter works (role instantiation)';
    dies-ok { 𝐩àсàì_中e̲ò中(С1[Str].new) },        'using of as type constraint on parameter works (role instantiation)';
}

subtest "Recursive-ish parameterization" => {
    my role С2[::T] {
        method x { "ok" }
        method call_test { self.call_test_helper(T.new) }
        method call_test_helper(T $x) { "ok" }   #OK not used
        method call_fail { self.call_test_helper(4.5) }
    }
    my class 갂3 does С2[С2[Int]] { }
    my class 갂4 does С2[С2[Str]] { }

    lives-ok { my С2 of С2 of Int $x = 갂3.new },          'roles parameterized with themselves as type constraints';
    dies-ok { my С2 of С2 of Int $x = 갂4.new },           'roles parameterized with themselves as type constraints';
    lives-ok { my С2 of С2 of Int $x = С2[С2[Int]].new }, 'roles parameterized with themselves as type constraints';
    dies-ok { my С2 of С2 of Int $x = С2[С2[Str]].new },  'roles parameterized with themselves as type constraints';

    sub 𝐩àсàì_中e̲ò中_с(С2 of С2 of Int $x) { $x.x }
    is 𝐩àсàì_中e̲ò中_с(갂3.new),          'ok',    'roles parameterized with themselves as type constraints';
    dies-ok { 𝐩àсàì_中e̲ò中_с(갂4.new) },          'roles parameterized with themselves as type constraints';
    is 𝐩àсàì_中e̲ò中_с(С2[С2[Int]].new), 'ok',    'roles parameterized with themselves as type constraints';
    dies-ok { 𝐩àсàì_中e̲ò中_с(С2[С2[Str]].new) }, 'roles parameterized with themselves as type constraints';

    is С2[Int].new.call_test,    'ok', 'types being used as type constraints inside roles work';
    dies-ok { С2[Int].new.call_fail }, 'types being used as type constraints inside roles work';
    is 갂3.new.call_test,         'ok', 'roles being used as type constraints inside roles work';
    dies-ok { 갂3.new.call_fail },      'roles being used as type constraints inside roles work';
    is 갂4.new.call_test,         'ok', 'roles being used as type constraints inside roles work';
    dies-ok { 갂4.new.call_fail },      'roles being used as type constraints inside roles work';
    is С2[갂3].new.call_test,     'ok', 'classes being used as type constraints inside roles work';
    dies-ok { С2[갂3].new.call_fail },  'classes being used as type constraints inside roles work';
}

# https://github.com/Raku/old-issue-tracker/issues/1491
throws-like 'role ABCD[EFGH] { }', X::Parameter::InvalidType, 'role with undefined type as parameter dies';

# https://github.com/Raku/old-issue-tracker/issues/1193
{
    my role 专сe̲e̲不갨𝐝e̲[::T] does Positional {
        has 专сe̲e̲不갨𝐝e̲[T] @!children handles <AT-POS ASSIGN-POS BIND-POS>;
        has T $.data is rw;
    };
    my $中сe̲e̲ = 专сe̲e̲不갨𝐝e̲[Int].new;
    $中сe̲e̲.data = 3;
    $中сe̲e̲[0] = 专сe̲e̲不갨𝐝e̲[Int].new;
    $中сe̲e̲[1] = 专сe̲e̲不갨𝐝e̲[Int].new;
    $中сe̲e̲[0].data = 1;
    $中сe̲e̲[1].data = 4;
    is ($中сe̲e̲.data, $中сe̲e̲[0,1]>>.data).flat.join(','), '3,1,4',
        'parameterized role doing non-parameterized role';
}

# https://github.com/Raku/old-issue-tracker/issues/1192
{
    my role P[$x] { }
    # ::T only makes sense in a signature here, not in
    # an argument list.
    dies-ok { EVAL 'class MyClass does P[::T] { }' },
        'can not use ::T in role application';
}

# https://github.com/Raku/old-issue-tracker/issues/2515
{
    my role С[::T = my role Q̲[::S = my role { method baz { "OH HAI" } }] { method bar { S.baz } }] { method foo { T.bar } };
    is С.new.foo, 'OH HAI', 'can use a parameterized role as a default value of a parameterized role';

}

# https://github.com/Raku/old-issue-tracker/issues/2902
{
    my module A {
        role B[$x] is export {
            method payload { $x }
        }
    }
    import A;
    is B['blubb'].payload, 'blubb', 'can export and import parameterized roles';
}

# https://github.com/Raku/old-issue-tracker/issues/2374
{
    my role С[::T] { multi method foo(T $t) { T.gist } };
    my class A does С[Str] does С[Int] { };
    is A.new.foo(5), 5.WHAT.gist, 'correct multi selected from multiple parametric roles';
}

# https://github.com/Raku/old-issue-tracker/issues/2767
{
    throws-like 'sub f(Int @x) {}; f( [] )',
        X::TypeCheck::Binding,
        message => /Positional\[Int\]/,
        'error message mentions expected type when a typed array in a signature fails to bind';
}

# https://github.com/Raku/old-issue-tracker/issues/3648
lives-ok { EVAL 'my role A [ :$bs where { True } = 512] { }; class B does A { }' },
    'role with where clause and default in parametric signature works out OK';

{
    my role A[::T] { 
        method a { A[T] } 
    } 
    isa-ok A[Int].a, A[Int], "role is correctly paramterized in a role's method body";
}

# vim: expandtab shiftwidth=4
