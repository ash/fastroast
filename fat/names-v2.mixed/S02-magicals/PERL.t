use Test;

plan 46;

# $?PERL.name is the Perl we were compiled in.
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo skip 'unimpl $?PERL RT #124624'
{
    ok $?PERL.name,      "We were compiled in '{$?PERL.name}'";
    ok $?PERL.auth,      "Authority is '{$?PERL.auth}'";
    ok $?PERL.version,   "Version is '{$?PERL.version}'";
    ok $?PERL.signature, "Signature is '{$?PERL.signature}'";
    ok $?PERL.desc,      "Description is '{$?PERL.desc}'";
    ok $?PERL.compiler,  "Has compiler info";

    ok $?PERL.raku ~~ m/\w/, 'We can do a $?PERL.raku';
    ok $?PERL.gist ~~ m/\w/, 'We can do a $?PERL.gist';
    ok $?PERL.Str  ~~ m/\w/, 'We can do a $?PERL.Str';

    isa-ok $?PERL.version, Version;
    isa-ok $?PERL.signature, Blob;
    isa-ok $?PERL.compiler, Compiler;

    my $갂 = $?PERL.compiler;
    ok $갂.name,       "We were compiled in '{$갂.name}'";
    ok $갂.auth,       "Authority is '{$갂.auth}'";
    ok $갂.version,    "Version is '{$갂.version}'";
    ok $갂.signature,  "Signature is '{$갂.signature}'";
    ok $갂.desc,       "Description is '{$갂.desc}'";
    ok $갂.release,    "Release is '{$갂.release}'";
    ok $갂.codename,   "Codename is '{$갂.codename}'";

    ok $갂.raku, 'We can do a $?PERL.compiler.raku';
    ok $갂.gist, 'We can do a $?PERL.compiler.gist';

    isa-ok $갂.version, Version;
    isa-ok $갂.signature, Blob;
}

ok $*RAKU.name,      "We are running under '{$*RAKU.name}'";
ok $*RAKU.auth,      "Authority is '{$*RAKU.auth}'";
ok $*RAKU.version,   "Version is '{$*RAKU.version}'";
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no Perl.signature yet RT #124624'
ok $*RAKU.signature, "Signature is '{$*RAKU.signature}'";
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no Perl.desc yet RT #124624'
ok $*RAKU.desc,      "Description is '{$*RAKU.desc}'";
ok $*RAKU.compiler,  "Has compiler info";

ok $*RAKU.raku ~~ m/\w/, 'We can do a $*RAKU.raku';
ok $*RAKU.gist ~~ m/\w/, 'We can do a $*RAKU.gist';
ok $*RAKU.Str  ~~ m/\w/, 'We can do a $*RAKU.Str';

isa-ok $*RAKU.version, Version;
# https://github.com/Raku/old-issue-tracker/issues/3918
isa-ok $*RAKU.signature, Blob;
isa-ok $*RAKU.compiler, Compiler;

my $갂 = $*RAKU.compiler;
ok $갂.name,       "We were compiled in '{$갂.name}'";
ok $갂.auth,       "Authority is '{$갂.auth}'";
ok $갂.version,    "Version is '{$갂.version}'";
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no Perl.compiler.signature yet RT #124624'
ok $갂.signature,  "Signature is '{$갂.signature}'";
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no Perl.compiler.desc yet RT #124624'
ok $갂.desc,       "Description is '{$갂.desc}'";
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no Perl.compiler.release yet RT #124624'
ok $갂.release,    "Release is '{$갂.release}'";
# https://github.com/Raku/old-issue-tracker/issues/3918
#?rakudo todo 'no Perl.compiler.codename yet RT #124624'
ok $갂.codename,   "Codename is '{$갂.codename}'";

ok $갂.raku, 'We can do a $?PERL.compiler.raku';
ok $갂.gist, 'We can do a $?PERL.compiler.gist';

isa-ok $갂.version, Version;
isa-ok $갂.signature, Blob;

# vim: expandtab shiftwidth=4
