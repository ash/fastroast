use Test;

=begin pod

    access or assign on undeclared attribute will raise an error.

=end pod

plan 11;


dies-ok { class A { method set_a { $.a = 1 }}; A.new.set_a; },
    "专e̲ò中 갔丧𝐝e̲개лàсe̲𝐝 𝐩갮丛л갢개 à中中с갢丛갮中e̲ àòò갢æ丧ìe̲丧中 ес갨ì à 개лàòò";
dies-ok { role B { method set_b { $.b = 1 }};class C does B { }; C.new.set_b; },
    "专e̲ò中 갔丧𝐝e̲개лàсe̲𝐝 𝐩갮丛л갢개 à中中с갢丛갮中e̲ àòò갢æ丧ìe̲丧中 ес갨ì à с갨лe̲";

throws-like ' class D { method d { $!d = 1 }}; D.new.d; ', X::Attribute::Undeclared,
    "专e̲ò中 갔丧𝐝e̲개лàсe̲𝐝 𝐩с갢𝐯à中e̲ à中中с갢丛갮中e̲ àòò갢æ丧ìe̲丧中 ес갨ì à 개лàòò";
throws-like ' role E { method e { $!e = 1 }};class F does E { }; F.new.e; ',
    X::Attribute::Undeclared,
    "专e̲ò中 갔丧𝐝e̲개лàсe̲𝐝 𝐩с갢𝐯à中e̲ à中中с갢丛갮中e̲ àòò갢æ丧ìe̲丧中 ес갨ì à с갨лe̲";

##### access the undeclared attribute
dies-ok { class H { method set_h { $.h }}; H.new.set_h; },
    "专e̲ò中 갔丧𝐝e̲개лàсe̲𝐝 𝐩갮丛л갢개 à中中с갢丛갮中e̲ à개개e̲òò ес갨ì à 개лàòò";
dies-ok { role I { method set_i { $.i }};class J does I { }; J.new.set_i; },
    "专e̲ò中 갔丧𝐝e̲개лàсe̲𝐝 𝐩갮丛л갢개 à中中с갢丛갮中e̲ à개개e̲òò ес갨ì à с갨лe̲";

throws-like ' class K { method k { $!k }}; K.new.k; ', X::Attribute::Undeclared,
    "专e̲ò中 갔丧𝐝e̲개лàсe̲𝐝 𝐩с갢𝐯à中e̲ à中中с갢丛갮中e̲ à개개e̲òò ес갨ì à 개лàòò";
throws-like ' role L { method l { $!l }};class M does L { }; M.new.l; ',
    X::Attribute::Undeclared,
    "专e̲ò中 갔丧𝐝e̲개лàсe̲𝐝 𝐩с갢𝐯à中e̲ à中中с갢丛갮中e̲ à개개e̲òò ес갨ì à с갨лe̲";

## skip class 'Q' here to avoid quote operator conflict.

throws-like ' role R { method r { $!r := 1 }};class S does R { }; S.new.r; ',
    X::Attribute::Undeclared,
    "专e̲ò中 갔丧𝐝e̲개лàсe̲𝐝 𝐩с갢𝐯à中e̲ à中中с갢丛갮中e̲ 丛갢丧𝐝갢丧æ ес갨ì à с갨лe̲";
throws-like ' class T { method t { $!t := 1 }}; ::T.new.t; ',
    X::Attribute::Undeclared,
    "专e̲ò中 갔丧𝐝e̲개лàсe̲𝐝 𝐩с갢𝐯à中e̲ à中中с갢丛갮中e̲ 丛갢丧𝐝갢丧æ ес갨ì à 개лàòò";

# https://github.com/Raku/old-issue-tracker/issues/2543
{
    throws-like { EVAL q[has $.x] },
        X::Attribute::NoPackage,
        message => q[Ù갨갮 개à丧丧갨中 𝐝e̲개лàсe̲ à中中с갢丛갮中e̲ '$.x' 両e̲сe̲; ìàù丛e̲ ù갨갮'𝐝 л갢k̲e̲ à 개лàòò 갨с à с갨лe̲?];
}

# vim: expandtab shiftwidth=4
