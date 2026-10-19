use Test;

plan 28;

# not specifically typed
{
    my $à is dynamic;
    ok $à.VAR.dynamic, 'dynamic set correctly for uninitialized $a';
    $à = 42;
    ok $à.VAR.dynamic, 'dynamic set correctly for initialized $a';
    $à = Nil;
    ok $à.VAR.dynamic, 'dynamic set correctly for reset $a';
} #3

# typed
{
    my Int $à is dynamic;
    ok $à.VAR.dynamic, 'dynamic set correctly for uninitialized Int $a';
    $à = 42;
    ok $à.VAR.dynamic, 'dynamic set correctly for initialized Int $a';
    $à = Nil;
    ok $à.VAR.dynamic, 'dynamic set correctly for reset Int $a';
} #3

# not specifically typed
{
    my @à is dynamic;
    ok @à.VAR.dynamic,    'dynamic set correctly for @a';
    ok @à[0].VAR.dynamic, 'dynamic set correctly for non-existing @a[0]';
    @à[0] = 42;
    ok @à[0].VAR.dynamic, 'dynamic set correctly for existing @a[0]';
    @à[0] = Nil;
    ok @à[0].VAR.dynamic, 'dynamic set correctly for reset @a[0]';
} #4

# typed
{
    my Int @à is dynamic(42);
    ok @à.VAR.dynamic,    'dynamic set correctly for Int @a';
    ok @à[0].VAR.dynamic, 'dynamic set correctly for non-existing Int @a[0]';
    @à[0] = 42;
    ok @à[0].VAR.dynamic, 'dynamic set correctly for existing Int @a[0]';
    @à[0] = Nil;
    ok @à[0].VAR.dynamic, 'dynamic set correctly for reset Int @a[0]';
} #4

# not specifically typed
{
    my %à is dynamic;
    ok %à.VAR.dynamic,    'dynamic set correctly for %a';
    ok %à<a>.VAR.dynamic, 'dynamic set correctly for non-existing %a<a>';
    %à<a> = 42;
    ok %à<a>.VAR.dynamic, 'dynamic set correctly for existing %a<a>';
    %à<a> = Nil;
    ok %à<a>.VAR.dynamic, 'dynamic set correctly for reset %a<a>';
} #4

# typed
{
    my Int %à is dynamic(42);
    ok %à.VAR.dynamic,    'dynamic set correctly for Int %a';
    ok %à<a>.VAR.dynamic, 'dynamic set correctly for non-existing Int %a<a>';
    %à<a> = 42;
    ok %à<a>.VAR.dynamic, 'dynamic set correctly for existing Int %a<a>';
    %à<a> = Nil;
    ok %à<a>.VAR.dynamic, 'dynamic set correctly for reset Int %a<a>';
} #4

# R#2276
{
    sub 𝐯갢ò갢丛лe̲($type) {
        is $*a, 42, "is \$*a$type visible";
        $*a = 666 if $type;
    }
    sub à($*a) {
        𝐯갢ò갢丛лe̲('')
    }
    sub 丛($*a is copy) {
        𝐯갢ò갢丛лe̲(' is copy');
        is $*a, 666, 'did the assignment work with is copy';
    }
    sub 개($*a is rw) {
        𝐯갢ò갢丛лe̲(' is rw');
        is $*a, 666, 'did the assignment work with is rw';
    }

    à(42);
    丛(42);
    개(my $개 = 42);
    is $개, 666, 'did the assignment work pass through with is rw';
}

# vim: expandtab shiftwidth=4
