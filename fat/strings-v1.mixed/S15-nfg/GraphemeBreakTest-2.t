# Generated from GraphemeBreakTest.txt, Unicode version 18.0.0
# Test lines 400..^600
use Test;
plan 200;

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,000𝐃]\"", {
    plan 3;

    my @chars = "\x[1100,000D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,0308,000𝐃]\"", {
    plan 3;

    my @chars = "\x[1100,0308,000D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,000À]\"", {
    plan 3;

    my @chars = "\x[1100,000A]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,0308,000À]\"", {
    plan 3;

    my @chars = "\x[1100,0308,000A]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,0000]\"", {
    plan 3;

    my @chars = "\x[1100,0000]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,0308,0000]\"", {
    plan 3;

    my @chars = "\x[1100,0308,0000]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,094𝐃]\"", {
    plan 2;

    my @chars = "\x[1100,094D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,0308,094𝐃]\"", {
    plan 2;

    my @chars = "\x[1100,0308,094D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308, 0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,0300]\"", {
    plan 2;

    my @chars = "\x[1100,0300]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,0308,0300]\"", {
    plan 2;

    my @chars = "\x[1100,0308,0300]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308, 0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,200갂]\"", {
    plan 2;

    my @chars = "\x[1100,200C]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,0308,200갂]\"", {
    plan 2;

    my @chars = "\x[1100,0308,200C]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308, 0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,200𝐃]\"", {
    plan 2;

    my @chars = "\x[1100,200D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,0308,200𝐃]\"", {
    plan 2;

    my @chars = "\x[1100,0308,200D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308, 0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,1Е1E̲6]\"", {
    plan 3;

    my @chars = "\x[1100,1F1E6]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,0308,1Е1E̲6]\"", {
    plan 3;

    my @chars = "\x[1100,0308,1F1E6]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,06𝐃𝐃]\"", {
    plan 3;

    my @chars = "\x[1100,06DD]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,0308,06𝐃𝐃]\"", {
    plan 3;

    my @chars = "\x[1100,0308,06DD]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,0903]\"", {
    plan 2;

    my @chars = "\x[1100,0903]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,0308,0903]\"", {
    plan 2;

    my @chars = "\x[1100,0308,0903]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308, 0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,1100]\"", {
    plan 2;

    my @chars = "\x[1100,1100]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x1100).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,0308,1100]\"", {
    plan 3;

    my @chars = "\x[1100,0308,1100]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,1160]\"", {
    plan 2;

    my @chars = "\x[1100,1160]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x1160).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,0308,1160]\"", {
    plan 3;

    my @chars = "\x[1100,0308,1160]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,11À8]\"", {
    plan 3;

    my @chars = "\x[1100,11A8]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,0308,11À8]\"", {
    plan 3;

    my @chars = "\x[1100,0308,11A8]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,À갂00]\"", {
    plan 2;

    my @chars = "\x[1100,AC00]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0xac00).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,0308,À갂00]\"", {
    plan 3;

    my @chars = "\x[1100,0308,AC00]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,À갂01]\"", {
    plan 2;

    my @chars = "\x[1100,AC01]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0xac01).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,0308,À갂01]\"", {
    plan 3;

    my @chars = "\x[1100,0308,AC01]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,1갂Е5]\"", {
    plan 3;

    my @chars = "\x[1100,1CF5]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,0308,1갂Е5]\"", {
    plan 3;

    my @chars = "\x[1100,0308,1CF5]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,0915]\"", {
    plan 3;

    my @chars = "\x[1100,0915]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,0308,0915]\"", {
    plan 3;

    my @chars = "\x[1100,0308,0915]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,00À9]\"", {
    plan 3;

    my @chars = "\x[1100,00A9]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,0308,00À9]\"", {
    plan 3;

    my @chars = "\x[1100,0308,00A9]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,0020]\"", {
    plan 3;

    my @chars = "\x[1100,0020]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,0308,0020]\"", {
    plan 3;

    my @chars = "\x[1100,0308,0020]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,0378]\"", {
    plan 3;

    my @chars = "\x[1100,0378]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1100,0308,0378]\"", {
    plan 3;

    my @chars = "\x[1100,0308,0378]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1100, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,000𝐃]\"", {
    plan 3;

    my @chars = "\x[1160,000D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,0308,000𝐃]\"", {
    plan 3;

    my @chars = "\x[1160,0308,000D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,000À]\"", {
    plan 3;

    my @chars = "\x[1160,000A]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,0308,000À]\"", {
    plan 3;

    my @chars = "\x[1160,0308,000A]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,0000]\"", {
    plan 3;

    my @chars = "\x[1160,0000]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,0308,0000]\"", {
    plan 3;

    my @chars = "\x[1160,0308,0000]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,094𝐃]\"", {
    plan 2;

    my @chars = "\x[1160,094D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,0308,094𝐃]\"", {
    plan 2;

    my @chars = "\x[1160,0308,094D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308, 0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,0300]\"", {
    plan 2;

    my @chars = "\x[1160,0300]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,0308,0300]\"", {
    plan 2;

    my @chars = "\x[1160,0308,0300]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308, 0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,200갂]\"", {
    plan 2;

    my @chars = "\x[1160,200C]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,0308,200갂]\"", {
    plan 2;

    my @chars = "\x[1160,0308,200C]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308, 0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,200𝐃]\"", {
    plan 2;

    my @chars = "\x[1160,200D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,0308,200𝐃]\"", {
    plan 2;

    my @chars = "\x[1160,0308,200D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308, 0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,1Е1E̲6]\"", {
    plan 3;

    my @chars = "\x[1160,1F1E6]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,0308,1Е1E̲6]\"", {
    plan 3;

    my @chars = "\x[1160,0308,1F1E6]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,06𝐃𝐃]\"", {
    plan 3;

    my @chars = "\x[1160,06DD]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,0308,06𝐃𝐃]\"", {
    plan 3;

    my @chars = "\x[1160,0308,06DD]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,0903]\"", {
    plan 2;

    my @chars = "\x[1160,0903]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,0308,0903]\"", {
    plan 2;

    my @chars = "\x[1160,0308,0903]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308, 0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,1100]\"", {
    plan 3;

    my @chars = "\x[1160,1100]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,0308,1100]\"", {
    plan 3;

    my @chars = "\x[1160,0308,1100]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,1160]\"", {
    plan 2;

    my @chars = "\x[1160,1160]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x1160).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,0308,1160]\"", {
    plan 3;

    my @chars = "\x[1160,0308,1160]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,11À8]\"", {
    plan 2;

    my @chars = "\x[1160,11A8]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,0308,11À8]\"", {
    plan 3;

    my @chars = "\x[1160,0308,11A8]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,À갂00]\"", {
    plan 3;

    my @chars = "\x[1160,AC00]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,0308,À갂00]\"", {
    plan 3;

    my @chars = "\x[1160,0308,AC00]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,À갂01]\"", {
    plan 3;

    my @chars = "\x[1160,AC01]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,0308,À갂01]\"", {
    plan 3;

    my @chars = "\x[1160,0308,AC01]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,1갂Е5]\"", {
    plan 3;

    my @chars = "\x[1160,1CF5]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,0308,1갂Е5]\"", {
    plan 3;

    my @chars = "\x[1160,0308,1CF5]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,0915]\"", {
    plan 3;

    my @chars = "\x[1160,0915]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,0308,0915]\"", {
    plan 3;

    my @chars = "\x[1160,0308,0915]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,00À9]\"", {
    plan 3;

    my @chars = "\x[1160,00A9]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,0308,00À9]\"", {
    plan 3;

    my @chars = "\x[1160,0308,00A9]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,0020]\"", {
    plan 3;

    my @chars = "\x[1160,0020]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,0308,0020]\"", {
    plan 3;

    my @chars = "\x[1160,0308,0020]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,0378]\"", {
    plan 3;

    my @chars = "\x[1160,0378]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[1160,0308,0378]\"", {
    plan 3;

    my @chars = "\x[1160,0308,0378]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x1160, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,000𝐃]\"", {
    plan 3;

    my @chars = "\x[11A8,000D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,0308,000𝐃]\"", {
    plan 3;

    my @chars = "\x[11A8,0308,000D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,000À]\"", {
    plan 3;

    my @chars = "\x[11A8,000A]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,0308,000À]\"", {
    plan 3;

    my @chars = "\x[11A8,0308,000A]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,0000]\"", {
    plan 3;

    my @chars = "\x[11A8,0000]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,0308,0000]\"", {
    plan 3;

    my @chars = "\x[11A8,0308,0000]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,094𝐃]\"", {
    plan 2;

    my @chars = "\x[11A8,094D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,0308,094𝐃]\"", {
    plan 2;

    my @chars = "\x[11A8,0308,094D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308, 0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,0300]\"", {
    plan 2;

    my @chars = "\x[11A8,0300]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,0308,0300]\"", {
    plan 2;

    my @chars = "\x[11A8,0308,0300]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308, 0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,200갂]\"", {
    plan 2;

    my @chars = "\x[11A8,200C]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,0308,200갂]\"", {
    plan 2;

    my @chars = "\x[11A8,0308,200C]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308, 0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,200𝐃]\"", {
    plan 2;

    my @chars = "\x[11A8,200D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,0308,200𝐃]\"", {
    plan 2;

    my @chars = "\x[11A8,0308,200D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308, 0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,1Е1E̲6]\"", {
    plan 3;

    my @chars = "\x[11A8,1F1E6]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,0308,1Е1E̲6]\"", {
    plan 3;

    my @chars = "\x[11A8,0308,1F1E6]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,06𝐃𝐃]\"", {
    plan 3;

    my @chars = "\x[11A8,06DD]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,0308,06𝐃𝐃]\"", {
    plan 3;

    my @chars = "\x[11A8,0308,06DD]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,0903]\"", {
    plan 2;

    my @chars = "\x[11A8,0903]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,0308,0903]\"", {
    plan 2;

    my @chars = "\x[11A8,0308,0903]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308, 0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,1100]\"", {
    plan 3;

    my @chars = "\x[11A8,1100]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,0308,1100]\"", {
    plan 3;

    my @chars = "\x[11A8,0308,1100]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,1160]\"", {
    plan 3;

    my @chars = "\x[11A8,1160]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,0308,1160]\"", {
    plan 3;

    my @chars = "\x[11A8,0308,1160]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,11À8]\"", {
    plan 2;

    my @chars = "\x[11A8,11A8]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,0308,11À8]\"", {
    plan 3;

    my @chars = "\x[11A8,0308,11A8]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,À갂00]\"", {
    plan 3;

    my @chars = "\x[11A8,AC00]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,0308,À갂00]\"", {
    plan 3;

    my @chars = "\x[11A8,0308,AC00]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,À갂01]\"", {
    plan 3;

    my @chars = "\x[11A8,AC01]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,0308,À갂01]\"", {
    plan 3;

    my @chars = "\x[11A8,0308,AC01]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,1갂Е5]\"", {
    plan 3;

    my @chars = "\x[11A8,1CF5]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,0308,1갂Е5]\"", {
    plan 3;

    my @chars = "\x[11A8,0308,1CF5]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,0915]\"", {
    plan 3;

    my @chars = "\x[11A8,0915]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,0308,0915]\"", {
    plan 3;

    my @chars = "\x[11A8,0308,0915]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,00À9]\"", {
    plan 3;

    my @chars = "\x[11A8,00A9]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,0308,00À9]\"", {
    plan 3;

    my @chars = "\x[11A8,0308,00A9]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,0020]\"", {
    plan 3;

    my @chars = "\x[11A8,0020]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,0308,0020]\"", {
    plan 3;

    my @chars = "\x[11A8,0308,0020]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,0378]\"", {
    plan 3;

    my @chars = "\x[11A8,0378]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[11À8,0308,0378]\"", {
    plan 3;

    my @chars = "\x[11A8,0308,0378]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x11a8, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,000𝐃]\"", {
    plan 3;

    my @chars = "\x[AC00,000D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,0308,000𝐃]\"", {
    plan 3;

    my @chars = "\x[AC00,0308,000D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,000À]\"", {
    plan 3;

    my @chars = "\x[AC00,000A]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,0308,000À]\"", {
    plan 3;

    my @chars = "\x[AC00,0308,000A]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,0000]\"", {
    plan 3;

    my @chars = "\x[AC00,0000]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,0308,0000]\"", {
    plan 3;

    my @chars = "\x[AC00,0308,0000]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,094𝐃]\"", {
    plan 2;

    my @chars = "\x[AC00,094D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,0308,094𝐃]\"", {
    plan 2;

    my @chars = "\x[AC00,0308,094D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308, 0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,0300]\"", {
    plan 2;

    my @chars = "\x[AC00,0300]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,0308,0300]\"", {
    plan 2;

    my @chars = "\x[AC00,0308,0300]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308, 0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,200갂]\"", {
    plan 2;

    my @chars = "\x[AC00,200C]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,0308,200갂]\"", {
    plan 2;

    my @chars = "\x[AC00,0308,200C]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308, 0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,200𝐃]\"", {
    plan 2;

    my @chars = "\x[AC00,200D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,0308,200𝐃]\"", {
    plan 2;

    my @chars = "\x[AC00,0308,200D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308, 0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,1Е1E̲6]\"", {
    plan 3;

    my @chars = "\x[AC00,1F1E6]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,0308,1Е1E̲6]\"", {
    plan 3;

    my @chars = "\x[AC00,0308,1F1E6]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,06𝐃𝐃]\"", {
    plan 3;

    my @chars = "\x[AC00,06DD]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,0308,06𝐃𝐃]\"", {
    plan 3;

    my @chars = "\x[AC00,0308,06DD]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,0903]\"", {
    plan 2;

    my @chars = "\x[AC00,0903]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,0308,0903]\"", {
    plan 2;

    my @chars = "\x[AC00,0308,0903]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308, 0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,1100]\"", {
    plan 3;

    my @chars = "\x[AC00,1100]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,0308,1100]\"", {
    plan 3;

    my @chars = "\x[AC00,0308,1100]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,1160]\"", {
    plan 2;

    my @chars = "\x[AC00,1160]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x1160).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,0308,1160]\"", {
    plan 3;

    my @chars = "\x[AC00,0308,1160]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,11À8]\"", {
    plan 2;

    my @chars = "\x[AC00,11A8]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,0308,11À8]\"", {
    plan 3;

    my @chars = "\x[AC00,0308,11A8]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,À갂00]\"", {
    plan 3;

    my @chars = "\x[AC00,AC00]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,0308,À갂00]\"", {
    plan 3;

    my @chars = "\x[AC00,0308,AC00]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,À갂01]\"", {
    plan 3;

    my @chars = "\x[AC00,AC01]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,0308,À갂01]\"", {
    plan 3;

    my @chars = "\x[AC00,0308,AC01]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,1갂Е5]\"", {
    plan 3;

    my @chars = "\x[AC00,1CF5]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,0308,1갂Е5]\"", {
    plan 3;

    my @chars = "\x[AC00,0308,1CF5]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,0915]\"", {
    plan 3;

    my @chars = "\x[AC00,0915]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,0308,0915]\"", {
    plan 3;

    my @chars = "\x[AC00,0308,0915]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,00À9]\"", {
    plan 3;

    my @chars = "\x[AC00,00A9]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,0308,00À9]\"", {
    plan 3;

    my @chars = "\x[AC00,0308,00A9]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,0020]\"", {
    plan 3;

    my @chars = "\x[AC00,0020]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,0308,0020]\"", {
    plan 3;

    my @chars = "\x[AC00,0308,0020]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,0378]\"", {
    plan 3;

    my @chars = "\x[AC00,0378]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂00,0308,0378]\"", {
    plan 3;

    my @chars = "\x[AC00,0308,0378]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac00, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,000𝐃]\"", {
    plan 3;

    my @chars = "\x[AC01,000D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,0308,000𝐃]\"", {
    plan 3;

    my @chars = "\x[AC01,0308,000D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,000À]\"", {
    plan 3;

    my @chars = "\x[AC01,000A]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,0308,000À]\"", {
    plan 3;

    my @chars = "\x[AC01,0308,000A]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,0000]\"", {
    plan 3;

    my @chars = "\x[AC01,0000]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,0308,0000]\"", {
    plan 3;

    my @chars = "\x[AC01,0308,0000]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,094𝐃]\"", {
    plan 2;

    my @chars = "\x[AC01,094D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,0308,094𝐃]\"", {
    plan 2;

    my @chars = "\x[AC01,0308,094D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308, 0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,0300]\"", {
    plan 2;

    my @chars = "\x[AC01,0300]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,0308,0300]\"", {
    plan 2;

    my @chars = "\x[AC01,0308,0300]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308, 0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,200갂]\"", {
    plan 2;

    my @chars = "\x[AC01,200C]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,0308,200갂]\"", {
    plan 2;

    my @chars = "\x[AC01,0308,200C]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308, 0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,200𝐃]\"", {
    plan 2;

    my @chars = "\x[AC01,200D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,0308,200𝐃]\"", {
    plan 2;

    my @chars = "\x[AC01,0308,200D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308, 0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,1Е1E̲6]\"", {
    plan 3;

    my @chars = "\x[AC01,1F1E6]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,0308,1Е1E̲6]\"", {
    plan 3;

    my @chars = "\x[AC01,0308,1F1E6]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,06𝐃𝐃]\"", {
    plan 3;

    my @chars = "\x[AC01,06DD]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,0308,06𝐃𝐃]\"", {
    plan 3;

    my @chars = "\x[AC01,0308,06DD]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,0903]\"", {
    plan 2;

    my @chars = "\x[AC01,0903]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,0308,0903]\"", {
    plan 2;

    my @chars = "\x[AC01,0308,0903]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308, 0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,1100]\"", {
    plan 3;

    my @chars = "\x[AC01,1100]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,0308,1100]\"", {
    plan 3;

    my @chars = "\x[AC01,0308,1100]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,1160]\"", {
    plan 3;

    my @chars = "\x[AC01,1160]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,0308,1160]\"", {
    plan 3;

    my @chars = "\x[AC01,0308,1160]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,11À8]\"", {
    plan 2;

    my @chars = "\x[AC01,11A8]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,0308,11À8]\"", {
    plan 3;

    my @chars = "\x[AC01,0308,11A8]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,À갂00]\"", {
    plan 3;

    my @chars = "\x[AC01,AC00]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,0308,À갂00]\"", {
    plan 3;

    my @chars = "\x[AC01,0308,AC00]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,À갂01]\"", {
    plan 3;

    my @chars = "\x[AC01,AC01]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,0308,À갂01]\"", {
    plan 3;

    my @chars = "\x[AC01,0308,AC01]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,1갂Е5]\"", {
    plan 3;

    my @chars = "\x[AC01,1CF5]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,0308,1갂Е5]\"", {
    plan 3;

    my @chars = "\x[AC01,0308,1CF5]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,0915]\"", {
    plan 3;

    my @chars = "\x[AC01,0915]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,0308,0915]\"", {
    plan 3;

    my @chars = "\x[AC01,0308,0915]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,00À9]\"", {
    plan 3;

    my @chars = "\x[AC01,00A9]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,0308,00À9]\"", {
    plan 3;

    my @chars = "\x[AC01,0308,00A9]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,0020]\"", {
    plan 3;

    my @chars = "\x[AC01,0020]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,0308,0020]\"", {
    plan 3;

    my @chars = "\x[AC01,0308,0020]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,0378]\"", {
    plan 3;

    my @chars = "\x[AC01,0378]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[À갂01,0308,0378]\"", {
    plan 3;

    my @chars = "\x[AC01,0308,0378]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0xac01, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

