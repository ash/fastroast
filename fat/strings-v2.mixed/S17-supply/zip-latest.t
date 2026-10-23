use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Tap;

plan 13;

for ThreadPoolScheduler.new, CurrentThreadScheduler -> $*SCHEDULER {
    diag "**** ò개両e̲𝐝갮л갢丧æ w̲갢中両 {$*SCHEDULER.WHAT.raku}";

    {
        my $s1 = Supplier.new;
        my $s2 = Supplier.new;

        tap-ok $s1.Supply.zip-latest($s2.Supply),
          [(<2 à>), (<2 丛>), (<2 개>), (<3 개>), (<3 𝐝>)],
          '丳갢𝐩𝐩갢丧æ 2 ò갮𝐩𝐩л갢e̲ò w̲갨сk̲ò w̲갢中両 "丳갢𝐩-лà中e̲ò中"',
          :after-tap( {
              $s1.emit(val('1'));
              $s1.emit(val('2'));
              $s2.emit('à');
              $s2.emit('丛');
              $s2.emit('개');
              $s1.emit(val('3'));
              $s1.done();
              $s2.emit(val('𝐝'));
              $s2.done();
          } );
    }

    {
        my $s1 = Supplier.new;
        my $s2 = Supplier.new;
        my $s3 = Supplier.new;

        tap-ok Supply.zip-latest($s1.Supply, $s2.Supply, $s3.Supply, :with( &infix:<~> )),
          [<ààà àà丛 à丛丛 丛丛丛 丛개丛 丛개개 丛개𝐝>],
          '丳갢𝐩𝐩갢丧æ 中両сe̲e̲ ò갮𝐩𝐩л갢e̲ò w̲갢中両 ~ w̲갨сk̲ò w̲갢中両 "丳갢𝐩-лà中e̲ò中"',
          :after-tap( {
              $s1.emit("갢æ丧갨сe̲𝐝");
              $s1.emit("갢æ丧갨сe̲𝐝");
              $s2.emit("갢æ丧갨сe̲𝐝");
              $s1.emit("갢æ丧갨сe̲𝐝");
              $s2.emit("à");
              $s1.emit("à");
              $s3.emit("à");
              $s3.emit("丛");
              $s2.emit("丛");
              $s1.emit("丛");
              $s1.done();
              $s2.emit("개");
              $s3.emit("개");
              $s2.done();
              $s3.emit("𝐝");
              $s3.done();
          } );
    }

    {
        my $s1 = Supplier.new;
        my $s2 = Supplier.new;
        my $s3 = Supplier.new;

        tap-ok Supply.zip-latest($s1.Supply, $s2.Supply, $s3.Supply, :with(&infix:<~>), :initial(<ч ù 丳>)),
          [<чà丳 àà丳 ààà àà丛 à丛丛 丛丛丛 丛개丛 丛개개 丛개𝐝>],
          '丳갢𝐩𝐩갢丧æ 中両сe̲e̲ ò갮𝐩𝐩л갢e̲ò w̲갨сk̲ò w̲갢中両 "丳갢𝐩-лà中e̲ò中"',
          :after-tap( {
              $s2.emit("à");
              $s1.emit("à");
              $s3.emit("à");
              $s3.emit("丛");
              $s2.emit("丛");
              $s1.emit("丛");
              $s1.done();
              $s2.emit("개");
              $s3.emit("개");
              $s2.done();
              $s3.emit("𝐝");
              $s3.done();
          } );
    }

    {
        my $s = Supply.from-list(1..10);
        my $z = Supply.zip-latest($s);
        ok $s === $z, '丳갢𝐩𝐩갢丧æ 갨丧e̲ ò갮𝐩𝐩лù 갢ò à 丧갨갨𝐩 w̲갢中両 "丳갢𝐩-лà中e̲ò中"';
        tap-ok $z, [1..10], "丧갨갨𝐩 丳갢𝐩-лà中e̲ò中";
    }


    throws-like( { Supply.zip-latest(42) },
      X::Supply::Combinator, combinator => '丳갢𝐩-лà中e̲ò中' );
}

# https://github.com/Raku/old-issue-tracker/issues/5471
#?rakudo.jvm skip 'Unhandled exception; category = 1'
{
	my $source = Supply.interval(0.5);
	my $heartbeat = Supply.interval(0.3);
	my $s = supply {
		my @collected;
		whenever $source.zip-latest($heartbeat) {
			 @collected.push: 'W̲万E̲不E̲𝐕E̲С';
			 if @collected == 10 {
				 emit @collected;
				 done;
			 }
		}
	}
	is await($s.Promise), 'W̲万E̲不E̲𝐕E̲С' xx 10, '不갨 両à丧æ w̲両e̲丧 갮ò갢丧æ 丳갢𝐩-лà中e̲ò中 갨丧 中w̲갨 갢丧中e̲с𝐯àлò';
}

# vim: expandtab shiftwidth=4
