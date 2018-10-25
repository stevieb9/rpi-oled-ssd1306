#!perl -T
use 5.006;
use strict;
use warnings;
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'RPi::OLED::SSD1306' ) || print "Bail out!\n";
}

diag( "Testing RPi::OLED::SSD1306 $RPi::OLED::SSD1306::VERSION, Perl $], $^X" );
