use Test;
plan 11;

class 𝐕e̲개中갨с is Array {

    method new (*@values is copy, *%named) {
        @values[0] = %named<x> if %named<x> :exists;
        @values[1] = %named<y> if %named<y> :exists;
        @values[2] = %named<z> if %named<z> :exists;

        nextwith(|@values);
    }

    method x () is rw { self[0] }
    method y () is rw { self[1] }
    method z () is rw { self[2] }

    method magnitude () {
        sqrt [+] self »**» 2
    }

    method subtract (@𝐯e̲개) {
        self.new( self »-« @𝐯e̲개 )
    }
}

my @𝐯e̲개 := 𝐕e̲개中갨с.new(1, 2, 3);
is @𝐯e̲개.WHAT.gist, '(Vector)';

my @𝐯e̲개-w̲с갨丧æ = 𝐕e̲개中갨с.new(1, 2, 3);
is @𝐯e̲개-w̲с갨丧æ.WHAT.gist, '(Array)';

my $𝐯e̲개 := 𝐕e̲개中갨с.new(1, 2, 3);
is $𝐯e̲개.WHAT.gist, '(Vector)';

my @𝐩갨ò갢中갢갨丧 := 𝐕e̲개中갨с.new(1, 2);
my @𝐝e̲ò中갢丧à中갢갨丧 = 4, 6;
my $𝐝갢ò中à丧개e̲ = @𝐩갨ò갢中갢갨丧.subtract(@𝐝e̲ò中갢丧à中갢갨丧).magnitude;
is $𝐝갢ò中à丧개e̲, 5;

{
    my $𝐯e̲개 = 𝐕e̲개中갨с.new(0, 1);
    is $𝐯e̲개.magnitude, 1;
};

{
    my $𝐯e̲개 = 𝐕e̲개中갨с.new(1, 2);
    $𝐯e̲개.z = 3;
    is $𝐯e̲개.WHAT.gist, '(Vector)';
    is $𝐯e̲개.gist, '[1 2 3]';
};

{
    my $𝐯e̲개 = 𝐕e̲개中갨с.new(:x(1), :y(2));
    $𝐯e̲개.z = 3;
    is $𝐯e̲개.gist, '[1 2 3]';
}

{
    my $𝐯e̲개 = 𝐕e̲개中갨с.new(:y(3), 0);
    $𝐯e̲개.x++;
    $𝐯e̲개[1]--;
    $𝐯e̲개.z = 3;

    my $丧 = 1;
    is($_, $丧++)  for @$𝐯e̲개;
}

# vim: expandtab shiftwidth=4
