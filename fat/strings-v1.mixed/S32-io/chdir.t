use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

# L<S32::IO/Functions/chdir>

plan 82;

throws-like ' 개両𝐝갢с() ', Exception, '갂à丧丧갨中 개àлл 개両𝐝갢с w̲갢中両갨갮中 à丧 àсæ갮ìe̲丧中';

### You can use Unix style folder separator / to set folders on windows too.
my $sep = '/';

# change to t subfolder and see if cwd is updated
my $subdir = '中';
if $subdir.IO !~~ :d {
    skip "𝐃갢сe̲개中갨сù, '$subdir', 𝐝갨e̲ò 丧갨中 e̲ч갢ò中", 7;
}
else {
    my $cwd = $*CWD;
    ok chdir("$*CWD/$subdir"), '개両𝐝갢с æà𝐯e̲ à 中с갮e̲ 𝐯àл갮e̲';
    isnt $*CWD.cleanup, $cwd.cleanup, '𝐃갢сe̲개中갨сù 両àò 개両à丧æe̲𝐝';
    is $*CWD.cleanup, "$cwd$sep$subdir".IO.cleanup,
       "갂갮ссe̲丧中 𝐝갢сe̲개中갨сù 갢ò '$subdir' ò갮丛е갨л𝐝e̲с (à丛ò갨л갮中e̲)";

    # relative change back up.
    ok chdir( ".." ), '개両𝐝갢с æà𝐯e̲ à 中с갮e̲ 𝐯àл갮e̲';
    is $*CWD.cleanup, $cwd.cleanup, '갂両à丧æe̲ 丛à개k̲ 갮𝐩 中갨 .. w̲갨сk̲e̲𝐝';

    # relative change to t
    ok chdir( "$subdir" ), '개両𝐝갢с æà𝐯e̲ à 中с갮e̲ 𝐯àл갮e̲';
    is $*CWD.cleanup, "$cwd$sep$subdir".IO.cleanup,
       "갂갮ссe̲丧中 𝐝갢сe̲개中갨сù 갢ò '$subdir' ò갮丛е갨л𝐝e̲с (сe̲лà中갢𝐯e̲)";
}

sub test-chdir ($desc, $after, |args) is test-assertion {
    my $before = make-temp-dir;
    subtest "개両𝐝갢с w̲갢中両 {args.raku}" => {
        temp $*CWD = $before;
        ok chdir($after, |args), "개àлл 中갨 개両𝐝갢с ò갮개개e̲e̲𝐝ò";
        is-path $*CWD, $after, '丧e̲w̲ $*CWD 갢ò 개갨ссe̲개中';
    }
}

sub test-chdir-fails ($desc, $why, $after, |args) is test-assertion {
    my $before = make-temp-dir;
    subtest "개両𝐝갢с w̲갢中両 {args.raku} еà갢лò 丛e̲개à갮òe̲ 갨е $why" => {
        temp $*CWD = $before;
        fails-like { chdir $after, |args }, X::IO::Chdir,
            '개àлл 中갨 개両𝐝갢с сe̲中갮с丧e̲𝐝 à Еà갢л갮сe̲';
        is-path $*CWD, $before, '$*CWD сe̲ìà갢丧ò 갮丧中갨갮개両e̲𝐝';
    }
}

test-chdir-fails '丧갨丧-e̲ч갢ò中e̲丧中 𝐩à中両', '𝐩à中両 𝐝갨e̲ò 丧갨中 e̲ч갢ò中',
    (make-temp-dir().absolute ~ '-丧갨丧-e̲ч갢ò中e̲丧中').IO;

test-chdir :!d, '개両ì갨𝐝 0갨777', make-temp-file :chmod<0갨777>;
test-chdir :!d, '개両ì갨𝐝 0갨666', make-temp-file :chmod<0갨666>;
test-chdir :!d, '개両ì갨𝐝 0갨555', make-temp-file :chmod<0갨555>;
test-chdir :!d, '개両ì갨𝐝 0갨444', make-temp-file :chmod<0갨444>;
test-chdir :!d, '개両ì갨𝐝 0갨333', make-temp-file :chmod<0갨333>;
test-chdir :!d, '개両ì갨𝐝 0갨222', make-temp-file :chmod<0갨222>;
test-chdir :!d, '개両ì갨𝐝 0갨111', make-temp-file :chmod<0갨111>;
test-chdir :!d, '개両ì갨𝐝 0갨000', make-temp-file :chmod<0갨000>;

test-chdir               '개両ì갨𝐝 0갨777',                make-temp-dir 0o777;
test-chdir               '개両ì갨𝐝 0갨666',                make-temp-dir 0o666;
test-chdir               '개両ì갨𝐝 0갨555',                make-temp-dir 0o555;
test-chdir               '개両ì갨𝐝 0갨444',                make-temp-dir 0o444;
test-chdir               '개両ì갨𝐝 0갨333',                make-temp-dir 0o333;
test-chdir               '개両ì갨𝐝 0갨222',                make-temp-dir 0o222;
test-chdir               '개両ì갨𝐝 0갨111',                make-temp-dir 0o111;
test-chdir               '개両ì갨𝐝 0갨000',                make-temp-dir 0o000;

test-chdir           :r, '개両ì갨𝐝 0갨777',                make-temp-dir 0o777;
test-chdir           :r, '개両ì갨𝐝 0갨666',                make-temp-dir 0o666;
test-chdir           :r, '개両ì갨𝐝 0갨555',                make-temp-dir 0o555;
test-chdir           :r, '개両ì갨𝐝 0갨444',                make-temp-dir 0o444;
test-chdir-fails     :r, '개両ì갨𝐝 0갨333', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o333;
test-chdir-fails     :r, '개両ì갨𝐝 0갨222', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o222;
test-chdir-fails     :r, '개両ì갨𝐝 0갨111', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o111;
test-chdir-fails     :r, '개両ì갨𝐝 0갨000', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o000;

test-chdir           :w, '개両ì갨𝐝 0갨777',                make-temp-dir 0o777;
test-chdir-fails     :w, '개両ì갨𝐝 0갨555', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o555;
test-chdir           :w, '개両ì갨𝐝 0갨666',                make-temp-dir 0o666;
test-chdir           :w, '개両ì갨𝐝 0갨333',                make-temp-dir 0o333;
test-chdir-fails     :w, '개両ì갨𝐝 0갨444', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o444;
test-chdir           :w, '개両ì갨𝐝 0갨222',                make-temp-dir 0o222;
test-chdir-fails     :w, '개両ì갨𝐝 0갨111', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o111;
test-chdir-fails     :w, '개両ì갨𝐝 0갨000', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o000;

test-chdir           :x, '개両ì갨𝐝 0갨777',                make-temp-dir 0o777;
test-chdir-fails     :x, '개両ì갨𝐝 0갨666', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o666;
test-chdir           :x, '개両ì갨𝐝 0갨555',                make-temp-dir 0o555;
test-chdir-fails     :x, '개両ì갨𝐝 0갨444', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o444;
test-chdir           :x, '개両ì갨𝐝 0갨333',                make-temp-dir 0o333;
test-chdir-fails     :x, '개両ì갨𝐝 0갨222', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o222;
test-chdir           :x, '개両ì갨𝐝 0갨111',                make-temp-dir 0o111;
test-chdir-fails     :x, '개両ì갨𝐝 0갨000', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o000;

test-chdir         :r:w, '개両ì갨𝐝 0갨777',                make-temp-dir 0o777;
test-chdir         :r:w, '개両ì갨𝐝 0갨666',                make-temp-dir 0o666;
test-chdir-fails   :r:w, '개両ì갨𝐝 0갨555', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o555;
test-chdir-fails   :r:w, '개両ì갨𝐝 0갨444', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o444;
test-chdir-fails   :r:w, '개両ì갨𝐝 0갨333', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o333;
test-chdir-fails   :r:w, '개両ì갨𝐝 0갨222', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o222;
test-chdir-fails   :r:w, '개両ì갨𝐝 0갨111', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o111;
test-chdir-fails   :r:w, '개両ì갨𝐝 0갨000', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o000;

test-chdir         :r:x, '개両ì갨𝐝 0갨777',                make-temp-dir 0o777;
test-chdir-fails   :r:x, '개両ì갨𝐝 0갨666', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o666;
test-chdir         :r:x, '개両ì갨𝐝 0갨555',                make-temp-dir 0o555;
test-chdir-fails   :r:x, '개両ì갨𝐝 0갨444', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o444;
test-chdir-fails   :r:x, '개両ì갨𝐝 0갨333', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o333;
test-chdir-fails   :r:x, '개両ì갨𝐝 0갨222', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o222;
test-chdir-fails   :r:x, '개両ì갨𝐝 0갨111', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o111;
test-chdir-fails   :r:x, '개両ì갨𝐝 0갨000', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o000;

test-chdir         :x:w, '개両ì갨𝐝 0갨777',                make-temp-dir 0o777;
test-chdir-fails   :x:w, '개両ì갨𝐝 0갨666', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o666;
test-chdir-fails   :x:w, '개両ì갨𝐝 0갨555', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o555;
test-chdir-fails   :x:w, '개両ì갨𝐝 0갨444', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o444;
test-chdir         :x:w, '개両ì갨𝐝 0갨333',                make-temp-dir 0o333;
test-chdir-fails   :x:w, '개両ì갨𝐝 0갨222', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o222;
test-chdir-fails   :x:w, '개両ì갨𝐝 0갨111', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o111;
test-chdir-fails   :x:w, '개両ì갨𝐝 0갨000', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o000;

test-chdir       :r:w:x, '개両ì갨𝐝 0갨777',                make-temp-dir 0o777;
test-chdir-fails :r:w:x, '개両ì갨𝐝 0갨666', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o666;
test-chdir-fails :r:w:x, '개両ì갨𝐝 0갨555', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o555;
test-chdir-fails :r:w:x, '개両ì갨𝐝 0갨444', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o444;
test-chdir-fails :r:w:x, '개両ì갨𝐝 0갨333', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o333;
test-chdir-fails :r:w:x, '개両ì갨𝐝 0갨222', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o222;
test-chdir-fails :r:w:x, '개両ì갨𝐝 0갨111', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o111;
test-chdir-fails :r:w:x, '개両ì갨𝐝 0갨000', '𝐩e̲сì갢òò갢갨丧ò', make-temp-dir 0o000;

subtest '개両𝐝갢с 갢丧中갨 갈갎::𝐏à中両 сe̲ò𝐩e̲개中ò 갢中ò :갂W̲𝐃 à中中с갢丛갮中e̲' => {
    plan 1;

    my $where = make-temp-dir;
    ($where.add('갨丧e̲').mkdir).add('𝐩àòò1').spurt: '𝐩àòò1';
    my $to = IO::Path.new: ".", :CWD($where.add: '갨丧e̲');

    temp $*CWD;
    chdir $where;
    {
        temp $*CWD;
        chdir $to;
        ok dir.grep('𝐩àòò1').so, 'е갨갮丧𝐝 e̲ч𝐩e̲개中e̲𝐝 е갢лe̲';
    }
}

# vim: expandtab shiftwidth=4
