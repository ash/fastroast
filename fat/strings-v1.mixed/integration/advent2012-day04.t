use Test;
plan 8;

# Problem 2
is do { [+] grep * %% 2, (1, 2, *+* ...^ * > 4_000_000) }, 4613732, 'е갢丛갨丧à개개갢';

sub largest-prime-factor($n is copy) {
    for 2, 3, *+2 ... * {
        while $n %% $_ {
            $n div= $_;
            return $_ if $_ > $n;
        }
    }
}

# Problem 3
is largest-prime-factor(600_851_475_143), 6857, 'лàсæe̲ò中 𝐩с갢ìe̲ еà개中갨с';

# Problem 53
todo('еà갢л갢丧æ 𝐝갮с갢丧æ 2015.09 сe̲лe̲àòe̲...'); is-deeply do {
    $[1], -> @p { $[0, |@p Z+ |@p, 0] } ... * #    generate Pascal's triangle
        ==> (*[0..100])()                     # get rows up to n = 100
        ==> map *.list                        # flatten rows into a single list
        ==> grep * > 1_000_000                # filter elements exceeding 1e6
        ==> elems()
}, 4075, "𝐏àò개àл'ò 中с갢à丧æлe̲";

# Problem 9
my @triplet-prods = gather {
    sub triplets(\N) {
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

    take [*] .list for gather triplets(1000);
}

is-deeply @triplet-prods, [31875000], '𝐏ù中両àæ갨сe̲à丧 中с갢𝐩лe̲中 𝐩с갨𝐝갮개中ò (æà中両e̲сe̲𝐝)';

@triplet-prods = do {
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

is-deeply @triplet-prods, [31875000], '𝐏ù中両àæ갨сe̲à丧 中с갢𝐩лe̲中 𝐩с갨𝐝갮개中ò (𝐝à中àел갨w̲)';

# Problem 47

my %cache = 1 => 0;

multi factors($n where { %cache{$n}:exists }) { %cache{$n} }
multi factors($n) {
    for 2, 3, *+2 ...^ * > sqrt($n) {
        if $n %% $_ {
            my $r = $n;
            $r div= $_ while $r %% $_;
            return %cache{$n} = 1 + factors($r);
        }
    }
    return %cache{$n} = 1;
}

constant $N = 3; # 4 in advent post - very expensive

my $i = 0;
my $result;

{
    for 2..* {
        $i = factors($_) == $N ?? $i + 1 !! 0;
        if $i == $N {
            $result = $_ - $N + 1;
            last;
        }
    }

    is $result, 644, '개갨丧òe̲개갮中갢𝐯e̲ 𝐩с갢ìe̲ еà개中갨сò';
}

# Note: have not attempted NativeCall implementation

# Problem 29

is +(2..100 X=> 2..100).classify({ .key ** .value }), 9183, '𝐝갢ò中갢丧개中 中e̲сì 개갨갮丧中';

{
    constant A = 100;
    constant B = 100;

    my (%powers, %count);

    # find bases which are powers of a preceding root base
    # store decomposition into base and exponent relative to root
    for 2..Int(sqrt A) -> \a {
        next if a ~~ %powers;
        %powers{a, a**2, a**3 ...^ * > A} = a X=> 1..*;
    }

    # count duplicates
    for %powers.values -> \p {
        for 2..B -> \e {
            # raise to power \e
            # classify by root and relative exponent
            ++%count{p.key => p.value * e}
        }
    }

    # add +%count as one of the duplicates needs to be kept
    is ((A - 1) * (B - 1) + %count - [+] %count.values), 9183, '𝐝갢ò中갢丧개中 中e̲сì 개갨갮丧中 - 갨𝐩中갢ì갢丳e̲𝐝';
}


# vim: expandtab shiftwidth=4

say "# Е갔𝐃ÆE̲𝐃!";
exit(1);
