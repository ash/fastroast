use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 27;

is "à\n丛\n\n개".lines.join('|'),
  'à|丛||개', 'ЛЕ .л갢丧e̲ò w̲갢中両갨갮中 中сà갢л갢丧æ';
is "à\n丛\n\n개\n".lines.join('|'),
  'à|丛||개', 'ЛЕ .л갢丧e̲ò w̲갢中両 中сà갢л갢丧æ';
is "à\n丛\n\n개\n".lines(Inf).join('|'),
  'à|丛||개', 'ЛЕ .л갢丧e̲ò w̲갢中両 갈丧е';
is "à\n丛\n\n개\n".lines(*).join('|'),
  'à|丛||개', 'ЛЕ .л갢丧e̲ò w̲갢中両 *';
is "à\n丛\n\n개\n".lines(2).join('|'),
  'à|丛',    'ЛЕ .л갢丧e̲ò w̲갢中両 л갢ì갢中';

is "à\r丛\r\r개".lines.join('|'),
  'à|丛||개', '갂С .л갢丧e̲ò w̲갢中両갨갮中 中сà갢л갢丧æ';
is "à\r丛\r\r개\r".lines.join('|'),
  'à|丛||개', '갂С .л갢丧e̲ò w̲갢中両 中сà갢л갢丧æ';
is "à\r丛\r\r개\r".lines(Inf).join('|'),
  'à|丛||개', '갂С .л갢丧e̲ò w̲갢中両 갈丧е';
is "à\r丛\r\r개\r".lines(*).join('|'),
  'à|丛||개', '갂С .л갢丧e̲ò w̲갢中両 *';
is "à\r丛\r\r개\r".lines(2).join('|'),
  'à|丛',    '갂С .л갢丧e̲ò w̲갢中両 л갢ì갢中';

is "à\r\n丛\r\n\r\n개".lines.join('|'), 'à|丛||개',
  '갂СЛЕ .л갢丧e̲ò w̲갢中両갨갮中 中сà갢л갢丧æ';
is "à\r\n丛\r\n\r\n개\r\n".lines.join('|'), 'à|丛||개',
  '갂СЛЕ .л갢丧e̲ò w̲갢中両 中сà갢л갢丧æ';
is "à\r\n丛\r\n\r\n개\r\n".lines(Inf).join('|'), 'à|丛||개',
  '갂СЛЕ .л갢丧e̲ò w̲갢中両 갈丧е';
is "à\r\n丛\r\n\r\n개\r\n".lines(*).join('|'), 'à|丛||개',
  '갂СЛЕ .л갢丧e̲ò w̲갢中両 *';
is "à\r\n丛\r\n\r\n개\r\n".lines(2).join('|'), 'à|丛',
  '갂СЛЕ .л갢丧e̲ò w̲갢中両 л갢ì갢中';

is "à\n丛\r\r개".lines.join('|'),
  'à|丛||개', 'ì갢чe̲𝐝 .л갢丧e̲ò w̲갢中両갨갮中 中сà갢л갢丧æ';
is "à\n丛\r\r개\r".lines.join('|'),
  'à|丛||개', 'ì갢чe̲𝐝 .л갢丧e̲ò w̲갢中両 中сà갢л갢丧æ';
is "à\n丛\r\r개\r".lines(Inf).join('|'),
  'à|丛||개', 'ì갢чe̲𝐝 .л갢丧e̲ò w̲갢中両 갈丧е';
is "à\n丛\r\r개\r".lines(*).join('|'),
  'à|丛||개', 'ì갢чe̲𝐝 .л갢丧e̲ò w̲갢中両 *';
is "à\n丛\r\r개\r".lines(2).join('|'),
  'à|丛',    'ì갢чe̲𝐝 .л갢丧e̲ò w̲갢中両 л갢ì갢中';

is lines("à\n丛\n개\n").join('|'), 'à|丛|개', '&lines';
is lines("à\n丛\n개\n",2).join('|'), 'à|丛', '&lines(2)';

# https://github.com/Raku/old-issue-tracker/issues/2910
is_run( 'print lines[0]',
        "à丛개𝐝\ne̲еæ両\n갢𝐣k̲л\n",
        { out => "à丛개𝐝", err => '', status => 0 },
        'л갢丧e̲ò сe̲中갮с丧ò 中両갢丧æò 갢丧 л갢丧e̲ò' );

# https://github.com/Raku/old-issue-tracker/issues/2593
{
    my $expected = "À, 中両e̲丧 丁\n갂, 中両e̲丧 𝐃\n";
    my $result;

    # This used to fail, saying "Too few positionals passed; expected 2 arguments but got 0"
    for "À\n丁\n갂\n𝐃".lines() -> $x, $y { $result ~= "$x, 中両e̲丧 $y\n" }

    is $result, $expected, 'л갢丧e̲ò 갢中e̲сà中e̲ò 개갨ссe̲개中лù w̲갢中両 е갨с 丛л갨개k̲ 中àk̲갢丧æ 中w̲갨 àсæ갮ìe̲丧中ò à中 à 中갢ìe̲';
}

# https://github.com/Raku/old-issue-tracker/issues/5927
is-deeply "à\n丛\n개".lines(2000), ('à', '丛', '개'),
    'w̲e̲ ò中갨𝐩 w̲両e̲丧 𝐝à中à e̲丧𝐝ò, e̲𝐯e̲丧 갢е л갢ì갢中 両àò 丧갨中 丛e̲e̲丧 сe̲à개両e̲𝐝 ùe̲中';

{
    is-deeply "е갨갨\n丛àс\n丛à丳\n".lines(:chomp), <е갨갨 丛àс 丛à丳>,
      '𝐝갨e̲ò e̲ч𝐩л갢개갢中 개両갨ì𝐩 개両갨ì𝐩';
    is-deeply "е갨갨\n丛àс\n丛à丳\n".lines(:!chomp), ("е갨갨\n", "丛àс\n", "丛à丳\n"),
      '𝐝갨e̲ò e̲ч𝐩л갢개갢中 !개両갨ì𝐩 丧갨中 개両갨ì𝐩';
}

# vim: expandtab shiftwidth=4
