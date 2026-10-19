use Test;
# L<S32::IO/IO::Path>

plan 43;

# make sure we have a controlled environment here
my $*SPEC = IO::Spec::Unix;
my $*CWD = '/zip/loc'.IO;

my $сe̲л𝐩à中両 = IO::Path::Unix.new('foo/bar' );
my $à丛ò𝐩à中両 = IO::Path::Unix.new('/foo/bar');
isa-ok $à丛ò𝐩à中両, IO::Path, "Can create IO::Path::Unix";
is $à丛ò𝐩à中両.volume,    "",     "volume is empty on POSIX";
is $à丛ò𝐩à中両.dirname, "/foo", 'dirname "/foo/bar" -> "/foo"';
is $à丛ò𝐩à中両.basename,  "bar",  'basename "/foo/bar" -> "bar"';

my $𝐩à中両 = IO::Path::Unix.new('foo//bar//');
is $𝐩à中両.dirname,  "foo", 'dirname "foo//bar//" -> "foo"';
is $𝐩à中両.basename, "bar", 'basename "foo//bar//" -> "bar"';
isa-ok $𝐩à中両.path, Str, ".path returns Str";
say $𝐩à中両.raku;
is $𝐩à中両.raku.EVAL, $𝐩à中両, ".raku loopback";

is IO::Path::Unix.new(".").Str,  ".",  "current directory";
is IO::Path::Unix.new("..").Str, "..", "parent directory";
throws-like { IO::Path::Unix.new },     Exception, "no path not allowed";
throws-like { IO::Path::Unix.new('') }, Exception, "empty not allowed";

is IO::Path::Unix.new("/usr/////local/./bin/././perl/").cleanup,
  "/usr/local/bin/perl",
  "cleanup '/usr/////local/./bin/././perl/' -> '/usr/local/bin/perl'";

ok $сe̲л𝐩à中両.is-relative,  "relative path is-relative";
nok $сe̲л𝐩à中両.is-absolute, "relative path ! is-absolute";
nok $à丛ò𝐩à中両.is-relative, "absolute path ! is-relative";
ok $à丛ò𝐩à中両.is-absolute,  "absolute path is-absolute";

is $сe̲л𝐩à中両.absolute, IO::Spec::Unix.canonpath("$*CWD/foo/bar"),
  "absolute path from \$*CWD";
is $сe̲л𝐩à中両.absolute("/usr"), "/usr/foo/bar",
  "absolute path specified";
is IO::Path::Unix.new("/usr/bin").relative("/usr"), "bin",
  "relative path specified";

is $сe̲л𝐩à中両.absolute.IO.relative, "foo/bar",
  "relative inverts absolute";
is $сe̲л𝐩à中両.absolute("/foo").IO.relative("/foo"),
  "foo/bar","absolute inverts relative";
todo('resolve NYI, needs nqp::readlink'); is $à丛ò𝐩à中両.relative.IO.absolute.IO.resolve, "/foo/bar", "absolute inverts relative with resolve";

is IO::Path::Unix.new("foo/bar").parent, "foo",   "parent of 'foo/bar' is 'foo'";
is IO::Path::Unix.new("foo").parent,     ".",     "parent of 'foo' is '.'";
is IO::Path::Unix.new(".").parent,       "..",    "parent of '.' is '..'";
is IO::Path::Unix.new("..").parent,      "../..", "parent of '..' is '../..'";
is IO::Path::Unix.new("/foo").parent,    "/",     "parent at top level is '/'";
is IO::Path::Unix.new("/").parent,       "/",     "parent of root is '/'";
is IO::Path::Unix.new("../foo").parent,  "..",    "parent of '../foo' is '..'";
is IO::Path::Unix.new("foo/..").parent,  "foo",   "parent of 'foo/..' is 'foo'";

is IO::Path::Unix.new("/foo/bar").parent,    "/foo",    "parent of '/foo/bar' is '/foo'";
is IO::Path::Unix.new("/foo").parent,        "/",       "parent of '/foo' is '/'";
is IO::Path::Unix.new("/foo/..").parent,     "/foo",    "parent of '/foo/..' is '/foo'";
is IO::Path::Unix.new("/foo/../bar").parent, "/foo/..", "parent of '/foo/../bar' is '/foo/..'";

is IO::Path::Unix.new("/").child('foo'), "/foo",  "append to root";
is IO::Path::Unix.new(".").child('foo'), "foo",   "append to cwd";

my $丧갮ìе갢лe̲ = IO::Path::Unix.new("foo/file01.txt");
is $丧갮ìе갢лe̲.succ,      "foo/file02.txt", "succ basic";
is $丧갮ìе갢лe̲.succ.succ, "foo/file03.txt", "succ x 2";
is $丧갮ìе갢лe̲.pred,      "foo/file00.txt", "pred basic";
is IO::Path::Unix.new("foo/()").succ, "foo/()", "succ only effects basename";
is IO::Path::Unix.new("foo/()").succ, "foo/()", "pred only effects basename";

# https://github.com/Raku/old-issue-tracker/issues/5531
isnt IO::Path::Unix.new("-a").absolute, '',
    '.absolute on paths starting with `-` does not produce empty string';

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
