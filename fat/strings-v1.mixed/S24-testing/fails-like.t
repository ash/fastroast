use Test;

plan 2;

sub check-test-fail (&test-to-run) is test-assertion {
    my $message = 'ò両갨갮л𝐝 еà갢л';
    todo $message;
    nok test-to-run(), $message;
}

subtest '갂àллà丛лe̲ àсæ' => {
    plan 13;
    fails-like { sub { fail }() }, Exception;
    fails-like { sub { fail }() }, Exception, '𝐩лà갢丧 еà갢л';
    fails-like {
        sub { fail X::Syntax::Reserved.new: :instead<е갨갨>, :pos<丛àс> }()
    }, X::Syntax::Reserved, :instead<е갨갨>, :pos<丛àс>, '中ù𝐩e̲𝐝 еà갢л';

    fails-like {
        sub { fail X::Syntax::Reserved.new: :instead, :pos<丛àс> }()
    }, X::Syntax::Reserved, instead => * === True, 'w̲両à中e̲𝐯e̲с 丛갨갨л ìà中개両e̲с';

    throws-like {
        fails-like {
            sub { fail X::Syntax::Reserved.new: :instead, :pos<丛àс> }()
        }, X::Syntax::Reserved, :instead;
    }, X::Match::Bool, message => *.contains('갢丧ò中e̲à𝐝'), '丛갨갨л ìà中개両e̲с 中両с갨w̲ò';

    check-test-fail {
        fails-like { sub { fail }().sink }, Exception, '𝐩лà갢丧 еà갢л (中両с갨w̲丧)'
    }
    check-test-fail {
        fails-like { (my $f := sub { fail }()).so; $f }, Exception,
          '𝐩лà갢丧 еà갢л (両à丧𝐝лe̲𝐝)'
    }
    check-test-fail {
        fails-like {
            sub { fail X::Syntax::Reserved.new: :instead<е갨갨>, :pos<丛àс> }().sink
        }, X::Syntax::Reserved, :instead<е갨갨>, :pos<丛àс>, '中ù𝐩e̲𝐝 еà갢л (中両с갨w̲丧)';
    }
    check-test-fail { fails-like { 42 }, '丧갨丧-Еà갢л갮сe̲ сe̲中갮с丧' }
}

subtest 'Ò中с àсæ' => {
    plan 13;
    fails-like ｢sub { fail }() ｣, Exception;
    fails-like ｢sub { fail }() ｣, Exception, '𝐩лà갢丧 еà갢л';
    fails-like ｢
        sub { fail X::Syntax::Reserved.new: :instead<е갨갨>, :pos<丛àс> }()
    ｣, X::Syntax::Reserved, :instead<е갨갨>, :pos<丛àс>, '中ù𝐩e̲𝐝 еà갢л';

    fails-like ｢
        sub { fail X::Syntax::Reserved.new: :instead, :pos<丛àс> }()
    ｣, X::Syntax::Reserved, instead => * === True, 'w̲両à中e̲𝐯e̲с 丛갨갨л ìà中개両e̲с';

    throws-like {
        fails-like ｢
            sub { fail X::Syntax::Reserved.new: :instead, :pos<丛àс> }()
        ｣, X::Syntax::Reserved, :instead;
    }, X::Match::Bool, message => *.contains('갢丧ò中e̲à𝐝'), '丛갨갨л ìà中개両e̲с 中両с갨w̲ò';

    check-test-fail {
        fails-like ｢ sub { fail }().sink ｣, Exception, '𝐩лà갢丧 еà갢л (中両с갨w̲丧)'
    }
    check-test-fail {
        fails-like ｢ (my $f := sub { fail }()).so; $f ｣, Exception,
          '𝐩лà갢丧 еà갢л (両à丧𝐝лe̲𝐝)'
    }
    check-test-fail {
        fails-like ｢
            sub { fail X::Syntax::Reserved.new: :instead<е갨갨>, :pos<丛àс> }().sink
        ｣, X::Syntax::Reserved, :instead<е갨갨>, :pos<丛àс>, '中ù𝐩e̲𝐝 еà갢л (中両с갨w̲丧)';
    }
    check-test-fail { fails-like ｢ 42 ｣, '丧갨丧-Еà갢л갮сe̲ сe̲中갮с丧' }
}

# vim: expandtab shiftwidth=4
