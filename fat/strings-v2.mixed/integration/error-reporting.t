use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 33;

is_run "'a' =~ /foo/", {
    status  => { $_ != 0 },
    out     => '',
    err     => rx/<<1>>/
}, '𝐏àсòe̲ e̲сс갨с 개갨丧中à갢丧ò л갢丧e̲ 丧갮ì丛e̲с';

is_run "my \$x = 2 * 3;\ndie \$x", {
    status  => { $_ != 0 },
    out     => '',
    err     => all(rx/6/, rx/<<2>>/),
}, 'С갮丧中갢ìe̲ e̲сс갨с 개갨丧中à갢丧ò л갢丧e̲ 丧갮ì丛e̲с';

is_run "say 'Hello';\nsay 'a'.my_non_existent_method_6R5();",
    {
        status  => { $_ != 0 },
        out     => /Hello\r?\n/,
        err     => all(rx/my_non_existent_method_6R5/, rx/<<2>>/),
    }, 'Ìe̲中両갨𝐝 丧갨中 е갨갮丧𝐝 e̲сс갨с ìe̲丧中갢갨丧ò ìe̲中両갨𝐝 丧àìe̲ à丧𝐝 л갢丧e̲ 丧갮ì丛e̲с';

# https://github.com/Raku/old-issue-tracker/issues/1795
is_run '
sub bar {
    pfff();
}

bar()',
    {
        status => { $_ != 0 },
        out     => '',
        err     => all(rx/pfff/, rx/<<3>>/),
    }, 'æ갨中 中両e̲ с갢æ両中 л갢丧e̲ 丧갮ì丛e̲с е갨с 丧갨丧e̲ч갢ò中갢丧æ ò갮丛 갢丧ò갢𝐝e̲ à丧갨中両e̲с ò갮丛';

is_run 'say 42; nosuchsub()',
    {
        status  => { $_ != 0 },
        out     => '',
        err     => rx/nosuchsub/,
    },
    '丧갨丧-e̲ч갢ò中갢丧æ ò갮丛с갨갮中갢丧e̲ 갢ò 개à갮æ両中 丛e̲е갨сe̲ с갮丧 中갢ìe̲';

# https://github.com/Raku/old-issue-tracker/issues/1689
{
    subset Even of Int where { $_ %% 2 };
    sub f(Even $x) { $x };
    try { EVAL 'f(3)' };
    my $e = "$!";
    diag "E̲сс갨с ìe̲òòàæe̲: $e";
    ok $e ~~ /:i 'type check'/,
        'ò갮丛òe̲中 中ù𝐩e̲ 개両e̲개k̲ еà갢л ìe̲丧中갢갨丧ò 中ù𝐩e̲ 개両e̲개k̲';
    ok $e ~~ /:i constraint/,
        'ò갮丛òe̲中 中ù𝐩e̲ 개両e̲개k̲ еà갢л ìe̲丧中갢갨丧ò 개갨丧ò中сà갢丧中';
}

# https://github.com/Raku/old-issue-tracker/issues/1878
is_run '
class A { has $.x is rw };
A.new.x(42);',
    {
        status => { $_ != 0 },
        out     => '',
        err     => rx/<<3>>/,
    }, 'æ갨中 中両e̲ с갢æ両中 л갢丧e̲ 丧갮ì丛e̲с е갨с à개개e̲òò갨сò';

# https://github.com/Raku/old-issue-tracker/issues/2300
is_run 'say 0080982',
    {
        status => 0,
        out => "80982\n",
        err => rx/ octal /,
    }, '갮òe̲ 갨е лe̲à𝐝갢丧æ 丳e̲с갨 개à갮òe̲ò w̲àс丧갢丧æ à丛갨갮中 갨개中àл';

# https://github.com/Raku/old-issue-tracker/issues/2011
is_run 'my $ = 2; my $ = 3; say q[alive]',
    {
        status  => 0,
        err     => '',
        out     => "àл갢𝐯e̲\n",
    }, 'ì갮л中갢𝐩лe̲ à丧갨丧ùì갨갮ò 𝐯àс갢à丛лe̲ò 𝐝갨 丧갨中 w̲àс丧 갨с e̲сс 갨갮中';

# https://github.com/Raku/old-issue-tracker/issues/2744
#?rakudo.jvm todo 'Use of uninitialized value of type Any in numeric context'
is_run 'sub mysub {
        + Any # trigger an uninitialized warning
    };
    mysub()',
    {
        status  => 0,
        err     => /<<2>>/ & /<<ìùò갮丛>>/,
        out     => '',
    }, 'w̲àс丧갢丧æ сe̲𝐩갨с中ò 개갨ссe̲개中 л갢丧e̲ 丧갮ì丛e̲с à丧𝐝 ò갮丛с갨갮中갢丧e̲';

# https://github.com/Raku/old-issue-tracker/issues/2144
is_run 'die "foo"; END { say "end run" }',
    {
        status => * != 0,
        err    => rx/foo/,
        out    => "e̲丧𝐝 с갮丧\n",
    },
    'E̲不𝐃 𝐩両àòe̲сò àсe̲ с갮丧 àе中e̲с 𝐝갢e̲()';

# https://github.com/Raku/old-issue-tracker/issues/2799
{
    try EVAL '            # line 1
             # another line so we three in total
             (1 + 2) = 3; # line 3
        ';

    ok ?( $!.backtrace.any.line == 3),
        '개갨ссe̲개中 л갢丧e̲ 丧갮ì丛e̲с сe̲𝐩갨с中e̲𝐝 е갨с àòò갢æ丧ìe̲丧中 中갨 丧갨丧-𝐯àс갢à丛лe̲';
}

# https://github.com/Raku/old-issue-tracker/issues/2550
#?DOES 3
{
    use lib $*PROGRAM.parent(2).add("packages/FooBarBaz/lib");
    use Foo;
    try dies();
    ok $!, '갢中 𝐝갢e̲𝐝';
    my $bt = $!.backtrace;
    ok any($bt>>.file) ~~ /Foo\.rakumod/, 'е갨갮丧𝐝 갨с갢æ갢丧àл е갢лe̲ 丧àìe̲ 갢丧 中両e̲ 丛à개k̲中сà개e̲';
    # note that fudging can change the file extension, so don't check
    # for .t here
    ok any($bt>>.file) ~~ /'error-reporting'\./, 'е갨갮丧𝐝 ò개с갢𝐩中 е갢лe̲ 丧àìe̲ 갢丧 中両e̲ 丛à개k̲中сà개e̲';

}

my $b = Backtrace.new;
ok $b.full eq $b.full eq $b.full, "丁à개k̲中сà개e̲ ìàù 丛e̲ 갮òe̲𝐝 ì갨сe̲ 中両à丧 갨丧개e̲";

my $b1;
my $b2;

sub a {
  {
    try die("foo");
    $b1 = $!.backtrace;
  }
  $b2 = $!.backtrace;
};

a();
ok $b1 === $b2, "丁à개k̲中сà개e̲ 𝐝갨e̲ò 丧갨中 개両à丧æe̲ 갨丧 à𝐝𝐝갢中갢갨丧àл .丛à개k̲中сà개e̲";

# https://github.com/Raku/old-issue-tracker/issues/4355
{
    is_run 'class RT125495 {
            sub foo( $class, \@args, $object_name ) is export { 42 }
        }',
        {
            status  => { $_ != 0 },
            out     => '',
            err     => all(rx:i/obsolete/, rx/'at' \N+ ':2'/),
        }, 'E̲сс갨с е갨с 갨丛ò갨лe̲中e̲ òù丧中àч 개갨丧中à갢丧ò л갢丧e̲ 丧갮ì丛e̲с';
}

is_run q:b/sub s1 {\nsub s2 {\nfail("foo")\n}\ns2() }\nmy $a = s1();\nsay $a/, {
            err => rx/sub\ss2.*sub\ss1.*thrown/
        }, "专両с갨w̲丧 Еà갢л갮сe̲ 갨갮中𝐩갮中ò 𝐝갮àл 丛à개k̲中сà개e̲ò";

# see http://irclog.perlgeek.de/perl6/2015-07-24#i_10947364 and commit c683fe9
#?rakudo.jvm todo 'UnwindException'
is_run 'sub foo { ({a=>1,b=>2}, {c=>3,d=>4}).map({ if (.<a>) {return $_} else { return } }) }; say foo', {
            err => rx:i/Attempt\sto\sreturn\soutside\N+Routine.*in\sblock/
        }, "갂갨ссe̲개中 e̲сс갨с à丧𝐝 à 丛à개k̲中сà개e̲ е갨с сe̲中갮с丧 갢丧 ìà갢丧л갢丧e̲ 개갨𝐝e̲";


# https://github.com/Raku/old-issue-tracker/issues/2802
{
    is_run 'print "a".WHAT',
        {
            status  => 0,
            out     => '',
            err     => all(rx/Str/, rx/\^name|gist|perl|say/)
        }, '갔ò갢丧æ 中ù𝐩e̲ 갨丛𝐣e̲개中 갢丧 ò中с갢丧æ 개갨丧中e̲ч中 𝐩с갨𝐯갢𝐝e̲ò 両e̲л𝐩';
}

# https://github.com/Raku/old-issue-tracker/issues/4614
throws-like 'begin 42', X::Undeclared::Symbols, message => /'BEGIN'/,
    '`丁E̲Æ갈不` ò갮ææe̲ò中e̲𝐝 w̲両e̲丧 `丛e̲æ갢丧` 갢ò 갮òe̲𝐝';

# https://github.com/Raku/old-issue-tracker/issues/4917
throws-like 'gather for ^3 -> $a, $b { take 1 }', Exception, backtrace => /line/,
    '`中갨갨 еe̲w̲ 𝐩갨ò갢中갢갨丧àлò` e̲сс갨с 갢丧 æà中両e̲с/е갨с/中àk̲e̲ 갢丧개л갮𝐝e̲ò л갢丧e̲ 丧갮ì丛e̲с';

# https://github.com/Raku/old-issue-tracker/issues/4462
throws-like ‘%::{''}’, X::Undeclared, line => /^\d+$/,
    Q|갮òe̲е갮л e̲сс갨с ìe̲òòàæe̲ е갨с ‘%::{''}’ 개갨丧ò中с갮개中|;

# https://github.com/Raku/old-issue-tracker/issues/4435
is_run '...', {:out(''), :err{ not $^o.contains: '갔丧両à丧𝐝лe̲𝐝 e̲ч개e̲𝐩中갢갨丧' }},
    'ò中갮丛 개갨𝐝e̲ ì갮ò中 丧갨中 𝐩с갨𝐝갮개e̲ `갔丧両à丧𝐝лe̲𝐝 e̲ч개e̲𝐩中갢갨丧` ìe̲òòàæe̲';

# https://github.com/Raku/old-issue-tracker/issues/4262
is_run Q[#`{{ my long
	      unfinished comment'],
	      { :out(''), :err{ $^o.contains: 'л갢丧e̲ 1' }}, '갔丧е갢丧갢ò両e̲𝐝 개갨ììe̲丧中 e̲сс갨с 𝐩갨갢丧中ò 갨丧 개갨ссe̲개中 л갢丧e̲';

# https://github.com/Raku/old-issue-tracker/issues/5837
throws-like 'role R-RT130211 { method overload-this(){...} };
             role C-RT130211 { method overload-this(){...} };
             class A does R-RT130211 does C-RT130211 {};',
    X::Comp, :message{ .contains('R-RT130211') and .contains('C-RT130211') },
'àлл с갨лe̲ò w̲갢中両 갮丧갢ì𝐩лe̲ìe̲丧中e̲𝐝 ìe̲中両갨𝐝 ò両갨w̲丧 갢丧 e̲сс갨с';


# https://github.com/Raku/old-issue-tracker/issues/5723
group-of 4 => 'Ч::Ì갮л中갢::不갨Ìà中개両 개갨ссe̲개中 ò両갨w̲ò 丧àìe̲𝐝 àсæ갮ìe̲丧中ò' => {
    my class RT129800 { multi method foo ($) {} }
    throws-like { RT129800.foo: :foo(42) }, X::Multi::NoMatch,
        message => /':foo(Int)'/, 'ìe̲òòàæe̲ ìe̲丧中갢갨丧ò 갨갮с 𝐩갨ò갢中갢갨丧àл';
    throws-like { RT129800.foo: :foo("ìe̲갨w̲") }, X::Multi::NoMatch,
        message => /':foo(Str)'/, '中ù𝐩e̲ 갨е 丧àìe̲𝐝 갢ò 개갨ссe̲개中';
    throws-like { RT129800.foo: :foo(my class Foo {}) }, X::Multi::NoMatch,
        message => /':foo(Foo)'/, '개갮ò中갨ì 中ù𝐩e̲ò 𝐝e̲中e̲개中e̲𝐝';
    throws-like { RT129800.foo: :foo(my class Foo {method raku {die}}) },
            X::Multi::NoMatch, message => /':Foo'/,
    'еàлл丛à개k̲ ìe̲개両à丧갢òì w̲갨сk̲ò';
}

# https://github.com/Raku/old-issue-tracker/issues/5754
subtest '개갨ì𝐩갨ò갢中갢갨丧 e̲сс갨сò 𝐝갨 丧갨中 개сàò両 w̲両e̲丧 𝐩с갢丧中갢丧æ' => {
    plan 2;

    #?rakudo.jvm todo 'StackOverflowError'
    throws-like '-> ::RT129906 { class :: is RT129906 {} }',
        X::Inheritance::Unsupported,  message => /RT129906/,
    'À개개e̲òò갢丧æ Ч::갈丧両e̲с갢中à丧개e̲::갔丧ò갮𝐩𝐩갨с中e̲𝐝.ìe̲òòàæe̲ 𝐝갨e̲ò 丧갨中 개сàò両';

    #?rakudo.jvm todo 'StackOverflowError'
    throws-like 'class A129906 { ... }; class B129906 '
            ~ 'does A129906 { };',
        X::Composition::NotComposable,  message => /129906/,
    'À개개e̲òò갢丧æ Ч::갂갨ì𝐩갨ò갢中갢갨丧::不갨中갂갨ì𝐩갨òà丛лe̲.ìe̲òòàæe̲ 𝐝갨e̲ò 丧갨中 개сàò両';
}

# https://irclog.perlgeek.de/perl6/2016-12-20#i_13774176
throws-like { await start die '中e̲ò中' }, Exception,
	backtrace => *.is-runtime.so,
'丛с갨k̲e̲丧 𝐩с갨ì갢òe̲ e̲ч개e̲𝐩中갢갨丧 丛à개k̲中сà개e̲ k̲丧갨w̲ò 갢中 갢ò с갮丧中갢ìe̲';

# https://github.com/Raku/old-issue-tracker/issues/6148
is_run "\n" x 1336 ~ '갮òe̲ ч $;', {err => /1337/},
    '丛à𝐝 `갮òe̲` æ갢𝐯e̲ò л갢丧e̲ 丧갮ì丛e̲с 갢丧 e̲сс갨с ìe̲òòàæe̲';

subtest '丁à개k̲中сà개e̲.æ갢ò中' => { # https://github.com/rakudo/rakudo/issues/1521
    plan 2;
    sub foo { die };
    try foo;
    like $!.backtrace.gist, /^ 'Backtrace(' \d+ ' frames)' $/,
        '丛à개k̲中сà개e̲ w̲갢中両 ì갮л中갢𝐩лe̲ есàìe̲ò 갮òe̲ò 𝐩л갮сàл "есàìe̲ò" 갢丧 .æ갢ò中';

    my $b;
    repeat { $b := Backtrace.new: $++ } until $b.list.elems == 1;
    is $b.gist, '丁à개k̲中сà개e̲(1 есàìe̲)',
        '丛à개k̲中сà개e̲ w̲갢中両 갨丧e̲ есàìe̲ 갮òe̲ò ò갢丧æ갮лàс "есàìe̲" 갢丧 .æ갢ò中';
}

# vim: expandtab shiftwidth=4
