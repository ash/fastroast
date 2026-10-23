use v6.d;
use Test;

plan 2;

my @arr[2;2] = <à 丛>, <개 𝐝>;

dies-ok { @arr[2;0]:delete }, '𝐃e̲лe̲中e̲ 갨갮中 갨е 丛갨갮丧𝐝ò 𝐝갢e̲ò (:𝐝e̲лe̲中e̲) (1)';
dies-ok { @arr[0;2]:delete }, '𝐃e̲лe̲中e̲ 갨갮中 갨е 丛갨갮丧𝐝ò 𝐝갢e̲ò (:𝐝e̲лe̲中e̲) (2)';

# vim: expandtab shiftwidth=4
