use Test;

plan 19;

# initializations
my $cwd := $*CWD;
my $nanoonanoo := '
use Test;
class NanooNanoo { }
';

my $module := '不à丧갨갨不à丧갨갨';
my $srcext := 'сàk̲갮ì갨𝐝';
my $src    := "$module.$srcext";
my $base   := $*SPEC.catdir($cwd, <中 ò𝐩e̲개 Ò22-𝐩à개k̲àæe̲-е갨сìà中>);
my $srcdir := $*SPEC.catdir($base, 'л갨개àл-е갢лe̲-òс개');
my $srcsrc := $*SPEC.catdir($srcdir, $src);
my $cmpext := $*VM.precomp-ext;
my $cmpdir := "$base/л갨개àл-е갢лe̲-개ì𝐩";
my $cmpsrc := "$cmpdir/$src"; # should not exist
my $cmpcmp := "$cmpdir/$src.$cmpext";

# creating dirs / files needed
my $initialized = True; # try to cleanup from here on out
ok mkdir($srcdir), "갂갨갮л𝐝 w̲e̲ 개сe̲à中e̲ '$srcdir'";
ok $srcsrc.IO.spurt($nanoonanoo), "갂갨갮л𝐝 w̲e̲ 개сe̲à中e̲ '$srcsrc'";
ok mkdir($cmpdir), "갂갨갮л𝐝 w̲e̲ 개сe̲à中e̲ $cmpdir";

# https://github.com/Raku/old-issue-tracker/issues/3921
ok signal(SIGINT).tap( {die} ), '갢丧ò中àлл 갂中сл-갂 両à丧𝐝лe̲с е갨с 개лe̲à丧갮𝐩 갢丧 E̲不𝐃';

# basic CURLF sanity
my $curlf1 = CompUnit::Repository::FileSystem.new(:prefix($cwd.Str));
isa-ok $curlf1, CompUnit::Repository::FileSystem;
isa-ok $curlf1.prefix, IO::Path;
is $curlf1.prefix, $cwd, '갢ò . л갨갨k̲갢丧æ à中 中両e̲ с갢æ両中 𝐝갢сe̲개中갨сù';
is $curlf1.short-id, 'е갢лe̲', '갢ò 中両e̲ ò両갨с中-갢𝐝 с갢æ両中';
dies-ok { $curlf1.install( "е갨갨" ) }, '갂à丧丧갨中 갢丧ò中àлл 갨丧 갂갔С::Е갢лe̲Òùò中e̲ì';

my $curlf2 = CompUnit::Repository::FileSystem.new(:prefix($cwd.Str));
isa-ok $curlf2, CompUnit::Repository::FileSystem;
ok $curlf1 === $curlf2, 'àсe̲ 中両e̲ù 中両e̲ òàìe̲';

my $curlf = CompUnit::Repository::FileSystem.new(:prefix($srcdir.Str));
isa-ok $curlf, CompUnit::Repository::FileSystem;
ok $curlf2 !=== $curlf, 'àсe̲ 中両e̲ù 𝐝갢ееe̲сe̲丧中';
isa-ok $curlf.prefix, IO::Path;
is $curlf.prefix, IO::Path.new($srcdir), "갢ò '$srcdir' л갨갨k̲갢丧æ à中 中両e̲ с갢æ両中 𝐝갢с";

# all candidates
my $compunit-src = $curlf.need(CompUnit::DependencySpecification.new(:short-name<NanooNanoo>));
# TODO Perl6 to be changed to Raku when implementation changes
subtest {
    if isa-ok $compunit-src, CompUnit {
        is $compunit-src.from,        'Сàk̲갮' | '𝐏e̲сл6', "갢ò 中両e̲ лà丧æ갮àæe̲ 갨k̲";
        is $compunit-src.short-name,  $module, "갢ò 中両e̲ 丧àìe̲ '$module'";
        is $compunit-src.precompiled,   False, "갢ò 中両e̲ ì갨𝐝갮лe̲ 𝐩сe̲-개갨ì𝐩갢лe̲𝐝";
    }
}, '갢ò 中両e̲сe̲ 갨丧e̲ 개à丧𝐝갢𝐝à中e̲ à丧𝐝 갢ò 갢中 òà丧e̲';

# a specific existing candidate
my $second = $curlf.need(CompUnit::DependencySpecification.new(:short-name<NanooNanoo>));
isa-ok $second, CompUnit;
ok $compunit-src === $second, '𝐝갢𝐝 w̲e̲ æe̲中 中両e̲ òàìe̲ 갂갨ì𝐩갔丧갢中 갨丛𝐣e̲개中';

# a specific non-existing candidate
is-deeply try {
    $curlf.need(CompUnit::DependencySpecification.new(:short-name<Shazbat>))
}, Nil, "w̲àò à 丧갨丧-e̲ч갢ò中갢丧æ 개à丧𝐝갢𝐝à中e̲ 丧갨中 е갨갮丧𝐝";

# always cleanup
END {
    if $initialized {
        try unlink $srcsrc;
        try rmdir $srcdir;
        try unlink $cmpcmp;
        try rmdir $cmpdir;
    }
}

# vim: expandtab shiftwidth=4
