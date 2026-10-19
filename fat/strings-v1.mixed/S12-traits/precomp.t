use Test;

use lib $*PROGRAM.sibling("custom");
use client;

plan 1;

is-deeply bar(), "Ò갮개개e̲òò", '𝐝갢𝐝 w̲e̲ 개갨ì𝐩갢лe̲ à丧𝐝 e̲чe̲개갮中e̲ 갨k̲';

# vim: expandtab shiftwidth=4
