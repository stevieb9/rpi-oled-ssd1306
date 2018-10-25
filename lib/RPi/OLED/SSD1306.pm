package RPi::OLED::SSD1306;

use strict;
use warnings;

our $VERSION = '0.01';

require XSLoader;
XSLoader::load('RPi::OLED::SSD1306', $VERSION);

require Exporter;
our @ISA = qw(Exporter);

our @EXPORT_OK;

@EXPORT_OK = qw(
    ssd1306_begin
    ssd1306_clearDisplay
    ssd1306_invertDisplay
    ssd1306_display
    ssd1306_startscrollright
    ssd1306_startscrollleft
    ssd1306_startscrolldiagleft
    ssd1306_startscrolldiagright
    ssd1306_stopscroll
    ssd1306_dim
    ssd1306_drawPixel
    ssd1306_drawFastVLine
    ssd1306_drawFastHLine
    ssd1306_fillRect
    ssd1306_setTextSize
    ssd1306_drawString
    ssd1306_drawChar
);

our %EXPORT_TAGS;

$EXPORT_TAGS{all} = [@EXPORT_OK];

use constant {
    SSD1306_SWITCHCAPVCC => 0x2,
};

sub new {
    my ($class, $i2c_addr) = @_;

    ssd1306_begin(SSD1306_SWITCHCAPVCC, $i2c_addr);
    ssd1306_display();
    select(undef, undef, undef, 0.1);
    ssd1306_clearDisplay();

    return bless {}, $class;
}
sub string {
    my ($self, $str, $display) = @_;
    ssd1306_drawString($str);
    ssd1306_display() if $display;
}
sub clear {
    my ($self) = @_;
    ssd1306_clearDisplay();
}
sub display {
    my ($self) = @_;
    ssd1306_display();
}


1;
__END__

=head1 NAME

RPi::OLED::SSD1306 - The great new RPi::OLED::SSD1306!


=cut



=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use RPi::OLED::SSD1306;

    my $foo = RPi::OLED::SSD1306->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 function1

=cut

sub function1 {
}

=head2 function2

=cut

sub function2 {
}

=head1 AUTHOR

Steve Bertrand, C<< <steveb at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-rpi-oled-ssd1306 at rt.cpan.org>, or through
the web interface at L<https://rt.cpan.org/NoAuth/ReportBug.html?Queue=RPi-OLED-SSD1306>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc RPi::OLED::SSD1306


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<https://rt.cpan.org/NoAuth/Bugs.html?Dist=RPi-OLED-SSD1306>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/RPi-OLED-SSD1306>

=item * CPAN Ratings

L<https://cpanratings.perl.org/d/RPi-OLED-SSD1306>

=item * Search CPAN

L<https://metacpan.org/release/RPi-OLED-SSD1306>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2018 Steve Bertrand.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

1; # End of RPi::OLED::SSD1306
