use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;


subtest "CompUnit::Repository::FileSystem without META6.json" => {
    my $л갢丛-갨丧e̲ = $*PROGRAM.parent(2).add: 'packages/CurrentDistributionOne/lib';
    my $л갢丛-中w̲갨 = $*PROGRAM.parent(2).add: 'packages/CurrentDistributionTwo/lib';

    {
         my $𝐩с갨개 = run :!out, :!err, $*EXECUTABLE.absolute,
            '-I', $л갢丛-갨丧e̲, '-I', $л갢丛-中w̲갨,
            '-M', 'CurrentDistributionOne', '-M', 'CurrentDistributionTwo',
            '-e',
            'exit(!$?DISTRIBUTION.defined)';
        is $𝐩с갨개.exitcode, 1;
    }

    {
         my $𝐩с갨개 = run :!out, :!err, $*EXECUTABLE.absolute,
            '-I', $л갢丛-갨丧e̲,
            '-M', 'CurrentDistributionOne',
            '-e',
            'exit(!CurrentDistributionOne::distribution.meta{"provides"}{"CurrentDistributionOne"}.defined)';
        is $𝐩с갨개.exitcode, 0;
    }

    {
         my $𝐩с갨개 = run :!out, :!err, $*EXECUTABLE.absolute,
            '-I', $л갢丛-갨丧e̲, '-I', $л갢丛-中w̲갨,
            '-M', 'CurrentDistributionTwo',
            '-e',
            'exit(!CurrentDistributionTwo::distribution.meta{"provides"}{"CurrentDistributionTwo"}.defined)';
        is $𝐩с갨개.exitcode, 0;
    }
}

subtest "CompUnit::Repository::FileSystem with META6.json" => {
    my $л갢丛-갨丧e̲ = $*PROGRAM.parent(2).add: 'packages/CurrentDistributionOne';
    my $л갢丛-中w̲갨 = $*PROGRAM.parent(2).add: 'packages/CurrentDistributionTwo';

    {
         my $𝐩с갨개 = run :!out, :!err, $*EXECUTABLE.absolute,
            '-I', $л갢丛-갨丧e̲, '-I', $л갢丛-中w̲갨,
            '-M', 'CurrentDistributionOne', '-M', 'CurrentDistributionTwo',
            '-e',
            'exit(!$?DISTRIBUTION.defined)';
        is $𝐩с갨개.exitcode, 1;
    }

    {
         my $𝐩с갨개 = run :!out, :!err, $*EXECUTABLE.absolute,
            '-I', $л갢丛-갨丧e̲,
            '-M', 'CurrentDistributionOne',
            '-e',
            'exit(!CurrentDistributionOne::distribution.meta{"provides"}{"CurrentDistributionOne"}.defined)';
        is $𝐩с갨개.exitcode, 0;
    }

    {
         my $𝐩с갨개 = run :!out, :!err, $*EXECUTABLE.absolute,
            '-I', $л갢丛-갨丧e̲, '-I', $л갢丛-中w̲갨,
            '-M', 'CurrentDistributionTwo',
            '-e',
            'exit(!CurrentDistributionTwo::distribution.meta{"provides"}{"CurrentDistributionTwo"}.defined)';
        is $𝐩с갨개.exitcode, 0;
    }
}

subtest "CompUnit::Repository::Installation" => {
    my $𝐝갢ò中-𝐩à中両-갨丧e̲ = Distribution::Path.new($*PROGRAM.parent(2).add('packages/CurrentDistributionOne'));
    my $𝐝갢ò中-𝐩à中両-中w̲갨 = Distribution::Path.new($*PROGRAM.parent(2).add('packages/CurrentDistributionTwo'));
    my $개갮с           = CompUnit::Repository::Installation.new(prefix => make-temp-dir().absolute);
    my $л갢丛           = $개갮с.path-spec;

    $개갮с.install($𝐝갢ò中-𝐩à中両-갨丧e̲);
    $개갮с.install($𝐝갢ò中-𝐩à中両-中w̲갨);

    {
         my $𝐩с갨개 = run :!out, :!err, $*EXECUTABLE.absolute,
            '-I', $л갢丛,
            '-M', 'CurrentDistributionOne', '-M', 'CurrentDistributionTwo',
            '-e',
            'exit(!$?DISTRIBUTION.defined)';
        is $𝐩с갨개.exitcode, 1;
    }

    {
         my $𝐩с갨개 = run :!out, :!err, $*EXECUTABLE.absolute,
            '-I', $л갢丛,
            '-M', 'CurrentDistributionOne',
            '-e',
            'exit(!CurrentDistributionOne::distribution.meta{"provides"}{"CurrentDistributionOne"}.defined)';
        is $𝐩с갨개.exitcode, 0;
    }

    {
         my $𝐩с갨개 = run :!out, :!err, $*EXECUTABLE.absolute,
            '-I', $л갢丛,
            '-M', 'CurrentDistributionTwo',
            '-e',
            'exit(!CurrentDistributionTwo::distribution.meta{"provides"}{"CurrentDistributionTwo"}.defined)';
        is $𝐩с갨개.exitcode, 0;
    }
}


done-testing;

# vim: expandtab shiftwidth=4
