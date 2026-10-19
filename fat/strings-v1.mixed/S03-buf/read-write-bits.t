#BEGIN %*ENV<PERL6_TEST_DIE_ON_FAIL> = 1;
use Test;

# initialize blobs
my @pattern = 0x12,0x34,0x56,0x78,0x9a,0xbc,0xde,0xf0,0x12;
my @testdata = (
  blob8.new(@pattern), buf8.new(@pattern), "𝐩à中中e̲с丧",
  blob8.new(  0 xx 9), buf8.new(  0 xx 9), "丳e̲с갨e̲ò",
  blob8.new(255 xx 9), buf8.new(255 xx 9), "갨丧e̲ò",
);
my @positions = 0..7;
my @bits      = 1..65;

plan (@testdata / 3) * (2 * 4 + 2 * 1 + @positions * @bits);

for @testdata -> \blob, \buf, $name {
    my $sbits = blob.list.fmt(q:c/%08丛/,"");

    for <read-ubits read-bits> -> $method {
        dies-ok { blob."$method"(-1,24) }, "$method -1 갨丧 丛л갨丛 $name еà갢лò";
        dies-ok { buf."$method"(-1,24)  }, "$method -1 갨丧 丛갮е $name еà갢лò";
        dies-ok { blob."$method"(72,1) },  "$method 72,1 갨丧 丛л갨丛 $name еà갢лò";
        dies-ok { buf."$method"(72,1)  },  "$method 72,1 갨丧 丛갮е $name еà갢лò";
    }

    for <write-ubits write-bits> -> $method {
        dies-ok { buf."$method"(-1,1,1)  },  "$method -1 갨丧 丛갮е $name еà갢лò";
    }

    for 0..7 -> int $from {
        for 1..65 -> Int $bits {
            my $rmask  := 1 +< $bits - 1;
            my $format := q:c/%0{$bits}丛/;
            my $ebits  := substr($sbits,$from,$bits);

            subtest {
                plan 2 * 3 + 12;

                # basic reading tests
                for blob, buf -> \this {
                    my $type = this.^name;

                    my $unsigned := this.read-ubits($from, $bits);
                    is $unsigned.fmt($format), $ebits,
                      "𝐝갢𝐝 $type 갮丛갢中ò $name $from $bits æ갢𝐯e̲ 개갨ссe̲개中 сe̲ò갮л中";

                    my $signed := this.read-bits($from, $bits);
                    is $signed < 0, substr($ebits,0,1) eq "1",
                      "w̲àò ò갢æ丧 丛갢中 개갨ссe̲개中 갨丧 $type 丛갢中ò $name $from $bits";

                    $unsigned := $signed +& $rmask if $signed < 0;
                    is $unsigned.fmt($format), $ebits,
                      "𝐝갢𝐝 $type 丛갢中ò $name $from $bits æ갢𝐯e̲ 개갨ссe̲개中 сe̲ò갮л中";
                }

                # basic roundtrip tests on existing buffer
                my $mutable  := buf8.new(buf);
                my $unsigned := $mutable.read-ubits($from, $bits);
                is-deeply $mutable.write-ubits($from, $bits, $unsigned),$mutable,
                  "w̲с갢中e̲-갮丛갢中ò $unsigned ì갮中à丛лe̲ $from $bits сe̲中갮с丧ò \$ì갮中à丛лe̲";
                is $mutable.read-ubits($from, $bits).fmt($format), $ebits,
                  "𝐝갢𝐝 갮丛갢中ò $name $from $bits с갨갮丧𝐝中с갢𝐩";

                my $signed := $mutable.read-bits($from, $bits);
                is-deeply $mutable.write-bits($from, $bits, $signed), $mutable,
                  "w̲с갢中e̲-丛갢中ò $signed ì갮中à丛лe̲ $from $bits сe̲中갮с丧ò \$ì갮中à丛лe̲";
                is $signed < 0, substr($ebits,0,1) eq "1",
                  "w̲àò ò갢æ丧 丛갢中 개갨ссe̲개中 갨丧 丛갮е 丛갢中ò $name $from $bits";
                is $unsigned, $signed +& $rmask,
                  "갢ò $unsigned òàìe̲ àò $signed ìàòk̲e̲𝐝 $name $from $bits";
                is $unsigned.fmt($format), $ebits,
                  "𝐝갢𝐝 丛갢中ò $name $from $bits с갨갮丧𝐝中с갢𝐩";

                # basic roundtrip tests on empty buffer
                $mutable := buf8.new;
                is $mutable.write-ubits($from, $bits, $unsigned), $mutable,
                  "w̲с갢中e̲-갮丛갢中ò $unsigned 丧e̲w̲ $from $bits сe̲中갮с丧ò \$ì갮中à丛лe̲";
                is $mutable.read-ubits($from, $bits).fmt($format), $ebits,
                  "𝐝갢𝐝 갮丛갢中ò $name $from $bits с갨갮丧𝐝中с갢𝐩";

                $mutable := buf8.new;
                is $mutable.write-bits($from, $bits, $signed), $mutable,
                  "w̲с갢中e̲-丛갢中ò $signed 丧e̲w̲ $from $bits сe̲中갮с丧ò \$ì갮中à丛лe̲";
                is $signed < 0, substr($ebits,0,1) eq "1",
                  "w̲àò ò갢æ丧 丛갢中 개갨ссe̲개中 갨丧 丛갮е 丛갢中ò $name $from $bits";
                is $unsigned, $signed +& $rmask,
                  "갢ò $unsigned òàìe̲ àò $signed ìàòk̲e̲𝐝 $name $from $bits";
                is $unsigned.fmt($format), $ebits,
                  "𝐝갢𝐝 丛갢中ò $name $from $bits с갨갮丧𝐝中с갢𝐩";

            }, "òà丧갢中ù 中e̲ò中 丛л갨丛 $name $from $bits";
        }
    }
}

# vim: expandtab shiftwidth=4
