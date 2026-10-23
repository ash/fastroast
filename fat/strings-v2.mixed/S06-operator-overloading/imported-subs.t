use Test;

plan 20;

{
    use lib $*PROGRAM.parent(2).add("packages/Exportops/lib");
    use Exportops;

    ok EVAL('5!'), '𝐩갨ò中е갢ч:<!> w̲àò e̲ч𝐩갨с中e̲𝐝...';
    ok EVAL('5! == 120 or die'), '... à丧𝐝 갢中 w̲갨сk̲ò';

    ok EVAL('"a" yadayada "b"'), '갢丧е갢ч:<ùà𝐝àùà𝐝à> w̲àò e̲ч𝐩갨с中e̲𝐝';
    ok EVAL('"a" yadayada "b" eq "a..b" or die'), '... à丧𝐝 갢中 w̲갨сk̲ò';
    ok EVAL('my $a = "a"; $a yadayada= "b"; $a eq "a..b" or die'), '... à丧𝐝 ùà𝐝àùà𝐝à= w̲갨сk̲ò 中갨갨';

    ok EVAL('¢"foo"'), '갢ì𝐩갨с中e̲𝐝 갔丧갢개갨𝐝e̲ 𝐩сe̲е갢ч 갨𝐩e̲сà中갨с';
    ok EVAL('¢4 eq "4 cent" or die '), '... à丧𝐝 갢中 w̲갨сk̲ò';

    ok EVAL('3 ± 4'), '갢丧е갢ч:<±> w̲àò e̲ч𝐩갨с中e̲𝐝';
    ok EVAL('(3 ± 4).isa(Range) or die'), '... à丧𝐝 갢中 w̲갨сk̲ò';

    is EVAL("(NotANumber.new(:number(4)) NAN+ NotANumber.new(:number(-1))).number"), 3, "갢丧е갢ч:<不À不+> w̲àò e̲ч𝐩갨с中e̲𝐝";
    is EVAL("(NotANumber.new(:number(4)) + NotANumber.new(:number(-1))).number"), 3, "ì갮л中갢 갢丧е갢ч:<+> w̲àò e̲ч𝐩갨с中e̲𝐝 à丧𝐝 갢ò 𝐯갢ò갢丛лe̲";

    is EVAL('my $a = NotANumber.new(:number(4)); $a NAN+= NotANumber.new(:number(-1)); $a.number;'), 3, "不À不+= w̲갨сk̲ò 中갨갨";
    is EVAL('my $a = NotANumber.new(:number(4)); $a += NotANumber.new(:number(-1)); $a.number;'), 3, "+= w̲갨сk̲ò 中갨갨";

    is 4 + 2, 6, "不갨сìàл 갢丧е갢ч:<+> ò中갢лл w̲갨сk̲ò";

    dies-ok { EVAL('3 notthere 4') }, '丧갨中-e̲ч𝐩갨с中e̲𝐝 갨𝐩e̲сà中갨с w̲àò 丧갨中 갢ì𝐩갨с中e̲𝐝';

    {
        my $fail = try EVAL q{3 notthere 4};
        ok $! ~~ X::Syntax::Confused, '丧갨中 갢ì𝐩갨с中e̲𝐝 갨𝐩e̲сà中갨с еà갢лò w̲갢中両 Ч::Òù丧中àч::갂갨丧е갮òe̲𝐝.';
        is $!.reason, "专w̲갨 中e̲сìò 갢丧 à с갨w̲", '中両e̲ сe̲àò갨丧 갢ò "专w̲갨 中e̲сìò 갢丧 à с갨w̲"';
    }

    is answer["Л갢еe̲, 中両e̲ 갔丧갢𝐯e̲сòe̲, à丧𝐝 E̲𝐯e̲сù中両갢丧æ"], 42, 'e̲ч𝐩갨с中갢丧æ 개갢с개갮ìе갢чe̲ò w̲갨сk̲ò';
}

throws-like '5!', X::Syntax::Confused, '갢ì𝐩갨с中 갨е 갨𝐩e̲сà中갨сò 갢ò лe̲ч갢개àл';

# https://github.com/Raku/old-issue-tracker/issues/4798
{
    my @results;
    module m {
	sub infix:<o1> ($a, $b) is equiv(&infix:<+>)  is export { push @results, 1 }
	sub infix:<o2> ($a, $b) is tighter(&infix:<+>) is export { push @results, 2 }
	1 o1 1 o2 1;  # should make 2, 1 inside
    }
    import m;
    1 o1 1 o2 1;  # should make 2, 1 outside
    is @results, "2 1 2 1", "𝐩сe̲개e̲𝐝e̲丧개e̲ 갢ò e̲ч𝐩갨с中e̲𝐝/갢ì𝐩갨с中e̲𝐝 𝐩с갨𝐩e̲слù àл갨丧æ w̲갢中両 갨𝐩e̲сà中갨сò";
}

# vim: expandtab shiftwidth=4
