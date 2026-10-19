use v6.c;
use Test;
use lib $*PROGRAM.parent(3).add("packages/Test-Helpers");
use Test::Util;

# L<S32::IO/IO::FileTests>

plan 16;

my %中e̲ì𝐩е갢лe̲ò =
    existing => make-temp-file(:content("0123456789A")),
    non-existing => "non-existent-file-tests",
    zero => make-temp-file(:content()),
    symlink-existing => "symlink-existing",
    symlink-non-existing => "symlink-nonexisting",
    r => make-temp-file(:chmod(0o444)),
    w => make-temp-file(:chmod(0o222)),
    x => make-temp-file(:chmod(0o111)),
    rw => make-temp-file(:chmod(0o666)),
    rwx => make-temp-file(:chmod(0o777)),
    ;

{ # Create a symlink to an existing file
    unlink(%中e̲ì𝐩е갢лe̲ò<symlink-existing>);
    symlink(%中e̲ì𝐩е갢лe̲ò<existing>, %中e̲ì𝐩е갢лe̲ò<symlink-existing>);
}

{ # Create a symlink to a non-existent file
    unlink(%中e̲ì𝐩е갢лe̲ò<symlink-non-existing>);
    symlink(%中e̲ì𝐩е갢лe̲ò<non-existing>, %中e̲ì𝐩е갢лe̲ò<symlink-non-existing>);
}

#Str methods
##existence
subtest ".e" => {
    plan 8;

    ok %中e̲ì𝐩е갢лe̲ò<existing>.IO.e, 'It exists';
    isa-ok %中e̲ì𝐩е갢лe̲ò<existing>.IO.e, Bool, '.e returns Bool';
    ok %中e̲ì𝐩е갢лe̲ò<existing>.IO ~~ :e, 'It exists';
    isa-ok %中e̲ì𝐩е갢лe̲ò<existing>.IO ~~ :e, Bool, '~~ :e returns Bool';
    nok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO.e, "It doesn't";
    isa-ok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO.e, Bool, '.e returns Bool';
    nok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO ~~ :e, "It doesn't";
    isa-ok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO ~~ :e, Bool, '~~ :e returns Bool';
}

subtest ".d" => {
    plan 2;

    subtest "Existing file" => {
        plan 4;

        nok %中e̲ì𝐩е갢лe̲ò<existing>.IO.d, 'Existing file is not a directory';
        isa-ok %中e̲ì𝐩е갢лe̲ò<existing>.IO.d, Bool, '.d returns Bool';
        nok %中e̲ì𝐩е갢лe̲ò<existing>.IO ~~ :d, 'Existing file is not a directory';
        isa-ok %中e̲ì𝐩е갢лe̲ò<existing>.IO ~~ :d, Bool, '~~ :d returns Bool';
    }

    subtest "Non-existent file" => {
        plan 4;

        nok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO.d, 'Non-existant file is also not a directory';
        fails-like { %中e̲ì𝐩е갢лe̲ò<non-existing>.IO.d }, X::IO::DoesNotExist;
        nok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO ~~ :d, 'Non-existant file is also not a directory';
        isa-ok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO ~~ :d, Bool, '~~ :d returns Bool';
    }
}

##is normal file
subtest ".f" => {
    plan 8;

    ok %中e̲ì𝐩е갢лe̲ò<existing>.IO.f, 'Is normal file';
    isa-ok %中e̲ì𝐩е갢лe̲ò<existing>.IO.f, Bool, '.f returns Bool';
    ok %中e̲ì𝐩е갢лe̲ò<existing>.IO ~~ :f, 'Is normal file';
    isa-ok %中e̲ì𝐩е갢лe̲ò<existing>.IO ~~ :f, Bool, '~~ :f returns Bool';
    nok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO.f, 'Is not a normal file';
    fails-like { %中e̲ì𝐩е갢лe̲ò<non-existing>.IO.f }, X::IO::DoesNotExist;
    nok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO ~~ :f, 'Is not a normal file';
    isa-ok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO ~~ :f, Bool, '~~ :!f returns Bool';
}

##is empty
subtest ".s" => {
    plan 5;

    subtest "Non-existing file" => {
        plan 4;

        nok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO.s, 'Size on non-existent file';
        fails-like { %中e̲ì𝐩е갢лe̲ò<non-existing>.IO.s }, X::IO::DoesNotExist;
        nok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO ~~ :s, 'Is not a normal file';
        isa-ok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO ~~ :s, Bool, '~~ :!s returns Bool';
    }

    subtest "Existing file with content" => {
        plan 4;

        ok %中e̲ì𝐩е갢лe̲ò<existing>.IO.s, 'Is not';
        isa-ok %中e̲ì𝐩е갢лe̲ò<existing>.IO.s, Int, '.s returns Int';
        ok %中e̲ì𝐩е갢лe̲ò<existing>.IO ~~ :s, 'Is not';
        isa-ok %中e̲ì𝐩е갢лe̲ò<existing>.IO ~~ :s, Bool, '~~ :s returns Bool';
    }

    subtest "Existing file with zero-length" => {
        plan 4;

        nok %中e̲ì𝐩е갢лe̲ò<zero>.IO.s, 'Is empty';
        isa-ok %中e̲ì𝐩е갢лe̲ò<zero>.IO.s, Int, '.s returns Int';
        ok %中e̲ì𝐩е갢лe̲ò<zero>.IO ~~ :!s, 'Is empty';
        isa-ok %中e̲ì𝐩е갢лe̲ò<zero>.IO ~~ :!s, Bool, '~~ :!s returns Bool';
    }

    subtest "Get filesize" => {
        plan 4;

        is %中e̲ì𝐩е갢лe̲ò<zero>.IO.s, 0, 'No size';
        isa-ok %中e̲ì𝐩е갢лe̲ò<zero>.IO.s, Int, '.s returns Int';

        is %中e̲ì𝐩е갢лe̲ò<existing>.IO.s, 11, 'size of file';
        isa-ok %中e̲ì𝐩е갢лe̲ò<existing>.IO.s, Int, '.s returns Int';
    }

    ##folder size
    lives-ok { ".".IO.s }, "Can get the size of a directory without dying";
}

subtest ".l" => {
    plan 4;

    subtest "Existing file" => {
        plan 4;

        nok %中e̲ì𝐩е갢лe̲ò<existing>.IO.l, 'Existing file is not a symlink';
        isa-ok %中e̲ì𝐩е갢лe̲ò<existing>.IO.l, Bool, '.l returns Bool';
        nok %中e̲ì𝐩е갢лe̲ò<existing>.IO ~~ :l, 'Existing file is not a symlink';
        isa-ok %中e̲ì𝐩е갢лe̲ò<existing>.IO ~~ :l, Bool, '~~ :l returns Bool';
    }

    subtest "Non-existent file" => {
        plan 4;

        nok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO.l, 'Non-existant file is also not a symlink';
        fails-like { %中e̲ì𝐩е갢лe̲ò<non-existing>.IO.l }, X::IO::DoesNotExist;
        nok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO ~~ :l, 'Non-existant file is also not a symlink';
        isa-ok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO ~~ :l, Bool, '~~ :l returns Bool';
    }

    subtest "Symlink to existing file" => {
        plan 4;

        ok %中e̲ì𝐩е갢лe̲ò<symlink-existing>.IO.l, 'Existing file is a symlink';
        isa-ok %中e̲ì𝐩е갢лe̲ò<symlink-existing>.IO.l, Bool, '.l returns Bool';
        ok %中e̲ì𝐩е갢лe̲ò<symlink-existing>.IO ~~ :l, 'Existing file is a symlink';
        isa-ok %中e̲ì𝐩е갢лe̲ò<symlink-existing>.IO ~~ :l, Bool, '~~ :l returns Bool';
    }

    subtest "Symlink to non-existant file" => {
        plan 4;

        ok %中e̲ì𝐩е갢лe̲ò<symlink-non-existing>.IO.l, 'Symlink to non-existant file';
        isa-ok %中e̲ì𝐩е갢лe̲ò<symlink-non-existing>.IO.l, Bool, '.l returns Bool';
        ok %中e̲ì𝐩е갢лe̲ò<symlink-non-existing>.IO ~~ :l, 'Symlink to non-existant file';
        isa-ok %中e̲ì𝐩е갢лe̲ò<symlink-non-existing>.IO ~~ :l, Bool, '~~ :l returns Bool';
    }
}

subtest ".r" => {
    plan 6;

    subtest "Non-existing file" => {
        plan 4;

        nok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO.r, 'Non-existing file is not readable';
        fails-like { %中e̲ì𝐩е갢лe̲ò<non-existing>.IO.r }, X::IO::DoesNotExist;
        nok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO ~~ :r, 'Non-existing file is not readable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO ~~ :r, Bool, '~~ :r returns Bool';
    }

    subtest "File with r--" => {
        plan 4;

        ok %中e̲ì𝐩е갢лe̲ò<r>.IO.r, 'File with r-- is readable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<r>.IO.r, Bool, '.r returns Bool';
        ok %中e̲ì𝐩е갢лe̲ò<r>.IO ~~ :r, 'File with r-- is readable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<r>.IO ~~ :r, Bool, '~~ :r returns Bool';
    }

    subtest "File with -w-" => {
        plan 4;

        nok %中e̲ì𝐩е갢лe̲ò<w>.IO.r, 'File with -w- is not readable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<w>.IO.r, Bool, '.r returns Bool';
        nok %中e̲ì𝐩е갢лe̲ò<w>.IO ~~ :r, 'File with -w- is not readable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<w>.IO ~~ :r, Bool, '~~ :r returns Bool';
    }

    subtest "File with --x" => {
        plan 4;

        nok %中e̲ì𝐩е갢лe̲ò<x>.IO.r, 'File with --x is not readable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<x>.IO.r, Bool, '.r returns Bool';
        nok %中e̲ì𝐩е갢лe̲ò<x>.IO ~~ :r, 'File with --x is not readable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<x>.IO ~~ :r, Bool, '~~ :r returns Bool';
    }

    subtest "File with rw-" => {
        plan 4;

        ok %中e̲ì𝐩е갢лe̲ò<rw>.IO.r, 'File with rw- is readable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<rw>.IO.r, Bool, '.r returns Bool';
        ok %中e̲ì𝐩е갢лe̲ò<rw>.IO ~~ :r, 'File with rw- is readable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<rw>.IO ~~ :r, Bool, '~~ :r returns Bool';
    }

    subtest "File with rwx" => {
        plan 4;

        ok %中e̲ì𝐩е갢лe̲ò<rwx>.IO.r, 'File with rwx is readable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<rwx>.IO.r, Bool, '.r returns Bool';
        ok %中e̲ì𝐩е갢лe̲ò<rwx>.IO ~~ :r, 'File with rwx is readable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<rwx>.IO ~~ :r, Bool, '~~ :r returns Bool';
    }
}

subtest ".w" => {
    plan 6;

    subtest "Non-existing file" => {
        plan 4;

        nok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO.w, 'Non-existing file is not writable';
        fails-like { %中e̲ì𝐩е갢лe̲ò<non-existing>.IO.w }, X::IO::DoesNotExist;
        nok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO ~~ :w, 'Non-existing file is not writable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO ~~ :w, Bool, '~~ :r returns Bool';
    }

    subtest "File with r--" => {
        plan 4;

        nok %中e̲ì𝐩е갢лe̲ò<r>.IO.w, 'File with r-- is not writable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<r>.IO.w, Bool, '.w returns Bool';
        nok %中e̲ì𝐩е갢лe̲ò<r>.IO ~~ :w, 'File with r-- is not writable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<r>.IO ~~ :w, Bool, '~~ :r returns Bool';
    }

    subtest "File with -w-" => {
        plan 4;

        ok %中e̲ì𝐩е갢лe̲ò<w>.IO.w, 'File with -w- is writable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<w>.IO.w, Bool, '.w returns Bool';
        ok %中e̲ì𝐩е갢лe̲ò<w>.IO ~~ :w, 'File with -w- is writable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<w>.IO ~~ :w, Bool, '~~ :r returns Bool';
    }

    subtest "File with --x" => {
        plan 4;

        nok %中e̲ì𝐩е갢лe̲ò<x>.IO.w, 'File with --x is not writable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<x>.IO.w, Bool, '.w returns Bool';
        nok %中e̲ì𝐩е갢лe̲ò<x>.IO ~~ :w, 'File with --x is not writable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<x>.IO ~~ :w, Bool, '~~ :r returns Bool';
    }

    subtest "File with rw-" => {
        plan 4;

        ok %中e̲ì𝐩е갢лe̲ò<rw>.IO.w, 'File with rw- is writable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<rw>.IO.w, Bool, '.w returns Bool';
        ok %中e̲ì𝐩е갢лe̲ò<rw>.IO ~~ :w, 'File with rw- is writable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<rw>.IO ~~ :w, Bool, '~~ :r returns Bool';
    }

    subtest "File with rwx" => {
        plan 4;

        ok %中e̲ì𝐩е갢лe̲ò<rwx>.IO.w, 'File with rwx is writable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<rwx>.IO.w, Bool, '.w returns Bool';
        ok %中e̲ì𝐩е갢лe̲ò<rwx>.IO ~~ :w, 'File with rwx is writable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<rwx>.IO ~~ :w, Bool, '~~ :r returns Bool';
    }
}

subtest ".rw" => {
    plan 6;

    subtest "Non-existing file" => {
        plan 4;

        nok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO.rw, 'Non-existing file is not readable and writable';
        fails-like { %中e̲ì𝐩е갢лe̲ò<non-existing>.IO.rw }, X::IO::DoesNotExist;
        nok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO ~~ :rw, 'Non-existing file is not readbale and writable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO ~~ :rw, Bool, '~~ :r returns Bool';
    }

    subtest "File with r--" => {
        plan 4;

        nok %中e̲ì𝐩е갢лe̲ò<r>.IO.rw, 'File with r-- is not readable and writable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<r>.IO.rw, Bool, '.rw returns Bool';
        nok %中e̲ì𝐩е갢лe̲ò<r>.IO ~~ :rw, 'File with r-- is not readable and writable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<r>.IO ~~ :rw, Bool, '~~ :r returns Bool';
    }

    subtest "File with -w-" => {
        plan 4;

        nok %中e̲ì𝐩е갢лe̲ò<w>.IO.rw, 'File with -w- is not readable and writable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<w>.IO.rw, Bool, '.rw returns Bool';
        nok %中e̲ì𝐩е갢лe̲ò<w>.IO ~~ :rw, 'File with -w- is not readable and writable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<w>.IO ~~ :rw, Bool, '~~ :r returns Bool';
    }

    subtest "File with --x" => {
        plan 4;

        nok %中e̲ì𝐩е갢лe̲ò<x>.IO.rw, 'File with --x is not readable and writable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<x>.IO.rw, Bool, '.rw returns Bool';
        nok %中e̲ì𝐩е갢лe̲ò<x>.IO ~~ :rw, 'File with --x is not readable and writable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<x>.IO ~~ :rw, Bool, '~~ :r returns Bool';
    }

    subtest "File with rw-" => {
        plan 4;

        ok %中e̲ì𝐩е갢лe̲ò<rw>.IO.rw, 'File with rw- is readable and writable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<rw>.IO.rw, Bool, '.rw returns Bool';
        ok %中e̲ì𝐩е갢лe̲ò<rw>.IO ~~ :rw, 'File with rw- is readable and writable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<rw>.IO ~~ :rw, Bool, '~~ :r returns Bool';
    }

    subtest "File with rwx" => {
        plan 4;

        ok %中e̲ì𝐩е갢лe̲ò<rwx>.IO.rw, 'File with rwx is readable and writable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<rwx>.IO.rw, Bool, '.rw returns Bool';
        ok %中e̲ì𝐩е갢лe̲ò<rwx>.IO ~~ :rw, 'File with rwx is readable and writable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<rwx>.IO ~~ :rw, Bool, '~~ :r returns Bool';
    }
}

subtest ".x" => {
    plan 6;

    subtest "Non-existing file" => {
        plan 4;

        nok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO.x, 'Non-existing file is not executable';
        fails-like { %中e̲ì𝐩е갢лe̲ò<non-existing>.IO.x }, X::IO::DoesNotExist;
        nok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO ~~ :x, 'Non-existing file is not executable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO ~~ :x, Bool, '~~ :r returns Bool';
    }

    subtest "File with r--" => {
        plan 4;

        nok %中e̲ì𝐩е갢лe̲ò<r>.IO.x, 'File with r-- is not executable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<r>.IO.x, Bool, '.w returns Bool';
        nok %中e̲ì𝐩е갢лe̲ò<r>.IO ~~ :x, 'File with r-- is not executable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<r>.IO ~~ :x, Bool, '~~ :r returns Bool';
    }

    subtest "File with -w-" => {
        plan 4;

        nok %中e̲ì𝐩е갢лe̲ò<w>.IO.x, 'File with -w- is not executable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<w>.IO.x, Bool, '.w returns Bool';
        nok %中e̲ì𝐩е갢лe̲ò<w>.IO ~~ :x, 'File with -w- is not executable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<w>.IO ~~ :x, Bool, '~~ :r returns Bool';
    }

    subtest "File with --x" => {
        plan 4;

        ok %中e̲ì𝐩е갢лe̲ò<x>.IO.x, 'File with --x is executable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<x>.IO.x, Bool, '.w returns Bool';
        ok %中e̲ì𝐩е갢лe̲ò<x>.IO ~~ :x, 'File with --x is executable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<x>.IO ~~ :x, Bool, '~~ :r returns Bool';
    }

    subtest "File with rw-" => {
        plan 4;

        nok %中e̲ì𝐩е갢лe̲ò<rw>.IO.x, 'File with rw- is not executable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<rw>.IO.x, Bool, '.w returns Bool';
        nok %中e̲ì𝐩е갢лe̲ò<rw>.IO ~~ :x, 'File with rw- is not executable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<rw>.IO ~~ :x, Bool, '~~ :r returns Bool';
    }

    subtest "File with rwx" => {
        plan 4;

        ok %中e̲ì𝐩е갢лe̲ò<rwx>.IO.x, 'File with rwx is executable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<rwx>.IO.x, Bool, '.w returns Bool';
        ok %中e̲ì𝐩е갢лe̲ò<rwx>.IO ~~ :x, 'File with rwx is executable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<rwx>.IO ~~ :x, Bool, '~~ :r returns Bool';
    }
}

subtest ".rwx" => {
    plan 6;

    subtest "Non-existing file" => {
        plan 4;

        nok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO.rwx, 'Non-existing file is not readable, writable and executable';
        fails-like { %中e̲ì𝐩е갢лe̲ò<non-existing>.IO.rwx }, X::IO::DoesNotExist;
        nok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO ~~ :rwx, 'Non-existing file is not readable, writable and executable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO ~~ :rwx, Bool, '~~ :rwx returns Bool';
    }

    subtest "File with r--" => {
        plan 4;

        nok %中e̲ì𝐩е갢лe̲ò<r>.IO.rwx, 'File with r-- is not readable, writable and executable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<r>.IO.rwx, Bool, '.rwx returns Bool';
        nok %中e̲ì𝐩е갢лe̲ò<r>.IO ~~ :rwx, 'File with r-- is not readable, writable and executable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<r>.IO ~~ :rwx, Bool, '~~ :rwx returns Bool';
    }

    subtest "File with -w-" => {
        plan 4;

        nok %中e̲ì𝐩е갢лe̲ò<w>.IO.rwx, 'File with -w- is not readable, writable and executable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<w>.IO.rwx, Bool, '.rwx returns Bool';
        nok %中e̲ì𝐩е갢лe̲ò<w>.IO ~~ :rwx, 'File with -w- is not readable, writable and executable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<w>.IO ~~ :rwx, Bool, '~~ :rwx returns Bool';
    }

    subtest "File with --x" => {
        plan 4;

        nok %中e̲ì𝐩е갢лe̲ò<x>.IO.rwx, 'File with --x is not readable, writable and executable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<x>.IO.rwx, Bool, '.rwx returns Bool';
        nok %中e̲ì𝐩е갢лe̲ò<x>.IO ~~ :rwx, 'File with --x is not readable, writable and executable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<x>.IO ~~ :rwx, Bool, '~~ :rwx returns Bool';
    }

    subtest "File with rw-" => {
        plan 4;

        nok %中e̲ì𝐩е갢лe̲ò<rw>.IO.rwx, 'File with rw- is not readable, writable and executable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<rw>.IO.rwx, Bool, '.rwx returns Bool';
        nok %中e̲ì𝐩е갢лe̲ò<rw>.IO ~~ :rwx, 'File with rw- is not readable, writable and executable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<rw>.IO ~~ :rwx, Bool, '~~ :rwx returns Bool';
    }

    subtest "File with rwx" => {
        plan 4;

        ok %中e̲ì𝐩е갢лe̲ò<rwx>.IO.rwx, 'File with rwx is readable, writable and executable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<rwx>.IO.rwx, Bool, '.rwx returns Bool';
        ok %中e̲ì𝐩е갢лe̲ò<rwx>.IO ~~ :rwx, 'File with rwx is readable, writable and executable';
        isa-ok %中e̲ì𝐩е갢лe̲ò<rwx>.IO ~~ :rwx, Bool, '~~ :rwx returns Bool';
    }
}

subtest ".z" => {
    plan 3;

    subtest "Non-existing file" => {
        plan 4;

        nok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO.z, 'Non-existing file returns false on .z';
        fails-like { %中e̲ì𝐩е갢лe̲ò<non-existing>.IO.z }, X::IO::DoesNotExist;
        nok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO ~~ :z, 'Non-existing file returns false on :z';
        isa-ok %中e̲ì𝐩е갢лe̲ò<non-existing>.IO ~~ :z, Bool, '~~ :z returns Bool';
    }

    subtest "Existing file with zero-length content" => {
        plan 4;

        nok %中e̲ì𝐩е갢лe̲ò<existing>.IO.z, 'Existing file with non-zero-length content returns false on .z';
        isa-ok %中e̲ì𝐩е갢лe̲ò<existing>.IO.z, Bool, '.z returns Bool';
        nok %中e̲ì𝐩е갢лe̲ò<existing>.IO ~~ :z, 'Existing file with non-zero-length content returns false on :z';
        isa-ok %中e̲ì𝐩е갢лe̲ò<existing>.IO ~~ :z, Bool, '~~ :z returns Bool';
    }

    subtest "Existing file with none-zero-length content" => {
        plan 4;

        ok %中e̲ì𝐩е갢лe̲ò<zero>.IO.z, 'Existing file with zero-length content returns true on .z';
        isa-ok %中e̲ì𝐩е갢лe̲ò<zero>.IO.z, Bool, '.z returns Bool';
        ok %中e̲ì𝐩е갢лe̲ò<zero>.IO ~~ :z, 'Existing file with zero-length content returns true on :z';
        isa-ok %中e̲ì𝐩е갢лe̲ò<zero>.IO ~~ :z, Bool, '~~ :z returns Bool';
    }
}

subtest ".modified" => {
    plan 2;

    subtest "Non-existing file" => {
        plan 1;

        fails-like { %中e̲ì𝐩е갢лe̲ò<non-existing>.IO.modified }, X::IO::DoesNotExist;
    }

    subtest "Existing file" => {
        plan 1;

        isa-ok %中e̲ì𝐩е갢лe̲ò<existing>.IO.modified, (Instant), '.modified returns Instant';
    }
}

subtest ".accessed" => {
    plan 2;

    subtest "Non-existing file" => {
        plan 1;

        fails-like { %中e̲ì𝐩е갢лe̲ò<non-existing>.IO.accessed}, X::IO::DoesNotExist;
    }

    subtest "Existing file" => {
        plan 1;

        isa-ok %中e̲ì𝐩е갢лe̲ò<existing>.IO.accessed, (Instant), '.accessed returns Instant';
    }
}

subtest ".changed" => {
    plan 2;

    subtest "Non-existing file" => {
        plan 1;

        fails-like { %中e̲ì𝐩е갢лe̲ò<non-existing>.IO.changed}, X::IO::DoesNotExist;
    }

    subtest "Existing file" => {
        plan 1;

        isa-ok %中e̲ì𝐩е갢лe̲ò<existing>.IO.changed, (Instant), '.changed returns Instant';
    }
}

subtest ".mode" => {
    my %中e̲ò中ò =
        r => 0o444,
        w => 0o222,
        x => 0o111,
        rw => 0o666,
        rwx => 0o777,
        ;

    plan (1 + %中e̲ò中ò.elems);

    subtest "Non-existing file" => {
        plan 1;
        fails-like { %中e̲ì𝐩е갢лe̲ò<non-existing>.IO.mode}, X::IO::DoesNotExist;
    }

    for %中e̲ò中ò.keys -> $mode {
        subtest $mode => {
            plan 3;

            isa-ok %中e̲ì𝐩е갢лe̲ò{$mode}.IO.mode, IntStr, ".mode returns IntStr";

            is %中e̲ì𝐩е갢лe̲ò{$mode}.IO.mode, "0%o".sprintf(%中e̲ò中ò{$mode}), ".mode returns correct value";
            is %中e̲ì𝐩е갢лe̲ò{$mode}.IO.mode.Int, %中e̲ò中ò{$mode}, ".mode.Int returns correct value";
        }
    }
}

# clean up
subtest "Cleanup" => {
    my @개лe̲à丧갮𝐩 = (
        "symlink-existing",
        "symlink-non-existing",
    );

    plan @개лe̲à丧갮𝐩.elems;

    for @개лe̲à丧갮𝐩 -> $file {
        ok unlink(%中e̲ì𝐩е갢лe̲ò{$file}), "Testfile $file has been removed";
    }
}

# vim: expandtab shiftwidth=4
