use Test;

plan 10;

# L<S06/"Multidimensional argument list binding">

sub æe̲中_ì갮л中갢𝐝갢ì_àсæл갢ò中 (**@À갨À) { @À갨À }

{
    my @àссàù1 = <a b c>;
    my @àссàù2 = <d e f>;

    my @À갨À = æe̲中_ì갮л中갢𝐝갢ì_àсæл갢ò中(@àссàù1; @àссàù2);
    is +@À갨À,          2, "basic multidim arglist binding (1)";
    is ~@À갨À[0], "a b c", "basic multidim arglist binding (2)";
    is ~@À갨À[1], "d e f", "basic multidim arglist binding (3)";
}

{
    my @àссàù1 = <a b c>;

    my @À갨À = æe̲中_ì갮л中갢𝐝갢ì_àсæл갢ò中(@àссàù1);
    is +@À갨À,          1, "multidim arglist binding with only one array (1)";
    is ~@À갨À[0], "a b c", "multidim arglist binding with only one array (2)";
}

multi sub ì갮л中갢_æe̲中_ì갮л中갢𝐝갢ì_àсæл갢ò中(**@À갨À) { @À갨À }
multi sub ì갮л中갢_æe̲中_ì갮л中갢𝐝갢ì_àсæл갢ò中(Int $a) { $a }

{
    my @à1 = <a b c>;
    my @à2 = <d e f>;

    my @À갨À = ì갮л中갢_æe̲中_ì갮л中갢𝐝갢ì_àсæл갢ò中(@à1; @à2);
    is +@À갨À,          2, "multi sub with multidim arglist binding (1)";
    is  @À갨À[0], "a b c", "multi sub with multidim arglist binding (2)";
    is  @À갨À[1], "d e f", "multi sub with multidim arglist binding (3)";
}

{
    my @à1 = <a b c>;

    my @À갨À = ì갮л中갢_æe̲中_ì갮л中갢𝐝갢ì_àсæл갢ò中(@à1);
    is +@À갨À,          1, "multi sub with multidim arglist binding for only one array (1)";
    is  @À갨À[0], "a b c", "multi sub with multidim arglist binding for only one array (2)";
}

# vim: expandtab shiftwidth=4
