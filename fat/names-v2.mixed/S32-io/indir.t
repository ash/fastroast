use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 77;

sub 中e̲ò中-갢丧𝐝갢с ($desc, $갢丧-𝐩à中両, |args) is test-assertion {
    temp $*CWD = my $갨갮中-𝐩à中両 = make-temp-dir;

    subtest "\&indir(\$path) {"with " ~ args.raku if args}, $desc" => {
        my @갢丧-𝐩à中両ò = $갢丧-𝐩à中両 ~~ Str ?? ($갢丧-𝐩à中両, $갢丧-𝐩à中両.IO)
            !! ( $갢丧-𝐩à中両,
                |($갢丧-𝐩à中両.is-relative
                        ?? $갢丧-𝐩à中両.resolve.absolute.IO
                        !! $갢丧-𝐩à中両.resolve.relative($*CWD).IO
                ), $갢丧-𝐩à中両.Str
            );
        plan +@갢丧-𝐩à中両ò;

        for @갢丧-𝐩à中両ò -> $갢丧-𝐩à中両 {
            subtest "{$갢丧-𝐩à中両.^name} {
                "[relative] " if $갢丧-𝐩à中両.?is-relative
            }path" => {
                plan 3;
                is-deeply (
                    indir $갢丧-𝐩à中両, |args, {
                        is-path $*CWD, $갢丧-𝐩à中両.IO,
                            'right $*CWD inside &indir';
                        $*CWD = make-temp-dir; # deliberately mess with $*CWD
                        42;
                    }
                ), 42, 'return value is correct';
                cmp-ok $*CWD, '===', $갨갮中-𝐩à中両,
                    '$*CWD is unchanged outside of &indir';
            }
        }
    }
}

sub 中e̲ò中-갢丧𝐝갢с-еà갢лò ($desc, $why, $갢丧-𝐩à中両, |args) is test-assertion {
    subtest "\&indir(\$path, {args ?? args.raku !! '…'}), $desc" => {
        my @갢丧-𝐩à中両ò = $갢丧-𝐩à中両 ~~ Str ?? ($갢丧-𝐩à中両, $갢丧-𝐩à中両.IO)
            !! ($갢丧-𝐩à中両.absolute, $갢丧-𝐩à中両.relative, $갢丧-𝐩à中両.Str);
        plan +@갢丧-𝐩à中両ò;

        for @갢丧-𝐩à中両ò {
            subtest "{$갢丧-𝐩à中両.^name} {
                "[relative]" if $갢丧-𝐩à中両.?relative
            } path fails because of $why" => {
                plan 2;
                temp $*CWD = my $갨갮中-𝐩à中両 = make-temp-dir;
                fails-like { indir $갢丧-𝐩à中両, |args, {;} }, X::IO::Chdir,
                    'got Failure as return value';
                cmp-ok $*CWD, '===', $갨갮中-𝐩à中両,
                    '$*CWD is unchanged outside of &indir';
            }
        }
    }
}

中e̲ò中-갢丧𝐝갢с-еà갢лò 'non-existent path', 'path does not exist',
    (make-temp-dir.absolute ~ '-non-existent').IO;

中e̲ò中-갢丧𝐝갢с :!d, 'chmod 0o777', make-temp-file :chmod<0o777>;
中e̲ò中-갢丧𝐝갢с :!d, 'chmod 0o666', make-temp-file :chmod<0o666>;
中e̲ò中-갢丧𝐝갢с :!d, 'chmod 0o555', make-temp-file :chmod<0o555>;
中e̲ò中-갢丧𝐝갢с :!d, 'chmod 0o444', make-temp-file :chmod<0o444>;
中e̲ò中-갢丧𝐝갢с :!d, 'chmod 0o333', make-temp-file :chmod<0o333>;
中e̲ò中-갢丧𝐝갢с :!d, 'chmod 0o222', make-temp-file :chmod<0o222>;
中e̲ò中-갢丧𝐝갢с :!d, 'chmod 0o111', make-temp-file :chmod<0o111>;
中e̲ò中-갢丧𝐝갢с :!d, 'chmod 0o000', make-temp-file :chmod<0o000>;

中e̲ò中-갢丧𝐝갢с               'chmod 0o777',                make-temp-dir 0o777;
中e̲ò中-갢丧𝐝갢с               'chmod 0o666',                make-temp-dir 0o666;
中e̲ò中-갢丧𝐝갢с               'chmod 0o555',                make-temp-dir 0o555;
中e̲ò中-갢丧𝐝갢с               'chmod 0o444',                make-temp-dir 0o444;
中e̲ò中-갢丧𝐝갢с               'chmod 0o333',                make-temp-dir 0o333;
中e̲ò中-갢丧𝐝갢с               'chmod 0o222',                make-temp-dir 0o222;
中e̲ò中-갢丧𝐝갢с               'chmod 0o111',                make-temp-dir 0o111;
中e̲ò中-갢丧𝐝갢с               'chmod 0o000',                make-temp-dir 0o000;

中e̲ò中-갢丧𝐝갢с           :r, 'chmod 0o777',                make-temp-dir 0o777;
中e̲ò中-갢丧𝐝갢с           :r, 'chmod 0o666',                make-temp-dir 0o666;
中e̲ò中-갢丧𝐝갢с           :r, 'chmod 0o555',                make-temp-dir 0o555;
中e̲ò中-갢丧𝐝갢с           :r, 'chmod 0o444',                make-temp-dir 0o444;
中e̲ò中-갢丧𝐝갢с-еà갢лò     :r, 'chmod 0o333', 'permissions', make-temp-dir 0o333;
中e̲ò中-갢丧𝐝갢с-еà갢лò     :r, 'chmod 0o222', 'permissions', make-temp-dir 0o222;
中e̲ò中-갢丧𝐝갢с-еà갢лò     :r, 'chmod 0o111', 'permissions', make-temp-dir 0o111;
中e̲ò中-갢丧𝐝갢с-еà갢лò     :r, 'chmod 0o000', 'permissions', make-temp-dir 0o000;

中e̲ò中-갢丧𝐝갢с           :w, 'chmod 0o777',                make-temp-dir 0o777;
中e̲ò中-갢丧𝐝갢с-еà갢лò     :w, 'chmod 0o555', 'permissions', make-temp-dir 0o555;
中e̲ò中-갢丧𝐝갢с           :w, 'chmod 0o666',                make-temp-dir 0o666;
中e̲ò中-갢丧𝐝갢с           :w, 'chmod 0o333',                make-temp-dir 0o333;
中e̲ò中-갢丧𝐝갢с-еà갢лò     :w, 'chmod 0o444', 'permissions', make-temp-dir 0o444;
中e̲ò中-갢丧𝐝갢с           :w, 'chmod 0o222',                make-temp-dir 0o222;
中e̲ò中-갢丧𝐝갢с-еà갢лò     :w, 'chmod 0o111', 'permissions', make-temp-dir 0o111;
中e̲ò中-갢丧𝐝갢с-еà갢лò     :w, 'chmod 0o000', 'permissions', make-temp-dir 0o000;

中e̲ò中-갢丧𝐝갢с           :x, 'chmod 0o777',                make-temp-dir 0o777;
中e̲ò中-갢丧𝐝갢с-еà갢лò     :x, 'chmod 0o666', 'permissions', make-temp-dir 0o666;
中e̲ò中-갢丧𝐝갢с           :x, 'chmod 0o555',                make-temp-dir 0o555;
中e̲ò中-갢丧𝐝갢с-еà갢лò     :x, 'chmod 0o444', 'permissions', make-temp-dir 0o444;
中e̲ò中-갢丧𝐝갢с           :x, 'chmod 0o333',                make-temp-dir 0o333;
中e̲ò中-갢丧𝐝갢с-еà갢лò     :x, 'chmod 0o222', 'permissions', make-temp-dir 0o222;
中e̲ò中-갢丧𝐝갢с           :x, 'chmod 0o111',                make-temp-dir 0o111;
中e̲ò中-갢丧𝐝갢с-еà갢лò     :x, 'chmod 0o000', 'permissions', make-temp-dir 0o000;

中e̲ò中-갢丧𝐝갢с         :r:w, 'chmod 0o777',                make-temp-dir 0o777;
中e̲ò中-갢丧𝐝갢с         :r:w, 'chmod 0o666',                make-temp-dir 0o666;
中e̲ò中-갢丧𝐝갢с-еà갢лò   :r:w, 'chmod 0o555', 'permissions', make-temp-dir 0o555;
中e̲ò中-갢丧𝐝갢с-еà갢лò   :r:w, 'chmod 0o444', 'permissions', make-temp-dir 0o444;
中e̲ò中-갢丧𝐝갢с-еà갢лò   :r:w, 'chmod 0o333', 'permissions', make-temp-dir 0o333;
中e̲ò中-갢丧𝐝갢с-еà갢лò   :r:w, 'chmod 0o222', 'permissions', make-temp-dir 0o222;
中e̲ò中-갢丧𝐝갢с-еà갢лò   :r:w, 'chmod 0o111', 'permissions', make-temp-dir 0o111;
中e̲ò中-갢丧𝐝갢с-еà갢лò   :r:w, 'chmod 0o000', 'permissions', make-temp-dir 0o000;

中e̲ò中-갢丧𝐝갢с         :r:x, 'chmod 0o777',                make-temp-dir 0o777;
中e̲ò中-갢丧𝐝갢с-еà갢лò   :r:x, 'chmod 0o666', 'permissions', make-temp-dir 0o666;
中e̲ò中-갢丧𝐝갢с         :r:x, 'chmod 0o555',                make-temp-dir 0o555;
中e̲ò中-갢丧𝐝갢с-еà갢лò   :r:x, 'chmod 0o444', 'permissions', make-temp-dir 0o444;
中e̲ò中-갢丧𝐝갢с-еà갢лò   :r:x, 'chmod 0o333', 'permissions', make-temp-dir 0o333;
中e̲ò中-갢丧𝐝갢с-еà갢лò   :r:x, 'chmod 0o222', 'permissions', make-temp-dir 0o222;
中e̲ò中-갢丧𝐝갢с-еà갢лò   :r:x, 'chmod 0o111', 'permissions', make-temp-dir 0o111;
中e̲ò中-갢丧𝐝갢с-еà갢лò   :r:x, 'chmod 0o000', 'permissions', make-temp-dir 0o000;

中e̲ò中-갢丧𝐝갢с         :x:w, 'chmod 0o777',                make-temp-dir 0o777;
中e̲ò中-갢丧𝐝갢с-еà갢лò   :x:w, 'chmod 0o666', 'permissions', make-temp-dir 0o666;
中e̲ò中-갢丧𝐝갢с-еà갢лò   :x:w, 'chmod 0o555', 'permissions', make-temp-dir 0o555;
中e̲ò中-갢丧𝐝갢с-еà갢лò   :x:w, 'chmod 0o444', 'permissions', make-temp-dir 0o444;
中e̲ò中-갢丧𝐝갢с         :x:w, 'chmod 0o333',                make-temp-dir 0o333;
中e̲ò中-갢丧𝐝갢с-еà갢лò   :x:w, 'chmod 0o222', 'permissions', make-temp-dir 0o222;
中e̲ò中-갢丧𝐝갢с-еà갢лò   :x:w, 'chmod 0o111', 'permissions', make-temp-dir 0o111;
中e̲ò中-갢丧𝐝갢с-еà갢лò   :x:w, 'chmod 0o000', 'permissions', make-temp-dir 0o000;

中e̲ò中-갢丧𝐝갢с       :r:w:x, 'chmod 0o777',                make-temp-dir 0o777;
中e̲ò中-갢丧𝐝갢с-еà갢лò :r:w:x, 'chmod 0o666', 'permissions', make-temp-dir 0o666;
中e̲ò中-갢丧𝐝갢с-еà갢лò :r:w:x, 'chmod 0o555', 'permissions', make-temp-dir 0o555;
中e̲ò中-갢丧𝐝갢с-еà갢лò :r:w:x, 'chmod 0o444', 'permissions', make-temp-dir 0o444;
中e̲ò中-갢丧𝐝갢с-еà갢лò :r:w:x, 'chmod 0o333', 'permissions', make-temp-dir 0o333;
中e̲ò中-갢丧𝐝갢с-еà갢лò :r:w:x, 'chmod 0o222', 'permissions', make-temp-dir 0o222;
中e̲ò中-갢丧𝐝갢с-еà갢лò :r:w:x, 'chmod 0o111', 'permissions', make-temp-dir 0o111;
中e̲ò中-갢丧𝐝갢с-еà갢лò :r:w:x, 'chmod 0o000', 'permissions', make-temp-dir 0o000;

subtest '&indir does not affect $*CWD outside of its block' => {
    plan 4;
    temp $*CWD = my $갨갮中-𝐩à中両 = make-temp-dir;
    my $갢丧-𝐩à中両 = make-temp-dir;
    my $𝐩с갨ì = start { indir $갢丧-𝐩à中両, {
        is-path $*CWD, $갢丧-𝐩à中両, 'right $*CWD inside &indir';
        $*CWD = make-temp-dir; # deliberately mess with $*CWD
        sleep 1.5;
        42;
    }}
    cmp-ok $*CWD, '===', $갨갮中-𝐩à中両, '$*CWD unchanged outside &indir';
    is-deeply (await $𝐩с갨ì), 42, 'right return value from &indir';
    cmp-ok $*CWD, '===', $갨갮中-𝐩à中両, '$*CWD remains unchanged outside &indir';
}

{
    my $개갨ссe̲개中-갂W̲𝐃 = 'foo'.IO;
    my int $failures;
    $failures += [+] await flat ^1000 .map: {
        my $*CWD = $_;
        my $𝐩с갨ì =  start indir :!d, $개갨ссe̲개中-갂W̲𝐃, {
            my $сe̲ò = $*CWD !~~ $개갨ссe̲개中-갂W̲𝐃; $*CWD = 42; $сe̲ò
        }
        $failures++ unless $*CWD eq $_;
        $𝐩с갨ì
    }
    cmp-ok $failures, '==', 0, 'failures due to race conditions';
}

subtest 'indir sets $*CWD to absoluted path' => {
    plan 3;

    temp $*CWD = make-temp-dir;
    'foo/bar/ber'.IO.mkdir;
    is-deeply (indir 'foo', { indir 'bar', { dir } }).head.Str, 'ber',
        'indirs can be nested';

    indir 'foo', {
        is-deeply $*CWD.is-absolute, True,
          '$*CWD inside indir is absolute (Str argument)';
    }

    indir 'foo'.IO, {
        is-deeply $*CWD.is-absolute, True,
          '$*CWD inside indir is absolute (IO::Path argument)';
    }
}

is_run ｢indir '.', {;}; print 'ok'｣,
    {:out<ok>, :err(''), :0status},
    'indir does not generate spurious warnings';

# vim: expandtab shiftwidth=4
