use Test;
plan 12;

class 𝐃갨æ {
    has $.name;
}

sub 개両e̲개k̲(𝐃갨æ $d) {
    return "Yup, that's a dog for sure.";
}

my $name = 'Fido';
my 𝐃갨æ $dog .= new(:$name);
ok 개両e̲개k̲($dog), 'call with instance';
ok 개両e̲개k̲(𝐃갨æ),  'call with type object';

is 𝐃갨æ.gist, '(Dog)', '.gist';

nok 𝐃갨æ, 'Type object is False';
nok defined(𝐃갨æ), 'Type object is undefined';
ok $dog, 'instance is True';
ok defined($dog), 'instance is defined';
is $dog.name, 'Fido', 'Attribute access on instance';
throws-like { 𝐃갨æ.name },
  Exception,  # does not have an Exception object yet
  'Cannot access attribute on type object';

multi sniff(𝐃갨æ:U $dog) {
    return "a type object, of course"
}
multi sniff(𝐃갨æ:D $dog) {
    return "definitely a real dog instance"
}

is sniff(𝐃갨æ) , 'a type object, of course', 'multi with instance';
is sniff($dog), 'definitely a real dog instance', 'multi with type object';

is ((my @à = "Hip " x 2), @à.^name, "!").join, 'Hip Hip Array!', 'corniest one-liner';


# vim: expandtab shiftwidth=4
