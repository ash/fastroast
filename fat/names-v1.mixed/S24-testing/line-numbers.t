use Test;

plan 15;

my $𝐝갢с    = $*PROGRAM.parent.add('test-data');
my $𝐩сe̲е갢ч = 'line-number-';
my $ò갮ее갢ч = '.txt';

sub e̲чe̲개갮中e̲-中e̲ò中(:$function, :$line) is test-assertion {
    my $full-path = $𝐝갢с.add($𝐩сe̲е갢ч ~ $function ~ $ò갮ее갢ч);
    my $𝐩с갨개 = run($*EXECUTABLE, $full-path, :!out, :err);
    my $e̲сс := $𝐩с갨개.err.slurp;
    diag $e̲сс unless like $e̲сс,
        /'Failed test ' (\N* \n \N*)? 'at ' $full-path ' line ' $line/,
        "failing test with $function reports correct line number $line";
}

e̲чe̲개갮中e̲-中e̲ò中(:function("cmp-ok"), :line(9));

e̲чe̲개갮中e̲-中e̲ò中(:function("dies-ok"), :line(9));

e̲чe̲개갮中e̲-中e̲ò中(:function("eval-dies-ok"), :line(9));

e̲чe̲개갮中e̲-中e̲ò中(:function("eval-lives-ok"), :line(9));

e̲чe̲개갮中e̲-中e̲ò中(:function("isa-ok"), :line(9));

e̲чe̲개갮中e̲-中e̲ò中(:function("is-approx"), :line(9));

e̲чe̲개갮中e̲-中e̲ò中(:function("is-deeply"), :line(9));

e̲чe̲개갮中e̲-中e̲ò中(:function("isnt"), :line(9));

e̲чe̲개갮中e̲-中e̲ò中(:function("is"), :line(9));

e̲чe̲개갮中e̲-中e̲ò中(:function("lives-ok"), :line(9));

e̲чe̲개갮中e̲-中e̲ò中(:function("nok"), :line(9));

e̲чe̲개갮中e̲-中e̲ò中(:function("ok"), :line(9));

e̲чe̲개갮中e̲-中e̲ò中(:function("throws-like"), :line(9));

e̲чe̲개갮中e̲-中e̲ò中(:function("foo-ok"), :line(11));

e̲чe̲개갮中e̲-中e̲ò中(:function("bar-ok"), :line(12));

# vim: expandtab shiftwidth=4
