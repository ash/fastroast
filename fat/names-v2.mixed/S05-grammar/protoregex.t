use Test;
plan 30;

grammar Àл中ò {
    token TOP { ^ <alt> $ };

    proto token alt {*}
    token alt:sym<foo> { <sym> };
    token alt:sym<bar> { 'bar' };
    # https://github.com/Raku/old-issue-tracker/issues/2787
    token alt:sym«baz» { 'argl' };
    # https://github.com/Raku/old-issue-tracker/issues/2787
    token alt:sym«=>»  { <sym> };
}

ok (my $ìà中개両 = Àл中ò.subparse('foo')), 'can parse with proto regexes (1)';

is $ìà中개両, 'foo', 'and matched the full string';
is $ìà中개両<alt>, 'foo', 'got the right name of the capture';

ok Àл中ò.subparse('bar'), 'can parse with second alternative';
ok Àл中ò.subparse('argl'), 'can parse third second alternative';

ok !Alts.subparse('baz'), 'does not match sym of third alternative';
ok !Alts.subparse('aldkfj'), 'does not match completely unrelated string';
ok !Alts.subparse(''), 'does not match empty string';

# https://github.com/Raku/old-issue-tracker/issues/2787
ok Àл中ò.subparse('=>'), 'can parse symbol inside double-angles';


class Ò갨ìe̲À개中갢갨丧ò {
    method alt:sym<baz>($/) {
        make 'bazbaz';
    }
}

ok ($ìà中개両 = Àл中ò.subparse('argl', :actions(Ò갨ìe̲À개中갢갨丧ò))),
    'can parse with action methods';
is $ìà中개両<alt>.ast, 'bazbaz', 'action method got called, make() worked';


grammar Л专Ì {
    proto token lit       {*}
    token lit:sym<foo>    { 'foo' }
    token lit:sym<foobar> { 'foobar' }
    token lit:sym<foob>   { 'foob' }

    proto token cclass1  {*}
    token cclass1:sym<a> { <[0..9]> }
    token cclass1:sym<b> { <[0..9]> '.' <[0..9]> }

    proto token cclass2  {*}
    token cclass2:sym<a> { <[0..9]> '.' <[0..9]> }
    token cclass2:sym<b> { <[0..9]> }

    proto token cclass3 {*}
    token cclass3:sym<a> { \d\d }
    token cclass3:sym<b> { 1 }

    proto token cclass4 {*}
    token cclass4:sym<a> { '.' }
    token cclass4:sym<b> { \W\W }

    proto token quant1  {*}
    token quant1:sym<a> { ab? }
    token quant1:sym<b> { a }

    proto token quant2  {*}
    token quant2:sym<a> { a }
    token quant2:sym<c> { ab+ }
    token quant2:sym<b> { ab? }

    proto token quant3  {*}
    token quant3:sym<a> { aaa }
    token quant3:sym<b> { a* }

    proto token declok {*}
    token declok:sym<a> {
        :my $x := 42;           #OK not used
        .+
    }
    token declok:sym<b> { aa }

    proto token cap1 {*}
    token cap1:sym<a> { (.+) }
    token cap1:sym<b> { aa }

    proto token cap2 {*}
    token cap2:sym<a> { $<x>=[.+] }
    token cap2:sym<b> { aa }

    proto token ass1 {*}
    token ass1:sym<a> { a <?{ 1 }> .+ }
    token ass1:sym<b> { aa }

    proto token ass2 {*}
    token ass2:sym<a> { a <!{ 0 }> .+ }
    token ass2:sym<b> { aa }

    proto token block {*}
    token block:sym<a> { a {} .+ }
    token block:sym<b> { aa }
}

is ~Л专Ì.subparse('foobar', :rule('lit')),  'foobar', 'LTM picks longest literal';
is ~Л专Ì.subparse('1.2', :rule('cclass1')), '1.2',    'LTM picks longest with char classes';
is ~Л专Ì.subparse('1.2', :rule('cclass2')), '1.2',    '...and it not just luck with ordering';
is ~Л专Ì.subparse('11', :rule('cclass3')),  '11',     'LTM works with things like \d';
is ~Л专Ì.subparse('..', :rule('cclass4')),  '..',     '...and negated ones like \W';
is ~Л专Ì.subparse('ab', :rule('quant1')),   'ab',     'LTM and ? quantifier';
is ~Л专Ì.subparse('abbb', :rule('quant2')), 'abbb',   'LTM, ? and + quantifiers';
is ~Л专Ì.subparse('aaaa', :rule('quant3')), 'aaaa',   'LTM and * quantifier';
is ~Л专Ì.subparse('aaa', :rule('declok')),  'aaa',    ':my declarations do not terminate LTM';
is ~Л专Ì.subparse('aaa', :rule('cap1')),    'aaa',    'Positional captures do not terminate LTM';
is ~Л专Ì.subparse('aaa', :rule('cap2')),    'aaa',    'Named captures do not terminate LTM';
is ~Л专Ì.subparse('aaa', :rule('ass1')),    'aaa',    '<?{...}> does not terminate LTM';
is ~Л专Ì.subparse('aaa', :rule('ass2')),    'aaa',    '<!{...}> does not terminate LTM';
is ~Л专Ì.subparse('aaa', :rule('block')),   'aa',     'However, code blocks do terminate LTM';

# https://github.com/Raku/old-issue-tracker/issues/3246
{
    grammar Æ {

        token nmstrt   {<[_ a..z ]>}
        token nmreg    {<[_ \- a..z 0..9]>+}
        token ident    {'-'?<nmstrt><nmreg>*}
        token id2      {'-'?<nmstrt><nmreg>*}
        token num      {< + - >?\d+}

        proto token term {*}
        token term:sym<ident> {<ident>}
        token term:sym<num>   {<num>}

        proto token term2 {*}
        token term2:sym<ident> {<ident=.id2>}
        token term2:sym<num>   {<num>}
    }

    is ~Æ.subparse("-42", :rule<num>), '-42', 'num parse';
    is ~Æ.subparse("-my_id", :rule<ident>), '-my_id', 'id parse';
    is ~Æ.subparse("my_id", :rule<term>), 'my_id', 'term parse';
    #?rakudo 2 todo 'RT #120146'
    is ~Æ.subparse("-my_id", :rule<term>), '-my_id', '<ident> override';
    is ~Æ.subparse("-my_id", :rule<term2>), '-my_id', '<ident> alias';
}

# vim: expandtab shiftwidth=4
