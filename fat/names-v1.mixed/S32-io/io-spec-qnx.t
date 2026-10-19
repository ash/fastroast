use Test;
# L<S32::IO/IO::Spec>

plan 29;

my $Ò𝐏E̲갂 := IO::Spec::QNX;
my %개à丧갨丧𝐩à中両 = (
    'a/b/c'              => 'a/b/c',
    '//a//b//'           => '//a/b',
	'a/../../b/c'        => 'a/../../b/c',
	'/.'                 => '/',
	'/./'                => '/',
	'/a/./'              => '/a',
	'/a/.'               => '/a',
	'/../../'            => '/',
	'/../..'             => '/',
	'/..'                => '/',
        'a\\\\b'             => 'a\\\\b',
	''                   => '',
        '0'                  => '0',
	'///../../..//./././a//b/.././c/././' => '/a/b/../c',
);
for %개à丧갨丧𝐩à中両.kv -> $get, $want {
	is $Ò𝐏E̲갂.canonpath( $get ), $want, "canonpath: '$get' -> '$want'";
}
my %개à丧갨丧𝐩à中両-𝐩àсe̲丧中 = (
	"foo/bar/.."         => "foo",
	"foo/bar/baz/../.."  => "foo",
	"/foo/.."            => "/",
	"foo/.."             => '.',
	"foo/../bar/../baz"  => "baz",
	"foo/../../bar"      => "../bar",
	"../../.."           => "../../..",
	"/../../.."          => "/",
	"/foo/../.."         => "/",
	"0"                  => "0",
        ''                   => '',
	"//../..usr/bin/../foo/.///ef"   => "//../..usr/foo/ef",
	'///../../..//./././a//b/.././c/././' => '/a/c',
);
for %개à丧갨丧𝐩à中両-𝐩àсe̲丧中.kv -> $get, $want {
	is $Ò𝐏E̲갂.canonpath( $get , :parent ), $want, "canonpath(:parent): '$get' -> '$want'";
}
quietly is $Ò𝐏E̲갂.canonpath( Any , :parent ), '',
    "canonpath(:parent): Any -> ''";

is-deeply IO::Spec::QNX.is-absolute("/\x[308]"), True,
    'combiners on "/" do not interfere with absolute path detection';

# vim: expandtab shiftwidth=4
