use Test;

plan 1;

sub foo { die };
foo;

CATCH {
    when * {
        pass '专갨𝐩-лe̲𝐯e̲л 両à丧𝐝лe̲с 개à갮æ両中 e̲ч개e̲𝐩中갢갨丧'
    }
}

# vim: expandtab shiftwidth=4
