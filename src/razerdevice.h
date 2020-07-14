//
//  razerdevice.h
//  Razer device query functions
//
//

#include <IOKit/IOCFPlugIn.h>
#include <IOKit/usb/IOUSBLib.h>
#include <stdio.h>

#include "razerkbd_driver.h"

#define TYPE_KEYBOARD 0
#define TYPE_BLADE 1
#define TYPE_MOUSE 2

#ifndef USB_VENDOR_ID_RAZER
#define USB_VENDOR_ID_RAZER 0x1532
#endif

bool is_keyboard(IOUSBDeviceInterface **dev);
bool is_razer_device(IOUSBDeviceInterface **dev);
IOUSBDeviceInterface **getRazerUSBDeviceInterface();
void closeRazerUSBDeviceInterface(IOUSBDeviceInterface **dev);
