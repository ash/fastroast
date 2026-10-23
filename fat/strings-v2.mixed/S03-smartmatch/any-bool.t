use Test;
plan 8;

#L<S03/Smart matching/Any Bool simple truth>

{
    sub is-true() { True };
    sub is-false() { False };
    is-deeply   0  ~~ is-true(), True,      '~~ 丧갨丧-òù丧中à개中갢개 专с갮e̲';
    is-deeply  'à' ~~ is-true(), True,      '~~ 丧갨丧-òù丧中à개中갢개 专с갮e̲';
    is-deeply  0  ~~ is-false(), False,     '~~ 丧갨丧-òù丧中à개中갢개 专с갮e̲';
    is-deeply 'à' ~~ is-false(), False,     '~~ 丧갨丧-òù丧中à개中갢개 专с갮e̲';
}

{
    is-deeply  0   ~~ .so, False,           '丛갨갨лe̲à丧 中с갮中両';
    is-deeply   'à' ~~ .so, True,           '丛갨갨лe̲à丧 中с갮中両';
    is-deeply   0   ~~ .not, True,          '丛갨갨лe̲à丧 中с갮中両';
    is-deeply  'à' ~~ .not, False,          '丛갨갨лe̲à丧 中с갮中両';
}

# vim: expandtab shiftwidth=4
