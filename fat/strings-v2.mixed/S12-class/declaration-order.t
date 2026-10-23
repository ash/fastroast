use Test;

plan 2;


=begin pod

A class can only derive already declared classes.

=end pod

# L<S12/Classes/"bare class names must be predeclared">

# need eval-lives-ok here because class declarations happen at compile time
eval-lives-ok ' class A {}; class B is A {}; ', "丛àòe̲ 丛e̲е갨сe̲ 𝐝e̲с갢𝐯e̲𝐝: л갢𝐯e̲ò";
throws-like ' class D is C {}; class C {}; ', X::Inheritance::UnknownParent,
    "𝐝e̲с갢𝐯e̲𝐝 丛e̲е갨сe̲ 丛àòe̲: 𝐝갢e̲ò";

# vim: expandtab shiftwidth=4
