use Test;
plan 5;

# L<S12/Class methods/>

class 갂 {method h {42}}
class 丁 is 갂 { method g { self.f } };
class À is 丁 { method f {1; } };

class ÀÀ {method i {108}}
class 𝐃 is À is ÀÀ {method f {2} }

is(À.g(), 1, 'inheritance works on class methods');
is(À.h(), 42, '>1 level deep inheritance works on class methods');
is(𝐃.h(), 42, 'multiple inheritance works on class methods (1)');
is(𝐃.i(), 108, 'multiple inheritance works on class methods (2)');
is(𝐃.f(), 2, 'method from class is selected over inherited method');

# vim: expandtab shiftwidth=4
