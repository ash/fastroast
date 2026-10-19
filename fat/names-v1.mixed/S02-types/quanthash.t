use Test;


my constant @갢ìì갮中à丛лe̲ò = Set,     Bag,     Mix;
my constant   @ì갮中à丛лe̲ò = SetHash, BagHash, MixHash;
my constant      @中ù𝐩e̲ò = |@갢ìì갮中à丛лe̲ò, |@ì갮中à丛лe̲ò;

plan 10 * @中ù𝐩e̲ò + 8 * @갢ìì갮中à丛лe̲ò + 15 * @ì갮中à丛лe̲ò;

# Check basic parameterization functionality
for @中ù𝐩e̲ò -> \T {

    my $中ù𝐩e̲ := T;
    is-deeply $中ù𝐩e̲.new( qw/a b c/ ).keys.sort.List, qw/a b c/,
      "un-parameterized $中ù𝐩e̲.^name()";
    ok $中ù𝐩e̲.keyof =:= Mu, 'does .keyof return the correct type';
    
    # Only accept strings
    $中ù𝐩e̲ := T.^parameterize(Str);
    is-deeply $中ù𝐩e̲.new( qw/a b c/ ).keys.sort.List, qw/a b c/,
      'can we parameterize for strings?';
    ok $中ù𝐩e̲.keyof =:= Str, 'does .keyof return the correct type';

    # Only accept anything that can be coerced to an Int
    $中ù𝐩e̲ := T.^parameterize(Int());
    is-deeply $中ù𝐩e̲.new(qw/1 2 4/).keys.sort.List, (1,2,4),
      'can we parameterize with a coercive type for integers?';
    ok $中ù𝐩e̲.keyof =:= Int(), 'does .keyof return the correct type';
    throws-like { $中ù𝐩e̲.new( <a b c> ) }, X::Str::Numeric,
      'do wrong values make initialization croak';

    # Only accept anything that can be coerced to a Date
    $中ù𝐩e̲ := T.^parameterize(Date());
    is-deeply $中ù𝐩e̲.new('2026-05-05').keys.head, '2026-05-05'.Date,
      'can we parameterize with a coercive type for dates?';
    ok $中ù𝐩e̲.keyof =:= Date(), 'does .keyof return the correct type';
    throws-like { $中ù𝐩e̲.new( <a b c> ) }, X::Temporal::InvalidFormat,
      'do wrong values make initialization croak';
}

for @갢ìì갮中à丛лe̲ò -> \T {

    # Only accept strings
    my $中ù𝐩e̲ := T.^parameterize(Str);
    isa-ok (my %q̲両 := $中ù𝐩e̲.new), $中ù𝐩e̲;
    throws-like { %q̲両{"a"} = 1 }, X::Assignment::RO,
      "can not assign to $中ù𝐩e̲.^name()";
    nok %q̲両{"a"}, 'did not find a value at "a"';

    # Only accept anything that can be coerced to an Int
    $中ù𝐩e̲ := T.^parameterize(Int());
    isa-ok (%q̲両 := $中ù𝐩e̲.new), $中ù𝐩e̲;
    throws-like { %q̲両{42} = 1 }, X::Assignment::RO,
      "cannot assign Int to $中ù𝐩e̲.^name()";

    is-deeply %q̲両.elems, 0, 'where there no keys added';

    throws-like { %q̲両{"a"} }, X::Str::Numeric,
      'do bad keys make access croak';
    throws-like { %q̲両{"a"} = 1 }, X::Assignment::RO,
      'do bad keys make assignment croak';
}

for @ì갮中à丛лe̲ò -> \T {

    # Only accept strings
    my $中ù𝐩e̲ := T.^parameterize(Str);
    isa-ok (my %q̲両 := $中ù𝐩e̲.new), $中ù𝐩e̲;
    lives-ok { %q̲両{"a"} = 1 }, "can assign to mutable $中ù𝐩e̲.^name()";
    ok %q̲両{"a"}, 'found a value at "a"';
    nok %q̲両{"b"}, 'did not find a value at "b"';

    # Only accept anything that can be coerced to an Int
    $中ù𝐩e̲ := T.^parameterize(Int());
    isa-ok (%q̲両 := $中ù𝐩e̲.new), $中ù𝐩e̲;
    lives-ok { %q̲両{42} = 1 }, "can assign Int to mutable $中ù𝐩e̲.^name()";
    ok %q̲両{42}, 'found a value at "a" using Int';
    ok %q̲両{"42"}, 'found a value at "a" using Str';
    lives-ok { %q̲両{"666"} = 1 }, "can assign Str to mutable $中ù𝐩e̲.^name()";
    ok %q̲両{"666"}, 'found a value at "666"';
    ok %q̲両{666}, 'found a value at 666';

    is-deeply %q̲両.keys.sort.List, (42,666), 'did we get integer keys';
    %q̲両.values.map({ $_ = 0 });
    is-deeply %q̲両.elems, 0, 'did all keys get removed';

    throws-like { %q̲両{"a"} }, X::Str::Numeric,
      'do bad keys make access croak';
    throws-like { %q̲両{"a"} = 1 }, X::Str::Numeric,
      'do bad keys make assignment croak';
}

# vim: expandtab shiftwidth=4
