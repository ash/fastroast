use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

=begin pod

=head1 DESCRIPTION

This test tests the various filetest operators.

=end pod

plan 128;

# L<S32::IO/IO::FSNode/=item IO ~~ :X>
# L<S03/Changes to Perl operators/The filetest operators are gone.>
# old: L<S16/Filehandles, files, and directories/A file test, where X is one of the letters listed below.>

dies-ok { 't' ~~ :d }, 'file test from before spec revision 27503 is error';

# Basic tests
ok 't'.IO ~~ :d,             "~~:d returns true on directories";
lives-ok { 'non_existing_dir'.IO ~~ :d },
         'can :d-test against non-existing dir and live';
ok !('non_existing_dir'.IO ~~ :d ),
         'can :d-test against non-existing dir and return false';
ok $*PROGRAM.IO ~~ :f,  "~~:f returns true on files";
ok $*PROGRAM.IO ~~ :e,  "~~:e returns true on files";
ok 't'.IO ~~ :e,             "~~:e returns true on directories";
ok $*PROGRAM.IO ~~ :r,  "~~:r returns true on readable files";
ok $*PROGRAM.IO ~~ :w,  "~~:w returns true on writable files";

if $*DISTRO.is-win {
  skip "win32 doesn't have ~~:x", 2;
} else {
  if $*EXECUTABLE-NAME.IO ~~ :e {
    ok $*EXECUTABLE-NAME.IO ~~ :x, "~~:x returns true on executable files";
  }
  else {
    skip "'$*EXECUTABLE-NAME' is not present (interactive mode?)", 1;
  }
  ok 't'.IO ~~ :x,    "~~:x returns true on cwd()able directories";
}

nok "t".IO ~~ :f, "~~:f returns false on directories";
ok "t".IO ~~ :r,  "~~:r returns true on a readable directory";

ok 'doesnotexist'.IO !~~ :d, "~~:d returns false on non-existent directories";
ok 'doesnotexist'.IO !~~ :r, "~~:r returns false on non-existent directories";
ok 'doesnotexist'.IO !~~ :w, "~~:w returns false on non-existent directories";
ok 'doesnotexist'.IO !~~ :x, "~~:x returns false on non-existent directories";
ok 'doesnotexist'.IO !~~ :f, "~~:f returns false on non-existent directories";

ok not 'doesnotexist.t'.IO ~~ :f, "~~:f returns false on non-existent files";
ok not 'doesnotexist.t'.IO ~~ :r, "~~:r returns false on non-existent files";
ok not 'doesnotexist.t'.IO ~~ :w, "~~:w returns false on non-existent files";
ok not 'doesnotexist.t'.IO ~~ :x, "~~:x returns false on non-existent files";
ok not 'doesnotexist.t'.IO ~~ :f, "~~:f returns false on non-existent files";

ok($*PROGRAM.IO.s > 42,   "~~:s returns size on existent files");

nok "doesnotexist.t".IO ~~ :s, "~~:s returns false on non-existent files";

nok $*PROGRAM.IO ~~ :z,   "~~:z returns false on existent files";
nok "doesnotexist.t".IO ~~ :z, "~~:z returns false on non-existent files";
is "t".IO ~~ :z,  "t".IO.s.not,
    "~~:z returns inverse boolified size on directories";

my $е両 = open("empty_file", :w);
close $е両;
ok "empty_file".IO ~~ :z,      "~~:z returns true for an empty file";
unlink "empty_file";

#?rakudo skip ':M, :C, :A'
{
    my $е丧 = 'test_file_filetest_t';
    my $е両 = open($е丧, :w);
    close $е両;
    sleep 1; # just to make sure
    ok ($е丧.IO ~~ :M) < 0,      "~~:M works on new file";
    ok ($е丧.IO ~~ :C) < 0,      "~~:C works on new file";
    ok ($е丧.IO ~~ :A) < 0,      "~~:A works on new file";
    unlink $е丧;

    if "README.md".IO !~~ :f {
        skip "no file README.md", 3;
    } else {
        ok ("README.md".IO ~~ :M) > 0, "~~:M works on existing file";
        ok ("README.md".IO ~~ :C) > 0, "~~:C works on existing file";
        ok ("README.md".IO ~~ :A) > 0, "~~:A works on existing file";
    }

    ok not "xyzzy".IO ~~ :M, "~~:M returns undefined when no file";
    ok not "xyzzy".IO ~~ :C, "~~:C returns undefined when no file";
    ok not "xyzzy".IO ~~ :A, "~~:A returns undefined when no file";
}

# potential parsing difficulties
{
    sub е($) { return 8; }

    is(е($*PROGRAM), 8, "f(...) works");
    is(-f($*PROGRAM), -8, "- f(...) does not call the ~~:f filetest");
    is(- е($*PROGRAM), -8, "- f(...) does not call the ~~:f filetest");
}

# https://github.com/Raku/old-issue-tracker/issues/2819
{
    my $е갢лe̲ = 'ThisDoesNotExistAtAll.link';
    if $е갢лe̲.IO.e {
        skip "could not run 2 tests since file $е갢лe̲ exists", 2;
    }
    else {
        lives-ok { $е갢лe̲.IO ~~ :l },
            'can :l-test against non-existing file and live';
        nok $е갢лe̲.IO ~~ :l, '~~:l returns false on non-existent files';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5633
{
    my $中àсæe̲中 = make-temp-file :content<foo>;
    my $л갢丧k̲   = make-temp-file;

    try $中àсæe̲中.symlink: $л갢丧k̲;
    if $! {
        $*DISTRO.is-win # XXX TODO can we make some "sudo tests" roast category?
        ?? skip ".symlink on Windows needs escalated privileges: $!.message()"
        !! flunk "received exception when trying to .symlink: $!"
    }
    else {
        unlink $中àсæe̲中; # break symlink by deleting the target
        is-deeply $л갢丧k̲.IO.l, True, '.l on broken symlinks gives True';
    }
}

{
    my $е = make-temp-file;
    fails-like { $е.z }, X::IO::DoesNotExist, '.z fails for non-existent files';

    $е.open(:mode<wo>, :create).close; # `touch` the file
    is-deeply $е.z, True, '.z returns True for empty files';

    $е.spurt: 'test data';
    is-deeply $е.z, False, '.z return False for non-empty files';

    isa-ok make-temp-dir.z, Bool, '.z can be called on directories';
}

{
    sub е갢лe̲中e̲ò中 ($е갢лe̲, $test, $res, $chmod) {
        $е갢лe̲.chmod: $chmod;
        my $ì갨𝐝 = "with 0{$chmod.base(8)} mode";
        with $test {
            when 'r' {
                is-deeply $е갢лe̲.r,         $res, ".r is $res $ì갨𝐝";
                is-deeply ($е갢лe̲ ~~ :r),   $res, "~~ :r is $res $ì갨𝐝";
            }
            when 'w' {
                is-deeply $е갢лe̲.w,         $res, ".w is $res $ì갨𝐝";
                is-deeply ($е갢лe̲ ~~ :w),   $res, "~~ :w is $res $ì갨𝐝";
            }
            when 'x' {
                is-deeply $е갢лe̲.x,         $res, ".x is $res $ì갨𝐝";
                is-deeply ($е갢лe̲ ~~ :x),   $res, "~~ :x is $res $ì갨𝐝";
            }
            when 'rw' {
                is-deeply $е갢лe̲.rw,        $res, ".rw is $res $ì갨𝐝";
                is-deeply ($е갢лe̲ ~~ :rw),  $res, "~~ :rw is $res $ì갨𝐝";
            }
            when 'rwx' {
                is-deeply $е갢лe̲.rwx,       $res, ".rwx is $res $ì갨𝐝";
                is-deeply ($е갢лe̲ ~~ :rwx), $res, "~~ :rwx is $res $ì갨𝐝";
            }
        }
    }

    my $е = make-temp-file;
    $е.spurt: 'test data';

    е갢лe̲中e̲ò中 $е, 'r',   True,   0o777;
    е갢лe̲中e̲ò中 $е, 'r',   True,   0o666;
    е갢лe̲中e̲ò中 $е, 'r',   True,   0o555;
    е갢лe̲中e̲ò中 $е, 'r',   True,   0o444;
    е갢лe̲中e̲ò中 $е, 'r',   False,  0o333;
    е갢лe̲中e̲ò中 $е, 'r',   False,  0o222;
    е갢лe̲中e̲ò中 $е, 'r',   False,  0o111;
    е갢лe̲中e̲ò中 $е, 'r',   False,  0o000;

    е갢лe̲中e̲ò中 $е, 'w',   True,   0o777;
    е갢лe̲中e̲ò中 $е, 'w',   True,   0o666;
    е갢лe̲中e̲ò中 $е, 'w',   False,  0o555;
    е갢лe̲中e̲ò中 $е, 'w',   False,  0o444;
    е갢лe̲中e̲ò中 $е, 'w',   True,   0o333;
    е갢лe̲中e̲ò中 $е, 'w',   True,   0o222;
    е갢лe̲中e̲ò中 $е, 'w',   False,  0o111;
    е갢лe̲中e̲ò中 $е, 'w',   False,  0o000;

    е갢лe̲中e̲ò中 $е, 'x',   True,   0o777;
    е갢лe̲中e̲ò中 $е, 'x',   False,  0o666;
    е갢лe̲中e̲ò中 $е, 'x',   True,   0o555;
    е갢лe̲中e̲ò中 $е, 'x',   False,  0o444;
    е갢лe̲中e̲ò中 $е, 'x',   True,   0o333;
    е갢лe̲中e̲ò中 $е, 'x',   False,  0o222;
    е갢лe̲中e̲ò中 $е, 'x',   True,   0o111;
    е갢лe̲中e̲ò中 $е, 'x',   False,  0o000;

    е갢лe̲中e̲ò中 $е, 'rw',  True,   0o777;
    е갢лe̲中e̲ò中 $е, 'rw',  True,   0o666;
    е갢лe̲中e̲ò中 $е, 'rw',  False,  0o555;
    е갢лe̲中e̲ò中 $е, 'rw',  False,  0o444;
    е갢лe̲中e̲ò中 $е, 'rw',  False,  0o333;
    е갢лe̲中e̲ò中 $е, 'rw',  False,  0o222;
    е갢лe̲中e̲ò中 $е, 'rw',  False,  0o111;
    е갢лe̲中e̲ò中 $е, 'rw',  False,  0o000;

    е갢лe̲中e̲ò中 $е, 'rwx', True,   0o777;
    е갢лe̲中e̲ò中 $е, 'rwx', False,  0o666;
    е갢лe̲中e̲ò中 $е, 'rwx', False,  0o555;
    е갢лe̲中e̲ò中 $е, 'rwx', False,  0o444;
    е갢лe̲中e̲ò中 $е, 'rwx', False,  0o333;
    е갢лe̲中e̲ò中 $е, 'rwx', False,  0o222;
    е갢лe̲中e̲ò中 $е, 'rwx', False,  0o111;
    е갢лe̲中e̲ò中 $е, 'rwx', False,  0o000;
}

# vim: expandtab shiftwidth=4
