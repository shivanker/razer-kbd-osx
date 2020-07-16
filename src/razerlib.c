// Created by Shivanker Goel on July 16, 2020

#import <IOKit/IOCFPlugIn.h>
#import <IOKit/IOKitLib.h>
#import <stdio.h>
#import <stdlib.h>
#import <string.h>

#import "razerdevice.h"
#import "razerkbd_driver.h"

uintptr_t rzr_init() { return (uintptr_t)getRazerUSBDeviceInterface(); }

void rzr_close(uintptr_t ptr) {
  closeRazerUSBDeviceInterface((IOUSBDeviceInterface **)ptr);
}

void rzr_info(uintptr_t ptr) {
  IOUSBDeviceInterface **dev = (IOUSBDeviceInterface **)ptr;

  char buf[256] = {0};
  razer_attr_read_device_type(dev, buf);
  printf("%s", buf);
  razer_attr_read_get_firmware_version(dev, buf);
  printf("Firmware %s", buf);
}

void rzr_set_spectrum(uintptr_t ptr) {
  IOUSBDeviceInterface **dev = (IOUSBDeviceInterface **)ptr;

  razer_attr_write_mode_spectrum(dev, "1", 1);
}

void rzr_set_wave(uintptr_t ptr, bool left) {
  IOUSBDeviceInterface **dev = (IOUSBDeviceInterface **)ptr;

  char *buf = left ? "1" : "2";
  razer_attr_write_mode_wave(dev, buf, 0);
}

void rzr_enable_custom(uintptr_t ptr) {
  IOUSBDeviceInterface **dev = (IOUSBDeviceInterface **)ptr;
  razer_attr_write_mode_custom(dev, NULL, 0);
}

void rzr_set_key_custom(uintptr_t ptr, unsigned char row, unsigned char col,
                        unsigned char r, unsigned char g, unsigned char b) {
  IOUSBDeviceInterface **dev = (IOUSBDeviceInterface **)ptr;

  char buf[6] = {row, col, col, r, g, b};
  razer_attr_write_matrix_custom_frame(dev, buf, 6);
}
