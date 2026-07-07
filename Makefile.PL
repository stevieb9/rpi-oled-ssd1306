use strict;
use warnings;
use ExtUtils::MakeMaker;

use version;

# The canonical wiringPi minimum lives in RPi::Const (WIRINGPI_MIN_VERSION);
# fall back to the literal if RPi::Const isn't installed at configure time
my $min_wpi_ver = eval {
    require RPi::Const;
    RPi::Const::WIRINGPI_MIN_VERSION();
} || 3.18;

# RPI_DIST_RELEASE allows cutting release tarballs on non-Pi machines by
# bypassing the wiringPi presence/version checks below. Without it, a
# missing wiringPi exits before WriteMakefile so CPAN testers report NA,
# not FAIL

if (! $ENV{RPI_DIST_RELEASE}){
    if (! -f '/usr/include/wiringPi.h' && ! -f '/usr/local/include/wiringPi.h'){
        print "wiringPi is not installed and RPI_DIST_RELEASE is not set, " .
              "exiting...\n";
        exit;
    }

    if (my $path = (grep { -x "$_/gpio" } split /:/, $ENV{PATH})[0]){
        my $bin = "$path/gpio";
        my $gpio_info = `$bin -v`;

        if (my ($version) = $gpio_info =~ /version:\s+(\d+\.\d+)/){

            my $installed_ver = version->parse($version);

            if ($installed_ver < $min_wpi_ver){
                print "\nyou must have wiringPi version $min_wpi_ver" .
                    " or greater installed to continue.\n\n" .
                    "You have version $version\n";
                exit;
            }
        }
    }
    else {
        print "\ncan not determine wiringPi version and RPI_DIST_RELEASE " .
            "is not set. Ensure version $min_wpi_ver+ is installed. " .
            "Can't continue\n";
        exit;
    }
}

WriteMakefile(
    NAME             => 'RPi::OLED::SSD1306::128_64',
    AUTHOR           => q{Steve Bertrand <steveb@cpan.org>},
    VERSION_FROM     => 'lib/RPi/OLED/SSD1306/128_64.pm',
    ABSTRACT_FROM    => 'lib/RPi/OLED/SSD1306/128_64.pm',
    LICENSE          => 'artistic_2',
    LIBS              => ['-lwiringPi -lrt'],
    DEFINE            => '',
    INC              => '-I.',
    OBJECT           => '$(O_FILES)', # include the extra *.c files (bit.c)
    PL_FILES         => {},
    MIN_PERL_VERSION => '5.010',
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => '0',
    },
    BUILD_REQUIRES => {
        'Test::More' => '0',
    },
    PREREQ_PM => {
        'RPi::Const' => '1.07',
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'RPi-OLED-SSD1306-*' },
);
