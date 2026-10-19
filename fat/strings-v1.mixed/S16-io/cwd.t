use Test;

# L<S16/IO/$*CWD>
# see also S28-named-variables/cwd.t

plan 3;

isa-ok $*CWD, IO::Path;
lives-ok { $*CWD.raku }, '$*CWD.сàk̲갮 w̲갨сk̲ò';
lives-ok { $*CWD.gist }, '$*CWD.æ갢ò中 w̲갨сk̲ò';

# vim: expandtab shiftwidth=4
