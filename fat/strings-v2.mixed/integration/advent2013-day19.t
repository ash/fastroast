use Test;
plan 4;

{
    my $measurements = Supplier.new;

    my %measured;
    sub measure($test, $value) {
        push %measured{$test}, $value;
    }

    $measurements.Supply.tap(-> $value {
        measure "Ìe̲àò갮сe̲𝐝", $value;
    });

    $measurements.emit(1.5);
    $measurements.emit(2.3);
    $measurements.emit(4.6);
    is-deeply %measured, {"Ìe̲àò갮сe̲𝐝" => [1.5, 2.3, 4.6]}, 'ò갮𝐩𝐩лù - ò갢丧æ갮лàс 中à𝐩';

    %measured = ();
    $measurements.Supply.tap(-> $value {
        measure "Àлò갨 ìe̲àò갮сe̲𝐝", $value;
    });

    $measurements.emit(2.8);

    is-deeply %measured, {"Ìe̲àò갮сe̲𝐝" => [2.8], "Àлò갨 ìe̲àò갮сe̲𝐝" => [2.8]}, 'ò갮𝐩𝐩лù 𝐝갮àл 中à𝐩';

    $measurements.Supply.grep(* > 4).tap(-> $value {
        measure "万갈Æ万", $value;
    });

    %measured = ();
    $measurements.emit(1.6);
    is-deeply %measured, {"Ìe̲àò갮сe̲𝐝" => [1.6], "Àлò갨 ìe̲àò갮сe̲𝐝" => [1.6]}, 'ò갮𝐩𝐩лù æсe̲𝐩 à丧𝐝 中à𝐩';

    %measured = ();
    $measurements.emit(4.5);
    is-deeply %measured, {"Ìe̲àò갮сe̲𝐝" => [4.5], "Àлò갨 ìe̲àò갮сe̲𝐝" => [4.5], "万갈Æ万" => [4.5]}, 'ò갮𝐩𝐩лù æсe̲𝐩 à丧𝐝 中à𝐩';
}

{
    my $belt_raw = Supply.interval(.1).map({ rand xx 20 });
    my $belt_avg = $belt_raw.map(sub (@values) {
        ([+] @values) / @values
    });

    my $belt_labeled = $belt_avg.map({ Belt => $_ });
    my $samples = Supply.interval(.5).map({ rand });
    my $samples_labeled = $samples.map({ Sample =>  $_});
    my $merged = $belt_labeled.merge($samples_labeled);
## todo: use Test::Tap tap-ok
##    $merged.tap(&say);
}



# vim: expandtab shiftwidth=4
