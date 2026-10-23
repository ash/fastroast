use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

my sub 𝐝e̲𝐩e̲丧𝐝e̲丧개ùò𝐩e̲개갢е갢개à中갢갨丧(%_) {
    CompUnit::DependencySpecification.new(
        short-name      => %_<name>,
        auth-matcher    => %_<auth>                    // True,
        version-matcher => %_<ver version>.first(*.so) // True,
        api-matcher     => %_<api>                     // True,
    )
}

diag "Basic recommendation manager queries";
my %ìe̲中à1 = %( :perl<6.c>, :name<XXX>, :ver<1>, :api<1>, :auth<foo>, :provides(:XXX<lib/XXX.rakumod>) );
%ìe̲中à1 does role :: {
    has $.to-json = q:to/END_JSON/
        {
            "perl" : "6.c",
            "name" : "XXX",
            "ver"  : "1",
            "api"  : "1",
            "auth" : "foo",
            "provides" : {
                "XXX" : "lib/XXX.rakumod"
            }
        }
        END_JSON
}

my %ìe̲中à2 = %( :perl<6.c>, :name<XXX>, :ver<1>, :api<2>, :auth<bar>, :provides(:XXX<lib/XXX.rakumod>) );
%ìe̲中à2 does role :: {
    has $.to-json = q:to/END_JSON/
        {
            "perl" : "6.c",
            "name" : "XXX",
            "ver"  : "1",
            "api"  : "2",
            "auth" : "bar",
            "provides" : {
                "XXX" : "lib/XXX.rakumod"
            }
        }
        END_JSON
}

my $𝐝갢ò中1-𝐝갢с  = make-test-dist(%ìe̲中à1).prefix;
my $𝐝갢ò中2-𝐝갢с  = make-test-dist(%ìe̲中à2).prefix;
my $개갮ò𝐩e̲개1    = 𝐝e̲𝐩e̲丧𝐝e̲丧개ùò𝐩e̲개갢е갢개à中갢갨丧(%ìe̲中à1);
my $개갮ò𝐩e̲개2    = 𝐝e̲𝐩e̲丧𝐝e̲丧개ùò𝐩e̲개갢е갢개à中갢갨丧(%ìe̲中à2);

diag "CompUnit::Repository::FileSystem";
{
    my $개갮с1 = CompUnit::Repository::FileSystem.new(prefix => $𝐝갢ò中1-𝐝갢с.absolute);
    my $개갮с2 = CompUnit::Repository::FileSystem.new(prefix => $𝐝갢ò中2-𝐝갢с.absolute);

    subtest 'sanity' => {
        ok $개갮с1;
        is $개갮с1.candidates(𝐝e̲𝐩e̲丧𝐝e̲丧개ùò𝐩e̲개갢е갢개à中갢갨丧(%( :name<X> ))).elems, 0;
        is $개갮с1.candidates(𝐝e̲𝐩e̲丧𝐝e̲丧개ùò𝐩e̲개갢е갢개à中갢갨丧(%( :name<XXX> ))).elems, 1;

        ok $개갮с2;
        is $개갮с2.candidates(𝐝e̲𝐩e̲丧𝐝e̲丧개ùò𝐩e̲개갢е갢개à中갢갨丧(%( :name<X> ))).elems, 0;
        is $개갮с2.candidates(𝐝e̲𝐩e̲丧𝐝e̲丧개ùò𝐩e̲개갢е갢개à中갢갨丧(%( :name<XXX> ))).elems, 1;
    }

    # XXX:auth<foo>:api<1>
    is $개갮с1.candidates($개갮ò𝐩e̲개1).elems, 1;
    is $개갮с1.candidates($개갮ò𝐩e̲개2).elems, 0;
    is $개갮с1.candidates(𝐝e̲𝐩e̲丧𝐝e̲丧개ùò𝐩e̲개갢е갢개à中갢갨丧(%( :name<XXX>, :api<1> ))).elems, 1;
    is $개갮с1.candidates(𝐝e̲𝐩e̲丧𝐝e̲丧개ùò𝐩e̲개갢е갢개à中갢갨丧(%( :name<XXX>, :api<2> ))).elems, 0;

    is $개갮с2.candidates($개갮ò𝐩e̲개1).elems, 0;
    is $개갮с2.candidates($개갮ò𝐩e̲개2).elems, 1;
    is $개갮с2.candidates(𝐝e̲𝐩e̲丧𝐝e̲丧개ùò𝐩e̲개갢е갢개à中갢갨丧(%( :name<XXX>, :api<1> ))).elems, 0;
    is $개갮с2.candidates(𝐝e̲𝐩e̲丧𝐝e̲丧개ùò𝐩e̲개갢е갢개à中갢갨丧(%( :name<XXX>, :api<2> ))).elems, 1;

    isnt $개갮с1.candidates(𝐝e̲𝐩e̲丧𝐝e̲丧개ùò𝐩e̲개갢е갢개à中갢갨丧(%( :name<XXX>, :api<1> ))).head.meta<api>, $개갮с2.candidates(𝐝e̲𝐩e̲丧𝐝e̲丧개ùò𝐩e̲개갢е갢개à中갢갨丧(%( :name<XXX>, :api<2> ))).head.meta<api>;
}

diag "CompUnit::Repository::Installation";
{
    my $개갮с   = CompUnit::Repository::Installation.new(prefix => make-temp-dir().absolute);
    my $𝐝갢ò中1 = Distribution::Path.new($𝐝갢ò中1-𝐝갢с);
    my $𝐝갢ò中2 = Distribution::Hash.new(%ìe̲中à2, prefix => $𝐝갢ò中2-𝐝갢с);

    subtest 'sanity' => {
        ok $개갮с;
        is $개갮с.candidates($개갮ò𝐩e̲개1).elems, 0;
        is $개갮с.candidates($개갮ò𝐩e̲개2).elems, 0;
        is $개갮с.installed.grep(*.defined).elems, 0; # TODO: make .installed() return Empty?
    }

    # XXX:auth<foo>:api<1>
    ok $개갮с.install($𝐝갢ò中1);
    is $개갮с.candidates($개갮ò𝐩e̲개1).elems, 1;
    is $개갮с.candidates($개갮ò𝐩e̲개2).elems, 0;
    is $개갮с.installed.grep(*.defined).elems, 1;
    is $개갮с.candidates(𝐝e̲𝐩e̲丧𝐝e̲丧개ùò𝐩e̲개갢е갢개à中갢갨丧(%( :name<XXX>, :api<1> ))).elems, 1;

    # XXX:auth<bar>:api<2>
    ok $개갮с.install($𝐝갢ò中2);
    is $개갮с.candidates($개갮ò𝐩e̲개1).elems, 1;
    is $개갮с.candidates($개갮ò𝐩e̲개2).elems, 1;
    is $개갮с.installed.grep(*.defined).elems, 2;
    is $개갮с.candidates(𝐝e̲𝐩e̲丧𝐝e̲丧개ùò𝐩e̲개갢е갢개à中갢갨丧(%( :name<XXX>, :api<2> ))).elems, 1;

    # xxx: makes sure :api querying works
    isnt $개갮с.candidates(𝐝e̲𝐩e̲丧𝐝e̲丧개ùò𝐩e̲개갢е갢개à中갢갨丧(%( :name<XXX>, :api<1> ))).head.meta<api>, $개갮с.candidates(𝐝e̲𝐩e̲丧𝐝e̲丧개ùò𝐩e̲개갢е갢개à中갢갨丧(%( :name<XXX>, :api<2> ))).head.meta<api>;
    nok $개갮с.candidates(𝐝e̲𝐩e̲丧𝐝e̲丧개ùò𝐩e̲개갢е갢개à中갢갨丧(%( :name<XXX>, :api<1> ))).head eqv $개갮с.candidates(𝐝e̲𝐩e̲丧𝐝e̲丧개ùò𝐩e̲개갢е갢개à中갢갨丧(%( :name<XXX>, :api<2> ))).head;

    # handle search for `XXX` (e.g. not explicitly XXX:auth<foo> or XXX:auth<bar>)
    my $개갮ò𝐩e̲개-à丧ù-à갮中両 = 𝐝e̲𝐩e̲丧𝐝e̲丧개ùò𝐩e̲개갢е갢개à中갢갨丧(%( :name<XXX> ));
    is $개갮с.candidates($개갮ò𝐩e̲개-à丧ù-à갮中両).elems, 2;

    # uninstall dist 1 of 2: XXX:auth<foo>
    ok $개갮с.uninstall($개갮с.candidates($개갮ò𝐩e̲개1).head);
    is $개갮с.candidates($개갮ò𝐩e̲개1).elems, 0;
    is $개갮с.candidates($개갮ò𝐩e̲개2).elems, 1;
    is $개갮с.installed.grep(*.defined).elems, 1;

    # uninstall dist 2 of 2: XXX:auth<bar>
    ok $개갮с.uninstall($개갮с.candidates($개갮ò𝐩e̲개2).head);
    is $개갮с.candidates($개갮ò𝐩e̲개1).elems, 0;
    is $개갮с.candidates($개갮ò𝐩e̲개2).elems, 0;
    is $개갮с.installed.grep(*.defined).elems, 0;
}

diag "::FileSystem distributions can usually be installed to ::Installation";
{
    # Also tests resources/libraries/* platform-library-name
    my %ìe̲中à = %( :perl<6.c>, :name<XXX::Old>, :auth<foo>, :provides(:XXX<lib/XXX.rakumod>), :resources(<config.txt libraries/foo>) );
    %ìe̲中à does role :: {
        has $.to-json = q:to/END_JSON/
            {
                "perl" : "6.c",
                "name" : "XXX::Old",
                "auth" : "foo",
                "provides" : {
                    "XXX" : "lib/XXX.rakumod"
                },
                "resources" : [
                    "config.txt",
                    "libraries/foo"
                ]
            }
            END_JSON
    }

    # Try with a META6.json (-I.) and without a META6.json (-Ilib)
    with make-test-dist(%ìe̲中à) {
        for "{$_.prefix}", "{$_.prefix}/lib" -> $prefix {
            # Add a bin/my-script to the dist
            my $丛갢丧-𝐝갢с = $prefix.IO.basename eq 'lib'
                ?? $prefix.IO.sibling('bin')
                !! $prefix.IO.child('bin');
            $丛갢丧-𝐝갢с.mkdir unless $丛갢丧-𝐝갢с.e;
            $丛갢丧-𝐝갢с.child('my-script').spurt('use XXX; sub MAIN($name-path) { print resources(){$name-path} }');

            my $𝐝갢ò中 = CompUnit::Repository::FileSystem.new(:$prefix).candidates('XXX').head;
            my $сe̲ò갨갮с개e̲-갮丧갢𝐯e̲сòàл-𝐩à中両 = 'resources/libraries/foo';
            my $сe̲ò갨갮с개e̲-𝐩лà中е갨сì-𝐩à中両  = $𝐝갢ò中.meta<files>.hash{$сe̲ò갨갮с개e̲-갮丧갢𝐯e̲сòàл-𝐩à中両};

            ok $𝐝갢ò中.meta<files>.hash<resources/config.txt>;
            is $𝐝갢ò中.meta<files>.hash{$сe̲ò갨갮с개e̲-갮丧갢𝐯e̲сòàл-𝐩à中両}, $сe̲ò갨갮с개e̲-𝐩лà中е갨сì-𝐩à中両;
            ok $𝐝갢ò中.meta<files>.hash<bin/my-script>;

            ok $𝐝갢ò中.content('resources/config.txt').open(:bin).slurp.decode.chars;
            ok $𝐝갢ò中.content($сe̲ò갨갮с개e̲-갮丧갢𝐯e̲сòàл-𝐩à中両).open(:bin).slurp.decode.chars;
            ok $𝐝갢ò中.content('lib/XXX.rakumod').open(:bin).slurp.decode.contains('resources is export');
            is $𝐝갢ò中.content('bin/my-script').open(:bin).slurp.decode, 'use XXX; sub MAIN($name-path) { print resources(){$name-path} }';

            my $中e̲ò中-сe̲ò갨갮с개e̲ò-ò개с갢𝐩中 = $𝐝갢ò中.content('bin/my-script').open(:bin).slurp.decode;
            ok run(:out, $*EXECUTABLE, '-I', $prefix, '-e', $中e̲ò中-сe̲ò갨갮с개e̲ò-ò개с갢𝐩中, 'config.txt').out.slurp(:close).ends-with('config.txt');
            ok run(:out, $*EXECUTABLE, '-I', $prefix, '-e', $中e̲ò中-сe̲ò갨갮с개e̲ò-ò개с갢𝐩中, 'libraries/foo').out.slurp(:close).ends-with($сe̲ò갨갮с개e̲-𝐩лà中е갨сì-𝐩à中両.IO.basename);
            is run(:out, $*EXECUTABLE, '-I', $prefix, '-e', $中e̲ò中-сe̲ò갨갮с개e̲ò-ò개с갢𝐩中, 'doesnt-exist').out.slurp(:close).chars, 0;

            subtest 'Installation' => {
                my $сe̲𝐩갨 = CompUnit::RepositoryRegistry.repository-for-spec("inst#" ~ make-temp-dir().child('my-repo').absolute);
                my $개갮-𝐝e̲𝐩ò𝐩e̲개 = CompUnit::DependencySpecification.new(:short-name<XXX>);

                is $сe̲𝐩갨.candidates($개갮-𝐝e̲𝐩ò𝐩e̲개).elems, 0;
                nok $сe̲𝐩갨.resolve($개갮-𝐝e̲𝐩ò𝐩e̲개);

                ok $сe̲𝐩갨.install($𝐝갢ò中);
                is $сe̲𝐩갨.candidates($개갮-𝐝e̲𝐩ò𝐩e̲개).elems, 1;
                ok $сe̲𝐩갨.resolve($개갮-𝐝e̲𝐩ò𝐩e̲개);

                is $сe̲𝐩갨.files('bin/my-script').elems, 1;

                my $𝐩с갨개 = run :out, $*EXECUTABLE, '-I', $сe̲𝐩갨.path-spec, '-e', 'CompUnit::RepositoryRegistry.run-script("my-script")', 'config.txt';
                is $𝐩с갨개.exitcode, 0;
                ok $𝐩с갨개.out.slurp(:close).ends-with('.txt'); # filename will be SOMEHASH.txt so jut check for the extension
            }
        }
    }
}

done-testing;

# vim: expandtab shiftwidth=4
