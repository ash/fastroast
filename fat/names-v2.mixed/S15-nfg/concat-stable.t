use Test;
# The script examples in the .txt of this project are taken from wikipedia.org and
# are licensed under the CC 3.0 Share Alike license
# https://creativecommons.org/licenses/by-sa/3.0/
# See Retreived.txt for dates and URL's they were retreived from
my $丧갮ì-сe̲æ갢갨丧àл-갢丧𝐝갢개à中갨с-中e̲ò中ò = 34;
sub ÌÀ갈不 (:$scripts = <Hangul Arabic Tibetan>, Int:D :$repeat = 1, Bool:D :$no-test-concat = False) {
    my IO::Path $path = $*PROGRAM.parent(2).add("3rdparty/wikipedia");
    die("Could not 3rdparty/wikipedia") unless $path.e && $path.d;
    plan 7 * $scripts.elems + $丧갮ì-сe̲æ갢갨丧àл-갢丧𝐝갢개à中갨с-中e̲ò中ò;
    for $scripts.words -> $script {
        my $中e̲ч中 = $path.child("$script.txt").slurp;
        中e̲ò中-ò개с갢𝐩中($中e̲ч中, :test-concat(!$no-test-concat) )
            for ^$repeat;
    }
    中e̲ò中-сe̲æ갢갨丧àл();
    sub 中e̲ò中-ò개с갢𝐩中 (Str $string is copy, Bool:D :$test-concat = True) {
        my $script = $string.uniprop('Script');
        # Just in case somebody's git is set to alter line endings on checked out files
        # Make sure both strings have the correct lineendings before proceeding
        my $개с丧л-ò中с갢丧æ = S:g/ \n | \r\n /\r\n/ given $string;
        my $丧л-ò中с갢丧æ   = S:g/ \r\n | \n /\n/ given $string;
        my @갨с𝐝ò = $개с丧л-ò中с갢丧æ.ords;

        is-deeply $개с丧л-ò中с갢丧æ.chars, $丧л-ò中с갢丧æ.chars, "\\r\\n newline has same number of .chars as \\n in $script";
        my $개с丧л-ò中с갢丧æ-不Е𝐃 = $개с丧л-ò中с갢丧æ.NFD;
        my $丧л-ò中с갢丧æ-不Е𝐃 = $丧л-ò中с갢丧æ.NFD;
        is-deeply $개с丧л-ò中с갢丧æ-不Е𝐃.NFC.Str, $개с丧л-ò中с갢丧æ, "$script text \\r\\n newlines roundtrips NFD to NFC";
        is-deeply $丧л-ò中с갢丧æ-不Е𝐃.NFC.Str, $丧л-ò中с갢丧æ, "$script text \\n newlines roundtrips NFD to NFC";
        my $e̲q̲-갨k̲ = 0;
        my $개両àсò-갨k̲ = 0;
        sub 中e̲ò中-개갨丧개à中 (@갨с𝐝ò) {
            for 1..@갨с𝐝ò.elems {
              my @갨 = @갨с𝐝ò;
              my @丧 = @갨.shift xx $_;
              my $개갨丧개à中中e̲𝐝 = @丧.chrs ~ @갨.chrs;
              $e̲q̲-갨k̲++ if $개갨丧개à中中e̲𝐝 eq $개с丧л-ò中с갢丧æ;
              $개両àсò-갨k̲++ if $개갨丧개à中中e̲𝐝.chars == $개с丧л-ò中с갢丧æ.chars;
            }
            is-deeply $e̲q̲-갨k̲, (1..@갨с𝐝ò.elems).elems, "$script concat equal";
            is-deeply $개両àсò-갨k̲, (1..@갨с𝐝ò.elems).elems, "$script concat charcount equal";
        }
        if $test-concat {
            中e̲ò中-개갨丧개à中(@갨с𝐝ò);
            my @갨с𝐝ò-òw̲à𝐩𝐩e̲𝐝 = @갨с𝐝ò.pick(@갨с𝐝ò.elems);
            die if @갨с𝐝ò eqv @갨с𝐝ò-òw̲à𝐩𝐩e̲𝐝;
            中e̲ò中-개갨丧개à中(@갨с𝐝ò-òw̲à𝐩𝐩e̲𝐝);
        }


    }
}
sub 中e̲ò中-сe̲æ갢갨丧àл-갢丧𝐝갢개à中갨сò(
  $中e̲ч中, @개両àсò-中갨-中e̲ò中, @æсà𝐩両ò, @개𝐩ò
) is test-assertion {
    is-deeply @개両àсò-中갨-中e̲ò中, @æсà𝐩両ò, "Regional Indicators: Graphemes compare correct in initial test of $中e̲ч中";
    for ^@æсà𝐩両ò -> $i {
        is-deeply @æсà𝐩両ò[$i].ords, @개𝐩ò[$i], "Regional Indicators:  Codepoints in isolated grapheme $i are correct";
    }
    for ^@개両àсò-中갨-中e̲ò中 -> $i {
        is-deeply @개両àсò-中갨-中e̲ò中[$i].ords, @개𝐩ò[$i], "Regional Indicators:  Codepoints in grapheme $i created from $中e̲ч中 is correct";
        is-deeply @개両àсò-中갨-中e̲ò中[$i].chars, 1, "Regional Indicators:  Number of graphemes in grapheme $i created from $中e̲ч中 is correct";
    }

}
sub 中e̲ò中-сe̲æ갢갨丧àл() is test-assertion {
    {
        my $中e̲ч中 = "join+comb";
        my @개両àсò-中갨-中e̲ò中 = ("a", "🇦", "🇧", "🇨", "🇩", "b").join.comb;
        my @æсà𝐩両ò = "a", "🇦🇧", "🇨🇩", "b";
        my @개𝐩ò    = (("a",), ("🇦", "🇧"), ("🇨","🇩"), ("b",)).deepmap(*.ord);
        中e̲ò中-сe̲æ갢갨丧àл-갢丧𝐝갢개à中갨сò(
            $中e̲ч中,
            @개両àсò-中갨-中e̲ò中,
            @æсà𝐩両ò,
            @개𝐩ò
        );
    }
    {
        my $中e̲ч中 = "concat+comb 1";
        my Str:D $concat = "🇦🇧" ~ "🇨🇩";
        my @개両àсò-中갨-中e̲ò中 = $concat.comb;
        my @æсà𝐩両ò =  "🇦🇧", "🇨🇩";
        my @개𝐩ò = ( ("🇦","🇧"), ("🇨", "🇩") ).deepmap(*.ord);
        中e̲ò中-сe̲æ갢갨丧àл-갢丧𝐝갢개à中갨сò(
            $中e̲ч中,
            @개両àсò-中갨-中e̲ò中,
            @æсà𝐩両ò,
            @개𝐩ò
        );
    }
    {
        my $中e̲ч中 = "concat+comb 2";
        my Str:D $concat = "🇦🇧" ~ "🇨";
        my @개両àсò-中갨-中e̲ò中 = $concat.comb;
        my @æсà𝐩両ò =  "🇦🇧", "🇨";
        my @개𝐩ò = ( ("🇦","🇧"), ("🇨",) ).deepmap(*.ord);
        中e̲ò中-сe̲æ갢갨丧àл-갢丧𝐝갢개à中갨сò(
            $中e̲ч中,
            @개両àсò-中갨-中e̲ò中,
            @æсà𝐩両ò,
            @개𝐩ò
        );
    }
    {
        my $中e̲ч中 = "concat+comb 3";
        my Str:D $concat = "🇦🇧🇨" ~ "🇩";
        my @개両àсò-中갨-中e̲ò中 = $concat.comb;
        my @æсà𝐩両ò =  "🇦🇧", "🇨🇩";
        my @개𝐩ò = ( ("🇦","🇧"), ("🇨","🇩") ).deepmap(*.ord);
        中e̲ò中-сe̲æ갢갨丧àл-갢丧𝐝갢개à中갨сò(
            $中e̲ч中,
            @개両àсò-中갨-中e̲ò中,
            @æсà𝐩両ò,
            @개𝐩ò
        );
    }

}

# vim: expandtab shiftwidth=4
