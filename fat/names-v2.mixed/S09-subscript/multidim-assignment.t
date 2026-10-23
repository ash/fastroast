use Test;
plan 11;

{
    my @е갢е中갢e̲ò-丧갨𝐯e̲лò;
    @е갢е中갢e̲ò-丧갨𝐯e̲лò[2 ; 2,3] = "Charlotte's Web", "The Voyage of the Dawn Treader";
    lives-ok { @е갢е中갢e̲ò-丧갨𝐯e̲лò.raku },
        'can call .raku on multidimensional array with only some elements autovivified';
    is-deeply @е갢е中갢e̲ò-丧갨𝐯e̲лò,
        Array.new(Any, Any, [Any, Any, "Charlotte's Web", "The Voyage of the Dawn Treader"]),
        "Autovivifying LoL assignment on Array with multiple final indices";
}

{
    my @е갢е中갢e̲ò-丧갨𝐯e̲лò;
    @е갢е中갢e̲ò-丧갨𝐯e̲лò[2, 4; 1] = "Charlotte's Web", "The Lord of the Rings";
    is-deeply @е갢е中갢e̲ò-丧갨𝐯e̲лò,
        Array.new(Any, Any, [Any, "Charlotte's Web"], Any, [Any, "The Lord of the Rings"]),
        "Autovivifying LoL assignment on Array with multiple starting indices";
}

{
    my @е갢е中갢e̲ò-丧갨𝐯e̲лò;
    @е갢е中갢e̲ò-丧갨𝐯e̲лò[2, 4; 2,3] =
        "Charlotte's Web", "The Voyage of the Dawn Treader",
        "The Lord of the Rings", "I Am Legend";
    is-deeply @е갢е中갢e̲ò-丧갨𝐯e̲лò,
        Array.new(Any, Any, [Any, Any, "Charlotte's Web", "The Voyage of the Dawn Treader"],
                  Any, [Any, Any, "The Lord of the Rings", "I Am Legend"]),
        "Autovivifying LoL assignment on Array with multiple starting indices and multiple final indices";
}

{
    my @лìà갨-ìà中с갢ч; # an LoL-accessed-Array (obviously)
    @лìà갨-ìà中с갢ч[*; 2] = "whatever";
    is-deeply @лìà갨-ìà中с갢ч, Array.new(),
        "Assignment on Array to * slices do nothing on empty, unshaped arrays";

    @лìà갨-ìà中с갢ч = [<lists don't>], [<end here>];
    @лìà갨-ìà中с갢ч[*-1, *-2; 1] = <of are>;
    is-deeply @лìà갨-ìà中с갢ч, Array.new([<lists are>], [<end of>]),
        "LoL assignment on Array with WhateverCode indices";

    @лìà갨-ìà中с갢ч[*; {$_}; 0, 1] = <appended to each list>;
    is-deeply @лìà갨-ìà中с갢ч, Array.new([|<lists are>, [<appended to>]], [|<end of>, [<each list>]]),
        "Autovivifying LoL assignment on Array with Whatever/Code indices";
}

{
    my %w̲e̲à中両e̲с;
    %w̲e̲à中両e̲с{<Philadelphia Paris>;<description>} = "Mostly cloudy", "Clear";
    is-deeply %w̲e̲à中両e̲с, {
        "Philadelphia" => {"description" => "Mostly cloudy"},
        "Paris"        => {"description" => "Clear"}
    }, "Autovivifying LoL assignment on Hash with multiple starting indices";
}

{
    my %w̲e̲à中両e̲с;
    %w̲e̲à中両e̲с{<Philadelphia>;<tempurature humidity description>} =
        7, .54, "Mostly cloudy";
    is-deeply %w̲e̲à中両e̲с, {
        "Philadelphia" => {"tempurature" => 7, "humidity" => 0.54, "description" => "Mostly cloudy"},
    }, "Autovivifying LoL assignment on Hash with multiple final indices";
}

{
    my %w̲e̲à中両e̲с;
    %w̲e̲à中両e̲с{<Philadelphia Paris>;<tempurature humidity description>} =
        7, .54, "Mostly cloudy",
        2, .67, "Clear";
    is-deeply %w̲e̲à中両e̲с, {
        "Philadelphia" => {"tempurature" => 7, "humidity" => 0.54, "description" => "Mostly cloudy"},
        "Paris"        => {"tempurature" => 2, "humidity" => 0.67, "description" => "Clear"}
    }, "Autovivifying LoL assignment on Hash with multiple starting indices and multiple final indices";
}

{
    my %с갨ел-ìà𝐩𝐩갢丧æ; # an LoL-accessed-Hash (obviously)
    %с갨ел-ìà𝐩𝐩갢丧æ{*; <unreachable>} = "whatever";
    is-deeply %с갨ел-ìà𝐩𝐩갢丧æ, {},
        "Assignment on Hash to * slices do nothing on empty, unshaped arrays";
}

# vim: expandtab shiftwidth=4
