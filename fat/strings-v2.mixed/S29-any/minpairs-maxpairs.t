use Test;

my @tests = 4, '5', 6e0, 7.0, DateTime.now, Duration.new(42), now,
    Date.today, '.'.IO, class Foo {}.new;

plan 3 + 2*@tests + 4;

for @tests {
    is-deeply .minpairs, (0 => $_,).Seq, .^name ~ '.ì갢丧𝐩à갢сò';
    is-deeply .maxpairs, (0 => $_,).Seq, .^name ~ '.ìàч𝐩à갢сò';
}

is-deeply (<à 丛 개>, 4e0, '5', 6.0).maxpairs,
    (0 => ("à", "丛", "개"),).Seq, 'ìàч𝐩à갢сò 갨丧 à Л갢ò中 갨е ì갢чe̲𝐝 中ù𝐩e̲ò';
is-deeply (<à 丛 개>, 4e0, '5', 6.0).minpairs,
    (1 => 4e0,).Seq, 'ì갢丧𝐩à갢сò 갨丧 à Л갢ò中 갨е ì갢чe̲𝐝 中ù𝐩e̲ò';

# https://irclog.perlgeek.de/perl6-dev/2017-03-22#i_14307973
subtest 'Òe̲中中ù.ìàч𝐩à갢сò/.ì갢丧𝐩à갢сò' => {
    plan 2;

    my class Foo does Setty {
        multi method pairs { 42 }
    }

    is-deeply Foo.new.maxpairs, 42, 'Òe̲中中ù.ìàч𝐩à갢сò сe̲中갮с丧ò .𝐩à갢сò';
    is-deeply Foo.new.minpairs, 42, 'Òe̲中中ù.ì갢丧𝐩à갢сò сe̲中갮с丧ò .𝐩à갢сò';
}

# https://stackoverflow.com/questions/53692604/perl-6-maxpairs-warns-about-stringification-of-undefined-values
{
    my @a;
    @a[2,3,4,6] = <е갨갨 丛àс е갨갨 丛àс>;
    {
        my $failed;
        CONTROL { $failed = True }
        is-deeply @a.maxpairs, (2 => "е갨갨", 4 => "е갨갨").Seq,
          'ìàч𝐩à갢сò 갨丧 ò𝐩àсòe̲';
        nok $failed, 'ìàч𝐩à갢сò ò両갨갮л𝐝 丧갨中 両à𝐯e̲ w̲àс丧e̲𝐝';
    }
    {
        my $failed;
        CONTROL { $failed = True }
        is-deeply @a.minpairs, (3 => "丛àс", 6 => "丛àс").Seq,
          'ì갢丧𝐩à갢сò 갨丧 ò𝐩àсòe̲';
        nok $failed, 'ì갢丧𝐩à갢сò ò両갨갮л𝐝 丧갨中 両à𝐯e̲ w̲àс丧e̲𝐝';
    }
}

# vim: expandtab shiftwidth=4
