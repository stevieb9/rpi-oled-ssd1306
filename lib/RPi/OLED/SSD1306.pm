package RPi::OLED::SSD1306;

use strict;
use warnings;

use Carp qw(croak);

our $VERSION = '0.01';

require XSLoader;
XSLoader::load('RPi::OLED::SSD1306', $VERSION);

require Exporter;
our @ISA = qw(Exporter);

our @EXPORT_OK;

@EXPORT_OK = qw(

    ssd1306_startscrollright
    ssd1306_startscrollleft
    ssd1306_startscrolldiagleft
    ssd1306_startscrolldiagright
    ssd1306_stopscroll
    ssd1306_drawFastHLine


    ssd1306_begin
    ssd1306_clearDisplay
    ssd1306_display
    ssd1306_dim
    ssd1306_invertDisplay

    ssd1306_setTextSize
    ssd1306_drawChar
    ssd1306_drawString
    ssd1306_drawPixel
    ssd1306_fillRect
    ssd1306_drawFastVLine
);

our %EXPORT_TAGS;

$EXPORT_TAGS{all} = [@EXPORT_OK];

use constant {
    SSD1306_SWITCHCAPVCC => 0x2,
};

my $oled;

sub new {
    return $oled if defined $oled;

    my ($class, $i2c_addr) = @_;

    $i2c_addr //= 0x3C;

    ssd1306_begin(SSD1306_SWITCHCAPVCC, $i2c_addr);
#    ssd1306_display();
    select(undef, undef, undef, 0.1);
    ssd1306_clearDisplay();

    my $self = bless {}, $class;
    $oled = $self;
    return $self;
}
sub horizontal_line {
    my ($self, $x, $y, $h, $colour) = @_;

    $colour //= 1;

    ssd1306_drawFastHLine($x, $y, $h, $colour);

    return 1;
}
sub vertical_line {
    my ($self, $x, $y, $h, $colour) = @_;

    $colour //= 1;

    ssd1306_drawFastVLine($x, $y, $h, $colour);

    return 1;
}
sub char {
    my ($self, $x, $y, $char, $size, $colour) = @_;

    $colour //= 1;
    $size //= 2;

    ssd1306_drawChar($x, $y, $char, $colour, $size);

    return 1;
}
sub pixel {
    my ($self, $x, $y, $colour) = @_;

    $colour //= 1;

    if ($x < 0 || $x > 127){
        croak "X must be between 0 and 127";
    }
    if ($y < 0 || $y > 63){
        croak "Y must be betwen 0 and 63";
    }

    ssd1306_drawPixel($x, $y, $colour);

    return 1;
}
sub dim {
    my ($self, $bool) = @_;

    $bool //= 0;

    if ($bool < 0 || $bool > 1){
        croak "dim() requires either 1 or 0 sent in";
    }

    ssd1306_dim($bool);

    return 1;
}
sub invert_display {
    my ($self, $bool) = @_;

    $bool //= 0;

    if ($bool < 0 || $bool > 1){
        croak "invert_display() requires either 1 or 0 sent in";
    }

    ssd1306_invertDisplay($bool);

    return 1;
}
sub rect {
    my ($self, $x, $y, $w, $h, $colour) = @_;

    $colour //= 1;

    if ($x < 0 || $x > 127){
        croak "X must be between 0 and 127";
    }
    if ($y < 0 || $y > 63){
        croak "y must be between 0 and 63";
    }
    if ($w < 0 || $w > 128){
        croak "width must be between 0 and 128";
    }
    if ($h < 0 || $h > 64){
        croak "height must be between 0 and 64";
    }

    ssd1306_fillRect($x, $y, $w, $h, $colour);

    return 1;
}
sub string {
    my ($self, $str, $display) = @_;
    ssd1306_drawString($str);
    ssd1306_display() if $display;
    return 1;
}
sub clear {
    my ($self) = @_;
    ssd1306_clearDisplay();
    ssd1306_display();

    return 1;
}
sub display {
    my ($self) = @_;
    ssd1306_display();
    return 1;
}
sub text_size {
    my ($self, $size) = @_;

    if ($size !~ /^\d+$/){
        croak "size parameter must be an integer";
    }

    ssd1306_setTextSize($size);
    return 1;
}

1;
__END__

=head1 NAME

RPi::OLED::SSD1306 - Interface to OLED displays

=head1 AUTHOR

Steve Bertrand, C<< <steveb at cpan.org> >>

=head1 LICENSE AND COPYRIGHT

Copyright 2018 Steve Bertrand.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>
