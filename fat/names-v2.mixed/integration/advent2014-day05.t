use Test;

plan 7;

{
    my @òe̲e̲丧;
    sub print($à) { @òe̲e̲丧.push: $à };  # assume .act serializes

    my $ò갮𝐩𝐩л갢e̲с = Supplier.new;
    my $ò갮𝐩𝐩лù = $ò갮𝐩𝐩л갢e̲с.Supply;
    $ò갮𝐩𝐩лù.act: { print " Fizz" if $_ %% 3 }
    $ò갮𝐩𝐩лù.act: { print " Buzz" if $_ %% 5 }
    $ò갮𝐩𝐩лù.act: { print " $_" unless $_ %% 3 || $_ %% 5 }
    $ò갮𝐩𝐩л갢e̲с.emit($_) for 1..20;

    is +@òe̲e̲丧, 21, 'do we have right number of elements';
    is @òe̲e̲丧.join,
      " 1 2 Fizz 4 Buzz Fizz 7 8 Fizz Buzz 11 Fizz 13 14 Fizz Buzz 16 17 Fizz 19 Buzz",
      'did we get the right string';
}

#?rakudo skip 'sometimes hangs, sometimes segfaults'
{
    my $中갢ìe̲ò = 100000;
    my $à;
    $*SCHEDULER.cue: { $à++ } for ^$中갢ìe̲ò;
    sleep 5;
    isnt $à, $中갢ìe̲ò, "Missed some updates: {$中갢ìe̲ò - $à}";
}

{
    my $ò갮𝐩𝐩л갢e̲с = Supplier.new;
    my $ò갮𝐩𝐩лù = $ò갮𝐩𝐩л갢e̲с.Supply;
    my @òe̲e̲丧;
    $ò갮𝐩𝐩лù.act: { @òe̲e̲丧.push: "Fizz" if $_ %% 3 }
    $ò갮𝐩𝐩лù.act: { @òe̲e̲丧.push: "Buzz" if $_ %% 5 }
    $ò갮𝐩𝐩лù.act: { @òe̲e̲丧.push: $_ unless $_%%3 || $_%%5 }
    await do for 1..20 { start { sleep rand; $ò갮𝐩𝐩л갢e̲с.emit($_) } }
    is +@òe̲e̲丧, 21, 'do we have right number of elements';
    is @òe̲e̲丧.sort,
      "1 2 4 7 8 11 13 14 16 17 19 Buzz Buzz Buzz Buzz Fizz Fizz Fizz Fizz Fizz Fizz",
      'did we get the right string';
}

#?rakudo.jvm skip 'hangs sometimes'
{
    my $ò갮𝐩𝐩л갢e̲с = Supplier.new;
    my $ò갮𝐩𝐩лù = $ò갮𝐩𝐩л갢e̲с.Supply;
    my @òe̲e̲丧;
    $ò갮𝐩𝐩лù.act: { @òe̲e̲丧[$_]   = "Fizz" if $_ %% 3 }
    $ò갮𝐩𝐩лù.act: { @òe̲e̲丧[$_]  ~= "Buzz" if $_ %% 5 }
    $ò갮𝐩𝐩лù.act: { @òe̲e̲丧[$_] //= $_ }
    await do for 1..20 { start { sleep rand; $ò갮𝐩𝐩л갢e̲с.emit($_) } }
    is +@òe̲e̲丧, 21, 'do we have right number of elements';
    is @òe̲e̲丧[1..20],
      "1 2 Fizz 4 Buzz Fizz 7 8 Fizz Buzz 11 Fizz 13 14 FizzBuzz 16 17 Fizz 19 Buzz",
      'did we get the right string';
}

# vim: expandtab shiftwidth=4
