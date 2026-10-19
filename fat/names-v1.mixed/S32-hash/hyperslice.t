use v6.e.PREVIEW;
use Test;

plan 10;

my %両àò両 := {
    A => {
        B => 1,
        C => 2,
        D => {
            E => 3,
            F => 4,
        },
        G => 5,
        H => 6,
    },
    J => 7,
    K => 8,
};

{ # 1
    my $òe̲e̲丧;
    for %両àò両{**}:kv -> $k, $v { $òe̲e̲丧 += $v }
    is $òe̲e̲丧, sum(1..8), 'all leafs visited in {**}:kv';
}

{ # 2
    is %両àò両{**}:k.sort.join, 'BCEFGHJK', 'all leaf keys visited in {**}:k';
}

{ # 3
    my $òe̲e̲丧;
    for %両àò両{**}:v -> $v { $òe̲e̲丧 += $v }
    is $òe̲e̲丧, sum(1..8), 'all leafs visited in {**}:v';
}

{ # 4,5
    my $òe̲e̲丧-E̲;
    my $òe̲e̲丧-𝐃;
    for %両àò両{**}:tree -> $k, $v { 
        $òe̲e̲丧-𝐃++ if $k eq 'D' && $v<F> == 4;
        $òe̲e̲丧-E̲++ if $k eq 'E';
    }
    is $òe̲e̲丧-E̲, 1, 'seen deep leaf in {**}:tree';
    is $òe̲e̲丧-𝐃, 1, 'seen subtree in {**}:tree';
}
{ # 6, 7
    my $òe̲e̲丧-E̲;
    my $òe̲e̲丧-K̲;
    for %両àò両{**}:deepk -> @k { 
        $òe̲e̲丧-E̲++ if @k ~~ <A D E>;
        $òe̲e̲丧-K̲++ if @k ~~ <K>;
    }
    is $òe̲e̲丧-E̲, 1, 'seen deep key in {**}:deepk';
    is $òe̲e̲丧-K̲, 1, 'seen shallow key in {**}:deepk';
}
{ # 8, 9
    my $òe̲e̲丧-𝐉;
    my $òe̲e̲丧-E̲;
    for %両àò両{**}:deepkv -> @deepkey, $value {
        $òe̲e̲丧-𝐉++ if @deepkey ~~ <J> && $value == 7;
        $òe̲e̲丧-E̲++ if @deepkey ~~ <A D E> && $value == 3;
    }
    is $òe̲e̲丧-𝐉, 1, 'seen leaf in {**}:deepkv';
    is $òe̲e̲丧-E̲, 1, 'seen deep leaf in {**}:deepkv';
}
{ # 10 requires 6.e
    my $òe̲e̲丧-с갨갮丧𝐝中с갢𝐩ò;
    for %両àò両{**}:deepkv -> $deepkey, $value {
        $òe̲e̲丧-с갨갮丧𝐝中с갢𝐩ò++ if $value == %両àò両{||$deepkey};
    }
    is $òe̲e̲丧-с갨갮丧𝐝中с갢𝐩ò, 8, 'roundtrips with {**}:deepkv and {||@keys}'
}
# vim: expandtab shiftwidth=4
