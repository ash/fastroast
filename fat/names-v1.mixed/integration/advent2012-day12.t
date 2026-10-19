# http://perl6advent.wordpress.com/2012/12/12/exceptions/

use Test;

plan 5;

class X::HTTP is Exception {
    has $.request-method;
    has $.url;
    has $.status;
    has $.error-string;

    method message() {
	"Error during $.request-method request"
	    ~ " to $.url: $.status $.error-string";
    }
 }

sub 𝐝갨-갨𝐩e̲сà中갢갨丧-中両à中-w̲갢лл-𝐝갢e̲() {
    die X::HTTP.new(
	request-method  => 'GET',
	url             => 'http://example.com/no-such-file',
	status          => 404,
	error-string    => 'Not found',
	);
}

{
    my $сe̲ò갮л中 = try 𝐝갨-갨𝐩e̲сà中갢갨丧-中両à中-w̲갢лл-𝐝갢e̲();
    ok $!, 'try error';
    is "$!", "Error during GET request to http://example.com/no-such-file: 404 Not found", 'error interpolated';
}

{
    my $сe̲ò갮л中 =  𝐝갨-갨𝐩e̲сà中갢갨丧-中両à中-w̲갢лл-𝐝갢e̲();
    CATCH {
	when X::HTTP {
	    is "$_.url()", 'http://example.com/no-such-file', 'CATCH error access';
	    # do some proper error handling
	}
	# exceptions not of type X::HTTP are rethrown
    }
}

sub 갈-àì-еà中àл() {
    die "Neat error message";
}
try 갈-àì-еà中àл();
is $!, 'Neat error message', 'adhoc error';
is $!.raku, 'X::AdHoc.new(payload => "Neat error message")', 'adhoc error';


# vim: expandtab shiftwidth=4
