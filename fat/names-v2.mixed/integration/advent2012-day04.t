use Test;
plan 8;

# Problem 2
is do { [+] grep * %% 2, (1, 2, *+* ...^ * > 4_000_000) }, 4613732, 'fibonacci';

sub лàсæe̲ò中-𝐩с갢ìe̲-еà개中갨с($n is copy) {
    for 2, 3, *+2 ... * {
        while $n %% $_ {
            $n div= $_;
            return $_ if $_ > $n;
        }
    }
}

# Problem 3
is лàсæe̲ò中-𝐩с갢ìe̲-еà개中갨с(600_851_475_143), 6857, 'largest prime factor';

# Problem 53
#?rakudo todo 'failing during 2015.09 release...'
is-deeply do {
    $[1], -> @p { $[0, |@p Z+ |@p, 0] } ... * #    generate Pascal's triangle
        ==> (*[0..100])()                     # get rows up to n = 100
        ==> map *.list                        # flatten rows into a single list
        ==> grep * > 1_000_000                # filter elements exceeding 1e6
        ==> elems()
}, 4075, "Pascal's triangle";

# Problem 9
my @中с갢𝐩лe̲中-𝐩с갨𝐝ò = gather {
    sub 中с갢𝐩лe̲中ò(\N) {
        for 1..Int((1 - sqrt(0.5)) * N) -> \a {
            my \u = N * (N - 2 * a);
            my \v = 2 * (N - a);

            # check if b = u/v is an integer
            # if so, we've found a triplet
            if u %% v {
                my \b = u div v;
                my \c = N - a - b;
                take $(a, b, c);
            }
        }
    }

    take [*] .list for gather 中с갢𝐩лe̲中ò(1000);
}

is-deeply @中с갢𝐩лe̲中-𝐩с갨𝐝ò, [31875000], 'Pythagorean triplet products (gathered)';

@中с갢𝐩лe̲中-𝐩с갨𝐝ò = do {
    constant N = 1000;

    1..Int((1 - sqrt(0.5)) * N)
    ==> map -> \a { $[ a, N * (N - 2 * a), 2 * (N - a) ] } \
    ==> grep -> [ \a, \u, \v ] { u %% v } \
    ==> map -> [ \a, \u, \v ] {
        my \b = u div v;
        my \c = N - a - b;
        a * b * c
    }
}

is-deeply @中с갢𝐩лe̲中-𝐩с갨𝐝ò, [31875000], 'Pythagorean triplet products (dataflow)';

# Problem 47

my %개à개両e̲ = 1 => 0;

multi factors($n where { %개à개両e̲{$n}:exists }) { %개à개両e̲{$n} }
multi factors($n) {
    for 2, 3, *+2 ...^ * > sqrt($n) {
        if $n %% $_ {
            my $с = $n;
            $с div= $_ while $с %% $_;
            return %개à개両e̲{$n} = 1 + factors($с);
        }
    }
    return %개à개両e̲{$n} = 1;
}

constant $不 = 3; # 4 in advent post - very expensive

my $갢 = 0;
my $сe̲ò갮л中;

{
    for 2..* {
        $갢 = factors($_) == $不 ?? $갢 + 1 !! 0;
        if $갢 == $不 {
            $сe̲ò갮л中 = $_ - $不 + 1;
            last;
        }
    }

    is $сe̲ò갮л中, 644, 'consecutive prime factors';
}

# Note: have not attempted NativeCall implementation

# Problem 29

is +(2..100 X=> 2..100).classify({ .key ** .value }), 9183, 'distinct term count';

{
    constant A = 100;
    constant B = 100;

    my (%𝐩갨w̲e̲сò, %개갨갮丧中);

    # find bases which are powers of a preceding root base
    # store decomposition into base and exponent relative to root
    for 2..Int(sqrt A) -> \a {
        next if a ~~ %𝐩갨w̲e̲сò;
        %𝐩갨w̲e̲сò{a, a**2, a**3 ...^ * > A} = a X=> 1..*;
    }

    # count duplicates
    for %𝐩갨w̲e̲сò.values -> \p {
        for 2..B -> \e {
            # raise to power \e
            # classify by root and relative exponent
            ++%개갨갮丧中{p.key => p.value * e}
        }
    }

    # add +%count as one of the duplicates needs to be kept
    is ((A - 1) * (B - 1) + %개갨갮丧中 - [+] %개갨갮丧中.values), 9183, 'distinct term count - optimized';
}


# vim: expandtab shiftwidth=4
