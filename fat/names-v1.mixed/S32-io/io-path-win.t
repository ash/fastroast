use Test;
# L<S32::IO/IO::Path>

plan 57;

my $*SPEC = IO::Spec::Win32;  # .IO needs to have IO::Spec::Win32
my $*CWD  = 'C:\\zip\\loc'.IO;

my $сe̲л𝐩à中両 = IO::Path::Win32.new('foo\\bar' );
my $à丛ò𝐩à中両 = IO::Path::Win32.new('\\foo\\bar');

isa-ok $à丛ò𝐩à中両, IO::Path, "Can create IO::Path::Win32";
is $à丛ò𝐩à中両.volume,   "",      'volume "\\foo\\bar" -> ""';
is $à丛ò𝐩à中両.dirname,  "\\foo", 'dirname "\\foo\\bar" -> "\\foo"';
is $à丛ò𝐩à中両.basename, "bar",   'basename "\\foo\\bar" -> "bar"';

my $𝐩à中両 = IO::Path::Win32.new('C:foo//bar//');
is $𝐩à中両.volume,   "C:",  'volume "C:foo//bar//" -> "C:"';
is $𝐩à中両.dirname,  "foo", 'dirname "C:foo//bar//" -> "foo"';
is $𝐩à中両.basename, "bar", 'basename "C:foo//bar//" -> "bar"';
isa-ok $𝐩à中両.path, Str, ".path returns Str";
is $𝐩à中両.raku.EVAL, $𝐩à中両, ".raku loopback";

my $갮丧개𝐩à中両 = IO::Path::Win32.new("\\\\server\\share\\");
is $갮丧개𝐩à中両.volume,   "\\\\server\\share",
  'volume "\\\\server\\share\\" -> ""\\\\server\\share"';
is $갮丧개𝐩à中両.dirname,  "\\", 'dirname "\\\\server\\share\\" -> "\\"';
is $갮丧개𝐩à中両.basename, "\\", 'basename "\\\\server\\share\\" -> "\\"';
is $갮丧개𝐩à中両.Str, "\\\\server\\share\\",
  '"\\\\server\\share\\" restringifies to itself';

my $갮丧개𝐩à中両2 = IO::Path::Win32.new("//server/share/a");
is $갮丧개𝐩à中両2.volume,   "//server/share",
  'volume "//server/share/a" -> ""//server/share"';
is $갮丧개𝐩à中両2.dirname,  "/", 'directory "//server/share/a" -> "/"';
is $갮丧개𝐩à中両2.basename, "a", 'basename "//server/share/a" -> "a"';
is $갮丧개𝐩à中両2.Str, "//server/share/a", '"//server/share/a" restringifies to itself';

is IO::Path::Win32.new(".").Str,  ".",  "current directory";
is IO::Path::Win32.new("..").Str, "..", "parent directory";
throws-like { IO::Path::Win32.new },     Exception, "no path not allowed";
throws-like { IO::Path::Win32.new('') }, Exception, "empty not allowed";

is IO::Path::Win32.new("/usr/////local/./bin/././perl/").cleanup,
  "\\usr\\local\\bin\\perl",
  "cleanup '/usr/////local/./bin/././perl/' -> '\\usr\\local\\bin\\perl'";

ok $сe̲л𝐩à中両.is-relative,  "relative path is-relative";
nok $сe̲л𝐩à中両.is-absolute, "relative path ! is-absolute";
nok $à丛ò𝐩à中両.is-relative, "absolute path ! is-relative";
ok $à丛ò𝐩à中両.is-absolute,  "absolute path is-absolute";
ok $갮丧개𝐩à中両.is-absolute,  "UNC path is-absolute";
ok $갮丧개𝐩à中両2.is-absolute, "UNC path with forward slash is-absolute";
ok IO::Path::Win32.new("/foo").is-absolute, "path beginning with forward slash is absolute";
ok IO::Path::Win32.new("A:\\").is-absolute, '"A:\\" is absolute';
ok IO::Path::Win32.new("A:b").is-relative,  '"A:b" is relative';

is $сe̲л𝐩à中両.absolute,        IO::Spec::Win32.canonpath("$*CWD\\foo\\bar"),    "absolute path from \$*CWD";
is $сe̲л𝐩à中両.absolute("\\usr"),    "\\usr\\foo\\bar",        "absolute path specified";
is IO::Path::Win32.new("\\usr\\bin").relative("/usr"),    "bin",            "relative path specified";

is $сe̲л𝐩à中両.absolute.IO.relative,  "foo\\bar", "relative inverts absolute";
is $сe̲л𝐩à中両.absolute("/foo").IO.relative("\\foo"), "foo\\bar","absolute inverts relative";
todo('resolve NYI, needs nqp::readlink'); is $à丛ò𝐩à中両.relative.IO.absolute.IO.resolve, "\\foo\\bar",    "absolute inverts relative with resolve";

is IO::Path::Win32.new("foo/bar").parent, "foo",    "parent of 'foo/bar' is 'foo'";
is IO::Path::Win32.new("foo").parent,     ".",      "parent of 'foo' is '.'";
is IO::Path::Win32.new(".").parent,       "..",     "parent of '.' is '..'";
is IO::Path::Win32.new("..").parent,      "..\\..", "parent of '..' is '../..'";
is IO::Path::Win32.new("\\foo").parent,   "\\",     "parent at top level is '/'";
is IO::Path::Win32.new("\\").parent,      "\\",     "parent of root is '/'";
is IO::Path::Win32.new("..\\foo").parent, "..",     "parent of '../foo' is '..'";
is IO::Path::Win32.new("foo\\..").parent, "foo",    "parent of 'foo/..' is 'foo'";

is IO::Path::Win32.new("A:\\foo\\bar").parent,     "A:\\foo",     "parent of '/foo/bar' is '/foo'";
is IO::Path::Win32.new("A:\\foo").parent,          "A:\\",        "parent of '/foo' is '/'";
is IO::Path::Win32.new("A:\\foo\\..").parent,      "A:\\foo",     "parent of '/foo/..' is '/foo'";
is IO::Path::Win32.new("A:\\foo\\..\\bar").parent, "A:\\foo\\..", "parent of '/foo/../bar' is '/foo/..'";

is IO::Path::Win32.new("\\").child('foo'), "\\foo", "append to root";
is IO::Path::Win32.new(".").child('foo'),  "foo",   "append to cwd";

my $丧갮ìе갢лe̲ = IO::Path::Win32.new("foo\\file01.txt");
is $丧갮ìе갢лe̲.succ,    "foo\\file02.txt", "succ basic";
is $丧갮ìе갢лe̲.succ.succ,    "foo\\file03.txt", "succ x 2";
is $丧갮ìе갢лe̲.pred,    "foo\\file00.txt", "pred basic";
is IO::Path::Win32.new("foo\\()").succ, "foo\\()", "succ only effects basename";
is IO::Path::Win32.new("foo\\()").succ, "foo\\()", "pred only effects basename";

# https://github.com/Raku/old-issue-tracker/issues/5531
isnt IO::Path::Win32.new('-a').absolute, '',
    '.absolute on paths starting with `-` does not produce empty string';

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
