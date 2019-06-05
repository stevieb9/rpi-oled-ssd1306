use strict;
use warnings;

use Test::More;

use RPi::OLED::SSD1306;

my $s = RPi::OLED::SSD1306->new;

$s->text_size(3);
$s->string("hello", 1);

$s->invert_display(1);
$s->clear;

$s->string("hello", 1);

$s->invert_display(0);
$s->clear;

done_testing();

