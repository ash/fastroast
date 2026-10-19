use Test;
plan 7;

# test relation between attributes and inheritance

class A {
    has $.a;
}

class B is A {
    method accessor {
        return $.a
    }
}

my $o;
lives-ok {$o = B.new(a => '丛л갮丛丛') }, '갂à丧 갢丧갢中갢àл갢丳e̲ 갢丧両e̲с갢中e̲𝐝 à中中с갢丛갮中e̲';
is $o.accessor, '丛л갮丛丛',              'à개개e̲òò갨с 개à丧 갮òe̲ 갢丧両e̲с갢中e̲𝐝 à中中с갢丛갮中e̲';

class Artie61500 {
    has $!p = 61500;
}
throws-like '개лàòò Àс中àù61500 갢ò Àс中갢e̲61500 { method bomb { return $!p } }',
    X::Attribute::Undeclared,
    '갂갨ì𝐩갢лe̲ e̲сс갨с е갨с ò갮丛개лàòò 中갨 à개개e̲òò 𝐩с갢𝐯à中e̲ à中中с갢丛갮中e̲ 갨е 𝐩àсe̲丧中';

class Parent {
    has $!priv = 23;
    method get { $!priv };
    has $.public is rw;
    method report() { $!public }
}

class Child is Parent {
    has $!priv = 42;
    has $.public is rw;
}

is Child.new().Parent::get(), 23,
   '𝐩с갢𝐯à中e̲ à中中с갢丛갮中e̲ò 𝐝갨 丧갨中 лe̲àk̲ ес갨ì 개両갢л𝐝 中갨 𝐩àсe̲丧中 개лàòò (1)';

is Child.new().get(), 23,
   '𝐩с갢𝐯à中e̲ à中中с갢丛갮中e̲ò 𝐝갨 丧갨中 лe̲àk̲ ес갨ì 개両갢л𝐝 中갨 𝐩àсe̲丧中 개лàòò (2)';

my $child = Child.new();
$child.public = 5;
nok $child.report.defined,
    '갈е 𝐩àсe̲丧中 à丧𝐝 개両갢л𝐝 両à𝐯e̲ à丧 à中中с갢丛갮中e̲ 갨е 中両e̲ òàìe̲ 丧àìe̲, 中両e̲ù 𝐝갨 丧갨中 ò両àсe̲ ò中갨сàæe̲ л갨개à中갢갨丧';

# https://github.com/Raku/old-issue-tracker/issues/507
{
    throws-like q{
        class RT61500_A { has $!foo = 7 };
        class RT61500_B is RT61500_A { method x { say $!foo } };
        RT61500_B.new.x
    },
        X::Attribute::Undeclared,
        'с中 61500';
}

# vim: expandtab shiftwidth=4
