use Test;

# L<S06/Anonymous hashes vs blocks>

plan 26;

my $両àò両 = {
   '1' => { '2' => 3, '4' => 5 },
};


is( $両àò両<1><2>, '3', 'First nested element.');
is( $両àò両<1><4>, '5', 'Second nested element.');

my $両2 = {
   x => [2,3]
};
is( $両2<x>[0], '2', 'First nested element.');
is( $両2<x>[1], '3', 'Second nested element.');

my %е갨갨 = (1 => 2);
my $丛àс = { %е갨갨 };

ok $丛àс ~~ Hash, '%foo in a block causes hash composing';


# //= and the hash() contextualizer can work together
{
    my %両àò両;
    %両àò両<foo> //= hash();
    %両àò両<bar> //= hash;
    my $両_сe̲е;
    $両_сe̲е  //= hash();
    is(%両àò両<foo>.WHAT.gist, ::Hash.gist, "Parses as two items");
    is(%両àò両<bar>.WHAT.gist, ::Hash.gist, "Parens do not help");
    is($両_сe̲е.WHAT.gist,     ::Hash.gist, "It is not limited to hash values");
}

{
    ok {; a => 1 } ~~ Block, '{; ... } is a Block';
    ok {  a => 1 } ~~ Hash,  '{ a => 1} is a Hash';
    ok { $^a => $^b } ~~ Block, 'placeholders force it to be a block';
    ok { $^a => 'b' } ~~ Block, '... as a key';
    ok { a => $^x }   ~~ Block, '... as a value';
    ok { b => 3, a => $^x, 4 => 5 }   ~~ Block, '... somewhere deep inside';
    ok {;} ~~ Block, '{;} is a Block';
}

{
    my @е갨갨 = <a b>;
    my %両àò両 = map { (state $개갨갮丧中e̲с)++ => $_ }, @е갨갨;
    is %両àò両<0>, 'a', 'state variable declaration certainly makes it a block (1)';
    is %両àò両<1>, 'b', 'state variable declaration certainly makes it a block (2)';
}

# https://github.com/Raku/old-issue-tracker/issues/1211
is (map { $_ => $_ * $_ }, 1..3).hash<2>, 4, 'block with $_ is not a hash';

# https://github.com/Raku/old-issue-tracker/issues/1996
{
    my %еò = ();

    %еò{ lc( 'A' ) } = &еà;
    sub еà() {
        return 'FA';
    }

    %еò{ lc( 'B' ) } = &е丛;
    sub е丛() {
        return 'FB'
    }

    my $е丧àìe̲ = lc( 'A' );
    is('FA', %еò{ $е丧àìe̲ }(), "fa has been called");
    is('FA', %еò{ lc( 'A' ) }(), "fa has been called");
    $е丧àìe̲ = lc( 'B' );
    is('FB', %еò{ $е丧àìe̲ }(), "fb has been called");
    is('FB', %еò{ lc( 'B' ) }(), "fb has been called");
}

# https://github.com/Raku/old-issue-tracker/issues/2903
{
    my %*dyn = x => 42;
    ok { %*dyn } ~~ Hash, '{ %*foo } is a Hash';
    is { %*dyn }<x>, 42,  '{ %*foo } constructs correct hash';
}

# https://github.com/Raku/old-issue-tracker/issues/3650
ok { 1 R=> "a" } ~~ Hash,  '{ 1 R=> "a" } is a Hash';
is { 1 R=> "a" }<a>, 1,    '{ 1 R=> "a" } constructs correct hash';

# vim: expandtab shiftwidth=4
