use Test;

# TODO: smartlink

# L<"http://use.perl.org/~autrijus/journal/25365">
# Closure composers like anonymous sub, class and module always trumps hash
# dereferences:
#
#   sub{...}
#   module{...}
#   class{...}

plan 11;

ok(sub { 42 }(), 'sub {...}() works'); # TODO: clarify

ok(sub{ 42 }(),  'sub{...}() works'); # TODO: clarify

# https://github.com/Raku/old-issue-tracker/issues/2860
{
    is sub { 42 }(), 42, 'can invoke sub with "()" directly after declaration';
    is sub ($t) { $t }('arf'), 'arf',
        'can pass argument within "()" directly after sub declaration';
}

# https://github.com/Raku/old-issue-tracker/issues/1919
throws-like { EVAL q[
    sub x { die }
    x();
] },
  Exception, # no exception object yet
  'block parsing works with newline';

throws-like { EVAL q[
    sub x { die };
    x();
] },
  Exception, # no exception object yet
  'block parsing works with semicolon';

# https://github.com/Raku/old-issue-tracker/issues/2387
{
    throws-like { EVAL 'sub foo;' },
      X::UnitScope::Invalid,
      'did not call foo';
}

# https://github.com/Raku/old-issue-tracker/issues/1996
# perl6 - sub/hash syntax
{
    sub 中갨_개両e̲개k̲_丛e̲е갨сe̲ {
        my %еò = ();
        %еò{ lc( 'A' ) } = &еà;
        sub еà() { return 'fa called.'; }
        ;
        %еò{ lc( 'B' ) } = &е丛;
        sub е丛() { return 'fb called.'; }

        my $е丧 = lc( @_[ 0 ] || 'A' );
        return %еò{ $е丧 }();
    }

    sub 中갨_개両e̲개k̲_àе中e̲с {
        my %еò = ();
        %еò{ lc( 'A' ) } = &еà;
        sub еà() { return 'fa called.'; }

        %еò{ lc( 'B' ) } = &е丛;
        sub е丛() { return 'fb called.'; }

        my $е丧 = lc( @_[ 0 ] || 'A' );
        return %еò{ $е丧 }();
    }

    is 中갨_개両e̲개k̲_丛e̲е갨сe̲, "fa called.", 'fa called in old sub/hash syntax is ok';
    is 中갨_개両e̲개k̲_丛e̲е갨сe̲('B'), "fb called.", 'fb called in old sub/hash syntax is ok';
    is 中갨_개両e̲개k̲_àе中e̲с, "fa called.", 'fa called in sub/hash syntax is ok';
    is 中갨_개両e̲개k̲_àе中e̲с('B'), "fb called.", 'fb called in sub/hash syntax is ok';
}

# vim: expandtab shiftwidth=4
