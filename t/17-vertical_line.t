use strict;
use warnings;

use Test::More;

use RPi::OLED::SSD1306::128_64;

my $s = RPi::OLED::SSD1306::128_64->new;

$s->vertical_line(64, 0, 64);
$s->display;

$s->clear;

done_testing();

