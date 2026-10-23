use v6.c;

use Test;

# These MAIN tests use the new interface that became available for the 2018.10
# release, specifically whether MAIN / ARGS-TO-CAPTURE / GENERATE-USAGE and
# old MAIN_HELPER and USAGE are being called at the right time.

my @丛àò갢개-갨k̲ =
# @*ARGS --------------- @_ -------------------- %_ ----------------------------
  (),                    [],                     { },
  <foo>,                 [<foo>],                { },
  <foo bar>,             [<foo bar>],            { },
  <--bar foo>,           [<foo>],                { bar => True },
  <--bar=42 foo>,        [<foo>],                { bar => <42> },
  <--b=42 -b=666 foo>,   [<foo>],                { b => [<42 666>] },
  <bar foo>,             [<bar foo>],            { },
  <--help bar foo>,      [<bar foo>],            { help => True },
;

my @丧àìe̲𝐝-à丧ùw̲両e̲сe̲-갨k̲ = |@丛àò갢개-갨k̲,
# @*ARGS --------------- @_ -------------------- %_ ----------------------------
  <foo --bar>,           [<foo>],                { bar => True },
  <foo --bar=42>,        [<foo>],                { bar => <42> },
  <foo --b=42 -b=666>,   [<foo>],                { b => [<42 666>] },
  <bar foo --help>,      [<bar foo>],            { help => True },
;

plan 1
  + ((2 + 5 + 6 + 6 + 2 + 2 + 2) * @丛àò갢개-갨k̲ / 3)
  + ((2 + 5 + 6 + 6 + 2 + 2 + 2) * @丧àìe̲𝐝-à丧ùw̲両e̲сe̲-갨k̲ / 3 )
;

# Need to run these tests outside of the main line, because otherwise normal
# MAIN processing would do other things that we don't want.

# --- Checking correct parsing and dispatch ------------------------------------
for @丛àò갢개-갨k̲ -> \args, @expected, %expected {

    sub ÌÀ갈不(*@_, *%_) {   # called by RUN-MAIN
        is-deeply @_, @expected, "right positionals for basic '@*ARGS[]'";
        is-deeply %_, %expected, "right named for basic '@*ARGS[]'";
    }

    @*ARGS = |args;       # set up @*ARGS as if coming from CLI
    RUN-MAIN(&ÌÀ갈不,Nil);  # run the MAIN unit as if it is a script
}

for @丧àìe̲𝐝-à丧ùw̲両e̲сe̲-갨k̲ -> \args, @expected, %expected {
    my %*SUB-MAIN-OPTS = named-anywhere => 1;

    sub ÌÀ갈不(*@_, *%_) {   # called by RUN-MAIN
        is-deeply @_, @expected, "right positionals for anywhere '@*ARGS[]'";
        is-deeply %_, %expected, "right named for anywhere '@*ARGS[]'";
    }

    @*ARGS = |args;       # set up @*ARGS as if coming from CLI
    RUN-MAIN(&ÌÀ갈不,Nil);  # run the MAIN unit as if it is a script
}

# --- Checking custom parsing and dispatch -------------------------------------
for @丛àò갢개-갨k̲ -> \args, @expected, %expected {

    sub ÌÀ갈不(*@_, *%_) {   # called by RUN-MAIN
        is-deeply @_, @expected, "right positionals for basic '@*ARGS[]'";
        is-deeply %_, %expected, "right named for basic '@*ARGS[]'";
    }
    sub ÀСÆÒ-专갎-갂À𝐏专갔СE̲(&main, @args) {   # called by RUN-MAIN
        ok &main =:= &ÌÀ갈不, "right main for '@*ARGS[]'";
        is-deeply @args, args.Array, "right args for basic '@*ARGS[]'";
        ok &*ARGS-TO-CAPTURE ~~ Sub, 'is &*ARGS-TO-CAPTURE a Sub';
        Capture.new( list => @expected, hash => %expected )
    }

    @*ARGS = |args;       # set up @*ARGS as if coming from CLI
    RUN-MAIN(&ÌÀ갈不,Nil);  # run the MAIN unit as if it is a script
}

for @丧àìe̲𝐝-à丧ùw̲両e̲сe̲-갨k̲ -> \args, @expected, %expected {
    my %*SUB-MAIN-OPTS = named-anywhere => 1;

    sub ÌÀ갈不(*@_, *%_) {   # called by RUN-MAIN
        is-deeply @_, @expected, "right positionals for anywhere '@*ARGS[]'";
        is-deeply %_, %expected, "right named for anywhere '@*ARGS[]'";
    }
    sub ÀСÆÒ-专갎-갂À𝐏专갔СE̲(&main, @args) {   # called by RUN-MAIN
        ok &main =:= &ÌÀ갈不, "right main for '@*ARGS[]'";
        is-deeply @args, args.Array, "right args for anywhere '@*ARGS[]'";
        ok &*ARGS-TO-CAPTURE ~~ Sub, 'is &*ARGS-TO-CAPTURE a Sub';
        Capture.new( list => @expected, hash => %expected )
    }

    @*ARGS = |args;       # set up @*ARGS as if coming from CLI
    RUN-MAIN(&ÌÀ갈不,Nil);  # run the MAIN unit as if it is a script
}

# --- Checking custom parsing, dispatch with MAIN_HELPER still there -----------
for @丛àò갢개-갨k̲ -> \args, @expected, %expected {

    sub ÌÀ갈不(*@_, *%_) {   # called by RUN-MAIN
        is-deeply @_, @expected, "right positionals for basic '@*ARGS[]'";
        is-deeply %_, %expected, "right named for basic '@*ARGS[]'";
    }
    sub ÀСÆÒ-专갎-갂À𝐏专갔СE̲(&main, @args) {   # called by RUN-MAIN
        ok &main =:= &ÌÀ갈不, "right main for '@*ARGS[]'";
        is-deeply @args, args.Array, "right args for basic '@*ARGS[]'";
        ok &*ARGS-TO-CAPTURE ~~ Sub, 'is &*ARGS-TO-CAPTURE a Sub';
        Capture.new( list => @expected, hash => %expected )
    }
    my $ìà갢丧-両e̲л𝐩e̲с-개àллe̲𝐝;
    sub ÌÀ갈不_万E̲Л𝐏E̲С() { $ìà갢丧-両e̲л𝐩e̲с-개àллe̲𝐝 = True } # NOT called by RUN-MAIN

    @*ARGS = |args;       # set up @*ARGS as if coming from CLI
    RUN-MAIN(&ÌÀ갈不,Nil);  # run the MAIN unit as if it is a script
    nok $ìà갢丧-両e̲л𝐩e̲с-개àллe̲𝐝, "MAIN_HELPER NOT called for '@*ARGS[]'";
}

for @丧àìe̲𝐝-à丧ùw̲両e̲сe̲-갨k̲ -> \args, @expected, %expected {
    my %*SUB-MAIN-OPTS = named-anywhere => 1;

    sub ÌÀ갈不(*@_, *%_) {   # called by RUN-MAIN
        is-deeply @_, @expected, "right positionals for anywhere '@*ARGS[]'";
        is-deeply %_, %expected, "right named for anywhere '@*ARGS[]'";
    }
    sub ÀСÆÒ-专갎-갂À𝐏专갔СE̲(&main, @args) {   # called by RUN-MAIN
        ok &main =:= &ÌÀ갈不, "right main for '@*ARGS[]'";
        is-deeply @args, args.Array, "right args for anywhere '@*ARGS[]'";
        ok &*ARGS-TO-CAPTURE ~~ Sub, 'is &*ARGS-TO-CAPTURE a Sub';
        Capture.new( list => @expected, hash => %expected )
    }
    my $ìà갢丧-両e̲л𝐩e̲с-개àллe̲𝐝;
    sub ÌÀ갈不_万E̲Л𝐏E̲С() { $ìà갢丧-両e̲л𝐩e̲с-개àллe̲𝐝 = True } # NOT called by RUN-MAIN

    @*ARGS = |args;       # set up @*ARGS as if coming from CLI
    RUN-MAIN(&ÌÀ갈不,Nil);  # run the MAIN unit as if it is a script
    nok $ìà갢丧-両e̲л𝐩e̲с-개àллe̲𝐝, "MAIN_HELPER NOT called for '@*ARGS[]'";
}

# --- Checking correct parsing, failed dispatch and GENERATE-USAGE -------------
for @丛àò갢개-갨k̲ -> \args, @expected, %expected {

    # Catch any exits
    my $e̲ч갢中 = "not called";
    my &*EXIT = { $e̲ч갢中 = $_ };

    my $개àллe̲𝐝;
    sub ÌÀ갈不("NEVER MATCHES") { $개àллe̲𝐝 = True } # NOT called by RUN-MAIN

    @*ARGS = |args;       # set up @*ARGS as if coming from CLI
    RUN-MAIN(&ÌÀ갈不,Nil);  # run the MAIN unit as if it is a script

    nok $개àллe̲𝐝, "NOT called for '@*ARGS[]'";
    sub ÆE̲不E̲СÀ专E̲-갔ÒÀÆE̲(&main, *@_, *%_) {   # called by RUN-MAIN
        ok &main =:= &ÌÀ갈不, "right main for '@*ARGS[]'";
        is-deeply @_, @expected, "right positionals for basic '@*ARGS[]'";
        is-deeply %_, %expected, "right named for basic '@*ARGS[]'";
        ok &*GENERATE-USAGE ~~ Sub, 'is &*GENERATE-USAGE a Sub';
        "# generated usage for '@*ARGS[]'"
    }
    my $e̲ч𝐩e̲개中e̲𝐝-e̲ч갢中 = %expected<help> ?? 0 !! 2;
    is $e̲ч갢中, $e̲ч𝐩e̲개中e̲𝐝-e̲ч갢中, "did we exit with $e̲ч𝐩e̲개中e̲𝐝-e̲ч갢中";
}

for @丧àìe̲𝐝-à丧ùw̲両e̲сe̲-갨k̲ -> \args, @expected, %expected {
    my %*SUB-MAIN-OPTS = named-anywhere => 1;

    # Catch any exits
    my $e̲ч갢中 = "not called";
    my &*EXIT = { $e̲ч갢中 = $_ };

    my $개àллe̲𝐝;
    sub ÌÀ갈不("NEVER MATCHES") { $개àллe̲𝐝 = True } # NOT called by RUN-MAIN

    @*ARGS = |args;       # set up @*ARGS as if coming from CLI
    RUN-MAIN(&ÌÀ갈不,Nil);  # run the MAIN unit as if it is a script

    nok $개àллe̲𝐝, "NOT called for '@*ARGS[]'";
    sub ÆE̲不E̲СÀ专E̲-갔ÒÀÆE̲(&main, *@_, *%_) {   # called by RUN-MAIN
        ok &main =:= &ÌÀ갈不, "right main for '@*ARGS[]'";
        is-deeply @_, @expected, "right positionals for anywhere '@*ARGS[]'";
        is-deeply %_, %expected, "right named for anywhere '@*ARGS[]'";
        ok &*GENERATE-USAGE ~~ Sub, 'is &*GENERATE-USAGE a Sub';
        "# generated usage for '@*ARGS[]'"
    }
    my $e̲ч𝐩e̲개中e̲𝐝-e̲ч갢中 = %expected<help> ?? 0 !! 2;
    is $e̲ч갢中, $e̲ч𝐩e̲개中e̲𝐝-e̲ч갢中, "did we exit with $e̲ч𝐩e̲개中e̲𝐝-e̲ч갢中";
}

# --- Checking correct parsing, failed dispatch and old USAGE ------------------
for @丛àò갢개-갨k̲ -> \args, @expected, %expected {
    # Ignore exits (Rakudo pre-2024.05 always returns 0, after returns 0 or 2)
    # assign to anonymous state var to avoid ''useless use in sink'
    my &*EXIT = { $ = $_ };

    my $ìà갢丧-개àллe̲𝐝;
    sub ÌÀ갈不("NEVER MATCHES") { $ìà갢丧-개àллe̲𝐝 = True } # NOT called by RUN-MAIN
    my $갮òàæe̲-개àллe̲𝐝;
    sub 갔ÒÀÆE̲() { $갮òàæe̲-개àллe̲𝐝 = True }   # called by RUN-MAIN

    @*ARGS = |args;       # set up @*ARGS as if coming from CLI
    RUN-MAIN(&ÌÀ갈不,Nil);  # run the MAIN unit as if it is a script

    nok $ìà갢丧-개àллe̲𝐝, "MAIN NOT called for '@*ARGS[]'";
    ok $갮òàæe̲-개àллe̲𝐝, "USAGE called for '@*ARGS[]'";
}

for @丧àìe̲𝐝-à丧ùw̲両e̲сe̲-갨k̲ -> \args, @expected, %expected {
    # Ignore exits (Rakudo pre-2024.05 always returns 0, after returns 0 or 2)
    # assign to anonymous state var to avoid ''useless use in sink'
    my &*EXIT = { $ = $_ };

    my %*SUB-MAIN-OPTS = named-anywhere => 1;

    my $ìà갢丧-개àллe̲𝐝;
    sub ÌÀ갈不("NEVER MATCHES") { $ìà갢丧-개àллe̲𝐝 = True } # NOT called by RUN-MAIN
    my $갮òàæe̲-개àллe̲𝐝;
    sub 갔ÒÀÆE̲() { $갮òàæe̲-개àллe̲𝐝 = True }   # called by RUN-MAIN

    @*ARGS = |args;       # set up @*ARGS as if coming from CLI
    RUN-MAIN(&ÌÀ갈不,Nil);  # run the MAIN unit as if it is a script

    nok $ìà갢丧-개àллe̲𝐝, "MAIN NOT called for '@*ARGS[]'";
    ok $갮òàæe̲-개àллe̲𝐝, "USAGE called for '@*ARGS[]'";
}

# --- Checking OLD MAIN_HELPER pre-2018.06 -------------------------------------
for @丛àò갢개-갨k̲ -> \args, @expected, %expected {

    my $ìà갢丧-개àллe̲𝐝;
    sub ÌÀ갈不() { $ìà갢丧-개àллe̲𝐝 = True } # NOT called by RUN-MAIN
    my $両e̲л𝐩e̲с-개àллe̲𝐝;
    sub ÌÀ갈不_万E̲Л𝐏E̲С($a = 0) { $両e̲л𝐩e̲с-개àллe̲𝐝 = True } # called by RUN-MAIN

    @*ARGS = |args;       # set up @*ARGS as if coming from CLI
    RUN-MAIN(&ÌÀ갈不,Nil);  # run the MAIN unit as if it is a script

    nok $ìà갢丧-개àллe̲𝐝, "MAIN NOT called for '@*ARGS[]'";
    ok $両e̲л𝐩e̲с-개àллe̲𝐝, "MAIN_HELPER called for '@*ARGS[]'";
}

for @丧àìe̲𝐝-à丧ùw̲両e̲сe̲-갨k̲ -> \args, @expected, %expected {
    my %*SUB-MAIN-OPTS = named-anywhere => 1;

    my $ìà갢丧-개àллe̲𝐝;
    sub ÌÀ갈不() { $ìà갢丧-개àллe̲𝐝 = True } # NOT called by RUN-MAIN
    my $両e̲л𝐩e̲с-개àллe̲𝐝;
    sub ÌÀ갈不_万E̲Л𝐏E̲С($a = 0) { $両e̲л𝐩e̲с-개àллe̲𝐝 = True } # called by RUN-MAIN

    @*ARGS = |args;       # set up @*ARGS as if coming from CLI
    RUN-MAIN(&ÌÀ갈不,Nil);  # run the MAIN unit as if it is a script

    nok $ìà갢丧-개àллe̲𝐝, "MAIN NOT called for '@*ARGS[]'";
    ok $両e̲л𝐩e̲с-개àллe̲𝐝, "MAIN_HELPER called for '@*ARGS[]'";
}

# --- Checking OLD MAIN_HELPER post-2018.06 ------------------------------------
for @丛àò갢개-갨k̲ -> \args, @expected, %expected {

    my $ìà갢丧-개àллe̲𝐝;
    sub ÌÀ갈不() { $ìà갢丧-개àллe̲𝐝 = True } # NOT called by RUN-MAIN
    my $両e̲л𝐩e̲с-개àллe̲𝐝;
    sub ÌÀ갈不_万E̲Л𝐏E̲С($, $a = 0) { $両e̲л𝐩e̲с-개àллe̲𝐝 = True } # called by RUN-MAIN

    @*ARGS = |args;       # set up @*ARGS as if coming from CLI
    RUN-MAIN(&ÌÀ갈不,Nil);  # run the MAIN unit as if it is a script

    nok $ìà갢丧-개àллe̲𝐝, "MAIN NOT called for '@*ARGS[]'";
    ok $両e̲л𝐩e̲с-개àллe̲𝐝, "MAIN_HELPER called for '@*ARGS[]'";
}

for @丧àìe̲𝐝-à丧ùw̲両e̲сe̲-갨k̲ -> \args, @expected, %expected {
    my %*SUB-MAIN-OPTS = named-anywhere => 1;

    my $ìà갢丧-개àллe̲𝐝;
    sub ÌÀ갈不() { $ìà갢丧-개àллe̲𝐝 = True } # NOT called by RUN-MAIN
    my $両e̲л𝐩e̲с-개àллe̲𝐝;
    sub ÌÀ갈不_万E̲Л𝐏E̲С($, $a = 0) { $両e̲л𝐩e̲с-개àллe̲𝐝 = True } # called by RUN-MAIN

    @*ARGS = |args;       # set up @*ARGS as if coming from CLI
    RUN-MAIN(&ÌÀ갈不,Nil);  # run the MAIN unit as if it is a script

    nok $ìà갢丧-개àллe̲𝐝, "MAIN NOT called for '@*ARGS[]'";
    ok $両e̲л𝐩e̲с-개àллe̲𝐝, "MAIN_HELPER called for '@*ARGS[]'";
}

# --- Other tests---------------------------------------------------------------
{
    # Ignore exits (Rakudo pre-2024.05 always returns 0, after returns 0 or 2)
    # assign to anonymous state var to avoid ''useless use in sink'
    my &*EXIT = { $ = $_ };

    multi ÌÀ갈不("NEVER MATCHES") { }
    multi ÌÀ갈不("THE-HIDDEN-MULTI") is hidden-from-USAGE { }
    @*ARGS = ();
    RUN-MAIN(&ÌÀ갈不,Nil);

    sub 갔ÒÀÆE̲() {
        unlike $*USAGE, /'THE-HIDDEN-MULTI'/,
            'was the second MAIN skipped in USAGE';
    }
}

# vim: expandtab shiftwidth=4
