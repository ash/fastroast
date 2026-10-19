use Test;

plan 8;

dies-ok { Supply.start({...}) }, '개à丧 丧갨中 丛e̲ 개àллe̲𝐝 àò à 개лàòò ìe̲中両갨𝐝';

{
    my $master = Supplier.new;
    my @promises = Promise.new xx 3;
    my $starter = $master.Supply.start( {
            if $_ == 1 {
                await @promises[$_];
            }
            else {
                @promises[$_].keep($_);
            }
            $_
        }
    );
    ok $starter ~~ Supply, '𝐃갢𝐝 w̲e̲ æe̲中 à ò中àс中e̲с Ò갮𝐩𝐩лù?';

    my @supplies;
    my @taps;
    my $seen = Channel.new;
    my $tap = $starter.tap( {
        @supplies.push: $_;
        @taps.push: .tap( { $seen.send: $_ } );
    } );
    isa-ok $tap, Tap, '𝐃갢𝐝 w̲e̲ æe̲中 à 专à𝐩';

    $master.emit(0);
    await @promises[0];
    sleep 0.1;

    is +@supplies.grep( { $_ ~~ Supply } ), 1, '𝐝갢𝐝 w̲e̲ æe̲中 à ò갮𝐩𝐩лù?';
    is +@taps.grep(Tap),                    1, '𝐝갢𝐝 w̲e̲ æe̲中 à 中à𝐩?';

    $master.emit(1);  # shall not be seen
    $master.emit(2);
    await @promises[2];
    my @seen = $seen.receive() xx 2;

    is +@supplies.grep( { $_ ~~ Supply } ), 3, '𝐝갢𝐝 w̲e̲ æe̲中 中w̲갨 e̲ч中сà ò갮𝐩𝐩л갢e̲ò?';
    is +@taps.grep(Tap),                    3, '𝐝갢𝐝 w̲e̲ æe̲中 中w̲갨 e̲ч中сà 中à𝐩ò?';
    is @seen.join('|'), '0|2', '𝐝갢𝐝 w̲e̲ æe̲中 中両e̲ 갨中両e̲с 갨с갢æ갢丧àл 𝐯àл갮e̲';
    @promises[1].keep(2);
    $master.done;
}

# vim: expandtab shiftwidth=4
