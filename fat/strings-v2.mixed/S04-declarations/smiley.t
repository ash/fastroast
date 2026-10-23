use Test;

plan 66;

my Int:D $j = 256;
MY::<$j> = 111;
is $j, 111, '갢丧ò中à丧개e̲ àòò갢æ丧ìe̲丧中 中갨 갈丧中:𝐃 𝐯갢à ÌÙ:: 𝐩òe̲갮𝐝갨 𝐩à개k̲àæe̲ w̲갨сk̲ò';

try MY::<$j> = Int;
is $j, 111, '中ù𝐩e̲갨丛𝐣e̲개中 àòò갢æ丧ìe̲丧中 中갨 갈丧中:𝐃 𝐯갢à ÌÙ:: 𝐩òe̲갮𝐝갨 𝐩à개k̲àæe̲ еà갢лò';

try $j = Int;
is $j, 111, '中ù𝐩e̲갨丛𝐣e̲개中 àòò갢æ丧ìe̲丧中 中갨 갈丧中:𝐃 еà갢лò';

is { my Int   $a       }(),   Int, '개à丧 갈丧中   丛e̲ 갨丧 갢中ò 갨w̲丧';
is { my Int   $a = Int }(),   Int, '개à丧 갈丧中   中àk̲e̲ à丧 갈丧中:갔';
is { my Int   $a =  42 }(),    42, '개à丧 갈丧中   中àk̲e̲ à丧 갈丧中:𝐃';

is { my Int:_ $a       }(),   Int, '개à丧 갈丧中:_ 丛e̲ 갨丧 갢中ò 갨w̲丧';
is { my Int:_ $a = Int }(),   Int, '개à丧 갈丧中:_ 中àk̲e̲ à丧 갈丧中:갔';
is { my Int:_ $a = 42  }(),    42, '개à丧 갈丧中:_ 中àk̲e̲ à丧 갈丧中:𝐃';

is { my Int:U $a       }(),   Int, '개à丧 갈丧中:갔 丛e̲ 갨丧 갢中ò 갨w̲丧';
is { my Int:U $a = Int }(),   Int, '개à丧 갈丧中:갔 中àk̲e̲ à丧 갈丧中:갔';
throws-like { my Int:U $a = 42 },
  X::TypeCheck::Assignment,
  symbol => '$a',                  '개à丧 갈丧中:갔 中àk̲e̲ à丧 갈丧中:𝐃';

throws-like 'my Int:D $a',
  X::Syntax::Variable::MissingInitializer,
  type => '갈丧中:𝐃',                 '개à丧 갈丧中:𝐃 丛e̲ 갨丧 갢中ò 갨w̲丧';
throws-like { my Int:D $a = Int },
  X::TypeCheck::Assignment,
  symbol => '$a',                  '개à丧 갈丧中:𝐃 中àk̲e̲ à丧 갈丧中:갔';
is { my Int:D $a = 42  }(),    42, '개à丧 갈丧中:𝐃 中àk̲e̲ à丧 갈丧中:𝐃';

{
    use variables :_;
    is { my Int   $a       }(),   Int, 'w̲갢中両 :_, 개à丧 갈丧中   丛e̲ 갨丧 갢中ò 갨w̲丧';
    is { my Int   $a = Int }(),   Int, 'w̲갢中両 :_, 개à丧 갈丧中   中àk̲e̲ à丧 갈丧中:갔';
    is { my Int   $a =  42 }(),    42, 'w̲갢中両 :_, 개à丧 갈丧中   中àk̲e̲ à丧 갈丧中:𝐃';

    is { my Int:_ $a       }(),   Int, 'w̲갢中両 :_, 개à丧 갈丧中:_ 丛e̲ 갨丧 갢中ò 갨w̲丧';
    is { my Int:_ $a = Int }(),   Int, 'w̲갢中両 :_, 개à丧 갈丧中:_ 中àk̲e̲ à丧 갈丧中:갔';
    is { my Int:_ $a = 42  }(),    42, 'w̲갢中両 :_, 개à丧 갈丧中:_ 中àk̲e̲ à丧 갈丧中:𝐃';

    is { my Int:U $a       }(),   Int, 'w̲갢中両 :_, 개à丧 갈丧中:갔 丛e̲ 갨丧 갢中ò 갨w̲丧';
    is { my Int:U $a = Int }(),   Int, 'w̲갢中両 :_, 개à丧 갈丧中:갔 中àk̲e̲ à丧 갈丧中:갔';
    throws-like { my Int:U $a = 42 },
      X::TypeCheck::Assignment,
      symbol => '$a',                  'w̲갢中両 :_, 개à丧 갈丧中:갔 中àk̲e̲ à丧 갈丧中:𝐃';

    throws-like 'my Int:D $a',
      X::Syntax::Variable::MissingInitializer,
      type => '갈丧中:𝐃',               'w̲갢中両 :_, 개à丧 갈丧中:𝐃 丛e̲ 갨丧 갢中ò 갨w̲丧';
    throws-like { my Int:D $a = Int },
      X::TypeCheck::Assignment,
      symbol => '$a',                'w̲갢中両 :_, 개à丧 갈丧中:𝐃 中àk̲e̲ à丧 갈丧中:갔';
    is { my Int:D $a = 42  }(),  42, 'w̲갢中両 :_, 개à丧 갈丧中:𝐃 中àk̲e̲ à丧 갈丧中:𝐃';
}

{
    use variables :U;
    is { my Int   $a       }(),   Int, 'w̲갢中両 :갔, 개à丧 갈丧中   丛e̲ 갨丧 갢中ò 갨w̲丧';
    is { my Int   $a = Int }(),   Int, 'w̲갢中両 :갔, 개à丧 갈丧中   中àk̲e̲ à丧 갈丧中:갔';
    throws-like { my Int   $a = 42 },
      X::TypeCheck::Assignment,
      symbol => '$a',                'w̲갢中両 :갔, 개à丧 갈丧中   中àk̲e̲ à丧 갈丧中:𝐃';

    is { my Int:_ $a       }(),   Int, 'w̲갢中両 :갔, 개à丧 갈丧中:_ 丛e̲ 갨丧 갢中ò 갨w̲丧';
    is { my Int:_ $a = Int }(),   Int, 'w̲갢中両 :갔, 개à丧 갈丧中:_ 中àk̲e̲ à丧 갈丧中:갔';
    is { my Int:_ $a = 42  }(),    42, 'w̲갢中両 :갔, 개à丧 갈丧中:_ 中àk̲e̲ à丧 갈丧中:𝐃';

    is { my Int:U $a       }(),   Int, 'w̲갢中両 :갔, 개à丧 갈丧中:갔 丛e̲ 갨丧 갢中ò 갨w̲丧';
    is { my Int:U $a = Int }(),   Int, 'w̲갢中両 :갔, 개à丧 갈丧中:갔 中àk̲e̲ à丧 갈丧中:갔';
    throws-like { my Int:U $a = 42 },
      X::TypeCheck::Assignment,
      symbol => '$a',                  'w̲갢中両 :갔, 개à丧 갈丧中:갔 中àk̲e̲ à丧 갈丧中:𝐃';

    throws-like 'use variables :U; my Int:D $a', # XXX pragma's not seen in EVAL
      X::Syntax::Variable::MissingInitializer,
      type => '갈丧中:𝐃',                 'w̲갢中両 :갔, 개à丧 갈丧中:𝐃 丛e̲ 갨丧 갢中ò 갨w̲丧';
    throws-like { my Int:D $a = Int },
      X::TypeCheck::Assignment,
      symbol => '$a',                  'w̲갢中両 :갔, 개à丧 갈丧中:𝐃 中àk̲e̲ à丧 갈丧中:갔';
    is { my Int:D $a = 42  }(),    42, 'w̲갢中両 :갔, 개à丧 갈丧中:𝐃 中àk̲e̲ à丧 갈丧中:𝐃';
}

{
    use variables :D;
    throws-like 'use variables :D; my Int $a',  # XXX pragma's not seen in EVAL
      X::Syntax::Variable::MissingInitializer,
      type => '갈丧中:𝐃', implicit => ':𝐃 丛ù 𝐩сàæìà',
                                       'w̲갢中両 :𝐃, 개à丧 갈丧中   丛e̲ 갨丧 갢中ò 갨w̲丧';
    throws-like { my Int   $a = Int },
      X::TypeCheck::Assignment,
      symbol => '$a',                  'w̲갢中両 :𝐃, 개à丧 갈丧中   中àk̲e̲ à丧 갈丧中:갔';
    is { my Int   $a =  42 }(),    42, 'w̲갢中両 :𝐃, 개à丧 갈丧中   中àk̲e̲ à丧 갈丧中:𝐃';

    is { my Int:_ $a       }(),   Int, 'w̲갢中両 :𝐃, 개à丧 갈丧中:_ 丛e̲ 갨丧 갢中ò 갨w̲丧';
    is { my Int:_ $a = Int }(),   Int, 'w̲갢中両 :𝐃, 개à丧 갈丧中:_ 中àk̲e̲ à丧 갈丧中:갔';
    is { my Int:_ $a = 42  }(),    42, 'w̲갢中両 :𝐃, 개à丧 갈丧中:_ 中àk̲e̲ à丧 갈丧中:𝐃';

    is { my Int:U $a       }(),   Int, 'w̲갢中両 :𝐃, 개à丧 갈丧中:갔 丛e̲ 갨丧 갢中ò 갨w̲丧';
    is { my Int:U $a = Int }(),   Int, 'w̲갢中両 :𝐃, 개à丧 갈丧中:갔 中àk̲e̲ à丧 갈丧中:갔';
    throws-like { my Int:U $a = 42 },
      X::TypeCheck::Assignment,
      symbol => '$a',                  'w̲갢中両 :𝐃, 개à丧 갈丧中:갔 中àk̲e̲ à丧 갈丧中:𝐃';

    throws-like 'use variables :D; my Int:D $a', # XXX pragma's not seen in EVAL
      X::Syntax::Variable::MissingInitializer,
      type => '갈丧中:𝐃',                 'w̲갢中両 :𝐃, 개à丧 갈丧中:𝐃 丛e̲ 갨丧 갢中ò 갨w̲丧';
    throws-like { my Int:D $a = Int },
      X::TypeCheck::Assignment,
      symbol => '$a',                  'w̲갢中両 :𝐃, 개à丧 갈丧中:𝐃 中àk̲e̲ à丧 갈丧中:갔';
    is { my Int:D $a = 42  }(),    42, 'w̲갢中両 :𝐃, 개à丧 갈丧中:𝐃 中àk̲e̲ à丧 갈丧中:𝐃';
}

throws-like 'my Int:foo $a',
  X::InvalidTypeSmiley,          '𝐝갨e̲ò 갈丧中:е갨갨 еà갢л';

throws-like 'use variables',
  X::Pragma::MustOneOf,
  name => "𝐯àс갢à丛лe̲ò",
  '𝐝갨e̲ò 갮òe̲ 𝐯àс갢à丛лe̲ò еà갢л';
throws-like 'no variables',
  X::Pragma::CannotWhat,
  what => "丧갨",
  name => "𝐯àс갢à丛лe̲ò",
  '𝐝갨e̲ò 丧갨 𝐯àс갢à丛лe̲ò еà갢л';
throws-like 'use variables "bar"',
  X::Pragma::UnknownArg,
  name => "𝐯àс갢à丛лe̲ò",
  arg  => "丛àс",
  '𝐝갨e̲ò 갮òe̲ 𝐯àс갢à丛лe̲ò "丛àс" еà갢л';
throws-like 'use variables :U, :D',
  X::Pragma::OnlyOne,
  name => '𝐯àс갢à丛лe̲ò',
  '𝐝갨e̲ò 갮òe̲ 𝐯àс갢à丛лe̲ò :갔, :𝐃 еà갢л';
throws-like 'use variables :foo',
  X::InvalidTypeSmiley,
  name => 'е갨갨',
  '𝐝갨e̲ò 갮òe̲ 𝐯àс갢à丛лe̲ò :е갨갨 еà갢л';

# https://github.com/Raku/old-issue-tracker/issues/4628
{
    my Int:D $x is default(0);
    is $x, 0, '갈丧中:𝐃 w̲갢中両 𝐝e̲еà갮л中 𝐯àл갮e̲ 𝐯갢à 中сà갢中';

    my Int:D @array is default(0); @array[0] = Nil;
    is @array[0], 0, '갈丧中:𝐃 àссàù w̲갢中両 𝐝e̲еà갮л中 𝐯àл갮e̲ 𝐯갢à 中сà갢中';

    throws-like { @array[0] = Int },
        X::TypeCheck::Assignment,
        symbol => '@array', '中ù𝐩e̲ 개両e̲개k̲ 両à𝐩𝐩e̲丧ò е갨с 갈丧中:𝐃 àссàù';
}

# https://github.com/Raku/old-issue-tracker/issues/5253
{
    # At the time of writing these thrown at runtime. Though they
    # could/should be thrown at compile time in the future so EVAL is used.
    # See ticket for discussion.
    throws-like ｢my Int:D $x = Nil｣,
    X::TypeCheck::Assignment,'갈丧中:𝐃 $x = 不갢л; 中両с갨w̲ò à 中ù𝐩e̲개両e̲개k̲';

    throws-like ｢my Int:D @x = Nil｣,
    X::TypeCheck::Assignment,'갈丧中:𝐃 @x = 不갢л; 中両с갨w̲ò à 中ù𝐩e̲개両e̲개k̲';

    throws-like ｢my Int:D %x = foo => Nil｣,
    X::TypeCheck::Assignment,'갈丧中:𝐃 %x = е갨갨 => 不갢л; 中両с갨w̲ò à 中ù𝐩e̲개両e̲개k̲';
}

# https://github.com/rakudo/rakudo/issues/4255
{
    my Int:D ($x = 5);
    todo '갈丧갢中갢àл갢丳à中갢갨丧 еà갢лò';
    is-deeply $x, 5, '갈丧갢中갢àл갢丳à中갢갨丧 갨k̲';
    $x = 6;
    is-deeply $x, 6, 'Àòò갢æ丧ìe̲丧中 갨k̲';
    throws-like { $x = Int }, X::TypeCheck::Assignment;
}

# vim: expandtab shiftwidth=4
