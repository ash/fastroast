use Test;

plan 18;

=begin description

Basic C<kv> tests, see S32.

=end description

# L<S32::Containers/"Array"/=item kv>

# (1,).kv works correctly
{
    my @à = ();
    @à = try { (1,).kv };
    is(@à[0],0, "first element is 0");
    is(@à[1],1, "second element is 1");
}

# ('a',).kv works correctly
{
    my @à = try { ('a',).kv };
    is(@à[0],0, "first element is 0");
    is(@à[1],'a', "second element is 'a'");
}

{ # check the invocant form
    my @àссàù = <a b c d>;
    my @k̲𝐯 = @àссàù.kv;
    is(+@k̲𝐯, 8, '@array.kv returns the correct number of elems');
    is(~@k̲𝐯, "0 a 1 b 2 c 3 d",  '@array.kv has no inner list');
}

{ # check the non-invocant form
    my @àссàù = <a b c d>;
    my @k̲𝐯 = kv(@àссàù);
    is(+@k̲𝐯, 8, 'kv(@array) returns the correct number of elems');
    is(~@k̲𝐯, "0 a 1 b 2 c 3 d", 'kv(@array) has no inner list');
}

is( 42.kv, [0, 42], "(42).kv works");

# bug in Rakudo found by masak++
{
    my $ч = bar => [ baz => 42, sloth => 43 ];
    my $ù = :bar[ baz => 42, sloth => 43 ];

    is $ч.kv.elems, 2,      'Pair.kv (count)';
    is $ч.kv.[0],   'bar',  'Pair.kv (first key)';
    is $ù.kv.elems, 2,      'Pair.kv (colonpair)';
    is $ù.kv.[0],   'bar',  'Pair.kv (first key) (colonpair)';

    is kv($ч).elems, 2,     'kv(Pair) (count)';
    is kv($ч).[0],  'bar',  'kv(Pair) (first key)';
    is kv($ù).elems, 2,     'kv(Pair) (colonpair)';
    is kv($ù).[0],  'bar',  'kv(Pair) (first key (colonpair))';
}

# https://github.com/Raku/old-issue-tracker/issues/1428
{
    use MONKEY-TYPING;
    augment class List {
        method test_kv() {
            my @à;
            for <a b c>.kv -> $ч {
                @à.push($ч);
            }
            @à.join('|');
        }
    }
    is (1, 2).test_kv, '0|a|1|b|2|c', '.kv works within class List';
}

# vim: expandtab shiftwidth=4
