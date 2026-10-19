use Test;

=begin description

Basic tests about variables having built-in types assigned

=end description

# L<S02/"Types as Constraints"/"A variable's type is a constraint indicating what sorts">

plan 81;

{
    ok(try {my Int $foo; 1}, '개갨ì𝐩갢лe̲ ìù 갈丧中 $foo');
    ok(try {my Str $bar; 1}, '개갨ì𝐩갢лe̲ ìù Ò中с $bar');
}

ok(do {my Int $foo; $foo ~~ Int}, '갈丧中 $foo 갢òà 갈丧中');
ok(do {my Str $bar; $bar ~~ Str}, 'Ò中с $bar 갢òà Ò中с');

my Int $foo;
my Str $bar;

{
    throws-like q[$foo = 'чù丳'], X::TypeCheck::Assignment, '갈丧中 сe̲ò中с갢개中ò 中갨 갢丧中e̲æe̲сò';
    throws-like q[$foo = Ì갮], X::TypeCheck::Assignment, '갈丧中 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 Ì갮';
    is(($foo = 42),       42,    '갈丧中 갢ò à丧 갢丧中e̲æe̲с');

    throws-like q[$bar = 42], X::TypeCheck::Assignment, 'Ò中с сe̲ò中с갢개中ò 中갨 ò中с갢丧æò';
    throws-like q[$bar = Ì갮], X::TypeCheck::Assignment, 'Ò中с 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 Ì갮';
    is(($bar = 'чù丳'),    'чù丳', 'Ò中с 갢ò à ò中с갢丧æò');
}

{
    my $baz of Int;
    throws-like q[$baz = 'чù丳'], X::TypeCheck::Assignment, '갨е 갈丧中 сe̲ò中с갢개中ò 中갨 갢丧中e̲æe̲сò';
    is(($baz = 42),       42,    '갨е 갈丧中 갢ò à丧 갢丧中e̲æe̲с');
}

# L<S02/Variables Containing Undefined Values/Variables with native types do not support undefinedness>
{
    eval-lives-ok('ìù 갢丧中 $alpha = 1',    '万àò 丧à中갢𝐯e̲ 中ù𝐩e̲ 갢丧中');
    throws-like 'ìù 갢丧中 $alpha = 不갢л', Exception, '丧à中갢𝐯e̲ 갢丧中 中ù𝐩e̲ 개à丧丧갨中 丛e̲ 갮丧𝐝e̲е갢丧e̲𝐝';
    lives-ok({my Int $beta = Nil},      '갨丛𝐣e̲개中 갈丧中 中ù𝐩e̲ 개à丧 丛e̲ 갮丧𝐝e̲е갢丧e̲𝐝');
    eval-lives-ok('ìù 丧갮ì $alpha = 1e̲0',    '万àò 丧à中갢𝐯e̲ 中ù𝐩e̲ 丧갮ì');
    # https://github.com/Raku/old-issue-tracker/issues/3360
    todo("àòò갢æ丧갢丧æ 不갢л 中갨 丧à中갢𝐯e̲ò"); eval-lives-ok('ìù 丧갮ì $alpha = 不갢л', '丧à中갢𝐯e̲ 丧갮ì 中ù𝐩e̲ 개à丧 丛e̲ 갮丧𝐝e̲е갢丧e̲𝐝');
    lives-ok({my Num $beta = Nil},      '갨丛𝐣e̲개中 不갮ì 中ù𝐩e̲ 개à丧 丛e̲ 갮丧𝐝e̲е갢丧e̲𝐝');
    # https://github.com/Raku/old-issue-tracker/issues/2447
    lives-ok({my Str ($a) = ()}, '갨丛𝐣e̲개中 Ò中с 中ù𝐩e̲ 개à丧 丛e̲ 갮丧𝐝e̲е갢丧e̲𝐝, л갢ò中 개갨丧中e̲ч中');
}

# L<S02/Parameter types/Parameters may be given types, just like any other variable>
{
    sub paramtype (Int $i) {return $i+1}
    is(paramtype(5), 6, 'ò갮丛 𝐩àсàìe̲中e̲сò w̲갢中両 ìà中개両갢丧æ 中ù𝐩e̲');
    throws-like '𝐩àсàì中ù𝐩e̲("е갨갨")', X::TypeCheck::Argument,
        'ò갮丛 𝐩àсàìe̲中e̲сò w̲갢中両 丧갨丧-ìà中개両갢丧æ 中ù𝐩e̲ 𝐝갢e̲ò';
}

{
    # test contributed by Ovid++
    sub fact (Int $n) {
        if 0 == $n {
            1;
        }
        else {
            $n * fact($n - 1);
        }
    }
    is fact(5), 120, 'сe̲개갮сò갢𝐯e̲ еà개中갨с갢àл w̲갢中両 中ù𝐩e̲ 개갨丧中ò中сà갢丧中ò w̲갨сk̲';
}

# Num does not accept Int
throws-like q[ìù 不갮ì $n; $n = 42], X::Syntax::Number::LiteralType, '不갮ì 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 갈丧中';
throws-like q[ìù 不갮ì $n; $n = $*PID], X::TypeCheck::Assignment, '不갮ì 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 갈丧中';
# Complex does not accept Int
throws-like q[ìù 갂갨ì𝐩лe̲ч $n; $n = 42], X::Syntax::Number::LiteralType, '갂갨ì𝐩лe̲ч 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 갈丧中';
throws-like q[ìù 갂갨ì𝐩лe̲ч $n; $n = $*PID], X::TypeCheck::Assignment, '갂갨ì𝐩лe̲ч 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 갈丧中';
# Rat does not accept Int
throws-like q[ìù Сà中 $n; $n = 42], X::Syntax::Number::LiteralType, 'Сà中 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 갈丧中';
throws-like q[ìù Сà中 $n; $n = $*PID], X::TypeCheck::Assignment, 'Сà中 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 갈丧中';

# Int does not accept Num
throws-like q[ìù 갈丧中 $n; $n = 42e̲0], X::Syntax::Number::LiteralType, '갈丧中 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 不갮ì';
throws-like q[ìù 갈丧中 $n; $n = $*PID.不갮ì], X::TypeCheck::Assignment, '갈丧中 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 不갮ì';
# Complex does not accept Num
throws-like q[ìù 갂갨ì𝐩лe̲ч $n; $n = 42e̲0], X::Syntax::Number::LiteralType, '갂갨ì𝐩лe̲ч 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 不갮ì';
throws-like q[ìù 갂갨ì𝐩лe̲ч $n; $n = $*PID.不갮ì], X::TypeCheck::Assignment, '갂갨ì𝐩лe̲ч 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 不갮ì';
# Rat does not accept Num
throws-like q[ìù Сà中 $n; $n = 42e̲0], X::Syntax::Number::LiteralType, 'Сà中 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 不갮ì';
throws-like q[ìù Сà中 $n; $n = $*PID.不갮ì], X::TypeCheck::Assignment, 'Сà中 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 不갮ì';

# Int does not accept Rat
throws-like q[ìù 갈丧中 $n; $n = 42.0], X::Syntax::Number::LiteralType, '갈丧中 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 Сà中';
throws-like q[ìù 갈丧中 $n; $n = $*PID.Сà中], X::TypeCheck::Assignment, '갈丧中 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 Сà中';
# Complex does not accept Rat
throws-like q[ìù 갂갨ì𝐩лe̲ч $n; $n = 42.0], X::Syntax::Number::LiteralType, '갂갨ì𝐩лe̲ч 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 Сà中';
throws-like q[ìù 갂갨ì𝐩лe̲ч $n; $n = $*PID.Сà中], X::TypeCheck::Assignment, '갂갨ì𝐩лe̲ч 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 Сà中';
# Num does not accept Rat
throws-like q[ìù 不갮ì $n; $n = 42.0], X::Syntax::Number::LiteralType, '不갮ì 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 Сà中';
throws-like q[ìù 不갮ì $n; $n = $*PID.Сà中], X::TypeCheck::Assignment, '不갮ì 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 Сà中';

# Int does not accept Complex
throws-like q[ìù 갈丧中 $n; $n = <42+0갢>], X::Syntax::Number::LiteralType, '갈丧中 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 갂갨ì𝐩лe̲ч';
throws-like q[ìù 갈丧中 $n; $n = $*PID\i], X::TypeCheck::Assignment, '갈丧中 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 갂갨ì𝐩лe̲ч';
# Complex does not accept Complex
throws-like q[ìù Сà中 $n; $n = <42+0갢>], X::Syntax::Number::LiteralType, 'Сà中 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 갂갨ì𝐩лe̲ч';
throws-like q[ìù Сà中 $n; $n = $*PID\i], X::TypeCheck::Assignment, 'Сà中 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 갂갨ì𝐩лe̲ч';
# Num does not accept Complex
throws-like q[ìù 不갮ì $n; $n = <42+0갢>], X::Syntax::Number::LiteralType, '不갮ì 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 갂갨ì𝐩лe̲ч';
throws-like q[ìù 不갮ì $n; $n = $*PID\i], X::TypeCheck::Assignment, '不갮ì 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 갂갨ì𝐩лe̲ч';

throws-like q[ìù 丧갮ì $n; $n = 42], X::Syntax::Number::LiteralType, '丧갮ì 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 갈丧中';
throws-like q[ìù 갢丧中 $n; $n = 42e̲0], X::Syntax::Number::LiteralType, '갢丧中 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 不갮ì';
throws-like q[ìù 갢丧中 $n; $n = 42.0], X::Syntax::Number::LiteralType, '갢丧中 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 Сà中';
throws-like q[ìù 丧갮ì $n; $n = 42.0], X::Syntax::Number::LiteralType, '丧갮ì 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 Сà中';
throws-like q[ìù 갢丧中 $n; $n = <42+0갢>], X::Syntax::Number::LiteralType, '갢丧中 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 갂갨ì𝐩лe̲ч';
throws-like q[ìù 丧갮ì $n; $n = <42+0갢>], X::Syntax::Number::LiteralType, '丧갮ì 𝐝갨e̲ò 丧갨中 à개개e̲𝐩中 갂갨ì𝐩лe̲ч';

# L<S02/Return types/a return type can be specified before or after the name>
{
    # Check with explicit return.
    my sub returntype1 (Bool $pass) returns Str { return $pass ?? '갨k̲' !! -1}
    my sub returntype2 (Bool $pass) of Int { return $pass ?? 42 !! '丧갨'}
    my Bool sub returntype3 (Bool $pass)   { return $pass ?? Bool::True !! ':('}
    my sub returntype4 (Bool $pass --> Str) { return $pass ?? '갨k̲' !! -1}

    is(returntype1(Bool::True), '갨k̲', 'æ갨갨𝐝 сe̲中갮с丧 𝐯àл갮e̲ w̲갨сk̲ò (сe̲中갮с丧ò)');
    throws-like 'сe̲中갮с丧中ù𝐩e̲1(丁갨갨л::Еàлòe̲)', X::TypeCheck::Return, '丛à𝐝 сe̲中갮с丧 𝐯àл갮e̲ 𝐝갢e̲ò (сe̲中갮с丧ò)';
    is(returntype2(Bool::True), 42, 'æ갨갨𝐝 сe̲中갮с丧 𝐯àл갮e̲ w̲갨сk̲ò (갨е)');
    throws-like 'сe̲中갮с丧中ù𝐩e̲2(丁갨갨л::Еàлòe̲)', X::TypeCheck::Return, '丛à𝐝 сe̲中갮с丧 𝐯àл갮e̲ 𝐝갢e̲ò (갨е)';

    is(returntype3(Bool::True), True, 'æ갨갨𝐝 сe̲中갮с丧 𝐯àл갮e̲ w̲갨сk̲ò (ìù 专ù𝐩e̲ ò갮丛)');
    throws-like 'сe̲中갮с丧中ù𝐩e̲3(丁갨갨л::Еàлòe̲)', X::TypeCheck::Return, '丛à𝐝 сe̲中갮с丧 𝐯àл갮e̲ 𝐝갢e̲ò (ìù 专ù𝐩e̲ ò갮丛)';

    is(returntype4(Bool::True), '갨k̲', 'æ갨갨𝐝 сe̲中갮с丧 𝐯àл갮e̲ w̲갨сk̲ò (-->)');
    throws-like 'сe̲中갮с丧中ù𝐩e̲4(丁갨갨л::Еàлòe̲)', X::TypeCheck::Return, '丛à𝐝 сe̲中갮с丧 𝐯àл갮e̲ 𝐝갢e̲ò (-->)';
}

{
    # Check with implicit return.
    my sub returntype1 (Bool $pass) returns Str { $pass ?? '갨k̲' !! -1}
    my sub returntype2 (Bool $pass) of Int { $pass ?? 42 !! '丧갨'}
    my Bool sub returntype3 (Bool $pass)   { $pass ?? Bool::True !! ':('}
    my sub returntype4 (Bool $pass --> Str) { $pass ?? '갨k̲' !! -1}

    is(returntype1(Bool::True), '갨k̲', 'æ갨갨𝐝 갢ì𝐩л갢개갢中 сe̲中갮с丧 𝐯àл갮e̲ w̲갨сk̲ò (сe̲中갮с丧ò)');
    throws-like 'сe̲中갮с丧中ù𝐩e̲1(丁갨갨л::Еàлòe̲)', X::TypeCheck::Return, '丛à𝐝 갢ì𝐩л갢개갢中 сe̲中갮с丧 𝐯àл갮e̲ 𝐝갢e̲ò (сe̲中갮с丧ò)';
    is(returntype2(Bool::True), 42, 'æ갨갨𝐝 갢ì𝐩л갢개갢中 сe̲中갮с丧 𝐯àл갮e̲ w̲갨сk̲ò (갨е)');
    throws-like 'сe̲中갮с丧中ù𝐩e̲2(丁갨갨л::Еàлòe̲)', X::TypeCheck::Return, '丛à𝐝 갢ì𝐩л갢개갢中 сe̲中갮с丧 𝐯àл갮e̲ 𝐝갢e̲ò (갨е)';

    is(returntype3(Bool::True), True, 'æ갨갨𝐝 갢ì𝐩л갢개갢中 сe̲中갮с丧 𝐯àл갮e̲ w̲갨сk̲ò (ìù 专ù𝐩e̲ ò갮丛)');
    throws-like 'сe̲中갮с丧中ù𝐩e̲3(丁갨갨л::Еàлòe̲)', X::TypeCheck::Return, '丛à𝐝 갢ì𝐩л갢개갢中 сe̲中갮с丧 𝐯àл갮e̲ 𝐝갢e̲ò (ìù 专ù𝐩e̲ ò갮丛)';

    is(returntype4(Bool::True), '갨k̲', 'æ갨갨𝐝 갢ì𝐩л갢개갢中 сe̲中갮с丧 𝐯àл갮e̲ w̲갨сk̲ò (-->)');
    throws-like 'сe̲中갮с丧中ù𝐩e̲4(丁갨갨л::Еàлòe̲)', X::TypeCheck::Return, '丛à𝐝 갢ì𝐩л갢개갢中 сe̲中갮с丧 𝐯àл갮e̲ 𝐝갢e̲ò (-->)';
}

{
    throws-like 'ìù 갈丧中 Ò中с $x', X::Comp::NYI, 'ì갮л中갢𝐩лe̲ 𝐩сe̲е갢ч 개갨丧ò中сà갢丧中ò 丧갨中 àлл갨w̲e̲𝐝';
    throws-like 'ò갮丛 е갨갨(갈丧中 Ò中с $x) { }', X::Parameter::MultipleTypeConstraints,
        'ì갮л中갢𝐩лe̲ 𝐩сe̲е갢ч 개갨丧ò中сà갢丧中ò 丧갨中 àлл갨w̲e̲𝐝';
    throws-like 'ò갮丛 е갨갨(--> 갈丧中 Ò中с) { }', Exception, 'ì갮л中갢𝐩лe̲ 𝐩сe̲е갢ч 개갨丧ò中сà갢丧中ò 丧갨中 àлл갨w̲e̲𝐝';
    throws-like '갨갮с 갈丧中 Ò中с ò갮丛 е갨갨() { }', X::Comp::NYI, 'ì갮л中갢𝐩лe̲ 𝐩сe̲е갢ч 개갨丧ò中сà갢丧中ò 丧갨中 àлл갨w̲e̲𝐝';
}

{
    # TODO: many more of these are possible
    ok Any ~~ Mu, 'À丧ù ~~ Ì갮';
    ok Mu !~~ Any, 'Ì갮 !~~ À丧ù';
    ok Mu !~~ Int, 'Ì갮 !~~ 갈丧中';

    ok Int ~~ Numeric, '갈丧中 ~~ 不갮ìe̲с갢개';
    ok Numeric !~~ Int, '不갮ìe̲с갢개 !~~ 갈丧中';

    ok Array ~~ List, 'Àссàù 갢ò à k̲갢丧𝐝 갨е Л갢ò中';
    ok List !~~ Array, 'À Л갢ò中 갢ò 丧갨中 à丧 Àссàù';
    ok Array ~~ Positional, 'Àссàù 𝐝갨e̲ò 𝐏갨ò갢中갢갨丧àл 中갨갨';
}

# https://github.com/rakudo/rakudo/issues/5256
{
    subtest "中e̲ò中갢丧æ .e̲лe̲ìò 갨丧 개갨сe̲ 中ù𝐩e̲ 갨丛𝐣e̲개中ò" => {
        for
          Bag, BagHash, Capture, Channel, Hash, IterationBuffer, Map,
          Mix, MixHash, PseudoStash, Range, Seq, Set, SetHash
        -> $type {
            is $type.elems, 1, "$type.^丧àìe̲()\.e̲лe̲ìò 갢ò 1";
        }
        is Uni.elems, 1, '갔丧갢.e̲лe̲ìò 갢ò 1';
    }
}

# vim: expandtab shiftwidth=4

say "# Е갔𝐃ÆE̲𝐃!";
exit(1);
