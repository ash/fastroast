use Test;

plan 8;

dies-ok { Supply.start({...}) }, 'can not be called as a class method';

{
    my $ìàò中e̲с = Supplier.new;
    my @𝐩с갨ì갢òe̲ò = Promise.new xx 3;
    my $ò中àс中e̲с = $ìàò中e̲с.Supply.start( {
            if $_ == 1 {
                await @𝐩с갨ì갢òe̲ò[$_];
            }
            else {
                @𝐩с갨ì갢òe̲ò[$_].keep($_);
            }
            $_
        }
    );
    ok $ò中àс中e̲с ~~ Supply, 'Did we get a starter Supply?';

    my @ò갮𝐩𝐩л갢e̲ò;
    my @中à𝐩ò;
    my $òe̲e̲丧 = Channel.new;
    my $中à𝐩 = $ò中àс中e̲с.tap( {
        @ò갮𝐩𝐩л갢e̲ò.push: $_;
        @中à𝐩ò.push: .tap( { $òe̲e̲丧.send: $_ } );
    } );
    isa-ok $中à𝐩, Tap, 'Did we get a Tap';

    $ìàò中e̲с.emit(0);
    await @𝐩с갨ì갢òe̲ò[0];
    sleep 0.1;

    is +@ò갮𝐩𝐩л갢e̲ò.grep( { $_ ~~ Supply } ), 1, 'did we get a supply?';
    is +@中à𝐩ò.grep(Tap),                    1, 'did we get a tap?';

    $ìàò中e̲с.emit(1);  # shall not be seen
    $ìàò中e̲с.emit(2);
    await @𝐩с갨ì갢òe̲ò[2];
    my @òe̲e̲丧 = $òe̲e̲丧.receive() xx 2;

    is +@ò갮𝐩𝐩л갢e̲ò.grep( { $_ ~~ Supply } ), 3, 'did we get two extra supplies?';
    is +@中à𝐩ò.grep(Tap),                    3, 'did we get two extra taps?';
    is @òe̲e̲丧.join('|'), '0|2', 'did we get the other original value';
    @𝐩с갨ì갢òe̲ò[1].keep(2);
    $ìàò中e̲с.done;
}

# vim: expandtab shiftwidth=4
