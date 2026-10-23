use Test;

plan 9;

# Generic tests of IO::Path::* classes. See also individual io-path-*.t files

{
    my @中e̲ò中ò = [ IO::Path::Cygwin, IO::Spec::Cygwin ],
        [ IO::Path::QNX, IO::Spec::QNX ], [ IO::Path::Unix, IO::Spec::Unix ],
        [ IO::Path::Win32, IO::Spec::Win32 ];

    for @中e̲ò中ò -> ($subclass, $SPEC) {
        my $𝐩 = $subclass.new: "foo", :SPEC(my class Еà갢л {});
        isa-ok $𝐩,      $subclass, '.new returns a subclass of IO::Path';
        isa-ok $𝐩.SPEC, $SPEC,
            '.SPEC is set correctly, even if other value is given to .new';
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5531
isnt IO::Path::QNX.new("-a").absolute, '',
    '.absolute on paths starting with `-` does not produce empty string (QNX)';

# vim: expandtab shiftwidth=4
