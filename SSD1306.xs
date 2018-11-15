/*
 * SSD1306.xs file for RPi::OLED::SSD1306 Perl distribution
 *
 * Copyright (c) 2018 by Steve Bertrand
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the same terms as Perl itself, either Perl version 5.18.2 or, at your option,
 * any later version of Perl 5 you may have available.
 *
 */

#include <stdlib.h>
#include <stdint.h>

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
//#include "ppport.h"
//#include "INLINE.h"

#include "ssd1306_i2c.h"
#include <wiringPi.h>
#include <wiringPiI2C.h>

// #include <sys/mman.h>

// TESTING FOR GLOBAL VARS TO REPLACE CONSTS

int *buffer, xWIDTH, yHEIGHT;

void setup (int x, int y){

    xWIDTH = x;
    yHEIGHT = y;

    buffer = malloc(sizeof(int) * (xWIDTH * yHEIGHT));

    for (int i = 0; i < x*y; i++) {
        buffer[i] = i;
    }
}

void test (){
    printf("w: %d, h: %d\n", xWIDTH, yHEIGHT);

    for (int i=0; i<xWIDTH*yHEIGHT; i++){
        printf("%d\n", buffer[i]);
    }

    // reset the buffer

    memset(buffer, 0, xWIDTH * yHEIGHT * sizeof(int));

    // reprint it

    for (int i=0; i<xWIDTH*yHEIGHT; i++){
        printf("%d: %d\n", buffer[i], i);
    }
}

void done (){
    free(buffer);
}

MODULE = RPi::OLED::SSD1306  PACKAGE = RPi::OLED::SSD1306

PROTOTYPES: DISABLE

# testing

void
setup(x, y)
    int x
    int y

void
test()

void
done()

# end testing

void
ssd1306_begin(switchvcc, i2caddr)
    unsigned int switchvcc
    unsigned int i2caddr

void
ssd1306_command(c)
    unsigned int c

void
ssd1306_clearDisplay()

void
ssd1306_invertDisplay(i)
    unsigned int i

void
ssd1306_display()

void
ssd1306_startscrollright(start, stop)
    unsigned int start
    unsigned int stop

void
ssd1306_startscrollleft(start, stop)
    unsigned int start
    unsigned int stop

void
ssd1306_startscrolldiagright(start, stop)
    unsigned int start
    unsigned int stop

void
ssd1306_startscrolldiagleft(start, stop)
    unsigned int start
    unsigned int stop

void
ssd1306_stopscroll()

void
ssd1306_dim(dim)
    unsigned int dim

void
ssd1306_drawPixel(x, y, color)
    int x
    int y
    unsigned int color

void
ssd1306_drawFastVLine(x, y, h, color)
    int x
    int y
    int h
    unsigned int color

void
ssd1306_drawFastHLine(x, y, w, color)
    int x
    int y
    int w
    unsigned int color

void
ssd1306_fillRect(x, y, w, h, fillcolor)
    int x
    int y
    int w
    int h
    int fillcolor

void
ssd1306_setTextSize(s)
    int s

void
ssd1306_drawString(str)
    char *str

void
ssd1306_drawChar(x, y, c, color, size)
    int x
    int y
    unsigned char c
    int color
    int size


