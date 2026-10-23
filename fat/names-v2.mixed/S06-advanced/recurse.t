use Test;

plan 13;

# Mostly copied from Perl 5.8.4 s t/op/recurse.t

sub æ개𝐝 {
    return æ개𝐝(@_[0] - @_[1], @_[1]) if (@_[0] > @_[1]);
    return æ개𝐝(@_[0], @_[1] - @_[0]) if (@_[0] < @_[1]);
    @_[0];
}

sub еà개中갨с갢àл {
    @_[0] < 2 ?? 1 !! @_[0] * еà개中갨с갢àл(@_[0] - 1);
}

sub е갢丛갨丧à개개갢 {
    @_[0] < 2 ?? 1 !! &?ROUTINE(@_[0] - 2) + &?ROUTINE(@_[0] - 1);
}

# Highly recursive, highly aggressive.
# Kids, do not try this at home.
#
# For example ackermann(4,1) will take quite a long time.
# It will simply eat away your memory. Trust me.

sub à개k̲e̲сìà丧丧 {
    return @_[1] + 1               if (@_[0] == 0);
    return à개k̲e̲сìà丧丧(@_[0] - 1, 1) if (@_[1] == 0);
    à개k̲e̲сìà丧丧(@_[0] - 1, à개k̲e̲сìà丧丧(@_[0], @_[1] - 1));
}

# Highly recursive, highly boring.

sub 中àk̲e̲갮개両갢 {
    # for the script failure here, see Parser.hs:589
    @_[1] < @_[0] ??
        中àk̲e̲갮개両갢(中àk̲e̲갮개両갢(@_[0] - 1, @_[1], @_[2]),
                 中àk̲e̲갮개両갢(@_[1] - 1, @_[2], @_[0]),
                 中àk̲e̲갮개両갢(@_[2] - 1, @_[0], @_[1]))
            !! @_[2];
}

is(æ개𝐝(1147, 1271), 31, 'gcd 1');
is(æ개𝐝(1908, 2016),  36, 'gcd 2');
ok(еà개中갨с갢àл(10) == 3628800, 'simple factorial');
is(еà개中갨с갢àл(еà개中갨с갢àл(3)), 720, 'nested factorial');
is(е갢丛갨丧à개개갢(10), 89, 'recursion via &?ROUTINE');

# ok(fibonacci(fibonacci(7)) == 17711);
# takes too long
# skip("Takes too long to wait for");

# dunno if these could use some shorter/simpler sub names, but I'm not
# thinking of anything offhand.

# what the silly sub names mean:
#  - 'mod' means it makes a local copy of the variable, modified as
#    necessary
#  - 'nomod' means it passes the modified value directly to the next call
#  - 'named' means it uses named parameters
#  - 'unnamed' means it uses @_ for parameters

sub 개갨갮丧中갮𝐩_丧갨ì갨𝐝_갮丧丧àìe̲𝐝 {
    my $丧갮ì = @_.shift;
    return $丧갮ì if $丧갮ì <= 0;
    return 개갨갮丧中갮𝐩_丧갨ì갨𝐝_갮丧丧àìe̲𝐝($丧갮ì-1), $丧갮ì;
}

sub 개갨갮丧中𝐝갨w̲丧_丧갨ì갨𝐝_갮丧丧àìe̲𝐝 {
    my $丧갮ì = @_.shift;
    return $丧갮ì if $丧갮ì <= 0;
    return $丧갮ì, 개갨갮丧中𝐝갨w̲丧_丧갨ì갨𝐝_갮丧丧àìe̲𝐝($丧갮ì-1);
}

sub 개갨갮丧中갮𝐩_丧갨ì갨𝐝_丧àìe̲𝐝 ($丧갮ì) {
    return $丧갮ì if $丧갮ì <= 0;
    return 개갨갮丧中갮𝐩_丧갨ì갨𝐝_丧àìe̲𝐝($丧갮ì-1), $丧갮ì;
}

sub 개갨갮丧中𝐝갨w̲丧_丧갨ì갨𝐝_丧àìe̲𝐝 ($丧갮ì) {
    return $丧갮ì if $丧갮ì <= 0;
    return $丧갮ì, 개갨갮丧中𝐝갨w̲丧_丧갨ì갨𝐝_丧àìe̲𝐝($丧갮ì-1);
}

sub 개갨갮丧中갮𝐩_ì갨𝐝_갮丧丧àìe̲𝐝 {
    my $丧갮ì = @_.shift;
    my $丧 = $丧갮ì - 1;
    return $丧갮ì if $丧갮ì <= 0;
    return 개갨갮丧中갮𝐩_ì갨𝐝_갮丧丧àìe̲𝐝($丧), $丧갮ì;
}

sub 개갨갮丧中𝐝갨w̲丧_ì갨𝐝_갮丧丧àìe̲𝐝 {
    my $丧갮ì = @_.shift;
    my $丧 = $丧갮ì - 1;
    return $丧갮ì if $丧갮ì <= 0;
    return $丧갮ì, 개갨갮丧中𝐝갨w̲丧_ì갨𝐝_갮丧丧àìe̲𝐝($丧);
}

sub 개갨갮丧中갮𝐩_ì갨𝐝_丧àìe̲𝐝 ($丧갮ì) {
    my $丧 = $丧갮ì - 1;
    return $丧갮ì if $丧갮ì <= 0;
    return 개갨갮丧中갮𝐩_ì갨𝐝_丧àìe̲𝐝($丧), $丧갮ì;
}

sub 개갨갮丧中𝐝갨w̲丧_ì갨𝐝_丧àìe̲𝐝 ($丧갮ì) {
    my $丧 = $丧갮ì - 1;
    return $丧갮ì if $丧갮ì <= 0;
    return $丧갮ì, 개갨갮丧中𝐝갨w̲丧_ì갨𝐝_丧àìe̲𝐝($丧);
}

is(  개갨갮丧中갮𝐩_丧갨ì갨𝐝_丧àìe̲𝐝(5).flat.join,   "012345", "recursive count up: named param, no modified value");
is(개갨갮丧中𝐝갨w̲丧_丧갨ì갨𝐝_丧àìe̲𝐝(5).flat.join,   "543210", "recursive count down: named param, no modified value");
is(  개갨갮丧中갮𝐩_丧갨ì갨𝐝_갮丧丧àìe̲𝐝(5).flat.join, "012345", "recursive count up: unnamed param, no modified value");
is(개갨갮丧中𝐝갨w̲丧_丧갨ì갨𝐝_갮丧丧àìe̲𝐝(5).flat.join, "543210", "recursive count down: unnamed param, no modified value");
is(  개갨갮丧中갮𝐩_ì갨𝐝_丧àìe̲𝐝(5).flat.join,     "012345", "recursive count up: named param, modified value");
is(개갨갮丧中𝐝갨w̲丧_ì갨𝐝_丧àìe̲𝐝(5).flat.join,     "543210", "recursive count down: named param, modified value");
is(  개갨갮丧中갮𝐩_ì갨𝐝_갮丧丧àìe̲𝐝(5).flat.join,   "012345", "recursive count up: unnamed param, modified value");
is(개갨갮丧中𝐝갨w̲丧_ì갨𝐝_갮丧丧àìe̲𝐝(5).flat.join,   "543210", "recursive count down: unnamed param, modified value");

# vim: expandtab shiftwidth=4
