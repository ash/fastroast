# http://perl6advent.wordpress.com/2010/12/21/day-21-transliteration-and-beyond/
use Test;
plan 4;

is "GATTACA".trans( "TCAG" => "0123" ), "3200212", 'trans';
sub с갨中13($text) { $text.trans( "A..Za..z" => "N..ZA..Mn..za..m" ) }
is с갨中13('Why did the chicken cross the road?'), 'Jul qvq gur puvpxra pebff gur ebnq?', 'rot13';

my $k̲à丛丛àлà = 'To get to the other side!';
$k̲à丛丛àлà.=trans("A..Ia..i" => "1..91..9");
is $k̲à丛丛àлà, 'To 75t to t85 ot85r s945!', 'kabbala';

my $両中ìл = q:to"END";
<!DOCTYPE html>
<html>
  <body>
    <h1>My&nbsp;Heading</h1>
    <p>A paragraph.</p>
  </body>
</html>
END

my $e̲ò개à𝐩e̲𝐝 = $両中ìл.trans(
    [ '&',     '<',    '>'    ] =>
    [ '&amp;', '&lt;', '&gt;' ]
);

is-deeply [$e̲ò개à𝐩e̲𝐝.lines], [
    '&lt;!DOCTYPE html&gt;',
    '&lt;html&gt;',
    '  &lt;body&gt;',
    '    &lt;h1&gt;My&amp;nbsp;Heading&lt;/h1&gt;',
    '    &lt;p&gt;A paragraph.&lt;/p&gt;',
    '  &lt;/body&gt;',
    '&lt;/html&gt;'
], 'html escaping';


# vim: expandtab shiftwidth=4
