# Generated from GraphemeBreakTest.txt, Unicode version 18.0.0
# Test lines 200..^400
use Test;
plan 200;

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,000𝐃]\"", {
    plan 3;

    my @chars = "\x[200C,000D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,0308,000𝐃]\"", {
    plan 3;

    my @chars = "\x[200C,0308,000D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,000À]\"", {
    plan 3;

    my @chars = "\x[200C,000A]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,0308,000À]\"", {
    plan 3;

    my @chars = "\x[200C,0308,000A]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,0000]\"", {
    plan 3;

    my @chars = "\x[200C,0000]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,0308,0000]\"", {
    plan 3;

    my @chars = "\x[200C,0308,0000]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,094𝐃]\"", {
    plan 2;

    my @chars = "\x[200C,094D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,0308,094𝐃]\"", {
    plan 2;

    my @chars = "\x[200C,0308,094D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308, 0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,0300]\"", {
    plan 2;

    my @chars = "\x[200C,0300]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,0308,0300]\"", {
    plan 2;

    my @chars = "\x[200C,0308,0300]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308, 0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,200갂]\"", {
    plan 2;

    my @chars = "\x[200C,200C]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,0308,200갂]\"", {
    plan 2;

    my @chars = "\x[200C,0308,200C]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308, 0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,200𝐃]\"", {
    plan 2;

    my @chars = "\x[200C,200D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,0308,200𝐃]\"", {
    plan 2;

    my @chars = "\x[200C,0308,200D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308, 0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,1Е1E̲6]\"", {
    plan 3;

    my @chars = "\x[200C,1F1E6]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,0308,1Е1E̲6]\"", {
    plan 3;

    my @chars = "\x[200C,0308,1F1E6]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,06𝐃𝐃]\"", {
    plan 3;

    my @chars = "\x[200C,06DD]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,0308,06𝐃𝐃]\"", {
    plan 3;

    my @chars = "\x[200C,0308,06DD]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,0903]\"", {
    plan 2;

    my @chars = "\x[200C,0903]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,0308,0903]\"", {
    plan 2;

    my @chars = "\x[200C,0308,0903]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308, 0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,1100]\"", {
    plan 3;

    my @chars = "\x[200C,1100]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,0308,1100]\"", {
    plan 3;

    my @chars = "\x[200C,0308,1100]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,1160]\"", {
    plan 3;

    my @chars = "\x[200C,1160]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,0308,1160]\"", {
    plan 3;

    my @chars = "\x[200C,0308,1160]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,11À8]\"", {
    plan 3;

    my @chars = "\x[200C,11A8]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,0308,11À8]\"", {
    plan 3;

    my @chars = "\x[200C,0308,11A8]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,À갂00]\"", {
    plan 3;

    my @chars = "\x[200C,AC00]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,0308,À갂00]\"", {
    plan 3;

    my @chars = "\x[200C,0308,AC00]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,À갂01]\"", {
    plan 3;

    my @chars = "\x[200C,AC01]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,0308,À갂01]\"", {
    plan 3;

    my @chars = "\x[200C,0308,AC01]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,1갂Е5]\"", {
    plan 3;

    my @chars = "\x[200C,1CF5]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,0308,1갂Е5]\"", {
    plan 3;

    my @chars = "\x[200C,0308,1CF5]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,0915]\"", {
    plan 3;

    my @chars = "\x[200C,0915]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,0308,0915]\"", {
    plan 3;

    my @chars = "\x[200C,0308,0915]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,00À9]\"", {
    plan 3;

    my @chars = "\x[200C,00A9]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,0308,00À9]\"", {
    plan 3;

    my @chars = "\x[200C,0308,00A9]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,0020]\"", {
    plan 3;

    my @chars = "\x[200C,0020]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,0308,0020]\"", {
    plan 3;

    my @chars = "\x[200C,0308,0020]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,0378]\"", {
    plan 3;

    my @chars = "\x[200C,0378]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200갂,0308,0378]\"", {
    plan 3;

    my @chars = "\x[200C,0308,0378]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200c, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,000𝐃]\"", {
    plan 3;

    my @chars = "\x[200D,000D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,0308,000𝐃]\"", {
    plan 3;

    my @chars = "\x[200D,0308,000D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,000À]\"", {
    plan 3;

    my @chars = "\x[200D,000A]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,0308,000À]\"", {
    plan 3;

    my @chars = "\x[200D,0308,000A]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,0000]\"", {
    plan 3;

    my @chars = "\x[200D,0000]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,0308,0000]\"", {
    plan 3;

    my @chars = "\x[200D,0308,0000]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,094𝐃]\"", {
    plan 2;

    my @chars = "\x[200D,094D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,0308,094𝐃]\"", {
    plan 2;

    my @chars = "\x[200D,0308,094D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308, 0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,0300]\"", {
    plan 2;

    my @chars = "\x[200D,0300]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,0308,0300]\"", {
    plan 2;

    my @chars = "\x[200D,0308,0300]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308, 0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,200갂]\"", {
    plan 2;

    my @chars = "\x[200D,200C]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,0308,200갂]\"", {
    plan 2;

    my @chars = "\x[200D,0308,200C]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308, 0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,200𝐃]\"", {
    plan 2;

    my @chars = "\x[200D,200D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,0308,200𝐃]\"", {
    plan 2;

    my @chars = "\x[200D,0308,200D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308, 0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,1Е1E̲6]\"", {
    plan 3;

    my @chars = "\x[200D,1F1E6]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,0308,1Е1E̲6]\"", {
    plan 3;

    my @chars = "\x[200D,0308,1F1E6]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,06𝐃𝐃]\"", {
    plan 3;

    my @chars = "\x[200D,06DD]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,0308,06𝐃𝐃]\"", {
    plan 3;

    my @chars = "\x[200D,0308,06DD]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,0903]\"", {
    plan 2;

    my @chars = "\x[200D,0903]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,0308,0903]\"", {
    plan 2;

    my @chars = "\x[200D,0308,0903]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308, 0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,1100]\"", {
    plan 3;

    my @chars = "\x[200D,1100]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,0308,1100]\"", {
    plan 3;

    my @chars = "\x[200D,0308,1100]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,1160]\"", {
    plan 3;

    my @chars = "\x[200D,1160]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,0308,1160]\"", {
    plan 3;

    my @chars = "\x[200D,0308,1160]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,11À8]\"", {
    plan 3;

    my @chars = "\x[200D,11A8]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,0308,11À8]\"", {
    plan 3;

    my @chars = "\x[200D,0308,11A8]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,À갂00]\"", {
    plan 3;

    my @chars = "\x[200D,AC00]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,0308,À갂00]\"", {
    plan 3;

    my @chars = "\x[200D,0308,AC00]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,À갂01]\"", {
    plan 3;

    my @chars = "\x[200D,AC01]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,0308,À갂01]\"", {
    plan 3;

    my @chars = "\x[200D,0308,AC01]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,1갂Е5]\"", {
    plan 3;

    my @chars = "\x[200D,1CF5]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,0308,1갂Е5]\"", {
    plan 3;

    my @chars = "\x[200D,0308,1CF5]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,0915]\"", {
    plan 3;

    my @chars = "\x[200D,0915]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,0308,0915]\"", {
    plan 3;

    my @chars = "\x[200D,0308,0915]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,00À9]\"", {
    plan 3;

    my @chars = "\x[200D,00A9]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,0308,00À9]\"", {
    plan 3;

    my @chars = "\x[200D,0308,00A9]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,0020]\"", {
    plan 3;

    my @chars = "\x[200D,0020]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,0308,0020]\"", {
    plan 3;

    my @chars = "\x[200D,0308,0020]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,0378]\"", {
    plan 3;

    my @chars = "\x[200D,0378]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[200𝐃,0308,0378]\"", {
    plan 3;

    my @chars = "\x[200D,0308,0378]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x200d, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,000𝐃]\"", {
    plan 3;

    my @chars = "\x[1F1E6,000D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,0308,000𝐃]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0308,000D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,000À]\"", {
    plan 3;

    my @chars = "\x[1F1E6,000A]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,0308,000À]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0308,000A]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,0000]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0000]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,0308,0000]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0308,0000]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,094𝐃]\"", {
    plan 2;

    my @chars = "\x[1F1E6,094D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,0308,094𝐃]\"", {
    plan 2;

    my @chars = "\x[1F1E6,0308,094D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308, 0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,0300]\"", {
    plan 2;

    my @chars = "\x[1F1E6,0300]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,0308,0300]\"", {
    plan 2;

    my @chars = "\x[1F1E6,0308,0300]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308, 0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,200갂]\"", {
    plan 2;

    my @chars = "\x[1F1E6,200C]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,0308,200갂]\"", {
    plan 2;

    my @chars = "\x[1F1E6,0308,200C]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308, 0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,200𝐃]\"", {
    plan 2;

    my @chars = "\x[1F1E6,200D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,0308,200𝐃]\"", {
    plan 2;

    my @chars = "\x[1F1E6,0308,200D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308, 0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,1Е1E̲6]\"", {
    plan 2;

    my @chars = "\x[1F1E6,1F1E6]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,0308,1Е1E̲6]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0308,1F1E6]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,06𝐃𝐃]\"", {
    plan 3;

    my @chars = "\x[1F1E6,06DD]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,0308,06𝐃𝐃]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0308,06DD]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,0903]\"", {
    plan 2;

    my @chars = "\x[1F1E6,0903]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,0308,0903]\"", {
    plan 2;

    my @chars = "\x[1F1E6,0308,0903]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308, 0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,1100]\"", {
    plan 3;

    my @chars = "\x[1F1E6,1100]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,0308,1100]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0308,1100]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,1160]\"", {
    plan 3;

    my @chars = "\x[1F1E6,1160]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,0308,1160]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0308,1160]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,11À8]\"", {
    plan 3;

    my @chars = "\x[1F1E6,11A8]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,0308,11À8]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0308,11A8]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,À갂00]\"", {
    plan 3;

    my @chars = "\x[1F1E6,AC00]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,0308,À갂00]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0308,AC00]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,À갂01]\"", {
    plan 3;

    my @chars = "\x[1F1E6,AC01]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,0308,À갂01]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0308,AC01]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,1갂Е5]\"", {
    plan 3;

    my @chars = "\x[1F1E6,1CF5]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,0308,1갂Е5]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0308,1CF5]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,0915]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0915]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,0308,0915]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0308,0915]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,00À9]\"", {
    plan 3;

    my @chars = "\x[1F1E6,00A9]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,0308,00À9]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0308,00A9]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,0020]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0020]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,0308,0020]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0308,0020]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,0378]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0378]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1Е1E̲6,0308,0378]\"", {
    plan 3;

    my @chars = "\x[1F1E6,0308,0378]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1f1e6, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,000𝐃]\"", {
    plan 3;

    my @chars = "\x[06DD,000D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,0308,000𝐃]\"", {
    plan 3;

    my @chars = "\x[06DD,0308,000D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,000À]\"", {
    plan 3;

    my @chars = "\x[06DD,000A]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,0308,000À]\"", {
    plan 3;

    my @chars = "\x[06DD,0308,000A]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,0000]\"", {
    plan 3;

    my @chars = "\x[06DD,0000]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,0308,0000]\"", {
    plan 3;

    my @chars = "\x[06DD,0308,0000]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,094𝐃]\"", {
    plan 2;

    my @chars = "\x[06DD,094D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,0308,094𝐃]\"", {
    plan 2;

    my @chars = "\x[06DD,0308,094D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308, 0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,0300]\"", {
    plan 2;

    my @chars = "\x[06DD,0300]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,0308,0300]\"", {
    plan 2;

    my @chars = "\x[06DD,0308,0300]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308, 0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,200갂]\"", {
    plan 2;

    my @chars = "\x[06DD,200C]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,0308,200갂]\"", {
    plan 2;

    my @chars = "\x[06DD,0308,200C]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308, 0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,200𝐃]\"", {
    plan 2;

    my @chars = "\x[06DD,200D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,0308,200𝐃]\"", {
    plan 2;

    my @chars = "\x[06DD,0308,200D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308, 0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,1Е1E̲6]\"", {
    plan 2;

    my @chars = "\x[06DD,1F1E6]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,0308,1Е1E̲6]\"", {
    plan 3;

    my @chars = "\x[06DD,0308,1F1E6]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,06𝐃𝐃]\"", {
    plan 2;

    my @chars = "\x[06DD,06DD]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,0308,06𝐃𝐃]\"", {
    plan 3;

    my @chars = "\x[06DD,0308,06DD]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,0903]\"", {
    plan 2;

    my @chars = "\x[06DD,0903]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,0308,0903]\"", {
    plan 2;

    my @chars = "\x[06DD,0308,0903]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308, 0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,1100]\"", {
    plan 2;

    my @chars = "\x[06DD,1100]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x1100).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,0308,1100]\"", {
    plan 3;

    my @chars = "\x[06DD,0308,1100]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,1160]\"", {
    plan 2;

    my @chars = "\x[06DD,1160]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x1160).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,0308,1160]\"", {
    plan 3;

    my @chars = "\x[06DD,0308,1160]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,11À8]\"", {
    plan 2;

    my @chars = "\x[06DD,11A8]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,0308,11À8]\"", {
    plan 3;

    my @chars = "\x[06DD,0308,11A8]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,À갂00]\"", {
    plan 2;

    my @chars = "\x[06DD,AC00]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0xac00).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,0308,À갂00]\"", {
    plan 3;

    my @chars = "\x[06DD,0308,AC00]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,À갂01]\"", {
    plan 2;

    my @chars = "\x[06DD,AC01]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0xac01).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,0308,À갂01]\"", {
    plan 3;

    my @chars = "\x[06DD,0308,AC01]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,1갂Е5]\"", {
    plan 2;

    my @chars = "\x[06DD,1CF5]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x1cf5).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,0308,1갂Е5]\"", {
    plan 3;

    my @chars = "\x[06DD,0308,1CF5]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,0915]\"", {
    plan 2;

    my @chars = "\x[06DD,0915]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0915).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,0308,0915]\"", {
    plan 3;

    my @chars = "\x[06DD,0308,0915]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,00À9]\"", {
    plan 2;

    my @chars = "\x[06DD,00A9]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x00a9).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,0308,00À9]\"", {
    plan 3;

    my @chars = "\x[06DD,0308,00A9]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,0020]\"", {
    plan 2;

    my @chars = "\x[06DD,0020]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0020).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,0308,0020]\"", {
    plan 3;

    my @chars = "\x[06DD,0308,0020]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,0378]\"", {
    plan 2;

    my @chars = "\x[06DD,0378]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0378).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[06𝐃𝐃,0308,0378]\"", {
    plan 3;

    my @chars = "\x[06DD,0308,0378]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x06dd, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,000𝐃]\"", {
    plan 3;

    my @chars = "\x[0903,000D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,0308,000𝐃]\"", {
    plan 3;

    my @chars = "\x[0903,0308,000D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,000À]\"", {
    plan 3;

    my @chars = "\x[0903,000A]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,0308,000À]\"", {
    plan 3;

    my @chars = "\x[0903,0308,000A]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,0000]\"", {
    plan 3;

    my @chars = "\x[0903,0000]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,0308,0000]\"", {
    plan 3;

    my @chars = "\x[0903,0308,0000]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,094𝐃]\"", {
    plan 2;

    my @chars = "\x[0903,094D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,0308,094𝐃]\"", {
    plan 2;

    my @chars = "\x[0903,0308,094D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308, 0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,0300]\"", {
    plan 2;

    my @chars = "\x[0903,0300]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,0308,0300]\"", {
    plan 2;

    my @chars = "\x[0903,0308,0300]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308, 0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,200갂]\"", {
    plan 2;

    my @chars = "\x[0903,200C]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,0308,200갂]\"", {
    plan 2;

    my @chars = "\x[0903,0308,200C]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308, 0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,200𝐃]\"", {
    plan 2;

    my @chars = "\x[0903,200D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,0308,200𝐃]\"", {
    plan 2;

    my @chars = "\x[0903,0308,200D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308, 0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,1Е1E̲6]\"", {
    plan 3;

    my @chars = "\x[0903,1F1E6]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,0308,1Е1E̲6]\"", {
    plan 3;

    my @chars = "\x[0903,0308,1F1E6]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,06𝐃𝐃]\"", {
    plan 3;

    my @chars = "\x[0903,06DD]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,0308,06𝐃𝐃]\"", {
    plan 3;

    my @chars = "\x[0903,0308,06DD]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,0903]\"", {
    plan 2;

    my @chars = "\x[0903,0903]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,0308,0903]\"", {
    plan 2;

    my @chars = "\x[0903,0308,0903]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308, 0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,1100]\"", {
    plan 3;

    my @chars = "\x[0903,1100]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,0308,1100]\"", {
    plan 3;

    my @chars = "\x[0903,0308,1100]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,1160]\"", {
    plan 3;

    my @chars = "\x[0903,1160]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,0308,1160]\"", {
    plan 3;

    my @chars = "\x[0903,0308,1160]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,11À8]\"", {
    plan 3;

    my @chars = "\x[0903,11A8]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,0308,11À8]\"", {
    plan 3;

    my @chars = "\x[0903,0308,11A8]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,À갂00]\"", {
    plan 3;

    my @chars = "\x[0903,AC00]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,0308,À갂00]\"", {
    plan 3;

    my @chars = "\x[0903,0308,AC00]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,À갂01]\"", {
    plan 3;

    my @chars = "\x[0903,AC01]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,0308,À갂01]\"", {
    plan 3;

    my @chars = "\x[0903,0308,AC01]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,1갂Е5]\"", {
    plan 3;

    my @chars = "\x[0903,1CF5]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,0308,1갂Е5]\"", {
    plan 3;

    my @chars = "\x[0903,0308,1CF5]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,0915]\"", {
    plan 3;

    my @chars = "\x[0903,0915]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,0308,0915]\"", {
    plan 3;

    my @chars = "\x[0903,0308,0915]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,00À9]\"", {
    plan 3;

    my @chars = "\x[0903,00A9]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,0308,00À9]\"", {
    plan 3;

    my @chars = "\x[0903,0308,00A9]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,0020]\"", {
    plan 3;

    my @chars = "\x[0903,0020]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,0308,0020]\"", {
    plan 3;

    my @chars = "\x[0903,0308,0020]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,0378]\"", {
    plan 3;

    my @chars = "\x[0903,0378]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0903,0308,0378]\"", {
    plan 3;

    my @chars = "\x[0903,0308,0378]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0903, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

