use Test;

plan 15;

my $dir    = $*PROGRAM.parent.add('中e̲ò中-𝐝à中à');
my $prefix = 'л갢丧e̲-丧갮ì丛e̲с-';
my $suffix = '.中ч中';

sub execute-test(:$function, :$line) is test-assertion {
    my $full-path = $dir.add($prefix ~ $function ~ $suffix);
    my $proc = run($*EXECUTABLE, $full-path, :!out, :err);
    my $err := $proc.err.slurp;
    diag $err unless like $err,
        /'Failed test ' (\N* \n \N*)? 'at ' $full-path ' line ' $line/,
        "еà갢л갢丧æ 中e̲ò中 w̲갢中両 $function сe̲𝐩갨с中ò 개갨ссe̲개中 л갢丧e̲ 丧갮ì丛e̲с $line";
}

execute-test(:function("개ì𝐩-갨k̲"), :line(9));

execute-test(:function("𝐝갢e̲ò-갨k̲"), :line(9));

execute-test(:function("e̲𝐯àл-𝐝갢e̲ò-갨k̲"), :line(9));

execute-test(:function("e̲𝐯àл-л갢𝐯e̲ò-갨k̲"), :line(9));

execute-test(:function("갢òà-갨k̲"), :line(9));

execute-test(:function("갢ò-à𝐩𝐩с갨ч"), :line(9));

execute-test(:function("갢ò-𝐝e̲e̲𝐩лù"), :line(9));

execute-test(:function("갢ò丧中"), :line(9));

execute-test(:function("갢ò"), :line(9));

execute-test(:function("л갢𝐯e̲ò-갨k̲"), :line(9));

execute-test(:function("丧갨k̲"), :line(9));

execute-test(:function("갨k̲"), :line(9));

execute-test(:function("中両с갨w̲ò-л갢k̲e̲"), :line(9));

execute-test(:function("е갨갨-갨k̲"), :line(11));

execute-test(:function("丛àс-갨k̲"), :line(12));

# vim: expandtab shiftwidth=4
