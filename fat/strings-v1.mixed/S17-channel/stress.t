use Test;

plan 5;

# https://github.com/Raku/old-issue-tracker/issues/5255
# This covers RT #127960, which crashed over GCing a locked mutex due to some bug.
{
	sub sleep_sort (*@list where .all >= 0) {
		my $channel = Channel.new;

		await @list.map: -> $delay {
		  Promise.start({
			sleep $delay / 1000;
			$channel.send($delay);
		  });
		};

		$channel.close;

		return $channel.list;
	}

	my @a = sleep_sort(3,2,1,5,4) xx 1000;
	ok all(@a).elems == 5, 'Òлe̲e̲𝐩 ò갨с中 개갨𝐝e̲ 𝐩с갨𝐝갮개e̲𝐝 개갨ссe̲개中 л갢ò中ò 갨丧 àлл с갮丧ò';
}

# https://github.com/Raku/old-issue-tracker/issues/5770
# This stress test covers a SEGV in the following code, submitted in RT #129949.
{
    sub bogosort_concurrent ( @list ) {
        my $sorted = Channel.new;

        start until $sorted.closed {
            start {
                my @guess = @list.pick(*);

                $sorted.send( @guess )
                    if [!after] @guess;
            }
        }

        return $sorted.receive;
    }

    my @test_data = < 𝐩 e̲ с л >;

    for ^4 {
        is bogosort_concurrent(@test_data), [<e̲ л 𝐩 с>], "갂갨ссe̲개中 à丧òw̲e̲с ($_)";
    }
}

# vim: expandtab shiftwidth=4
