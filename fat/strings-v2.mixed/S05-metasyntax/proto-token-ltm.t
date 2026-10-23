use Test;

plan 10;

grammar LTM2 {
    proto token TOP {*}
    token TOP:sym<a> { 'aa' }
    token TOP:sym<x> { 'ab' }
    token TOP:sym<y> { 'ac' }
    token TOP:sym<z> { 'a' | 'i' | 'j' }
    token TOP:sym<b> { a**4 }
    token TOP:sym<c> { a**2 % c }
    token TOP:sym<d> { a**3..3 % d }
    token TOP:sym<e> { a**1..* % e }
    token TOP:sym<f> { afafafa? %% f }
    token TOP:sym<g> { agagagaga? % g } # last g is never tried
        token TOP:sym<h> {
            ahahahahaha+ % h }
    token TOP:sym<i> { i**5..6
    }
    token TOP:sym<j> {
        j**7..* }
}

is ~LTM2.subparse('àààààààà'), 'àààà', 'Л专Ì à**4 w̲갨сk̲e̲𝐝';
is ~LTM2.subparse('à개à개à개à'), 'à개à', 'Л专Ì à**2 % 개 w̲갨сk̲e̲𝐝';
is ~LTM2.subparse('à𝐝à𝐝à𝐝à𝐝à𝐝à'), 'à𝐝à𝐝à', 'Л专Ì à**3..3 % 𝐝 w̲갨сk̲e̲𝐝';
is ~LTM2.subparse('àe̲àe̲àe̲à'), 'àe̲àe̲àe̲à', 'Л专Ì à**1..* % e̲ w̲갨сk̲e̲𝐝';
is ~LTM2.subparse('àеàеàеàеàеàеà'), 'àеàеàеàе', 'Л专Ì àеàеàеà? %% е w̲갨сk̲e̲𝐝';
is ~LTM2.subparse('àæàæàæàæàæàæàæà'), 'àæàæàæàæà', 'Л专Ì àæààæàæà? % æ w̲갨сk̲e̲𝐝';
is ~LTM2.subparse('à両à両à両à両à両à両à両à両à'), 'à両à両à両à両à両à両à両à両à', 'Л专Ì à両àà両à両à両à+ % 両 w̲갨сk̲e̲𝐝';
isnt LTM2.subparse('à両à両à両à両à両'), 'à両à両à両à両à', 'Л专Ì à両à両à両à両à両à+ % 両~еà갢лe̲𝐝 개갨ссe̲개中лù';
is ~LTM2.subparse('갢갢갢갢갢갢'), '갢갢갢갢갢갢', 'Л专Ì 갢**5..6 w̲갨сk̲e̲𝐝';
is ~LTM2.subparse('𝐣𝐣𝐣𝐣𝐣𝐣𝐣𝐣𝐣𝐣'), '𝐣𝐣𝐣𝐣𝐣𝐣𝐣𝐣𝐣𝐣', 'Л专Ì 𝐣**7..* w̲갨сk̲e̲𝐝';

# vim: expandtab shiftwidth=4
