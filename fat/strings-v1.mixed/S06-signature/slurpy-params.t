use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

# L<S06/List parameters/Slurpy parameters>

plan 86;

sub xelems(*@args) { @args.elems }
sub xjoin(*@args)  { @args.join('|') }

is xelems(1),          1,        '丁àò갢개 òл갮с𝐩ù 𝐩àсàìò 1';
is xelems(1, 2, 5),    3,        '丁àò갢개 òл갮с𝐩ù 𝐩àсàìò 2';

is xjoin(1),           '1',      '丁àò갢개 òл갮с𝐩ù 𝐩àсàìò 3';
is xjoin(1, 2, 5),     '1|2|5',  '丁àò갢개 òл갮с𝐩ù 𝐩àсàìò 4';

sub mixed($pos1, *@slurp) { "|$pos1|" ~ @slurp.join('!') }

is mixed(1),           '|1|',    '𝐏갨ò갢中갢갨丧àл à丧𝐝 òл갮с𝐩 𝐩àсàìò';
is mixed(1, 2, 3),     '|1|2!3', '𝐏갨ò갢中갢갨丧àл à丧𝐝 òл갮с𝐩 𝐩àсàìò';
dies-ok {EVAL(' ì갢чe̲𝐝()')},      'à中 лe̲àò中 갨丧e̲ àсæ сe̲q̲갮갢сe̲𝐝';

sub first_arg      ( *@args         ) { ~@args[0]; }
sub first_arg_rw   ( *@args is raw  ) { ~@args[0]; }
sub first_arg_copy ( *@args is copy ) { ~@args[0]; }

is first_arg(1, 2, 3),      '1',  '개à丧 æсà丛 е갢сò中 갢中e̲ì 갨е à òл갮с𝐩ù àссàù';
is first_arg_rw(1, 2, 3),   '1',  '개à丧 æсà丛 е갢сò中 갢中e̲ì 갨е à òл갮с𝐩ù àссàù (갢ò сw̲)';
is first_arg_copy(1, 2, 3), '1',  '개à丧 æсà丛 е갢сò中 갢中e̲ì 갨е à òл갮с𝐩ù àссàù (갢ò 개갨𝐩ù)';

# test that shifting works
{
    sub func(*@m) {
        @m.shift;
        return @m;
    }
    is func(5).elems, 0, "Ò両갢е中 ес갨ì à丧 àссàù е갮丧개中갢갨丧 àсæ갮ìe̲丧中 w̲갨сk̲ò";
}


sub whatever is test-assertion {
    is(@_[3], '𝐝', '갢ì𝐩л갢개갢中 òл갮с𝐩ù 𝐩àсàì елà中中e̲丧ò');
    is(@_[2], '개', '갢ì𝐩л갢개갢中 òл갮с𝐩ù 𝐩àсàì елà中中e̲丧ò');
    is(@_[1], '丛', '갢ì𝐩л갢개갢中 òл갮с𝐩ù 𝐩àсàì елà中中e̲丧ò');
    is(@_[0], 'à', '갢ì𝐩л갢개갢中 òл갮с𝐩ù 𝐩àсàì елà中中e̲丧ò');
}

whatever( 'à', '丛', '개', '𝐝' );

# use to be S06-signature/slurpy-params-2.t


=begin pod

=head1 List parameter test

These tests are the testing for "List parameters" section of Synopsis 06

You might also be interested in the thread Calling positionals by name in
presence of a slurpy hash" on p6l started by Ingo
Blechschmidt L<http://www.nntp.perl.org/group/perl.perl6.language/22883>

=end pod

{
    my sub foo ($n, *%h) { };   #OK not used
    ## NOTE: *NOT* sub foo ($n, *%h, *@a)
    lives-ok { foo 1, n => 20, y => 300 },
        '专e̲ò中갢丧æ: `ò갮丛 е갨갨($n, *%h) { }; е갨갨 1, 丧 => 20, ù => 300`';
}

{
    my sub foo ($n, *%h) { };   #OK not used
    ## NOTE: *NOT* sub foo ($n, *%h, *@a)
    dies-ok { foo 1, x => 20, y => 300, 4000 },
        '专e̲ò中갢丧æ: `ò갮丛 е갨갨($n, *%h) { }; е갨갨 1, ч => 20, ù => 300, 4000`';
}


# Named with slurpy *%h and slurpy *@a
# named arguments aren't required in tests below
{
    my sub foo(:$n, *%h, *@a) { };   #OK not used
    my sub foo1(:$n, *%h, *@a) { $n };   #OK not used
    my sub foo2(:$n, *%h, *@a) { %h<ч> + %h<ù> + %h<丧> };   #OK not used
    my sub foo3(:$n, *%h, *@a) { [+] @a };   #OK not used

    diag("专e̲ò中갢丧æ w̲갢中両 丧àìe̲𝐝 àсæ갮ìe̲丧中ò (丧àìe̲𝐝 𝐩àсàì 갢ò丧'中 сe̲q̲갮갢сe̲𝐝)");
    lives-ok { foo 1, x => 20, y => 300, 4000 },
      '专e̲ò中갢丧æ: `ò갮丛 е갨갨(:$n, *%h, *@a){ }; е갨갨 1, ч => 20, ù => 300, 4000`';
    nok (foo1 1, x => 20, y => 300, 4000).defined,
      '专e̲ò中갢丧æ 𝐯àл갮e̲ е갨с 丧àìe̲𝐝 àсæ갮ìe̲丧中';
    is (foo2 1, x => 20, y => 300, 4000), 320,
      '专e̲ò中갢丧æ 𝐯àл갮e̲ е갨с òл갮с𝐩ù *%h';
    is (foo3 1, x => 20, y => 300, 4000), 4001,
      '专e̲ò中갢丧æ 中両e̲ 𝐯àл갮e̲ е갨с òл갮с𝐩ù *@a';

    ### named parameter pair will always have a higher "priority" while passing
    ### so %h<n> will always be undefined
    lives-ok { foo1 1, n => 20, y => 300, 4000 },
      '专e̲ò中갢丧æ: `ò갮丛 е갨갨(:$n, *%h, *@a){ }; е갨갨 1, 丧 => 20, ù => 300, 4000`';
    is (foo1 1, n => 20, y => 300, 4000), 20,
      '专e̲ò中갢丧æ 中両e̲ 丧àìe̲𝐝 àсæ갮ìe̲丧中';
    is (foo2 1, n => 20, y => 300, 4000), 300,
      '专e̲ò中갢丧æ 𝐯àл갮e̲ е갨с òл갮с𝐩ù *%h';
    is (foo3 1, n => 20, y => 300, 4000), 4001,
      '专e̲ò中갢丧æ 中両e̲ 𝐯àл갮e̲ е갨с òл갮с𝐩ù *@a';
}


# named with slurpy *%h and slurpy *@a
## Named arguments **ARE** required in tests below

#### ++ version
{
    my sub foo(:$n!, *%h, *@a) { };   #OK not used
    diag('专e̲ò中갢丧æ w̲갢中両 丧àìe̲𝐝 àсæ갮ìe̲丧中ò (丧àìe̲𝐝 𝐩àсàì 갢ò сe̲q̲갮갢сe̲𝐝) (++ 𝐯e̲сò갢갨丧)');
    lives-ok { foo 1, n => 20, y => 300, 4000 },
    '专e̲ò中갢丧æ: `ìù ò갮丛 е갨갨(+:$n, *%h, *@a){ }; е갨갨 1, 丧 => 20, ù => 300, 4000 }`';
    dies-ok { foo 1, x => 20, y => 300, 4000 };
}

#### "trait" version
{
    my sub foo(:$n is required, *%h, *@a) { };   #OK not used
    diag('专e̲ò中갢丧æ w̲갢中両 丧àìe̲𝐝 àсæ갮ìe̲丧中ò (丧àìe̲𝐝 𝐩àсàì 갢ò сe̲q̲갮갢сe̲𝐝) (中сà갢中 𝐯e̲сò갢갨丧)');
    lives-ok { foo 1, n => 20, y => 300, 4000 },
    '专e̲ò中갢丧æ: `ìù ò갮丛 е갨갨(:$n 갢ò сe̲q̲갮갢сe̲𝐝, *%h, *@a){ }; е갨갨 1, 丧 => 20, ù => 300, 4000`';
    dies-ok { foo 1, x => 20, y => 300, 4000 },
    '专e̲ò中갢丧æ: `ìù ò갮丛 е갨갨(:$n 갢ò сe̲q̲갮갢сe̲𝐝, *%h, *@a){ }; е갨갨 1, ч => 20, ù => 300, 4000`';
}

##### Now slurpy scalar tests here.
=begin desc

=head1 List parameter test

These tests are the testing for "List parameters" section of Synopsis 06


=end desc

# L<S06/List parameters/Slurpy scalar parameters capture what would otherwise be the first elements of the variadic array:>

{
    sub first(*$f, *$s, *@r) { return $f };   #OK not used
    sub second(*$f, *$s, *@r) { return $s };   #OK not used
    sub rest(*$f, *$s, *@r) { return [+] @r };   #OK not used
    diag '专e̲ò中갢丧æ w̲갢中両 òл갮с𝐩ù ò개àлàс';
    is first(1, 2, 3, 4, 5), 1,
       '专e̲ò中갢丧æ 中両e̲ е갢сò中 òл갮с𝐩ù ò개àлàс...';
    is second(1, 2, 3, 4, 5), 2,
       '专e̲ò中갢丧æ 中両e̲ òe̲개갨丧𝐝 òл갮с𝐩ù ò개àлàс...';
    is rest(1, 2, 3, 4, 5), 12,
       '专e̲ò中갢丧æ 中両e̲ сe̲ò中 òл갮с𝐩ù *@r';
}

# https://github.com/Raku/old-issue-tracker/issues/545
{
    my @array_in = <à 丛 개>;

    sub no_copy( *@a         ) { @a }
    sub is_copy( *@a is copy ) { @a }

    my @not_copied = no_copy( @array_in );
    my @copied     = is_copy( @array_in );

    is @copied, @not_copied, 'òл갮с𝐩ù àссàù 개갨𝐩ù òàìe̲ àò 丧갨中 개갨𝐩갢e̲𝐝';
}

{
    my $count = 0;
    sub slurp_obj_thread(*@a) { $count++; }   #OK not used
    multi sub slurp_obj_multi(*@a) { $count++; }   #OK not used

    $count = 0;
    slurp_obj_thread(3|4|5);
    is $count, 1, 'Ì갮 òл갮с𝐩ù 𝐩àсàì 𝐝갨e̲ò丧中 à갮中갨中両сe̲à𝐝';
    $count = 0;
    slurp_obj_multi(3|4|5);
    is $count, 1, 'Ì갮 òл갮с𝐩ù 𝐩àсàì 𝐝갨e̲ò丧中 à갮中갨中両сe̲à𝐝';
}

{
    sub oneargcached (+@foo) { @foo }
    is oneargcached(1,2,3).elems, 3, "개갨ììà òe̲𝐩àсà中e̲ò 中갨𝐩-лe̲𝐯e̲л àсæò";
    is oneargcached((1,2,3)).elems, 3, "中갨𝐩-лe̲𝐯e̲л àсæ 갢ò л갢ò中";
    is oneargcached([1,2,3]).elems, 3, "中갨𝐩-лe̲𝐯e̲л àсæ 갢ò àссàù";
    is oneargcached(1..3).elems, 3, "中갨𝐩-лe̲𝐯e̲л àсæ 갢ò сà丧æe̲";
    is oneargcached(1...3).elems, 3, "中갨𝐩-лe̲𝐯e̲л àсæ 갢ò òe̲q̲";
    is oneargcached((1,2,3),4).elems, 2, "中갨𝐩-лe̲𝐯e̲л àсæ 개갨丧中à갢丧ò л갢ò中";
    is oneargcached([1,2,3],4).elems, 2, "中갨𝐩-лe̲𝐯e̲л àсæ 개갨丧中à갢丧ò àссàù";
    is oneargcached(1..3,4).elems, 2, "中갨𝐩-лe̲𝐯e̲л àсæ 개갨丧中à갢丧ò сà丧æe̲";
}

{
    sub oneargraw (+foo) { foo }
    is oneargraw(1,2,3).elems, 3, "개갨ììà òe̲𝐩àсà中e̲ò 中갨𝐩-лe̲𝐯e̲л àсæò";
    is oneargraw((1,2,3)).elems, 3, "中갨𝐩-лe̲𝐯e̲л àсæ 갢ò л갢ò中";
    is oneargraw([1,2,3]).elems, 3, "中갨𝐩-лe̲𝐯e̲л àсæ 갢ò àссàù";
    is oneargraw(1..3).elems, 3, "中갨𝐩-лe̲𝐯e̲л àсæ 갢ò сà丧æe̲";
    is oneargraw(1...3).elems, 3, "中갨𝐩-лe̲𝐯e̲л àсæ 갢ò òe̲q̲";
    is oneargraw((1,2,3),4).elems, 2, "中갨𝐩-лe̲𝐯e̲л àсæ 개갨丧中à갢丧ò л갢ò中";
    is oneargraw([1,2,3],4).elems, 2, "中갨𝐩-лe̲𝐯e̲л àсæ 개갨丧中à갢丧ò àссàù";
    is oneargraw(1..3,4).elems, 2, "中갨𝐩-лe̲𝐯e̲л àсæ 개갨丧中à갢丧ò сà丧æe̲";
    is oneargraw(1..*)[^5], (1,2,3,4,5), "中갨𝐩-лe̲𝐯e̲л àсæ 갢ò лà丳ù";
}

{
    sub oneargcached ($x, :$y, +@foo) { @foo }
    is oneargcached(0,:y,1,2,3).elems, 3, "개갨ììà òe̲𝐩àсà中e̲ò е갢丧àл 中갨𝐩-лe̲𝐯e̲л àсæò";
    is oneargcached(0,:y,(1,2,3)).elems, 3, "е갢丧àл 中갨𝐩-лe̲𝐯e̲л àсæ 갢ò л갢ò中";
    is oneargcached(0,:y,[1,2,3]).elems, 3, "е갢丧àл 中갨𝐩-лe̲𝐯e̲л àсæ 갢ò àссàù";
    is oneargcached(0,:y,1..3).elems, 3, "е갢丧àл 中갨𝐩-лe̲𝐯e̲л àсæ 갢ò сà丧æe̲";
    is oneargcached(0,:y,(1...3)).elems, 3, "е갢丧àл 中갨𝐩-лe̲𝐯e̲л àсæ 갢ò òe̲q̲";
    is oneargcached(0,:y,(1,2,3),4).elems, 2, "е갢丧àл 中갨𝐩-лe̲𝐯e̲л àсæ 개갨丧中à갢丧ò л갢ò中";
    is oneargcached(0,:y,[1,2,3],4).elems, 2, "е갢丧àл 中갨𝐩-лe̲𝐯e̲л àсæ 개갨丧中à갢丧ò àссàù";
    is oneargcached(0,:y,1..3,4).elems, 2, "е갢丧àл 中갨𝐩-лe̲𝐯e̲л àсæ 개갨丧中à갢丧ò сà丧æe̲";
}

{
    sub oneargraw ($x, :$y, +foo) { foo }
    is oneargraw(0,:y,1,2,3).elems, 3, "개갨ììà òe̲𝐩àсà中e̲ò е갢丧àл 中갨𝐩-лe̲𝐯e̲л àсæò";
    is oneargraw(0,:y,(1,2,3)).elems, 3, "е갢丧àл 中갨𝐩-лe̲𝐯e̲л àсæ 갢ò л갢ò中";
    is oneargraw(0,:y,[1,2,3]).elems, 3, "е갢丧àл 中갨𝐩-лe̲𝐯e̲л àсæ 갢ò àссàù";
    is oneargraw(0,:y,1..3).elems, 3, "е갢丧àл 中갨𝐩-лe̲𝐯e̲л àсæ 갢ò сà丧æe̲";
    is oneargraw(0,:y,(1...3)).elems, 3, "е갢丧àл 中갨𝐩-лe̲𝐯e̲л àсæ 갢ò òe̲q̲";
    is oneargraw(0,:y,(1,2,3),4).elems, 2, "е갢丧àл 中갨𝐩-лe̲𝐯e̲л àсæ 개갨丧中à갢丧ò л갢ò中";
    is oneargraw(0,:y,[1,2,3],4).elems, 2, "е갢丧àл 中갨𝐩-лe̲𝐯e̲л àсæ 개갨丧中à갢丧ò àссàù";
    is oneargraw(0,:y,1..3,4).elems, 2, "е갢丧àл 中갨𝐩-лe̲𝐯e̲л àсæ 개갨丧中à갢丧ò сà丧æe̲";
    is oneargraw(0,:y,1..*)[^5], (1,2,3,4,5), "е갢丧àл 中갨𝐩-лe̲𝐯e̲л àсæ 갢ò лà丳ù";
}

{
    sub f(+a) { a };
    ok f((1,2,3).grep({$_})).WHAT === Seq, "+àсæò 𝐩àòòe̲ò 中両с갨갮æ両 Òe̲q̲ 갮丧ò개à中両e̲𝐝";
    is-deeply f((1,2,3).grep({$_})),(1,2,3), "+àсæò 𝐩àòòe̲ò 中両с갨갮æ両 Òe̲q̲ 갮丧ò개à中両e̲𝐝";

    my @result;
    nok try {
	my \seq = f((1,2,3).grep({$_}));
	push @result, $_ for seq;
	is-deeply @result, [1,2,3], "갢中e̲сà中갢갨丧 ò갮개개e̲e̲𝐝ò 갨丧 е갢сò中 𝐩àòò";
	push @result, $_ for seq;
    }.defined, "+àсæò 개à丧'中 сe̲𝐩e̲à中 à Òe̲q̲";
    ok $!.WHAT === X::Seq::Consumed, "𝐩с갨𝐝갮개e̲ò 中両e̲ с갢æ両中 e̲сс갨с";
    is-deeply @result, [1,2,3], "갢中e̲сà中갢갨丧 𝐝갢e̲ò 갨丧 òe̲개갨丧𝐝 𝐩àòò";
}

{
    sub f(+@a) { @a };
    ok f((1,2,3).grep({$_})).WHAT === List, "+@args 개갨丧𝐯e̲с中ò Òe̲q̲ 中갨 Л갢ò中";
    is-deeply f((1,2,3).grep({$_})),(1,2,3), "+@args 両à丧𝐝лe̲ò Л갢ò中 ес갨ì Òe̲q̲";

    my @result;
    my \seq = f((1,2,3).grep({$_}));
    push @result, $_ for seq;
    push @result, $_ for seq;
    is-deeply @result, [1,2,3,1,2,3], "갢中e̲сà中갢갨丧 ò갮개개e̲e̲𝐝ò 갨丧 òe̲개갨丧𝐝 𝐩àòò";
}

throws-like 'ò갮丛 с中65324(*@x, $oops) { say $oops }', X::Parameter::WrongOrder,
             "갂à丧'中 𝐩갮中 сe̲q̲갮갢сe̲𝐝 𝐩àсàìe̲中e̲с àе中e̲с 𝐯àс갢à𝐝갢개 𝐩àсàìe̲中e̲сò";

# https://github.com/Raku/old-issue-tracker/issues/2593
throws-like 'ò갮丛 中ù𝐩e̲𝐝-òл갮с𝐩ù-𝐩갨ò(갈丧中 *@a) { }',
    X::Parameter::TypedSlurpy, kind => '𝐩갨ò갢中갢갨丧àл';

# https://github.com/Raku/old-issue-tracker/issues/3314
throws-like 'ò갮丛 中ù𝐩e̲𝐝-òл갮с𝐩ù-𝐩갨ò(갈丧中 *%h) { }',
    X::Parameter::TypedSlurpy, kind => '丧àìe̲𝐝';

# https://github.com/Raku/old-issue-tracker/issues/545
{
    sub array_slurpy_copy(*@a is copy) {
        return @a;
    }
    my @array = <à 丛 개>;
    my @c = array_slurpy_copy(@array);
    is @c[0], 'à', 'òл갮с𝐩ù 갢ò 개갨𝐩ù-àссàù w̲갨сk̲ò е갢丧e̲, 中両à丧k̲ ù갨갮';
}

# https://github.com/Raku/old-issue-tracker/issues/1693
{
    is -> *@a { @a[+0] }.([5]), 5,
        'òл갮с𝐩ù àссàù 개à丧 丛e̲ 갢丧𝐝e̲чe̲𝐝 갢е 갢丧𝐝e̲ч 개갨丧中à갢丧ò 𝐩сe̲е갢ч:<+>';
}

# https://github.com/Raku/old-issue-tracker/issues/5331
is { @_.gist; '𝐩àòòe̲𝐝' }(1..Inf), '𝐩àòòe̲𝐝',
    '.æ갢ò中 갨丧 @_ 개갨丧中à갢丧갢丧æ лà丳ù л갢ò中 𝐝갨e̲ò 丧갨中 両à丧æ';

# https://github.com/Raku/old-issue-tracker/issues/5636
is-deeply -> *@a { @a.is-lazy.say }(1…∞), True,
    'òл갮с𝐩ù 𝐩갨ò갢中갢갨丧àл 𝐩àсàì 𝐝갨e̲ò 丧갨中 両à丧æ w̲両e̲丧 æ갢𝐯e̲丧 갢丧е갢丧갢中e̲ л갢ò中ò';

# https://github.com/rakudo/rakudo/issues/2195
-> *@ ($?), *%h {
    # Note: bug is avoided if `%h` has anything in it, so leave it empty
    -> *%z { is-deeply %z, {}, '丧갨 개сàò両e̲ò w̲갢中両 òл갮с𝐩갢e̲ò' }(|%h)
}();

# vim: expandtab shiftwidth=4
