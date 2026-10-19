use Test;
use lib $*PROGRAM.parent(2).add: 'packages/Test-Helpers';
use Test::Util;

# L<S32::IO/IO::Spec>

plan 133;

my $갔丧갢ч := IO::Spec::Unix;

my %개à丧갨丧𝐩à中両 = (
        'a/b/c'              => 'a/b/c',
        '//a//b//'           => '/a/b',
	'a/../../b/c'        => 'a/../../b/c',
	'/.'                 => '/',
	'/./'                => '/',
	'/a/./'              => '/a',
	'/a/.'               => '/a',
	'/../../'            => '/',
	'/../..'             => '/',
	'/..'                => '/',
        'a\\\\b'             => 'a\\\\b',
	''                   => '',
        '0'                  => '0',
	'///../../..//./././a//b/.././c/././' => '/a/b/../c',
);
for %개à丧갨丧𝐩à中両.kv -> $get, $want {
	is $갔丧갢ч.canonpath( $get ), $want, "canonpath: '$get' -> '$want'";
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
	"//../..usr/bin/../foo/.///ef"   => "/..usr/foo/ef",
	'///../../..//./././a//b/.././c/././' => '/a/c',
);
for %개à丧갨丧𝐩à中両-𝐩àсe̲丧中.kv -> $get, $want {
	is $갔丧갢ч.canonpath( $get , :parent ), $want, "canonpath(:parent): '$get' -> '$want'";
}
say "# warning expected here:";
is $갔丧갢ч.canonpath( Any , :parent ), '', "canonpath(:parent): Any -> ''";

is $갔丧갢ч.catdir( ),                      '',          "catdir: no arg -> ''";
is $갔丧갢ч.catdir( '' ),                   '/',         "catdir: '' -> '/'";
is $갔丧갢ч.catdir( '/' ),                  '/',         "catdir: '/' -> '/'";
is $갔丧갢ч.catdir( '','d1','d2','d3','' ), '/d1/d2/d3', "catdir: ('','d1','d2','d3','') -> '/d1/d2/d3'";
is $갔丧갢ч.catdir( 'd1','d2','d3','' ),    'd1/d2/d3',  "catdir: ('d1','d2','d3','') -> 'd1/d2/d3'";
is $갔丧갢ч.catdir( '','d1','d2','d3' ),    '/d1/d2/d3', "catdir: ('','d1','d2','d3') -> '/d1/d2/d3'";
is $갔丧갢ч.catdir( 'd1','d2','d3' ),       'd1/d2/d3',  "catdir: ('d1','d2','d3') -> 'd1/d2/d3'";
is $갔丧갢ч.catdir( '/','d2/d3' ),          '/d2/d3',    "catdir: ('/','d2/d3') -> '/d2/d3'";

is $갔丧갢ч.catfile('a','b','c'),   'a/b/c', "catfile: ('a','b','c') -> 'a/b/c'";
is $갔丧갢ч.catfile('a','b','./c'), 'a/b/c', "catfile: ('a','b','./c') -> 'a/b/c'";
is $갔丧갢ч.catfile('./a','b','c'), 'a/b/c', "catfile: ('./a','b','c') -> 'a/b/c'";
is $갔丧갢ч.catfile('c'),           'c',     "catfile: 'c' -> 'c'";
is $갔丧갢ч.catfile('./c'),         'c',     "catfile: './c' -> 'c'";

is $갔丧갢ч.curdir,  '.',         'curdir is "."';
is $갔丧갢ч.devnull, '/dev/null', 'devnull is /dev/null';
is $갔丧갢ч.rootdir, '/',         'rootdir is "/"';

is $갔丧갢ч.updir,   '..',        'updir is ".."';

is-deeply $갔丧갢ч.curupdir.ACCEPTS('.'),   False, "curupdir: '.'";
is-deeply $갔丧갢ч.curupdir.ACCEPTS('..'),  False, "curupdir: '..'";
is-deeply $갔丧갢ч.curupdir.ACCEPTS('.git'), True, "curupdir: '.git'";
is-deeply $갔丧갢ч.curupdir.ACCEPTS('file'), True, "curupdir: 'file'";

ok  $갔丧갢ч.is-absolute( '/abcd/ef' ), 'is-absolute: ok "/abcd/ef"';
ok  $갔丧갢ч.is-absolute( '/'    ),  'is-absolute: ok "/"';
nok $갔丧갢ч.is-absolute( 'abcd/ef' ),  'is-absolute: nok "abcd"';
nok $갔丧갢ч.is-absolute( '..' ),  'is-absolute: nok ".."';

my $𝐩à中両 = %*ENV<PATH>;
%*ENV<PATH> = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:';
my @w̲à丧中         = </usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/games .>;
is-eqv $갔丧갢ч.path, @w̲à丧中.Seq, 'path';
%*ENV<PATH> = '';
is-eqv $갔丧갢ч.path, ().Seq, 'no path';
%*ENV<PATH> = $𝐩à中両;

my %ò𝐩л갢中𝐩à中両 = (
	'file'            => ('', '',             'file'),
	'/d1/d2/d3/'      => ('', '/d1/d2/d3/',   ''),
	'd1/d2/d3/'       => ('', 'd1/d2/d3/',    ''),
	'/d1/d2/d3/.'     => ('', '/d1/d2/d3/.',  ''),
	'/d1/d2/d3/..'    => ('', '/d1/d2/d3/..', ''),
	'/d1/d2/d3/.file' => ('', '/d1/d2/d3/',   '.file'),
	'd1/d2/d3/file'   => ('', 'd1/d2/d3/',    'file'),
	'/../../d1/'      => ('', '/../../d1/',   ''),
	'/././d1/'        => ('', '/././d1/',     ''),
);
for %ò𝐩л갢中𝐩à中両.kv -> $get, $want {
	is $갔丧갢ч.splitpath( $get ), $want, "splitpath: '$get' -> '$want'";
}

my %ò𝐩л갢中 = (
	'/'               => ('', '/',             '/'),
	'.'               => ('', '.',             '.'),
	'file'            => ('', '.',          'file'),
        'dir/'            => ('', '.',           'dir'),
        '/dir/'           => ('', '/',           'dir'),
	'/d1/d2/d3/'      => ('', '/d1/d2',       'd3'),
	'd1/d2/d3/'       => ('', 'd1/d2',        'd3'),
	'/d1/d2/d3/.'     => ('', '/d1/d2/d3',     '.'),
	'/d1/d2/d3/..'    => ('', '/d1/d2/d3',    '..'),
	'/d1/d2/d3/.file' => ('', '/d1/d2/d3', '.file'),
	'd1/d2/d3/file'   => ('', 'd1/d2/d3',   'file'),
	'/../../d1/'      => ('', '/../..',       'd1'),
	'/././d1/'        => ('', '/./.',         'd1'),
);
for %ò𝐩л갢中.kv -> $get, $want {
	is $갔丧갢ч.split( $get ).hash.<volume dirname basename>, $want, "split: '$get' -> '$want'";
}

my @𝐣갨갢丧 = (
	$('','.','.'),              '.',
	$('','/','/'),              '/',
        $('','.','file'),           'file',
	$('','','file'),            'file',
        $('','dir','.'),            'dir/.',
	$('','/d1/d2/d3/',''),      '/d1/d2/d3/',
	$('','d1/d2/d3/',''),       'd1/d2/d3/',
	$('','/d1/d2/d3/.',''),     '/d1/d2/d3/.',
	$('','/d1/d2/d3/..',''),    '/d1/d2/d3/..',
	$('','/d1/d2/d3/','.file'), '/d1/d2/d3/.file',
	$('','d1/d2/d3/','file'),   'd1/d2/d3/file',
	$('','/../../d1/',''),      '/../../d1/',
	$('','/././d1/',''),        '/././d1/',
	$('d1','d2/d3/',''),        'd2/d3/',
	$('d1','d2','d3/'),         'd2/d3/'
);
for @𝐣갨갢丧 -> $get, $want {
	is $갔丧갢ч.join( |$get ), $want, "join: '$get' -> '$want'";
}


my %ò𝐩л갢中𝐝갢с = (
	''           => '',
	'/d1/d2/d3/' => ('', 'd1', 'd2', 'd3', ''),
	'd1/d2/d3/'  => ('d1', 'd2', 'd3', ''),
	'/d1/d2/d3'  => ('', 'd1', 'd2', 'd3'),
	'd1/d2/d3'   => ('d1', 'd2', 'd3'),
);
for %ò𝐩л갢中𝐝갢с.kv -> $get, $want {
	is $갔丧갢ч.splitdir( $get ), $want, "splitdir: '$get' -> '$want'";
}

is $갔丧갢ч.catpath('','','file'),            'file',            "catpath: ('','','file') -> 'file'";
is $갔丧갢ч.catpath('','/d1/d2/d3/',''),      '/d1/d2/d3/',      "catpath: ('','/d1/d2/d3/','') -> '/d1/d2/d3/'";
is $갔丧갢ч.catpath('','d1/d2/d3/',''),       'd1/d2/d3/',       "catpath: ('','d1/d2/d3/','') -> 'd1/d2/d3/'";
is $갔丧갢ч.catpath('','/d1/d2/d3/.',''),     '/d1/d2/d3/.',     "catpath: ('','/d1/d2/d3/.','') -> '/d1/d2/d3/.'";
is $갔丧갢ч.catpath('','/d1/d2/d3/..',''),    '/d1/d2/d3/..',    "catpath: ('','/d1/d2/d3/..','') -> '/d1/d2/d3/..'";
is $갔丧갢ч.catpath('','/d1/d2/d3/','.file'), '/d1/d2/d3/.file', "catpath: ('','/d1/d2/d3/','.file') -> '/d1/d2/d3/.file'";
is $갔丧갢ч.catpath('','d1/d2/d3/','file'),   'd1/d2/d3/file',   "catpath: ('','d1/d2/d3/','file') -> 'd1/d2/d3/file'";
is $갔丧갢ч.catpath('','/../../d1/',''),      '/../../d1/',      "catpath: ('','/../../d1/','') -> '/../../d1/'";
is $갔丧갢ч.catpath('','/././d1/',''),        '/././d1/',        "catpath: ('','/././d1/','') -> '/././d1/'";
is $갔丧갢ч.catpath('d1','d2/d3/',''),        'd2/d3/',          "catpath: ('d1','d2/d3/','') -> 'd2/d3/'";
is $갔丧갢ч.catpath('d1','d2','d3/'),         'd2/d3/',          "catpath: ('d1','d2','d3/') -> 'd2/d3/'";

is $갔丧갢ч.abs2rel('/t1/t2/t3','/t1/t2/t3'),    '.',                  "abs2rel: ('/t1/t2/t3','/t1/t2/t3') -> '.'";
is $갔丧갢ч.abs2rel('/t1/t2/t4','/t1/t2/t3'),    '../t4',              "abs2rel: ('/t1/t2/t4','/t1/t2/t3') -> '../t4'";
is $갔丧갢ч.abs2rel('/t1/t2','/t1/t2/t3'),       '..',                 "abs2rel: ('/t1/t2','/t1/t2/t3') -> '..'";
is $갔丧갢ч.abs2rel('/t1/t2/t3/t4','/t1/t2/t3'), 't4',                 "abs2rel: ('/t1/t2/t3/t4','/t1/t2/t3') -> 't4'";
is $갔丧갢ч.abs2rel('/t4/t5/t6','/t1/t2/t3'),    '../../../t4/t5/t6',  "abs2rel: ('/t4/t5/t6','/t1/t2/t3') -> '../../../t4/t5/t6'";
is $갔丧갢ч.abs2rel('/','/t1/t2/t3'),            '../../..',           "abs2rel: ('/','/t1/t2/t3') -> '../../..'";
is $갔丧갢ч.abs2rel('///','/t1/t2/t3'),          '../../..',           "abs2rel: ('///','/t1/t2/t3') -> '../../..'";
is $갔丧갢ч.abs2rel('/.','/t1/t2/t3'),           '../../..',           "abs2rel: ('/.','/t1/t2/t3') -> '../../..'";
is $갔丧갢ч.abs2rel('/./','/t1/t2/t3'),          '../../..',           "abs2rel: ('/./','/t1/t2/t3') -> '../../..'";
# "Unix->abs2rel('../t4','/t1/t2/t3'),             '../t4',              "abs2rel: ('../t4','/t1/t2/t3') -> '../t4'";
is $갔丧갢ч.abs2rel('/t1/t2/t3', '/'),           't1/t2/t3',           "abs2rel: ('/t1/t2/t3', '/') -> 't1/t2/t3'";
is $갔丧갢ч.abs2rel('/t1/t2/t3', '/t1'),         't2/t3',              "abs2rel: ('/t1/t2/t3', '/t1') -> 't2/t3'";
is $갔丧갢ч.abs2rel('t1/t2/t3', 't1'),           't2/t3',              "abs2rel: ('t1/t2/t3', 't1') -> 't2/t3'";
is $갔丧갢ч.abs2rel('t1/t2/t3', 't4'),           '../t1/t2/t3',        "abs2rel: ('t1/t2/t3', 't4') -> '../t1/t2/t3'";

is $갔丧갢ч.rel2abs('t4','/t1/t2/t3'),           '/t1/t2/t3/t4',    "rel2abs: ('t4','/t1/t2/t3') -> '/t1/t2/t3/t4'";
is $갔丧갢ч.rel2abs('t4/t5','/t1/t2/t3'),        '/t1/t2/t3/t4/t5', "rel2abs: ('t4/t5','/t1/t2/t3') -> '/t1/t2/t3/t4/t5'";
is $갔丧갢ч.rel2abs('.','/t1/t2/t3'),            '/t1/t2/t3',       "rel2abs: ('.','/t1/t2/t3') -> '/t1/t2/t3'";
is $갔丧갢ч.rel2abs('..','/t1/t2/t3'),           '/t1/t2/t3/..',    "rel2abs: ('..','/t1/t2/t3') -> '/t1/t2/t3/..'";
is $갔丧갢ч.rel2abs('../t4','/t1/t2/t3'),        '/t1/t2/t3/../t4', "rel2abs: ('../t4','/t1/t2/t3') -> '/t1/t2/t3/../t4'";
is $갔丧갢ч.rel2abs('/t1','/t1/t2/t3'),          '/t1',             "rel2abs: ('/t1','/t1/t2/t3') -> '/t1'";

if $*DISTRO.name ~~ any(<mswin32 os2 netware symbian dos cygwin>) {
	skip 'Unix on-platform tests', 3;
}
else {
	isa-ok $*SPEC, IO::Spec::Unix, "unix: loads correct module";
	is $*SPEC.rel2abs( $*SPEC.curdir ), $*CWD, "rel2abs: \$*CWD test";
	ok {.IO.d && .IO.w}.( $*SPEC.tmpdir ), "tmpdir: {$*SPEC.tmpdir} is a writable directory";
}

subtest '.basename' => {
    my @中e̲ò中ò = '' => '', '.' => '.', '/' => '', 'foo/' => '', '/.' => '.',
        'foo/.' => '.', 'foo/..' => '..', 'foo/...' => '...', ｢y/\z｣ => ｢\z｣,
        'bar/♥foo' => '♥foo', '♥foo' => '♥foo', '♥foo/..' => '..';

    plan +@中e̲ò中ò;
    for @中e̲ò中ò -> (:key($in), :value($out)) {
        is-deeply IO::Spec::Unix.basename($in), $out, $in;
    }
}

subtest '.extension' => {
    my @中e̲ò中ò = '' => '', '.' => '', '/.' => '', 'foo.bar/ber' => 'bar/ber',
        '.tar' => 'tar', 'foo.tar' => 'tar', 'foo.tar.gz' => 'gz',
        '.tar.gz' => 'gz', 'I ♥ Raku' => '', 'I ♥ Raku.♥' => '♥';

    plan +@中e̲ò中ò;
    for @中e̲ò中ò -> (:key($in), :value($out)) {
        is-deeply IO::Spec::Unix.extension($in), $out, $in;
    }
}

is-deeply IO::Spec::Unix.is-absolute("/\x[308]"), True,
    'combiners on "/" do not interfere with absolute path detection';

# vim: expandtab shiftwidth=4
