use strict;
use warnings;

use RPi::OLED::SSD1306 qw(:all);

my ($x, $y) = (5, 10);
RPi::OLED::SSD1306::setup($x, $y);
RPi::OLED::SSD1306::test();
RPi::OLED::SSD1306::done();
