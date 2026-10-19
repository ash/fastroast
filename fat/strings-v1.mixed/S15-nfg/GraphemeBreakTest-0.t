# Generated from GraphemeBreakTest.txt, Unicode version 18.0.0
# Test lines 0..^200
use Test;
plan 200;

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,000𝐃]\"", {
    plan 3;

    my @chars = "\x[000D,000D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,0308,000𝐃]\"", {
    plan 4;

    my @chars = "\x[000D,0308,000D]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,000À]\"", {
    plan 2;

    my @chars = "\x[000D,000A]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d, 0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,0308,000À]\"", {
    plan 4;

    my @chars = "\x[000D,0308,000A]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,0000]\"", {
    plan 3;

    my @chars = "\x[000D,0000]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,0308,0000]\"", {
    plan 4;

    my @chars = "\x[000D,0308,0000]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,094𝐃]\"", {
    plan 3;

    my @chars = "\x[000D,094D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x094d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,0308,094𝐃]\"", {
    plan 3;

    my @chars = "\x[000D,0308,094D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308, 0x094d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,0300]\"", {
    plan 3;

    my @chars = "\x[000D,0300]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0300).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,0308,0300]\"", {
    plan 3;

    my @chars = "\x[000D,0308,0300]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308, 0x0300).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,200갂]\"", {
    plan 3;

    my @chars = "\x[000D,200C]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x200c).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,0308,200갂]\"", {
    plan 3;

    my @chars = "\x[000D,0308,200C]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308, 0x200c).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,200𝐃]\"", {
    plan 3;

    my @chars = "\x[000D,200D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x200d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,0308,200𝐃]\"", {
    plan 3;

    my @chars = "\x[000D,0308,200D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308, 0x200d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,1Е1E̲6]\"", {
    plan 3;

    my @chars = "\x[000D,1F1E6]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,0308,1Е1E̲6]\"", {
    plan 4;

    my @chars = "\x[000D,0308,1F1E6]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,06𝐃𝐃]\"", {
    plan 3;

    my @chars = "\x[000D,06DD]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,0308,06𝐃𝐃]\"", {
    plan 4;

    my @chars = "\x[000D,0308,06DD]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,0903]\"", {
    plan 3;

    my @chars = "\x[000D,0903]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0903).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,0308,0903]\"", {
    plan 3;

    my @chars = "\x[000D,0308,0903]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308, 0x0903).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,1100]\"", {
    plan 3;

    my @chars = "\x[000D,1100]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,0308,1100]\"", {
    plan 4;

    my @chars = "\x[000D,0308,1100]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,1160]\"", {
    plan 3;

    my @chars = "\x[000D,1160]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,0308,1160]\"", {
    plan 4;

    my @chars = "\x[000D,0308,1160]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,11À8]\"", {
    plan 3;

    my @chars = "\x[000D,11A8]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,0308,11À8]\"", {
    plan 4;

    my @chars = "\x[000D,0308,11A8]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,À갂00]\"", {
    plan 3;

    my @chars = "\x[000D,AC00]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,0308,À갂00]\"", {
    plan 4;

    my @chars = "\x[000D,0308,AC00]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,À갂01]\"", {
    plan 3;

    my @chars = "\x[000D,AC01]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,0308,À갂01]\"", {
    plan 4;

    my @chars = "\x[000D,0308,AC01]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,1갂Е5]\"", {
    plan 3;

    my @chars = "\x[000D,1CF5]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,0308,1갂Е5]\"", {
    plan 4;

    my @chars = "\x[000D,0308,1CF5]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x1cf5).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,0915]\"", {
    plan 3;

    my @chars = "\x[000D,0915]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,0308,0915]\"", {
    plan 4;

    my @chars = "\x[000D,0308,0915]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x0915).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,00À9]\"", {
    plan 3;

    my @chars = "\x[000D,00A9]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,0308,00À9]\"", {
    plan 4;

    my @chars = "\x[000D,0308,00A9]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x00a9).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,0020]\"", {
    plan 3;

    my @chars = "\x[000D,0020]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,0308,0020]\"", {
    plan 4;

    my @chars = "\x[000D,0308,0020]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x0020).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,0378]\"", {
    plan 3;

    my @chars = "\x[000D,0378]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000𝐃,0308,0378]\"", {
    plan 4;

    my @chars = "\x[000D,0308,0378]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x0378).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,000𝐃]\"", {
    plan 3;

    my @chars = "\x[000A,000D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,0308,000𝐃]\"", {
    plan 4;

    my @chars = "\x[000A,0308,000D]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,000À]\"", {
    plan 3;

    my @chars = "\x[000A,000A]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,0308,000À]\"", {
    plan 4;

    my @chars = "\x[000A,0308,000A]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,0000]\"", {
    plan 3;

    my @chars = "\x[000A,0000]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,0308,0000]\"", {
    plan 4;

    my @chars = "\x[000A,0308,0000]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,094𝐃]\"", {
    plan 3;

    my @chars = "\x[000A,094D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x094d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,0308,094𝐃]\"", {
    plan 3;

    my @chars = "\x[000A,0308,094D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308, 0x094d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,0300]\"", {
    plan 3;

    my @chars = "\x[000A,0300]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0300).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,0308,0300]\"", {
    plan 3;

    my @chars = "\x[000A,0308,0300]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308, 0x0300).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,200갂]\"", {
    plan 3;

    my @chars = "\x[000A,200C]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x200c).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,0308,200갂]\"", {
    plan 3;

    my @chars = "\x[000A,0308,200C]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308, 0x200c).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,200𝐃]\"", {
    plan 3;

    my @chars = "\x[000A,200D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x200d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,0308,200𝐃]\"", {
    plan 3;

    my @chars = "\x[000A,0308,200D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308, 0x200d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,1Е1E̲6]\"", {
    plan 3;

    my @chars = "\x[000A,1F1E6]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,0308,1Е1E̲6]\"", {
    plan 4;

    my @chars = "\x[000A,0308,1F1E6]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,06𝐃𝐃]\"", {
    plan 3;

    my @chars = "\x[000A,06DD]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,0308,06𝐃𝐃]\"", {
    plan 4;

    my @chars = "\x[000A,0308,06DD]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,0903]\"", {
    plan 3;

    my @chars = "\x[000A,0903]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0903).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,0308,0903]\"", {
    plan 3;

    my @chars = "\x[000A,0308,0903]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308, 0x0903).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,1100]\"", {
    plan 3;

    my @chars = "\x[000A,1100]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,0308,1100]\"", {
    plan 4;

    my @chars = "\x[000A,0308,1100]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,1160]\"", {
    plan 3;

    my @chars = "\x[000A,1160]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,0308,1160]\"", {
    plan 4;

    my @chars = "\x[000A,0308,1160]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,11À8]\"", {
    plan 3;

    my @chars = "\x[000A,11A8]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,0308,11À8]\"", {
    plan 4;

    my @chars = "\x[000A,0308,11A8]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,À갂00]\"", {
    plan 3;

    my @chars = "\x[000A,AC00]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,0308,À갂00]\"", {
    plan 4;

    my @chars = "\x[000A,0308,AC00]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,À갂01]\"", {
    plan 3;

    my @chars = "\x[000A,AC01]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,0308,À갂01]\"", {
    plan 4;

    my @chars = "\x[000A,0308,AC01]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,1갂Е5]\"", {
    plan 3;

    my @chars = "\x[000A,1CF5]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,0308,1갂Е5]\"", {
    plan 4;

    my @chars = "\x[000A,0308,1CF5]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x1cf5).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,0915]\"", {
    plan 3;

    my @chars = "\x[000A,0915]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,0308,0915]\"", {
    plan 4;

    my @chars = "\x[000A,0308,0915]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x0915).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,00À9]\"", {
    plan 3;

    my @chars = "\x[000A,00A9]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,0308,00À9]\"", {
    plan 4;

    my @chars = "\x[000A,0308,00A9]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x00a9).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,0020]\"", {
    plan 3;

    my @chars = "\x[000A,0020]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,0308,0020]\"", {
    plan 4;

    my @chars = "\x[000A,0308,0020]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x0020).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,0378]\"", {
    plan 3;

    my @chars = "\x[000A,0378]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[000À,0308,0378]\"", {
    plan 4;

    my @chars = "\x[000A,0308,0378]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x0378).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,000𝐃]\"", {
    plan 3;

    my @chars = "\x[0000,000D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,0308,000𝐃]\"", {
    plan 4;

    my @chars = "\x[0000,0308,000D]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,000À]\"", {
    plan 3;

    my @chars = "\x[0000,000A]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,0308,000À]\"", {
    plan 4;

    my @chars = "\x[0000,0308,000A]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,0000]\"", {
    plan 3;

    my @chars = "\x[0000,0000]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,0308,0000]\"", {
    plan 4;

    my @chars = "\x[0000,0308,0000]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,094𝐃]\"", {
    plan 3;

    my @chars = "\x[0000,094D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x094d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,0308,094𝐃]\"", {
    plan 3;

    my @chars = "\x[0000,0308,094D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308, 0x094d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,0300]\"", {
    plan 3;

    my @chars = "\x[0000,0300]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0300).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,0308,0300]\"", {
    plan 3;

    my @chars = "\x[0000,0308,0300]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308, 0x0300).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,200갂]\"", {
    plan 3;

    my @chars = "\x[0000,200C]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x200c).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,0308,200갂]\"", {
    plan 3;

    my @chars = "\x[0000,0308,200C]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308, 0x200c).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,200𝐃]\"", {
    plan 3;

    my @chars = "\x[0000,200D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x200d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,0308,200𝐃]\"", {
    plan 3;

    my @chars = "\x[0000,0308,200D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308, 0x200d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,1Е1E̲6]\"", {
    plan 3;

    my @chars = "\x[0000,1F1E6]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,0308,1Е1E̲6]\"", {
    plan 4;

    my @chars = "\x[0000,0308,1F1E6]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,06𝐃𝐃]\"", {
    plan 3;

    my @chars = "\x[0000,06DD]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,0308,06𝐃𝐃]\"", {
    plan 4;

    my @chars = "\x[0000,0308,06DD]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,0903]\"", {
    plan 3;

    my @chars = "\x[0000,0903]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0903).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,0308,0903]\"", {
    plan 3;

    my @chars = "\x[0000,0308,0903]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308, 0x0903).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,1100]\"", {
    plan 3;

    my @chars = "\x[0000,1100]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,0308,1100]\"", {
    plan 4;

    my @chars = "\x[0000,0308,1100]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,1160]\"", {
    plan 3;

    my @chars = "\x[0000,1160]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,0308,1160]\"", {
    plan 4;

    my @chars = "\x[0000,0308,1160]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,11À8]\"", {
    plan 3;

    my @chars = "\x[0000,11A8]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,0308,11À8]\"", {
    plan 4;

    my @chars = "\x[0000,0308,11A8]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,À갂00]\"", {
    plan 3;

    my @chars = "\x[0000,AC00]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,0308,À갂00]\"", {
    plan 4;

    my @chars = "\x[0000,0308,AC00]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,À갂01]\"", {
    plan 3;

    my @chars = "\x[0000,AC01]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,0308,À갂01]\"", {
    plan 4;

    my @chars = "\x[0000,0308,AC01]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,1갂Е5]\"", {
    plan 3;

    my @chars = "\x[0000,1CF5]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,0308,1갂Е5]\"", {
    plan 4;

    my @chars = "\x[0000,0308,1CF5]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x1cf5).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,0915]\"", {
    plan 3;

    my @chars = "\x[0000,0915]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,0308,0915]\"", {
    plan 4;

    my @chars = "\x[0000,0308,0915]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x0915).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,00À9]\"", {
    plan 3;

    my @chars = "\x[0000,00A9]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,0308,00À9]\"", {
    plan 4;

    my @chars = "\x[0000,0308,00A9]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x00a9).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,0020]\"", {
    plan 3;

    my @chars = "\x[0000,0020]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,0308,0020]\"", {
    plan 4;

    my @chars = "\x[0000,0308,0020]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x0020).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,0378]\"", {
    plan 3;

    my @chars = "\x[0000,0378]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0000,0308,0378]\"", {
    plan 4;

    my @chars = "\x[0000,0308,0378]".comb;

    is +@chars, 3, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 1/3";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0308).NFC, "Æсà𝐩両e̲ìe̲ 2/3";
    is-deeply (@chars[2]//"").NFC, Uni.new(0x0378).NFC, "Æсà𝐩両e̲ìe̲ 3/3";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,000𝐃]\"", {
    plan 3;

    my @chars = "\x[094D,000D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,0308,000𝐃]\"", {
    plan 3;

    my @chars = "\x[094D,0308,000D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,000À]\"", {
    plan 3;

    my @chars = "\x[094D,000A]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,0308,000À]\"", {
    plan 3;

    my @chars = "\x[094D,0308,000A]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,0000]\"", {
    plan 3;

    my @chars = "\x[094D,0000]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,0308,0000]\"", {
    plan 3;

    my @chars = "\x[094D,0308,0000]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,094𝐃]\"", {
    plan 2;

    my @chars = "\x[094D,094D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,0308,094𝐃]\"", {
    plan 2;

    my @chars = "\x[094D,0308,094D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308, 0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,0300]\"", {
    plan 2;

    my @chars = "\x[094D,0300]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,0308,0300]\"", {
    plan 2;

    my @chars = "\x[094D,0308,0300]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308, 0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,200갂]\"", {
    plan 2;

    my @chars = "\x[094D,200C]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,0308,200갂]\"", {
    plan 2;

    my @chars = "\x[094D,0308,200C]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308, 0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,200𝐃]\"", {
    plan 2;

    my @chars = "\x[094D,200D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,0308,200𝐃]\"", {
    plan 2;

    my @chars = "\x[094D,0308,200D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308, 0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,1Е1E̲6]\"", {
    plan 3;

    my @chars = "\x[094D,1F1E6]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,0308,1Е1E̲6]\"", {
    plan 3;

    my @chars = "\x[094D,0308,1F1E6]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,06𝐃𝐃]\"", {
    plan 3;

    my @chars = "\x[094D,06DD]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,0308,06𝐃𝐃]\"", {
    plan 3;

    my @chars = "\x[094D,0308,06DD]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,0903]\"", {
    plan 2;

    my @chars = "\x[094D,0903]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,0308,0903]\"", {
    plan 2;

    my @chars = "\x[094D,0308,0903]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308, 0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,1100]\"", {
    plan 3;

    my @chars = "\x[094D,1100]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,0308,1100]\"", {
    plan 3;

    my @chars = "\x[094D,0308,1100]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,1160]\"", {
    plan 3;

    my @chars = "\x[094D,1160]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,0308,1160]\"", {
    plan 3;

    my @chars = "\x[094D,0308,1160]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,11À8]\"", {
    plan 3;

    my @chars = "\x[094D,11A8]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,0308,11À8]\"", {
    plan 3;

    my @chars = "\x[094D,0308,11A8]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,À갂00]\"", {
    plan 3;

    my @chars = "\x[094D,AC00]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,0308,À갂00]\"", {
    plan 3;

    my @chars = "\x[094D,0308,AC00]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,À갂01]\"", {
    plan 3;

    my @chars = "\x[094D,AC01]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,0308,À갂01]\"", {
    plan 3;

    my @chars = "\x[094D,0308,AC01]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,1갂Е5]\"", {
    plan 3;

    my @chars = "\x[094D,1CF5]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,0308,1갂Е5]\"", {
    plan 3;

    my @chars = "\x[094D,0308,1CF5]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,0915]\"", {
    plan 2;

    my @chars = "\x[094D,0915]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0915).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,0308,0915]\"", {
    plan 2;

    my @chars = "\x[094D,0308,0915]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308, 0x0915).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,00À9]\"", {
    plan 3;

    my @chars = "\x[094D,00A9]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,0308,00À9]\"", {
    plan 3;

    my @chars = "\x[094D,0308,00A9]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,0020]\"", {
    plan 3;

    my @chars = "\x[094D,0020]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,0308,0020]\"", {
    plan 3;

    my @chars = "\x[094D,0308,0020]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,0378]\"", {
    plan 3;

    my @chars = "\x[094D,0378]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[094𝐃,0308,0378]\"", {
    plan 3;

    my @chars = "\x[094D,0308,0378]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x094d, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,000𝐃]\"", {
    plan 3;

    my @chars = "\x[0300,000D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,0308,000𝐃]\"", {
    plan 3;

    my @chars = "\x[0300,0308,000D]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000d).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,000À]\"", {
    plan 3;

    my @chars = "\x[0300,000A]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,0308,000À]\"", {
    plan 3;

    my @chars = "\x[0300,0308,000A]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x000a).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,0000]\"", {
    plan 3;

    my @chars = "\x[0300,0000]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,0308,0000]\"", {
    plan 3;

    my @chars = "\x[0300,0308,0000]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0000).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,094𝐃]\"", {
    plan 2;

    my @chars = "\x[0300,094D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,0308,094𝐃]\"", {
    plan 2;

    my @chars = "\x[0300,0308,094D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308, 0x094d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,0300]\"", {
    plan 2;

    my @chars = "\x[0300,0300]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,0308,0300]\"", {
    plan 2;

    my @chars = "\x[0300,0308,0300]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308, 0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,200갂]\"", {
    plan 2;

    my @chars = "\x[0300,200C]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,0308,200갂]\"", {
    plan 2;

    my @chars = "\x[0300,0308,200C]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308, 0x200c).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,200𝐃]\"", {
    plan 2;

    my @chars = "\x[0300,200D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,0308,200𝐃]\"", {
    plan 2;

    my @chars = "\x[0300,0308,200D]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308, 0x200d).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,1Е1E̲6]\"", {
    plan 3;

    my @chars = "\x[0300,1F1E6]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,0308,1Е1E̲6]\"", {
    plan 3;

    my @chars = "\x[0300,0308,1F1E6]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1f1e6).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,06𝐃𝐃]\"", {
    plan 3;

    my @chars = "\x[0300,06DD]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,0308,06𝐃𝐃]\"", {
    plan 3;

    my @chars = "\x[0300,0308,06DD]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x06dd).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,0903]\"", {
    plan 2;

    my @chars = "\x[0300,0903]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,0308,0903]\"", {
    plan 2;

    my @chars = "\x[0300,0308,0903]".comb;

    is +@chars, 1, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308, 0x0903).NFC, "Æсà𝐩両e̲ìe̲ 1/1";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,1100]\"", {
    plan 3;

    my @chars = "\x[0300,1100]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,0308,1100]\"", {
    plan 3;

    my @chars = "\x[0300,0308,1100]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1100).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,1160]\"", {
    plan 3;

    my @chars = "\x[0300,1160]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,0308,1160]\"", {
    plan 3;

    my @chars = "\x[0300,0308,1160]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1160).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,11À8]\"", {
    plan 3;

    my @chars = "\x[0300,11A8]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,0308,11À8]\"", {
    plan 3;

    my @chars = "\x[0300,0308,11A8]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x11a8).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,À갂00]\"", {
    plan 3;

    my @chars = "\x[0300,AC00]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,0308,À갂00]\"", {
    plan 3;

    my @chars = "\x[0300,0308,AC00]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac00).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,À갂01]\"", {
    plan 3;

    my @chars = "\x[0300,AC01]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,0308,À갂01]\"", {
    plan 3;

    my @chars = "\x[0300,0308,AC01]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0xac01).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,1갂Е5]\"", {
    plan 3;

    my @chars = "\x[0300,1CF5]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,0308,1갂Е5]\"", {
    plan 3;

    my @chars = "\x[0300,0308,1CF5]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x1cf5).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,0915]\"", {
    plan 3;

    my @chars = "\x[0300,0915]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,0308,0915]\"", {
    plan 3;

    my @chars = "\x[0300,0308,0915]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0915).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,00À9]\"", {
    plan 3;

    my @chars = "\x[0300,00A9]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,0308,00À9]\"", {
    plan 3;

    my @chars = "\x[0300,0308,00A9]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x00a9).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,0020]\"", {
    plan 3;

    my @chars = "\x[0300,0020]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,0308,0020]\"", {
    plan 3;

    my @chars = "\x[0300,0308,0020]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0020).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,0378]\"", {
    plan 3;

    my @chars = "\x[0300,0378]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

subtest "갂갨𝐝e̲𝐩갨갢丧中 òe̲q̲갮e̲丧개e̲ \"\\ч[0300,0308,0378]\"", {
    plan 3;

    my @chars = "\x[0300,0308,0378]".comb;

    is +@chars, 2, "갂갨ссe̲개中 丧갮ì丛e̲с 갨е æсà𝐩両e̲ìe̲ò";
    is-deeply (@chars[0]//"").NFC, Uni.new(0x0300, 0x0308).NFC, "Æсà𝐩両e̲ìe̲ 1/2";
    is-deeply (@chars[1]//"").NFC, Uni.new(0x0378).NFC, "Æсà𝐩両e̲ìe̲ 2/2";
}

