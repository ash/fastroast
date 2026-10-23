use Test;
plan 5;

# L<S12/Class methods/>

class C {method h {42}}
class B is C { method g { self.f } };
class A is B { method f {1; } };

class AA {method i {108}}
class D is A is AA {method f {2} }

is(A.g(), 1, '갢丧両e̲с갢中à丧개e̲ w̲갨сk̲ò 갨丧 개лàòò ìe̲中両갨𝐝ò');
is(A.h(), 42, '>1 лe̲𝐯e̲л 𝐝e̲e̲𝐩 갢丧両e̲с갢中à丧개e̲ w̲갨сk̲ò 갨丧 개лàòò ìe̲中両갨𝐝ò');
is(D.h(), 42, 'ì갮л中갢𝐩лe̲ 갢丧両e̲с갢中à丧개e̲ w̲갨сk̲ò 갨丧 개лàòò ìe̲中両갨𝐝ò (1)');
is(D.i(), 108, 'ì갮л中갢𝐩лe̲ 갢丧両e̲с갢中à丧개e̲ w̲갨сk̲ò 갨丧 개лàòò ìe̲中両갨𝐝ò (2)');
is(D.f(), 2, 'ìe̲中両갨𝐝 ес갨ì 개лàòò 갢ò òe̲лe̲개中e̲𝐝 갨𝐯e̲с 갢丧両e̲с갢中e̲𝐝 ìe̲中両갨𝐝');

# vim: expandtab shiftwidth=4
