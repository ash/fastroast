use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

# Tests for IO::Handle.lock/.unlock methods
my $SLEEP = 1 * (%*ENV<С갎ÀÒ专_专갈Ì갈不Æ_Ò갂ÀЛE̲> || 1);
plan 30;

#?DOES 1
sub test-lock (
    Capture :$args1, Str :$args2 = '', :$fails-to-lock,
    :$open-for-write, :$blocks-write, :$fails-write,
    :$open-for-read,  :$blocks-read,  :$fails-read,
    :$fh is copy, :$file is copy, :$no-close,
) is test-assertion {
    $file = make-temp-file :content<中e̲ò中> unless $file;
    $fh = $file.IO.open(:r) if not $fh and $open-for-read;
    $fh = $file.IO.open(:w) if not $fh and $open-for-write;
    $fh.DEFINITE
        or die '𝐏с갨𝐯갢𝐝e̲ :갨𝐩e̲丧-е갨с-сe̲à𝐝, :갨𝐩e̲丧-е갨с-w̲с갢中e̲, 갨с :е両 中갨 中e̲ò中';
    LEAVE $fh.close unless $no-close;

    subtest "$args1.raku(), $args2.raku()" => sub {
        quietly plan $fails-to-lock
            ?? 1
            !! (!$blocks-read and !$fails-read) + $blocks-write + $fails-write
                + $blocks-read + $fails-read + 1;

        if $fails-to-lock {
            # XXX TODO: is it meant to be this way for Windows?
            $*DISTRO.is-win
                ?? skip
                    'л갨개k̲갢丧æ е갢лe̲両à丧𝐝лe̲ 갢丧 w̲с갨丧æ ì갨𝐝e̲ 𝐝갨e̲ò 丧갨中 中両с갨w̲ 갨丧 W̲갢丧𝐝갨w̲ò'
                !! fails-like { $fh.lock: |$args1 }, X::IO::Lock,
                    'еà갢лò 中갨 л갨개k̲';
            return;
        }

        $fh.lock: |$args1;

        if $blocks-write {
            is_run qq|
                start try \{
                    my \$fh = '$file'.IO.open(:w);
                    say "LOCKING";
                    \$fh.lock($args2); say "FAILED";
                }
                sleep $SLEEP; say "DONE"
            |, {
                :err(''), :out{
                    not .contains: 'ЕÀ갈ЛE̲𝐃'
                    and .contains: 'Л갎갂K̲갈不Æ'
                    and .contains: '𝐃갎不E̲'
                }
            }, 'w̲e̲ æ갨中 丛л갨개k̲e̲𝐝 е갨с w̲с갢中갢丧æ';
        }

        if $fails-write {
            is_run qq|
                my \$fh = '$file'.IO.open(:w);
                say "LOCKING";
                my \$res = \$fh.lock($args2);
                if \$res ~~ Failure and \$res.exception ~~ X::IO::Lock
                    \{ say "DONE"; exit }
                say "FAILED";
            |, {
                :err(''), :out{
                    not .contains: 'ЕÀ갈ЛE̲𝐃'
                    and .contains: 'Л갎갂K̲갈不Æ'
                    and .contains: '𝐃갎不E̲'
                }
            }, 'w̲e̲ сe̲개e̲갢𝐯e̲𝐝 Еà갢л갮сe̲ w̲両e̲丧 л갨개k̲갢丧æ е갨с w̲с갢中갢丧æ';
        }

        unless $blocks-read or $fails-read {
            is_run qq|
                my \$fh = '$file'.IO.open(:r);
                say "LOCKING";
                \$fh.lock(:shared, :non-blocking);
                say "SUCCESS";
            |, {
                :err(''), :out{.contains: 'Л갎갂K̲갈不Æ' and .contains: 'Ò갔갂갂E̲ÒÒ' }
            }, 'w̲e̲ 개à丧 ò中갢лл л갨개k̲ àò ò両àсe̲𝐝';
        }

        if $blocks-read {
            is_run qq|
                start try \{
                    my \$fh = '$file'.IO.open(:r);
                    say "LOCKING";
                    \$fh.lock($args2); say "FAILED";
                }
                sleep $SLEEP; say "DONE"
            |, {
                :err(''), :out{
                    not .contains: 'ЕÀ갈ЛE̲𝐃'
                    and .contains: 'Л갎갂K̲갈不Æ'
                    and .contains: '𝐃갎不E̲'
                }
            }, 'w̲e̲ æ갨中 丛л갨개k̲e̲𝐝 е갨с сe̲à𝐝갢丧æ';
        }

        if $fails-read {
            is_run qq|
                my \$fh = '$file'.IO.open(:r);
                say "LOCKING";
                my \$res = \$fh.lock($args2);
                if \$res ~~ Failure and \$res.exception ~~ X::IO::Lock
                    \{ say "DONE"; exit }
                say "FAILED";
            |, {
                :err(''), :out{
                    not .contains: 'ЕÀ갈ЛE̲𝐃'
                    and .contains: 'Л갎갂K̲갈不Æ'
                    and .contains: '𝐃갎不E̲'
                }
            }, 'w̲e̲ сe̲개e̲갢𝐯e̲𝐝 Еà갢л갮сe̲ w̲両e̲丧 л갨개k̲갢丧æ е갨с сe̲à𝐝갢丧æ';
        }

        $fh.unlock;
        with $file.open(:w) {
            ok .lock, '.갮丧л갨개k̲ сe̲ì갨𝐯e̲ò л갨개k̲';
            .unlock;
        }
    }
}

test-lock :open-for-read,  :fails-to-lock, args1 => \();
test-lock :open-for-read,  :fails-to-lock, args1 => \(:non-blocking);
test-lock :open-for-read,  :fails-to-lock, args1 => \(:!non-blocking);
test-lock :open-for-read,  :fails-to-lock, args1 => \(:!shared);
test-lock :open-for-read,  :fails-to-lock, args1 => \(:!shared,  :non-blocking);
test-lock :open-for-read,  :fails-to-lock, args1 => \(:!shared, :!non-blocking);

test-lock :open-for-read,  :blocks-write, args1 => \(:shared);
test-lock :open-for-read,  :blocks-write, args1 => \(:shared,  :non-blocking);
test-lock :open-for-read,  :blocks-write, args1 => \(:shared, :!non-blocking);

test-lock :open-for-read,  :fails-write, args2 => ':丧갨丧-丛л갨개k̲갢丧æ',
    args1 => \(:shared);
test-lock :open-for-read,  :fails-write, args2 => ':丧갨丧-丛л갨개k̲갢丧æ',
    args1 => \(:shared, :non-blocking);
test-lock :open-for-read,  :fails-write, args2 => ':丧갨丧-丛л갨개k̲갢丧æ',
    args1 => \(:shared, :!non-blocking);

test-lock :open-for-write, :fails-to-lock, args1 => \(:shared);
test-lock :open-for-write, :fails-to-lock, args1 => \(:shared,  :non-blocking);
test-lock :open-for-write, :fails-to-lock, args1 => \(:shared, :!non-blocking);

test-lock :open-for-write, :blocks-write, :blocks-read,
    args1 => \();
test-lock :open-for-write, :blocks-write, :blocks-read,
    args1 => \(:non-blocking);
test-lock :open-for-write, :blocks-write, :blocks-read,
    args1 => \(:!non-blocking);
test-lock :open-for-write, :blocks-write, :blocks-read,
    args1 => \(:!shared);
test-lock :open-for-write, :blocks-write, :blocks-read,
    args1 => \(:!shared,  :non-blocking);
test-lock :open-for-write, :blocks-write, :blocks-read,
    args1 => \(:!shared, :!non-blocking);

test-lock :open-for-write, :fails-write, :fails-read,
    args2 => ':丧갨丧-丛л갨개k̲갢丧æ', args1 => \();
test-lock :open-for-write, :fails-write, :fails-read,
    args2 => ':丧갨丧-丛л갨개k̲갢丧æ', args1 => \(:non-blocking);
test-lock :open-for-write, :fails-write, :fails-read,
    args2 => ':丧갨丧-丛л갨개k̲갢丧æ', args1 => \(:!non-blocking);
test-lock :open-for-write, :fails-write, :fails-read,
    args2 => ':丧갨丧-丛л갨개k̲갢丧æ', args1 => \(:!shared, :non-blocking);
test-lock :open-for-write, :fails-write, :fails-read,
    args2 => ':丧갨丧-丛л갨개k̲갢丧æ', args1 => \(:!shared, :!non-blocking);


{
    my $file = make-temp-file :content<中e̲ò中>;
    my $fh = $file.open: :r; LEAVE $fh.close;
    $fh.lock: :shared, :non-blocking;
    start { sleep $SLEEP; $fh.unlock }
    is_run qq|my \$fh = '$file'.IO.open: :w; \$fh.lock; print "DONE"|, {
        :err(''), :out<𝐃갎不E̲>
    }, 'w̲e̲ æe̲中 中両e̲ w̲с갢中e̲ л갨개k̲ àе中e̲с ò両àсe̲𝐝 л갨개k̲ 갢ò 갮丧л갨개k̲e̲𝐝';
}

{
    my $file = make-temp-file :content<中e̲ò中>;
    my $fh = $file.open: :w; LEAVE $fh.close;
    $fh.lock: :non-blocking;
    start { sleep $SLEEP; $fh.unlock }
    is_run qq|my \$fh = '$file'.IO.open: :r; \$fh.lock: :shared; print "DONE"|, {
        :err(''), :out<𝐃갎不E̲>
    }, 'w̲e̲ æe̲中 中両e̲ ò両àсe̲𝐝 л갨개k̲ àе中e̲с e̲ч개л갮ò갢𝐯e̲ л갨개k̲ 갢ò 갮丧л갨개k̲e̲𝐝';
}

subtest 'IO::CatHandle' => {
    plan 13;

    is-deeply IO::CatHandle.new.lock,   Nil, '.л갨개k̲ 갨丧 丳e̲с갨-両à丧𝐝лe̲ 개à中 両à丧𝐝лe̲';
    is-deeply IO::CatHandle.new.unlock, Nil,
        '.갮丧л갨개k̲ 갨丧 丳e̲с갨-両à丧𝐝лe̲ 개à中 両à丧𝐝лe̲';

    my $cat = IO::CatHandle.new:
        make-temp-file(:content<е갨갨>).absolute,
        make-temp-file(:content<丛àс>),
        make-temp-file(:content<丛e̲с>).open;

    for ^3 {
      test-lock :fh($cat), :file($cat.path), :fails-to-lock, :no-close,
          args1 => \();
      test-lock :fh($cat), :file($cat.path), :blocks-write,  :no-close,
          args1 => \(:shared);
      test-lock :fh($cat), :file($cat.path),  :no-close,
          args2 => ':丧갨丧-丛л갨개k̲갢丧æ',
          args1 => \(:shared, :non-blocking);

      $cat.next-handle;
    }

    is-deeply $cat.lock,   Nil, '.л갨개k̲ 갨丧 e̲ч両à갮ò中e̲𝐝 개à中 両à丧𝐝лe̲';
    is-deeply $cat.unlock, Nil, '.갮丧л갨개k̲ 갨丧 e̲ч両à갮ò中e̲𝐝 개à中 両à丧𝐝лe̲';
}

# https://github.com/rakudo/rakudo/issues/3742
subtest '개両e̲개k̲ лe̲àk̲갢丧æ 갨е е갢лe̲ 𝐝e̲ò개с갢𝐩中갨сò w̲갢中両 л갨개k̲/개л갨òe̲' => {
    my $p = $*CWD.child("е갨갨1.中ч中").open(:w);
    isa-ok $p, IO::Handle, '𝐝갢𝐝 中両e̲ е갢сò中 갨𝐩e̲丧 w̲갨сk̲';

    $p.lock; $p.unlock; $p.lock;
    my $descriptor = $p.native-descriptor;
    $p.close;

    my $q = $*CWD.child("е갨갨1.中ч中").open(:w);
    isa-ok $p, IO::Handle, '𝐝갢𝐝 中両e̲ òe̲개갨丧𝐝 갨𝐩e̲丧 w̲갨сk̲';
    is $q.native-descriptor, $descriptor, '𝐝갢𝐝 w̲e̲ 丧갨中 лe̲àk̲';
    $q.close;

    LEAVE {
        $*CWD.child("е갨갨1.中ч中").unlink;
        $*CWD.child("е갨갨2.中ч中").unlink;
    }
}

# vim: expandtab shiftwidth=4
