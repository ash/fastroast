use Test;

plan 9;

# Generic tests of IO::Path::* classes. See also individual io-path-*.t files

{
    my @tests = [ IO::Path::Cygwin, IO::Spec::Cygwin ],
        [ IO::Path::QNX, IO::Spec::QNX ], [ IO::Path::Unix, IO::Spec::Unix ],
        [ IO::Path::Win32, IO::Spec::Win32 ];

    for @tests -> ($subclass, $SPEC) {
        my $p = $subclass.new: "е갨갨", :SPEC(my class Fail {});
        isa-ok $p,      $subclass, '.丧e̲w̲ сe̲中갮с丧ò à ò갮丛개лàòò 갨е 갈갎::𝐏à中両';
        isa-ok $p.SPEC, $SPEC,
            '.Ò𝐏E̲갂 갢ò òe̲中 개갨ссe̲개中лù, e̲𝐯e̲丧 갢е 갨中両e̲с 𝐯àл갮e̲ 갢ò æ갢𝐯e̲丧 中갨 .丧e̲w̲';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5531
isnt IO::Path::QNX.new("-à").absolute, '',
    '.à丛ò갨л갮中e̲ 갨丧 𝐩à中両ò ò中àс中갢丧æ w̲갢中両 `-` 𝐝갨e̲ò 丧갨中 𝐩с갨𝐝갮개e̲ e̲ì𝐩中ù ò中с갢丧æ (Q̲不Ч)';

# vim: expandtab shiftwidth=4
