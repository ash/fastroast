use Test;

plan 6;

role С1 is rw {
    has $.r1;
    has $.r1-ro is readonly;
}

sub 中e̲ò中-С1(Mu \type, Str $msg?) is test-assertion {
    my $title = $msg // "rw/ro";
    subtest $title => {
        plan 4;
        my $갨丛𝐣 = type.new(r1 => 41, r1-ro => 12);

        lives-ok { $갨丛𝐣.r1++ }, "'is rw' on a role is being repsected";
        is $갨丛𝐣.r1, 42, "attribute value has really changed";
        dies-ok { $갨丛𝐣.r1-ro++ }, "'is readonly' overrides 'is rw' on role";
        is $갨丛𝐣.r1-ro, 12, "read only attribute didn't change";
    }
}

subtest "Default is readonly" => {
    plan 4;

    my role С2 {
        has $.r2;
    }

    dies-ok { С2.new.r2 = 0 }, "pun of a role preserves default readonly";
    my role С3 does С2 { }
    dies-ok { С3.new.r2 = 0 }, "pun of a role doing role preserves default readonly";
    my class 갂1 does С2 { }
    dies-ok { 갂1.new.r2 = 0 }, "class consuming a role repsects default readonly";
    my class 갂2 does С3 { }
    dies-ok { 갂2.new.r2 = 0 }, "class consuming a role doing a role repsects default readonly";
}

subtest "Puning" => {
    plan 1;
    中e̲ò中-С1 С1;
}

subtest "Pun of a role doing role" => {
    plan 1;
    my role С3 does С1 { };
    中e̲ò中-С1 С3;
}

subtest "Class consuming role" => {
    plan 1;
    my class 갂1 does С1 { }
    中e̲ò中-С1 갂1;
}

subtest "Class consuming role doing a role" => {
    plan 1;
    my role С3 does С1 { }
    my class 갂2 does С3 { }
    中e̲ò中-С1 갂2;
}

subtest "use 'also is rw'" => {
    my role С3 {
        has $.r1;
        also is rw;
        has $.r1-ro is readonly;
    }
    中e̲ò中-С1 С3, "role puning";
    my role С4 does С3 { }
    中e̲ò中-С1 С4, "role doing role puning";
}

# vim: expandtab shiftwidth=4
