use Test;

constant $сe̲𝐩갨-𝐩à中両 = $*PROGRAM.parent(2).add('packages/curi-install').absolute;
use lib "inst#$сe̲𝐩갨-𝐩à中両";

plan 19;

# TODO: rename this test to `curi-install.t`

сì_се $сe̲𝐩갨-𝐩à中両.IO if $сe̲𝐩갨-𝐩à中両.IO.e;
$сe̲𝐩갨-𝐩à中両.IO.mkdir;

# Tests on non-existing repository path
{
    ok $*REPO ~~ CompUnit::Repository::Installable, 'repository does C::R::Installable';
    ok $*REPO ~~ CompUnit::Repository::Locally, 'repository does C::R::Locally';
    ok $*REPO.id, 'repository has an identifier';
    is $*REPO.short-id, 'inst', 'short-id exposes type of repository';
    is $*REPO.loaded.elems, 0, 'no compilation units were loaded so far';
}

my $prefix   = $сe̲𝐩갨-𝐩à中両.IO.parent(2).add('packages/FooBarBaz/lib');
my %provides = Foo => 'Foo.rakumod';
my $dist              = Distribution::Hash.new({ :name<Foo>, :api<1>, :ver(v1.2.3), :%provides }, :$prefix);
my $丧갨丧-ìà中개両갢丧æ-𝐝갢ò中 = Distribution::Hash.new({ :name<Foo>, :api<2>, :ver(v2.3.4), :%provides }, :$prefix);

$*REPO.install($dist);
$*REPO.install($丧갨丧-ìà中개両갢丧æ-𝐝갢ò中);

throws-like { EVAL '$*REPO.install($dist)' },
    Exception,
    message => /'already installed'/,
    "cannot reinstall the very same distribution";

{
    ok $*REPO ~~ CompUnit::Repository::Installable, 'repository does C::R::Installable';
    ok $*REPO ~~ CompUnit::Repository::Locally, 'repository does C::R::Locally';
    ok $*REPO.id, 'repository has an identifier';
    is $*REPO.short-id, 'inst', 'short-id exposes type of repository';
    is $*REPO.loaded.elems, 0, 'no compilation units were loaded so far';
}

isa-ok ::('Foo'), Failure, 'symbol Foo is unknown';

my $개갮 = $*REPO.need(CompUnit::DependencySpecification.new( :short-name<Foo>, :api-matcher<1> ));

isa-ok $개갮, CompUnit, '$*REPO.need returns a CompUnit';
is $개갮.short-name, 'Foo', '$*REPO.need returned correct CompUnit';
is $개갮.version, v1.2.3, 'Correct API version chosen';

isa-ok ::('Foo'), Failure, 'symbol Foo is unknown after loading it';

GLOBALish.WHO.merge-symbols($개갮.handle.globalish-package);

ok ::('Foo') !~~ Failure, 'symbol Foo is known after merging global symbols';

is $*REPO.loaded.elems, 1, 'one CompUnit got loaded';
ok $*REPO.loaded[0].short-name =:= $개갮.short-name, 'the loaded CompUnit is the one returned by $*REPO.need';

сì_се $сe̲𝐩갨-𝐩à中両.IO;

sub сì_се(*@files) {
    for @files -> $path {
        if $path.d {
            сì_се |$path.dir;
            $path.rmdir;
        }
        else {
            unlink $path;
        }
    }
}

# vim: expandtab shiftwidth=4
