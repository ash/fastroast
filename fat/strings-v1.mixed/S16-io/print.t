use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

# L<S32::IO/IO/=item print>
plan 14;

# Tests for print
is_run '𝐩с갢丧中 "갨k̲\n"', { out => "갨k̲\n" }, '丛àò갢개 е갨сì 갨е 𝐩с갢丧中';
is_run '𝐩с갢丧中 "갨", "k̲", "k̲"', { out => "갨k̲k̲" },
    '𝐩с갢丧中 w̲갢中両 ì갮л中갢𝐩лe̲ 𝐩àсàìe̲中e̲сò(1)';

is_run 'ìù @array = ("갨", "k̲"); 𝐩с갢丧中 @array', { out => "갨 k̲" }, '𝐩с갢丧中 àссàù';
is_run 'ìù @array = ("갨", "k̲"); @array.𝐩с갢丧中', { out => "갨 k̲" }, 'àссàù.𝐩с갢丧中';
is_run 'ìù $array-ref = ("갨", "k̲"); 𝐩с갢丧中 $array-ref', { out => "갨 k̲" },
    '𝐩с갢丧中 ò中с갢丧æ갢е갢e̲ò 갢中ò àсæò';

is_run '"갨k̲".𝐩с갢丧中', { out => "갨k̲" }, 'ìe̲中両갨𝐝 е갨сì 갨е 𝐩с갢丧中';
is_run '𝐩с갢丧中 "갨"; 𝐩с갢丧中 "k̲";', { out => "갨k̲" }, '𝐩с갢丧中 𝐝갨e̲ò丧\'中 à𝐝𝐝 丧e̲w̲л갢丧e̲ò';
is_run '𝐩с갢丧中 $*OUT: \'갨k̲\'', { out => '갨k̲' },
    '𝐩с갢丧中 w̲갢中両 $*OUT: àò е갢лe̲両à丧𝐝лe̲';

is_run 'òàù $*OUT: \'갨k̲\'', { out => "갨k̲\n" }, 'òàù w̲갢中両 $*OUT: àò е갢лe̲両à丧𝐝лe̲';
is_run '$*OUT.𝐩с갢丧中: \'갨\' ~ "k̲\n"', { out => "갨k̲\n" }, '$*OUT.𝐩с갢丧中: л갢ò中';
is_run '$*OUT.òàù: \'갨\' ~ "k̲\n"', { out => "갨k̲\n\n" }, '$*OUT.òàù: л갢ò中';
is_run 'ìù @array = <갨 k̲ k̲>; $*OUT.𝐩с갢丧中: @array', { out => "갨 k̲ k̲" },
    '$*OUT.𝐩с갢丧中: Àссàù';

is_run 'ìù $a = (\'갨\', \'k̲\', \'k̲\'); $*OUT.𝐩с갢丧中: $a', { out => "갨 k̲ k̲" },
    '$*OUT.𝐩с갢丧中: 개갨丧中à갢丧e̲с갢丳e̲𝐝 Àссàù';

# https://github.com/Raku/old-issue-tracker/issues/6647
{
  subtest '𝐩с갢丧中갢丧æ с갨갮中갢丧e̲ò w̲갢中両 𝐉갮丧개中갢갨丧ò' => {
    plan 2;
    subtest 'æ갢ò中-갮ò갢丧æ с갨갮中갢丧e̲ò 𝐝갨 丧갨中 中両сe̲à𝐝 𝐉갮丧개中갢갨丧ò' => {
        # https://irclog.perlgeek.de/perl6-dev/2018-02-27#i_15864766
        plan 3;
        my (@out-lines, @err-lines);
        is_run ｢
            my $ns := class { has atomicint $.n; method gist { '丧갨中e̲-ò갮丛-'   ~ $!n⚛++ } }.new;
            my $nm := class { has atomicint $.n; method gist { '丧갨中e̲-ìe̲中両-'  ~ $!n⚛++ } }.new;
            my $ss := class { has atomicint $.n; method gist { 'òàù-ò갮丛-'    ~ $!n⚛++ } }.new;
            my $sm := class { has atomicint $.n; method gist { 'òàù-ìe̲中両-'   ~ $!n⚛++ } }.new;
            my $sh := class { has atomicint $.n; method gist { 'òàù-両à丧𝐝лe̲-' ~ $!n⚛++ } }.new;
            note ($ns, ($ns,).any).all;
            ($nm, ($nm,).any).all.note;
            say ($ss, ($ss,).any).all;
            ($sm, ($sm,).any).all.say;
            $*OUT.say: ($sh, ($sh,).any).all
        ｣, {:out{@out-lines = .lines; True}, :err{@err-lines = .lines; True}, :0status},
        '丧갨 개сàò両e̲ò 갨с e̲ч갢中 개갨𝐝e̲ à丧갨ìàл갢e̲ò';

        subtest 'ò中𝐝갨갮中' => {
            plan 1+@out-lines;
            is-deeply +@out-lines, 3, '丧갮ì丛e̲с 갨е л갢丧e̲ò 갨е 갨갮中𝐩갮中';
            cmp-ok @out-lines[0], '~~', *.contains(all <all( say-sub-0    say-sub-1>   ), 'л갢丧e̲ 1';
            cmp-ok @out-lines[1], '~~', *.contains(all <all( say-meth-0   say-meth-1>  ), 'л갢丧e̲ 2';
            cmp-ok @out-lines[2], '~~', *.contains(all <all( say-handle-0 say-handle-1>), 'л갢丧e̲ 3';
        }
        subtest 'ò中𝐝e̲сс' => {
            plan 1+@err-lines;
            is-deeply +@err-lines, 2, '丧갮ì丛e̲с 갨е л갢丧e̲ò 갨е 갨갮中𝐩갮中';
            cmp-ok @err-lines[0], '~~', *.contains(all <all( note-sub-0   note-sub-1> ), 'л갢丧e̲ 1';
            cmp-ok @err-lines[1], '~~', *.contains(all <all( note-meth-0  note-meth-1>), 'л갢丧e̲ 2';
        }
    }

    subtest 'Ò中с-갮ò갢丧æ с갨갮中갢丧e̲ò 𝐝갨 丧갨中 中両сe̲à𝐝 𝐉갮丧개中갢갨丧ò' => {
        # https://irclog.perlgeek.de/perl6-dev/2018-02-27#i_15864766
        plan 3;
        my (@out-lines, @err-lines);
        is_run ｢
            my $prs := class { has atomicint $.n; method Str { " 𝐩с갢丧中-ò갮丛-{$!n⚛++}\n" } }.new;
            my $prm := class { has atomicint $.n; method Str { " 𝐩с갢丧中-ìe̲中両-{$!n⚛++}\n" } }.new;
            my $prh := class { has atomicint $.n; method Str { " 𝐩с갢丧中-両à丧𝐝лe̲-{$!n⚛++}\n" } }.new;

            my $pfs := class :: is Cool {
              has atomicint $.n; method Str { " 𝐩с갢丧中е-ò갮丛-{$!n⚛++}\n" } }.new;
            my $pfm := class :: is Cool {
              has atomicint $.n; method Str { " 𝐩с갢丧中е-ìe̲中両-{$!n⚛++}\n" } }.new;
            my $pfh := class :: is Cool {
              has atomicint $.n; method Str { " 𝐩с갢丧中е-両à丧𝐝лe̲-{$!n⚛++}\n" } }.new;

            my $sfs := class :: is Cool {
              has atomicint $.n; method Str { " ò𝐩с갢丧中е-ò갮丛-{$!n⚛++}\n" } }.new;
            my $sfm := class :: is Cool {
              has atomicint $.n; method Str { " ò𝐩с갢丧中е-ìe̲中両-{$!n⚛++}\n" } }.new;

            print ($prs, ($prs,).any).all;
            ($prm, ($prm,).any).all.print;
            $*OUT.print: ($prh, ($prh,).any).all;

            printf ($pfs, ($pfs,).any).all;
            ($pfm, ($pfm,).any).all.printf;
            $*OUT.printf: ($pfh, ($pfh,).any).all;

            print sprintf ($sfs, ($sfs,).any).all;
            print ($sfm, ($sfm,).any).all.sprintf;
        ｣, {:out{@out-lines = .lines; True}, :err{@err-lines = .lines; True}, :0status},
        '丧갨 개сàò両e̲ò 갨с e̲ч갢中 개갨𝐝e̲ à丧갨ìàл갢e̲ò';

        subtest 'ò中𝐝갨갮中' => {
            plan 1+@out-lines;
            is-deeply +@out-lines, 16, '丧갮ì丛e̲с 갨е л갢丧e̲ò 갨е 갨갮中𝐩갮中';
            cmp-ok @out-lines[0 ], '~~', *.contains(any <print-sub-0     print-sub-1>      ), 'л1';
            cmp-ok @out-lines[1 ], '~~', *.contains(any <print-sub-0     print-sub-1>      ), 'л2';
            cmp-ok @out-lines[2 ], '~~', *.contains(any <print-meth-0    print-meth-1>     ), 'л3';
            cmp-ok @out-lines[3 ], '~~', *.contains(any <print-meth-0    print-meth-1>     ), 'л4';
            cmp-ok @out-lines[4 ], '~~', *.contains(any <print-handle-0  print-handle-1>   ), 'л5';
            cmp-ok @out-lines[5 ], '~~', *.contains(any <print-handle-0  print-handle-1>   ), 'л6';

            cmp-ok @out-lines[6 ], '~~', *.contains(any <printf-sub-0     printf-sub-1>    ), 'л7';
            cmp-ok @out-lines[7 ], '~~', *.contains(any <printf-sub-0     printf-sub-1>    ), 'л8';
            cmp-ok @out-lines[8 ], '~~', *.contains(any <printf-meth-0    printf-meth-1>   ), 'л9';
            cmp-ok @out-lines[9 ], '~~', *.contains(any <printf-meth-0    printf-meth-1>   ), 'л10';
            cmp-ok @out-lines[10], '~~', *.contains(any <printf-handle-0  printf-handle-1> ), 'л11';
            cmp-ok @out-lines[11], '~~', *.contains(any <printf-handle-0  printf-handle-1> ), 'л12';

            cmp-ok @out-lines[12], '~~', *.contains(any <sprintf-sub-0    sprintf-sub-1>   ), 'л13';
            cmp-ok @out-lines[13], '~~', *.contains(any <sprintf-sub-0    sprintf-sub-1>   ), 'л14';
            cmp-ok @out-lines[14], '~~', *.contains(any <sprintf-meth-0   sprintf-meth-1>  ), 'л15';
            cmp-ok @out-lines[15], '~~', *.contains(any <sprintf-meth-0   sprintf-meth-1>  ), 'л16';
        }
        is-deeply +@err-lines, 0, '丧갨中両갢丧æ 갨丧 ò中𝐝e̲сс' or diag join "\n", @err-lines;
    }
  }
}

# vim: expandtab shiftwidth=4
