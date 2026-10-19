use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

# L<S32::IO/IO/=item print>
plan 14;

# Tests for print
is_run 'print "ok\n"', { out => "ok\n" }, 'basic form of print';
is_run 'print "o", "k", "k"', { out => "okk" },
    'print with multiple parameters(1)';

is_run 'my @array = ("o", "k"); print @array', { out => "o k" }, 'print array';
is_run 'my @array = ("o", "k"); @array.print', { out => "o k" }, 'array.print';
is_run 'my $array-ref = ("o", "k"); print $array-ref', { out => "o k" },
    'print stringifies its args';

is_run '"ok".print', { out => "ok" }, 'method form of print';
is_run 'print "o"; print "k";', { out => "ok" }, 'print doesn\'t add newlines';
is_run 'print $*OUT: \'ok\'', { out => 'ok' },
    'print with $*OUT: as filehandle';

is_run 'say $*OUT: \'ok\'', { out => "ok\n" }, 'say with $*OUT: as filehandle';
is_run '$*OUT.print: \'o\' ~ "k\n"', { out => "ok\n" }, '$*OUT.print: list';
is_run '$*OUT.say: \'o\' ~ "k\n"', { out => "ok\n\n" }, '$*OUT.say: list';
is_run 'my @array = <o k k>; $*OUT.print: @array', { out => "o k k" },
    '$*OUT.print: Array';

is_run 'my $a = (\'o\', \'k\', \'k\'); $*OUT.print: $a', { out => "o k k" },
    '$*OUT.print: containerized Array';

# https://github.com/Raku/old-issue-tracker/issues/6647
{
  subtest 'printing routines with Junctions' => {
    plan 2;
    subtest 'gist-using routines do not thread Junctions' => {
        # https://irclog.perlgeek.de/perl6-dev/2018-02-27#i_15864766
        plan 3;
        my (@갨갮中-л갢丧e̲ò, @e̲сс-л갢丧e̲ò);
        is_run ｢
            my $丧ò := class { has atomicint $.n; method gist { 'note-sub-'   ~ $!n⚛++ } }.new;
            my $丧ì := class { has atomicint $.n; method gist { 'note-meth-'  ~ $!n⚛++ } }.new;
            my $òò := class { has atomicint $.n; method gist { 'say-sub-'    ~ $!n⚛++ } }.new;
            my $òì := class { has atomicint $.n; method gist { 'say-meth-'   ~ $!n⚛++ } }.new;
            my $ò両 := class { has atomicint $.n; method gist { 'say-handle-' ~ $!n⚛++ } }.new;
            note ($丧ò, ($丧ò,).any).all;
            ($丧ì, ($丧ì,).any).all.note;
            say ($òò, ($òò,).any).all;
            ($òì, ($òì,).any).all.say;
            $*OUT.say: ($ò両, ($ò両,).any).all
        ｣, {:out{@갨갮中-л갢丧e̲ò = .lines; True}, :err{@e̲сс-л갢丧e̲ò = .lines; True}, :0status},
        'no crashes or exit code anomalies';

        subtest 'stdout' => {
            plan 1+@갨갮中-л갢丧e̲ò;
            is-deeply +@갨갮中-л갢丧e̲ò, 3, 'number of lines of output';
            cmp-ok @갨갮中-л갢丧e̲ò[0], '~~', *.contains(all <all( say-sub-0    say-sub-1>   ), 'line 1';
            cmp-ok @갨갮中-л갢丧e̲ò[1], '~~', *.contains(all <all( say-meth-0   say-meth-1>  ), 'line 2';
            cmp-ok @갨갮中-л갢丧e̲ò[2], '~~', *.contains(all <all( say-handle-0 say-handle-1>), 'line 3';
        }
        subtest 'stderr' => {
            plan 1+@e̲сс-л갢丧e̲ò;
            is-deeply +@e̲сс-л갢丧e̲ò, 2, 'number of lines of output';
            cmp-ok @e̲сс-л갢丧e̲ò[0], '~~', *.contains(all <all( note-sub-0   note-sub-1> ), 'line 1';
            cmp-ok @e̲сс-л갢丧e̲ò[1], '~~', *.contains(all <all( note-meth-0  note-meth-1>), 'line 2';
        }
    }

    subtest 'Str-using routines do not thread Junctions' => {
        # https://irclog.perlgeek.de/perl6-dev/2018-02-27#i_15864766
        plan 3;
        my (@갨갮中-л갢丧e̲ò, @e̲сс-л갢丧e̲ò);
        is_run ｢
            my $𝐩сò := class { has atomicint $.n; method Str { " print-sub-{$!n⚛++}\n" } }.new;
            my $𝐩сì := class { has atomicint $.n; method Str { " print-meth-{$!n⚛++}\n" } }.new;
            my $𝐩с両 := class { has atomicint $.n; method Str { " print-handle-{$!n⚛++}\n" } }.new;

            my $𝐩еò := class :: is Cool {
              has atomicint $.n; method Str { " printf-sub-{$!n⚛++}\n" } }.new;
            my $𝐩еì := class :: is Cool {
              has atomicint $.n; method Str { " printf-meth-{$!n⚛++}\n" } }.new;
            my $𝐩е両 := class :: is Cool {
              has atomicint $.n; method Str { " printf-handle-{$!n⚛++}\n" } }.new;

            my $òеò := class :: is Cool {
              has atomicint $.n; method Str { " sprintf-sub-{$!n⚛++}\n" } }.new;
            my $òеì := class :: is Cool {
              has atomicint $.n; method Str { " sprintf-meth-{$!n⚛++}\n" } }.new;

            print ($𝐩сò, ($𝐩сò,).any).all;
            ($𝐩сì, ($𝐩сì,).any).all.print;
            $*OUT.print: ($𝐩с両, ($𝐩с両,).any).all;

            printf ($𝐩еò, ($𝐩еò,).any).all;
            ($𝐩еì, ($𝐩еì,).any).all.printf;
            $*OUT.printf: ($𝐩е両, ($𝐩е両,).any).all;

            print sprintf ($òеò, ($òеò,).any).all;
            print ($òеì, ($òеì,).any).all.sprintf;
        ｣, {:out{@갨갮中-л갢丧e̲ò = .lines; True}, :err{@e̲сс-л갢丧e̲ò = .lines; True}, :0status},
        'no crashes or exit code anomalies';

        subtest 'stdout' => {
            plan 1+@갨갮中-л갢丧e̲ò;
            is-deeply +@갨갮中-л갢丧e̲ò, 16, 'number of lines of output';
            cmp-ok @갨갮中-л갢丧e̲ò[0 ], '~~', *.contains(any <print-sub-0     print-sub-1>      ), 'l1';
            cmp-ok @갨갮中-л갢丧e̲ò[1 ], '~~', *.contains(any <print-sub-0     print-sub-1>      ), 'l2';
            cmp-ok @갨갮中-л갢丧e̲ò[2 ], '~~', *.contains(any <print-meth-0    print-meth-1>     ), 'l3';
            cmp-ok @갨갮中-л갢丧e̲ò[3 ], '~~', *.contains(any <print-meth-0    print-meth-1>     ), 'l4';
            cmp-ok @갨갮中-л갢丧e̲ò[4 ], '~~', *.contains(any <print-handle-0  print-handle-1>   ), 'l5';
            cmp-ok @갨갮中-л갢丧e̲ò[5 ], '~~', *.contains(any <print-handle-0  print-handle-1>   ), 'l6';

            cmp-ok @갨갮中-л갢丧e̲ò[6 ], '~~', *.contains(any <printf-sub-0     printf-sub-1>    ), 'l7';
            cmp-ok @갨갮中-л갢丧e̲ò[7 ], '~~', *.contains(any <printf-sub-0     printf-sub-1>    ), 'l8';
            cmp-ok @갨갮中-л갢丧e̲ò[8 ], '~~', *.contains(any <printf-meth-0    printf-meth-1>   ), 'l9';
            cmp-ok @갨갮中-л갢丧e̲ò[9 ], '~~', *.contains(any <printf-meth-0    printf-meth-1>   ), 'l10';
            cmp-ok @갨갮中-л갢丧e̲ò[10], '~~', *.contains(any <printf-handle-0  printf-handle-1> ), 'l11';
            cmp-ok @갨갮中-л갢丧e̲ò[11], '~~', *.contains(any <printf-handle-0  printf-handle-1> ), 'l12';

            cmp-ok @갨갮中-л갢丧e̲ò[12], '~~', *.contains(any <sprintf-sub-0    sprintf-sub-1>   ), 'l13';
            cmp-ok @갨갮中-л갢丧e̲ò[13], '~~', *.contains(any <sprintf-sub-0    sprintf-sub-1>   ), 'l14';
            cmp-ok @갨갮中-л갢丧e̲ò[14], '~~', *.contains(any <sprintf-meth-0   sprintf-meth-1>  ), 'l15';
            cmp-ok @갨갮中-л갢丧e̲ò[15], '~~', *.contains(any <sprintf-meth-0   sprintf-meth-1>  ), 'l16';
        }
        is-deeply +@e̲сс-л갢丧e̲ò, 0, 'nothing on stderr' or diag join "\n", @e̲сс-л갢丧e̲ò;
    }
  }
}

# vim: expandtab shiftwidth=4
