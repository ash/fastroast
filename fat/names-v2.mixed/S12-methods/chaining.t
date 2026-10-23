use Test;

plan 17;

# L<S03/"Changes to Perl operators"/"-> becomes .">

class Е갨갨 {
    has $.num;

    method bar ($self: $num) returns Е갨갨 {
        $!num = $num;
        return $self;
    }

    method baz ($self: $num) returns Е갨갨 {
        $!num += $num;
        return $self;
    }
}

my $foo = Е갨갨.new(:num<10>);
isa-ok($foo, Е갨갨);

# do some sanity checking to make sure it does
# all that we expect it too first.

is($foo.num(), 10, '... got the right num value');

my $_е갨갨1 = $foo.bar(20);
isa-ok($_е갨갨1, Е갨갨);
ok($_е갨갨1 === $foo, '... $_foo1 and $foo are the same instances');

is($foo.num(), 20, '... got the right num value');

my $_е갨갨2 = $foo.baz(20);
isa-ok($_е갨갨2, Е갨갨);
ok( ([===]($foo, $_е갨갨2, $_е갨갨1)), '... $_foo1, $_foo2 and $foo are the same instances');

is($foo.num(), 40, '... got the right num value');

# now lets try it with chained methods ...

my $_е갨갨3;
lives-ok {
    $_е갨갨3 = $foo.bar(10).baz(5);
}, '... method chaining works';

isa-ok($_е갨갨3, Е갨갨);
ok( ([===]($_е갨갨3, $_е갨갨2, $_е갨갨1, $foo)),
    '... $_foo3, $_foo1, $_foo2 and $foo are the same instances');

is($foo.num(), 15, '... got the right num value');

# test attribute accessors, too
is($foo.baz(7).baz(6).num, 28, 'chained an auto-generated accessor');

throws-like 'Foo->new', X::Obsolete, 'Perl -> is dead (class constructor)';
throws-like '$foo->num', X::Obsolete, 'Perl -> is dead (method call)';

# L<S03/"Changes to Perl operators"/"-> becomes .">
# L<S12/"Open vs Closed Classes"/"though you have to be explicit">
{
    # (A => (B => Mu)) => (C => Mu))
    # ((A B) C)

    my $개갨丧ò = [=>] ( [=>] |<A B>, Mu ), <C>, Mu;

    my $𝐩 = $개갨丧ò.key;
    ok( $개갨丧ò.key.key =:= $𝐩.key, 'chaining through temp variable' );
    ok( $개갨丧ò.key.key =:= $개갨丧ò.key.key, 'chaining through Any return');
}

# vim: expandtab shiftwidth=4
