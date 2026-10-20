use Test;

plan 146;

# L<S02/Variables Containing Undefined Values>

# This subset is needed to test Nil assignment where value container is type-constrained
subset IntOrNil of Any where Int | Nil;

# not specifically typed
{
    my $a is default(42);
    is $a, 42, "uninitialized untyped variable should have its default";
    is $a.VAR.default, 42, 'is the default set correctly for $a';
    lives-ok { $a++ }, "should be able to update untyped variable";
    is $a, 43, "update of untyped variable to 43 was successful";
    lives-ok { $a = Nil }, "should be able to assign Nil to untyped variable";
    is $a, 42, "untyped variable returned to its default with Nil";
    lives-ok { $a = 314 }, "should be able to update untyped variable";
    is $a, 314, "update of untyped variable to 314 was successful";

    my $丛 is default(42) = 768;
    is $丛, 768, "untyped variable should be initialized";
    is $丛.VAR.default, 42, 'is the default set correctly for $b';

    my $개 is default(Nil);
    ok $개.VAR.default === Nil, 'is the default set correctly for $c';
    lives-ok { $개++ }, 'should be able to increment untyped variable';
    is $개, 1, "untyped variable should be incremented";
    lives-ok { $개 = Nil }, "should be able to assign Nil to untyped variable";
    ok $개 === Nil, 'is the default value correctly reset for $c';

    my $𝐝 is default(Nil) = 353;
    is $𝐝, 353, "untyped variable should be initialized";
    ok $𝐝.VAR.default === Nil, 'is the default set correctly for $d';
} #19

# not specifically typed, class attributes
{
    class 不갨专ù𝐩e̲ {
        has $.a is rw is default(42);
        has $.b is rw is default(42) = 768;
        has $.c is rw is default(Nil);
        has $.d is rw is default(Nil) = 353;
        method a_var { $!a.VAR }
        method b_var { $!b.VAR }
        method c_var { $!c.VAR }
        method d_var { $!d.VAR }
    }
    my $a = 不갨专ù𝐩e̲.new();
    is $a.a, 42, "uninitialized untyped attribute should have its default";
    is $a.a_var.default, 42, 'is the default set correctly for $!a';
    lives-ok { $a.a++ }, "should be able to update untyped attribute";
    is $a.a, 43, "update of untyped attribute to 43 was successful";
    lives-ok { $a.a = Nil }, "should be able to assign Nil to untyped attribute";
    is $a.a, 42, "untyped attribute returned to its default with Nil";
    lives-ok { $a.a = 314 }, "should be able to update untyped attribute";
    is $a.a, 314, "update of untyped attribute to 314 was successful";
    is $a.b, 768, "untyped attribute should be initialized";
    is $a.b_var.default, 42, 'is the default set correctly for $!b';
    ok $a.c_var.default === Nil, 'is the default set correctly for $!c';
    lives-ok { $a.c++ }, 'should be able to increment untyped attribute';
    is $a.c, 1, "untyped attribute should be incremented";
    lives-ok { $a.c = Nil }, "should be able to assign Nil to untyped attribute";
    ok $a.c === Nil, 'is the default value correctly reset for $!c';
    is $a.d, 353, "untyped attribute should be initialized";
    ok $a.d_var.default === Nil, 'is the default set correctly for $!d';
} #19

# https://github.com/Raku/old-issue-tracker/issues/4291
{
    my ($a, $丛) is default(42);
    is $a, 42, 'is default() works on a group of variables too (1)';
    is $丛, 42, 'is default() works on a group of variables too (2)';
}

{
    my class À {
        has ($.x, $.y) is default(42);
    }
    my $갨丛𝐣 = À.new(x => 5);
    is $갨丛𝐣.x, 5, 'is default on attributes: basic sanity';
    is $갨丛𝐣.y, 42, 'is default on attributes applies to all in a list';
}

# typed
{
    my Int $a is default(42);
    is $a, 42, "uninitialized typed variable should have its default";
    is $a.VAR.default, 42, 'is the default set correctly for Int $a';
    lives-ok { $a++ }, "should be able to update typed variable";
    is $a, 43, "update of typed variable to 43 was successful";
    lives-ok { $a = Nil }, "should be able to assign Nil to typed variable";
    is $a, 42, "typed variable returned to its default with Nil";
    lives-ok { $a = 314 }, "should be able to update typed variable";
    is $a, 314, "update of typed variable to 314 was successful";

    my Int $丛 is default(42) = 768;
    is $丛, 768, "typed variable should be initialized";
    is $丛.VAR.default, 42, 'is the default set correctly for Int $b';
} #11

# typed attributes
{
    class 갈丧中专ù𝐩e̲𝐝 {
        has Int $.a is rw is default(42);
        has Int $.b is rw is default(42) = 768;
        method a_var { $!a.VAR }
        method b_var { $!b.VAR }
    }
    my $a = 갈丧中专ù𝐩e̲𝐝.new();
    is $a.a, 42, "uninitialized typed attribute should have its default";
    is $a.a_var.default, 42, 'is the default set correctly for Int $!a';
    lives-ok { $a.a++ }, "should be able to update typed attribute";
    is $a.a, 43, "update of typed attribute to 43 was successful";
    lives-ok { $a.a = Nil }, "should be able to assign Nil to typed attribute";
    is $a.a, 42, "typed attribute returned to its default with Nil";
    lives-ok { $a.a = 314 }, "should be able to update typed attribute";
    is $a.a, 314, "update of typed attribute to 314 was successful";
    is $a.b, 768, "typed attribute should be initialized";
    is $a.b_var.default, 42, 'is the default set correctly for Int $!b';
} #11

# not specifically typed
{
    my @à is default(42);
    is @à[0], 42, "uninitialized untyped array element should have its default";
    is @à.VAR.default, 42, 'is the default set correctly for @a';
    lives-ok { @à[0]++ }, "should be able to update untyped array element";
    is @à[0], 43, "update of untyped array element to 43 was successful";
    lives-ok { @à[0] = Nil }, "assign Nil to untyped array element";
    is @à[0], 42, "untyped array element returned to its default with Nil";
    lives-ok { @à[0] = 314 }, "should be able to update untyped array element";
    is @à[0], 314, "update of untyped array element to 314 was successful";

    my @丛 is default(42) = 768;
    is @丛[0], 768, "untyped array element should be initialized";
    is @丛.VAR.default, 42, 'is the default set correctly for @b';

    my @개 is default(Nil);
    ok @개.VAR.default === Nil, 'is the default set correctly for @c';
    lives-ok { @개[0]++ }, 'should be able to increment untyped variable';
    is @개[0], 1, "untyped variable should be incremented";
    lives-ok { @개[0] = Nil }, "able to assign Nil to untyped variable";
    ok @개[0] === Nil, 'is the default value correctly reset for @c[0]';

    my @𝐝 is default(Nil) = 353;
    is @𝐝[0], 353, "untyped variable should be initialized";
    ok @𝐝.VAR.default === Nil, 'is the default set correctly for @d';
}

# not specifically typed array attribute
{
    class 不갨专ù𝐩e̲Àссàù {
        has @.a is rw is default(42);
        has @.b is rw is default(42) = 768;
        has @.c is rw is default(Nil);
        has @.d is rw is default(Nil) = 353;
        method a_var { @!a.VAR }
        method b_var { @!b.VAR }
        method c_var { @!c.VAR }
        method d_var { @!d.VAR }
    }
    my $a = 不갨专ù𝐩e̲Àссàù.new();
    is $a.a[0], 42, "uninitialized untyped attrib element should have its default";
    is $a.a_var.default, 42, 'is the default set correctly for @!a';
    lives-ok { $a.a[0]++ }, "should be able to update untyped attrib element";
    is $a.a[0], 43, "update of untyped attrib element to 43 was successful";
    lives-ok { $a.a[0] = Nil }, "assign Nil to untyped attrib element";
    is $a.a[0], 42, "untyped attrib element returned to its default with Nil";
    lives-ok { $a.a[0] = 314 }, "should be able to update untyped attrib element";
    is $a.a[0], 314, "update of untyped attrib element to 314 was successful";
    is $a.b[0], 768, "untyped attrib element should be initialized";
    is $a.b_var.default, 42, 'is the default set correctly for @!b';
    ok $a.c_var.default === Nil, 'is the default set correctly for @!c';
    lives-ok { $a.c[0]++ }, 'should be able to increment untyped variable';
    is $a.c[0], 1, "untyped variable should be incremented";
    lives-ok { $a.c[0] = Nil }, "able to assign Nil to untyped variable";
    ok $a.c[0] === Nil, 'is the default value correctly reset for @!c[0]';
    is $a.d[0], 353, "untyped variable should be initialized";
    ok $a.d_var.default === Nil, 'is the default set correctly for @!d';
} #19

# typed
{
    my Int @à is default(42);
    is @à[0], 42, "uninitialized typed array element should have its default";
    is @à.VAR.default, 42, 'is the default set correctly for Int @a';
    lives-ok { @à[0]++ }, "should be able to update typed array element";
    is @à[0], 43, "update of typed array element to 43 was successful";
    lives-ok { @à[0] = Nil }, "assign Nil to typed array element";
    is @à[0], 42, "typed array element returned to its default with Nil";
    lives-ok { @à[0] = 314 }, "should be able to update typed array element";
    is @à[0], 314, "update of typed array element to 314 was successful";

    my Int @丛 is default(42) = 768;
    is @丛[0], 768, "typed array element should be initialized";
    is @丛.VAR.default, 42, 'is the default set correctly for Int @b';
} #12

# typed array attribute
{
    class 갈丧中专ù𝐩e̲𝐝Àссàù {
        has Int @.a is rw is default(42);
        has Int @.b is rw is default(42) = 768;
        method a_var { @!a.VAR }
        method b_var { @!b.VAR }
    }
    my $a = 갈丧中专ù𝐩e̲𝐝Àссàù.new();
    is $a.a[0], 42, "uninitialized typed attrib element should have its default";
    is $a.a_var.default, 42, 'is the default set correctly for Int @!a';
    lives-ok { $a.a[0]++ }, "should be able to update typed attrib element";
    is $a.a[0], 43, "update of typed attrib element to 43 was successful";
    lives-ok { $a.a[0] = Nil }, "assign Nil to typed attrib element";
    is $a.a[0], 42, "typed attrib element returned to its default with Nil";
    lives-ok { $a.a[0] = 314 }, "should be able to update typed attrib element";
    is $a.a[0], 314, "update of typed attrib element to 314 was successful";
    is $a.b[0], 768, "typed attrib element should be initialized";
    is $a.b_var.default, 42, 'is the default set correctly for Int @!b';
} #12

# not specifically typed
subtest "Hashes" => {
    plan 4;
    my @両àò両e̲ò =
        ( "Untyped",
            (my % is default(42)),
            (my % is default(42) = o => 768),
            (my % is default(Nil)),
            (my % is default(Nil) = o => 353)),

        ( "Typed Key",
            (my %{Str:D} is default(42)),
            (my %{Str:D} is default(42) = o => 768),
            (my %{Str:D} is default(Nil)),
            (my %{Str:D} is default(Nil) = o => 353)),

        ( "Typed Value",
            (my Int % is default(42)),
            (my Int % is default(42) = o => 768),
            (my IntOrNil % is default(Nil)),
            (my IntOrNil % is default(Nil) = o => 353)),

        ( "Typed Value And Key",
            (my Int %{Str:D} is default(42)),
            (my Int %{Str:D} is default(42) = o => 768),
            (my IntOrNil %{Str:D} is default(Nil)),
            (my IntOrNil %{Str:D} is default(Nil) = o => 353)),
        ;

    for @両àò両e̲ò -> (Str:D $test-name, %a is raw, %b is raw, %c is raw, %d is raw) {
        subtest $test-name, {
            plan 2;
            subtest "concrete default" => {
                plan 13;
                is %a<o>, 42, "uninitialized hash element should have its default";
                is %a.VAR.default, 42, 'is the default set correctly for %a';
                lives-ok { %a<o>++ }, "should be able to update hash element";
                is %a<o>, 43, "update of hash element to 43 was successful";
                lives-ok { %a<o> = Nil }, "assign Nil to hash element";
                is %a<o>, 42, "hash element returned to its default with Nil";
                lives-ok { %a<o> = 314 }, "should be able to update hash element";
                is %a<o>, 314, "update of hash element to 314 was successful";
                is %a<o>:delete, 314, "delete of existing element returns its value";
                is %a<o>:delete, 42, "delete of deleted element returns hash default";
                is %a<z>:delete, 42, "delete of never initialized element returns hash default";

                is %b<o>, 768, "hash element should be initialized";
                is %b.VAR.default, 42, 'is the default set correctly for %b';
            }

            subtest "Nil default" => {
                plan 8;
                ok %c.VAR.default === Nil, 'is the default set correctly for %c';
                lives-ok { %c<o>++ }, 'should be able to increment hash element';
                is %c<o>, 1, "element should be incremented";
                lives-ok { %c<o> = Nil }, "able to assign Nil to hash element";
                ok %c<o> === Nil, 'is the default value correctly reset for %c<o>';
                is %c<z>:delete, Nil, "delete of never initialized element returns Nil from hash default";

                is %d<o>, 353, "hash element should be initialized";
                ok %d.VAR.default === Nil, 'is the default set correctly for %d';
            }
        }
    }
}

# not specifically typed attribute
subtest "Hash Attributes" => {
    plan 4;

    my class 不갨专ù𝐩e̲万àò両 {
        has %.a is rw is default(42);
        has %.b is rw is default(42) = o => 768;
        has %.c is rw is default(Nil);
        has %.d is rw is default(Nil) = o => 353;
        method a_var { %!a.VAR }
        method b_var { %!b.VAR }
        method c_var { %!c.VAR }
        method d_var { %!d.VAR }
        method name { "Untyped" }
    }
    my class 专ù𝐩e̲𝐝K̲e̲ù万àò両 {
        has %.a{Str:D} is rw is default(42);
        has %.b{Str:D} is rw is default(42) = o => 768;
        has %.c{Str:D} is rw is default(Nil);
        has %.d{Str:D} is rw is default(Nil) = o => 353;
        method a_var { %!a.VAR }
        method b_var { %!b.VAR }
        method c_var { %!c.VAR }
        method d_var { %!d.VAR }
        method name { "Typed Key" }
    }
    my class 专ù𝐩e̲𝐝𝐕àл갮e̲万àò両 {
        has Int %.a is rw is default(42);
        has Int %.b is rw is default(42) = o => 768;
        has IntOrNil %.c is rw is default(Nil);
        has IntOrNil %.d is rw is default(Nil) = o => 353;
        method a_var { %!a.VAR }
        method b_var { %!b.VAR }
        method c_var { %!c.VAR }
        method d_var { %!d.VAR }
        method name { "Typed Value" }
    }
    my class 专ù𝐩e̲𝐝K̲e̲ù𝐕àл갮e̲万àò両 {
        has Int %.a{Str:D} is rw is default(42);
        has Int %.b{Str:D} is rw is default(42) = o => 768;
        has IntOrNil %.c{Str:D} is rw is default(Nil);
        has IntOrNil %.d{Str:D} is rw is default(Nil) = o => 353;
        method a_var { %!a.VAR }
        method b_var { %!b.VAR }
        method c_var { %!c.VAR }
        method d_var { %!d.VAR }
        method name { "Typed Key and Value" }
    }
    for 不갨专ù𝐩e̲万àò両, 专ù𝐩e̲𝐝𝐕àл갮e̲万àò両, 专ù𝐩e̲𝐝K̲e̲ù万àò両, 专ù𝐩e̲𝐝K̲e̲ù𝐕àл갮e̲万àò両 -> \hash-type {
        subtest hash-type.name ~ " Hash" => {
            plan 2;
            my $a = hash-type.new();
            subtest "concrete default" => {
                plan 13;
                is $a.a<o>, 42, "uninitialized attrib hash element should have its default";
                is $a.a_var.default, 42, 'is the default set correctly for %!a';
                lives-ok { $a.a<o>++ }, "should be able to update attrib hash element";
                is $a.a<o>, 43, "update of attrib hash element to 43 was successful";
                lives-ok { $a.a<o> = Nil }, "assign Nil to attrib hash element";
                is $a.a<o>, 42, "attrib hash element returned to its default with Nil";
                lives-ok { $a.a<o> = 314 }, "should be able to update attrib hash element";
                is $a.a<o>, 314, "update of attrib hash element to 314 was successful";
                is $a.a<o>:delete, 314, "delete of an existing element returns its value";
                is $a.a<o>:delete, 42, "delete of deleted element returns hash default";
                is $a.a<z>:delete, 42, "delete of never initialized element returns hash default";
                is $a.b<o>, 768, "attrib hash element should be initialized";
                is $a.b_var.default, 42, 'is the default set correctly for %!b';
            }
            subtest "Nil default" => {
                plan 8;
                ok $a.c_var.default === Nil, 'is the default set correctly for %!c';
                lives-ok { $a.c<o>++ }, 'should be able to increment attrib hash element';
                is $a.c<o>, 1, "attrib hash element should be incremented";
                lives-ok { $a.c<o> = Nil }, "able to assign Nil to attrib hash element";
                ok $a.c<o> === Nil, 'is the default value correctly reset for %!c<o>';
                is $a.c<z>:delete, Nil, "delete of never initialized hash element returns Nil from hash default";
                is $a.d<o>, 353, "attrib hash element should be initialized";
                ok $a.d.VAR.default === Nil, 'is the default set correctly for %!d';
            }
        }
    }
}

# typed
{
    my Int %a is default(42);
    is %a<o>, 42, "uninitialized typed hash element should have its default";
    is %a.VAR.default, 42, 'is the default set correctly for Int %a';
    lives-ok { %a<o>++ }, "should be able to update typed hash element";
    is %a<o>, 43, "update of hash array element to 43 was successful";
    lives-ok { %a<o> = Nil }, "assign Nil to hash array element";
    is %a<o>, 42, "typed hash element returned to its default with Nil";
    lives-ok { %a<o> = 314 }, "should be able to update typed hash element";
    is %a<o>, 314, "update of typed hash element to 314 was successful";

    my Int %b is default(42) = o => 768;
    is %b<o>, 768, "typed hash element should be initialized";
    is %b.VAR.default, 42, 'is the default set correctly for Int %b';
} #12

# type mismatches in setting default
{
    throws-like 'my Int $a is default("foo")',
      X::Parameter::Default::TypeCheck,
      expected => Int,
      got      => 'foo';
    throws-like 'my Int $a is default(Nil)',
      X::Parameter::Default::TypeCheck,
      expected => Int,
      got      => Nil;
    throws-like 'my Int @a is default("foo")',
      X::Parameter::Default::TypeCheck,
      expected => Array[Int],
      got      => 'foo';
    throws-like 'my Int @a is default(Nil)',
      X::Parameter::Default::TypeCheck,
      expected => Array[Int],
      got      => Nil;
    throws-like 'my Int %a is default("foo")',
      X::Parameter::Default::TypeCheck,
      expected => Hash[Int],
      got      => 'foo';
    throws-like 'my Int %a is default(Nil)',
      X::Parameter::Default::TypeCheck,
      expected => Hash[Int],
      got      => Nil;
# https://github.com/Raku/old-issue-tracker/issues/6512
    throws-like 'class IntFoo { has Int $!a is default("foo") }',
      X::TypeCheck::Attribute::Default,
      expected => Int,
      got      => 'foo';
    throws-like 'class IntNil { has Int $!a is default(Nil) }',
      X::TypeCheck::Attribute::Default,
      expected => Int,
      got      => Nil;
} #6

# native types
{
    throws-like 'my int $a is default(42)',
      X::Comp::Trait::NotOnNative,
      type    => 'is',
      subtype => 'default';
    throws-like 'my int @a is default(42)',
      X::Comp::Trait::NotOnNative,
      type    => 'is',
      subtype => 'default';
    #?rakudo todo 'fails first on native int hashes being NYI'
    throws-like 'my int %a is default(42)',
      X::Comp::Trait::NotOnNative,
      type    => 'is',
      subtype => 'default';
} #4

# https://github.com/Raku/old-issue-tracker/issues/4553
lives-ok { EVAL 'my Any $a is default(3)' }, 'Default value that is subtype of constraint works fine';
lives-ok { EVAL 'class Any3 { has Any $!a is default(3) }' }, 'Default value that is subtype of attribute constraint works fine';

# https://github.com/Raku/old-issue-tracker/issues/4557
lives-ok { EVAL 'my $a is default(Mu); 1' }, 'Mu as a default value on an unconstrained Scalar works';

# https://github.com/Raku/old-issue-tracker/issues/6513
subtest 'can use `Mu` as default for attributes' => {
    plan 3;

    my class 갂갨w̲Òàùò { has $.a is default(Mu); has $.b is default(Mu) is rw }
    cmp-ok 갂갨w̲Òàùò.new.a.WHAT, '=:=', Mu, 'defaults to default value on instantiation';
    cmp-ok 갂갨w̲Òàùò.new(:42a).a, '==', 42, 'constructor sets the value';
    with 갂갨w̲Òàùò.new: :42b {
        .b = Nil;
        cmp-ok .b.WHAT, '=:=', Mu, 'assigning Nil restores Mu default';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/4561
eval-lives-ok 'my $a is default(Failure.new); 1',
    'Failure.new as a default value on an unconstrained Scalar works';
eval-lives-ok 'class NoneFailure { has $!a is default(Failure.new); 1}',
    'Failure.new as a default value on an unconstrained Scalar attribute works';

# https://github.com/Raku/old-issue-tracker/issues/4555
subtest 'is default() respects type constraint' => {
    plan 2;
    subtest 'variable' => {
        plan 3;
        throws-like ｢my $a is default("foo") of Int｣,
            X::Parameter::Default::TypeCheck, 'is default() + of';
        throws-like ｢my $a of Int is default("foo")｣,
            X::Parameter::Default::TypeCheck, 'of is default()';
        throws-like ｢my Int $a is default("foo")｣,
            X::Parameter::Default::TypeCheck, 'Type $ is default()';
    }

    subtest 'attribute' => {
        plan 3;
        throws-like ｢class { has $.a is default("foo") of Int }｣,
            X::TypeCheck::Attribute::Default, 'is default() + of';
        throws-like ｢class { has $.a of Int is default("foo") }｣,
            X::TypeCheck::Attribute::Default, 'of is default()';
        throws-like ｢class { has Int $.a is default("foo") }｣,
            X::TypeCheck::Attribute::Default, 'Type $ is default()';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/4555
subtest 'default `is default()` gets adjusted to type constraint' => {
    plan 2;
    subtest 'variable' => {
        plan 3;
        my Int $a;
        is-deeply $a, Int, 'uninitialized read';
        $a = 3;
        is-deeply $a, 3, 'set a value';
        $a = Nil;
        is-deeply $a, Int, 'setting to Nil restores correct default';
    }

    subtest 'attribute' => {
        plan 4;
        my $o := class { has Int $.a is rw; has Num $.b }.new;
        is-deeply $o.a, Int, 'uninitialized read (rw attr)';
        is-deeply $o.b, Num, 'uninitialized read (ro attr)';
        $o.a = 3;
        is-deeply $o.a, 3, 'set a value';
        $o.a = Nil;
        is-deeply $o.a, Int, 'setting to Nil restores correct default';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/4640
{
    class 𝐃e̲еà갮л中专ù𝐩e̲𝐝 { has Int:D $.a is rw is default(42) }
    is 𝐃e̲еà갮л中专ù𝐩e̲𝐝.new.a, 42, 'uninitialized typed:D attribute should have its default';
    throws-like ｢class 不갢л𝐃e̲еà갮л中专ù𝐩e̲𝐝 { has Int:D $.a is rw is default(Nil) }｣,
                X::TypeCheck::Attribute::Default;
}

subtest "Generics" => {
    my role С[::T] {
        has $.v is default(T);
        has %.h is default(T);
        has @.a is default(T);
    }

    my class 갂 does С[Str:D] {}

    my $갨丛𝐣 = 갂.new;

    cmp-ok $갨丛𝐣.v, &[===], Str:D, "scalar gets its default instantiated";
    cmp-ok $갨丛𝐣.h<the-answer>, &[===], Str:D, "hash gets its default instantiated";
    cmp-ok $갨丛𝐣.a[42], &[===], Str:D, "array gets its default instantiated";
}

# vim: expandtab shiftwidth=4
