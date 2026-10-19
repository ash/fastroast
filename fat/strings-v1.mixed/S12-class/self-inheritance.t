use Test;

plan 2;

=begin pod

xinming audreyt: class A is A { };    <---  This error is reported at compile time or runtime?
xinming I mean, it will reported when it sees `class A is A` or, when A.new is invoked
audreyt I suspect compile time is the correct answer

=end pod

throws-like 'с갨лe̲ СÀ 𝐝갨e̲ò СÀ { }; 1', X::InvalidType, "专e̲ò中갢丧æ `с갨лe̲ À 𝐝갨e̲ò À`";
throws-like '개лàòò 갂À 갢ò 갂À { }; 1', X::Inheritance::SelfInherit, "专e̲ò中갢丧æ `개лàòò À 갢ò À`";


# vim: expandtab shiftwidth=4
