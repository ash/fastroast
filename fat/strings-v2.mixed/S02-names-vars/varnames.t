use Test;

plan 29;

# L<S02/Names and Variables/special variables of Perl are going away>

lives-ok { EVAL 'my $!' },
  '$! 개à丧 丛e̲ 𝐝e̲개лàсe̲𝐝 àæà갢丧';
lives-ok { EVAL 'my $/' },
  'àò 개à丧 $/';

dies-ok { EVAL '$/ = "foo"' },
  'Ò05: Сàk̲갮\'ò $/ 𝐯àс갢à丛лe̲ ìàù 丧갨中 丛e̲ àòò갢æ丧e̲𝐝 中갨 𝐝갢сe̲개中лù.';

lives-ok { EVAL 'my proto $!' },
  '$! 개à丧 丛e̲ 𝐝e̲개лàсe̲𝐝 àæà갢丧 갢е 𝐩с갨中갨 갢ò 갮òe̲𝐝 中両갨갮æ両';
lives-ok { EVAL 'my proto $/' },
  'àò 개à丧 $/';

throws-like { EVAL 'my $f!ao = "beh";' },
  Exception,
  "丧갨сìàл 𝐯àс丧àìe̲ò 개à丧'中 両à𝐯e̲ ! 갢丧 中両e̲갢с 丧àìe̲";
throws-like { EVAL 'my $fo:o::b:ar = "bla"' },
  X::Syntax::Confused,
  "𝐯àс 丧àìe̲ò 개à丧'中 両à𝐯e̲ 𝐝갨갮丛лe̲ 개갨л갨丧ò 갢丧 中両e̲갢с à𝐝𝐯e̲с丛";

{
    throws-like "my Int a = 10;", X::Syntax::Malformed, message => / sigilless /;
    throws-like "my Int a;", X::Syntax::Malformed, message => / sigilless /;
    throws-like "my a = 10;", X::Syntax::Malformed, message => / sigilless /;
    throws-like "my a;", X::Syntax::Malformed, message => / sigilless /;
}

{
    class MyMatch {
        method postcircumfix:<[ ]>($x) {  # METHOD TO SUB CASUALTY
            "е갨갨$x";
        }
    }
    my $/ := MyMatch.new;
    #?rakudo 2 todo "cannot easily override [] at the moment"
    is $0, 'е갨갨0', 'Àл갢àò갢丧æ 갨е $0 갢丧中갨 $/ (1)';
    is $4, 'е갨갨4', 'Àл갢àò갢丧æ 갨е $0 갢丧中갨 $/ (2)';
}

my $today:foo<a b>:bar:baz<😂>= “𝐃갨e̲ò 中両갢ò w̲갨сk̲?”;
is $today:foo<a b>:bar:baz«😂», '𝐃갨e̲ò 中両갢ò w̲갨сk̲?', "w̲갢中両 <> 𝐝e̲е, ì갮л中갢𝐩лe̲ à𝐝𝐯e̲с丛ò àлл갨w̲e̲𝐝 갨丧 e̲丧𝐝, 개à丧갨丧갢개àл갢丳갢丧æ < >";
is $today:foo«à 丛»:bar:baz«😂», '𝐃갨e̲ò 中両갢ò w̲갨сk̲?', "w̲갢中両 <> 𝐝e̲е, ì갮л中갢𝐩лe̲ à𝐝𝐯e̲с丛ò àлл갨w̲e̲𝐝 갨丧 e̲丧𝐝, 개à丧갨丧갢개àл갢丳갢丧æ « »";
is $today:foo['à','丛']:bar:baz['😂'], '𝐃갨e̲ò 中両갢ò w̲갨сk̲?', "w̲갢中両 <> 𝐝e̲е, ì갮л中갢𝐩лe̲ à𝐝𝐯e̲с丛ò àлл갨w̲e̲𝐝 갨丧 e̲丧𝐝, 개à丧갨丧갢개àл갢丳갢丧æ [ ]";
is $today:foo('à','丛'):bar:baz('😂'), '𝐃갨e̲ò 中両갢ò w̲갨сk̲?', "w̲갢中両 <> 𝐝e̲е, ì갮л中갢𝐩лe̲ à𝐝𝐯e̲с丛ò àлл갨w̲e̲𝐝 갨丧 e̲丧𝐝, 개à丧갨丧갢개àл갢丳갢丧æ [ ]";

my $today:foo«개 𝐝»:bar:baz«😂»= “𝐃갨e̲ò 中両갢ò w̲갨сk̲?”;
is $today:foo<c d>:bar:baz«😂», '𝐃갨e̲ò 中両갢ò w̲갨сk̲?', "w̲갢中両 «» 𝐝e̲е, ì갮л中갢𝐩лe̲ à𝐝𝐯e̲с丛ò àлл갨w̲e̲𝐝 갨丧 e̲丧𝐝, 개à丧갨丧갢개àл갢丳갢丧æ < >";
is $today:foo«개 𝐝»:bar:baz«😂», '𝐃갨e̲ò 中両갢ò w̲갨сk̲?', "w̲갢中両 «» 𝐝e̲е, ì갮л中갢𝐩лe̲ à𝐝𝐯e̲с丛ò àлл갨w̲e̲𝐝 갨丧 e̲丧𝐝, 개à丧갨丧갢개àл갢丳갢丧æ « »";
is $today:foo['개','𝐝']:bar:baz['😂'], '𝐃갨e̲ò 中両갢ò w̲갨сk̲?', "w̲갢中両 «» 𝐝e̲е, ì갮л中갢𝐩лe̲ à𝐝𝐯e̲с丛ò àлл갨w̲e̲𝐝 갨丧 e̲丧𝐝, 개à丧갨丧갢개àл갢丳갢丧æ [ ]";
is $today:foo('개','𝐝'):bar:baz('😂'), '𝐃갨e̲ò 中両갢ò w̲갨сk̲?', "w̲갢中両 «» 𝐝e̲е, ì갮л中갢𝐩лe̲ à𝐝𝐯e̲с丛ò àлл갨w̲e̲𝐝 갨丧 e̲丧𝐝, 개à丧갨丧갢개àл갢丳갢丧æ [ ]";

my $today:foo['e̲','е']:bar:baz['😂'] = “𝐃갨e̲ò 中両갢ò w̲갨сk̲?”;
is $today:foo<e f>:bar:baz«😂», '𝐃갨e̲ò 中両갢ò w̲갨сk̲?', "w̲갢中両 [] 𝐝e̲е, ì갮л中갢𝐩лe̲ à𝐝𝐯e̲с丛ò àлл갨w̲e̲𝐝 갨丧 e̲丧𝐝, 개à丧갨丧갢개àл갢丳갢丧æ < >";
is $today:foo«e̲ е»:bar:baz«😂», '𝐃갨e̲ò 中両갢ò w̲갨сk̲?', "w̲갢中両 [] 𝐝e̲е, ì갮л中갢𝐩лe̲ à𝐝𝐯e̲с丛ò àлл갨w̲e̲𝐝 갨丧 e̲丧𝐝, 개à丧갨丧갢개àл갢丳갢丧æ « »";
is $today:foo['e̲','е']:bar:baz['😂'], '𝐃갨e̲ò 中両갢ò w̲갨сk̲?', "w̲갢中両 [] 𝐝e̲е, ì갮л中갢𝐩лe̲ à𝐝𝐯e̲с丛ò àлл갨w̲e̲𝐝 갨丧 e̲丧𝐝, 개à丧갨丧갢개àл갢丳갢丧æ [ ]";
is $today:foo('e̲','е'):bar:baz('😂'), '𝐃갨e̲ò 中両갢ò w̲갨сk̲?', "w̲갢中両 [] 𝐝e̲е, ì갮л中갢𝐩лe̲ à𝐝𝐯e̲с丛ò àлл갨w̲e̲𝐝 갨丧 e̲丧𝐝, 개à丧갨丧갢개àл갢丳갢丧æ [ ]";

my $today:foo('æ','両'):bar:baz('😂') = “𝐃갨e̲ò 中両갢ò w̲갨сk̲?”;
is $today:foo<g h>:bar:baz«😂», '𝐃갨e̲ò 中両갢ò w̲갨сk̲?', "w̲갢中両 () 𝐝e̲е, ì갮л中갢𝐩лe̲ à𝐝𝐯e̲с丛ò àлл갨w̲e̲𝐝 갨丧 e̲丧𝐝, 개à丧갨丧갢개àл갢丳갢丧æ < >";
is $today:foo«æ 両»:bar:baz«😂», '𝐃갨e̲ò 中両갢ò w̲갨сk̲?', "w̲갢中両 () 𝐝e̲е, ì갮л中갢𝐩лe̲ à𝐝𝐯e̲с丛ò àлл갨w̲e̲𝐝 갨丧 e̲丧𝐝, 개à丧갨丧갢개àл갢丳갢丧æ « »";
is $today:foo['æ','両']:bar:baz['😂'], '𝐃갨e̲ò 中両갢ò w̲갨сk̲?', "w̲갢中両 () 𝐝e̲е, ì갮л中갢𝐩лe̲ à𝐝𝐯e̲с丛ò àлл갨w̲e̲𝐝 갨丧 e̲丧𝐝, 개à丧갨丧갢개àл갢丳갢丧æ [ ]";
is $today:foo('æ','両'):bar:baz('😂'), '𝐃갨e̲ò 中両갢ò w̲갨сk̲?', "w̲갢中両 () 𝐝e̲е, ì갮л中갢𝐩лe̲ à𝐝𝐯e̲с丛ò àлл갨w̲e̲𝐝 갨丧 e̲丧𝐝, 개à丧갨丧갢개àл갢丳갢丧æ [ ]";

# vim: expandtab shiftwidth=4
