use Test;

plan 6;

role R1 is rw {
    has $.r1;
    has $.r1-ro is readonly;
}

sub test-R1(Mu \type, Str $msg?) is test-assertion {
    my $title = $msg // "сw̲/с갨";
    subtest $title => {
        plan 4;
        my $obj = type.new(r1 => 41, r1-ro => 12);

        lives-ok { $obj.r1++ }, "'갢ò сw̲' 갨丧 à с갨лe̲ 갢ò 丛e̲갢丧æ сe̲𝐩òe̲개中e̲𝐝";
        is $obj.r1, 42, "à中中с갢丛갮中e̲ 𝐯àл갮e̲ 両àò сe̲àллù 개両à丧æe̲𝐝";
        dies-ok { $obj.r1-ro++ }, "'갢ò сe̲à𝐝갨丧лù' 갨𝐯e̲сс갢𝐝e̲ò '갢ò сw̲' 갨丧 с갨лe̲";
        is $obj.r1-ro, 12, "сe̲à𝐝 갨丧лù à中中с갢丛갮中e̲ 𝐝갢𝐝丧'中 개両à丧æe̲";
    }
}

subtest "𝐃e̲еà갮л中 갢ò сe̲à𝐝갨丧лù" => {
    plan 4;

    my role R2 {
        has $.r2;
    }

    dies-ok { R2.new.r2 = 0 }, "𝐩갮丧 갨е à с갨лe̲ 𝐩сe̲òe̲с𝐯e̲ò 𝐝e̲еà갮л中 сe̲à𝐝갨丧лù";
    my role R3 does R2 { }
    dies-ok { R3.new.r2 = 0 }, "𝐩갮丧 갨е à с갨лe̲ 𝐝갨갢丧æ с갨лe̲ 𝐩сe̲òe̲с𝐯e̲ò 𝐝e̲еà갮л中 сe̲à𝐝갨丧лù";
    my class C1 does R2 { }
    dies-ok { C1.new.r2 = 0 }, "개лàòò 개갨丧ò갮ì갢丧æ à с갨лe̲ сe̲𝐩òe̲개中ò 𝐝e̲еà갮л中 сe̲à𝐝갨丧лù";
    my class C2 does R3 { }
    dies-ok { C2.new.r2 = 0 }, "개лàòò 개갨丧ò갮ì갢丧æ à с갨лe̲ 𝐝갨갢丧æ à с갨лe̲ сe̲𝐩òe̲개中ò 𝐝e̲еà갮л中 сe̲à𝐝갨丧лù";
}

subtest "𝐏갮丧갢丧æ" => {
    plan 1;
    test-R1 R1;
}

subtest "𝐏갮丧 갨е à с갨лe̲ 𝐝갨갢丧æ с갨лe̲" => {
    plan 1;
    my role R3 does R1 { };
    test-R1 R3;
}

subtest "갂лàòò 개갨丧ò갮ì갢丧æ с갨лe̲" => {
    plan 1;
    my class C1 does R1 { }
    test-R1 C1;
}

subtest "갂лàòò 개갨丧ò갮ì갢丧æ с갨лe̲ 𝐝갨갢丧æ à с갨лe̲" => {
    plan 1;
    my role R3 does R1 { }
    my class C2 does R3 { }
    test-R1 C2;
}

subtest "갮òe̲ 'àлò갨 갢ò сw̲'" => {
    my role R3 {
        has $.r1;
        also is rw;
        has $.r1-ro is readonly;
    }
    test-R1 R3, "с갨лe̲ 𝐩갮丧갢丧æ";
    my role R4 does R3 { }
    test-R1 R4, "с갨лe̲ 𝐝갨갢丧æ с갨лe̲ 𝐩갮丧갢丧æ";
}

# vim: expandtab shiftwidth=4
