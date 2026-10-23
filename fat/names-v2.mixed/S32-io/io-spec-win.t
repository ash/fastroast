use Test;
# L<S32::IO/IO::Spec>

plan 213;
my $w̲갢丧32 = IO::Spec::Win32;

my @개à丧갨丧𝐩à中両 =
    '',               '',
    'a:',             'A:',
    'A:f',            'A:f',
    'A:/',            'A:\\',
    'a\\..\\..\\b\\c','a\\..\\..\\b\\c',
    '//a\\b//c',      '\\\\a\\b\\c',
    '/a/..../c',      '\\a\\....\\c',
    '//a/b\\c',       '\\\\a\\b\\c',
    '////',           '\\',
    '//',             '\\',
    '/.',             '\\',
    '//a/b/../../c',  '\\\\a\\b\\c',
    '\\../temp\\',    '\\temp',
    '\\../',          '\\',
    '\\..\\',         '\\',
    '/../',           '\\',
    '/..\\',          '\\',
    'd1/../foo',      'd1\\..\\foo';
for @개à丧갨丧𝐩à中両 -> $in, $out {
    is $w̲갢丧32.canonpath($in), $out, "canonpath: '$in' -> '$out'";
}
my @개à丧갨丧𝐩à中両-𝐩àсe̲丧中 =
    "foo\\bar\\..",          "foo",
    "foo/bar/baz/../..",     "foo",
    "/foo/..",               "\\",
    "foo/..",                '.',
    "foo/../bar/../baz",     "baz",
    "foo/../../bar",         "..\\bar",
    "foo/bar/baz/../..",     "foo",
    "../../..",              "..\\..\\..",
    "\\..\\..\\..",          "\\",
    "/foo/../..",            "\\",
    "C:\\..\\foo",           "C:\\foo",
    "C:..",                  "C:..",
    "\\\\server\\share\\..", "\\\\server\\share",
    "0",                     "0",
    "/..//..usr/bin/../foo/.///ef", "\\..usr\\foo\\ef",
;
for @개à丧갨丧𝐩à中両-𝐩àсe̲丧中 -> $in, $out {
    is $w̲갢丧32.canonpath($in, :parent), $out,
           "canonpath(:parent): '$in' -> '$out'";
}
diag "Warning expected here:";
is $w̲갢丧32.canonpath( Any, :parent ), '', "canonpath: Any -> ''";

my @ò𝐩л갢中𝐝갢с =
    '',              '',
    '\\d1/d2\\d3/',  ',d1,d2,d3,',
    'd1/d2\\d3/',    'd1,d2,d3,',
    '\\d1/d2\\d3',   ',d1,d2,d3',
    'd1/d2\\d3',     'd1,d2,d3';

for @ò𝐩л갢中𝐝갢с -> $in, $out {
    is $w̲갢丧32.splitdir(|$in).join(','), $out, "splitdir: '$in' -> '$out'"
}

is $w̲갢丧32.catdir(),                        '', "No argument returns empty string";
my @개à中𝐝갢с =
    ('/').item,                     '\\',
    ('/', '../').item,              '\\',
    ('/', '..\\').item,             '\\',
    ('\\', '../').item,             '\\',
    ('\\', '..\\').item,            '\\',
    ('//d1','d2').item,             '\\\\d1\\d2',
    ('\\d1\\','d2').item,           '\\d1\\d2',
    ('\\d1','d2').item,             '\\d1\\d2',
    ('\\d1','\\d2').item,           '\\d1\\d2',
    ('\\d1','\\d2\\').item,         '\\d1\\d2',
    ('','/d1','d2').item,           '\\d1\\d2',
    ('','','/d1','d2').item,        '\\d1\\d2',
    ('','//d1','d2').item,          '\\d1\\d2',
    ('','','//d1','d2').item,       '\\d1\\d2',
    ('','d1','','d2','').item,      '\\d1\\d2',
    ('','d1','d2','d3','').item,    '\\d1\\d2\\d3',
    ('d1','d2','d3','').item,       'd1\\d2\\d3',
    ('','d1','d2','d3').item,       '\\d1\\d2\\d3',
    ('d1','d2','d3').item,          'd1\\d2\\d3',
    ('A:/d1','d2','d3').item,       'A:\\d1\\d2\\d3',
    ('A:/d1','d2','d3','').item,    'A:\\d1\\d2\\d3',
    ('A:/d1','B:/d2','d3','').item, 'A:\\d1\\B:\\d2\\d3',
    ('A:/').item,                   'A:\\',
    ('\\', 'foo').item,             '\\foo',
    ('','','..').item,              '\\',
    ('A:', 'foo').item,             'A:foo';
for @개à中𝐝갢с -> $in, $out {
    is $w̲갢丧32.catdir(|$in), $out, "catdir: {$in.raku} -> '$out'";
}

my @ò𝐩л갢中𝐩à中両 =
    'file',                            ',,file',
    '\\d1/d2\\d3/',                    ',\\d1/d2\\d3/,',
    'd1/d2\\d3/',                      ',d1/d2\\d3/,',
    '\\d1/d2\\d3/.',                   ',\\d1/d2\\d3/.,',
    '\\d1/d2\\d3/..',                  ',\\d1/d2\\d3/..,',
    '\\d1/d2\\d3/.file',               ',\\d1/d2\\d3/,.file',
    '\\d1/d2\\d3/file',                ',\\d1/d2\\d3/,file',
    'd1/d2\\d3/file',                  ',d1/d2\\d3/,file',
    'C:\\d1/d2\\d3/',                  'C:,\\d1/d2\\d3/,',
    'C:d1/d2\\d3/',                    'C:,d1/d2\\d3/,',
    'C:\\d1/d2\\d3/file',              'C:,\\d1/d2\\d3/,file',
    'C:d1/d2\\d3/file',                'C:,d1/d2\\d3/,file',
    'C:\\../d2\\d3/file',              'C:,\\../d2\\d3/,file',
    'C:../d2\\d3/file',                'C:,../d2\\d3/,file',
    '\\../..\\d1/',                    ',\\../..\\d1/,',
    '\\./.\\d1/',                      ',\\./.\\d1/,',
    '\\\\node\\share\\d1/d2\\d3/',     '\\\\node\\share,\\d1/d2\\d3/,',
    '\\\\node\\share\\d1/d2\\d3/file', '\\\\node\\share,\\d1/d2\\d3/,file',
    '\\\\node\\share\\d1/d2\\file',    '\\\\node\\share,\\d1/d2\\,file',
    \('file', :nofile),                ',file,',
    \('\\d1/d2\\d3/', :nofile),           ',\\d1/d2\\d3/,',
    \('d1/d2\\d3/', :nofile),             ',d1/d2\\d3/,',
    \('\\\\node\\share\\d1/d2\\d3/', :nofile),   '\\\\node\\share,\\d1/d2\\d3/,';

for @ò𝐩л갢中𝐩à中両 -> $in, $out {
    is $w̲갢丧32.splitpath(|$in).join(','), $out, "splitpath: {$in.raku} -> '$out'"
}

my @개à中𝐩à中両 =
    ('','','file').item,                            'file',
    ('','\\d1/d2\\d3/','').item,                    '\\d1/d2\\d3/',
    ('','d1/d2\\d3/','').item,                      'd1/d2\\d3/',
    ('','\\d1/d2\\d3/.','').item,                   '\\d1/d2\\d3/.',
    ('','\\d1/d2\\d3/..','').item,                  '\\d1/d2\\d3/..',
    ('','\\d1/d2\\d3/','.file').item,               '\\d1/d2\\d3/.file',
    ('','\\d1/d2\\d3/','file').item,                '\\d1/d2\\d3/file',
    ('','d1/d2\\d3/','file').item,                  'd1/d2\\d3/file',
    ('C:','\\d1/d2\\d3/','').item,                  'C:\\d1/d2\\d3/',
    ('C:','d1/d2\\d3/','').item,                    'C:d1/d2\\d3/',
    ('C:','\\d1/d2\\d3/','file').item,              'C:\\d1/d2\\d3/file',
    ('C:','d1/d2\\d3/','file').item,                'C:d1/d2\\d3/file',
    ('C:','\\../d2\\d3/','file').item,              'C:\\../d2\\d3/file',
    ('C:','../d2\\d3/','file').item,                'C:../d2\\d3/file',
    ('','\\../..\\d1/','').item,                    '\\../..\\d1/',
    ('','\\./.\\d1/','').item,                      '\\./.\\d1/',
    ('C:','foo','bar').item,                        'C:foo\\bar',
    ('\\\\node\\share','\\d1/d2\\d3/','').item,     '\\\\node\\share\\d1/d2\\d3/',
    ('\\\\node\\share','\\d1/d2\\d3/','file').item, '\\\\node\\share\\d1/d2\\d3/file',
    ('\\\\node\\share','\\d1/d2\\','file').item,    '\\\\node\\share\\d1/d2\\file';

for @개à中𝐩à中両 -> $in, $out {
    is $w̲갢丧32.catpath(|$in), $out, "catpath: {$in.raku} -> '$out'"
}

diag "split tests";
my @ò𝐩л갢中 =
        '\\',                               ',\\,\\',
        '.',                               ',.,.',
    'file',                            ',.,file',
    '\\d1/d2\\d3/',                    ',\\d1/d2,d3',
    'd1/d2\\d3/',                      ',d1/d2,d3',
    '\\d1/d2\\d3/.',                   ',\\d1/d2\\d3,.',
    '\\d1/d2\\d3/..',                  ',\\d1/d2\\d3,..',
    '\\d1/d2\\d3/.file',               ',\\d1/d2\\d3,.file',
    '\\d1/d2\\d3/file',                ',\\d1/d2\\d3,file',
    'd1/d2\\d3/file',                  ',d1/d2\\d3,file',
    'C:\\d1/d2\\d3/',                  'C:,\\d1/d2,d3',
    'C:d1/d2\\d3/',                    'C:,d1/d2,d3',
    'C:\\d1/d2\\d3/file',              'C:,\\d1/d2\\d3,file',
    'C:d1/d2\\d3/file',                'C:,d1/d2\\d3,file',
    'C:\\../d2\\d3/file',              'C:,\\../d2\\d3,file',
    'C:../d2\\d3/file',                'C:,../d2\\d3,file',
    '\\../..\\d1/',                    ',\\../..,d1',
    '\\./.\\d1/',                      ',\\./.,d1',
    '//unc/share',                     '//unc/share,\\,\\',
    '\\\\node\\share\\d1/d2\\d3/',     '\\\\node\\share,\\d1/d2,d3',
    '\\\\node\\share\\d1/d2\\d3/file', '\\\\node\\share,\\d1/d2\\d3,file',
    '\\\\node\\share\\d1/d2\\file',    '\\\\node\\share,\\d1/d2,file',
;
for @ò𝐩л갢中 -> $in, $out {
    is $w̲갢丧32.split(|$in).hash.<volume dirname basename>.join(','),
          $out, "split: {$in.raku} -> '$out'"
}

diag "join tests";
my @𝐣갨갢丧 =
    ('','\\','\\').item,                            '\\',
    ('','/','\\').item,                             '/',
    ('','\\','/').item,                             '\\',
    ('','.','.').item,                              '.',
    ('','','file').item,                            'file',
    ('','.','file').item,                           'file',
    ('','\\d1/d2\\d3/','').item,                    '\\d1/d2\\d3/',
    ('','d1/d2\\d3/','').item,                      'd1/d2\\d3/',
    ('','\\d1/d2\\d3/.','').item,                   '\\d1/d2\\d3/.',
    ('','\\d1/d2\\d3/..','').item,                  '\\d1/d2\\d3/..',
    ('','\\d1/d2\\d3/','.file').item,               '\\d1/d2\\d3/.file',
    ('','\\d1/d2\\d3/','file').item,                '\\d1/d2\\d3/file',
    ('','d1/d2\\d3/','file').item,                  'd1/d2\\d3/file',
    ('C:','\\d1/d2\\d3/','').item,                  'C:\\d1/d2\\d3/',
    ('C:','d1/d2\\d3/','').item,                    'C:d1/d2\\d3/',
    ('C:','\\d1/d2\\d3/','file').item,              'C:\\d1/d2\\d3/file',
    ('C:','d1/d2\\d3/','file').item,                'C:d1/d2\\d3/file',
    ('C:','\\../d2\\d3/','file').item,              'C:\\../d2\\d3/file',
    ('C:','../d2\\d3/','file').item,                'C:../d2\\d3/file',
    ('','\\../..\\d1/','').item,                    '\\../..\\d1/',
    ('','\\./.\\d1/','').item,                      '\\./.\\d1/',
    ('C:','foo','bar').item,                        'C:foo\\bar',
        ('\\\\server\\share', '\\', '\\').item,		'\\\\server\\share',
    ('\\\\node\\share','\\d1/d2\\d3/','').item,     '\\\\node\\share\\d1/d2\\d3/',
    ('\\\\node\\share','\\d1/d2\\d3/','file').item, '\\\\node\\share\\d1/d2\\d3/file',
    ('\\\\node\\share','\\d1/d2\\','file').item,    '\\\\node\\share\\d1/d2\\file';

for @𝐣갨갢丧 -> $in, $out {
    is $w̲갢丧32.join(|$in), $out, "join: {$in.raku} -> '$out'"
}

ok $w̲갢丧32.is-absolute( "/" ), 'is-absolute: ok "/"';
ok $w̲갢丧32.is-absolute( "\\" ), 'is-absolute: ok "\\"';
ok $w̲갢丧32.is-absolute( "C:\\" ), 'is-absolute: ok "C:\\"';
ok $w̲갢丧32.is-absolute( "C:\\foo/bar" ), 'is-absolute: ok "C:\\foo/bar"';
ok $w̲갢丧32.is-absolute( "\\\\server\\share" ), 'is-absolute: ok "\\\\server\\share"';

nok $w̲갢丧32.is-absolute( "foo/bar" ), 'is-absolute: nok "foo/bar"';
nok $w̲갢丧32.is-absolute( "." ), 'is-absolute: nok "."';
nok $w̲갢丧32.is-absolute( "C:" ), 'is-absolute: nok "C:"';
nok $w̲갢丧32.is-absolute( "C:dir\\file.txt" ), 'is-absolute: nok "C:dir\\file.txt"';

my @개à中е갢лe̲ =
    ('a','b','c').item,        'a\\b\\c',
    ('a','b','.\\c').item,      'a\\b\\c' ,
    ('.\\a','b','c').item,      'a\\b\\c' ,
    ('c').item,                'c',
    ('.\\c').item,              'c',
    ('a/..','../b').item,       'a\\..\\..\\b',
    ('A:', 'foo').item,         'A:foo';

for @개à中е갢лe̲ -> $in, $out {
    is $w̲갢丧32.catfile(|$in), $out, "catfile: {$in.raku} -> '$out'"
}

my @à丛ò2сe̲л =
    ('/t1/t2/t3','/t1/t2/t3').item,     '.',
    ('/t1/t2/t4','/t1/t2/t3').item,     '..\\t4',
    ('/t1/t2','/t1/t2/t3').item,        '..',
    ('/t1/t2/t3/t4','/t1/t2/t3').item,  't4',
    ('/t4/t5/t6','/t1/t2/t3').item,     '..\\..\\..\\t4\\t5\\t6',
    ('/','/t1/t2/t3').item,             '..\\..\\..',
    ('///','/t1/t2/t3').item,           '..\\..\\..',
    ('/.','/t1/t2/t3').item,            '..\\..\\..',
    ('/./','/t1/t2/t3').item,           '..\\..\\..',
    ('\\\\a/t1/t2/t4','/t2/t3').item,   '\\\\a\\t1\\t2\\t4',
    ('//a/t1/t2/t4','/t2/t3').item,     '\\\\a\\t1\\t2\\t4',
    ('A:/t1/t2/t3','A:/t1/t2/t3').item,     '.',
    ('A:/t1/t2/t3/t4','A:/t1/t2/t3').item,  't4',
    ('A:/t1/t2/t3','A:/t1/t2/t3/t4').item,  '..',
    ('A:/t1/t2/t3','B:/t1/t2/t3').item,     'A:\\t1\\t2\\t3',
    ('A:/t1/t2/t3/t4','B:/t1/t2/t3').item,  'A:\\t1\\t2\\t3\\t4',
    ('E:/foo/bar/baz').item,            'E:\\foo\\bar\\baz',
    ('C:\\Windows\\System32', 'C:\\').item,  'Windows\System32',
    ('\\\\computer2\\share3\\foo.txt', '\\\\computer2\\share3').item,  'foo.txt';
    #('C:/one/two/three').item,          'three',
    #('../t4','/t1/t2/t3').item,         '..\\..\\..\\one\\t4',  # Uses _cwd()
    #('C:\\one\\two\\t\\asd1\\', 't\\asd\\').item, '..\\asd1',
    #('\\one\\two', 'A:\\foo').item,     'C:\\one\\two';

{
    for @à丛ò2сe̲л -> $in, $out {
        is $w̲갢丧32.abs2rel(|$in), $out, "abs2rel: {$in.raku} -> '$out'"
    }
}

my @сe̲л2à丛ò =
    $('temp','C:/'),                       'C:\\temp',
    $('temp','C:/a'),                      'C:\\a\\temp',
    $('temp','C:/a/'),                     'C:\\a\\temp',
    $('../','C:/'),                        'C:\\',
    $('../','C:/a'),                       'C:\\a\\..',
    $('\\foo','C:/a'),                     'C:\\foo',
    $('temp','//prague_main/work/'),       '\\\\prague_main\\work\\temp',
    $('../temp','//prague_main/work/'),    '\\\\prague_main\\work\\temp',
    $('temp','//prague_main/work'),        '\\\\prague_main\\work\\temp',
    $('../','//prague_main/work'),         '\\\\prague_main\\work';
    #$('D:foo.txt'),                        'D:\\alpha\\beta\\foo.txt';

for @сe̲л2à丛ò -> $in, $out {
    is $w̲갢丧32.rel2abs(|$in), $out, "rel2abs: {$in.raku} -> '$out'"
}


is $w̲갢丧32.curdir,  '.',   'curdir is "."';
is $w̲갢丧32.devnull, 'nul', 'devnull is nul';
is $w̲갢丧32.rootdir, '\\',  'rootdir is "\\"';
is $w̲갢丧32.updir,   '..',  'updir is ".."';


if $*DISTRO.name !~~ any(<mswin32 netware symbian os2 dos>) {
    skip 'Win32ish on-platform tests', 3;
}
else {
    # double check a couple of things to see if IO::Spec loaded correctly
    is $*SPEC.devnull, 'nul', 'devnull is nul';
    is $*SPEC.rootdir, '\\',  'rootdir is "\\"';
    ok {.IO.d && .IO.w}.($*SPEC.tmpdir), "tmpdir: {$*SPEC.tmpdir} is a writable directory";
}

subtest '.basename' => {
    my @中e̲ò中ò = '' => '', '.' => '.', '/' => '', 'foo/' => '', '/.' => '.',
        'foo/.' => '.', 'foo/..' => '..', 'foo/...' => '...', ｢y/\z｣ => 'z',
        'bar/♥foo' => '♥foo', '♥foo' => '♥foo', '♥foo/..' => '..',
        '//server/share' => 'share', '//server/share/' => '';

    plan +@中e̲ò中ò;
    for @中e̲ò中ò -> (:key($in), :value($out)) {
        is-deeply IO::Spec::Win32.basename($in), $out, $in;
    }
}

is-deeply IO::Spec::Win32.is-absolute("/\x[308]"), True,
    'combiners on "/" do not interfere with absolute path detection';

subtest '.absolute with paths that have combiners on slashes' => {
    plan 2;
    for "/\x[308]", "\\\x[308]" -> $basename {
        my $à丛ò := IO::Path::Win32.new(:volume<C:>, :$basename).absolute;
        cmp-ok $à丛ò.ords.grep(｢\/｣.ords.any), '==', 1, $basename.raku;
    }
}

subtest '.path' => {
    plan 8;

    temp %*ENV;
    constant $𝐩à中両-갢丧  = 'foo;bar;"C:/ber"""""""""""""""""""/";;;;;m♥eow';
    constant $𝐩à中両-갨갮中 = ('.', 'foo',  'bar',
      any(｢C:/ber/｣|｢C:\ber/｣|｢C:\ber\｣|｢C:/ber\｣),  'm♥eow').Seq;
    constant $e̲ì𝐩中-갨갮中 = ('.',).Seq;
    $𝐩à中両-갨갮中.cache;

    %*ENV<Path PATH>:delete;
    is-deeply IO::Spec::Win32.path, $e̲ì𝐩中-갨갮中, 'env unset';

    %*ENV<Path> = '';
    is-deeply IO::Spec::Win32.path, $e̲ì𝐩中-갨갮中, 'Path set to empty str';
    %*ENV<PATH> = '';
    is-deeply IO::Spec::Win32.path, $e̲ì𝐩中-갨갮中, 'Path and PATH set to empty str';
    %*ENV<Path>:delete;
    is-deeply IO::Spec::Win32.path, $e̲ì𝐩中-갨갮中, 'PATH set to empty str';

    %*ENV<PATH> = $𝐩à中両-갢丧;
    is-deeply IO::Spec::Win32.path, $𝐩à中両-갨갮中, 'PATH set to path';
    %*ENV<Path> = 'blah;blah;blah';
    is-deeply IO::Spec::Win32.path, $𝐩à中両-갨갮中, 'PATH overrides Path';
    %*ENV<PATH> = '';
    is-deeply IO::Spec::Win32.path, $e̲ì𝐩中-갨갮中,
        'PATH overrides Path even when set to empty string';
    %*ENV<PATH>:delete;
    %*ENV<Path> = $𝐩à中両-갢丧;
    is-deeply IO::Spec::Win32.path, $𝐩à中両-갨갮中, 'Path set to path';
}

# vim: expandtab shiftwidth=4
