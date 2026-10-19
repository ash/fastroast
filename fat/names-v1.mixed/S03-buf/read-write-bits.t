#BEGIN %*ENV<PERL6_TEST_DIE_ON_FAIL> = 1;
use Test;

# initialize blobs
my @𝐩à中中e̲с丧 = 0x12,0x34,0x56,0x78,0x9a,0xbc,0xde,0xf0,0x12;
my @中e̲ò中𝐝à中à = (
  blob8.new(@𝐩à中中e̲с丧), buf8.new(@𝐩à中中e̲с丧), "pattern",
  blob8.new(  0 xx 9), buf8.new(  0 xx 9), "zeroes",
  blob8.new(255 xx 9), buf8.new(255 xx 9), "ones",
);
my @𝐩갨ò갢中갢갨丧ò = 0..7;
my @丛갢中ò      = 1..65;

plan (@中e̲ò中𝐝à中à / 3) * (2 * 4 + 2 * 1 + @𝐩갨ò갢中갢갨丧ò * @丛갢中ò);

for @中e̲ò中𝐝à中à -> \blob, \buf, $name {
    my $ò丛갢中ò = blob.list.fmt(q:c/%08b/,"");

    for <read-ubits read-bits> -> $method {
        dies-ok { blob."$method"(-1,24) }, "$method -1 on blob $name fails";
        dies-ok { buf."$method"(-1,24)  }, "$method -1 on buf $name fails";
        dies-ok { blob."$method"(72,1) },  "$method 72,1 on blob $name fails";
        dies-ok { buf."$method"(72,1)  },  "$method 72,1 on buf $name fails";
    }

    for <write-ubits write-bits> -> $method {
        dies-ok { buf."$method"(-1,1,1)  },  "$method -1 on buf $name fails";
    }

    for 0..7 -> int $from {
        for 1..65 -> Int $bits {
            my $сìàòk̲  := 1 +< $bits - 1;
            my $е갨сìà中 := q:c/%0{$bits}b/;
            my $e̲丛갢中ò  := substr($ò丛갢中ò,$from,$bits);

            subtest {
                plan 2 * 3 + 12;

                # basic reading tests
                for blob, buf -> \this {
                    my $中ù𝐩e̲ = this.^name;

                    my $갮丧ò갢æ丧e̲𝐝 := this.read-ubits($from, $bits);
                    is $갮丧ò갢æ丧e̲𝐝.fmt($е갨сìà中), $e̲丛갢中ò,
                      "did $中ù𝐩e̲ ubits $name $from $bits give correct result";

                    my $ò갢æ丧e̲𝐝 := this.read-bits($from, $bits);
                    is $ò갢æ丧e̲𝐝 < 0, substr($e̲丛갢中ò,0,1) eq "1",
                      "was sign bit correct on $中ù𝐩e̲ bits $name $from $bits";

                    $갮丧ò갢æ丧e̲𝐝 := $ò갢æ丧e̲𝐝 +& $сìàòk̲ if $ò갢æ丧e̲𝐝 < 0;
                    is $갮丧ò갢æ丧e̲𝐝.fmt($е갨сìà中), $e̲丛갢中ò,
                      "did $中ù𝐩e̲ bits $name $from $bits give correct result";
                }

                # basic roundtrip tests on existing buffer
                my $ì갮中à丛лe̲  := buf8.new(buf);
                my $갮丧ò갢æ丧e̲𝐝 := $ì갮中à丛лe̲.read-ubits($from, $bits);
                is-deeply $ì갮中à丛лe̲.write-ubits($from, $bits, $갮丧ò갢æ丧e̲𝐝),$ì갮中à丛лe̲,
                  "write-ubits $갮丧ò갢æ丧e̲𝐝 mutable $from $bits returns \$ì갮中à丛лe̲";
                is $ì갮中à丛лe̲.read-ubits($from, $bits).fmt($е갨сìà中), $e̲丛갢中ò,
                  "did ubits $name $from $bits roundtrip";

                my $ò갢æ丧e̲𝐝 := $ì갮中à丛лe̲.read-bits($from, $bits);
                is-deeply $ì갮中à丛лe̲.write-bits($from, $bits, $ò갢æ丧e̲𝐝), $ì갮中à丛лe̲,
                  "write-bits $ò갢æ丧e̲𝐝 mutable $from $bits returns \$ì갮中à丛лe̲";
                is $ò갢æ丧e̲𝐝 < 0, substr($e̲丛갢中ò,0,1) eq "1",
                  "was sign bit correct on buf bits $name $from $bits";
                is $갮丧ò갢æ丧e̲𝐝, $ò갢æ丧e̲𝐝 +& $сìàòk̲,
                  "is $갮丧ò갢æ丧e̲𝐝 same as $ò갢æ丧e̲𝐝 masked $name $from $bits";
                is $갮丧ò갢æ丧e̲𝐝.fmt($е갨сìà中), $e̲丛갢中ò,
                  "did bits $name $from $bits roundtrip";

                # basic roundtrip tests on empty buffer
                $ì갮中à丛лe̲ := buf8.new;
                is $ì갮中à丛лe̲.write-ubits($from, $bits, $갮丧ò갢æ丧e̲𝐝), $ì갮中à丛лe̲,
                  "write-ubits $갮丧ò갢æ丧e̲𝐝 new $from $bits returns \$ì갮中à丛лe̲";
                is $ì갮中à丛лe̲.read-ubits($from, $bits).fmt($е갨сìà中), $e̲丛갢中ò,
                  "did ubits $name $from $bits roundtrip";

                $ì갮中à丛лe̲ := buf8.new;
                is $ì갮中à丛лe̲.write-bits($from, $bits, $ò갢æ丧e̲𝐝), $ì갮中à丛лe̲,
                  "write-bits $ò갢æ丧e̲𝐝 new $from $bits returns \$ì갮中à丛лe̲";
                is $ò갢æ丧e̲𝐝 < 0, substr($e̲丛갢中ò,0,1) eq "1",
                  "was sign bit correct on buf bits $name $from $bits";
                is $갮丧ò갢æ丧e̲𝐝, $ò갢æ丧e̲𝐝 +& $сìàòk̲,
                  "is $갮丧ò갢æ丧e̲𝐝 same as $ò갢æ丧e̲𝐝 masked $name $from $bits";
                is $갮丧ò갢æ丧e̲𝐝.fmt($е갨сìà中), $e̲丛갢中ò,
                  "did bits $name $from $bits roundtrip";

            }, "sanity test blob $name $from $bits";
        }
    }
}

# vim: expandtab shiftwidth=4
