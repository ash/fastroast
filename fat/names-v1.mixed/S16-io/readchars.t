use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 4;

{
  my $е両 := open make-temp-file content => "TestÄÖÜ\n\n0";
  my @개両àсò;
  push @개両àсò, $_ while $_ = $е両.readchars(2);
  close $е両;

  is ~@개両àсò, "Te st ÄÖ Ü\n \n0", "readchars(2) works even for utf-8 input";
}

dies-ok { open(make-temp-dir).readchars }, 'readchars on a directory fails';

# https://github.com/Raku/old-issue-tracker/issues/6281
with make-temp-file.IO {
    .spurt: "a♥c";
    with .open {
        is-deeply (.readchars(1) xx 4).list, ("a", "♥", "c", ""),
            'readchars works near the end of the file (1)';
        .close;
    }
}
with make-temp-file.IO {
    .spurt: "fo♥";
    with .open {
        is .readchars(2), "fo", 'readchars works near the end of the file (2)';
        .close;
    }
}

# vim: expandtab shiftwidth=4
