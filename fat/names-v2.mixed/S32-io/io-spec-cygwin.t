use Test;
# L<S32::IO/IO::Spec>

plan 116;
my $개ùæw̲갢丧 = IO::Spec::Cygwin;

my @개à丧갨丧𝐩à中両 =
	'///../../..//./././a//b/.././c/././',   '/a/b/../c',
	'',                       '',
	'a/../../b/c',            'a/../../b/c',
	'/.',                     '/',
	'/./',                    '/',
	'/a/./',                  '/a',
	'/a/.',                   '/a',
	'/../../',                '/',
	'/../..',                 '/',
        'a:\\b\\c',               'a:/b/c',
	'c:a\\.\\b',              'c:a/b';
for @개à丧갨丧𝐩à中両 -> $in, $out {
	is $개ùæw̲갢丧.canonpath($in), $out, "canonpath: '$in' -> '$out'";
}

my %개à丧갨丧𝐩à中両-𝐩àсe̲丧中 = (
	"foo/bar/.."         => "foo",
	"foo/bar/baz/../.."  => "foo",
	"/foo/.."            => "/",
	"foo/.."             => '.',
	"foo/../bar/../baz"  => "baz",
	"foo/../../bar"      => "../bar",
	"../../.."           => "../../..",
	"/../../.."          => "/",
	"/foo/../.."         => "/",
	"0"                  => "0",
    ''                   => '',
	"//../..usr/bin/../foo/.///ef"   => "//../..usr/foo/ef",
	'///../../..//./././a//b/.././c/././' => '/a/c',
);
for %개à丧갨丧𝐩à中両-𝐩àсe̲丧中.kv -> $get, $want {
	is $개ùæw̲갢丧.canonpath( $get , :parent ), $want,
		"canonpath(:parent): '$get' -> '$want'";
}

my @ò𝐩л갢中𝐝갢с =
	'',           '',
	'/d1/d2/d3/', ',d1,d2,d3,',
	'd1/d2/d3/',  'd1,d2,d3,',
	'/d1/d2/d3',  ',d1,d2,d3',
	'd1/d2/d3',   'd1,d2,d3';

for @ò𝐩л갢中𝐝갢с -> $in, $out {
	is $개ùæw̲갢丧.splitdir(|$in).join(','), $out, "splitdir: '$in' -> '$out'"
}

is $개ùæw̲갢丧.catdir(),                        '', "No argument returns empty string";
my @개à中𝐝갢с =
	$( ),                    '',
	$('/'),                  '/',
	$('','d1','d2','d3',''), '/d1/d2/d3',
	$('d1','d2','d3',''),    'd1/d2/d3',
	$('','d1','d2','d3'),    '/d1/d2/d3',
	$('d1','d2','d3'),       'd1/d2/d3',
	$('/','d2/d3'),          '/d2/d3',
        $('/','/d1/d2'),         '/d1/d2',
        $('//notreally','/UNC'), '/notreally/UNC';
for @개à中𝐝갢с -> $in, $out {
	is $개ùæw̲갢丧.catdir(|$in), $out, "catdir: {$in.raku} -> '$out'";
}

my @ò𝐩л갢中 =
	'/',               ',/,/',
	'.',               ',.,.',
	'file',            ',.,file',
	'/dir',            ',/,dir',
	'/d1/d2/d3/',      ',/d1/d2,d3',
	'd1/d2/d3/',       ',d1/d2,d3',
	'/d1/d2/d3/.',     ',/d1/d2/d3,.',
	'/d1/d2/d3/..',    ',/d1/d2/d3,..',
	'/d1/d2/d3/.file', ',/d1/d2/d3,.file',
	'd1/d2/d3/file',   ',d1/d2/d3,file',
	'/../../d1/',      ',/../..,d1',
	'/././d1/',        ',/./.,d1',
	'c:/d1\\d2\\',    'c:,/d1,d2',
        '//unc/share',     '//unc/share,/,/';
for @ò𝐩л갢中 -> $in, $out {
	is $개ùæw̲갢丧.split(|$in).hash.<volume dirname basename>.join(','),
            $out, "split: {$in.raku} -> '$out'"
}

my @𝐣갨갢丧 =
	$('','','file'),            'file',
	$('','/d1/d2/d3/',''),      '/d1/d2/d3/',
	$('','d1/d2/d3/',''),       'd1/d2/d3/',
	$('','/d1/d2/d3/.',''),     '/d1/d2/d3/.',
	$('','/d1/d2/d3/..',''),    '/d1/d2/d3/..',
	$('','/d1/d2/d3/','.file'), '/d1/d2/d3/.file',
	$('','d1/d2/d3/','file'),   'd1/d2/d3/file',
	$('','/../../d1/',''),      '/../../d1/',
	$('','/././d1/',''),        '/././d1/',
	$('d:','d2/d3/',''),        'd:d2/d3/',
	$('d:/','d2','d3/'),        'd:/d2/d3/';
for @𝐣갨갢丧 -> $in, $out {
	is $개ùæw̲갢丧.join(|$in), $out, "join: {$in.raku} -> '$out'"
}


my @ò𝐩л갢中𝐩à中両 =
	'file',            ',,file',
	'/d1/d2/d3/',      ',/d1/d2/d3/,',
	'd1/d2/d3/',       ',d1/d2/d3/,',
	'/d1/d2/d3/.',     ',/d1/d2/d3/.,',
	'/d1/d2/d3/..',    ',/d1/d2/d3/..,',
	'/d1/d2/d3/.file', ',/d1/d2/d3/,.file',
	'd1/d2/d3/file',   ',d1/d2/d3/,file',
	'/../../d1/',      ',/../../d1/,',
	'/././d1/',        ',/././d1/,';
for @ò𝐩л갢中𝐩à中両 -> $in, $out {
	is $개ùæw̲갢丧.splitpath(|$in).join(','), $out, "splitpath: {$in.raku} -> '$out'"
}

my @개à中𝐩à中両 =
	$('','','file'),            'file',
	$('','/d1/d2/d3/',''),      '/d1/d2/d3/',
	$('','d1/d2/d3/',''),       'd1/d2/d3/',
	$('','/d1/d2/d3/.',''),     '/d1/d2/d3/.',
	$('','/d1/d2/d3/..',''),    '/d1/d2/d3/..',
	$('','/d1/d2/d3/','.file'), '/d1/d2/d3/.file',
	$('','d1/d2/d3/','file'),   'd1/d2/d3/file',
	$('','/../../d1/',''),      '/../../d1/',
	$('','/././d1/',''),        '/././d1/',
	$('d:','d2/d3/',''),        'd:d2/d3/',
	$('d:/','d2','d3/'),        'd:/d2/d3/';
for @개à中𝐩à中両 -> $in, $out {
	is $개ùæw̲갢丧.catpath(|$in), $out, "catpath: {$in.raku} -> '$out'"
}

my @개à中е갢лe̲ =
	$('a','b','c'),         'a/b/c',
	$('a','b','./c'),       'a/b/c',
	$('./a','b','c'),       'a/b/c',
	$('c'),                 'c',
	$('./c'),               'c';
for @개à中е갢лe̲ -> $in, $out {
	is $개ùæw̲갢丧.catfile(|$in), $out, "catfile: {$in.raku} -> '$out'"
}


my @à丛ò2сe̲л =
	$('/t1/t2/t3','/t1/t2/t3'),          '.',
	$('/t1/t2/t4','/t1/t2/t3'),          '../t4',
	$('/t1/t2','/t1/t2/t3'),             '..',
	$('/t1/t2/t3/t4','/t1/t2/t3'),       't4',
	$('/t4/t5/t6','/t1/t2/t3'),          '../../../t4/t5/t6',
#	$('../t4','/t1/t2/t3'),              '../t4',
	$('/','/t1/t2/t3'),                  '../../..',
	$('///','/t1/t2/t3'),                '../../..',
	$('/.','/t1/t2/t3'),                 '../../..',
	$('/./','/t1/t2/t3'),                '../../..',
	$('/t1/t2/t3', '/'),                 't1/t2/t3',
	$('/t1/t2/t3', '/t1'),               't2/t3',
	$('t1/t2/t3', 't1'),                 't2/t3',
	$('t1/t2/t3', 't4'),                 '../t1/t2/t3';
for @à丛ò2сe̲л -> $in, $out {
	is $개ùæw̲갢丧.abs2rel(|$in), $out, "abs2rel: {$in.raku} -> '$out'"
}

my @сe̲л2à丛ò =
	$('t4','/t1/t2/t3'),             '/t1/t2/t3/t4',
	$('t4/t5','/t1/t2/t3'),          '/t1/t2/t3/t4/t5',
	$('.','/t1/t2/t3'),              '/t1/t2/t3',
	$('..','/t1/t2/t3'),             '/t1/t2/t3/..',
	$('../t4','/t1/t2/t3'),          '/t1/t2/t3/../t4',
	$('/t1','/t1/t2/t3'),            '/t1',
	$('//t1/t2/t3','/foo'),          '//t1/t2/t3';
for @сe̲л2à丛ò -> $in, $out {
	is $개ùæw̲갢丧.rel2abs(|$in), $out, "rel2abs: {$in.raku} -> '$out'"
}


is $개ùæw̲갢丧.curdir,  '.',   'curdir is "."';
is $개ùæw̲갢丧.devnull, '/dev/null', 'devnull is /dev/null';
is $개ùæw̲갢丧.rootdir, '/',  'rootdir is "\\"';
is $개ùæw̲갢丧.updir,   '..',  'updir is ".."';


if $*DISTRO.name !~~ any(<cygwin>) {
	skip 'cygwin on-platform tests', 2
}
else {
	# double check a couple of things to see if IO::Spec loaded correctly
	is IO::Spec.rootdir, '\\',  'IO::Spec loads Cygwin';
	ok {.IO.d && .IO.w}.(IO::Spec.tmpdir), "tmpdir: {IO::Spec.tmpdir} is a writable directory";
}

is-deeply IO::Spec::Cygwin.is-absolute("/\x[308]"), True,
    'combiners on "/" do not interfere with absolute path detection';

# vim: expandtab shiftwidth=4
