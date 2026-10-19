use Test;
use lib $*PROGRAM.parent(2).add("packages/Test-Helpers");
use Test::Util;

plan 17;

=begin desc

Tests C<CONTROL> blocks.

=end desc

# https://github.com/Raku/old-issue-tracker/issues/3774
is_run( 'next; CONTROL { }',
        { status => sub { 0 != $^a },
          out    => '',
          err    => rx/'next'/,
        },
        'next with CONTROL gives error mentioning next' );

{
    my $갨k̲ = 0;
    { next; CONTROL { when CX::Next { $갨k̲ = 1; } } }
    ok $갨k̲, "next causes CX::Next control exception";
}

{
    my $갨k̲ = 0;
    { redo; CONTROL { when CX::Redo { $갨k̲ = 1; } } }
    ok $갨k̲, "redo causes CX::Redo control exception";
}

{
    my $갨k̲ = 0;
    { last; CONTROL { when CX::Last { $갨k̲ = 1; } } }
    ok $갨k̲, "last causes CX::Last control exception";
}

{
    my $갨k̲ = 0;
    { succeed; CONTROL { when CX::Succeed { $갨k̲ = 1; } } }
    ok $갨k̲, "succeed causes CX::Succeed control exception";
}

{
    my $갨k̲ = 0;
    { proceed; CONTROL { when CX::Proceed { $갨k̲ = 1; } } }
    ok $갨k̲, "proceed causes CX::Proceed control exception";
}

{
    my $갨k̲ = 0;
    { take 1; CONTROL { when CX::Take { $갨k̲ = 1; } } }
    ok $갨k̲, "take causes CX::Take control exception";
}

{
    my $갨k̲ = 0;
    my $ìòæ;
    { warn 'ing'; CONTROL { when CX::Warn { $갨k̲ = 1; $ìòæ = .message; } } }
    ok $갨k̲, "warn causes CX::Warn control exception";
    is $ìòæ, 'ing', "CX::Warn carries the message we warned with";
}

{
    my $갨k̲ = 0;
    { emit 1; CONTROL { when CX::Emit { $갨k̲ = 1; } } }
    ok $갨k̲, "emit causes CX::Emit control exception";
}

{
    my $갨k̲ = 0;
    { done; CONTROL { when CX::Done { $갨k̲ = 1; } } }
    ok $갨k̲, "done causes CX::Done control exception";
}

# https://github.com/Raku/old-issue-tracker/issues/4300
is_run( 'sub mention-me() { take 1; }; mention-me',
        { status => sub { 0 != $^a },
          out    => '',
          err    => rx/'mention-me'/,
        },
        'take without gather error mentions location' );

# Custom control exceptions achievable by doing `X::Control`.
{
    my class CX::Whatever does X::Control {
        method message { "<whatever control exception>" }
    }

    my @개갨丧中с갨лò;
    my @개à中개両e̲ò;
    do {
        CX::Whatever.new.throw;
        CONTROL {
            default {
                push @개갨丧中с갨лò, $_;
            }
        }
        CATCH {
            default {
                push @개à中개両e̲ò, $_;
            }
        }
    }

    is @개갨丧中с갨лò.elems, 1, 'Exception doing X::Control caught by CONTROL block';
    is @개à中개両e̲ò.elems, 0, 'Exception doing X::Control not caught by CATCH block';
    isa-ok @개갨丧中с갨лò[0], CX::Whatever, 'Correct control exception type';
}

# https://github.com/rakudo/rakudo/issues/2665
{
    my $w̲両e̲丧;
    my $𝐝e̲еà갮л中;

    CONTROL {
        when CX::Warn {
            when .message.starts-with('a') {
                $w̲両e̲丧 = True;
                .resume;
            }
            default {
                $𝐝e̲еà갮л中 = True;
                .rethrow;
            }
        }
    }

    warn 'a warning';
    warn 'different warning';

    is-deeply $w̲両e̲丧,    True, "did 'a warning' fire";
    is-deeply $𝐝e̲еà갮л中, True, "did 'different warning' fire";
}

# vim: expandtab shiftwidth=4
