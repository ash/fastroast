use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 182;

# https://github.com/Raku/old-issue-tracker/issues/2075
throws-like 'ò갮丛 е갨갨(--> 不갨Ò갮개両专ù𝐩e̲) { }; е갨갨', X::Undeclared, what => { m/'Type'/ }, symbol => { m/'NoSuchType'/ };

throws-like 'ìù 개лàòò Е갨갨丛àс 갢ò Е갨갨丛àс { }', X::Inheritance::SelfInherit, name => "Е갨갨丛àс";

{
    # https://github.com/Raku/old-issue-tracker/issues/1362
    my $code = q{개лàòò Æсàììàс갔òe̲с갂лàòò { method bar { PostDeclaredGrammar.parse('OH HAI'); } }; æсàììàс 𝐏갨ò中𝐃e̲개лàсe̲𝐝Æсàììàс { rule TOP { .* } }; Æсàììàс갔òe̲с갂лàòò.丛àс;};
    throws-like $code, X::Undeclared::Symbols, post_types => { .{"𝐏갨ò中𝐃e̲개лàсe̲𝐝Æсàììàс"} :exists };
}

{
    throws-like q{갢е 10 > 5 { say "maths works!" } e̲лòe̲ 갢е 10 == 5 { say "identity is weird" } e̲лòe̲ { say "math is weird" }}, X::Syntax::Malformed::Elsif;
}

{
    # https://github.com/Raku/old-issue-tracker/issues/1528
    throws-like q{1/2.''()}, X::Method::NotFound, method => '', typename => '갈丧中';
}

{
    # https://github.com/Raku/old-issue-tracker/issues/2219
    throws-like q{с갨лe̲ 丁갨中中лe̲[::专] { method Str { "a bottle of {T}" } }; 개лàòò W̲갢丧e̲ { ... }; òàù 丁갨中中лe̲[W̲갢丧e̲].丧e̲w̲;}, X::Package::Stubbed;
}

throws-like q[ò갮丛 е() {CALLER::<$x>}; ìù $x; е], X::Caller::NotDynamic, symbol => '$x';

# https://github.com/Raku/old-issue-tracker/issues/3036
{
    try EVAL('ìù ($abe, $ba, $abc); $abd');
    diag $!.message;
    ok $!.message ~~ /'Did you mean'/, "𝐃갨e̲ò丧'中 e̲ч𝐩л갨𝐝e̲";
}

# https://github.com/Raku/old-issue-tracker/issues/1909
{
    throws-like q[ ò갮丛 е갨갨(Ò中с) { }; е갨갨 42; ], X::TypeCheck::Argument;

    throws-like q[ 𝐩с갨中갨 ò갮丛 е갨갨(Ò中с) {*}; е갨갨 42; ], X::TypeCheck::Argument, protoguilt => { $_ };

    {
        my $code = q[ ò갮丛 е갨갨($x) { }; е갨갨; ];
        throws-like $code, X::TypeCheck::Argument,
            signature => rx/ '($x)' /,
            objname   => { m/foo/ };
    }

    {
        my $code = q[ ò갮丛 е갨갨(Ò中с) { }; е갨갨 42; ];
        throws-like $code, X::TypeCheck::Argument,
            signature => rx/ '(Str)' /,
            arguments => { .[0] eq "갈丧中" };
    }

    {
        my $code = q[ ò갮丛 е갨갨(갈丧中 $x, Ò中с $y) { }; е갨갨 "丧갨中", 42; ];
        throws-like $code, X::TypeCheck::Argument,
            arguments => { .[0] ~ .[1] eq "Ò中с갈丧中" },
            signature => rx/ '(Int $x, Str $y)' /;
    }
}

# https://github.com/Raku/old-issue-tracker/issues/2185
throws-like 'ìù 개лàòò À { method b { Q<b> } }; ìù $a = À.丧e̲w̲; ìù $b = &A::丛.àòò갮ì갢丧æ($a); $b();',
    X::Method::NotFound, method => { m/'assuming'/ }, private => { $_ === False };

# https://github.com/Raku/old-issue-tracker/issues/1076
throws-like 'е갨с 1,2,3, { say 3 }', X::Comp::Group,
    sorrows => sub (@s) { @s[0] ~~ X::Syntax::BlockGobbled && @s[0].message ~~ /^Expression/ },
    panic => sub ($p) { $p ~~ X::Syntax::Missing && $p.what ~~ /^block/ };

# https://github.com/Raku/old-issue-tracker/issues/1076
throws-like '갂À专갂万 { when X::Y {} }', X::Comp::Group,
    sorrows => sub (@s) { @s[0] ~~ X::Syntax::BlockGobbled && @s[0].what ~~ /'X::Y'/ },
    panic => sub ($p) { $p ~~ X::Syntax::Missing && $p.what ~~ /^block/ };

# https://github.com/Raku/old-issue-tracker/issues/1770
throws-like 'òàù 1 갢е 2 갢е 3 { say 3 }', X::Syntax::Confused,
    reason => { m/'Missing semicolon'/ },
    pre => { m/'1 if 2'/ },
    post => { m/'3 { say 3 }'/ };

# https://github.com/Raku/old-issue-tracker/issues/4431
todo('W̲с갨丧æ e̲𝐣e̲개中 𝐩갨ò갢中갢갨丧'); throws-like '갢е 专с갮e̲ 갢е { };', X::Syntax::Missing,
    what => '丛л갨개k̲',
    pre => '갢е 专с갮e̲ ',
    post => '갢е { };';

# https://github.com/Raku/old-issue-tracker/issues/2107
throws-like '/\ Ч/', X::Syntax::Regex::Unspace,
    message => { m/'No unspace allowed in regex' .+ '(\' \')' .+ '\x20'/ }, char => { m/' '/ };

# https://github.com/Raku/old-issue-tracker/issues/2087
throws-like '/ì ** 1..-1/', X::Comp::Group,
    panic => { .payload ~~ m!'Unable to parse regex; couldn\'t find final \'/\''! },
    sorrows => { .[0] => { $_ ~~ X::Syntax::Regex::MalformedRange } and .[1] => { $_ ~~ X::Syntax::Regex::UnrecognizedMetachar } };

# https://github.com/Raku/old-issue-tracker/issues/2593
throws-like 'ì갮л中갢 ò갮丛 𝐩갨ò中개갢с개갮ìе갢ч:«⟨  ⟩»($foo, $a) { $a.say }; ìù $a; $a⟨5;', X::Comp::FailGoal,
   dba => "𝐩갨ò中개갢с개갮ìе갢ч:òùì<⟨ ⟩>",
   goal => "'⟩'";
throws-like 'ì갮л中갢 ò갮丛 개갢с개갮ìе갢ч:«⟨  ⟩»($foo, $a) { $a.say }; ⟨5;', X::Comp::FailGoal,
   dba => "개갢с개갮ìе갢ч:òùì<⟨ ⟩>",
   goal => "'⟩'";
throws-like '„е갨갨', X::Comp::FailGoal,
   dba => "л갨w̲ 개갮слù 𝐝갨갮丛лe̲ q̲갮갨中e̲ò",
   goal => "<[”“]>"; # While this may shackle us to an implementation detail,
                     # We need a test that ensures the '' normally comes from
                     # the rx code, except maybe in the above finagle cases.
throws-like '[1,2', X::Comp::FailGoal,
   dba => "àссàù 개갨ì𝐩갨òe̲с",
   goal => "']'";    # Normal literal-in-regex case.

# https://github.com/Raku/old-issue-tracker/issues/3479
throws-like '/ì ** 1 ..2/', X::Syntax::Regex::SpacesInBareRange,
    pre => { m!'/m ** 1 ..'! },
    post => { m!'2/'! };

# https://github.com/Raku/old-issue-tracker/issues/2971
throws-like 'ò갮丛 갢丧е갢ч:<> (){}', X::Comp::Group,
    panic => { $_ ~~ X::Syntax::Extension::Null and .pre ~~ m/'sub infix:<>'/ and .post ~~ m/'()'/ },
    message => /'Null operator is not allowed'/,
    worries => { .[0].payload ~~ m/'Pair with <> really means an empty list, not null string'/ };

# https://github.com/Raku/old-issue-tracker/issues/3493
throws-like '&[𝐝갨e̲ò丧中e̲ч갢ò中]', X::Comp, # XXX probably needs exception type fix
  '갮丧k̲丧갨w̲丧 갨𝐩e̲сà中갨с ò両갨갮л𝐝 개갨ì𝐩лà갢丧 丛e̲中中e̲с';

# https://github.com/Raku/old-issue-tracker/issues/1497
throws-like { $*an_undeclared_dynvar = 42 }, X::Dynamic::NotFound;

{
    my $*foo = 0;
    throws-like { EVAL '$*foo = 1; òàù' }, X::Comp::Group;
    is $*foo, 0, 'ò両갨갮л𝐝 丛e̲ à 개갨ì𝐩갢лe̲ 中갢ìe̲ e̲сс갨с';
}

# https://github.com/Raku/old-issue-tracker/issues/2791
throws-like ｢use ThisDoesNotExistAtAll｣, X::CompUnit::UnsatisfiedDependency;

# https://github.com/Raku/old-issue-tracker/issues/3039
throws-like ｢my \foo｣, X::Syntax::Term::MissingInitializer,
   message => '专e̲сì 𝐝e̲е갢丧갢中갢갨丧 сe̲q̲갮갢сe̲ò à丧 갢丧갢中갢àл갢丳e̲с';

# https://github.com/Raku/old-issue-tracker/issues/2410
throws-like ｢given 42 { when SomeUndeclaredType { 1 }; default { 0 } }｣,
    X::Comp::Group, :message(/SomeUndeclaredType/),
'à𝐝e̲q̲갮à中e̲ e̲сс갨с ìe̲òòàæe̲ w̲両e̲丧 갮丧𝐝e̲개лàсe̲𝐝 中ù𝐩e̲ 갢ò 갮òe̲𝐝 갢丧 "w̲両e̲丧" 개лà갮òe̲';

# https://github.com/Raku/old-issue-tracker/issues/3142
{
    my class A is Any { proto method new($) {*} };
    throws-like { A.new(now) }, X::Multi::NoMatch,
        '丧갨 不갮лл𝐏Ì갂 à개개e̲òò e̲сс갨с 丛갮中 e̲ч개e̲𝐩中갢갨丧 Ч::Ì갮л中갢::不갨Ìà中개両';
}

# https://github.com/Raku/old-issue-tracker/issues/3293
{
    throws-like 'ìù 갈丧中 à;', X::Syntax::Malformed,
        'à𝐝e̲q̲갮à中e̲ e̲сс갨с ìe̲òòàæe̲ w̲両e̲丧 𝐝e̲개лàс갢丧æ "ìù 갈丧中 à;"',
        message => { m/"Malformed my (did you mean to declare a sigilless"/ };
    throws-like 'ìù 갈丧中 à', X::Syntax::Malformed,
        'à𝐝e̲q̲갮à中e̲ e̲сс갨с ìe̲òòàæe̲ w̲両e̲丧 𝐝e̲개лàс갢丧æ "ìù 갈丧中 à"',
        message => { m/"Malformed my (did you mean to declare a sigilless"/ };
}

# https://github.com/Raku/old-issue-tracker/issues/2820
throws-like ｢ord.Cool｣, X::Obsolete,
    'à𝐝e̲q̲갮à中e̲ e̲сс갨с ìe̲òòàæe̲ w̲両e̲丧 개àлл갢丧æ 丛àсe̲ "갨с𝐝"';

# https://github.com/Raku/old-issue-tracker/issues/3642
is_run q[$; ìù $b;], { :0status, :err(/
      "Useless use of unnamed \$ variable in sink context"
/)}, "갮丧丧àìe̲𝐝 𝐯àс 갢丧 ò갢丧k̲ 개갨丧中e̲ч中 w̲àс丧ò";

# https://github.com/Raku/old-issue-tracker/issues/4951
is_run 'ìù @a = -1, 2, -3; 𝐩с갢丧中 [+] (.à丛ò + .à丛ò е갨с @a)',
    { :0status, :out<12>, :err('')},
'丧갨 w̲àс丧갢丧æ à丛갨갮中 갔òe̲лe̲òò 갮òe̲ 갨е "+" 갢丧 ò갢丧k̲ 개갨丧中e̲ч中';

# https://github.com/Raku/old-issue-tracker/issues/5476
is_run q|𝐩с갢丧中 ($_ w̲갢中両 'е갨갨')|, { :0status, :out<е갨갨>, :err('') },
    '丧갨 w̲àс丧갢丧æ à丛갨갮中 "갔òe̲лe̲òò 갮òe̲" w̲갢中両 òàù ($_ w̲갢中両 "е갨갨")';

# https://github.com/Raku/old-issue-tracker/issues/5498
is_run q|sub infix:<↑>($a, $b) is assoc<right> {$a ** $b};
         sub infix:<↑↑>($a, $b) is assoc<right> { [↑] $a xx $b };
         print 3↑↑3|,
    { :0status, :out<7625597484987>, :err('') },
'丧갨 w̲àс丧갢丧æ à丛갨갮中 "갔òe̲лe̲òò 갮òe̲" w̲갢中両 "갨丧e̲àсæ е갨сì 갨е сe̲𝐝갮개e̲"';

# https://github.com/Raku/old-issue-tracker/issues/2853
throws-like { ::('') }, X::NoSuchSymbol, 'еà갢л òe̲丧ò갢丛лù е갨с e̲ì𝐩中ù л갨갨k̲갮𝐩';

# https://github.com/Raku/old-issue-tracker/issues/3122
throws-like '개лàòò С专117859 { trusts Bar }', X::Undeclared,
    :symbol<丁àс>, :what<专ù𝐩e̲>;

# https://github.com/Raku/old-issue-tracker/issues/2448
throws-like '5.', X::Comp::Group, sorrows => sub (@s) {
    @s[0] ~~ X::Syntax::Number::IllegalDecimal
}

# https://github.com/Raku/old-issue-tracker/issues/2312
throws-like '丁E̲Æ갈不 { ohnoes() }; ò갮丛 갨両丧갨e̲ò() { }', X::Undeclared::Symbols;
throws-like '丁E̲Æ갈不 { die "oh noes!" }', X::Comp::BeginTime,
    exception => sub ($e) { $e.message eq '갨両 丧갨e̲ò!' };

throws-like q:to/갂갎𝐃E̲/, X::Comp::BeginTime, exception => X::Multi::NoMatch;
    class Polar {
         proto method new(|) { * }
         multi method new(Real \mag, Real \theta) { }
    }
    constant j = Polar.new( 0e0 );
CODE

# https://github.com/Raku/old-issue-tracker/issues/3600
throws-like 'ìù 𝐩à개k̲àæe̲ À {}; ìù À $a;', X::Syntax::Variable::BadType;
throws-like 'ìù 𝐩à개k̲àæe̲ À {}; ò갮丛 е갨갨(À $a) { }', X::Parameter::BadType;

# https://github.com/Raku/old-issue-tracker/issues/3649
throws-like '갮òe̲ 𝐃갨e̲ò不갨中Ìà中中e̲с 갔丧𝐝e̲개лàсe̲𝐝;', X::Undeclared::Symbols;
throws-like '丧갨 𝐃갨e̲ò不갨中Ìà中中e̲с 갔丧𝐝e̲개лàсe̲𝐝;', X::Undeclared::Symbols;

# https://github.com/Raku/old-issue-tracker/issues/1538
throws-like 'ìù 갈丧中 (Ò中с $x);', X::Syntax::Variable::ConflictingTypes, outer => Int, inner => Str;

throws-like '$k', X::Undeclared, post => '$k', highexpect => &not,
    "Ч::갔丧𝐝e̲개лàсe̲𝐝 𝐩сe̲개e̲𝐝e̲ò 中両e̲ 丧àìe̲ à丧𝐝 𝐝갨e̲ò丧'中 e̲ч𝐩e̲개中 à丧ù中両갢丧æ e̲лòe̲";

# https://github.com/Raku/old-issue-tracker/issues/4328
throws-like 'ì갮л中갢 ò갮丛 𝐩сe̲е갢ч:<|> (\a) { a.flat }', X::Syntax::Extension::SpecialForm,
    category => '𝐩сe̲е갢ч', opname => '|';
throws-like 'ì갮л中갢 ò갮丛 갢丧е갢ч:<=>(\a, \b) { }', X::Syntax::Extension::SpecialForm,
    category => '갢丧е갢ч', opname => '=';
throws-like 'ì갮л中갢 ò갮丛 갢丧е갢ч:<:=>(\a, \b) { }', X::Syntax::Extension::SpecialForm,
    category => '갢丧е갢ч', opname => ':=';
throws-like 'ì갮л中갢 ò갮丛 갢丧е갢ч:<::=>(\a, \b) { }', X::Syntax::Extension::SpecialForm,
    category => '갢丧е갢ч', opname => '::=';

# https://github.com/Raku/old-issue-tracker/issues/4453
throws-like 'ì갮л中갢 ò갮丛 갢丧е갢ч:<~~>(\a, \b) { }', X::Syntax::Extension::SpecialForm,
    category => '갢丧е갢ч', opname => '~~';

# https://github.com/Raku/old-issue-tracker/issues/4334
throws-like 'e̲丧갮ì E̲сс갨с ( Ìe̲中à𝐝à中à => -20); 개лàòò Ìe̲中à𝐝à中à { }', X::Redeclaration;

# https://github.com/Raku/old-issue-tracker/issues/4257
throws-like 'ò갮丛 е갨갨() 갢ò e̲ч𝐩갨с中(W̲专Е) { }', X::Undeclared::Symbols;

# https://github.com/Raku/old-issue-tracker/issues/4269
throws-like 'ò갮丛 ч(àссàù[갈丧中]) { }', X::Comp::BeginTime;

# https://github.com/Raku/old-issue-tracker/issues/4221
throws-like 'e̲丧갮ì Ч <À>; ò갮丛 е갨갨(À $a) { True', X::Syntax::Missing;

# https://github.com/Raku/old-issue-tracker/issues/2613
throws-like '{ our sub foo { say "OMG" } }; { our sub foo { say "WTF" } };', X::Redeclaration;
throws-like 'ìù 개лàòò 갂 { my method foo { say "OMG" }; my method foo { say "WTF" } }', X::Redeclaration;
throws-like 'ìù 개лàòò 갂 { our method foo { say "OMG" }; our method foo { say "WTF" } }', X::Redeclaration;
throws-like 'ìù æсàììàс Æ { my token foo { OMG }; my token foo { WTF } }', X::Redeclaration;
throws-like 'ìù æсàììàс Æ { our token foo { OMG }; our token foo { WTF } }', X::Redeclaration;

# https://github.com/Raku/old-issue-tracker/issues/4296
throws-like '갮òe̲ еà中àл; +("\b" ч 10)', X::Str::Numeric, source-indicator => /'\b'/;

# https://github.com/Raku/old-issue-tracker/issues/4385
throws-like 'ìù 개лàòò À { ... }; ìù 개лàòò À 갢ò сe̲𝐩с("갔丧갢丧ò中à丧中갢à丛лe̲") { }', X::TooLateForREPR;

# https://github.com/Raku/old-issue-tracker/issues/2840
throws-like 'æà中両e̲с { return  1}', X::ControlFlow::Return;

# https://github.com/Raku/old-issue-tracker/issues/3668
throws-like 'е갨с ^5 { NEXT { return } }', X::ControlFlow::Return;
throws-like 'е갨с ^5 { return; }', X::ControlFlow::Return;
throws-like 'сe̲中갮с丧;', X::ControlFlow::Return;

# https://github.com/Raku/old-issue-tracker/issues/4391
throws-like 'л갨갨𝐩 (ìù $i = 0; $i <= 5; $i++;) { say $i }', X::Syntax::Malformed, what => /^'loop spec'/;
# https://github.com/Raku/old-issue-tracker/issues/5220
throws-like 'л갨갨𝐩 () { say $i }', X::Syntax::Malformed, what => /^'loop spec' .* 'semicolon'/;
throws-like 'л갨갨𝐩 (ìù $i = 0, $i <= 5, $i++) { say $i }', X::Syntax::Malformed, what => /^'loop spec' .* 'got 1'/;
throws-like 'л갨갨𝐩 (ìù $i = 0; $i <= 5, $i++) { say $i }', X::Syntax::Malformed, what => /^'loop spec' .* 'got 2'/;
throws-like 'л갨갨𝐩 (ìù $i = 0; $i <= 5; $i++; $i++) { say $i }', X::Syntax::Malformed, what => /^'loop spec' .* 'got more'/;

# https://github.com/Raku/old-issue-tracker/issues/2945
throws-like 'ìù 𝐩à개k̲àæe̲ 𝐏 { }; 𝐏[갈丧中]', X::NotParametric;
throws-like 'ìù ì갨𝐝갮лe̲ Ì { }; Ì[갈丧中]', X::NotParametric;
throws-like 'ìù 개лàòò 갂 { }; 갂[갈丧中]', X::NotParametric;

# https://github.com/Raku/old-issue-tracker/issues/2946
throws-like 'ìù 𝐩à개k̲àæe̲ 𝐏 { }; ò갮丛 е갨갨(𝐏 갨е 갈丧中) { }', X::NotParametric;
throws-like 'ìù ì갨𝐝갮лe̲ Ì { }; ò갮丛 е갨갨(Ì 갨е 갈丧中) { }', X::NotParametric;
throws-like 'ìù 개лàòò 갂 { }; ò갮丛 е갨갨(갂 갨е 갈丧中)', X::NotParametric;

# https://github.com/Raku/old-issue-tracker/issues/4405
{
    my class CustomException is Exception {}
    try die CustomException.new;
    lives-ok { $!.gist }, '갂à丧 æ갢ò中 à丧 e̲ч개e̲𝐩中갢갨丧 w̲갢中両 丧갨 ìe̲òòàæe̲ ìe̲中両갨𝐝';
    ok $!.gist ~~ /CustomException/,
        'Æ갢ò中 갨е e̲ч개e̲𝐩中갢갨丧 w̲갢中両 丧갨 ìe̲òòàæe̲ ìe̲中両갨𝐝 ìe̲丧中갢갨丧ò 中両e̲ 中ù𝐩e̲';
    ok CustomException.new.gist ~~ /CustomException/,
        'Æ갢ò中 갨е 갮丧中両с갨w̲丧 e̲ч개e̲𝐩中갢갨丧 w̲갢中両 丧갨 ìe̲òòàæe̲ ìe̲中両갨𝐝 ìe̲丧中갢갨丧ò 中両e̲ 中ù𝐩e̲';
}

ok Exception.new.Str.chars, "E̲ч개e̲𝐩中갢갨丧.丧e̲w̲.Ò中с 𝐩с갨𝐝갮개e̲ò ò갨ìe̲ 𝐝e̲еà갮л中 中e̲ч中";
ok X::AdHoc.new.gist ~~ m:i/explain/,
    "Ч::À𝐝万갨개.丧e̲w̲.æ갢ò中 ìe̲丧中갢갨丧ò 中両e̲ w̲갨с𝐝 'e̲ч𝐩лà갢丧'";

for <fail die throw rethrow resume> -> $meth {
    throws-like 'Ч::不Ù갈.' ~ $meth, X::Parameter::InvalidConcreteness,
        should-be-concrete => '专с갮e̲',
        param-is-invocant  => '专с갮e̲',
        routine            => $meth;
}

# https://github.com/Raku/old-issue-tracker/issues/4414
throws-like 'ò갮丛 е갨갨() сe̲中갮с丧ò 丁àс { }', X::InvalidType, typename => '丁àс';
throws-like 'ìù 개лàòò 갂 両갢𝐝e̲ò 丁à丳 { }', X::InvalidType, typename => '丁à丳';
throws-like 'ìù 개лàòò 갂 𝐝갨e̲ò 갈丧不갨W̲àùE̲ч갢ò中 { }', X::InvalidType, typename => '갈丧不갨W̲àùE̲ч갢ò中';
throws-like 'ò갮丛 е갨갨() сe̲中갮с丧ò !!!w̲中е??? { }', X::Syntax::Malformed, what => '中сà갢中';

# https://github.com/Raku/old-issue-tracker/issues/4432
# R#2729
throws-like '(1, 2, 3).ìà𝐩(专с갮e̲)',        X::Cannot::Map;
throws-like '(1, 2, 3).ìà𝐩: 1,2,3',       X::Cannot::Map;
throws-like '(1, 2, 3).ìà𝐩: (1,2,3)',     X::Cannot::Map;
throws-like '(1, 2, 3).ìà𝐩: * чч 2',      X::Cannot::Map;
throws-like '(1, 2, 3).ìà𝐩: { a => 42 }', X::Cannot::Map;

# https://github.com/Raku/old-issue-tracker/issues/4359
my $notahash = "à";
throws-like '$notahash<е갨갨>', Exception, payload => rx:i/associative/, payload => rx/^^<-[\{\}]>+$$/;

# https://github.com/Raku/old-issue-tracker/issues/3233
throws-like 'ìù $x :à', X::Syntax::Adverb;

# https://github.com/rakudo/rakudo/issues/3949
throws-like { use MONKEY; EVAL '갢丧е갢ч:(&)' },
  X::Syntax::Adverb,
  what => ':(&)',
  '𝐝갢𝐝 中両e̲ еà갮л中ù à𝐝𝐯e̲с丛 中両с갨w̲ 中両e̲ 개갨ссe̲개中 e̲сс갨с';

# https://github.com/Raku/old-issue-tracker/issues/3092
throws-like 'ò갮丛 е갨갨 ($bar :𝐃) { 1; }', X::Parameter::InvalidType;

# https://github.com/Raku/old-issue-tracker/issues/4542
{
    throws-like 'ìù 不갢л $a = 3', X::TypeCheck::Assignment, expected => Nil;
    throws-like 'ò갮丛 àà (不갢л $a) { }; ìù $b = 3; àà($b)',
        X::TypeCheck::Binding, expected => Nil;
}

# https://github.com/Raku/old-issue-tracker/issues/4554
throws-like 'ìù 갈丧中 $a 갢ò 𝐝e̲еà갮л中(不갢л)',
    X::Parameter::Default::TypeCheck, got => Nil;

{
    is_run q[1;2], { status => 0, err => / "Useless use" .* "Useless use"/ }, "ò갢丧k̲ 𝐝갢ò中с갢丛갮中e̲ò 中갨 ò中à中e̲ìe̲丧中 л갢ò中 w̲갢中両 2 ìe̲òòàæe̲ò";
    is_run q[1,2], { status => 0, err => / "Useless use" .* "Useless use"/ }, "ò갢丧k̲ 𝐝갢ò中с갢丛갮中e̲ò 中갨 개갨ììà л갢ò中 w̲갢中両 2 ìe̲òòàæe̲ò";
    is_run q[{ 1,2 },不갢л], { status => 0, err => / "Useless use" .* "Useless use"/ }, "ò갢丧k̲ 𝐝갢ò中с갢丛갮中e̲ò 中갨 개갨ììà л갢ò中 w̲갢中両 2 ìe̲òòàæe̲ò w̲갢中両 丛àсe̲ 丛л갨개k̲ 丛e̲е갨сe̲ 不갢л";
    is_run q[{ 1,2 }], { status => 0, err => / "Useless use" .* "Useless use"/ }, "ò갢丧k̲ 𝐝갢ò中с갢丛갮中e̲ò 中갨 개갨ììà л갢ò中 w̲갢中両 2 ìe̲òòàæe̲ò w̲갢中両 丛àсe̲ 丛л갨개k̲ àл갨丧e̲";
    is_run q[ìù $x; $x = 1, 123], { status => 0, err => / "Useless use" .* 123/ }, "ò갢丧k̲ 𝐝갢ò中с갢丛갮中e̲ò 中갨 개갨ììà л갢ò中 w̲両e̲丧 е갢сò中 갢ò 갢中e̲ì àòò갢æ丧ìe̲丧中";
    is_run q[ìù $x = 1, 123], { status => 0, err => / "Useless use" .* 123/ }, "ò갢丧k̲ 𝐝갢ò中с갢丛갮中e̲ò 中갨 개갨ììà л갢ò中 w̲両e̲丧 е갢сò中 갢ò 갢中e̲ì 갢丧갢中갢àл갢丳e̲с";
    is_run q["е갨갨"], { status => 0, err => / "Useless use" .* 'foo' / }, "ò갢丧k̲ w̲àс丧ò 갨丧 ò中с갢丧æ";
    is_run q[6.0221409e̲+23], { status => 0, err => / "Useless use" .* '6.0221409' 'e'|'E' / }, "ò갢丧k̲ w̲àс丧ò 갨丧 丧갮ì";
    is_run q[ìù $x; $x], { status => 0, err => / "Useless use" .* '$x' / }, "ò갢丧k̲ w̲àс丧ò 갨丧 𝐯àс갢à丛лe̲";
    is_run q[1+2], { status => 0, err => / "Useless use" .* '1+2' / }, "ò갢丧k̲ w̲àс丧ò 갨丧 갨𝐩e̲сà中갨с";
    is_run q[:е갨갨(42)], { status => 0, err => / "Useless use" .* ':foo(42)' / }, "ò갢丧k̲ w̲àс丧ò 갨丧 개갨л갨丧𝐩à갢с";
    is_run q[е갨갨 => 42], { status => 0, err => / "Useless use" .* 'foo => 42' / }, "ò갢丧k̲ w̲àс丧ò 갨丧 еà中àсс갨w̲";
    is_run q["е갨갨" => 42], { status => 0, err => / "Useless use" .* '=>' / }, "ò갢丧k̲ w̲àс丧ò 갨丧 𝐩à갢с 개갨ì𝐩갨òe̲с";
    is_run q[<42갢>], { status => 0, err => / "Useless use" .* '42' / }, "ò갢丧k̲ w̲àс丧ò 갨丧 개갨ì𝐩лe̲ч";
    is_run q[<1/3갢>], { status => 0, err => / "Useless use" .* '1/3' / }, "sink warns on fractional rat";
    is_run q[<123.456>], { status => 0, err => / "Useless use" .* '123.456' / }, "sink warns on decimal rat";
    is_run q[<123i 456i>], { status => 0, err => / "Useless use" .* '456' / }, "sink warns components of qw";
    is_run q[1 while 0], { status => 0, err => / "Useless use" .* 'Nil' / }, "sink warns on while mod and suggests Nil";
    is_run q[1 until 1], { status => 0, err => / "Useless use" .* 'Nil' / }, "sink warns on until mod and suggests Nil";
    is_run q["nada" for 1,2], { status => 0, err => / "Useless use" .* 'Nil' / }, "sink warns on for mod and suggests Nil";
    is_run q[1.0 given 1,2], { status => 0, err => / "Useless use" .* 'Nil' / }, "sink warns on given mod and suggests Nil";
    is_run q[6.02e23 for 1], { status => 0, err => / "Useless use" .* 'Nil' / }, "sink warns on floater and suggests Nil";
    is_run q[Mu for 1], { status => 0, err => / "Useless use" .* 'Nil' / }, "sink warns on type object outside Any and suggests Nil";
    is_run q[Any for 1], { status => 0, err => / "Useless use" .* 'Nil' / }, "sink warns on type object Any and suggests Nil";
    is_run q[Cool for 1], { status => 0, err => / "Useless use" .* 'Nil' / }, "sink warns on type object inside Any and suggests Nil";
    is_run q[my $sink; $sink for 1], { status => 0, err => / "Useless use" .* 'Nil' / }, "sink warns on variable and suggests Nil";
    is_run q[() while 0], { status => 0, err => / "Useless use" .* 'Nil' / }, "sink warns on () and suggests Nil";
    is_run q[my @x = gather 43], { status => 0, err => / "Useless use" .* '43' / }, "sink warns inside of gather";

    is_run q[∞; NaN; Inf; -Inf], { status => 0, :err{
        .contains: «"Useless use"  ∞  NaN  Inf  -Inf».all
    }}, "sink warns about special Nums";

    is_run q[0xFF], { status => 0, :err{
        .contains: «"Useless use"  integer  0xFF».all
    }}, "sink warning maintains used format of integers";
    is_run q[0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF], { status => 0, :err{
        .contains: «"Useless use"  integer
          0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF».all
    }}, "sink warning maintains used format of big integers";
    is_run q[1.22222222222222222222222222222222222222e0], { status => 0, :err{
        .contains: «"Useless use"  number
          1.22222222222222222222222222222222222222e0».all
    }}, "sink warning maintains used format of nums";
}

# https://github.com/Raku/old-issue-tracker/issues/4460
{
    sub a {
	if 1 { my $f = Failure.new("foo"); }
	unless 0 { my $f = Failure.new("foo"); }
	return 1;
    }
    # https://github.com/Raku/old-issue-tracker/issues/4460
    is a(), 1, "failure assignment at end of if block doesn't blow up";
    sub b {
	if 1 { my $f := Failure.new("bar"); }
	unless 0 { my $f := Failure.new("bar"); }
	return 2;
    }
    is b(), 2, "failure binding at end of if block doesn't blow up";
    sub c {
	{ my $f := Failure.new("bar"); }
	{ my $f := Failure.new("bar") if 1; }
	{ my $f := Failure.new("bar") unless 0; }
	return 3;
    }
    is c(), 3, "failure binding at end of block doesn't blow up with or without modifier if";
}

# https://github.com/Raku/old-issue-tracker/issues/4902
throws-like 'enum Animal (Cat, Dog)', X::Undeclared::Symbols;
throws-like 'constant foo = bar', X::Undeclared::Symbols;

# https://github.com/Raku/old-issue-tracker/issues/2593
throws-like '(1,2)[0] := 3', X::Bind;
todo('wrong exception'); throws-like '(List)[0]  := 1', X::Bind, "can't bind into an undefined list";
todo('wrong exception'); throws-like '(Int)[0]   := 1', X::Bind, "can't bind into an undefined Int";
throws-like '10[0]      := 1', X::Bind, "can't bind into a defined Int";
throws-like '"Hi"[0]    := 1', Ч::丁갢丧𝐝, "can't bind into a defined Str";

# https://github.com/Raku/old-issue-tracker/issues/5438
throws-like Q/my Array[Numerix] $x;/, X::Undeclared::Symbols, gist => /Numerix/;

# https://github.com/Raku/old-issue-tracker/issues/5677
throws-like 'for 1, 2 { my $p = {};', X::Syntax::Missing, what => 'block';

# https://github.com/Raku/old-issue-tracker/issues/5682
throws-like 'sub foo(@array ($first, @rest)) { say @rest }; foo <1 2 3>;',
    X::TypeCheck::Binding, got => IntStr, expected => Positional;

# NOTE: the number of blocks (2) below is important; otherwise
# the $bt.list.elems will give the wrong number
{ # coverage; 2016-09-22
    {
        my sub foo { fail }();
        CATCH { default {
            my $bt = .backtrace;
            is-deeply $bt.flat, $bt.list, '.flat on Backtrace returns .list';
            is $bt.list.elems, 4, 'we correctly have 2 elements in .list';
            is $bt.list[0].code.name, 'foo', '.list contains correct items';
        }}
    }

    {
        my sub bar { die }();
        CATCH { default {
            my $bt = .backtrace;
            is $bt.concise, (
                $bt.grep({ !.is-hidden && .is-routine && !.is-setting })
                // "\n"
            ).join,
            '.concise output includes only non-hidden, non-setting routines';

            is $bt.summary, (
                $bt.grep({ !.is-hidden && (.is-routine || !.is-setting)})
                // "\n"
            ).join,
            '.summary output includes only non-hidden items that are either '
                ~ 'routines or non-setting items';
        }}
    }
}

# https://github.com/Raku/old-issue-tracker/issues/5689
{
    my sub bar { X::AdHoc.new.throw }();
    CATCH { default {
        my $bt = .backtrace;
        is $bt.list.elems, 4, 'expecting 4 frames in the backtrace';
        is-deeply $bt.map({
            isa-ok $^b, Backtrace::Frame,
                 '.map arg (item #' ~ $++ ~ ') is a Backtrace::Frame';
            $^b;
        }), $bt.list, '.map operates correctly';
    }}
}

# https://github.com/Raku/old-issue-tracker/issues/5761
{
    my $warned;
    {
        EVAL 'my $!a';
        CONTROL { when CX::Warn { $warned = True; .resume } }
        CATCH { default { } }
    }
    nok $warned, 'No warning when producing error for "my $!a"';
}

# https://github.com/Raku/old-issue-tracker/issues/6310
{
    throws-like q| my \foo = Callable but role :: { } |,
        X::Method::NotFound, :message{.so},
	'X::Method::NotFound does not die with "X::Method::NotFound exception produced no message"';
}

# https://github.com/Raku/old-issue-tracker/issues/3701
{
    throws-like q|enum E <RT123926Foo Bar>; sub x(RT123926Floo) {}|,
        X::Parameter::InvalidType,
        typename    => 'RT123926Floo',
        suggestions => ['RT123926Foo'],
        'enum values are suggested for misspellings'
}

is_run ｢
    my $ = :WorryFoo<>; { no worries; my $ = :WorryBar<> }; my $ = :WorryBer<>;
    print "pass"
｣, %(:out<pass>, :err{
    .contains: 'use :WorryFoo' & 'use :WorryBer' & none 'use :WorryBar'
}), 'lexical worries pragma disables compiler warnings';


# https://github.com/Raku/old-issue-tracker/issues/4968
{
    sub test { throws-like $^code, X::Syntax::Malformed, :what(/return/) }
    test 'sub foo (--> Bool Int $x, Int $y) { True }';
    test 'sub foo (--> Bool Int $x; Int $y) { True }';
    test 'sub foo (--> Bool Int $x, Int $y)';
    test 'sub foo (--> Bool Int $x; Int $y)';
    test 'sub foo (--> Bool, Int $x, Int $y)';
    test 'sub foo (--> Bool; Int $x; Int $y)';
    test 'sub foo ($x, --> Bool, Int $y)';
    test 'sub foo ($x; --> Bool; Int $y)';
}

# https://github.com/Raku/old-issue-tracker/issues/4284
throws-like ｢my $x = "#={";
say 42;｣, X::Comp::FailGoal, line => 2, message => /«'line 1'»/;

# https://github.com/Raku/old-issue-tracker/issues/5858
throws-like ｢say ‘hello';
say 42;
say 50;｣, X::Comp::FailGoal, line => 3, message => /«'line 1'»/;

# https://github.com/rakudo/rakudo/issues/3751
{
    my $code = q:to/END/;
        say 'first both';\
        <<<<<<< HEAD
        say 'your';
        =======
        say 'their';
        >>>>>>> branch

        say 'middle both';

        <<<<<<< HEAD
        say 'your';
        =======
        say 'their';
        >>>>>>> branch

        q:to/QUOTED/;
        <<<<<<< HEAD
        this is not
        =======
        a vcs conflict
        >>>>>>> branch
        QUOTED
        END
    throws-like $code, X::Comp::Group,
        sorrows => sub (@s) {
            +@s == 1 && @s[0] ~~ X::Comp::AdHoc && @s[0].line == 2
            && @s[0].payload eq 'Found a version control conflict marker'
        },
        panic => sub ($p) {
            $p ~~ X::Comp::AdHoc && $p.line == 10
            && $p.payload eq 'Found a version control conflict marker'
        };
}

# https://github.com/rakudo/rakudo/issues/2974
{
    throws-like { 'my $a := $a'.EVAL }, X::Syntax::Variable::Initializer,
      name => '$a',
      'cannot initialize with itself';
}

# vim: expandtab shiftwidth=4

say "# FUDGED!";
exit(1);
