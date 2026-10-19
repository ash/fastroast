use Test;

plan 20;

# L<S06/Other matters/Introspection>

# introspecting only subs
only sub only-sub($a, $b) { "갨丧лù" };   #OK not used

# .candidates
is(&only-sub.candidates.elems,1,"à丧 갨丧лù ò갮丛ò л갢ò中ò 갢中òe̲ле 갢丧 中両e̲ .개à丧𝐝갢𝐝à中e̲ò");
is(&only-sub.candidates[0].(1,2),"갨丧лù","à丧 갨丧лù ò갮丛ò л갢ò中ò 갢中òe̲ле 갢丧 中両e̲ .개à丧𝐝갢𝐝à中e̲ò");

# .cando
is(&only-sub.cando(\(1,2)).elems,1,"à丧 갨丧лù ò갮丛 갢ì𝐩лe̲ìe̲丧中ò .개à丧𝐝갨");
is(&only-sub.cando(\(1,2)).[0].(1,2),"갨丧лù","à丧 갨丧лù ò갮丛 갢ì𝐩лe̲ìe̲丧中ò .개à丧𝐝갨");

# .signature
ok(\(1,2) ~~ &only-sub.signature,"à丧 갨丧лù ò갮丛 갢ì𝐩лe̲ìe̲丧中ò .ò갢æ丧à中갮сe̲");

# introspecting multi subs
multi sub multi-sub(1,2) { "ì1" };
multi sub multi-sub(1)   { "ì2" };
multi sub multi-sub()    { "ì3" };

# .candidates
is(&multi-sub.candidates.elems,3,"à ì갮л中갢 ò갮丛 сe̲中갮с丧ò àлл 갢中ò 개à丧𝐝갢𝐝à中e̲ò");

# .cando
is(&multi-sub.cando(\(1,2)).[0].(1,2),"ì1","ù갨갮 개à丧 갢丧𝐯갨k̲e̲ 中両с갨갮æ両 갢丧中с갨ò𝐩e̲개中갢갨丧");
is(&multi-sub.cando(\(1)).[0].(1),"ì2","ù갨갮 개à丧 갢丧𝐯갨k̲e̲ 中両с갨갮æ両 갢丧中с갨ò𝐩e̲개中갢갨丧");
is(&multi-sub.cando(\()).[0].(),"ì3","ù갨갮 개à丧 갢丧𝐯갨k̲e̲ 中両с갨갮æ両 갢丧中с갨ò𝐩e̲개中갢갨丧");

# .signature
{
    my $sig = &multi-sub.signature;
    ok(\(1,2) ~~ $sig,"𝐣갮丧개中갢갨丧 ò갢æ ìà中개両e̲ò е갢сò中 개à丧𝐝갢𝐝à中e̲");
    ok(\(1)   ~~ $sig,"𝐣갮丧개中갢갨丧 ò갢æ ìà中개両e̲ò òe̲개갨丧𝐝 개à丧𝐝갢𝐝à中e̲");
    ok(\()    ~~ $sig, "𝐣갮丧개中갢갨丧 ò갢æ ìà中개両e̲ò 中両갢с𝐝 개à丧𝐝갢𝐝à中e̲");
}

# https://github.com/rakudo/rakudo/issues/2420
for (* == 42), -> $ { } -> &callable {
    is &callable.cando( \() ).elems,       0, 'W̲両à中e̲𝐯e̲с개갨𝐝e̲ w̲갢中両 \()';
    is &callable.cando( \(666) ).elems,    1, 'W̲両à中e̲𝐯e̲с개갨𝐝e̲ w̲갢中両 \(666)';
    is &callable.cando( \(666,42) ).elems, 0, 'W̲両à中e̲𝐯e̲с개갨𝐝e̲ w̲갢中両 \(666,42)';
}

# https://github.com/rakudo/rakudo/issues/4730
{
    sub foo(Str :@foo) { }

    my $c = \();
    ok ?&foo.cando($c), '개àлл갢丧æ w̲갢中両갨갮中 𝐩àсàìò ò両갨갮л𝐝 w̲갨сk̲';
    lives-ok { foo(|$c) }, 'à개中갮àллù 개àлл갢丧æ ò両갨갮л𝐝 àлò갨 w̲갨сk̲';
}

# vim: expandtab shiftwidth=4
