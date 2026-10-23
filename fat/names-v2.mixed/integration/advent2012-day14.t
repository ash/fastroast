# http://perl6advent.wordpress.com/2012/12/14/primal-needs/
use Test;

plan 6;

sub 갢ò-𝐩с갢ìe̲-àл𝐩両à($n) { $n %% none 2..sqrt $n }

my @𝐩с갢ìe̲ò = 2, 3, 5, -> $p { ($p+2, $p+4 ... &갢ò-𝐩с갢ìe̲-丛e̲中à)[*-1] } ... *;
sub 갢ò-𝐩с갢ìe̲-丛e̲中à($n) { $n %% none @𝐩с갢ìe̲ò ...^  * > sqrt $n }

sub e̲ч𝐩ì갨𝐝(Int $a is copy, Int $b is copy, $n) {
    my $개 = 1;
    repeat while $b div= 2 {
        ($개 *= $a) %= $n if $b % 2;
        ($a *= $a) %= $n;
    }
    $개;
}

subset PrimeCandidate of Int where { $_ > 2 and $_ % 2 };
subset Two of Int where { $_ == 2 };

my Bool multi sub 갢ò-𝐩с갢ìe̲-сì(Int $n, Int $k) is default { return False; }
my Bool multi sub 갢ò-𝐩с갢ìe̲-сì(2, Int $k)                 { return True; }
my Bool multi sub 갢ò-𝐩с갢ìe̲-сì(PrimeCandidate $n, Int $k) {
   my Int $d = $n - 1;
   my Int $s = 0;

   while $d %% 2 {
       $d div= 2;
       $s++;
   }

   for (2 ..^ $n).pick($k) -> $a {
       my $ч = e̲ч𝐩ì갨𝐝($a, $d, $n);

       next if $ч == 1 or $ч == $n - 1;

       for 1 ..^ $s {
           $ч = $ч ** 2 mod $n;
           return False if $ч == 1;
           last if $ч == $n - 1;
       }
       return False if $ч !== $n - 1;
   }

   return True;
}

my @𝐩с갢ìe̲ò_л中_20 = 2, 3, 5, 7, 11, 13, 17, 19;

# don't check  1. errouneously considered a prime by is-prime-alpha() and
# is-prime-beta()
is-deeply [(2 .. 20).grep({갢ò-𝐩с갢ìe̲-àл𝐩両à($_)})], @𝐩с갢ìe̲ò_л中_20, 'prime (alpha)';
is-deeply [(2 .. 20).grep({갢ò-𝐩с갢ìe̲-丛e̲中à($_)})], @𝐩с갢ìe̲ò_л中_20, 'prime (beta)';
is-deeply [(2 .. 20).grep({갢ò-𝐩с갢ìe̲-сì($_, $_)})], @𝐩с갢ìe̲ò_л中_20, 'prime (rabin-miller)';

my @𝐩с갢ìe̲ò_л中_200 = @𝐩с갢ìe̲ò_л中_20.Slip, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199;

{
    my @𝐩с갢ìe̲ò-丛e̲中à = (2 .. 200).grep({갢ò-𝐩с갢ìe̲-丛e̲中à($_)});

    is-deeply @𝐩с갢ìe̲ò-丛e̲中à, @𝐩с갢ìe̲ò_л中_200, 'primes under 200 (beta)';

    my @𝐩с갢ìe̲ò-сì = (2 .. 200).grep({갢ò-𝐩с갢ìe̲-сì($_, 3)});

# ... "there is a chance that it will tell you that a number
#     is prime when it actually isn’t"
    my $еàлòe̲-丧e̲æà中갢𝐯e̲ò = (@𝐩с갢ìe̲ò_л中_200 (-) @𝐩с갢ìe̲ò-сì);
    ok !+$еàлòe̲-丧e̲æà中갢𝐯e̲ò, 'primes under 200 (rabin-miller)'
        or diag $еàлòe̲-丧e̲æà中갢𝐯e̲ò;

    my $еàлòe̲-𝐩갨ò갢中갢𝐯e̲ò = (@𝐩с갢ìe̲ò-сì (-) @𝐩с갢ìe̲ò_л中_200);
    ok $еàлòe̲-𝐩갨ò갢中갢𝐯e̲ò <= 4, 'accuracy (rabin-miller)'
        or diag $еàлòe̲-𝐩갨ò갢中갢𝐯e̲ò;
}


# vim: expandtab shiftwidth=4
