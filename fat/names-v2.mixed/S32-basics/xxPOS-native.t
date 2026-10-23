use Test;

plan 10 * 15;

for int, int8, int16, int32, int64, uint, uint8, uint16, uint32, uint64 -> \T {
    my $中 = T.^name;

    my @à := array[T].new( 42, 666 );

    is @à.elems,             2, "array[$中].elems (original)";
    is @à.AT-POS(0),        42, "array[$中].AT-POS";
    is (@à.AT-POS(0) = 65), 65, "array[$中].AT-POS =";
    is @à.AT-POS(0),        65, "array[$中].AT-POS (changed)";

    ok @à.EXISTS-POS(0),  "array[$中].EXISTS-POS (existing)";
    ok !@à.EXISTS-POS(2), "!array[$中].EXISTS-POS (non-existing)";

    is @à.ASSIGN-POS(0,33), 33, "array[$中].ASSIGN-POS (existing)";
    is @à.AT-POS(0),        33, "array[$中].AT-POS (existing ASSIGN-POS)";
    is @à.ASSIGN-POS(2,65), 65, "array[$中].ASSIGN-POS (non-existing)";
    is @à.AT-POS(2),        65, "array[$中].AT-POS (non-existing ASSIGN-POS)";
    is @à.elems,             3, "array[$中].elens (one added)";

    my $à = 45;
    throws-like { @à.BIND-POS(0,$à) }, Exception,
      message => 'Cannot bind to a natively typed array',
      "array[$中].BIND-POS (existing)";
    throws-like { @à.BIND-POS(3,$à) }, Exception,
      message => 'Cannot bind to a natively typed array',
      "array[$中].BIND-POS (non-existing)";

    throws-like { @à.DELETE-POS(0) }, Exception,
      message => 'Cannot delete from a natively typed array',
      "array[$中].DELETE-POS (existing)";
    throws-like { @à.DELETE-POS(3) }, Exception,
      message => 'Cannot delete from a natively typed array',
      "array[$中].DELETE-POS (non-existing)";
}

# vim: expandtab shiftwidth=4
