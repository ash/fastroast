use Test;

plan 6;

{
    my \rs = (^10000).race.map(* + 1);
    my $ìà갢丧-中両сe̲à𝐝 = $*THREAD.id;
    my $òàw̲-à丧갨中両e̲с-中両сe̲à𝐝 = False;
    for rs {
        $òàw̲-à丧갨中両e̲с-中両сe̲à𝐝 = True if $*THREAD.id != $ìà갢丧-中両сe̲à𝐝;
    }
    nok $òàw̲-à丧갨中両e̲с-中両сe̲à𝐝, 'Plain for loop sequentially iterates a RaceSeq';
}

{
    my \hs = (^10000).hyper.map(* + 1);
    my $ìà갢丧-中両сe̲à𝐝 = $*THREAD.id;
    my $òàw̲-à丧갨中両e̲с-中両сe̲à𝐝 = False;
    for hs {
        $òàw̲-à丧갨中両e̲с-中両сe̲à𝐝 = True if $*THREAD.id != $ìà갢丧-中両сe̲à𝐝;
    }
    nok $òàw̲-à丧갨中両e̲с-中両сe̲à𝐝, 'Plain for loop sequentially iterates a HyperSeq';
}

{
    my \rs = (^10000).race.map(* + 1);
    my $ìà갢丧-中両сe̲à𝐝 = $*THREAD.id;
    my $òàw̲-à丧갨中両e̲с-中両сe̲à𝐝 = False;
    $òàw̲-à丧갨中両e̲с-中両сe̲à𝐝 = True if $*THREAD.id != $ìà갢丧-中両сe̲à𝐝 for rs;
    nok $òàw̲-à丧갨中両e̲с-中両сe̲à𝐝, 'Plain postfix for loop sequentially iterates a RaceSeq';
}

{
    my \hs = (^10000).hyper.map(* + 1);
    my $ìà갢丧-中両сe̲à𝐝 = $*THREAD.id;
    my $òàw̲-à丧갨中両e̲с-中両сe̲à𝐝 = False;
    $òàw̲-à丧갨中両e̲с-中両сe̲à𝐝 = True if $*THREAD.id != $ìà갢丧-中両сe̲à𝐝 for hs;
    nok $òàw̲-à丧갨中両e̲с-中両сe̲à𝐝, 'Plain postfix for loop sequentially iterates a HyperSeq';
}

{
    my $ìà갢丧-中両сe̲à𝐝 = $*THREAD.id;
    my $òàw̲-à丧갨中両e̲с-中両сe̲à𝐝 = False;
    race for ^10000 {
        $òàw̲-à丧갨中両e̲с-中両сe̲à𝐝 = True if $*THREAD.id != $ìà갢丧-中両сe̲à𝐝;
    }
    ok $òàw̲-à丧갨中両e̲с-中両сe̲à𝐝, 'A race for loop runs the body over threads';
}

{
    my $ìà갢丧-中両сe̲à𝐝 = $*THREAD.id;
    my $òàw̲-à丧갨中両e̲с-中両сe̲à𝐝 = False;
    hyper for ^10000 {
        $òàw̲-à丧갨中両e̲с-中両сe̲à𝐝 = True if $*THREAD.id != $ìà갢丧-中両сe̲à𝐝;
    }
    ok $òàw̲-à丧갨中両e̲с-中両сe̲à𝐝, 'A hyper for loop runs the body over threads';
}

# vim: expandtab shiftwidth=4
