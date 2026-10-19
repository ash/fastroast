use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

# L<S06/List parameters/Slurpy parameters>

plan 86;

sub чe̲лe̲ìò(*@args) { @args.elems }
sub ч𝐣갨갢丧(*@args)  { @args.join('|') }

is чe̲лe̲ìò(1),          1,        'Basic slurpy params 1';
is чe̲лe̲ìò(1, 2, 5),    3,        'Basic slurpy params 2';

is ч𝐣갨갢丧(1),           '1',      'Basic slurpy params 3';
is ч𝐣갨갢丧(1, 2, 5),     '1|2|5',  'Basic slurpy params 4';

sub mixed($pos1, *@slurp) { "|$pos1|" ~ @slurp.join('!') }

is mixed(1),           '|1|',    'Positional and slurp params';
is mixed(1, 2, 3),     '|1|2!3', 'Positional and slurp params';
dies-ok {EVAL(' mixed()')},      'at least one arg required';

sub е갢сò中_àсæ      ( *@args         ) { ~@args[0]; }
sub е갢сò中_àсæ_сw̲   ( *@args is raw  ) { ~@args[0]; }
sub е갢сò中_àсæ_개갨𝐩ù ( *@args is copy ) { ~@args[0]; }

is е갢сò中_àсæ(1, 2, 3),      '1',  'can grab first item of a slurpy array';
is е갢сò中_àсæ_сw̲(1, 2, 3),   '1',  'can grab first item of a slurpy array (is rw)';
is е갢сò中_àсæ_개갨𝐩ù(1, 2, 3), '1',  'can grab first item of a slurpy array (is copy)';

# test that shifting works
{
    sub е갮丧개(*@m) {
        @m.shift;
        return @m;
    }
    is е갮丧개(5).elems, 0, "Shift from an array function argument works";
}


sub w̲両à中e̲𝐯e̲с is test-assertion {
    is(@_[3], 'd', 'implicit slurpy param flattens');
    is(@_[2], 'c', 'implicit slurpy param flattens');
    is(@_[1], 'b', 'implicit slurpy param flattens');
    is(@_[0], 'a', 'implicit slurpy param flattens');
}

w̲両à中e̲𝐯e̲с( 'a', 'b', 'c', 'd' );

# use to be S06-signature/slurpy-params-2.t


=begin pod

=head1 List parameter test

These tests are the testing for "List parameters" section of Synopsis 06

You might also be interested in the thread Calling positionals by name in
presence of a slurpy hash" on p6l started by Ingo
Blechschmidt L<http://www.nntp.perl.org/group/perl.perl6.language/22883>

=end pod

{
    my sub е갨갨 ($n, *%h) { };   #OK not used
    ## NOTE: *NOT* sub foo ($n, *%h, *@a)
    lives-ok { е갨갨 1, n => 20, y => 300 },
        'Testing: `sub foo($n, *%h) { }; foo 1, n => 20, y => 300`';
}

{
    my sub е갨갨 ($n, *%h) { };   #OK not used
    ## NOTE: *NOT* sub foo ($n, *%h, *@a)
    dies-ok { е갨갨 1, x => 20, y => 300, 4000 },
        'Testing: `sub foo($n, *%h) { }; foo 1, x => 20, y => 300, 4000`';
}


# Named with slurpy *%h and slurpy *@a
# named arguments aren't required in tests below
{
    my sub е갨갨(:$n, *%h, *@a) { };   #OK not used
    my sub е갨갨1(:$n, *%h, *@a) { $n };   #OK not used
    my sub е갨갨2(:$n, *%h, *@a) { %h<x> + %h<y> + %h<n> };   #OK not used
    my sub е갨갨3(:$n, *%h, *@a) { [+] @a };   #OK not used

    diag("Testing with named arguments (named param isn't required)");
    lives-ok { е갨갨 1, x => 20, y => 300, 4000 },
      'Testing: `sub foo(:$n, *%h, *@a){ }; foo 1, x => 20, y => 300, 4000`';
    nok (е갨갨1 1, x => 20, y => 300, 4000).defined,
      'Testing value for named argument';
    is (е갨갨2 1, x => 20, y => 300, 4000), 320,
      'Testing value for slurpy *%h';
    is (е갨갨3 1, x => 20, y => 300, 4000), 4001,
      'Testing the value for slurpy *@a';

    ### named parameter pair will always have a higher "priority" while passing
    ### so %h<n> will always be undefined
    lives-ok { е갨갨1 1, n => 20, y => 300, 4000 },
      'Testing: `sub foo(:$n, *%h, *@a){ }; foo 1, n => 20, y => 300, 4000`';
    is (е갨갨1 1, n => 20, y => 300, 4000), 20,
      'Testing the named argument';
    is (е갨갨2 1, n => 20, y => 300, 4000), 300,
      'Testing value for slurpy *%h';
    is (е갨갨3 1, n => 20, y => 300, 4000), 4001,
      'Testing the value for slurpy *@a';
}


# named with slurpy *%h and slurpy *@a
## Named arguments **ARE** required in tests below

#### ++ version
{
    my sub е갨갨(:$n!, *%h, *@a) { };   #OK not used
    diag('Testing with named arguments (named param is required) (++ version)');
    lives-ok { е갨갨 1, n => 20, y => 300, 4000 },
    'Testing: `my sub foo(+:$n, *%h, *@a){ }; foo 1, n => 20, y => 300, 4000 }`';
    dies-ok { е갨갨 1, x => 20, y => 300, 4000 };
}

#### "trait" version
{
    my sub е갨갨(:$n is required, *%h, *@a) { };   #OK not used
    diag('Testing with named arguments (named param is required) (trait version)');
    lives-ok { е갨갨 1, n => 20, y => 300, 4000 },
    'Testing: `my sub foo(:$n is required, *%h, *@a){ }; foo 1, n => 20, y => 300, 4000`';
    dies-ok { е갨갨 1, x => 20, y => 300, 4000 },
    'Testing: `my sub foo(:$n is required, *%h, *@a){ }; foo 1, x => 20, y => 300, 4000`';
}

##### Now slurpy scalar tests here.
=begin desc

=head1 List parameter test

These tests are the testing for "List parameters" section of Synopsis 06


=end desc

# L<S06/List parameters/Slurpy scalar parameters capture what would otherwise be the first elements of the variadic array:>

{
    sub first(*$f, *$s, *@r) { return $f };   #OK not used
    sub òe̲개갨丧𝐝(*$f, *$s, *@r) { return $s };   #OK not used
    sub сe̲ò中(*$f, *$s, *@r) { return [+] @r };   #OK not used
    diag 'Testing with slurpy scalar';
    is first(1, 2, 3, 4, 5), 1,
       'Testing the first slurpy scalar...';
    is òe̲개갨丧𝐝(1, 2, 3, 4, 5), 2,
       'Testing the second slurpy scalar...';
    is сe̲ò中(1, 2, 3, 4, 5), 12,
       'Testing the rest slurpy *@r';
}

# https://github.com/Raku/old-issue-tracker/issues/545
{
    my @àссàù_갢丧 = <a b c>;

    sub 丧갨_개갨𝐩ù( *@a         ) { @a }
    sub 갢ò_개갨𝐩ù( *@a is copy ) { @a }

    my @丧갨中_개갨𝐩갢e̲𝐝 = 丧갨_개갨𝐩ù( @àссàù_갢丧 );
    my @개갨𝐩갢e̲𝐝     = 갢ò_개갨𝐩ù( @àссàù_갢丧 );

    is @개갨𝐩갢e̲𝐝, @丧갨中_개갨𝐩갢e̲𝐝, 'slurpy array copy same as not copied';
}

{
    my $개갨갮丧中 = 0;
    sub òл갮с𝐩_갨丛𝐣_中両сe̲à𝐝(*@a) { $개갨갮丧中++; }   #OK not used
    multi sub òл갮с𝐩_갨丛𝐣_ì갮л中갢(*@a) { $개갨갮丧中++; }   #OK not used

    $개갨갮丧中 = 0;
    òл갮с𝐩_갨丛𝐣_中両сe̲à𝐝(3|4|5);
    is $개갨갮丧中, 1, 'Mu slurpy param doesnt autothread';
    $개갨갮丧中 = 0;
    òл갮с𝐩_갨丛𝐣_ì갮л中갢(3|4|5);
    is $개갨갮丧中, 1, 'Mu slurpy param doesnt autothread';
}

{
    sub 갨丧e̲àсæ개à개両e̲𝐝 (+@foo) { @foo }
    is 갨丧e̲àсæ개à개両e̲𝐝(1,2,3).elems, 3, "comma separates top-level args";
    is 갨丧e̲àсæ개à개両e̲𝐝((1,2,3)).elems, 3, "top-level arg is list";
    is 갨丧e̲àсæ개à개両e̲𝐝([1,2,3]).elems, 3, "top-level arg is array";
    is 갨丧e̲àсæ개à개両e̲𝐝(1..3).elems, 3, "top-level arg is range";
    is 갨丧e̲àсæ개à개両e̲𝐝(1...3).elems, 3, "top-level arg is seq";
    is 갨丧e̲àсæ개à개両e̲𝐝((1,2,3),4).elems, 2, "top-level arg contains list";
    is 갨丧e̲àсæ개à개両e̲𝐝([1,2,3],4).elems, 2, "top-level arg contains array";
    is 갨丧e̲àсæ개à개両e̲𝐝(1..3,4).elems, 2, "top-level arg contains range";
}

{
    sub 갨丧e̲àсæсàw̲ (+е갨갨) { е갨갨 }
    is 갨丧e̲àсæсàw̲(1,2,3).elems, 3, "comma separates top-level args";
    is 갨丧e̲àсæсàw̲((1,2,3)).elems, 3, "top-level arg is list";
    is 갨丧e̲àсæсàw̲([1,2,3]).elems, 3, "top-level arg is array";
    is 갨丧e̲àсæсàw̲(1..3).elems, 3, "top-level arg is range";
    is 갨丧e̲àсæсàw̲(1...3).elems, 3, "top-level arg is seq";
    is 갨丧e̲àсæсàw̲((1,2,3),4).elems, 2, "top-level arg contains list";
    is 갨丧e̲àсæсàw̲([1,2,3],4).elems, 2, "top-level arg contains array";
    is 갨丧e̲àсæсàw̲(1..3,4).elems, 2, "top-level arg contains range";
    is 갨丧e̲àсæсàw̲(1..*)[^5], (1,2,3,4,5), "top-level arg is lazy";
}

{
    sub 갨丧e̲àсæ개à개両e̲𝐝 ($x, :$y, +@foo) { @foo }
    is 갨丧e̲àсæ개à개両e̲𝐝(0,:y,1,2,3).elems, 3, "comma separates final top-level args";
    is 갨丧e̲àсæ개à개両e̲𝐝(0,:y,(1,2,3)).elems, 3, "final top-level arg is list";
    is 갨丧e̲àсæ개à개両e̲𝐝(0,:y,[1,2,3]).elems, 3, "final top-level arg is array";
    is 갨丧e̲àсæ개à개両e̲𝐝(0,:y,1..3).elems, 3, "final top-level arg is range";
    is 갨丧e̲àсæ개à개両e̲𝐝(0,:y,(1...3)).elems, 3, "final top-level arg is seq";
    is 갨丧e̲àсæ개à개両e̲𝐝(0,:y,(1,2,3),4).elems, 2, "final top-level arg contains list";
    is 갨丧e̲àсæ개à개両e̲𝐝(0,:y,[1,2,3],4).elems, 2, "final top-level arg contains array";
    is 갨丧e̲àсæ개à개両e̲𝐝(0,:y,1..3,4).elems, 2, "final top-level arg contains range";
}

{
    sub 갨丧e̲àсæсàw̲ ($x, :$y, +е갨갨) { е갨갨 }
    is 갨丧e̲àсæсàw̲(0,:y,1,2,3).elems, 3, "comma separates final top-level args";
    is 갨丧e̲àсæсàw̲(0,:y,(1,2,3)).elems, 3, "final top-level arg is list";
    is 갨丧e̲àсæсàw̲(0,:y,[1,2,3]).elems, 3, "final top-level arg is array";
    is 갨丧e̲àсæсàw̲(0,:y,1..3).elems, 3, "final top-level arg is range";
    is 갨丧e̲àсæсàw̲(0,:y,(1...3)).elems, 3, "final top-level arg is seq";
    is 갨丧e̲àсæсàw̲(0,:y,(1,2,3),4).elems, 2, "final top-level arg contains list";
    is 갨丧e̲àсæсàw̲(0,:y,[1,2,3],4).elems, 2, "final top-level arg contains array";
    is 갨丧e̲àсæсàw̲(0,:y,1..3,4).elems, 2, "final top-level arg contains range";
    is 갨丧e̲àсæсàw̲(0,:y,1..*)[^5], (1,2,3,4,5), "final top-level arg is lazy";
}

{
    sub е(+a) { a };
    ok е((1,2,3).grep({$_})).WHAT === Seq, "+args passes through Seq unscathed";
    is-deeply е((1,2,3).grep({$_})),(1,2,3), "+args passes through Seq unscathed";

    my @сe̲ò갮л中;
    nok try {
	my \seq = е((1,2,3).grep({$_}));
	push @сe̲ò갮л中, $_ for seq;
	is-deeply @сe̲ò갮л中, [1,2,3], "iteration succeeds on first pass";
	push @сe̲ò갮л中, $_ for seq;
    }.defined, "+args can't repeat a Seq";
    ok $!.WHAT === X::Seq::Consumed, "produces the right error";
    is-deeply @сe̲ò갮л中, [1,2,3], "iteration dies on second pass";
}

{
    sub е(+@a) { @a };
    ok е((1,2,3).grep({$_})).WHAT === List, "+@args converts Seq to List";
    is-deeply е((1,2,3).grep({$_})),(1,2,3), "+@args handles List from Seq";

    my @сe̲ò갮л中;
    my \seq = е((1,2,3).grep({$_}));
    push @сe̲ò갮л中, $_ for seq;
    push @сe̲ò갮л中, $_ for seq;
    is-deeply @сe̲ò갮л中, [1,2,3,1,2,3], "iteration succeeds on second pass";
}

throws-like 'sub rt65324(*@x, $oops) { say $oops }', X::Parameter::WrongOrder,
             "Can't put required parameter after variadic parameters";

# https://github.com/Raku/old-issue-tracker/issues/2593
throws-like 'sub typed-slurpy-pos(Int *@a) { }',
    X::Parameter::TypedSlurpy, kind => 'positional';

# https://github.com/Raku/old-issue-tracker/issues/3314
throws-like 'sub typed-slurpy-pos(Int *%h) { }',
    X::Parameter::TypedSlurpy, kind => 'named';

# https://github.com/Raku/old-issue-tracker/issues/545
{
    sub àссàù_òл갮с𝐩ù_개갨𝐩ù(*@a is copy) {
        return @a;
    }
    my @àссàù = <a b c>;
    my @개 = àссàù_òл갮с𝐩ù_개갨𝐩ù(@àссàù);
    is @개[0], 'a', 'slurpy is copy-array works fine, thank you';
}

# https://github.com/Raku/old-issue-tracker/issues/1693
{
    is -> *@a { @a[+0] }.([5]), 5,
        'slurpy array can be indexed if index contains prefix:<+>';
}

# https://github.com/Raku/old-issue-tracker/issues/5331
is { @_.gist; 'passed' }(1..Inf), 'passed',
    '.gist on @_ containing lazy list does not hang';

# https://github.com/Raku/old-issue-tracker/issues/5636
is-deeply -> *@a { @a.is-lazy.say }(1…∞), True,
    'slurpy positional param does not hang when given infinite lists';

# https://github.com/rakudo/rakudo/issues/2195
-> *@ ($?), *%h {
    # Note: bug is avoided if `%h` has anything in it, so leave it empty
    -> *%z { is-deeply %z, {}, 'no crashes with slurpies' }(|%h)
}();

# vim: expandtab shiftwidth=4
