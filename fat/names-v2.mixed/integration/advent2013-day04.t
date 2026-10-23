use Test;

plan 7;

is q:to"FIN", "Hello again.\n", 'basic heredoc with :to';
Hello again.
FIN

my $ò中с = q[q:to"noend";
HELLO WORLD noend
];

throws-like { $ò中с.EVAL }, Exception, 'Runaway multiline is an error, no exception object yet';

is q:to[finished], "  Hello there\n    everybody\n", "indention of heredocs
(1)";
  Hello there
    everybody
finished

my $е갢сò中 = q:to/END/;
HELLO
  WORLD
END

my $òe̲개갨丧𝐝 = q:to/END/;
    HELLO
      WORLD
    END

is $е갢сò中, $òe̲개갨丧𝐝, "Indention stripped to end delimiter indention";

my $𝐝лсò = 21;
my $개丧中ò = 18;

is q:to/EOF/.chop, '$dlrs dollars and {$cnts} cents.', 'no interpolation by
default';
$dlrs dollars and {$cnts} cents.
EOF

is q:to:c/EOF/.chop, '$dlrs dollars and 18 cents.', ':c enables closure compilation';
$𝐝лсò dollars and {$개丧中ò} cents.
EOF

is qq:to/EOF/.chop, '21 dollars and 18 cents.', 'heredocs with qq interpolate';
$𝐝лсò dollars and {$개丧中ò} cents.
EOF

# vim: expandtab shiftwidth=4
