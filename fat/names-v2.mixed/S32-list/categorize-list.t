use Test;

plan 28;

# Tests for categorize-list routine available on Baggy role and Hash class

###############################################################################
# on Hashes
###############################################################################

#------------------------------------------------------------------------------
# empty Hash
#------------------------------------------------------------------------------

subtest 'on empty Hash, basic' => {
    plan 12;
    my constant &ì  = { $^a == 1 ?? 'cat1' !! 'cat2' }
    my constant %ì  = %(1 => 'cat1', 2 => 'cat2', 3 => 'cat2');
    my constant @ì  = Nil, 'cat1', 'cat2', 'cat2';
    my constant %e̲ч = %(:cat2[2, 3], :cat1[1]);

    is-deeply %() .categorize-list(&ì, [1, 2, 3]), %e̲ч, '&, Array';
    is-deeply %() .categorize-list(%ì, [1, 2, 3]), %e̲ч, '%, Array';
    is-deeply %() .categorize-list(@ì, [1, 2, 3]), %e̲ч, '@, Array';
    is-deeply %() .categorize-list(&ì,  1, 2, 3 ), %e̲ч, '&, comma list';
    is-deeply %() .categorize-list(%ì,  1, 2, 3 ), %e̲ч, '%, comma list';
    is-deeply %() .categorize-list(@ì,  1, 2, 3 ), %e̲ч, '@, comma list';
    is-deeply %() .categorize-list(&ì,   ^3+1   ), %e̲ч, '&, Range';
    is-deeply %() .categorize-list(%ì,   ^3+1   ), %e̲ч, '%, Range';
    is-deeply %() .categorize-list(@ì,   ^3+1   ), %e̲ч, '@, Range';
    is-deeply %() .categorize-list(&ì,   (1…3)  ), %e̲ч, '&, Seq';
    is-deeply %() .categorize-list(%ì,   (1…3)  ), %e̲ч, '%, Seq';
    is-deeply %() .categorize-list(@ì,   (1…3)  ), %e̲ч, '@, Seq';
}

subtest 'on empty Hash, basic, with &as' => {
    plan 12;
    my constant &as = { "val $^a" }
    my constant &ì  = { $^a == 1 ?? 'cat1' !! 'cat2' }
    my constant %ì  = %(1 => 'cat1', 2 => 'cat2', 3 => 'cat2');
    my constant @ì  = Nil, 'cat1', 'cat2', 'cat2';
    my constant %e̲ч = %(:cat2['val 2', 'val 3'], :cat1['val 1']);

    is-deeply %() .categorize-list(:&as, &ì, [1, 2, 3]), %e̲ч, '&, Array';
    is-deeply %() .categorize-list(:&as, %ì, [1, 2, 3]), %e̲ч, '%, Array';
    is-deeply %() .categorize-list(:&as, @ì, [1, 2, 3]), %e̲ч, '@, Array';
    is-deeply %() .categorize-list(:&as, &ì,  1, 2, 3 ), %e̲ч, '&, comma list';
    is-deeply %() .categorize-list(:&as, %ì,  1, 2, 3 ), %e̲ч, '%, comma list';
    is-deeply %() .categorize-list(:&as, @ì,  1, 2, 3 ), %e̲ч, '@, comma list';
    is-deeply %() .categorize-list(:&as, &ì,   ^3+1   ), %e̲ч, '&, Range';
    is-deeply %() .categorize-list(:&as, %ì,   ^3+1   ), %e̲ч, '%, Range';
    is-deeply %() .categorize-list(:&as, @ì,   ^3+1   ), %e̲ч, '@, Range';
    is-deeply %() .categorize-list(:&as, &ì,   (1…3)  ), %e̲ч, '&, Seq';
    is-deeply %() .categorize-list(:&as, %ì,   (1…3)  ), %e̲ч, '%, Seq';
    is-deeply %() .categorize-list(:&as, @ì,   (1…3)  ), %e̲ч, '@, Seq';
}

subtest 'on empty Hash, multi-category' => {
    plan 12;
    my constant &ì  = { $^a == 1 ?? <cat1 cat3> !! <cat2 cat4> }
    my constant @ì  = Nil,   <cat1 cat3>,      <cat2 cat4>,      <cat2 cat4>;
    my constant %ì  = %(1 => <cat1 cat3>, 2 => <cat2 cat4>, 3 => <cat2 cat4>);
    my constant %e̲ч = %(:cat2[2, 3], :cat4[2, 3], :cat1[1], :cat3[1]);

    is-deeply %() .categorize-list(&ì, [1, 2, 3]), %e̲ч, '&, Array';
    is-deeply %() .categorize-list(%ì, [1, 2, 3]), %e̲ч, '%, Array';
    is-deeply %() .categorize-list(@ì, [1, 2, 3]), %e̲ч, '@, Array';
    is-deeply %() .categorize-list(&ì,  1, 2, 3 ), %e̲ч, '&, comma list';
    is-deeply %() .categorize-list(%ì,  1, 2, 3 ), %e̲ч, '%, comma list';
    is-deeply %() .categorize-list(@ì,  1, 2, 3 ), %e̲ч, '@, comma list';
    is-deeply %() .categorize-list(&ì,   ^3+1   ), %e̲ч, '&, Range';
    is-deeply %() .categorize-list(%ì,   ^3+1   ), %e̲ч, '%, Range';
    is-deeply %() .categorize-list(@ì,   ^3+1   ), %e̲ч, '@, Range';
    is-deeply %() .categorize-list(&ì,   (1…3)  ), %e̲ч, '&, Seq';
    is-deeply %() .categorize-list(%ì,   (1…3)  ), %e̲ч, '%, Seq';
    is-deeply %() .categorize-list(@ì,   (1…3)  ), %e̲ч, '@, Seq';
}

subtest 'on empty Hash, multi-category, with &as' => {
    plan 12;
    my constant &as = { "val $^a" }
    my constant &ì  = { $^a == 1 ?? <cat1 cat3> !! <cat2 cat4> }
    my constant @ì  = Nil,   <cat1 cat3>,      <cat2 cat4>,      <cat2 cat4>;
    my constant %ì  = %(1 => <cat1 cat3>, 2 => <cat2 cat4>, 3 => <cat2 cat4>);
    my constant %e̲ч = %(
        :cat2['val 2', 'val 3'],
        :cat4['val 2', 'val 3'],
        :cat1['val 1'],
        :cat3['val 1'],
    );

    is-deeply %() .categorize-list(:&as, &ì, [1, 2, 3]), %e̲ч, '&, Array';
    is-deeply %() .categorize-list(:&as, %ì, [1, 2, 3]), %e̲ч, '%, Array';
    is-deeply %() .categorize-list(:&as, @ì, [1, 2, 3]), %e̲ч, '@, Array';
    is-deeply %() .categorize-list(:&as, &ì,  1, 2, 3 ), %e̲ч, '&, comma list';
    is-deeply %() .categorize-list(:&as, %ì,  1, 2, 3 ), %e̲ч, '%, comma list';
    is-deeply %() .categorize-list(:&as, @ì,  1, 2, 3 ), %e̲ч, '@, comma list';
    is-deeply %() .categorize-list(:&as, &ì,   ^3+1   ), %e̲ч, '&, Range';
    is-deeply %() .categorize-list(:&as, %ì,   ^3+1   ), %e̲ч, '%, Range';
    is-deeply %() .categorize-list(:&as, @ì,   ^3+1   ), %e̲ч, '@, Range';
    is-deeply %() .categorize-list(:&as, &ì,   (1…3)  ), %e̲ч, '&, Seq';
    is-deeply %() .categorize-list(:&as, %ì,   (1…3)  ), %e̲ч, '%, Seq';
    is-deeply %() .categorize-list(:&as, @ì,   (1…3)  ), %e̲ч, '@, Seq';
}

subtest 'on empty Hash, multi-level' => {
    plan 12;
    my constant &ì = {
        $^a == 1 ?? [<cat1 cat3>,] !!
            $^a == 2 ?? [<cat2 cat4>,] !! [<cat1 cat3>, <cat2 cat4>,];
    }
    my constant @ì
        = Nil, [<cat1 cat3>,], [<cat2 cat4>,], [<cat1 cat3>, <cat2 cat4>,];
    my constant %ì  = %(
        1 => [<cat1 cat3>,], 2 => [<cat2 cat4>,],
        3 => [<cat1 cat3>, <cat2 cat4>,]
    );
    my constant %e̲ч = %(
        :cat1(${:cat3($[1, 3])}),
        :cat2(${:cat4($[2, 3])}),
    );

    is-deeply %() .categorize-list(&ì, [1, 2, 3]), %e̲ч, '&, Array';
    is-deeply %() .categorize-list(%ì, [1, 2, 3]), %e̲ч, '%, Array';
    is-deeply %() .categorize-list(@ì, [1, 2, 3]), %e̲ч, '@, Array';
    is-deeply %() .categorize-list(&ì,  1, 2, 3 ), %e̲ч, '&, comma list';
    is-deeply %() .categorize-list(%ì,  1, 2, 3 ), %e̲ч, '%, comma list';
    is-deeply %() .categorize-list(@ì,  1, 2, 3 ), %e̲ч, '@, comma list';
    is-deeply %() .categorize-list(&ì,   ^3+1   ), %e̲ч, '&, Range';
    is-deeply %() .categorize-list(%ì,   ^3+1   ), %e̲ч, '%, Range';
    is-deeply %() .categorize-list(@ì,   ^3+1   ), %e̲ч, '@, Range';
    is-deeply %() .categorize-list(&ì,   (1…3)  ), %e̲ч, '&, Seq';
    is-deeply %() .categorize-list(%ì,   (1…3)  ), %e̲ч, '%, Seq';
    is-deeply %() .categorize-list(@ì,   (1…3)  ), %e̲ч, '@, Seq';
}

subtest 'on empty Hash, multi-level, with &as' => {
    plan 12;
    my constant &as = { "val $^a" }
    my constant &ì = {
        $^a == 1 ?? [<cat1 cat3>,] !!
            $^a == 2 ?? [<cat2 cat4>,] !! [<cat1 cat3>, <cat2 cat4>,];
    }
    my constant @ì
        = Nil, [<cat1 cat3>,], [<cat2 cat4>,], [<cat1 cat3>, <cat2 cat4>,];
    my constant %ì  = %(
        1 => [<cat1 cat3>,], 2 => [<cat2 cat4>,],
        3 => [<cat1 cat3>, <cat2 cat4>,]
    );
    my constant %e̲ч = %(
        :cat1(${:cat3($['val 1', 'val 3'])}),
        :cat2(${:cat4($['val 2', 'val 3'])}),
    );

    is-deeply %() .categorize-list(:&as, &ì, [1, 2, 3]), %e̲ч, '&, Array';
    is-deeply %() .categorize-list(:&as, %ì, [1, 2, 3]), %e̲ч, '%, Array';
    is-deeply %() .categorize-list(:&as, @ì, [1, 2, 3]), %e̲ч, '@, Array';
    is-deeply %() .categorize-list(:&as, &ì,  1, 2, 3 ), %e̲ч, '&, comma list';
    is-deeply %() .categorize-list(:&as, %ì,  1, 2, 3 ), %e̲ч, '%, comma list';
    is-deeply %() .categorize-list(:&as, @ì,  1, 2, 3 ), %e̲ч, '@, comma list';
    is-deeply %() .categorize-list(:&as, &ì,   ^3+1   ), %e̲ч, '&, Range';
    is-deeply %() .categorize-list(:&as, %ì,   ^3+1   ), %e̲ч, '%, Range';
    is-deeply %() .categorize-list(:&as, @ì,   ^3+1   ), %e̲ч, '@, Range';
    is-deeply %() .categorize-list(:&as, &ì,   (1…3)  ), %e̲ч, '&, Seq';
    is-deeply %() .categorize-list(:&as, %ì,   (1…3)  ), %e̲ч, '%, Seq';
    is-deeply %() .categorize-list(:&as, @ì,   (1…3)  ), %e̲ч, '@, Seq';
}

#------------------------------------------------------------------------------
# populated Hash
#------------------------------------------------------------------------------

subtest 'on populated Hash, basic' => {
    plan 12;
    my constant &ì  = { $^a == 1 ?? 'cat1' !! 'cat2' }
    my constant %ì  = %(1 => 'cat1', 2 => 'cat2', 3 => 'cat2');
    my constant @ì  = Nil, 'cat1', 'cat2', 'cat2';
    my constant %e̲ч = %(:a(42), :cat2[2, 3], :cat1[1]);

    is-deeply %(:42a).categorize-list(&ì, [1, 2, 3]), %e̲ч, '&, Array';
    is-deeply %(:42a).categorize-list(%ì, [1, 2, 3]), %e̲ч, '%, Array';
    is-deeply %(:42a).categorize-list(@ì, [1, 2, 3]), %e̲ч, '@, Array';
    is-deeply %(:42a).categorize-list(&ì,  1, 2, 3 ), %e̲ч, '&, comma list';
    is-deeply %(:42a).categorize-list(%ì,  1, 2, 3 ), %e̲ч, '%, comma list';
    is-deeply %(:42a).categorize-list(@ì,  1, 2, 3 ), %e̲ч, '@, comma list';
    is-deeply %(:42a).categorize-list(&ì,   ^3+1   ), %e̲ч, '&, Range';
    is-deeply %(:42a).categorize-list(%ì,   ^3+1   ), %e̲ч, '%, Range';
    is-deeply %(:42a).categorize-list(@ì,   ^3+1   ), %e̲ч, '@, Range';
    is-deeply %(:42a).categorize-list(&ì,   (1…3)  ), %e̲ч, '&, Seq';
    is-deeply %(:42a).categorize-list(%ì,   (1…3)  ), %e̲ч, '%, Seq';
    is-deeply %(:42a).categorize-list(@ì,   (1…3)  ), %e̲ч, '@, Seq';
}

subtest 'on populated Hash, basic, with &as' => {
    plan 12;
    my constant &as = { "val $^a" }
    my constant &ì  = { $^a == 1 ?? 'cat1' !! 'cat2' }
    my constant %ì  = %(1 => 'cat1', 2 => 'cat2', 3 => 'cat2');
    my constant @ì  = Nil, 'cat1', 'cat2', 'cat2';
    my constant %e̲ч = %(:a(42), :cat2['val 2', 'val 3'], :cat1['val 1']);

    is-deeply %(:42a).categorize-list(:&as, &ì, [1, 2, 3]), %e̲ч, '&, Array';
    is-deeply %(:42a).categorize-list(:&as, %ì, [1, 2, 3]), %e̲ч, '%, Array';
    is-deeply %(:42a).categorize-list(:&as, @ì, [1, 2, 3]), %e̲ч, '@, Array';
    is-deeply %(:42a).categorize-list(:&as, &ì,  1, 2, 3 ), %e̲ч, '&, comma list';
    is-deeply %(:42a).categorize-list(:&as, %ì,  1, 2, 3 ), %e̲ч, '%, comma list';
    is-deeply %(:42a).categorize-list(:&as, @ì,  1, 2, 3 ), %e̲ч, '@, comma list';
    is-deeply %(:42a).categorize-list(:&as, &ì,   ^3+1   ), %e̲ч, '&, Range';
    is-deeply %(:42a).categorize-list(:&as, %ì,   ^3+1   ), %e̲ч, '%, Range';
    is-deeply %(:42a).categorize-list(:&as, @ì,   ^3+1   ), %e̲ч, '@, Range';
    is-deeply %(:42a).categorize-list(:&as, &ì,   (1…3)  ), %e̲ч, '&, Seq';
    is-deeply %(:42a).categorize-list(:&as, %ì,   (1…3)  ), %e̲ч, '%, Seq';
    is-deeply %(:42a).categorize-list(:&as, @ì,   (1…3)  ), %e̲ч, '@, Seq';
}

subtest 'on populated Hash, multi-category' => {
    plan 12;
    my constant &ì  = { $^a == 1 ?? <cat1 cat3> !! <cat2 cat4> }
    my constant @ì  = Nil,   <cat1 cat3>,      <cat2 cat4>,      <cat2 cat4>;
    my constant %ì  = %(1 => <cat1 cat3>, 2 => <cat2 cat4>, 3 => <cat2 cat4>);
    my constant %e̲ч = %(:a(42), :cat2[2, 3], :cat4[2, 3], :cat1[1], :cat3[1]);

    is-deeply %(:42a).categorize-list(&ì, [1, 2, 3]), %e̲ч, '&, Array';
    is-deeply %(:42a).categorize-list(%ì, [1, 2, 3]), %e̲ч, '%, Array';
    is-deeply %(:42a).categorize-list(@ì, [1, 2, 3]), %e̲ч, '@, Array';
    is-deeply %(:42a).categorize-list(&ì,  1, 2, 3 ), %e̲ч, '&, comma list';
    is-deeply %(:42a).categorize-list(%ì,  1, 2, 3 ), %e̲ч, '%, comma list';
    is-deeply %(:42a).categorize-list(@ì,  1, 2, 3 ), %e̲ч, '@, comma list';
    is-deeply %(:42a).categorize-list(&ì,   ^3+1   ), %e̲ч, '&, Range';
    is-deeply %(:42a).categorize-list(%ì,   ^3+1   ), %e̲ч, '%, Range';
    is-deeply %(:42a).categorize-list(@ì,   ^3+1   ), %e̲ч, '@, Range';
    is-deeply %(:42a).categorize-list(&ì,   (1…3)  ), %e̲ч, '&, Seq';
    is-deeply %(:42a).categorize-list(%ì,   (1…3)  ), %e̲ч, '%, Seq';
    is-deeply %(:42a).categorize-list(@ì,   (1…3)  ), %e̲ч, '@, Seq';
}

subtest 'on populated Hash, multi-category, with &as' => {
    plan 12;
    my constant &as = { "val $^a" }
    my constant &ì  = { $^a == 1 ?? <cat1 cat3> !! <cat2 cat4> }
    my constant @ì  = Nil,   <cat1 cat3>,      <cat2 cat4>,      <cat2 cat4>;
    my constant %ì  = %(1 => <cat1 cat3>, 2 => <cat2 cat4>, 3 => <cat2 cat4>);
    my constant %e̲ч = %(
        :a(42),
        :cat2['val 2', 'val 3'], :cat4['val 2', 'val 3'],
        :cat1['val 1'], :cat3['val 1'],
    );

    is-deeply %(:42a).categorize-list(:&as, &ì, [1, 2, 3]), %e̲ч, '&, Array';
    is-deeply %(:42a).categorize-list(:&as, %ì, [1, 2, 3]), %e̲ч, '%, Array';
    is-deeply %(:42a).categorize-list(:&as, @ì, [1, 2, 3]), %e̲ч, '@, Array';
    is-deeply %(:42a).categorize-list(:&as, &ì,  1, 2, 3 ), %e̲ч, '&, comma list';
    is-deeply %(:42a).categorize-list(:&as, %ì,  1, 2, 3 ), %e̲ч, '%, comma list';
    is-deeply %(:42a).categorize-list(:&as, @ì,  1, 2, 3 ), %e̲ч, '@, comma list';
    is-deeply %(:42a).categorize-list(:&as, &ì,   ^3+1   ), %e̲ч, '&, Range';
    is-deeply %(:42a).categorize-list(:&as, %ì,   ^3+1   ), %e̲ч, '%, Range';
    is-deeply %(:42a).categorize-list(:&as, @ì,   ^3+1   ), %e̲ч, '@, Range';
    is-deeply %(:42a).categorize-list(:&as, &ì,   (1…3)  ), %e̲ч, '&, Seq';
    is-deeply %(:42a).categorize-list(:&as, %ì,   (1…3)  ), %e̲ч, '%, Seq';
    is-deeply %(:42a).categorize-list(:&as, @ì,   (1…3)  ), %e̲ч, '@, Seq';
}

subtest 'on populated Hash, multi-level' => {
    plan 12;
    my constant &ì = {
        $^a == 1 ?? [<cat1 cat3>,] !!
            $^a == 2 ?? [<cat2 cat4>,] !! [<cat1 cat3>, <cat2 cat4>,];
    }
    my constant @ì
        = Nil, [<cat1 cat3>,], [<cat2 cat4>,], [<cat1 cat3>, <cat2 cat4>,];
    my constant %ì  = %(
        1 => [<cat1 cat3>,], 2 => [<cat2 cat4>,],
        3 => [<cat1 cat3>, <cat2 cat4>,]
    );
    my constant %e̲ч = %(:a(42),
        :cat1(${:cat3($[1, 3])}),
        :cat2(${:cat4($[2, 3])}),
    );

    is-deeply %(:42a).categorize-list(&ì, [1, 2, 3]), %e̲ч, '&, Array';
    is-deeply %(:42a).categorize-list(%ì, [1, 2, 3]), %e̲ч, '%, Array';
    is-deeply %(:42a).categorize-list(@ì, [1, 2, 3]), %e̲ч, '@, Array';
    is-deeply %(:42a).categorize-list(&ì,  1, 2, 3 ), %e̲ч, '&, comma list';
    is-deeply %(:42a).categorize-list(%ì,  1, 2, 3 ), %e̲ч, '%, comma list';
    is-deeply %(:42a).categorize-list(@ì,  1, 2, 3 ), %e̲ч, '@, comma list';
    is-deeply %(:42a).categorize-list(&ì,   ^3+1   ), %e̲ч, '&, Range';
    is-deeply %(:42a).categorize-list(%ì,   ^3+1   ), %e̲ч, '%, Range';
    is-deeply %(:42a).categorize-list(@ì,   ^3+1   ), %e̲ч, '@, Range';
    is-deeply %(:42a).categorize-list(&ì,   (1…3)  ), %e̲ч, '&, Seq';
    is-deeply %(:42a).categorize-list(%ì,   (1…3)  ), %e̲ч, '%, Seq';
    is-deeply %(:42a).categorize-list(@ì,   (1…3)  ), %e̲ч, '@, Seq';
}

subtest 'on populated Hash, multi-level, with &as' => {
    plan 12;
    my constant &as = { "val $^a" }
    my constant &ì = {
        $^a == 1 ?? [<cat1 cat3>,] !!
            $^a == 2 ?? [<cat2 cat4>,] !! [<cat1 cat3>, <cat2 cat4>,];
    }
    my constant @ì
        = Nil, [<cat1 cat3>,], [<cat2 cat4>,], [<cat1 cat3>, <cat2 cat4>,];
    my constant %ì  = %(
        1 => [<cat1 cat3>,], 2 => [<cat2 cat4>,],
        3 => [<cat1 cat3>, <cat2 cat4>,]
    );
    my constant %e̲ч = %(:a(42),
        :cat1(${:cat3($['val 1', 'val 3'])}),
        :cat2(${:cat4($['val 2', 'val 3'])}),
    );

    is-deeply %(:42a).categorize-list(:&as, &ì, [1, 2, 3]), %e̲ч, '&, Array';
    is-deeply %(:42a).categorize-list(:&as, %ì, [1, 2, 3]), %e̲ч, '%, Array';
    is-deeply %(:42a).categorize-list(:&as, @ì, [1, 2, 3]), %e̲ч, '@, Array';
    is-deeply %(:42a).categorize-list(:&as, &ì,  1, 2, 3 ), %e̲ч, '&, comma list';
    is-deeply %(:42a).categorize-list(:&as, %ì,  1, 2, 3 ), %e̲ч, '%, comma list';
    is-deeply %(:42a).categorize-list(:&as, @ì,  1, 2, 3 ), %e̲ч, '@, comma list';
    is-deeply %(:42a).categorize-list(:&as, &ì,   ^3+1   ), %e̲ч, '&, Range';
    is-deeply %(:42a).categorize-list(:&as, %ì,   ^3+1   ), %e̲ч, '%, Range';
    is-deeply %(:42a).categorize-list(:&as, @ì,   ^3+1   ), %e̲ч, '@, Range';
    is-deeply %(:42a).categorize-list(:&as, &ì,   (1…3)  ), %e̲ч, '&, Seq';
    is-deeply %(:42a).categorize-list(:&as, %ì,   (1…3)  ), %e̲ч, '%, Seq';
    is-deeply %(:42a).categorize-list(:&as, @ì,   (1…3)  ), %e̲ч, '@, Seq';
}

#------------------------------------------------------------------------------
# degenerate cases
#------------------------------------------------------------------------------

subtest 'on Hashes, degenerate cases, no items to loop over' => {
    plan 12;
    my constant &as = { "val $^a" }
    my constant &ì  = { $^a == 1 ?? 'cat1' !! 'cat2' }
    my constant %ì  = %(1 => 'cat1', 2 => 'cat2', 3 => 'cat2');
    my constant @ì  = Nil, 'cat1', 'cat2', 'cat2';
    my constant %e̲ч-e̲ì𝐩中ù = %();
    my constant %e̲ч-𝐩갨𝐩л中 = %(:42a);

    is-deeply %()    .categorize-list(      &ì), %e̲ч-e̲ì𝐩中ù, 'empty, &';
    is-deeply %()    .categorize-list(      %ì), %e̲ч-e̲ì𝐩中ù, 'empty, %';
    is-deeply %()    .categorize-list(      @ì), %e̲ч-e̲ì𝐩中ù, 'empty, @';
    is-deeply %()    .categorize-list(:&as, &ì), %e̲ч-e̲ì𝐩中ù, 'empty, :&as, &';
    is-deeply %()    .categorize-list(:&as, %ì), %e̲ч-e̲ì𝐩中ù, 'empty, :&as, %';
    is-deeply %()    .categorize-list(:&as, @ì), %e̲ч-e̲ì𝐩中ù, 'empty, :&as, @';
    is-deeply %(:42a).categorize-list(      &ì), %e̲ч-𝐩갨𝐩л中, 'populated, &';
    is-deeply %(:42a).categorize-list(      %ì), %e̲ч-𝐩갨𝐩л中, 'populated, %';
    is-deeply %(:42a).categorize-list(      @ì), %e̲ч-𝐩갨𝐩л中, 'populated, @';
    is-deeply %(:42a).categorize-list(:&as, &ì), %e̲ч-𝐩갨𝐩л中, 'populatd, :&as, &';
    is-deeply %(:42a).categorize-list(:&as, %ì), %e̲ч-𝐩갨𝐩л中, 'populatd, :&as, %';
    is-deeply %(:42a).categorize-list(:&as, @ì), %e̲ч-𝐩갨𝐩л中, 'populatd, :&as, @';
}

subtest 'on Hashes, degenerate cases, 0-item, multi-level iterables' => {
    plan 12;
    my constant &as = { "val $^a" }
    my constant &ì  = { $^a == 0 ?? ((),) !! ((),) }
    my constant %ì  = %(0 => ((),), 1 => ((),), 2 => ((),));
    my constant @ì  = ((),), ((),), ((),);
    my constant %e̲ч-e̲   = %();
    my constant %e̲ч-𝐩   = %(:42a);
    my constant %e̲ч-e̲àò = %();
    my constant %e̲ч-𝐩àò = %(:42a);

    is-deeply %()    .categorize-list(      &ì, ^3), %e̲ч-e̲,   'empty, &';
    is-deeply %()    .categorize-list(      %ì, ^3), %e̲ч-e̲,   'empty, %';
    is-deeply %()    .categorize-list(      @ì, ^3), %e̲ч-e̲,   'empty, @';
    is-deeply %()    .categorize-list(:&as, &ì, ^3), %e̲ч-e̲àò, 'empty, :&as, &';
    is-deeply %()    .categorize-list(:&as, %ì, ^3), %e̲ч-e̲àò, 'empty, :&as, %';
    is-deeply %()    .categorize-list(:&as, @ì, ^3), %e̲ч-e̲àò, 'empty, :&as, @';
    is-deeply %(:42a).categorize-list(      &ì, ^3), %e̲ч-𝐩,   'poptd, &';
    is-deeply %(:42a).categorize-list(      %ì, ^3), %e̲ч-𝐩,   'poptd, %';
    is-deeply %(:42a).categorize-list(      @ì, ^3), %e̲ч-𝐩,   'poptd, @';
    is-deeply %(:42a).categorize-list(:&as, &ì, ^3), %e̲ч-𝐩àò, 'poptd, :&as, &';
    is-deeply %(:42a).categorize-list(:&as, %ì, ^3), %e̲ч-𝐩àò, 'poptd, :&as, %';
    is-deeply %(:42a).categorize-list(:&as, @ì, ^3), %e̲ч-𝐩àò, 'poptd, :&as, @';
}

subtest 'on Hashes, degenerate cases, mapper returns empty list' => {
    plan 12;
    my constant &as = { "val $^a" }
    my constant &ì  = { $^a == 0 ?? () !! 'cat2' }
    my constant %ì  = %(0 => (), 1 => 'cat2', 2 => 'cat2');
    my constant @ì  = (), 'cat2', 'cat2';
    my constant %e̲ч-e̲   = %(:cat2[1, 2]);
    my constant %e̲ч-𝐩   = %(:42a, :cat2[1, 2]);
    my constant %e̲ч-e̲àò = %(:cat2['val 1', 'val 2']);
    my constant %e̲ч-𝐩àò = %(:42a, :cat2['val 1', 'val 2']);

    is-deeply %()    .categorize-list(      &ì, ^3), %e̲ч-e̲,   'empty, &';
    is-deeply %()    .categorize-list(      %ì, ^3), %e̲ч-e̲,   'empty, %';
    is-deeply %()    .categorize-list(      @ì, ^3), %e̲ч-e̲,   'empty, @';
    is-deeply %()    .categorize-list(:&as, &ì, ^3), %e̲ч-e̲àò, 'empty, :&as, &';
    is-deeply %()    .categorize-list(:&as, %ì, ^3), %e̲ч-e̲àò, 'empty, :&as, %';
    is-deeply %()    .categorize-list(:&as, @ì, ^3), %e̲ч-e̲àò, 'empty, :&as, @';
    is-deeply %(:42a).categorize-list(      &ì, ^3), %e̲ч-𝐩,   'poptd, &';
    is-deeply %(:42a).categorize-list(      %ì, ^3), %e̲ч-𝐩,   'poptd, %';
    is-deeply %(:42a).categorize-list(      @ì, ^3), %e̲ч-𝐩,   'poptd, @';
    is-deeply %(:42a).categorize-list(:&as, &ì, ^3), %e̲ч-𝐩àò, 'poptd, :&as, &';
    is-deeply %(:42a).categorize-list(:&as, %ì, ^3), %e̲ч-𝐩àò, 'poptd, :&as, %';
    is-deeply %(:42a).categorize-list(:&as, @ì, ^3), %e̲ч-𝐩àò, 'poptd, :&as, @';
}

#------------------------------------------------------------------------------
# exceptions
#------------------------------------------------------------------------------

subtest ‘on Hashes, exceptions, can't classify lazy lists’ => {
    plan 12;
    my constant $л  = (−∞…∞);
    my constant &as = { "val $^a" }

    throws-like { %().categorize-list: {;}, $л }, X::Cannot::Lazy, 'empty hash, &';
    throws-like { %().categorize-list: %(),  $л }, X::Cannot::Lazy, 'empty hash, %';
    throws-like { %().categorize-list: @(),  $л }, X::Cannot::Lazy, 'empty hash, @';
    throws-like { %().categorize-list: :&as, {;}, $л }, X::Cannot::Lazy,
        'empty hash, :&as, &';
    throws-like { %().categorize-list: :&as, %(), $л }, X::Cannot::Lazy,
        'empty hash, :&as, %';
    throws-like { %().categorize-list: :&as, @(), $л }, X::Cannot::Lazy,
        'empty hash, :&as, @';

    throws-like { %(:42a).categorize-list: {;}, $л }, X::Cannot::Lazy,
        'populated hash, &';
    throws-like { %(:42a).categorize-list: %(), $л }, X::Cannot::Lazy,
        'populated hash, %';
    throws-like { %(:42a).categorize-list: @(), $л }, X::Cannot::Lazy,
        'populated hash, @';

    throws-like { %(:42a).categorize-list: :&as, {;}, $л }, X::Cannot::Lazy,
        'populated hash, :&as, &';
    throws-like { %(:42a).categorize-list: :&as, %(), $л }, X::Cannot::Lazy,
        'populated hash, :&as, %';
    throws-like { %(:42a).categorize-list: :&as, @(), $л }, X::Cannot::Lazy,
        'populated hash, :&as, @';
}

subtest ‘on Hashes, exceptions, can't do mixed-level classification’ => {
    plan 12;
    my constant &ì1  = { $^a == 1 ?? [['cat1',],] !! <cat2 cat3> }
    my constant %ì1  = %(1 => [['cat1',],], 2 => <cat2 cat3>, 3 => <cat2 cat3>);
    my constant @ì1  = Nil, [['cat1',],], <cat2 cat3>, <cat2 cat3>;
    my constant &ì2  = { $^a == 1 ?? <cat1 cat3> !! [['cat2',],] }
    my constant %ì2
        = %(1 => <cat1 cat3>, 2 => [['cat2',],], 3 => [['cat2',],]);
    my constant @ì2  = Nil, <cat1 cat3>, [['cat2',],], [['cat2',],];
    my constant &as  = { "val $^a" }

    throws-like { %() .categorize-list: &ì1, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, '&, v1';
    throws-like { %() .categorize-list: %ì1, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, '%, v1';
    throws-like { %() .categorize-list: @ì1, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, '@, v1';
    throws-like { %() .categorize-list: &ì2, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, '&, v2';
    throws-like { %() .categorize-list: %ì2, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, '%, v2';
    throws-like { %() .categorize-list: @ì2, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, '@, v2';

    throws-like { %() .categorize-list: :&as, &ì1, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, ':&as, &, v1';
    throws-like { %() .categorize-list: :&as, %ì1, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, ':&as, %, v1';
    throws-like { %() .categorize-list: :&as, @ì1, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, ':&as, @, v1';
    throws-like { %() .categorize-list: :&as, &ì2, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, ':&as, &, v2';
    throws-like { %() .categorize-list: :&as, %ì2, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, ':&as, %, v2';
    throws-like { %() .categorize-list: :&as, @ì2, [1, 2, 3] },
        X::Invalid::ComputedValue, message => /:i 'mixed-level'/, ':&as, @, v2';
}

###############################################################################
# on Baggy
###############################################################################

#------------------------------------------------------------------------------
# empty Baggy
#------------------------------------------------------------------------------

subtest 'on empty BagHash, single category' => {
    plan 12;
    my constant &ì  = { $^a == 1 ?? 'cat1' !! 'cat2' }
    my constant %ì  = %(1 => 'cat1', 2 => 'cat2', 3 => 'cat2');
    my constant @ì  = Nil, 'cat1', 'cat2', 'cat2';
    my constant $e̲ч = BagHash.new: <cat1  cat2 cat2>;

    is-deeply BagHash.new.categorize-list(&ì, [1, 2, 3]), $e̲ч, '&, Array';
    is-deeply BagHash.new.categorize-list(%ì, [1, 2, 3]), $e̲ч, '%, Array';
    is-deeply BagHash.new.categorize-list(@ì, [1, 2, 3]), $e̲ч, '@, Array';
    is-deeply BagHash.new.categorize-list(&ì,  1, 2, 3 ), $e̲ч, '&, comma list';
    is-deeply BagHash.new.categorize-list(%ì,  1, 2, 3 ), $e̲ч, '%, comma list';
    is-deeply BagHash.new.categorize-list(@ì,  1, 2, 3 ), $e̲ч, '@, comma list';
    is-deeply BagHash.new.categorize-list(&ì,   ^3+1   ), $e̲ч, '&, Range';
    is-deeply BagHash.new.categorize-list(%ì,   ^3+1   ), $e̲ч, '%, Range';
    is-deeply BagHash.new.categorize-list(@ì,   ^3+1   ), $e̲ч, '@, Range';
    is-deeply BagHash.new.categorize-list(&ì,   (1…3)  ), $e̲ч, '&, Seq';
    is-deeply BagHash.new.categorize-list(%ì,   (1…3)  ), $e̲ч, '%, Seq';
    is-deeply BagHash.new.categorize-list(@ì,   (1…3)  ), $e̲ч, '@, Seq';
}

subtest 'on populated BagHash, single category' => {
    plan 12;
    my constant &ì  = { $^a == 1 ?? 'cat1' !! 'cat2' }
    my constant %ì  = %(1 => 'cat1', 2 => 'cat2', 3 => 'cat2');
    my constant @ì  = Nil, 'cat1', 'cat2', 'cat2';
    my constant $e̲ч = BagHash.new: <a b  cat1  cat2 cat2>;

    is-deeply BagHash.new(<a b>).categorize-list(&ì, [1, 2, 3]), $e̲ч, '&, Array';
    is-deeply BagHash.new(<a b>).categorize-list(%ì, [1, 2, 3]), $e̲ч, '%, Array';
    is-deeply BagHash.new(<a b>).categorize-list(@ì, [1, 2, 3]), $e̲ч, '@, Array';
    is-deeply BagHash.new(<a b>).categorize-list(&ì,  1, 2, 3 ), $e̲ч, '&, commas';
    is-deeply BagHash.new(<a b>).categorize-list(%ì,  1, 2, 3 ), $e̲ч, '%, commas';
    is-deeply BagHash.new(<a b>).categorize-list(@ì,  1, 2, 3 ), $e̲ч, '@, commas';
    is-deeply BagHash.new(<a b>).categorize-list(&ì,   ^3+1   ), $e̲ч, '&, Range';
    is-deeply BagHash.new(<a b>).categorize-list(%ì,   ^3+1   ), $e̲ч, '%, Range';
    is-deeply BagHash.new(<a b>).categorize-list(@ì,   ^3+1   ), $e̲ч, '@, Range';
    is-deeply BagHash.new(<a b>).categorize-list(&ì,   (1…3)  ), $e̲ч, '&, Seq';
    is-deeply BagHash.new(<a b>).categorize-list(%ì,   (1…3)  ), $e̲ч, '%, Seq';
    is-deeply BagHash.new(<a b>).categorize-list(@ì,   (1…3)  ), $e̲ч, '@, Seq';
}

subtest 'on populated MixHash, single category' => {
    plan 12;
    my constant &ì  = { $^a == 1 ?? 'cat1' !! 'cat2' }
    my constant %ì  = %(1 => 'cat1', 2 => 'cat2', 3 => 'cat2');
    my constant @ì  = Nil, 'cat1', 'cat2', 'cat2';
    my constant $e̲ч = MixHash.new: <a b  cat1  cat2 cat2>;

    is-deeply MixHash.new(<a b>).categorize-list(&ì, [1, 2, 3]), $e̲ч, '&, Array';
    is-deeply MixHash.new(<a b>).categorize-list(%ì, [1, 2, 3]), $e̲ч, '%, Array';
    is-deeply MixHash.new(<a b>).categorize-list(@ì, [1, 2, 3]), $e̲ч, '@, Array';
    is-deeply MixHash.new(<a b>).categorize-list(&ì,  1, 2, 3 ), $e̲ч, '&, commas';
    is-deeply MixHash.new(<a b>).categorize-list(%ì,  1, 2, 3 ), $e̲ч, '%, commas';
    is-deeply MixHash.new(<a b>).categorize-list(@ì,  1, 2, 3 ), $e̲ч, '@, commas';
    is-deeply MixHash.new(<a b>).categorize-list(&ì,   ^3+1   ), $e̲ч, '&, Range';
    is-deeply MixHash.new(<a b>).categorize-list(%ì,   ^3+1   ), $e̲ч, '%, Range';
    is-deeply MixHash.new(<a b>).categorize-list(@ì,   ^3+1   ), $e̲ч, '@, Range';
    is-deeply MixHash.new(<a b>).categorize-list(&ì,   (1…3)  ), $e̲ч, '&, Seq';
    is-deeply MixHash.new(<a b>).categorize-list(%ì,   (1…3)  ), $e̲ч, '%, Seq';
    is-deeply MixHash.new(<a b>).categorize-list(@ì,   (1…3)  ), $e̲ч, '@, Seq';
}

subtest 'on empty BagHash, multi-category' => {
    plan 12;
    my constant &ì  = { $^a == 1 ?? 'cat1' !! <cat2 cat3> }
    my constant %ì  = %(1 => 'cat1', 2 => <cat2 cat3>, 3 => <cat2 cat3>);
    my constant @ì  = Nil, 'cat1', <cat2 cat3>, <cat2 cat3>;
    my constant $e̲ч = BagHash.new: <cat1  cat2 cat2  cat3 cat3>;

    is-deeply BagHash.new.categorize-list(&ì, [1, 2, 3]), $e̲ч, '&, Array';
    is-deeply BagHash.new.categorize-list(%ì, [1, 2, 3]), $e̲ч, '%, Array';
    is-deeply BagHash.new.categorize-list(@ì, [1, 2, 3]), $e̲ч, '@, Array';
    is-deeply BagHash.new.categorize-list(&ì,  1, 2, 3 ), $e̲ч, '&, comma list';
    is-deeply BagHash.new.categorize-list(%ì,  1, 2, 3 ), $e̲ч, '%, comma list';
    is-deeply BagHash.new.categorize-list(@ì,  1, 2, 3 ), $e̲ч, '@, comma list';
    is-deeply BagHash.new.categorize-list(&ì,   ^3+1   ), $e̲ч, '&, Range';
    is-deeply BagHash.new.categorize-list(%ì,   ^3+1   ), $e̲ч, '%, Range';
    is-deeply BagHash.new.categorize-list(@ì,   ^3+1   ), $e̲ч, '@, Range';
    is-deeply BagHash.new.categorize-list(&ì,   (1…3)  ), $e̲ч, '&, Seq';
    is-deeply BagHash.new.categorize-list(%ì,   (1…3)  ), $e̲ч, '%, Seq';
    is-deeply BagHash.new.categorize-list(@ì,   (1…3)  ), $e̲ч, '@, Seq';
}

subtest 'on populated BagHash, multi-category' => {
    plan 12;
    my constant &ì  = { $^a == 1 ?? 'cat1' !! <cat2 cat3> }
    my constant %ì  = %(1 => 'cat1', 2 => <cat2 cat3>, 3 => <cat2 cat3>);
    my constant @ì  = Nil, 'cat1', <cat2 cat3>, <cat2 cat3>;
    my constant $e̲ч = BagHash.new: <a b  cat1  cat2 cat2  cat3 cat3>;

    is-deeply BagHash.new(<a b>).categorize-list(&ì, [1, 2, 3]), $e̲ч, '&, Array';
    is-deeply BagHash.new(<a b>).categorize-list(%ì, [1, 2, 3]), $e̲ч, '%, Array';
    is-deeply BagHash.new(<a b>).categorize-list(@ì, [1, 2, 3]), $e̲ч, '@, Array';
    is-deeply BagHash.new(<a b>).categorize-list(&ì,  1, 2, 3 ), $e̲ч, '&, commas';
    is-deeply BagHash.new(<a b>).categorize-list(%ì,  1, 2, 3 ), $e̲ч, '%, commas';
    is-deeply BagHash.new(<a b>).categorize-list(@ì,  1, 2, 3 ), $e̲ч, '@, commas';
    is-deeply BagHash.new(<a b>).categorize-list(&ì,   ^3+1   ), $e̲ч, '&, Range';
    is-deeply BagHash.new(<a b>).categorize-list(%ì,   ^3+1   ), $e̲ч, '%, Range';
    is-deeply BagHash.new(<a b>).categorize-list(@ì,   ^3+1   ), $e̲ч, '@, Range';
    is-deeply BagHash.new(<a b>).categorize-list(&ì,   (1…3)  ), $e̲ч, '&, Seq';
    is-deeply BagHash.new(<a b>).categorize-list(%ì,   (1…3)  ), $e̲ч, '%, Seq';
    is-deeply BagHash.new(<a b>).categorize-list(@ì,   (1…3)  ), $e̲ч, '@, Seq';
}

subtest 'on populated MixHash, multi-category' => {
    plan 12;
    my constant &ì  = { $^a == 1 ?? 'cat1' !! <cat2 cat3> }
    my constant %ì  = %(1 => 'cat1', 2 => <cat2 cat3>, 3 => <cat2 cat3>);
    my constant @ì  = Nil, 'cat1', <cat2 cat3>, <cat2 cat3>;
    my constant $e̲ч = MixHash.new: <a b  cat1  cat2 cat2  cat3 cat3>;

    is-deeply MixHash.new(<a b>).categorize-list(&ì, [1, 2, 3]), $e̲ч, '&, Array';
    is-deeply MixHash.new(<a b>).categorize-list(%ì, [1, 2, 3]), $e̲ч, '%, Array';
    is-deeply MixHash.new(<a b>).categorize-list(@ì, [1, 2, 3]), $e̲ч, '@, Array';
    is-deeply MixHash.new(<a b>).categorize-list(&ì,  1, 2, 3 ), $e̲ч, '&, commas';
    is-deeply MixHash.new(<a b>).categorize-list(%ì,  1, 2, 3 ), $e̲ч, '%, commas';
    is-deeply MixHash.new(<a b>).categorize-list(@ì,  1, 2, 3 ), $e̲ч, '@, commas';
    is-deeply MixHash.new(<a b>).categorize-list(&ì,   ^3+1   ), $e̲ч, '&, Range';
    is-deeply MixHash.new(<a b>).categorize-list(%ì,   ^3+1   ), $e̲ч, '%, Range';
    is-deeply MixHash.new(<a b>).categorize-list(@ì,   ^3+1   ), $e̲ч, '@, Range';
    is-deeply MixHash.new(<a b>).categorize-list(&ì,   (1…3)  ), $e̲ч, '&, Seq';
    is-deeply MixHash.new(<a b>).categorize-list(%ì,   (1…3)  ), $e̲ч, '%, Seq';
    is-deeply MixHash.new(<a b>).categorize-list(@ì,   (1…3)  ), $e̲ч, '@, Seq';
}

#------------------------------------------------------------------------------
# degenerate cases
#------------------------------------------------------------------------------

subtest 'on Baggy, degenerate cases, no items to loop over' => {
    plan 12;
    my constant &ì  = { $^a == 1 ?? 'cat1' !! 'cat2' }
    my constant %ì  = %(1 => 'cat1', 2 => 'cat2', 3 => 'cat2');
    my constant @ì  = Nil, 'cat1', 'cat2', 'cat2';
    my constant $e̲ч-丛àæ-e̲ì𝐩中ù = BagHash.new;
    my constant $e̲ч-ì갢ч-e̲ì𝐩中ù = MixHash.new;
    my constant $e̲ч-丛àæ-𝐩갨𝐩л中 = BagHash.new: <a b>;
    my constant $e̲ч-ì갢ч-𝐩갨𝐩л中 = MixHash.new: <a b>;

    is-deeply BagHash.new.categorize-list(&ì), $e̲ч-丛àæ-e̲ì𝐩中ù, 'BagHash, empty, &';
    is-deeply BagHash.new.categorize-list(%ì), $e̲ч-丛àæ-e̲ì𝐩中ù, 'BagHash, empty, %';
    is-deeply BagHash.new.categorize-list(@ì), $e̲ч-丛àæ-e̲ì𝐩中ù, 'BagHash, empty, @';
    is-deeply MixHash.new.categorize-list(&ì), $e̲ч-ì갢ч-e̲ì𝐩中ù, 'MixHash, empty, &';
    is-deeply MixHash.new.categorize-list(%ì), $e̲ч-ì갢ч-e̲ì𝐩中ù, 'MixHash, empty, %';
    is-deeply MixHash.new.categorize-list(@ì), $e̲ч-ì갢ч-e̲ì𝐩中ù, 'MixHash, empty, @';
    is-deeply BagHash.new(<a b>).categorize-list(&ì), $e̲ч-丛àæ-𝐩갨𝐩л中,
        'BagHash, populated, &';
    is-deeply BagHash.new(<a b>).categorize-list(%ì), $e̲ч-丛àæ-𝐩갨𝐩л中,
        'BagHash, populated, %';
    is-deeply BagHash.new(<a b>).categorize-list(@ì), $e̲ч-丛àæ-𝐩갨𝐩л中,
        'BagHash, populated, @';
    is-deeply MixHash.new(<a b>).categorize-list(&ì), $e̲ч-ì갢ч-𝐩갨𝐩л中,
        'MixHash, populated, &';
    is-deeply MixHash.new(<a b>).categorize-list(%ì), $e̲ч-ì갢ч-𝐩갨𝐩л中,
        'MixHash, populated, %';
    is-deeply MixHash.new(<a b>).categorize-list(@ì), $e̲ч-ì갢ч-𝐩갨𝐩л中,
        'MixHash, populated, @';
}

subtest 'on Hashes, degenerate cases, mapper returns empty list' => {
    plan 12;
    my constant &as = { "val $^a" }
    my constant &ì  = { $^a == 0 ?? () !! 'cat2' }
    my constant %ì  = %(0 => (), 1 => 'cat2', 2 => 'cat2');
    my constant @ì  = (), 'cat2', 'cat2';
    my constant %e̲ч-丛e̲ = BagHash.new: <cat2 cat2>;
    my constant %e̲ч-ìe̲ = MixHash.new: <cat2 cat2>;
    my constant %e̲ч-丛𝐩 = BagHash.new: <a b  cat2 cat2>;
    my constant %e̲ч-ì𝐩 = MixHash.new: <a b  cat2 cat2>;

    is-deeply BagHash.new.categorize-list(&ì, ^3), %e̲ч-丛e̲, 'BagHash, empty, &';
    is-deeply BagHash.new.categorize-list(%ì, ^3), %e̲ч-丛e̲, 'BagHash, empty, %';
    is-deeply BagHash.new.categorize-list(@ì, ^3), %e̲ч-丛e̲, 'BagHash, empty, @';
    is-deeply MixHash.new.categorize-list(&ì, ^3), %e̲ч-ìe̲, 'MixHash, empty, &';
    is-deeply MixHash.new.categorize-list(%ì, ^3), %e̲ч-ìe̲, 'MixHash, empty, %';
    is-deeply MixHash.new.categorize-list(@ì, ^3), %e̲ч-ìe̲, 'MixHash, empty, @';

    is-deeply BagHash.new(<a b>).categorize-list(&ì, ^3), %e̲ч-丛𝐩,
        'BagHash, populated, &';
    is-deeply BagHash.new(<a b>).categorize-list(%ì, ^3), %e̲ч-丛𝐩,
        'BagHash, populated, %';
    is-deeply BagHash.new(<a b>).categorize-list(@ì, ^3), %e̲ч-丛𝐩,
        'BagHash, populated, @';
    is-deeply MixHash.new(<a b>).categorize-list(&ì, ^3), %e̲ч-ì𝐩,
        'MixHash, populated, &';
    is-deeply MixHash.new(<a b>).categorize-list(%ì, ^3), %e̲ч-ì𝐩,
        'MixHash, populated, %';
    is-deeply MixHash.new(<a b>).categorize-list(@ì, ^3), %e̲ч-ì𝐩,
        'MixHash, populated, @';
}


#------------------------------------------------------------------------------
# exceptions
#------------------------------------------------------------------------------

subtest ‘on Baggy, exceptions, can't classify lazy lists’ => {
    plan 12;
    my constant $л = (−∞…∞);

    throws-like { BagHash.new.categorize-list: {;}, $л }, X::Cannot::Lazy,
        'empty BagHash, &';
    throws-like { BagHash.new.categorize-list: %(),  $л }, X::Cannot::Lazy,
        'empty BagHash, %';
    throws-like { BagHash.new.categorize-list: @(),  $л }, X::Cannot::Lazy,
        'empty BagHash, @';
    throws-like { MixHash.new.categorize-list: {;}, $л }, X::Cannot::Lazy,
        'empty MixHash, &';
    throws-like { MixHash.new.categorize-list: %(),  $л }, X::Cannot::Lazy,
        'empty MixHash, %';
    throws-like { MixHash.new.categorize-list: @(),  $л }, X::Cannot::Lazy,
        'empty MixHash, @';

    throws-like { BagHash.new(<a b>).categorize-list: {;}, $л }, X::Cannot::Lazy,
        'populated BagHash, &';
    throws-like { BagHash.new(<a b>).categorize-list: %(),  $л }, X::Cannot::Lazy,
        'populated BagHash, %';
    throws-like { BagHash.new(<a b>).categorize-list: @(),  $л }, X::Cannot::Lazy,
        'populated BagHash, @';
    throws-like { MixHash.new(<a b>).categorize-list: {;}, $л }, X::Cannot::Lazy,
        'populated MixHash, &';
    throws-like { MixHash.new(<a b>).categorize-list: %(),  $л }, X::Cannot::Lazy,
        'populated MixHash, %';
    throws-like { MixHash.new(<a b>).categorize-list: @(),  $л }, X::Cannot::Lazy,
        'populated MixHash, @';
}

subtest ‘on Baggy, exceptions, can't multi-level classify’ => {
    plan 6;
    my constant &ì  = { $^a == 1 ?? [<a b>,] !! [<a b>,] }
    my constant @ì  = Nil,   [<a b>,],      [<a b>,],      [<a b>,];
    my constant %ì  = %(1 => [<a b>,], 2 => [<a b>,], 3 => [<a b>,]);

    throws-like { BagHash.new.categorize-list: &ì, 1, 2, 3  },
        X::Invalid::ComputedValue,
        message => /'multi-level categorization'/, 'BagHash, &';
    throws-like { BagHash.new.categorize-list: %ì, 1, 2, 3  },
        X::Invalid::ComputedValue,
        message => /'multi-level categorization'/, 'BagHash, %';
    throws-like { BagHash.new.categorize-list: @ì, 1, 2, 3  },
        X::Invalid::ComputedValue,
        message => /'multi-level categorization'/, 'BagHash, @';
    throws-like { MixHash.new.categorize-list: &ì, 1, 2, 3  },
        X::Invalid::ComputedValue,
        message => /'multi-level categorization'/, 'MixHash, &';
    throws-like { MixHash.new.categorize-list: %ì, 1, 2, 3  },
        X::Invalid::ComputedValue,
        message => /'multi-level categorization'/, 'MixHash, %';
    throws-like { MixHash.new.categorize-list: @ì, 1, 2, 3  },
        X::Invalid::ComputedValue,
        message => /'multi-level categorization'/, 'MixHash, @';
}

subtest ‘on Baggy, exceptions, can't classify on immutable Bag/Mix’ => {
    plan 6;
    throws-like { Bag.new.categorize-list: {;}, ^2 }, X::Immutable, 'Bag, &';
    throws-like { Bag.new.categorize-list: %(), ^2 }, X::Immutable, 'Bag, %';
    throws-like { Bag.new.categorize-list: @(), ^2 }, X::Immutable, 'Bag, @';
    throws-like { Mix.new.categorize-list: {;}, ^2 }, X::Immutable, 'Mix, &';
    throws-like { Mix.new.categorize-list: %(), ^2 }, X::Immutable, 'Mix, %';
    throws-like { Mix.new.categorize-list: @(), ^2 }, X::Immutable, 'Mix, @';
}

# vim: expandtab shiftwidth=4
