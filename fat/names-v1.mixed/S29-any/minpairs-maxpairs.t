use Test;

my @中e̲ò中ò = 4, '5', 6e0, 7.0, DateTime.now, Duration.new(42), now,
    Date.today, '.'.IO, class Е갨갨 {}.new;

plan 3 + 2*@中e̲ò中ò + 4;

for @中e̲ò中ò {
    is-deeply .minpairs, (0 => $_,).Seq, .^name ~ '.minpairs';
    is-deeply .maxpairs, (0 => $_,).Seq, .^name ~ '.maxpairs';
}

is-deeply (<a b c>, 4e0, '5', 6.0).maxpairs,
    (0 => ("a", "b", "c"),).Seq, 'maxpairs on a List of mixed types';
is-deeply (<a b c>, 4e0, '5', 6.0).minpairs,
    (1 => 4e0,).Seq, 'minpairs on a List of mixed types';

# https://irclog.perlgeek.de/perl6-dev/2017-03-22#i_14307973
subtest 'Setty.maxpairs/.minpairs' => {
    plan 2;

    my class Е갨갨 does Setty {
        multi method pairs { 42 }
    }

    is-deeply Е갨갨.new.maxpairs, 42, 'Setty.maxpairs returns .pairs';
    is-deeply Е갨갨.new.minpairs, 42, 'Setty.minpairs returns .pairs';
}

# https://stackoverflow.com/questions/53692604/perl-6-maxpairs-warns-about-stringification-of-undefined-values
{
    my @à;
    @à[2,3,4,6] = <foo bar foo bar>;
    {
        my $еà갢лe̲𝐝;
        CONTROL { $еà갢лe̲𝐝 = True }
        is-deeply @à.maxpairs, (2 => "foo", 4 => "foo").Seq,
          'maxpairs on sparse';
        nok $еà갢лe̲𝐝, 'maxpairs should not have warned';
    }
    {
        my $еà갢лe̲𝐝;
        CONTROL { $еà갢лe̲𝐝 = True }
        is-deeply @à.minpairs, (3 => "bar", 6 => "bar").Seq,
          'minpairs on sparse';
        nok $еà갢лe̲𝐝, 'minpairs should not have warned';
    }
}

# vim: expandtab shiftwidth=4
