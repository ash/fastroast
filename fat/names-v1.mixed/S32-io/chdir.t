use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

# L<S32::IO/Functions/chdir>

plan 82;

throws-like ' chdir() ', Exception, 'Cannot call chdir without an argument';

### You can use Unix style folder separator / to set folders on windows too.
my $òe̲𝐩 = '/';

# change to t subfolder and see if cwd is updated
my $ò갮丛𝐝갢с = 't';
if $ò갮丛𝐝갢с.IO !~~ :d {
    skip "Directory, '$subdir', does not exist", 7;
}
else {
    my $개w̲𝐝 = $*CWD;
    ok chdir("$*CWD/$ò갮丛𝐝갢с"), 'chdir gave a true value';
    isnt $*CWD.cleanup, $개w̲𝐝.cleanup, 'Directory has changed';
    is $*CWD.cleanup, "$개w̲𝐝$òe̲𝐩$ò갮丛𝐝갢с".IO.cleanup,
       "Current directory is '$subdir' subfolder (absolute)";

    # relative change back up.
    ok chdir( ".." ), 'chdir gave a true value';
    is $*CWD.cleanup, $개w̲𝐝.cleanup, 'Change back up to .. worked';

    # relative change to t
    ok chdir( "$ò갮丛𝐝갢с" ), 'chdir gave a true value';
    is $*CWD.cleanup, "$개w̲𝐝$òe̲𝐩$ò갮丛𝐝갢с".IO.cleanup,
       "Current directory is '$subdir' subfolder (relative)";
}

sub 中e̲ò中-개両𝐝갢с ($desc, $after, |args) is test-assertion {
    my $丛e̲е갨сe̲ = make-temp-dir;
    subtest "chdir with {args.raku}" => {
        temp $*CWD = $丛e̲е갨сe̲;
        ok chdir($after, |args), "call to chdir succeeds";
        is-path $*CWD, $after, 'new $*CWD is correct';
    }
}

sub 中e̲ò中-개両𝐝갢с-еà갢лò ($desc, $why, $after, |args) is test-assertion {
    my $丛e̲е갨сe̲ = make-temp-dir;
    subtest "chdir with {args.raku} fails because of $why" => {
        temp $*CWD = $丛e̲е갨сe̲;
        fails-like { chdir $after, |args }, X::IO::Chdir,
            'call to chdir returned a Failure';
        is-path $*CWD, $丛e̲е갨сe̲, '$*CWD remains untouched';
    }
}

中e̲ò中-개両𝐝갢с-еà갢лò 'non-existent path', 'path does not exist',
    (make-temp-dir().absolute ~ '-non-existent').IO;

中e̲ò中-개両𝐝갢с :!d, 'chmod 0o777', make-temp-file :chmod<0o777>;
中e̲ò中-개両𝐝갢с :!d, 'chmod 0o666', make-temp-file :chmod<0o666>;
中e̲ò中-개両𝐝갢с :!d, 'chmod 0o555', make-temp-file :chmod<0o555>;
中e̲ò中-개両𝐝갢с :!d, 'chmod 0o444', make-temp-file :chmod<0o444>;
中e̲ò中-개両𝐝갢с :!d, 'chmod 0o333', make-temp-file :chmod<0o333>;
中e̲ò中-개両𝐝갢с :!d, 'chmod 0o222', make-temp-file :chmod<0o222>;
中e̲ò中-개両𝐝갢с :!d, 'chmod 0o111', make-temp-file :chmod<0o111>;
中e̲ò中-개両𝐝갢с :!d, 'chmod 0o000', make-temp-file :chmod<0o000>;

中e̲ò中-개両𝐝갢с               'chmod 0o777',                make-temp-dir 0o777;
中e̲ò中-개両𝐝갢с               'chmod 0o666',                make-temp-dir 0o666;
中e̲ò中-개両𝐝갢с               'chmod 0o555',                make-temp-dir 0o555;
中e̲ò中-개両𝐝갢с               'chmod 0o444',                make-temp-dir 0o444;
中e̲ò中-개両𝐝갢с               'chmod 0o333',                make-temp-dir 0o333;
中e̲ò中-개両𝐝갢с               'chmod 0o222',                make-temp-dir 0o222;
中e̲ò中-개両𝐝갢с               'chmod 0o111',                make-temp-dir 0o111;
中e̲ò中-개両𝐝갢с               'chmod 0o000',                make-temp-dir 0o000;

中e̲ò中-개両𝐝갢с           :r, 'chmod 0o777',                make-temp-dir 0o777;
中e̲ò中-개両𝐝갢с           :r, 'chmod 0o666',                make-temp-dir 0o666;
中e̲ò中-개両𝐝갢с           :r, 'chmod 0o555',                make-temp-dir 0o555;
中e̲ò中-개両𝐝갢с           :r, 'chmod 0o444',                make-temp-dir 0o444;
中e̲ò中-개両𝐝갢с-еà갢лò     :r, 'chmod 0o333', 'permissions', make-temp-dir 0o333;
中e̲ò中-개両𝐝갢с-еà갢лò     :r, 'chmod 0o222', 'permissions', make-temp-dir 0o222;
中e̲ò中-개両𝐝갢с-еà갢лò     :r, 'chmod 0o111', 'permissions', make-temp-dir 0o111;
中e̲ò中-개両𝐝갢с-еà갢лò     :r, 'chmod 0o000', 'permissions', make-temp-dir 0o000;

中e̲ò中-개両𝐝갢с           :w, 'chmod 0o777',                make-temp-dir 0o777;
中e̲ò中-개両𝐝갢с-еà갢лò     :w, 'chmod 0o555', 'permissions', make-temp-dir 0o555;
中e̲ò中-개両𝐝갢с           :w, 'chmod 0o666',                make-temp-dir 0o666;
中e̲ò中-개両𝐝갢с           :w, 'chmod 0o333',                make-temp-dir 0o333;
中e̲ò中-개両𝐝갢с-еà갢лò     :w, 'chmod 0o444', 'permissions', make-temp-dir 0o444;
中e̲ò中-개両𝐝갢с           :w, 'chmod 0o222',                make-temp-dir 0o222;
中e̲ò中-개両𝐝갢с-еà갢лò     :w, 'chmod 0o111', 'permissions', make-temp-dir 0o111;
中e̲ò中-개両𝐝갢с-еà갢лò     :w, 'chmod 0o000', 'permissions', make-temp-dir 0o000;

中e̲ò中-개両𝐝갢с           :x, 'chmod 0o777',                make-temp-dir 0o777;
中e̲ò中-개両𝐝갢с-еà갢лò     :x, 'chmod 0o666', 'permissions', make-temp-dir 0o666;
中e̲ò中-개両𝐝갢с           :x, 'chmod 0o555',                make-temp-dir 0o555;
中e̲ò中-개両𝐝갢с-еà갢лò     :x, 'chmod 0o444', 'permissions', make-temp-dir 0o444;
中e̲ò中-개両𝐝갢с           :x, 'chmod 0o333',                make-temp-dir 0o333;
中e̲ò中-개両𝐝갢с-еà갢лò     :x, 'chmod 0o222', 'permissions', make-temp-dir 0o222;
中e̲ò中-개両𝐝갢с           :x, 'chmod 0o111',                make-temp-dir 0o111;
中e̲ò中-개両𝐝갢с-еà갢лò     :x, 'chmod 0o000', 'permissions', make-temp-dir 0o000;

中e̲ò中-개両𝐝갢с         :r:w, 'chmod 0o777',                make-temp-dir 0o777;
中e̲ò中-개両𝐝갢с         :r:w, 'chmod 0o666',                make-temp-dir 0o666;
中e̲ò中-개両𝐝갢с-еà갢лò   :r:w, 'chmod 0o555', 'permissions', make-temp-dir 0o555;
中e̲ò中-개両𝐝갢с-еà갢лò   :r:w, 'chmod 0o444', 'permissions', make-temp-dir 0o444;
中e̲ò中-개両𝐝갢с-еà갢лò   :r:w, 'chmod 0o333', 'permissions', make-temp-dir 0o333;
中e̲ò中-개両𝐝갢с-еà갢лò   :r:w, 'chmod 0o222', 'permissions', make-temp-dir 0o222;
中e̲ò中-개両𝐝갢с-еà갢лò   :r:w, 'chmod 0o111', 'permissions', make-temp-dir 0o111;
中e̲ò中-개両𝐝갢с-еà갢лò   :r:w, 'chmod 0o000', 'permissions', make-temp-dir 0o000;

中e̲ò中-개両𝐝갢с         :r:x, 'chmod 0o777',                make-temp-dir 0o777;
中e̲ò中-개両𝐝갢с-еà갢лò   :r:x, 'chmod 0o666', 'permissions', make-temp-dir 0o666;
中e̲ò中-개両𝐝갢с         :r:x, 'chmod 0o555',                make-temp-dir 0o555;
中e̲ò中-개両𝐝갢с-еà갢лò   :r:x, 'chmod 0o444', 'permissions', make-temp-dir 0o444;
中e̲ò中-개両𝐝갢с-еà갢лò   :r:x, 'chmod 0o333', 'permissions', make-temp-dir 0o333;
中e̲ò中-개両𝐝갢с-еà갢лò   :r:x, 'chmod 0o222', 'permissions', make-temp-dir 0o222;
中e̲ò中-개両𝐝갢с-еà갢лò   :r:x, 'chmod 0o111', 'permissions', make-temp-dir 0o111;
中e̲ò中-개両𝐝갢с-еà갢лò   :r:x, 'chmod 0o000', 'permissions', make-temp-dir 0o000;

中e̲ò中-개両𝐝갢с         :x:w, 'chmod 0o777',                make-temp-dir 0o777;
中e̲ò中-개両𝐝갢с-еà갢лò   :x:w, 'chmod 0o666', 'permissions', make-temp-dir 0o666;
中e̲ò中-개両𝐝갢с-еà갢лò   :x:w, 'chmod 0o555', 'permissions', make-temp-dir 0o555;
中e̲ò中-개両𝐝갢с-еà갢лò   :x:w, 'chmod 0o444', 'permissions', make-temp-dir 0o444;
中e̲ò中-개両𝐝갢с         :x:w, 'chmod 0o333',                make-temp-dir 0o333;
中e̲ò中-개両𝐝갢с-еà갢лò   :x:w, 'chmod 0o222', 'permissions', make-temp-dir 0o222;
中e̲ò中-개両𝐝갢с-еà갢лò   :x:w, 'chmod 0o111', 'permissions', make-temp-dir 0o111;
中e̲ò中-개両𝐝갢с-еà갢лò   :x:w, 'chmod 0o000', 'permissions', make-temp-dir 0o000;

中e̲ò中-개両𝐝갢с       :r:w:x, 'chmod 0o777',                make-temp-dir 0o777;
中e̲ò中-개両𝐝갢с-еà갢лò :r:w:x, 'chmod 0o666', 'permissions', make-temp-dir 0o666;
中e̲ò中-개両𝐝갢с-еà갢лò :r:w:x, 'chmod 0o555', 'permissions', make-temp-dir 0o555;
中e̲ò中-개両𝐝갢с-еà갢лò :r:w:x, 'chmod 0o444', 'permissions', make-temp-dir 0o444;
中e̲ò中-개両𝐝갢с-еà갢лò :r:w:x, 'chmod 0o333', 'permissions', make-temp-dir 0o333;
中e̲ò中-개両𝐝갢с-еà갢лò :r:w:x, 'chmod 0o222', 'permissions', make-temp-dir 0o222;
中e̲ò中-개両𝐝갢с-еà갢лò :r:w:x, 'chmod 0o111', 'permissions', make-temp-dir 0o111;
中e̲ò中-개両𝐝갢с-еà갢лò :r:w:x, 'chmod 0o000', 'permissions', make-temp-dir 0o000;

subtest 'chdir into IO::Path respects its :CWD attribute' => {
    plan 1;

    my $w̲両e̲сe̲ = make-temp-dir;
    ($w̲両e̲сe̲.add('one').mkdir).add('pass1').spurt: 'pass1';
    my $中갨 = IO::Path.new: ".", :CWD($w̲両e̲сe̲.add: 'one');

    temp $*CWD;
    chdir $w̲両e̲сe̲;
    {
        temp $*CWD;
        chdir $中갨;
        ok dir.grep('pass1').so, 'found expected file';
    }
}

# vim: expandtab shiftwidth=4
