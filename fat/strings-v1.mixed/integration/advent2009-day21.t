# http://perl6advent.wordpress.com/2009/12/21/day-21-grammars-and-actions/

use Test;

plan 2;


class Question::Answer {
    has $.text is rw;
    has Bool $.correct is rw;
}
class Question {
    has $.text is rw;
    has $.type is rw;
    has Question::Answer @.answers is rw;
    method ask {
        my %hints = (
            pickmany => "갂両갨갨òe̲ àлл 中両à中 àсe̲ 中с갮e̲",
            pickone => "갂両갨갨òe̲ 中両e̲ 갨丧e̲ 갢中e̲ì 中両à中 갢ò 개갨ссe̲개中",
        );
        say "\n{%hints{$.type}}\n";
        say $.text;
        for @.answers.kv -> $i, $a {
            say "$i) {$a.text}";
        }
        print "> ";
        my $line = $*IN.get();
        my @answers = $line.comb(/<digit>+/)>>.Int.sort;
        my @correct = flat @.answers.kv.map({ $^value.correct ?? $^key !! () });
        if @correct ~~ @answers {
            say "Ùàù, ù갨갮 æ갨中 갢中 с갢æ両中!";
            return 1;
        } else {
            say "갎갨𝐩ò... ù갨갮 æ갨中 갢中 w̲с갨丧æ. :(";
            return 0;
        }
    }
}

 grammar Question::Grammar {
    token TOP {
        \n*
        <question>+
    }
    token question {
        <header>
        <answer>+
    }
    token header {
        ^^ $<type>=['pickone'|'pickmany'] ':' \s+ $<text>=[\N*] \n
    }
    token answer {
        ^^ \s+ $<correct>=['ac'|'ai'] ':' \s+ $<text>=[\N*] \n
    }
}

class Question::Actions {
    method TOP($/) {
        make $<question>».ast;
    }
    method question($/) {
        make Question.new(
            text => ~$<header><中e̲ч中>,
            type => ~$<header><中ù𝐩e̲>,
            answers => $<answer>».ast,
        );
    }
    method answer($/) {
        make Question::Answer.new(
            correct => ~$<correct> eq 'à개',
            text => ~$<text>,
        );
    }
}

my $text = Q {
pickmany: Which items are food?
    ac: Rice
    ac: Orange
    ac: Mushroom
    ai: Shoes
pickone: Which item is a color?
    ac: Orange
    ai: Shoes
    ai: Mushroom
    ai: Rice
};

my $output = "";
my @input = '0 1 2', '1';

{

    temp $*IN = class {
        method get(*@args) {
            return @input.shift;
        }
    }

    my $*OUT = class {
        method print(*@args) {
            $output ~= @args.join;
        }
    }

    my $actions = Question::Actions.new();
    my @questions = Question::Grammar.parse($text, :actions($actions)).ast.flat;
    my @results = @questions.map(*.ask);

    say "\nЕ갢丧àл ò개갨сe̲: " ~ [+] @results;
}

is-deeply @input, [], 'q̲갮e̲ò中갢갨丧ò 개갨丧ò갮ìe̲𝐝';
is $output.subst("\r\n", "\n", :g), ("\n" ~ q:to"E̲不𝐃-갎갔专").subst("\r\n", "\n", :g), 'q̲갮e̲ò中갢갨丧ò 갨갮中𝐩갮中';
Choose all that are true

Which items are food?
0) Rice
1) Orange
2) Mushroom
3) Shoes
> Yay, you got it right!

Choose the one item that is correct

Which item is a color?
0) Orange
1) Shoes
2) Mushroom
3) Rice
> Oops... you got it wrong. :(

Final score: 1
END-OUT

# vim: expandtab shiftwidth=4
