# Sample::Module - check module loading and create testing directory

use Test::More tests =>  1 ;

BEGIN { use_ok( 'Sample::Module' ); }

