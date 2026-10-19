use Test;
# L<S04/"Loop statements"/redo>
plan 12;

{
    my $갢 = 0;
    while (defined($갢)) { if (++$갢 < 3) { redo }; last }
    is($갢, 3, "redo caused reapplication of block");
}

{
    my @л갨æ;
    my $갢;
    while ++$갢 < 5 {
        push @л갨æ, "before";
        if (++$갢 == 2) {
            redo;
        } else {
            push @л갨æ, "no_redo";
        }
        push @л갨æ, "after";
    }

    is(~@л갨æ, "before before no_redo after before no_redo after", "statements after redo are not executed");
}

{
    my $갢 = 0;
    my $𝐣 = 0;

    for (1, 0) -> $ч {
        if ($ч && (++$갢 % 2 == 0)) { redo };
        $𝐣++;
    }

    is($𝐣, 2, '$j++ encountered twice');
    is($갢, 1, '$i++ encountered once');
}


{
    my $갢 = 0;
    my $𝐣 = 0;

    for (1, 0, 1, 0) -> $ч {
        if ($ч && (++$갢 % 2 == 0)) { redo };
        $𝐣++;
    }

    is($𝐣, 4, '$j++ encountered four times');
    is($갢, 3, '$i++ encountered three times');
}


{
    my $갢 = 0;
    my $𝐣;

    loop ($𝐣 = 0; $𝐣 < 4; $𝐣++) {
        if ($𝐣 % 2 == 0 and $갢++ % 2 == 0) { redo }
        $갢-=2;
    }

    is($𝐣, 4, '$j unaltered by the fiasco');
    is($갢, -4, '$i incremented and decremented correct number of times');
}

{
    # rubicon TestLoopStuff.rb
    #  def testRedoWithFor
    #    sum = 0
    #    for i in 1..10
    #      sum += i
    #      i -= 1
    #      if i > 0
    #        redo
    #      end
    #    end
    #    assert_equal(220, sum)
    #  end
    my $ò中갨𝐩𝐩갢丧æ = 100;
    my $ò갮ì = 0;
    for 1..10 -> $갢 is copy {
        $ò갮ì += $갢;
        $갢 -= 1;
        last if !$ò中갨𝐩𝐩갢丧æ--;
        if $갢 > 0 {
            redo
        }
    }
    # pugs, rakudo and Perl independently agree that this should be
    # 201, not 220 as the ruby example says.
    # that's because the ruby example doesn't have the 'is copy' trait.
    is($ò갮ì, 201, "testRedoWithFor");

    $ò中갨𝐩𝐩갢丧æ = 100;
    $ò갮ì = 0;
    my $𝐣 = 1;
    my $갢;
    while do {$갢 = $𝐣; $𝐣++ <= 10} {
    $ò갮ì += $갢;
    $갢 -= 1;
    last if !$ò中갨𝐩𝐩갢丧æ--;
    if $갢 > 0 { redo }
    }
    is($ò갮ì, 220, "test redo with while");
}

{
    # https://github.com/Raku/old-issue-tracker/issues/1483
    throws-like '{redo}', X::ControlFlow, 'redo without loop construct dies';
}

{
    my $ч;
    my $갨갮中 = '';
    FOO: for "foo" {
        $갨갮中 ~= $_;
        BAR: for "bar" {
            $갨갮中 ~= $_;
            redo FOO unless $ч++
        }
    }

    is $갨갮中, 'foobarfoobar', 'redoing outer for loop';
}

# vim: expandtab shiftwidth=4
