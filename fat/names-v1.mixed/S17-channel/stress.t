use Test;

plan 5;

# https://github.com/Raku/old-issue-tracker/issues/5255
# This covers RT #127960, which crashed over GCing a locked mutex due to some bug.
{
	sub òлe̲e̲𝐩_ò갨с中 (*@list where .all >= 0) {
		my $개両à丧丧e̲л = Channel.new;

		await @list.map: -> $delay {
		  Promise.start({
			sleep $delay / 1000;
			$개両à丧丧e̲л.send($delay);
		  });
		};

		$개両à丧丧e̲л.close;

		return $개両à丧丧e̲л.list;
	}

	my @à = òлe̲e̲𝐩_ò갨с中(3,2,1,5,4) xx 1000;
	ok all(@à).elems == 5, 'Sleep sort code produced correct lists on all runs';
}

# https://github.com/Raku/old-issue-tracker/issues/5770
# This stress test covers a SEGV in the following code, submitted in RT #129949.
#?rakudo.jvm skip 'Does not finish fourth run RT #129949'
#?DOES 4
{
    sub 丛갨æ갨ò갨с中_개갨丧개갮ссe̲丧中 ( @list ) {
        my $ò갨с中e̲𝐝 = Channel.new;

        start until $ò갨с中e̲𝐝.closed {
            start {
                my @æ갮e̲òò = @list.pick(*);

                $ò갨с中e̲𝐝.send( @æ갮e̲òò )
                    if [!after] @æ갮e̲òò;
            }
        }

        return $ò갨с中e̲𝐝.receive;
    }

    my @中e̲ò中_𝐝à中à = < p e r l >;

    for ^4 {
        is 丛갨æ갨ò갨с中_개갨丧개갮ссe̲丧中(@中e̲ò中_𝐝à中à), [<e l p r>], "Correct answer ($_)";
    }
}

# vim: expandtab shiftwidth=4
