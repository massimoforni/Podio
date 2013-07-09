#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Podio' ) || print "Bail out!\n";
}

diag( "Testing Podio $Podio::VERSION, Perl $], $^X" );
