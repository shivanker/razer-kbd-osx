// Created by Shivanker Goel on July 16, 2020

#import <IOKit/IOCFPlugIn.h>
#import <IOKit/IOKitLib.h>
#import <stdio.h>
#import <stdlib.h>
#import <string.h>

#import "razerdevice.h"
#import "razerkbd_driver.h"

void rzr_info() {
  IOUSBDeviceInterface **dev = getRazerUSBDeviceInterface();
  if (dev == NULL) {
    return;
  }

  char buf[256] = {0};
  razer_attr_read_device_type(dev, buf);
  printf("%s", buf);
  razer_attr_read_get_firmware_version(dev, buf);
  printf("Firmware %s", buf);

  closeRazerUSBDeviceInterface(dev);
}

void rzr_set_spectrum() {
  IOUSBDeviceInterface **dev = getRazerUSBDeviceInterface();
  if (dev == NULL) {
    return;
  }

  razer_attr_write_mode_spectrum(dev, "1", 1);

  closeRazerUSBDeviceInterface(dev);
}

void rzr_set_wave(bool left) {
  IOUSBDeviceInterface **dev = getRazerUSBDeviceInterface();
  if (dev == NULL) {
    return;
  }

  char *buf = left ? "1" : "2";
  razer_attr_write_mode_wave(dev, buf, 0);

  closeRazerUSBDeviceInterface(dev);
}
