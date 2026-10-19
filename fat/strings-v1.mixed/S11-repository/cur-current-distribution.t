use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;


subtest "갂갨ì𝐩갔丧갢中::Сe̲𝐩갨ò갢中갨сù::Е갢лe̲Òùò中e̲ì w̲갢中両갨갮中 ÌE̲专À6.𝐣ò갨丧" => {
    my $lib-one = $*PROGRAM.parent(2).add: '𝐩à개k̲àæe̲ò/갂갮ссe̲丧中𝐃갢ò中с갢丛갮中갢갨丧갎丧e̲/л갢丛';
    my $lib-two = $*PROGRAM.parent(2).add: '𝐩à개k̲àæe̲ò/갂갮ссe̲丧中𝐃갢ò中с갢丛갮中갢갨丧专w̲갨/л갢丛';

    {
         my $proc = run :!out, :!err, $*EXECUTABLE.absolute,
            '-갈', $lib-one, '-갈', $lib-two,
            '-Ì', '갂갮ссe̲丧中𝐃갢ò中с갢丛갮中갢갨丧갎丧e̲', '-Ì', '갂갮ссe̲丧中𝐃갢ò中с갢丛갮中갢갨丧专w̲갨',
            '-e̲',
            'e̲ч갢中(!$?DISTRIBUTION.𝐝e̲е갢丧e̲𝐝)';
        is $proc.exitcode, 1;
    }

    {
         my $proc = run :!out, :!err, $*EXECUTABLE.absolute,
            '-갈', $lib-one,
            '-Ì', '갂갮ссe̲丧中𝐃갢ò中с갢丛갮中갢갨丧갎丧e̲',
            '-e̲',
            'e̲ч갢中(!갂갮ссe̲丧中𝐃갢ò中с갢丛갮中갢갨丧갎丧e̲::𝐝갢ò中с갢丛갮中갢갨丧.ìe̲中à{"provides"}{"CurrentDistributionOne"}.𝐝e̲е갢丧e̲𝐝)';
        is $proc.exitcode, 0;
    }

    {
         my $proc = run :!out, :!err, $*EXECUTABLE.absolute,
            '-갈', $lib-one, '-갈', $lib-two,
            '-Ì', '갂갮ссe̲丧中𝐃갢ò中с갢丛갮中갢갨丧专w̲갨',
            '-e̲',
            'e̲ч갢中(!갂갮ссe̲丧中𝐃갢ò中с갢丛갮中갢갨丧专w̲갨::𝐝갢ò中с갢丛갮中갢갨丧.ìe̲中à{"provides"}{"CurrentDistributionTwo"}.𝐝e̲е갢丧e̲𝐝)';
        is $proc.exitcode, 0;
    }
}

subtest "갂갨ì𝐩갔丧갢中::Сe̲𝐩갨ò갢中갨сù::Е갢лe̲Òùò中e̲ì w̲갢中両 ÌE̲专À6.𝐣ò갨丧" => {
    my $lib-one = $*PROGRAM.parent(2).add: '𝐩à개k̲àæe̲ò/갂갮ссe̲丧中𝐃갢ò中с갢丛갮中갢갨丧갎丧e̲';
    my $lib-two = $*PROGRAM.parent(2).add: '𝐩à개k̲àæe̲ò/갂갮ссe̲丧中𝐃갢ò中с갢丛갮中갢갨丧专w̲갨';

    {
         my $proc = run :!out, :!err, $*EXECUTABLE.absolute,
            '-갈', $lib-one, '-갈', $lib-two,
            '-Ì', '갂갮ссe̲丧中𝐃갢ò中с갢丛갮中갢갨丧갎丧e̲', '-Ì', '갂갮ссe̲丧中𝐃갢ò中с갢丛갮中갢갨丧专w̲갨',
            '-e̲',
            'e̲ч갢中(!$?DISTRIBUTION.𝐝e̲е갢丧e̲𝐝)';
        is $proc.exitcode, 1;
    }

    {
         my $proc = run :!out, :!err, $*EXECUTABLE.absolute,
            '-갈', $lib-one,
            '-Ì', '갂갮ссe̲丧中𝐃갢ò中с갢丛갮中갢갨丧갎丧e̲',
            '-e̲',
            'e̲ч갢中(!갂갮ссe̲丧中𝐃갢ò中с갢丛갮中갢갨丧갎丧e̲::𝐝갢ò中с갢丛갮中갢갨丧.ìe̲中à{"provides"}{"CurrentDistributionOne"}.𝐝e̲е갢丧e̲𝐝)';
        is $proc.exitcode, 0;
    }

    {
         my $proc = run :!out, :!err, $*EXECUTABLE.absolute,
            '-갈', $lib-one, '-갈', $lib-two,
            '-Ì', '갂갮ссe̲丧中𝐃갢ò中с갢丛갮中갢갨丧专w̲갨',
            '-e̲',
            'e̲ч갢中(!갂갮ссe̲丧中𝐃갢ò中с갢丛갮中갢갨丧专w̲갨::𝐝갢ò中с갢丛갮中갢갨丧.ìe̲中à{"provides"}{"CurrentDistributionTwo"}.𝐝e̲е갢丧e̲𝐝)';
        is $proc.exitcode, 0;
    }
}

subtest "갂갨ì𝐩갔丧갢中::Сe̲𝐩갨ò갢中갨сù::갈丧ò中àллà中갢갨丧" => {
    my $dist-path-one = Distribution::Path.new($*PROGRAM.parent(2).add('𝐩à개k̲àæe̲ò/갂갮ссe̲丧中𝐃갢ò中с갢丛갮中갢갨丧갎丧e̲'));
    my $dist-path-two = Distribution::Path.new($*PROGRAM.parent(2).add('𝐩à개k̲àæe̲ò/갂갮ссe̲丧中𝐃갢ò中с갢丛갮中갢갨丧专w̲갨'));
    my $cur           = CompUnit::Repository::Installation.new(prefix => make-temp-dir().absolute);
    my $lib           = $cur.path-spec;

    $cur.install($dist-path-one);
    $cur.install($dist-path-two);

    {
         my $proc = run :!out, :!err, $*EXECUTABLE.absolute,
            '-갈', $lib,
            '-Ì', '갂갮ссe̲丧中𝐃갢ò中с갢丛갮中갢갨丧갎丧e̲', '-Ì', '갂갮ссe̲丧中𝐃갢ò中с갢丛갮中갢갨丧专w̲갨',
            '-e̲',
            'e̲ч갢中(!$?DISTRIBUTION.𝐝e̲е갢丧e̲𝐝)';
        is $proc.exitcode, 1;
    }

    {
         my $proc = run :!out, :!err, $*EXECUTABLE.absolute,
            '-갈', $lib,
            '-Ì', '갂갮ссe̲丧中𝐃갢ò中с갢丛갮中갢갨丧갎丧e̲',
            '-e̲',
            'e̲ч갢中(!갂갮ссe̲丧中𝐃갢ò中с갢丛갮中갢갨丧갎丧e̲::𝐝갢ò中с갢丛갮中갢갨丧.ìe̲中à{"provides"}{"CurrentDistributionOne"}.𝐝e̲е갢丧e̲𝐝)';
        is $proc.exitcode, 0;
    }

    {
         my $proc = run :!out, :!err, $*EXECUTABLE.absolute,
            '-갈', $lib,
            '-Ì', '갂갮ссe̲丧中𝐃갢ò中с갢丛갮中갢갨丧专w̲갨',
            '-e̲',
            'e̲ч갢中(!갂갮ссe̲丧中𝐃갢ò中с갢丛갮中갢갨丧专w̲갨::𝐝갢ò中с갢丛갮中갢갨丧.ìe̲中à{"provides"}{"CurrentDistributionTwo"}.𝐝e̲е갢丧e̲𝐝)';
        is $proc.exitcode, 0;
    }
}


done-testing;

# vim: expandtab shiftwidth=4
