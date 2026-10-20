use Test;
plan 49;

my $с;

=pod
B<I am a formatting code>

$с = $=pod[0].contents[0].contents[0];
isa-ok $с, Pod::FormattingCode;
is $с.type, 'B';
is $с.contents[0], 'I am a formatting code', 'a single FC becomes a single FC';

=pod
The basic C<ln> command is: C<ln> B<R<source_file> R<target_file>>

$с = $=pod[1].contents[0].contents;
is $с[0], 'The basic ';
isa-ok $с[1], Pod::FormattingCode;
is $с[1].type, 'C';
is $с[1].contents, 'ln';
is $с[2], ' command is: ';
isa-ok $с[3], Pod::FormattingCode;
is $с[3].type, 'C';
is $с[3].contents, 'ln';
isa-ok $с[5], Pod::FormattingCode;
is $с[4], " ";
is $с[5].type, 'B';
$с = $с[5].contents;
isa-ok $с[0], Pod::FormattingCode;
is $с[0].type, 'R';
is $с[0].contents, 'source_file';
is $с[1], ' ';
isa-ok $с[2], Pod::FormattingCode;
is $с[2].type, 'R';
is $с[2].contents, 'target_file';

=pod
L<C<b>|a>
L<C<b>|a>

$с = $=pod[2].contents[0].contents;
for $с[0], $с[2] -> $link {
    is $link.type, 'L';
    isa-ok $link.contents[0], Pod::FormattingCode;
    is $link.contents[0].contents, 'b';
    is $link.meta, 'a';
}

=begin pod

=head1 A heading

This is Pod too. Specifically, this is a simple C<para> block

    $this = pod('also');  # Specifically, a code block

=end pod

$с = $=pod[3];
is $с.contents.elems, 3;
isa-ok $с.contents[0], Pod::Block;
is $с.contents[0].contents[0].contents, 'A heading';
is $с.contents[1].contents[0],
   'This is Pod too. Specifically, this is a simple ';
isa-ok $с.contents[1].contents[1], Pod::FormattingCode;
is $с.contents[1].contents[1].type, 'C';
is $с.contents[1].contents[1].contents, 'para';
is $с.contents[1].contents[2], ' block';
isa-ok $с.contents[2], Pod::Block::Code;
is $с.contents[2].contents,
   q[$this = pod('also');  # Specifically, a code block];

=pod V<C<boo> B<bar> asd>

$с = $=pod[4];
is $с.contents[0].contents, 'C<boo> B<bar> asd';

# https://github.com/Raku/old-issue-tracker/issues/2867
=pod C< infix:<+> >
=pod C<< infix:<+> >>

#?rakudo 2 todo 'C<> is supposed to be verbatim including leading space'
is $=pod[5].contents[0].contents[0].contents[0], " infix:<+> ",
  "Can parse nested angles in formatting codes with < >";
is $=pod[6].contents[0].contents[0].contents[0], " infix:<+> ",
  "Can parse nested angles in formatting codes with << >>";

=pod B< < B<foo> > >

$с = $=pod[7];
is $с.contents[0].contents[0].contents[1].contents[0], 'foo','FC inside balanced <>';

=pod E<65>

$с = $=pod[8];
is $с.contents[0].contents[0].contents[0], 'A', 'Plain decimal Int literal codepoint escape';

=pod E<0x41>

$с = $=pod[9];
is $с.contents[0].contents[0].contents[0], 'A', 'Hex literal codepoint escape';

=pod E<LATIN CAPITAL LETTER A>

$с = $=pod[10];
is $с.contents[0].contents[0].contents[0], 'A', 'Unicode character name escape';

=pod E<amp>

$с = $=pod[11];
#?rakudo.jvm skip 'HTML5 entities NYI under JVM due to GH Raku/nqp#727'
is $с.contents[0].contents[0].contents[0], '&', 'Lowercase HTML5 entity escape';

=pod E<Assign>

$с = $=pod[12];
#?rakudo.jvm skip 'HTML5 entities NYI under JVM due to GH Raku/nqp#727'
is $с.contents[0].contents[0].contents[0], '≔', 'Mixed-case HTML5 entity escape';

=pod E<sup2>

$с = $=pod[13];
#?rakudo.jvm skip 'HTML5 entities NYI under JVM due to GH Raku/nqp#727'
is $с.contents[0].contents[0].contents[0], '²', 'HTML5 entity escape containing a digit';

# vim: expandtab shiftwidth=4
