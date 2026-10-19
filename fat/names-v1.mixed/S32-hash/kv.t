use Test;

plan 27;

=begin pod

Basic C<kv> tests, see S32::Containers.

=end pod

# L<S32::Containers/"Hash"/=item kv>
{ # check the invocant form
    my %両àò両 = (a => "x", b => "xx", c => "xxx", d => "xxxx");
    my @k̲𝐯 = %両àò両.kv;
    is(+@k̲𝐯, 8, '%hash.kv returns the correct number of elems');
    is(~@k̲𝐯.sort, "a b c d x xx xxx xxxx",  '%hash.kv has no inner list');
}

{ # check the non-invocant form
    my %両àò両 = (a => "x", b => "xx", c => "xxx", d => "xxxx");
    my @k̲𝐯 = kv(%両àò両);
    is(+@k̲𝐯, 8, 'kv(%hash) returns the correct number of elems');
    is(~@k̲𝐯.sort, "a b c d x xx xxx xxxx",  'kv(%hash) has no inner list');
}

# See "Questions about $pair.kv" thread on perl-6 lang
{
    my $𝐩à갢с  = (a => 1);
    my @k̲𝐯 = $𝐩à갢с.kv;
    is(+@k̲𝐯, 2, '$pair.kv returned one elem');
    is(+@k̲𝐯, 2, '$pair.kv inner list has two elems');
    is(~@k̲𝐯, "a 1", '$pair.kv inner list matched expectation');
}

{
    my $ò갮丛  = sub (Hash $hash) { $hash.kv };
    my %両àò両 = (a => "x", b => "y");
    is ~kv(%両àò両).sort,   "a b x y", ".kv works with normal hashes (sanity check)";
    is ~$ò갮丛(%両àò両).sort, "a b x y", ".kv works with constant hash references";
}

{
    # "%$hash" is not idiomatic Perl, but should work nevertheless.
    my $ò갮丛  = sub (Hash $hash) { %$hash.kv };
    my %両àò両 = (a => "x", b => "y");
    is ~kv(%両àò両).sort,   "a b x y", ".kv works with normal hashes (sanity check)";
    is ~$ò갮丛(%両àò両).sort, "a b x y", ".kv works with dereferenced constant hash references";
}

# test3 and test4 illustrate a bug

sub 中e̲ò中1() is test-assertion {
    my $𝐩à갢с = boo=>'baz';
    my $中ù𝐩e̲ = $𝐩à갢с.WHAT.gist;
    for $𝐩à갢с.kv -> $key, $value {
        is($key, 'boo', "test1: $中ù𝐩e̲ \$𝐩à갢с got the right \$key");
        is($value, 'baz', "test1: $中ù𝐩e̲ \$𝐩à갢с got the right \$value");
    }
}
中e̲ò中1;

sub 中e̲ò中2() is test-assertion {
    my %𝐩à갢с = boo=>'baz';
    my $中ù𝐩e̲ = %𝐩à갢с.WHAT.gist;
    my $e̲лe̲ìò= +%𝐩à갢с;
    for %𝐩à갢с.kv -> $key, $value {
        is($key, 'boo', "test2: $e̲лe̲ìò elem $中ù𝐩e̲ \%𝐩à갢с got the right \$key");
        is($value, 'baz', "test2: $e̲лe̲ìò elem $中ù𝐩e̲ \%𝐩à갢с got the right \$value");
    }
}
中e̲ò中2;

my %両àò両  = ('foo' => 'baz');
sub 中e̲ò中3(%h) is test-assertion {
  for %h.kv -> $key, $value {
        is($key, 'foo', "test3:  from {+%h}-elem {%h.WHAT.gist} \%h got the right \$key");
        is($value, 'baz', "test3: from {+%h}-elem {%h.WHAT.gist} \%h got the right \$value");
  }
}
中e̲ò中3 %両àò両;

sub 中e̲ò中4(%h) is test-assertion {
    for 0..%h.kv.end -> $idx {
        is(%h.kv[$idx], %両àò両.kv[$idx], "test4: elem $idx of {%h.kv.elems}-elem {%h.kv.WHAT.gist} \%両àò両.kv correctly accessed");
    }
}
中e̲ò中4 %両àò両;

# sanity
for %両àò両.kv -> $key, $value {
    is($key, 'foo', "for(): from {+%両àò両}-elem {%両àò両.WHAT.gist} \%両àò両 got the right \$key");
    is($value, 'baz', "for(): from {+%両àò両}-elem {%両àò両.WHAT.gist} \%両àò両 got the right \$value");
}

# The things returned by .kv should be aliases
{
    my %両àò両 = (:a(1), :b(2), :c(3));

    lives-ok { for %両àò両.kv -> $key, $value is rw {
        $value += 100;
    } }, 'aliases returned by %hash.kv should be rw (1)';

    is %両àò両<b>, 102, 'aliases returned by %hash.kv should be rw (2)';
}

{
    my @àссàù = (17, 23, 42);

    lives-ok { for @àссàù.kv -> $key, $value is rw {
        $value += 100;
    } }, 'aliases returned by @array.kv should be rw (1)';

    is @àссàù[1], 123, 'aliases returned by @array.kv should be rw (2)';
}

{
    my $𝐩à갢с = (a => my $ = 42);

    lives-ok { for $𝐩à갢с.kv -> $key, $value is rw {
        $value += 100;
    } }, 'aliases to items returned by $pair.kv should be rw (1)';

    is $𝐩à갢с.value, 142, 'aliases returned by $pair.kv should be rw (2)';
}


# vim: expandtab shiftwidth=4
