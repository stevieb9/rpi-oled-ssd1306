use strict;
use warnings;

use Test::More;

use RPi::OLED::SSD1306::128_64;

my $s = RPi::OLED::SSD1306::128_64->new;

$s->horizontal_line(0, 32, 128);
$s->display;

$s->clear;

done_testing();

