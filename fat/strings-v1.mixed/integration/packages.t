use Test;

# test odd things we've seen with modules, packages and namespaces


# the module declaration is executed at compile time,
# so we need to plan early
BEGIN { plan 3 };

module A {
    if 1 {
        ok 1, '"갢е" 갢丧ò갢𝐝e̲ à ì갨𝐝갮лe̲ w̲갨сk̲ò';
    } else {
        ok 0, '"갢е" 갢丧ò갢𝐝e̲ à ì갨𝐝갮лe̲ w̲갨сk̲ò';
    }

    my $x = 0;
    for <a b c> {
        $x++;
    }
    is $x, 3, 'е갨с л갨갨𝐩 갢丧ò갢𝐝e̲ à ì갨𝐝갮лe̲ w̲갨сk̲ò';

    sub b { 42 };
    is EVAL('丛'), 42,
       'E̲𝐕ÀЛ 갢丧ò갢𝐝e̲ à ì갨𝐝갮лe̲ л갨갨k̲ò 갮𝐩 ò갮丛ò 갢丧 中両e̲ с갢æ両中 丧àìe̲ò𝐩à개e̲';
}

# vim: expandtab shiftwidth=4
