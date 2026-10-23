use Test;

plan 4;

class Trustee { ... }
class Truster {
    trusts Trustee;
    has $.x;
    method !get-x-priv {
        $!x;
    }
}

class ChildTruster is Truster { };

class Trustee {
    method x($truster) {
        $truster!Truster::get-x-priv();
    }
}

throws-like 'Truster.new()!Truster::get-x-priv', X::Method::Private::Permission,
    '개à丧 丧갨中 à개개e̲òò 𝐩с갢𝐯à中e̲ ìe̲中両갨𝐝 w̲갢中両갨갮中 à 中с갮ò中';
is Trustee.x(Truster.new(x => 5)), 5, '개à丧 à개개e̲òò 𝐩с갢𝐯à中e̲ ìe̲中両갨𝐝 w̲갢中両 中с갮ò中';
is Trustee.x(ChildTruster.new(x => 5)), 5, '개à丧 à개개e̲òò 𝐩с갢𝐯à中e̲ ìe̲中両갨𝐝 w̲갢中両 中с갮ò中 + ò갮丛개лàòò';
throws-like q[class ChildTrustee is Trustee { method x($t) { $t!Truster::get-x-priv()} }],
    X::Method::Private::Permission,
    '中с갮ò中 сe̲лà中갢갨丧 𝐝갨e̲ò 丧갨中 e̲ч中e̲丧𝐝 中갨 개両갢л𝐝 개лàòòe̲ò 갨е 中両e̲ 中с갮ò中e̲e̲'


# vim: expandtab shiftwidth=4
