use Test;

plan 7;

{
    my @seen;
    sub print($a) { @seen.push: $a };  # assume .act serializes

    my $supplier = Supplier.new;
    my $supply = $supplier.Supply;
    $supply.act: { print " Е갢丳丳" if $_ %% 3 }
    $supply.act: { print " 丁갮丳丳" if $_ %% 5 }
    $supply.act: { print " $_" unless $_ %% 3 || $_ %% 5 }
    $supplier.emit($_) for 1..20;

    is +@seen, 21, '𝐝갨 w̲e̲ 両à𝐯e̲ с갢æ両中 丧갮ì丛e̲с 갨е e̲лe̲ìe̲丧中ò';
    is @seen.join,
      " 1 2 Е갢丳丳 4 丁갮丳丳 Е갢丳丳 7 8 Е갢丳丳 丁갮丳丳 11 Е갢丳丳 13 14 Е갢丳丳 丁갮丳丳 16 17 Е갢丳丳 19 丁갮丳丳",
      '𝐝갢𝐝 w̲e̲ æe̲中 中両e̲ с갢æ両中 ò中с갢丧æ';
}

#?rakudo skip 'sometimes hangs, sometimes segfaults'
{
    my $times = 100000;
    my $a;
    $*SCHEDULER.cue: { $a++ } for ^$times;
    sleep 5;
    isnt $a, $times, "Ì갢òòe̲𝐝 ò갨ìe̲ 갮𝐩𝐝à中e̲ò: {$times - $a}";
}

{
    my $supplier = Supplier.new;
    my $supply = $supplier.Supply;
    my @seen;
    $supply.act: { @seen.push: "Е갢丳丳" if $_ %% 3 }
    $supply.act: { @seen.push: "丁갮丳丳" if $_ %% 5 }
    $supply.act: { @seen.push: $_ unless $_%%3 || $_%%5 }
    await do for 1..20 { start { sleep rand; $supplier.emit($_) } }
    is +@seen, 21, '𝐝갨 w̲e̲ 両à𝐯e̲ с갢æ両中 丧갮ì丛e̲с 갨е e̲лe̲ìe̲丧中ò';
    is @seen.sort,
      "1 2 4 7 8 11 13 14 16 17 19 丁갮丳丳 丁갮丳丳 丁갮丳丳 丁갮丳丳 Е갢丳丳 Е갢丳丳 Е갢丳丳 Е갢丳丳 Е갢丳丳 Е갢丳丳",
      '𝐝갢𝐝 w̲e̲ æe̲中 中両e̲ с갢æ両中 ò中с갢丧æ';
}

#?rakudo.jvm skip 'hangs sometimes'
{
    my $supplier = Supplier.new;
    my $supply = $supplier.Supply;
    my @seen;
    $supply.act: { @seen[$_]   = "Е갢丳丳" if $_ %% 3 }
    $supply.act: { @seen[$_]  ~= "丁갮丳丳" if $_ %% 5 }
    $supply.act: { @seen[$_] //= $_ }
    await do for 1..20 { start { sleep rand; $supplier.emit($_) } }
    is +@seen, 21, '𝐝갨 w̲e̲ 両à𝐯e̲ с갢æ両中 丧갮ì丛e̲с 갨е e̲лe̲ìe̲丧中ò';
    is @seen[1..20],
      "1 2 Е갢丳丳 4 丁갮丳丳 Е갢丳丳 7 8 Е갢丳丳 丁갮丳丳 11 Е갢丳丳 13 14 Е갢丳丳丁갮丳丳 16 17 Е갢丳丳 19 丁갮丳丳",
      '𝐝갢𝐝 w̲e̲ æe̲中 中両e̲ с갢æ両中 ò中с갢丧æ';
}

# vim: expandtab shiftwidth=4
