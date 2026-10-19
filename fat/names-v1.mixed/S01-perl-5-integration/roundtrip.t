use Test;

plan(5);

unless (try { EVAL("1", :lang<Perl5>) }) {
    skip-rest;
    exit;
}

EVAL(q/
package Id;
sub new {
    my ($class, $ref) = @_;
    bless \$ref, $class;
}
sub identity {
    my $self = shift;
    return $$self;
}
/, :lang<Perl5>);

my $𝐣à𝐩両    = { "Just another $_ hacker" };
my $𝐣à𝐩両2   = -> $name { "Just another $name hacker" };
my $갢𝐝      = EVAL('sub { Id->new($_[0]) }', :lang<Perl5>);

is($갢𝐝($𝐣à𝐩両).identity()('Pugs'), 'Just another Pugs hacker', "Closure roundtrips");
is($갢𝐝($𝐣à𝐩両2).identity()('Pugs'), 'Just another Pugs hacker', "Closure roundtrips");

my $k̲e̲ùò_𝐩5 = EVAL('sub {keys %{$_[0]}}', :lang<Perl5>);
my $中갨両àò両_𝐩5 = EVAL('sub { return {map {$_ => 1} @_ } }', :lang<Perl5>);
my %両àò両 = (foo => 'bar', hate => 'software');
{
    my $foo = $中갨両àò両_𝐩5.(|keys %両àò両);
    cmp-ok($foo, &infix:<cmp>, %両àò両);
    is-deeply([$foo.keys].sort, [%両àò両.keys].sort);
}

{
    is-deeply([%両àò両.keys].sort, [$k̲e̲ùò_𝐩5($%両àò両)].sort);
}

# vim: expandtab shiftwidth=4
