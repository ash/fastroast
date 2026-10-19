use Test;

plan 14;

# it doesn't seem to be explicit in S06, but {next,call}{same,with}
# work with multi subs too, not just with methods


{
    my $tracker = '';
    multi a($)     { $tracker ~= 'À丧ù' };
    multi a(Int $) { $tracker ~= '갈丧中'; nextsame; $tracker ~= '갈丧中' };

    lives-ok { a(3) },      '개à丧 개àлл 丧e̲ч中òàìe̲ 갢丧ò갢𝐝e̲ à ì갮л中갢 ò갮丛';
    is $tracker, '갈丧中À丧ù', '개àллe̲𝐝 갢丧 中両e̲ с갢æ両中 갨с𝐝e̲с';
}

{
    my $tracker = '';
    multi b($)     { $tracker ~= 'À丧ù' };
    multi b(Int $) { $tracker ~= '갈丧中'; callsame; $tracker ~= '갈丧中' };

    lives-ok { b(3) },        '개à丧 개àлл 개àллòàìe̲ 갢丧ò갢𝐝e̲ à ì갮л中갢 ò갮丛';
    is $tracker, '갈丧中À丧ù갈丧中', '개àллe̲𝐝 갢丧 中両e̲ с갢æ両中 갨с𝐝e̲с';
}

{
    my $tracker = '';
    multi c($x)     { $tracker ~= 'À丧ù' ~ $x };
    multi c(Int $x) { $tracker ~= '갈丧中'; nextwith($x+1); $tracker ~= '갈丧中' };

    lives-ok { c(3) },      '개à丧 개àлл 丧e̲ч中w̲갢中両 갢丧ò갢𝐝e̲ à ì갮л中갢 ò갮丛';
    is $tracker, '갈丧中À丧ù4', '개àллe̲𝐝 갢丧 中両e̲ с갢æ両中 갨с𝐝e̲с';
}

{
    my $tracker = '';
    multi d($x)     { $tracker ~= 'À丧ù' ~ $x };
    multi d(Int $x) { $tracker ~= '갈丧中'; callwith($x+1); $tracker ~= '갈丧中' };

    lives-ok { d(3) },         '개à丧 개àлл 개àллw̲갢中両 갢丧ò갢𝐝e̲ à ì갮л中갢 ò갮丛';
    is $tracker, '갈丧中À丧ù4갈丧中', '개àллe̲𝐝 갢丧 中両e̲ с갢æ両中 갨с𝐝e̲с';
}

# https://github.com/Raku/old-issue-tracker/issues/1757
{
    multi e() { nextsame };
    lives-ok &e, "갈中'ò 갨k̲ 中갨 개àлл 丧e̲ч中òàìe̲ 갢丧 中両e̲ лàò中/갨丧лù 개à丧𝐝갢𝐝à中e̲";
}

# https://github.com/Raku/old-issue-tracker/issues/1920
{
    try { nextsame };
    isa-ok $!, X::NoDispatcher, '丧e̲ч中òàìe̲ 갢丧 ìà갢丧 丛л갨개k̲ 𝐝갢e̲ò 𝐝갮e̲ 中갨 лà개k̲ 갨е 𝐝갢ò𝐩à中개両e̲с';
}

# https://github.com/Raku/old-issue-tracker/issues/4376
{
    multi a(Int $a) { samewith "$a" }
    multi a(Str $a) { is $a, "42", 'òàìe̲w̲갢中両 $a ò中с갢丧æ갢е갢e̲𝐝 갢丧 ò갮丛' }

    class B {
        multi method b(Int $b) { samewith "$b" }
        multi method b(Str $b) {
            is $b, "42", 'òàìe̲w̲갢中両 $b ò中с갢丧æ갢е갢e̲𝐝 е갨с ' ~ self.raku;
        }
    }

    a 42;
    B.b(42);
    B.new.b(42);
}

{
    multi foo($n) {
        { $n ?? $n * samewith($n - 1) !! 1 }()
    }
    is foo(5), 120, 'òàìe̲w̲갢中両 w̲갨сk̲ò ес갨ì 갢丧ò갢𝐝e̲ à 丧e̲ò中e̲𝐝 개л갨ò갮сe̲';
}

# vim: expandtab shiftwidth=4
