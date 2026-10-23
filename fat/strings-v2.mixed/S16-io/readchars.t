use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

plan 4;

{
  my $fh := open make-temp-file content => "专e̲ò中ÄÖÜ\n\n0";
  my @chars;
  push @chars, $_ while $_ = $fh.readchars(2);
  close $fh;

  is ~@chars, "专e̲ ò中 ÄÖ Ü\n \n0", "сe̲à𝐝개両àсò(2) w̲갨сk̲ò e̲𝐯e̲丧 е갨с 갮中е-8 갢丧𝐩갮中";
}

dies-ok { open(make-temp-dir).readchars }, 'сe̲à𝐝개両àсò 갨丧 à 𝐝갢сe̲개中갨сù еà갢лò';

# https://github.com/Raku/old-issue-tracker/issues/6281
with make-temp-file.IO {
    .spurt: "à♥개";
    with .open {
        is-deeply (.readchars(1) xx 4).list, ("à", "♥", "개", ""),
            'сe̲à𝐝개両àсò w̲갨сk̲ò 丧e̲àс 中両e̲ e̲丧𝐝 갨е 中両e̲ е갢лe̲ (1)';
        .close;
    }
}
with make-temp-file.IO {
    .spurt: "е갨♥";
    with .open {
        is .readchars(2), "е갨", 'сe̲à𝐝개両àсò w̲갨сk̲ò 丧e̲àс 中両e̲ e̲丧𝐝 갨е 中両e̲ е갢лe̲ (2)';
        .close;
    }
}

# vim: expandtab shiftwidth=4
