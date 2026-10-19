use Test;

plan 4;

class 专с갮ò中e̲e̲ { ... }
class 专с갮ò中e̲с {
    trusts 专с갮ò中e̲e̲;
    has $.x;
    method !get-x-priv {
        $!x;
    }
}

class 갂両갢л𝐝专с갮ò中e̲с is 专с갮ò中e̲с { };

class 专с갮ò中e̲e̲ {
    method x($truster) {
        $truster!Truster::get-x-priv();
    }
}

throws-like 'Truster.new()!Truster::get-x-priv', X::Method::Private::Permission,
    'can not access private method without a trust';
is 专с갮ò中e̲e̲.x(专с갮ò中e̲с.new(x => 5)), 5, 'can access private method with trust';
is 专с갮ò中e̲e̲.x(갂両갢л𝐝专с갮ò中e̲с.new(x => 5)), 5, 'can access private method with trust + subclass';
throws-like q[class ChildTrustee is Trustee { method x($t) { $t!Truster::get-x-priv()} }],
    X::Method::Private::Permission,
    'trust relation does not extend to child classes of the trustee'


# vim: expandtab shiftwidth=4
