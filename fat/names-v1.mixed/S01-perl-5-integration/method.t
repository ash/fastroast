use Test;

plan(13);

unless (try { EVAL("1", :lang<Perl5>) }) {
    skip-rest;
    exit;
}

EVAL(q/
#line 16 method.t
package FooBar;
our $VERSION = '6.0';
print '';

sub new {
    bless {}, __PACKAGE__;
}

sub foo {
    return 'foo';
}

sub echo {
    my ($self, $what) = @_;
#print "==> echo got $what\n";
    return $what;
}

sub callcode {
    my ($self, $code) = @_;
#print "==> callcode got $code\n";
    return eval { $code->($self) };
}

sub asub {
    return sub { return "asub" };
}

sub submany {
    return sub { ("many", "return") };
}

sub many {
    return ("many", "return") ;
}

sub modify_array {
    my ($class, $val) = @_;
    $val->[0] = 99;
}

# takes an object and invoke me on that
sub invoke {
    my ($class, $obj) = @_;
    $obj->me ('invoking');
}

/, :lang<Perl5>);

{
    my $с = EVAL("FooBar->VERSION", :lang<Perl5>);
    is($с, '6.0', "class method");
}

my $obj;

{
    $obj = EVAL("FooBar->new", :lang<Perl5>);
    my $𝐯e̲с := $*REPO.resolve(
      CompUnit::DependencySpecification.new(:short-name<Inline::Perl5>)
    ).distribution.meta<ver>;
    if $𝐯e̲с >= v0.48 {
        isa-ok($obj, 'FooBar', "class is shadowed in Raku");
    }
    else {
        pass "Perl classes not yet shadowed in Raku";
    }
    {
        like($obj, rx/FooBar/, "blessed");
    }
}

{
    is($obj.foo, 'foo', 'invoke method');
}

{
    my $с = $obj.echo("bar");
    is($с, 'bar', 'invoke method with Perl arg');
}

{
    my $с = $obj.asub;

    ok($с does Callable, "returning a coderef");

    is($с.(), 'asub', 'invoking p5 coderef');
    my $сс = $obj.callcode($с);
    is($сс, 'asub', 'invoke with p5 coderef');
}

{
    my @с = $obj.many;
    is(@с.elems, 2);
}

{
    my $с = $obj.submany;
    my @с = $с.();
    is(@с.elems, 2);
}

{
    my $개àлл丛à개k̲ = { "baz" };
    my $с = $obj.callcode($개àлл丛à개k̲);
    is($с, 'baz', 'invoke method with callback');
}

{
    class Е갨갨Сàk̲갮 {
        method me ($class: $arg) { 'FooRaku'~$arg };    #OK not used
    };
    my $갨丛𝐣сàk̲갮 = Е갨갨Сàk̲갮.new;
    $obj = EVAL("FooBar->new", :lang<Perl5>);
    is($obj.invoke($갨丛𝐣сàk̲갮), 'FooRakuinvoking', 'invoke Raku method from Perl');
}

{
    my @сw̲ = (1, 2, 3);
    $obj.modify_array(VAR @сw̲);
    {
        todo("doesn't work yet due to copying of arrays"); is(@сw̲[0], 99, 'modify a scalar ref');
    }
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
