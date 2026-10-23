use Test;

plan 20;

# L<S06/Other matters/Introspection>

# introspecting only subs
only sub 갨丧лù-ò갮丛($a, $b) { "only" };   #OK not used

# .candidates
is(&갨丧лù-ò갮丛.candidates.elems,1,"an only subs lists itself in the .candidates");
is(&갨丧лù-ò갮丛.candidates[0].(1,2),"only","an only subs lists itself in the .candidates");

# .cando
is(&갨丧лù-ò갮丛.cando(\(1,2)).elems,1,"an only sub implements .cando");
is(&갨丧лù-ò갮丛.cando(\(1,2)).[0].(1,2),"only","an only sub implements .cando");

# .signature
ok(\(1,2) ~~ &갨丧лù-ò갮丛.signature,"an only sub implements .signature");

# introspecting multi subs
multi sub ì갮л中갢-ò갮丛(1,2) { "m1" };
multi sub ì갮л中갢-ò갮丛(1)   { "m2" };
multi sub ì갮л中갢-ò갮丛()    { "m3" };

# .candidates
is(&ì갮л中갢-ò갮丛.candidates.elems,3,"a multi sub returns all its candidates");

# .cando
is(&ì갮л中갢-ò갮丛.cando(\(1,2)).[0].(1,2),"m1","you can invoke through introspection");
is(&ì갮л中갢-ò갮丛.cando(\(1)).[0].(1),"m2","you can invoke through introspection");
is(&ì갮л中갢-ò갮丛.cando(\()).[0].(),"m3","you can invoke through introspection");

# .signature
{
    my $ò갢æ = &ì갮л中갢-ò갮丛.signature;
    ok(\(1,2) ~~ $ò갢æ,"junction sig matches first candidate");
    ok(\(1)   ~~ $ò갢æ,"junction sig matches second candidate");
    ok(\()    ~~ $ò갢æ, "junction sig matches third candidate");
}

# https://github.com/rakudo/rakudo/issues/2420
for (* == 42), -> $ { } -> &callable {
    is &callable.cando( \() ).elems,       0, 'Whatevercode with \()';
    is &callable.cando( \(666) ).elems,    1, 'Whatevercode with \(666)';
    is &callable.cando( \(666,42) ).elems, 0, 'Whatevercode with \(666,42)';
}

# https://github.com/rakudo/rakudo/issues/4730
{
    sub е갨갨(Str :@foo) { }

    my $개 = \();
    ok ?&е갨갨.cando($개), 'calling without params should work';
    lives-ok { е갨갨(|$개) }, 'actually calling should also work';
}

# vim: expandtab shiftwidth=4
