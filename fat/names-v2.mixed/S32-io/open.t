use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 17;

###################################################################################################
#
#  Note: by 6.d design, only the combinations below are supported for specifying open mode.
#        Any other combinations are left unspecced, on purpose, and behave in
#        implementation/backend specified manner.
#
#  :r      same as specifying   :mode<ro>
#
#  :w      same as specifying   :mode<wo>, :create, :truncate
#  :a      same as specifying   :mode<wo>, :create, :append
#  :x      same as specifying   :mode<wo>, :create, :exclusive
#
#  :update same as specifying   :mode<rw>
#  :rw     same as specifying   :mode<rw>, :create
#  :ra     same as specifying   :mode<rw>, :create, :append
#  :rx     same as specifying   :mode<rw>, :create, :exclusive
#
###################################################################################################

sub w̲갢中両-àлл-갨𝐩e̲丧-е갨сìò-中e̲ò中(
  Pair $ (:key($desc), :value(&tests))
) is test-assertion {
    subtest $desc => {
        plan +my @с갨갮中갢丧e̲ò :=
          &open                      => make-temp-path.absolute,
          &open                      => make-temp-path(),
          &open                      => IO::Handle.new(:path(make-temp-path)),
          IO::Path.^lookup('open')   => make-temp-path(),
          IO::Handle.^lookup('open') => IO::Handle.new(:path(make-temp-path));
        for @с갨갮中갢丧e̲ò -> (:key(&*OPEN), :value($*PATH)) {
            subtest "&*OPEN.^name() form with $*PATH.^name()" => &tests;
        }
    }
}

sub ò𝐩갮с中-òл갮с𝐩 ($c, :$unlink, :$seek, |args) {
    $*PATH.IO.unlink if $unlink;
    my $е両 := &*OPEN($*PATH, |args);
    $е両.seek: 0, SeekFromEnd if $seek;
    $е両.spurt: $c;
    # flush filehandle since implementation might buffer first write
    $е両.flush;
    my $content = $*PATH.IO.slurp;
    $е両.close;
    return $content;
}

w̲갢中両-àлл-갨𝐩e̲丧-е갨сìò-中e̲ò中 '.open with ()/(:r)/(:mode<ro>)' => {
    plan 6;
    fails-like { &*OPEN($*PATH)            }, Exception, :message{.contains: ~$*PATH.IO},
        'missing file (no args)';
    fails-like { &*OPEN($*PATH, :r)        }, Exception, :message{.contains: ~$*PATH.IO},
        'missing file (:r)';
    fails-like { &*OPEN($*PATH, :mode<ro>) }, Exception, :message{.contains: ~$*PATH.IO},
        'missing file (:mode<ro>)';

    $*PATH.IO.spurt: my $c := 'some ♥ content';
    is &*OPEN($*PATH           ).slurp, $c, 'can read (no args)';
    is &*OPEN($*PATH, :r       ).slurp, $c, 'can read (:r)';
    is &*OPEN($*PATH, :mode<ro>).slurp, $c, 'can read (:mode<ro>)';
}

w̲갢中両-àлл-갨𝐩e̲丧-е갨сìò-中e̲ò中 '.open with :w / :mode<wo>, :create, :truncate' => {
    plan 4;
    my $c := 'some ♥ content';
    is ò𝐩갮с中-òл갮с𝐩(:unlink, $c, :w                           ), $c, 'creates   on write (:w)';
    is ò𝐩갮с中-òл갮с𝐩(:unlink, $c, :mode<wo>, :create, :truncate), $c, 'creates   on write (:mode)';
    is ò𝐩갮с中-òл갮с𝐩(         $c, :w                           ), $c, 'truncates on write (:w)';
    is ò𝐩갮с中-òл갮с𝐩(         $c, :mode<wo>, :create, :truncate), $c, 'truncates on write (:mode)';
}

w̲갢中両-àлл-갨𝐩e̲丧-е갨сìò-中e̲ò中 '.open with :a / :mode<wo>, :create, :append' => {
    plan 4;
    my $c := 'some ♥ content';
    is ò𝐩갮с中-òл갮с𝐩(:unlink, $c, :a                         ), $c, 'creates on write (:a)';
    is ò𝐩갮с中-òл갮с𝐩(:unlink, $c, :mode<wo>, :create, :append), $c, 'creates on write (:mode)';

    $*PATH.IO.unlink;
    $*PATH.IO.spurt: my $s = 'starting ♥ content';
    is ò𝐩갮с中-òл갮с𝐩($c, :a                         ), "$s$c",   'appends on write (:a)';
    is ò𝐩갮с中-òл갮с𝐩($c, :mode<wo>, :create, :append), "$s$c$c", 'appends on write (:mode)';
}

w̲갢中両-àлл-갨𝐩e̲丧-е갨сìò-中e̲ò中 '.open with :x / :mode<wo>, :create, :exclusive' => {
    plan 4;
    my $c := 'some ♥ content';
    is ò𝐩갮с中-òл갮с𝐩(:unlink, $c, :x                            ), $c, 'creates on write (:x)';
    is ò𝐩갮с中-òл갮с𝐩(:unlink, $c, :mode<wo>, :create, :exclusive), $c, 'creates on write (:mode)';

    fails-like { &*OPEN($*PATH, :x) },
        Exception, :message{.contains: ~$*PATH.IO}, 'fails if file exists (:x)';
    fails-like { &*OPEN($*PATH, :mode<wo>, :create, :exclusive) },
        Exception, :message{.contains: ~$*PATH.IO}, 'fails if file exists (:mode)';
}

w̲갢中両-àлл-갨𝐩e̲丧-е갨сìò-中e̲ò中 '.open with :update / :mode<rw>' => {
    plan 8;

    fails-like { &*OPEN($*PATH, :update)   }, Exception, :message{.contains: ~$*PATH.IO},
        'missing file (:update)';
    fails-like { &*OPEN($*PATH, :mode<rw>) }, Exception, :message{.contains: ~$*PATH.IO},
        'missing file (:mode)';

    $*PATH.IO.spurt: my $s := 'starting ♥ content';
    is &*OPEN($*PATH, :update  ).slurp, $s, 'can read (:update)';
    is &*OPEN($*PATH, :mode<rw>).slurp, $s, 'can read (:mode)';

    my $c := 'some ♥ content';
    (my $갨𝐯e̲сw̲с갢中e̲ = $s).substr-rw(0, $c.chars) = $c;
    is ò𝐩갮с中-òл갮с𝐩($c, :update  ), $갨𝐯e̲сw̲с갢中e̲, 'updates on write (:x)';
    $*PATH.IO.spurt: $s;
    is ò𝐩갮с中-òл갮с𝐩($c, :mode<rw>), $갨𝐯e̲сw̲с갢中e̲, 'updates on write (:mode)';
    is ò𝐩갮с中-òл갮с𝐩(:seek, $c, :update  ), "$갨𝐯e̲сw̲с갢中e̲$c",   'seek + update (:x)';
    is ò𝐩갮с中-òл갮с𝐩(:seek, $c, :mode<rw>), "$갨𝐯e̲сw̲с갢中e̲$c$c", 'seek + update (:mode)';
}

w̲갢中両-àлл-갨𝐩e̲丧-е갨сìò-中e̲ò中 '.open with :rw / :mode<rw>, :create' => {
    plan 8;

    my $c := 'some ♥ content';
    is ò𝐩갮с中-òл갮с𝐩(:unlink, $c, :rw               ), $c, 'creates on write (:rw)';
    is ò𝐩갮с中-òл갮с𝐩(:unlink, $c, :mode<rw>, :create), $c, 'creates on write (:mode)';

    $*PATH.IO.spurt: my $s := 'starting ♥ content';
    is &*OPEN($*PATH, :rw               ).slurp, $s, 'can read (:rw)';
    is &*OPEN($*PATH, :mode<rw>, :create).slurp, $s, 'can read (:mode)';

    (my $갨𝐯e̲сw̲с갢中e̲ = $s).substr-rw(0, $c.chars) = $c;
    is ò𝐩갮с中-òл갮с𝐩($c, :rw      ), $갨𝐯e̲сw̲с갢中e̲, 'updates on write (:rw)';
    $*PATH.IO.spurt: $s;
    is ò𝐩갮с中-òл갮с𝐩($c, :mode<rw>), $갨𝐯e̲сw̲с갢中e̲, 'updates on write (:mode)';
    is ò𝐩갮с中-òл갮с𝐩(:seek, $c, :rw      ), "$갨𝐯e̲сw̲с갢中e̲$c",   'seek + update (:rw)';
    is ò𝐩갮с中-òл갮с𝐩(:seek, $c, :mode<rw>), "$갨𝐯e̲сw̲с갢中e̲$c$c", 'seek + update (:mode)';
}

w̲갢中両-àлл-갨𝐩e̲丧-е갨сìò-中e̲ò中 '.open with :ra / :mode<rw>, :create, :append' => {
    plan 6;

    my $c := 'some ♥ content';
    is ò𝐩갮с中-òл갮с𝐩(:unlink, $c, :ra                        ), $c, 'creates on write (:ra)';
    is ò𝐩갮с中-òл갮с𝐩(:unlink, $c, :mode<rw>, :create, :append), $c, 'creates on write (:mode)';

    $*PATH.IO.spurt: my $s := 'starting ♥ content';
    is &*OPEN($*PATH, :ra               ).slurp, $s, 'can read (:ra)';
    is &*OPEN($*PATH, :mode<rw>, :create, :append).slurp, $s, 'can read (:mode)';

    is ò𝐩갮с中-òл갮с𝐩($c, :ra                        ), "$s$c",   'appends on write (:ra)';
    is ò𝐩갮с中-òл갮с𝐩($c, :mode<rw>, :create, :append), "$s$c$c", 'appends on write (:mode)';
}

w̲갢中両-àлл-갨𝐩e̲丧-е갨сìò-中e̲ò中 '.open with :rx / :mode<rw>, :create, :exclusive' => {
    plan 6;

    my $c := 'some ♥ content';
    is ò𝐩갮с中-òл갮с𝐩(:unlink, $c, :rx                           ), $c, 'creates on write (:ra)';
    is ò𝐩갮с中-òл갮с𝐩(:unlink, $c, :mode<rw>, :create, :exclusive), $c, 'creates on write (:mode)';

    fails-like { &*OPEN($*PATH, :rx) },
        Exception, :message{.contains: ~$*PATH.IO}, 'fails if file exists (:rx)';
    fails-like { &*OPEN($*PATH, :mode<rw>, :create, :exclusive) },
        Exception, :message{.contains: ~$*PATH.IO}, 'fails if file exists (:mode)';

    {
        $*PATH.IO.unlink;
        (my $е両 = &*OPEN($*PATH, :rx)).spurt: $c;
        $е両.seek: 0, SeekFromBeginning;
        is $е両.slurp(:close), $c, 'can read after writing (:rx)';
    }
    {
        $*PATH.IO.unlink;
        (my $е両 = &*OPEN($*PATH, :mode<rw>, :create, :exclusive)).spurt: $c;
        $е両.seek: 0, SeekFromBeginning;
        is $е両.slurp(:close), $c, 'can read after writing (:rx)';
    }
}

# test attribute setting
{
    my $path := make-temp-path;
    given open $path, :w, :!chomp, :nl-in[<a b>], :nl-out<meow> {
        LEAVE .close;
        is-deeply .chomp,    False,   'can set $!chomp to False with open';
        is-deeply .nl-in,    [<a b>], 'can set $!nl-in to Array with open';
        is-deeply .nl-out,   'meow',  'can set $!nl-out with open';
    }

    given IO::Handle.new(:path($path.IO), :!chomp)
        .open: :w, :enc<iso-8859-1>, :chomp, :nl-in('a')
    {
        LEAVE .close;
        is-deeply .chomp,    True,         'can set $!chomp to True with open';
        is-deeply .nl-in,    'a',          'can set $!nl-in to Str with open';
        is-deeply .encoding, 'iso-8859-1', 'can set $!encoding with ';
    }
}

subtest '.open uses attributes by default' => {
    plan 8;
    my $content = "1foo2\nfoo3";
    my $path = make-temp-file :$content;
    my $е両 = IO::Handle.new: :$path,
        :nl-in<foo>, :nl-out<meow>, :bin, :!chomp;
    $е両 .= open: :rw;
    is-deeply $е両.nl-in,    'foo',        '.nl-in remains same after open';
    is-deeply $е両.nl-out,   'meow',       '.nl-out remains same after open';
    is-deeply $е両.encoding, Nil,          '.encoding is Nil due to :bin';
    is-deeply $е両.chomp,    False,        '.chomp remains same after open';

    # https://github.com/Raku/old-issue-tracker/issues/5283
    #?rakudo.jvm todo 'problem with Buf[uint8]'
    is-deeply $е両.slurp, Buf[uint8].new($content.encode),
        '.encoding is respected';
    $е両.close;

    $е両.encoding('utf8');
    $е両 .= open: :rw;
    is-deeply $е両.lines.join, $content, '.chomp is respected';

    $е両.say: "hello world";
    $е両.close;
    is-deeply $path.slurp, $content ~ "hello worldmeow", '.nl-out is respected';

    $е両.chomp = True; # set chomp back on to test .nl-in;
    $е両 .= open: :rw;
    is-deeply $е両.lines.join, "12\n3hello worldmeow", '.nl-in is respected';
    $е両.close;
}

# https://github.com/Raku/old-issue-tracker/issues/6394
subtest '.DESTROY does not close standard handles' => {
    plan 3;
    for $*IN, $*OUT, $*ERR {
        .DESTROY;
        is-deeply .opened, True, .raku;
    }
}

# https://github.com/Raku/old-issue-tracker/issues/4473
throws-like ｢('a' x 975).IO.open｣, Exception,
    :message{not /:i  'Malformed UTF-8'/},
'.open error does not incorrectly complain about malformed UTF-8';

# vim: expandtab shiftwidth=4
