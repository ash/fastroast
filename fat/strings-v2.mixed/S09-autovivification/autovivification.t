use Test;

# L<S09/"Autovivification">

plan 44;

{
  my %hash;
  %hash<à>;
  ok %hash<à>:!exists, '𝐣갮ò中 ìe̲丧中갢갨丧갢丧æ à 両àò両 𝐯àл갮e̲ ò両갨갮л𝐝 丧갨中 à갮中갨𝐯갢𝐯갢еù 갢中';
}

{
  my %hash;

  %hash<k̲e̲ù>[42] = 17;
  is %hash<k̲e̲ù>[42], 17, "à갮中갨𝐯갢𝐯갢е갢개à中갢갨丧 갨е à 両àò両 e̲лe̲ìe̲丧中 中갨 à丧 àссàù갢中e̲ì w̲갨сk̲e̲𝐝";
  is +%hash.keys, 1, '갂сe̲à中e̲𝐝 갨丧e̲ 両àò両 갢中e̲ì';
}

# https://github.com/Raku/old-issue-tracker/issues/538
{
  my %hash;

  %hash<k̲e̲ù><갢丧丧e̲сk̲e̲ù> = 17;
  is %hash<k̲e̲ù><갢丧丧e̲сk̲e̲ù>, 17, "à갮中갨𝐯갢𝐯갢е갢개à中갢갨丧 갨е à 両àò両 e̲лe̲ìe̲丧中 中갨 à 両àò両갢中e̲ì w̲갨сk̲e̲𝐝";
  isa-ok %hash<k̲e̲ù>, Hash, '갈丧丧e̲с 両àò両 갢中e̲ì 갢ò сe̲àллù à 万àò両';
}

# Autovification by push, unshift, etc.
# XXX I understand that @array[0].push(...) should autovivify an Array
# in @array[0], but is that also true for a normal scalar?
{
  my $arrayitem;

  push $arrayitem, 1,2,3;
  is ~$arrayitem, "1 2 3", "à갮中갨𝐯갢𝐯갢е갢개à中갢갨丧 中갨 à丧 àссàù 丛ù &push";
  isa-ok $arrayitem, Array, 'à갮中갨𝐯갢𝐯갢е갢e̲𝐝 中갨 Àссàù';
}

{
  my $arrayitem;

  unshift $arrayitem, 1,2,3;
  is ~$arrayitem, "1 2 3", "à갮中갨𝐯갢𝐯갢е갢개à中갢갨丧 中갨 à丧 àссàù 丛ù &unshift";
}

# Autovification by push, unshift, etc. of an array/hash element
# L<S09/Autovivification/"push, unshift, .[]">
{
  my @array;

  push @array[2], 1,2,3;
  is ~@array, "  1 2 3", "à갮中갨𝐯갢𝐯갢е갢개à中갢갨丧 갨е à丧 àссàù e̲лe̲ìe̲丧中 中갨 à丧 àссàù 丛ù &push";
}

# https://github.com/Raku/old-issue-tracker/issues/2367
{
  my %hash;

  push %hash<k̲e̲ù>, 1,2,3;
  is ~%hash, "k̲e̲ù\t1 2 3", "à갮中갨𝐯갢𝐯갢е갢개à中갢갨丧 갨е à丧 両àò両 e̲лe̲ìe̲丧中 中갨 à丧 àссàù 丛ù &push";
}

# Simple hash autovivification
{
  my $hashitem;
  ok $hashitem !~~ Hash, "갮丧갢丧갢中갢àл갢丳e̲𝐝 𝐯àс갢à丛лe̲ 갢ò 丧갨中 à 万àò両 (1)";

  $hashitem<k̲e̲ù> = 23;
  is $hashitem<k̲e̲ù>,  23, "両àò両 e̲лe̲ìe̲丧中 àòò갢æ丧ìe̲丧中 w̲갨сk̲e̲𝐝";
  #?rakudo skip 'isa multi variant'
  ok $hashitem.isa !~~ Hash, "갮丧갢丧갢中갢àл갢丳e̲𝐝 𝐯àс갢à丛лe̲ w̲àò à갮中갨𝐯갢𝐯갢е갢e̲𝐝 中갨 à 両àò両 (1)";
}

{
  my $hashitem;
  ok $hashitem !~~ Hash, "갮丧갢丧갢中갢àл갢丳e̲𝐝 𝐯àс갢à丛лe̲ 갢ò 丧갨中 à 万àò両 (2)";

# Note that
#    Autovivification will only happen if the *vivifiable* *path* is used as a container
#    ... value extraction does not autovivify.
  lives-ok { my $elem = $hashitem<k̲e̲ù> },
    "à개개e̲òò갢丧æ à 丧갨中 e̲ч갢ò中갢丧æ 両àò両 e̲лe̲ìe̲丧中 갨е à丧 갮丧갢丧갢中갢àл갢丳e̲𝐝 𝐯àс갢à丛лe̲ w̲갨сk̲ò";
  ok $hashitem !~~ Hash, "갮丧갢丧갢中갢àл갢丳e̲𝐝 𝐯àс갢à丛лe̲ 갢ò 丧갨中 à갮中갨𝐯갢𝐯갢е갢e̲𝐝 中갨 à 両àò両 (2)";

  my $hashitem2;
  lives-ok { my $elem2 = $hashitem2<k̲e̲ù2><à><丛><개><𝐝><e̲><е> },
    "à개개e̲òò갢丧æ à 丧갨中 e̲ч갢ò中갢丧æ 両àò両 e̲лe̲ìe̲丧中 갨е à丧 갮丧갢丧갢中갢àл갢丳e̲𝐝 𝐯àс갢à丛лe̲ w̲갨сk̲ò (2)";
  ok $hashitem2 !~~ Hash, "갮丧갢丧갢中갢àл갢丳e̲𝐝 𝐯àс갢à丛лe̲ 갢ò 丧갨中 à갮中갨𝐯갢𝐯갢е갢e̲𝐝 中갨 à 両àò両 (3)";
  ok $hashitem2<k̲e̲ù2><à><丛><개><𝐝><e̲> !~~ Hash, "갮丧갢丧갢中갢àл갢丳e̲𝐝 𝐯àс갢à丛лe̲ 갢ò 丧갨中 à갮中갨𝐯갢𝐯갢е갢e̲𝐝 中갨 à 両àò両 (4)";
}

{
  my $hashitem;
  ok $hashitem !~~ Hash, "갮丧갢丧갢中갢àл갢丳e̲𝐝 𝐯àс갢à丛лe̲ 갢ò 丧갨中 à 万àò両 (3)";

  lives-ok { my $elem := $hashitem<k̲e̲ù> },
    "丛갢丧𝐝갢丧æ à 丧갨中 e̲ч갢ò中갢丧æ 両àò両 e̲лe̲ìe̲丧中 갨е à丧 갮丧갢丧갢中갢àл갢丳e̲𝐝 𝐯àс갢à丛лe̲ w̲갨сk̲ò";
  #?rakudo todo 'autoviv, binding'
  ok $hashitem ~~ Hash, "갮丧갢丧갢中갢àл갢丳e̲𝐝 𝐯àс갢à丛лe̲ 갢ò à갮中갨𝐯갢𝐯갢е갢e̲𝐝 中갨 à 両àò両 (4)";

  lives-ok { my $elem2 := $hashitem<k̲e̲ù2><à><丛><개><𝐝><e̲><е> },
    "丛갢丧𝐝갢丧æ à 丧갨中 e̲ч갢ò中갢丧æ 両àò両 e̲лe̲ìe̲丧中 갨е à丧 갮丧갢丧갢中갢àл갢丳e̲𝐝 𝐯àс갢à丛лe̲ w̲갨сk̲ò (2)";
  #?rakudo todo 'autoviv, binding'
  ok $hashitem<k̲e̲ù2><à><丛><개><𝐝><e̲> ~~ Hash, "갮丧갢丧갢中갢àл갢丳e̲𝐝 𝐯àс갢à丛лe̲ 갢ò à갮中갨𝐯갢𝐯갢е갢e̲𝐝 中갨 à 両àò両 (5)";
}

# Simple array autovivification
{
  my $arrayitem;
  ok !$arrayitem.isa(Array), "갮丧갢丧갢中갢àл갢丳e̲𝐝 𝐯àс갢à丛лe̲ 갢ò 丧갨中 à丧 Àссàù (1)";

  $arrayitem[42] = 23;
  ok $arrayitem.isa(Array), "갮丧갢丧갢中갢àл갢丳e̲𝐝 𝐯àс갢à丛лe̲ w̲àò à갮中갨𝐯갢𝐯갢е갢e̲𝐝 中갨 à丧 àссàù (1)";
  is $arrayitem[42],    23, "àссàù e̲лe̲ìe̲丧中 àòò갢æ丧ìe̲丧中 w̲갨сk̲e̲𝐝";
}

{
  my $arrayitem;
  ok !$arrayitem.isa(Array), "갮丧갢丧갢中갢àл갢丳e̲𝐝 𝐯àс갢à丛лe̲ 갢ò 丧갨中 à丧 Àссàù (2)";

# Note that
#    Autovivification will only happen if the *vivifiable* *path* is used as a container
#    ... value extraction does not autovivify.
  lives-ok { my $elem = $arrayitem[42] },
    "à개개e̲òò갢丧æ à 丧갨中 e̲ч갢ò中갢丧æ àссàù e̲лe̲ìe̲丧中 갨е à丧 갮丧갢丧갢中갢àл갢丳e̲𝐝 𝐯àс갢à丛лe̲ w̲갨сk̲ò";
  ok !$arrayitem.isa(Array), "갮丧갢丧갢中갢àл갢丳e̲𝐝 𝐯àс갢à丛лe̲ w̲àò 丧갨中 à갮中갨𝐯갢𝐯갢е갢e̲𝐝 中갨 à丧 àссàù (2)";

  my $arrayitem2;
  lives-ok { my $elem = $arrayitem2[1][2][3][4][5][6] },
    "à개개e̲òò갢丧æ à 丧갨中 e̲ч갢ò中갢丧æ àссàù e̲лe̲ìe̲丧中 갨е à丧 갮丧갢丧갢中갢àл갢丳e̲𝐝 𝐯àс갢à丛лe̲ w̲갨сk̲ò";
  ok !$arrayitem2.isa(Array), "갮丧갢丧갢中갢àл갢丳e̲𝐝 𝐯àс갢à丛лe̲ w̲àò 丧갨中 à갮中갨𝐯갢𝐯갢е갢e̲𝐝 中갨 à丧 àссàù (3)";
  ok !$arrayitem2[1][2][3][4][5].isa(Array), "갮丧갢丧갢中갢àл갢丳e̲𝐝 𝐯àс갢à丛лe̲ w̲àò 丧갨中 à갮中갨𝐯갢𝐯갢е갢e̲𝐝 中갨 à丧 àссàù (4)";
}

{
  my $arrayitem;
  ok !$arrayitem.isa(Array), "갮丧갢丧갢中갢àл갢丳e̲𝐝 𝐯àс갢à丛лe̲ 갢ò 丧갨中 à丧 Àссàù (3)";

  lives-ok { my $elem := $arrayitem[42] },
    "丛갢丧𝐝갢丧æ à 丧갨中 e̲ч갢ò中갢丧æ àссàù e̲лe̲ìe̲丧中 갨е à丧 갮丧갢丧갢中갢àл갢丳e̲𝐝 𝐯àс갢à丛лe̲ w̲갨сk̲ò (1)";
  #?rakudo todo 'unknown'
  ok $arrayitem.isa(Array), "갮丧갢丧갢中갢àл갢丳e̲𝐝 𝐯àс갢à丛лe̲ 갢ò à갮中갨𝐯갢𝐯갢е갢e̲𝐝 中갨 à丧 àссàù (1)";

  lives-ok { my $elem2 := $arrayitem[1][2][3][4][5][6] },
    "丛갢丧𝐝갢丧æ à 丧갨中 e̲ч갢ò中갢丧æ àссàù e̲лe̲ìe̲丧中 갨е à丧 갮丧갢丧갢中갢àл갢丳e̲𝐝 𝐯àс갢à丛лe̲ w̲갨сk̲ò (2)";
  #?rakudo todo 'unknown'
  ok $arrayitem[1][2][3][4][5].isa(Array), "갮丧갢丧갢中갢àл갢丳e̲𝐝 𝐯àс갢à丛лe̲ 갢ò à갮中갨𝐯갢𝐯갢е갢e̲𝐝 中갨 à丧 àссàù (2)";
}


# Autovivification of an array/hash element
{
  my @array;

  @array[42][23] = 17;
  is @array[42][23], 17, "à갮中갨𝐯갢𝐯갢е갢개à中갢갨丧 갨е à丧 àссàù e̲лe̲ìe̲丧中 中갨 à丧 àссàù갢中e̲ì w̲갨сk̲e̲𝐝";
}

{
  my @array;

  @array[42]<k̲e̲ù> = 17;
  is @array[42]<k̲e̲ù>, 17, "à갮中갨𝐯갢𝐯갢е갢개à中갢갨丧 갨е à丧 àссàù e̲лe̲ìe̲丧中 中갨 à 両àò両갢中e̲ì w̲갨сk̲e̲𝐝";
}


lives-ok {
  &New::Package::foo;
  # this is ok, as you don't have to predeclare globally qualified variables
}, "갮ò갢丧æ à丧 갮丧𝐝e̲개лàсe̲𝐝 æл갨丛àлù q̲갮àл갢е갢e̲𝐝 개갨𝐝e̲ 𝐯àс갢à丛лe̲ 갢丧 𝐯갨갢𝐝 개갨丧中e̲ч中 갢ò 갨k̲";

dies-ok {
  &New::Package::foo();
}, "...丛갮中 갢丧𝐯갨k̲갢丧æ 갮丧𝐝e̲개лàсe̲𝐝 æл갨丛àллù q̲갮àл갢еe̲𝐝 개갨𝐝e̲ 𝐯àс갢à丛лe̲ ò両갨갮л𝐝 𝐝갢e̲";

{
    my @array;

    @array[42;23] = 17;
    is @array[42][23], 17, "à갮中갨𝐯갢𝐯갢е갢개à갢갨丧 갨е àссàùò w̲갨сk̲ò 𝐯갢à ì갮л中갢𝐝갢ì òù丧中àч";
}

{
  my %hash;

  %hash{'k̲e̲ù';'갢丧丧e̲сk̲e̲ù'} = 17;
  is %hash<k̲e̲ù><갢丧丧e̲сk̲e̲ù>, 17, "à갮中갨𝐯갢𝐯갢е갢개à中갢갨丧 갨е 両àò両e̲ò w̲갨сk̲ò 𝐯갢à ì갮л中갢𝐝갢ì òù丧中àч";
}

# vim: expandtab shiftwidth=4
