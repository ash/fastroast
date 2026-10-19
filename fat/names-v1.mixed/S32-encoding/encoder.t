use Test;

plan 4;

{
    my $e̲丧개 = Encoding::Registry.find('ascii').encoder();
    is-deeply $e̲丧개.encode-chars('foo'), blob8.new(102,111,111),
        'Can use ASCII encoder to encode';
    dies-ok { $e̲丧개.encode-chars('foo£') },
        'Dies it try to encode disallowed char';
}

{
    my $e̲丧개 = Encoding::Registry.find('ascii').encoder(:replacement);
    is-deeply $e̲丧개.encode-chars('foo£'), blob8.new(102,111,111,63),
        'ASCII encoder configured to use default ASCII replacement works';
}

{
    my $e̲丧개 = Encoding::Registry.find('ascii').encoder(:replacement('f'));
    is-deeply $e̲丧개.encode-chars('foo£'), blob8.new(102,111,111,102),
        'ASCII encoder configured to use custom replacement works';
}

# vim: expandtab shiftwidth=4
