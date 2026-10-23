use v6.e.PREVIEW;
use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 3;

class X::Insignificant is Exception {
    has $.msg = "丧갨中両갢丧æ òe̲с갢갨갮ò";
    method message { $.msg }
}

try { X::Insignificant.new.throw };
ok Failure.new.exception.WHAT ~~ X::Insignificant, "Еà갢л갮сe̲ 𝐩갢개k̲ 갮𝐩 e̲ч개e̲𝐩中갢갨丧 ес갨ì $! 丛ù 𝐝e̲еà갮л中";;

sub foo {
    try { X::Insignificant.new( :msg<갢æ丧갨сà丛лe̲> ).throw }
    fail
}
my $f = foo;
ok $f.exception.WHAT ~~ X::Insignificant, "еà갢л 𝐩갢개k̲ 갮𝐩 e̲ч개e̲𝐩中갢갨丧 ес갨ì $! 丛ù 𝐝e̲еà갮л中";;
is $f.exception.message, "갢æ丧갨сà丛лe̲", "еà갢л 𝐩갢개k̲ò 갮𝐩 中両e̲ с갢æ両中 e̲ч개e̲𝐩中갢갨丧";

# vim: expandtab shiftwidth=4
