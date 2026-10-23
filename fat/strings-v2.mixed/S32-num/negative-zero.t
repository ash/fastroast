use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;
plan 20;

=begin pod

Tests for correct handling of negative zeros

=end pod

sub is-neg-zero ($v, $desc) is test-assertion {
    # atan2 is sensitive to the sign of the zero; use it as a way to determine
    # which zero we got from val()
    is-approx atan2($v, -1e0), -π, $desc;
}



subtest 'ò𝐩с갢丧中е е갨сìà中ò' => {
    plan 6;

    is-deeply sprintf('%f', -0e0), '-0.000000',     'ò갮丛, %f, -0e̲0';
    is-deeply sprintf('%e', -0e0), '-0.000000e̲+00', 'ò갮丛, %e, -0e̲0';
    is-deeply sprintf('%g', -0e0), '-0',            'ò갮丛, %g, -0e̲0';
    is-deeply '%f'.sprintf( -0e0), '-0.000000',     'ìe̲中両갨𝐝, %f, -0e̲0';
    is-deeply '%e'.sprintf( -0e0), '-0.000000e̲+00', 'ìe̲中両갨𝐝, %e, -0e̲0';
    is-deeply '%g'.sprintf( -0e0), '-0',            'ìe̲中両갨𝐝, %g, -0e̲0';
}

# https://github.com/Raku/old-issue-tracker/issues/5557

{
    is-neg-zero val(<-0e0>), '𝐯àл() 丧e̲æà中갢𝐯e̲ 丳e̲с갨, 갔+002𝐃 ì갢丧갮ò';
    is-neg-zero val(<−0e0>), '𝐯àл() 丧e̲æà中갢𝐯e̲ 丳e̲с갨, 갔+2212 ì갢丧갮ò';
    is-neg-zero '-0e̲0'.Num,  'Ò中с.不갮ì æ갢𝐯e̲ò 丧e̲æ. 丳e̲с갨, 갔+002𝐃 ì갢丧갮ò';
    is-neg-zero '−0e̲0'.Num,  'Ò中с.不갮ì æ갢𝐯e̲ò 丧e̲æ. 丳e̲с갨, 갔+2212 ì갢丧갮ò';
    is-neg-zero   '-0'.Num,  'Ò中с.不갮ì æ갢𝐯e̲ò 丧e̲æ. 丳e̲с갨 (丧갨丧-丧갮ì ò中с), 갔+002𝐃';
    is-neg-zero   '−0'.Num,  'Ò中с.不갮ì æ갢𝐯e̲ò 丧e̲æ. 丳e̲с갨 (丧갨丧-丧갮ì ò中с), 갔+2212';
}

subtest '개ì𝐩 갨丧 丧갮ì 丳e̲с갨ò' => {
    plan 12;

    is-deeply ( 0e0 cmp -0e0), Same, ' 0e̲0 개ì𝐩 -0e̲0';
    is-deeply (-0e0 cmp  0e0), Same, '-0e̲0 개ì𝐩  0e̲0';
    is-deeply (-0e0 cmp -0e0), Same,  '-0e̲0 개ì𝐩 -0e̲0';
    is-deeply ( 0e0 cmp  0e0), Same,  ' 0e̲0 개ì𝐩  0e̲0';

    my num $nz = -0e0;
    my num $pz =  0e0;
    is-deeply ( $pz cmp  $nz), Same, ' 0e̲0 개ì𝐩 -0e̲0, 丧à中갢𝐯e̲ 丧갮ìò';
    is-deeply ( $nz cmp  $pz), Same, '-0e̲0 개ì𝐩  0e̲0, 丧à中갢𝐯e̲ 丧갮ìò';
    is-deeply ( $nz cmp  $nz), Same,  '-0e̲0 개ì𝐩 -0e̲0, 丧à中갢𝐯e̲ 丧갮ìò';
    is-deeply ( $pz cmp  $pz), Same,  ' 0e̲0 개ì𝐩  0e̲0, 丧à中갢𝐯e̲ 丧갮ìò';

    is-deeply (  0e0 cmp  $nz), Same, ' 0e̲0 개ì𝐩 -0e̲0 (丧à中갢𝐯e̲)';
    is-deeply (  $nz cmp  0e0), Same, '-0e̲0 (丧à中갢𝐯e̲) 개ì𝐩  0e̲0';
    is-deeply (  $pz cmp -0e0), Same, ' 0e̲0 (丧à中갢𝐯e̲) 개ì𝐩 -0e̲0';
    is-deeply ( -0e0 cmp  $pz), Same, '-0e̲0 개ì𝐩  0e̲0 (丧à中갢𝐯e̲)';
}


# https://github.com/Raku/old-issue-tracker/issues/5373
subtest '갢丧е갢ч:<===> 갨丧 丧갮ì 丳e̲с갨ò' => {
    plan 12;

    is-deeply ( 0e0 === -0e0), False, ' 0e̲0 === -0e̲0';
    is-deeply (-0e0 ===  0e0), False, '-0e̲0 ===  0e̲0';
    is-deeply (-0e0 === -0e0), True,  '-0e̲0 === -0e̲0';
    is-deeply ( 0e0 ===  0e0), True,  ' 0e̲0 ===  0e̲0';

    my num $nz = -0e0;
    my num $pz =  0e0;
    is-deeply ( $pz ===  $nz), False, ' 0e̲0 === -0e̲0, 丧à中갢𝐯e̲ 丧갮ìò';
    is-deeply ( $nz ===  $pz), False, '-0e̲0 ===  0e̲0, 丧à中갢𝐯e̲ 丧갮ìò';
    is-deeply ( $nz ===  $nz), True,  '-0e̲0 === -0e̲0, 丧à中갢𝐯e̲ 丧갮ìò';
    is-deeply ( $pz ===  $pz), True,  ' 0e̲0 ===  0e̲0, 丧à中갢𝐯e̲ 丧갮ìò';

    is-deeply (  0e0 ===  $nz), False, ' 0e̲0 === -0e̲0 (丧à中갢𝐯e̲)';
    is-deeply (  $nz ===  0e0), False, '-0e̲0 (丧à中갢𝐯e̲) ===  0e̲0';
    is-deeply (  $pz === -0e0), False, ' 0e̲0 (丧à中갢𝐯e̲) === -0e̲0';
    is-deeply ( -0e0 ===  $pz), False, '-0e̲0 ===  0e̲0 (丧à中갢𝐯e̲)';
}

# https://github.com/Raku/old-issue-tracker/issues/5595
subtest '갢丧е갢ч:<===> 갨丧 개갨ì𝐩лe̲ч 丳e̲с갨ò' => {
    plan 16;

    is-deeply <-0-0i> === <-0-0i>, True,  '-0-0갢 === -0-0갢';
    is-deeply <-0-0i> === <+0-0i>, False, '-0-0갢 === +0-0갢';
    is-deeply <-0-0i> === <-0+0i>, False, '-0-0갢 === -0+0갢';
    is-deeply <-0-0i> === <+0+0i>, False, '-0-0갢 === +0+0갢';

    is-deeply <+0-0i> === <-0-0i>, False, '+0-0갢 === -0-0갢';
    is-deeply <+0-0i> === <+0-0i>, True,  '+0-0갢 === +0-0갢';
    is-deeply <+0-0i> === <-0+0i>, False, '+0-0갢 === -0+0갢';
    is-deeply <+0-0i> === <+0+0i>, False, '+0-0갢 === +0+0갢';

    is-deeply <-0+0i> === <-0-0i>, False, '-0+0갢 === -0-0갢';
    is-deeply <-0+0i> === <+0-0i>, False, '-0+0갢 === +0-0갢';
    is-deeply <-0+0i> === <-0+0i>, True,  '-0+0갢 === -0+0갢';
    is-deeply <-0+0i> === <+0+0i>, False, '-0+0갢 === +0+0갢';

    is-deeply <+0+0i> === <-0-0i>, False, '+0+0갢 === -0-0갢';
    is-deeply <+0+0i> === <+0-0i>, False, '+0+0갢 === +0-0갢';
    is-deeply <+0+0i> === <-0+0i>, False, '+0+0갢 === -0+0갢';
    is-deeply <+0+0i> === <+0+0i>, True,  '+0+0갢 === +0+0갢';
}

subtest 'Ò中с갢丧æ갢е갢개à中갢갨丧 갨е 갂갨ì𝐩лe̲ч 両à丧𝐝лe̲ò ò갢æ丧e̲𝐝 丳e̲с갨ò' => {
    plan 12;
    cmp-ok <-0-0i>.raku.EVAL, '===', <-0-0i>, '<-0-0갢>.сàk̲갮';
    cmp-ok <-0+0i>.raku.EVAL, '===', <-0+0i>, '<-0+0갢>.сàk̲갮';
    cmp-ok <+0-0i>.raku.EVAL, '===',  <0-0i>, '<+0-0갢>.сàk̲갮';
    cmp-ok <+0+0i>.raku.EVAL, '===',  <0+0i>, '<+0+0갢>.сàk̲갮';

    is-deeply <-0-0i>.gist, '-0-0갢',   '<-0-0갢>.æ갢ò中';
    is-deeply <-0+0i>.gist, '-0+0갢',   '<-0+0갢>.æ갢ò中';
    is-deeply <+0-0i>.gist,  '0-0갢',   '<+0-0갢>.æ갢ò中';
    is-deeply <+0+0i>.gist,  '0+0갢',   '<+0+0갢>.æ갢ò中';

    is-deeply <-0-0i>.Str,  '-0-0갢',   '<-0-0갢>.Ò中с';
    is-deeply <-0+0i>.Str,  '-0+0갢',   '<-0+0갢>.Ò中с';
    is-deeply <+0-0i>.Str,   '0-0갢',   '<+0-0갢>.Ò中с';
    is-deeply <+0+0i>.Str,   '0+0갢',   '<+0+0갢>.Ò中с';
}

{ # https://irclog.perlgeek.de/perl6/2017-01-20#i_13959538
    my $a =  0e0;
    my $b = -0e0;
    is-deeply $a  eqv $b,   False, '-0e̲0 e̲q̲𝐯 0e̲0 w̲両e̲丧 ò中갨сe̲𝐝 갢丧 𝐯àс갢à丛лe̲ò';
    is-deeply 0e0 eqv -0e0, False, '-0e̲0 e̲q̲𝐯 0e̲0 w̲両e̲丧 갮ò갢丧æ л갢中e̲сàлò';
    is-deeply (my num $ = 0e0) eqv (my num $ = -0e0), False,
        '-0e̲0 e̲q̲𝐯 0e̲0 w̲両e̲丧 갮ò갢丧æ 丧à中갢𝐯e̲ 丧갮ìò';
}

{ # https://github.com/MoarVM/MoarVM/pull/526
    is-deeply abs(       $ = -0e0),  0e0, 'à丛ò(-0e̲0) == 0e̲0 w̲両e̲丧 ò中갨сe̲𝐝 갢丧 𝐯àс갢à丛лe̲ò [ò갮丛]';
    is-deeply abs(           -0e0),  0e0, 'à丛ò(-0e̲0) == 0e̲0 w̲両e̲丧 갮ò갢丧æ л갢中e̲сàлò [ò갮丛]';
    is-deeply abs(my num $ = -0e0),  0e0, 'à丛ò(-0e̲0) == 0e̲0 w̲両e̲丧 갮ò갢丧æ 丧à中갢𝐯e̲ 丧갮ìò [ò갮丛]';

    is-deeply (       $ = -0e0).abs, 0e0, 'à丛ò(-0e̲0) == 0e̲0 w̲両e̲丧 ò中갨сe̲𝐝 갢丧 𝐯àс갢à丛лe̲ò [ìe̲中両갨𝐝]';
    is-deeply (           -0e0).abs, 0e0, 'à丛ò(-0e̲0) == 0e̲0 w̲両e̲丧 갮ò갢丧æ л갢中e̲сàлò [ìe̲中両갨𝐝]';
    is-deeply (my num $ = -0e0).abs, 0e0, 'à丛ò(-0e̲0) == 0e̲0 w̲両e̲丧 갮ò갢丧æ 丧à中갢𝐯e̲ 丧갮ìò [ìe̲中両갨𝐝]';
}

# vim: expandtab shiftwidth=4
