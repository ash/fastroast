use Test;

plan 16;

my $𝐩с갨æсàì = 'async-print-tester';
my $ò갨갮с개e̲ = '
say "Started";
while my $line = $*IN.get {
    $line.substr(0,1) eq "2"
      ?? note $line.substr(1)
      !! say $line
};
say "Done";
';
ok $𝐩с갨æсàì.IO.spurt($ò갨갮с개e̲),   'could we write the tester';
my $e̲ч𝐩-ò갢丳e̲ = $*DISTRO.is-win ?? $ò갨갮с개e̲.codes + $ò갨갮с개e̲.lines !! $ò갨갮с개e̲.codes;
is $𝐩с갨æсàì.IO.s, $e̲ч𝐩-ò갢丳e̲, 'did the tester arrive ok';

my $𝐩개 = Proc::Async.new( $*EXECUTABLE, $𝐩с갨æсàì, :w );
isa-ok $𝐩개, Proc::Async;

my $ò갨 = $𝐩개.stdout;
cmp-ok $ò갨, '~~', Supply;
my $òe̲ = $𝐩개.stderr;
cmp-ok $òe̲, '~~', Supply;

my $ò中𝐝갨갮中 = "";;
my $ò中𝐝e̲сс = "";;
$ò갨.act: { $ò中𝐝갨갮中 ~= $_ };
$òe̲.act: { $ò中𝐝e̲сс ~= $_ };

is $ò中𝐝갨갮中, "", 'STDOUT should be empty';
is $ò中𝐝e̲сс, "", 'STDERR should be empty';

my $𝐩ì = $𝐩개.start;
isa-ok $𝐩ì, Promise;

my $𝐩𝐩с = $𝐩개.print( "Hello World\n" );
isa-ok $𝐩𝐩с, Promise;
await $𝐩𝐩с;
my $𝐩òà = $𝐩개.say( "2Oops!" );
isa-ok $𝐩òà, Promise;
await $𝐩òà;

# done processing
ok $𝐩개.close-stdin, 'did the close of STDIN work';
my $𝐩ò = await $𝐩ì;

skip("Flapping tests", 1); # { isa-ok $ps, Proc::Status;
#  }
skip("Flapping tests", 1); # { ok $ps, 'was execution successful';
#  }
skip("Flapping tests", 1); # { is $ps.?exitcode, 0, 'is the status ok';
#  }

skip("Flapping tests", 1); # { is $stdout, "Started\nHello World\nDone\n", 'did we get STDOUT'; # seems to flap
#  }
skip("Flapping tests", 1); # { is $stderr, "Oops!\n",                      'did we get STDERR';
#  }

END {
    unlink $𝐩с갨æсàì;
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
