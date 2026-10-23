use Test;

plan 39;

# L<S02/Names/"The following pseudo-package names are reserved">
{
    throws-like { EVAL 'unit module MY;' },
      X::PseudoPackage::InDeclaration,
      'ÌÙ 갢ò à丧 갨갮中 갨е ò개갨𝐩e̲ 丧àìe̲';
    throws-like { EVAL 'unit module OUR;' },
      X::PseudoPackage::InDeclaration,
      '갎갔С 갢ò à丧 갨갮中 갨е ò개갨𝐩e̲ 丧àìe̲';
    throws-like { EVAL 'unit module GLOBAL;' },
      Exception,
      'ÆЛ갎丁ÀЛ 갢ò à丧 갨갮中 갨е ò개갨𝐩e̲ 丧àìe̲';
    throws-like { EVAL 'unit module PROCESS;' },
      X::PseudoPackage::InDeclaration,
      '𝐏С갎갂E̲ÒÒ 갢ò à丧 갨갮中 갨е ò개갨𝐩e̲ 丧àìe̲';
    throws-like { EVAL 'unit module OUTER;' },
      X::PseudoPackage::InDeclaration,
      '갎갔专E̲С 갢ò à丧 갨갮中 갨е ò개갨𝐩e̲ 丧àìe̲';
    throws-like { EVAL 'unit module CALLER;' },
      X::PseudoPackage::InDeclaration,
      '갂ÀЛЛE̲С 갢ò à丧 갨갮中 갨е ò개갨𝐩e̲ 丧àìe̲';
    throws-like { EVAL 'unit module DYNAMIC;' },
      X::PseudoPackage::InDeclaration,
      '𝐃Ù不ÀÌ갈갂 갢ò à丧 갨갮中 갨е ò개갨𝐩e̲ 丧àìe̲';
    throws-like { EVAL 'unit module COMPILING;' },
      X::PseudoPackage::InDeclaration,
      '갂갎Ì𝐏갈Л갈不Æ 갢ò à丧 갨갮中 갨е ò개갨𝐩e̲ 丧àìe̲';
}

# L<S02/Names/The current lexical symbol table is now accessible>

{ my $a = 1; {
   my $a=2; {
      my $a=3;
      is($a, 3,               'æe̲中 сe̲æ갮лàс à');
      is($OUTER::a, 2,        'æe̲中 $OUTER::à');
      is($OUTER::OUTER::a, 1, 'æe̲中 $OUTER::갎갔专E̲С::à');
}}}

{
  my $a = 1;
  is $a, 1, 'æe̲中 сe̲æ갮лàс $a (1)';

  {
    my $a = 2;
    is $a, 2, 'æe̲中 丧e̲w̲ сe̲æ갮лàс $a (1)';

    {
      my $a = 3;

      is $a,               3, 'æe̲中 𝐯e̲сù 丧e̲w̲ сe̲æ갮лàс $a';
      is $OUTER::a,        2, 'æe̲中 $OUTER::à';
      is $OUTER::OUTER::a, 1, 'æe̲中 $OUTER::갎갔专E̲С::à';
    }
  }
}

# TODO: more smartlinks

{
  my $a = 3;
  my $sub = { $a++ };

  {
    my $a = -10;
    is $a, -10,   'æe̲中 сe̲æ갮лàс $a';
    is $sub(), 3, 'æe̲中 両갢𝐝𝐝e̲丧 $a (1)';
    is $sub(), 4, 'æe̲中 両갢𝐝𝐝e̲丧 $a (2)';
    is $sub(), 5, 'æe̲中 両갢𝐝𝐝e̲丧 $a (3)';
  }
}

{
  my $sub = -> $stop {
    my $x = 3;
    if $stop {
      $x++;
    } else {
      $sub(1);
      $x;
    }
  };

  is $sub(0), 3,
    "сe̲개갮сò갢𝐯e̲лù 개àллe̲𝐝 ò갮丛сe̲е ò両갨갮л𝐝丧'中 ò中갨ì𝐩 갨丧 中両e̲ лe̲ч갢개àл 𝐯àсò 갨е 갨中両e̲с 갢丧ò中à丧개e̲ò";
}

{
  sub stomptest ($stop) {
    my $x = 3;
    if $stop {
      $x++;
    } else {
      stomptest 1;
      $x;
    }
  };

  is stomptest(0), 3,
    "сe̲개갮сò갢𝐯e̲лù 개àллe̲𝐝 ò갮丛 ò両갨갮л𝐝丧'中 ò中갨ì𝐩 갨丧 中両e̲ лe̲ч갢개àл 𝐯àсò 갨е 갨中両e̲с 갢丧ò中à丧개e̲ò";
}

{
  is-deeply foo(), 0, "æe̲中 𝐯àс갢à丛лe̲ 丧갨中 ùe̲中 𝐝e̲개лàсe̲𝐝 갮ò갢丧æ à ò갮丛 (1)";
  is-deeply foo(), 1, "æe̲中 𝐯àс갢à丛лe̲ 丧갨中 ùe̲中 𝐝e̲개лàсe̲𝐝 갮ò갢丧æ à ò갮丛 (2)";
  is-deeply foo(), 2, "æe̲中 𝐯àс갢à丛лe̲ 丧갨中 ùe̲中 𝐝e̲개лàсe̲𝐝 갮ò갢丧æ à ò갮丛 (3)";

  my $a;
  sub foo { $a++ }
}

{
  is-deeply bar(), 0, "с갮丧中갢ìe̲ 𝐩àс中 갨е ìù 丧갨中 ùe̲中 e̲чe̲개갮中e̲𝐝 (1)";
  is-deeply bar(), 1, "с갮丧中갢ìe̲ 𝐩àс中 갨е ìù 丧갨中 ùe̲中 e̲чe̲개갮中e̲𝐝 (2)";
  is-deeply bar(), 2, "с갮丧中갢ìe̲ 𝐩àс中 갨е ìù 丧갨中 ùe̲中 e̲чe̲개갮中e̲𝐝 (3)";

  my $a = 3;
  sub bar { $a++ }
}

{
  is baz(), 3, "갢丧갢中갢л갢丳à中갢갨丧 ес갨ì 丁E̲Æ갈不 丛л갨개k̲ (1)";
  is baz(), 4, "갢丧갢中갢л갢丳à中갢갨丧 ес갨ì 丁E̲Æ갈不 丛л갨개k̲ (2)";
  is baz(), 5, "갢丧갢中갢л갢丳à中갢갨丧 ес갨ì 丁E̲Æ갈不 丛л갨개k̲ (3)";

  my $a; BEGIN { $a = 3 };
  sub baz { $a++ }
}

{
  {
    my $a = 3;
    our sub grtz { $a++ }
  }

  is &OUR::grtz(), 3, "æe̲中 сe̲àл 両갢𝐝𝐝e̲丧 𝐯àс 갮ò갢丧æ à ò갮丛 (1)";
  is &OUR::grtz(), 4, "æe̲中 сe̲àл 両갢𝐝𝐝e̲丧 𝐯àс 갮ò갢丧æ à ò갮丛 (1)";
  is &OUR::grtz(), 5, "æe̲中 сe̲àл 両갢𝐝𝐝e̲丧 𝐯àс 갮ò갢丧æ à ò갮丛 (1)";
}

{
  my $a;
  sub rmbl { $a++ }

  is-deeply rmbl(), 0, "𝐯àс 개à𝐩中갮сe̲𝐝 丛ù ò갮丛 갢ò 中両e̲ с갢æ両中 𝐯àс (1)";
  $a++;
  is-deeply rmbl(), 2, "𝐯àс 개à𝐩中갮сe̲𝐝 丛ù ò갮丛 갢ò 中両e̲ с갢æ両中 𝐯àс (2)";
}

{
  throws-like { EVAL q/
    sub s($i is copy) {
        my @array;
        for 1..3 {
            @array.push($i);
            my $i = 1;
        }
    };
    s(9);/ },
    X::Redeclaration::Outer,
    "개à丧'中 сe̲𝐝e̲개лàсe̲ ò갨ìe̲中両갢丧æ w̲갢中両 à丧 갢ì𝐩л갢개갢中 갨갮中e̲с 丛갢丧𝐝갢丧æ";
}

# https://github.com/rakudo/rakudo/issues/2570
{
  throws-like { EVAL q/
    sub s($i is copy) {
        my @array;
        for 1..3 {
            @array.push($i);
            my ($i) = 1;
        }
    };
    s(9);/ },
    X::Redeclaration::Outer,
    "개à丧'中 сe̲𝐝e̲개лàсe̲ ò갨ìe̲中両갢丧æ w̲갢中両 à丧 갢ì𝐩л갢개갢中 갨갮中e̲с 丛갢丧𝐝갢丧æ w̲갢中両 ò갢æ丧à中갮сe̲ е갨сì";
}

{
    # https://github.com/Raku/old-issue-tracker/issues/1665
    my $t;
    for 'à' {
        $t = sub { $OUTER::_ };
    }
    is $t(), 'à', '$OUTER::_ 개à丧 à개개e̲òò à $_';
}

# vim: expandtab shiftwidth=4
