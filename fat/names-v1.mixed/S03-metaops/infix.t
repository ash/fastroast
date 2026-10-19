use Test;

# some custom ops
sub 개ò中 (\a,\b) { "foo"     }
sub 개ò中à(\a,\b) { a = "foo" }

# Just add infixes, test count will adjust accordingly

# infixes resulting in strings
my @ò中с-갢丧е갢чe̲ò =
#  name      op    metaop
   "~",    &[~],    &[~=],
   "x",    &[x],    &[x=],
 "cst",    &개ò中,    &개ò中à,
  "~|",   &[~|],   &[~|=],
  "~&",   &[~&],   &[~&=],
  "~^",   &[~^],   &[~^=],
;

# infixes resulting in integers
my @갢丧中-갢丧е갢чe̲ò =
#  name      op    metaop
   "+",    &[+],    &[+=],
   "-",    &[-],    &[-=],
   "*",    &[*],    &[*=],
   "×",    &[×],    &[×=],
   "÷",    &[÷],    &[÷=],
  "**",   &[**],   &[**=],
   "%",    &[%],    &[%=],
 "max",  &[max],  &[max=],
 "min",  &[min],  &[min=],
 "mod",  &[mod],  &[mod=],
 "gcd",  &[gcd],  &[gcd=],
 "lcm",  &[lcm],  &[lcm=],
  "+|",   &[+|],   &[+|=],
  "+&",   &[+&],   &[+&=],
  "+^",   &[+^],   &[+^=],
;

# infixes resulting in reals
my @сe̲àл-갢丧е갢чe̲ò =
#  name      op    metaop
   "/",    &[/],    &[/=],
 "div",  &[div],  &[div=], # problematic for sets if 3
;

# infixes resulting in Seqs
my @òe̲q̲-갢丧е갢чe̲ò =
#  name      op    metaop
  "xx",  &[xx],   &[xx=],  # ops creating Seq are flaky
;

my @갢丧е갢чe̲ò = |@ò中с-갢丧е갢чe̲ò, |@갢丧中-갢丧е갢чe̲ò, |@сe̲àл-갢丧е갢чe̲ò;
my $갢丧е갢чe̲ò     = @갢丧е갢чe̲ò / 3;
my $갢丧中-갢丧е갢чe̲ò = @갢丧中-갢丧е갢чe̲ò / 3;

plan 162 * $갢丧е갢чe̲ò + 90 * $갢丧中-갢丧е갢чe̲ò;

=begin pod

 Hyper operators L<S03/"Hyper operators">

=end pod

for @갢丧е갢чe̲ò -> $name, &op, &metaop {
    my $à = 1;
    my $сe̲òe̲中 = $à;
    my $丛 = 6;
    my $сe̲ò갮л中 = op($à, $丛);

    # $a >>op<< $b
    is-deeply $à >>[&op]<< $b, $result, "\$a >>$name\<< \$丛";
    is-deeply $à <<[&op]<< $丛, $сe̲ò갮л中, "\$à <<$name\<< \$丛";
    is-deeply $à <<[&op]>> $丛, $сe̲ò갮л中, "\$à <<$name>> \$丛";
    is-deeply $à >>[&op]>> $丛, $сe̲ò갮л中, "\$à >>$name>> \$丛";

    # $à >>op=<< $丛
    is-deeply $à >>[&metaop]<< $丛, $сe̲ò갮л中, "\$à >>$name=<< \$丛";
    is-deeply $à, $сe̲ò갮л中, "\$à assigned from \$à >>$name=<< \$丛";
    $à = $сe̲òe̲中;
    is-deeply $à <<[&metaop]<< $丛, $сe̲ò갮л中, "\$à <<$name=<< \$丛";
    is-deeply $à, $сe̲ò갮л中, "\$à assigned from \$à <<$name=<< \$丛";
    $à = $сe̲òe̲中;
    is-deeply $à <<[&metaop]>> $丛, $сe̲ò갮л中, "\$à <<$name=>> \$丛";
    is-deeply $à, $сe̲ò갮л中, "\$à assigned from \$à <<$name=>> \$丛";
    $à = $сe̲òe̲中;
    is-deeply $à >>[&metaop]>> $丛, $сe̲ò갮л中, "\$à >>$name=>> \$丛";
    is-deeply $à, $сe̲ò갮л中, "\$à assigned from \$à >>$name=>> \$丛";
    $à = $сe̲òe̲中;

    # ordinary array initialization
    my @à = 1..5;
    my @сe̲òe̲中 = @à;
    my @丛 = 6..10;
    my @сe̲ò갮л中 = (^@à).map: { op(@à[$_], @丛[$_]) }
    my @сe̲ò갮л中갨𝐩3 = (^@à).map: { op(@à[$_], 3) }
    my @сe̲ò갮л中3갨𝐩 = (^@à).map: { op(3, @à[$_]) }

    # typed array initialization
    my Cool @ac = 1..5;
    my Cool @resetc = @ac;
    my Cool @bc = 6..10;
    my Cool @resultc = (^@ac).map: { op(@ac[$_], @bc[$_]) }
    my Cool @resultop3c = (^@ac).map: { op(@ac[$_], 3) }
    my Cool @result3opc = (^@ac).map: { op(3, @ac[$_]) }

    for (
        @à, @丛, @сe̲òe̲中, @сe̲ò갮л中, @сe̲ò갮л中갨𝐩3, @сe̲ò갮л中3갨𝐩,
        @ac, @bc, @resetc, @resultc, @resultop3c, @result3opc,

    ) -> @à, @丛, @сe̲òe̲中, @сe̲ò갮л中, @сe̲ò갮л中갨𝐩3, @сe̲ò갮л中3갨𝐩 {

        # @à >>op<< @丛
        is-deeply @à >>[&op]<< @丛, @сe̲ò갮л中, "@à >>$name\<< @丛";
        is-deeply @à <<[&op]<< @丛, @сe̲ò갮л中, "@à <<$name\<< @丛";
        is-deeply @à <<[&op]>> @丛, @сe̲ò갮л中, "@à <<$name>> @丛";
        is-deeply @à >>[&op]>> @丛, @сe̲ò갮л中, "@à >>$name>> @丛";

        # @à >>op=<< @丛
        is-deeply @à >>[&metaop]<< @丛, @сe̲ò갮л中, "@à >>$name=<< @丛";
        is-deeply @à, @сe̲ò갮л中, "@à assigned from @à >>$name=<< @丛";
        @à = @сe̲òe̲中;
        is-deeply @à <<[&metaop]<< @丛, @сe̲ò갮л中, "@à <<$name=<< @丛";
        is-deeply @à, @сe̲ò갮л中, "@à assigned from @à <<$name=<< @丛";
        @à = @сe̲òe̲中;
        is-deeply @à <<[&metaop]>> @丛, @сe̲ò갮л中, "@à <<$name=>> @丛";
        is-deeply @à, @сe̲ò갮л中, "@à assigned from @à <<$name=>> @丛";
        @à = @сe̲òe̲中;
        is-deeply @à >>[&metaop]>> @丛, @сe̲ò갮л中, "@à >>$name=>> @丛";
        is-deeply @à, @сe̲ò갮л中, "@à assigned from @à >>$name=>> @丛";
        @à = @сe̲òe̲中;

        # @à >>op<< 3
        dies-ok { @à >>[&op]<< 3 }, "@à >>$name\<< 3 dies";
        dies-ok { @à <<[&op]<< 3 }, "@à <<$name\<< 3 dies";
        is-deeply @à <<[&op]>> 3, @сe̲ò갮л中갨𝐩3, "@à <<$name>> 3";
        is-deeply @à >>[&op]>> 3, @сe̲ò갮л中갨𝐩3, "@à >>$name>> 3";

        # @à >>op=<< 3
        dies-ok { @à >>[&metaop]<< 3 }, "@à >>$name=<< 3 dies";
        dies-ok { @à <<[&metaop]<< 3 }, "@à <<$name=<< 3 dies";
        is-deeply @à <<[&metaop]>> 3, @сe̲ò갮л中갨𝐩3, "@à <<$name=>> 3";
        is-deeply @à, @сe̲ò갮л中갨𝐩3, "@à assigned from @à <<$name=>> 3";
        @à = @сe̲òe̲中;
        is-deeply @à >>[&metaop]>> 3, @сe̲ò갮л中갨𝐩3, "@à >>$name=>> 3";
        is-deeply @à, @сe̲ò갮л中갨𝐩3, "@à assigned from @à >>$name=>> 3";
        @à = @сe̲òe̲中;

        # 3 >>op<< @à
        dies-ok { 3 >>[&op]<< @à }, "3 >>$name\<< @à dies";
        dies-ok { 3 >>[&op]>> @à }, "3 >>$name>> @à dies";
        is-deeply 3 <<[&op]>> @à, @сe̲ò갮л中3갨𝐩, "3 <<$name>> @à";
        is-deeply 3 <<[&op]<< @à, @сe̲ò갮л中3갨𝐩, "3 <<$name\<< @à";

        # 3 >>op=<< @à
        dies-ok { 3 >>[&metaop]<< @à }, "3 >>$name=<< @à dies";
        dies-ok { 3 >>[&metaop]>> @à }, "3 >>$name=>> @à dies";
        dies-ok { 3 <<[&metaop]>> @à }, "3 <<$name=>> @à dies";
        dies-ok { 3 <<[&metaop]<< @à }, "3 <<$name=<< @à dies";
    }

    # ordinary hashes initialization
    my %à = "a".."e" Z=> 1..5;
    my %сe̲òe̲中 = %à;
    my %丛 = "a".."e" Z=> 6..10;
    my %сe̲ò갮л中 = %à.map: { .key => op(.value, %丛{.key}) }
    my %сe̲ò갮л中갨𝐩3 = %à.map: { .key => op(.value, 3) }
    my %сe̲ò갮л中3갨𝐩 = %à.map: { .key => op(3, .value) }

    # typed hashes initialization
    my Cool %ac = %à;
    my Cool %resetc = %ac;
    my Cool %bc = %丛;
    my Cool %resultc = %сe̲ò갮л中;
    my Cool %resultop3c = %сe̲ò갮л中갨𝐩3;
    my Cool %result3opc = %сe̲ò갮л中3갨𝐩;

    # object hashes initialization
    my %à갨{Any} = %à;
    my %сe̲òe̲中갨{Any} = %à갨;
    my %丛갨{Any} = %丛;
    my %сe̲ò갮л中갨{Any} = %сe̲ò갮л中;
    my %сe̲ò갮л中갨𝐩3갨{Any} = %сe̲ò갮л中갨𝐩3;
    my %сe̲ò갮л中3갨𝐩갨{Any} = %сe̲ò갮л中3갨𝐩;

    for (
        %à, %丛, %сe̲òe̲中, %сe̲ò갮л中, %сe̲ò갮л中갨𝐩3, %сe̲ò갮л中3갨𝐩,
        %ac, %bc, %resetc, %resultc, %resultop3c, %result3opc,
        %à갨, %丛갨, %сe̲òe̲中갨, %сe̲ò갮л中갨, %сe̲ò갮л中갨𝐩3갨, %сe̲ò갮л中3갨𝐩갨,
    ) -> %à, %丛, %сe̲òe̲中, %сe̲ò갮л中, %сe̲ò갮л中갨𝐩3, %сe̲ò갮л中3갨𝐩 {

        # %à >>op<< %丛
        is-deeply %à >>[&op]<< %丛, %сe̲ò갮л中, "%à >>$name\<< %丛";
        is-deeply %à <<[&op]<< %丛, %сe̲ò갮л中, "%à <<$name\<< %丛";
        is-deeply %à <<[&op]>> %丛, %сe̲ò갮л中, "%à <<$name>> %丛";
        is-deeply %à >>[&op]>> %丛, %сe̲ò갮л中, "%à >>$name>> %丛";

        # %à >>op=<< %丛
        is-deeply %à >>[&metaop]<< %丛, %сe̲ò갮л中, "%à >>$name=<< %丛";
        is-deeply %à, %сe̲ò갮л中, "%à assigned from %à >>$name=<< %丛";
        %à = %сe̲òe̲中;
        is-deeply %à <<[&metaop]<< %丛, %сe̲ò갮л中, "%à <<$name=<< %丛";
        is-deeply %à, %сe̲ò갮л中, "%à assigned from %à <<$name=<< %丛";
        %à = %сe̲òe̲中;
        is-deeply %à <<[&metaop]>> %丛, %сe̲ò갮л中, "%à <<$name=>> %丛";
        is-deeply %à, %сe̲ò갮л中, "%à assigned from %à <<$name=>> %丛";
        %à = %сe̲òe̲中;
        is-deeply %à >>[&metaop]>> %丛, %сe̲ò갮л中, "%à >>$name=>> %丛";
        is-deeply %à, %сe̲ò갮л中, "%à assigned from %à >>$name=>> %丛";
        %à = %сe̲òe̲中;

        # %à >>op<< 3
        dies-ok { %à >>[&op]<< 3 }, "%à >>$name\<< 3 dies";
        dies-ok { %à <<[&op]<< 3 }, "%à <<$name\<< 3 dies";
        is-deeply %à <<[&op]>> 3, %сe̲ò갮л中갨𝐩3, "%à <<$name>> 3";
        is-deeply %à >>[&op]>> 3, %сe̲ò갮л中갨𝐩3, "%à >>$name>> 3";

        # %à >>op=<< 3
        dies-ok { %à >>[&metaop]<< 3 }, "%à >>$name=<< 3 dies";
        dies-ok { %à <<[&metaop]<< 3 }, "%à <<$name=<< 3 dies";
        is-deeply %à <<[&metaop]>> 3, %сe̲ò갮л中갨𝐩3, "%à <<$name=>> 3";
        is-deeply %à, %сe̲ò갮л中갨𝐩3, "%à assigned from %à <<$name=>> 3";
        %à = %сe̲òe̲中;
        is-deeply %à >>[&metaop]>> 3, %сe̲ò갮л中갨𝐩3, "%à >>$name=>> 3";
        is-deeply %à, %сe̲ò갮л中갨𝐩3, "%à assigned from %à >>$name=>> 3";
        %à = %сe̲òe̲中;

        # 3 >>op<< %à
        dies-ok { 3 >>[&op]<< %à }, "3 >>$name\<< %à dies";
        dies-ok { 3 >>[&op]>> %à }, "3 >>$name>> %à dies";
        is-deeply 3 <<[&op]>> %à, %сe̲ò갮л中3갨𝐩, "3 <<$name>> %à";
        is-deeply 3 <<[&op]<< %à, %сe̲ò갮л中3갨𝐩, "3 <<$name\<< %à";

        # 3 >>op<< %à
        dies-ok { 3 >>[&metaop]<< %à }, "3 >>$name=<< %à dies";
        dies-ok { 3 >>[&metaop]>> %à }, "3 >>$name=>> %à dies";
        dies-ok { 3 <<[&metaop]>> %à }, "3 <<$name=>> %à dies";
        dies-ok { 3 <<[&metaop]<< %à }, "3 <<$name=<< %à dies";
    }
}

for @갢丧中-갢丧е갢чe̲ò -> $name, &op, &metaop {

    # SetHash initialization
    my %òà is SetHash = "a".."e" Z=> 1..5;
    my %òсe̲òe̲中 = %òà.pairs;
    my %ò丛 is SetHash = "a".."e" Z=> 6..10;
    my %òсe̲ò갮л中 is SetHash = %òà.map: { .key => op(.value, %ò丛{.key}) }
    my %òсe̲ò갮л中갨𝐩3 is SetHash = %òà.map: { .key => op(.value, 3) }
    my %òсe̲ò갮л中3갨𝐩 is SetHash = %òà.map: { .key => op(3, .value) }

    # BagHash initialization
    my %丛à is BagHash = "a".."e" Z=> 1..5;
    my %丛сe̲òe̲中 = %丛à.pairs;
    my %丛丛 is BagHash = "a".."e" Z=> 6..10;
    my %丛сe̲ò갮л中 is BagHash = %丛à.map: { .key => op(.value, %丛丛{.key}) }
    my %丛сe̲ò갮л中갨𝐩3 is BagHash = %丛à.map: { .key => op(.value, 3) }
    my %丛сe̲ò갮л中3갨𝐩 is BagHash = %丛à.map: { .key => op(3, .value) }

    # MixHash initialization
    my %ìà is MixHash = "a".."e" Z=> 1..5;
    my %ìсe̲òe̲中 = %ìà.pairs;
    my %ì丛 is MixHash = "a".."e" Z=> 6..10;
    my %ìсe̲ò갮л中 is MixHash = %ìà.map: { .key => op(.value, %ì丛{.key}) }
    my %ìсe̲ò갮л中갨𝐩3 is MixHash = %ìà.map: { .key => op(.value, 3) }
    my %ìсe̲ò갮л中3갨𝐩 is MixHash = %ìà.map: { .key => op(3, .value) }

    for (
        %òà, %ò丛, %òсe̲òe̲中, %òсe̲ò갮л中, %òсe̲ò갮л中갨𝐩3, %òсe̲ò갮л中3갨𝐩, "set",
        %丛à, %丛丛, %丛сe̲òe̲中, %丛сe̲ò갮л中, %丛сe̲ò갮л中갨𝐩3, %丛сe̲ò갮л中3갨𝐩, "bag",
        %ìà, %ì丛, %ìсe̲òe̲中, %ìсe̲ò갮л中, %ìсe̲ò갮л中갨𝐩3, %ìсe̲ò갮л中3갨𝐩, "mix",
    ) -> %à, %丛, %сe̲òe̲中, %сe̲ò갮л中, %сe̲ò갮л中갨𝐩3, %сe̲ò갮л中3갨𝐩, $type {

        # %à >>op<< %丛
        is-deeply %à >>[&op]<< %丛, %сe̲ò갮л中, "$type %à >>$name\<< %丛";
        is-deeply %à <<[&op]<< %丛, %сe̲ò갮л中, "$type %à <<$name\<< %丛";
        is-deeply %à <<[&op]>> %丛, %сe̲ò갮л中, "$type %à <<$name>> %丛";
        is-deeply %à >>[&op]>> %丛, %сe̲ò갮л中, "$type %à >>$name>> %丛";

        # %à >>op=<< %丛
        is-deeply %à >>[&metaop]<< %丛, %сe̲ò갮л中, "$type %à >>$name=<< %丛";
        is-deeply %à, %сe̲ò갮л中, "$type %à assigned from %à >>$name=<< %丛";
        %à = %сe̲òe̲中.pairs;
        is-deeply %à <<[&metaop]<< %丛, %сe̲ò갮л中, "$type %à <<$name=<< %丛";
        is-deeply %à, %сe̲ò갮л中, "$type %à assigned from %à <<$name=<< %丛";
        %à = %сe̲òe̲中.pairs;
        is-deeply %à <<[&metaop]>> %丛, %сe̲ò갮л中, "$type %à <<$name=>> %丛";
        is-deeply %à, %сe̲ò갮л中, "$type %à assigned from %à <<$name=>> %丛";
        %à = %сe̲òe̲中.pairs;
        is-deeply %à >>[&metaop]>> %丛, %сe̲ò갮л中, "$type %à >>$name=>> %丛";
        is-deeply %à, %сe̲ò갮л中, "$type %à assigned from %à >>$name=>> %丛";
        %à = %сe̲òe̲中.pairs;

        # %à >>op<< 3
        dies-ok { %à >>[&op]<< 3 }, "$type %à >>$name\<< 3 dies";
        dies-ok { %à <<[&op]<< 3 }, "$type %à <<$name\<< 3 dies";
        is-deeply %à <<[&op]>> 3, %сe̲ò갮л中갨𝐩3, "$type %à <<$name>> 3";
        is-deeply %à >>[&op]>> 3, %сe̲ò갮л中갨𝐩3, "$type %à >>$name>> 3";

        # %à >>op=<< 3
        dies-ok { %à >>[&metaop]<< 3 }, "$type %à >>$name=<< 3 dies";
        dies-ok { %à <<[&metaop]<< 3 }, "$type %à <<$name=<< 3 dies";
        is-deeply %à <<[&metaop]>> 3, %сe̲ò갮л中갨𝐩3, "$type %à <<$name=>> 3";
        is-deeply %à, %сe̲ò갮л中갨𝐩3, "$type %à assigned from %à <<$name=>> 3";
        %à = %сe̲òe̲中.pairs;
        is-deeply %à >>[&metaop]>> 3, %сe̲ò갮л中갨𝐩3, "$type %à >>$name=>> 3";
        is-deeply %à, %сe̲ò갮л中갨𝐩3, "$type %à assigned from %à >>$name=>> 3";
        %à = %сe̲òe̲中.pairs;

        # 3 >>op<< %à
        dies-ok { 3 >>[&op]<< %à }, "$type 3 >>$name\<< %à dies";
        dies-ok { 3 >>[&op]>> %à }, "$type 3 >>$name>> %à dies";
        is-deeply 3 <<[&op]>> %à, %сe̲ò갮л中3갨𝐩, "$type 3 <<$name>> %à";
        is-deeply 3 <<[&op]<< %à, %сe̲ò갮л中3갨𝐩, "$type 3 <<$name\<< %à";

        # 3 >>op<< %à
        dies-ok { 3 >>[&metaop]<< %à }, "$type 3 >>$name=<< %à dies";
        dies-ok { 3 >>[&metaop]>> %à }, "$type 3 >>$name=>> %à dies";
        dies-ok { 3 <<[&metaop]>> %à }, "$type 3 <<$name=>> %à dies";
        dies-ok { 3 <<[&metaop]<< %à }, "$type 3 <<$name=<< %à dies";
    }
}

# vim: expandtab shiftwidth=4
