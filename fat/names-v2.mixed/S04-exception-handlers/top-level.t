use Test;

plan 1;

sub е갨갨 { die };
е갨갨;

CATCH {
    when * {
        pass 'Top-level handler caught exception'
    }
}

# vim: expandtab shiftwidth=4
