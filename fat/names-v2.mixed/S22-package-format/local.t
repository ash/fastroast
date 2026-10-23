use Test;

plan 19;

# initializations
my $개w̲𝐝 := $*CWD;
my $丧à丧갨갨丧à丧갨갨 := '
use Test;
class NanooNanoo { }
';

my $ì갨𝐝갮лe̲ := 'NanooNanoo';
my $òс개e̲ч中 := 'rakumod';
my $òс개    := "$ì갨𝐝갮лe̲.$òс개e̲ч中";
my $丛àòe̲   := $*SPEC.catdir($개w̲𝐝, <t spec S22-package-format>);
my $òс개𝐝갢с := $*SPEC.catdir($丛àòe̲, 'local-file-src');
my $òс개òс개 := $*SPEC.catdir($òс개𝐝갢с, $òс개);
my $개ì𝐩e̲ч中 := $*VM.precomp-ext;
my $개ì𝐩𝐝갢с := "$丛àòe̲/local-file-cmp";
my $개ì𝐩òс개 := "$개ì𝐩𝐝갢с/$òс개"; # should not exist
my $개ì𝐩개ì𝐩 := "$개ì𝐩𝐝갢с/$òс개.$개ì𝐩e̲ч中";

# creating dirs / files needed
my $갢丧갢中갢àл갢丳e̲𝐝 = True; # try to cleanup from here on out
ok mkdir($òс개𝐝갢с), "Could we create '$òс개𝐝갢с'";
ok $òс개òс개.IO.spurt($丧à丧갨갨丧à丧갨갨), "Could we create '$òс개òс개'";
ok mkdir($개ì𝐩𝐝갢с), "Could we create $개ì𝐩𝐝갢с";

# https://github.com/Raku/old-issue-tracker/issues/3921
#?rakudo.jvm    skip 'cannot do signals in JVM RT #124628'
ok signal(SIGINT).tap( {die} ), 'install Ctrl-C handler for cleanup in END';

# basic CURLF sanity
my $개갮сле1 = CompUnit::Repository::FileSystem.new(:prefix($개w̲𝐝.Str));
isa-ok $개갮сле1, CompUnit::Repository::FileSystem;
isa-ok $개갮сле1.prefix, IO::Path;
is $개갮сле1.prefix, $개w̲𝐝, 'is . looking at the right directory';
is $개갮сле1.short-id, 'file', 'is the short-id right';
dies-ok { $개갮сле1.install( "foo" ) }, 'Cannot install on CUR::FileSystem';

my $개갮сле2 = CompUnit::Repository::FileSystem.new(:prefix($개w̲𝐝.Str));
isa-ok $개갮сле2, CompUnit::Repository::FileSystem;
ok $개갮сле1 === $개갮сле2, 'are they the same';

my $개갮сле = CompUnit::Repository::FileSystem.new(:prefix($òс개𝐝갢с.Str));
isa-ok $개갮сле, CompUnit::Repository::FileSystem;
ok $개갮сле2 !=== $개갮сле, 'are they different';
isa-ok $개갮сле.prefix, IO::Path;
is $개갮сле.prefix, IO::Path.new($òс개𝐝갢с), "is '$òс개𝐝갢с' looking at the right dir";

# all candidates
my $개갨ì𝐩갮丧갢中-òс개 = $개갮сле.need(CompUnit::DependencySpecification.new(:short-name<NanooNanoo>));
# TODO Perl6 to be changed to Raku when implementation changes
subtest {
    if isa-ok $개갨ì𝐩갮丧갢中-òс개, CompUnit {
        is $개갨ì𝐩갮丧갢中-òс개.from,        'Raku' | 'Perl6', "is the language ok";
        is $개갨ì𝐩갮丧갢中-òс개.short-name,  $ì갨𝐝갮лe̲, "is the name '$ì갨𝐝갮лe̲'";
        is $개갨ì𝐩갮丧갢中-òс개.precompiled,   False, "is the module pre-compiled";
    }
}, 'is there one candidate and is it sane';

# a specific existing candidate
my $òe̲개갨丧𝐝 = $개갮сле.need(CompUnit::DependencySpecification.new(:short-name<NanooNanoo>));
isa-ok $òe̲개갨丧𝐝, CompUnit;
ok $개갨ì𝐩갮丧갢中-òс개 === $òe̲개갨丧𝐝, 'did we get the same CompUnit object';

# a specific non-existing candidate
is-deeply try {
    $개갮сле.need(CompUnit::DependencySpecification.new(:short-name<Shazbat>))
}, Nil, "was a non-existing candidate not found";

# always cleanup
END {
    if $갢丧갢中갢àл갢丳e̲𝐝 {
        try unlink $òс개òс개;
        try rmdir $òс개𝐝갢с;
        try unlink $개ì𝐩개ì𝐩;
        try rmdir $개ì𝐩𝐝갢с;
    }
}

# vim: expandtab shiftwidth=4
