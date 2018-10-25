use strict;
use warnings;

use RPi::OLED::SSD1306;

my $oled = RPi::OLED::SSD1306->new(0x3c);

$oled->string("blah blah", 1);
