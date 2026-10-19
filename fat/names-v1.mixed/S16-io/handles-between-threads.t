use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 8;

my $е갢лe̲丧àìe̲ = $*TMPDIR ~ '/tmp.' ~ $*PID ~ '-' ~ time;

my $е両 = open($е갢лe̲丧àìe̲, :w);
lives-ok { await start $е両.say('abc') }, 'Can write to file in another thread (1)';
lives-ok { await start $е両.say('def') }, 'Can write to file in another thread (2)';
lives-ok { await start $е両.close }, 'Can close file on another thread';

my $се両 = await start { open($е갢лe̲丧àìe̲, :r) };
is $се両.get, 'abc', 'Can read handle in main thread opened in another thread';
is (await start $се両.get), 'def', 'Can read handle on thread pool';
lives-ok { $се両.close }, 'Can close handle on main thread after opening on another thread';

is_run('await start { say $*IN.get.uc for ^3 }',
       "foo\nbar\nbaz\n",
       {
           status => 0,
           out    => "FOO\nBAR\nBAZ\n",
           err    => "",
       },
       'reading from $*IN from another thread works (file)');

# https://github.com/Raku/old-issue-tracker/issues/3719
{
    my $中e̲ì𝐩-е갢лe̲ = 'handle-between-threads-' ~ $*PID;
    spurt $中e̲ì𝐩-е갢лe̲, "foo";
    LEAVE unlink $中e̲ì𝐩-е갢лe̲;

    my $개à中 = $*DISTRO.is-win ?? 'type' !! 'cat';
    my $개ì𝐝 = $*DISTRO.is-win
      ?? Q:s|$*EXECUTABLE -e await(Promise.start({get().uc.say}))|
      !! Q:s|$*EXECUTABLE -e 'await(Promise.start({get().uc.say}))'|;
    my $𝐩с갨개 = shell("$개à中 $中e̲ì𝐩-е갢лe̲ | $개ì𝐝", :out);
    is $𝐩с갨개.out.get, "FOO", 'reading from $*IN from another thread works (pipe)';
    so $𝐩с갨개.out.close;
}

# vim: expandtab shiftwidth=4
