//
//  main.c
//
//  Created by Dylan Parker on September 11 2019
//

#import <IOKit/IOKitLib.h>
#import <IOKit/IOCFPlugIn.h>
#import <stdio.h>
#import <string.h>

#import "razerkbd_driver.h"

IOUSBDeviceInterface** getRazerUSBDeviceInterface() {
	CFMutableDictionaryRef matchingDict;
	matchingDict = IOServiceMatching(kIOUSBDeviceClassName);
	if (matchingDict == NULL) {
		return NULL;
	}
	
	io_iterator_t iter;
	kern_return_t kReturn =
		IOServiceGetMatchingServices(kIOMasterPortDefault, matchingDict, &iter);
	if (kReturn != kIOReturnSuccess) {
		return NULL;
	}

	io_service_t usbDevice;
	while ((usbDevice = IOIteratorNext(iter))) {
		IOCFPlugInInterface **plugInInterface = NULL;
		SInt32 score;
		
		kReturn = IOCreatePlugInInterfaceForService(
			usbDevice, kIOUSBDeviceUserClientTypeID, kIOCFPlugInInterfaceID, &plugInInterface, &score);
		
		IOObjectRelease(usbDevice);  // Not needed after plugin created
		if ((kReturn != kIOReturnSuccess) || plugInInterface == NULL) {
			printf("Unable to create plugin (0x%08x)\n", kReturn);
			continue;
		}
		
		IOUSBDeviceInterface **dev = NULL;
		HRESULT hResult = (*plugInInterface)->QueryInterface(
			plugInInterface, CFUUIDGetUUIDBytes(kIOUSBDeviceInterfaceID), (LPVOID *)&dev);
		
		(*plugInInterface)->Release(plugInInterface);  // Not needed after device interface created
		if (hResult || !dev) {
			printf("Couldn’t create a device interface (0x%08x)\n", (int) hResult);
			continue;
		}
		
		if (!is_blade_laptop(dev)) {
			(*dev)->Release(dev);	// Not recognized as a Razer Blade Laptop device
			continue;
		}
		
		kReturn = (*dev)->USBDeviceOpen(dev);
		if (kReturn != kIOReturnSuccess)  {
			printf("Unable to open USB device: %08x\n", kReturn);
			(*dev)->Release(dev);
			continue;
		}
		
		// Success. We found the Razer USB device.
		// Caller is responsible for closing USB and release device.
		IOObjectRelease(iter);
		return dev;
	}
	
	IOObjectRelease(iter);
	return NULL;
}

const char* usageText = \
	"Usage: razer-led <command>\n\n" \
	"Where <command> is one of:\n\n" \
/*	"   none       - keyboard LED effects are disabled\n" \
	"   pulsate    - pulse brightness on and off\n" \  */
	"   red        - solid red\n" \
	"   green      - solid green\n" \
	"   blue       - solid blue\n" \
	"   white      - solid white\n" \
	"   breathe1   - throb keyboard with random colours\n" \
	"   breathe2   - throb keyboard with green colour\n" \
	"   breathe3   - throb keyboard with blue+red colours\n" \
	"   starlight  - keys randomly light up and fade\n" \
	"   reactive   - keys react to your typing\n" \
	"   spectrum   - cycle through a spectrum of colours\n" \
	"   wave_left  - wave of colours moving left\n" \
	"   wave_right - wave of colours moving right\n" \
	"   logo_on    - Turn the Razer logo on\n" \
	"   logo_off   - Turn the Razer logo off\n\n";

int main(int argc, const char * argv[]) {
	if (argc != 2) {
		printf("%s", usageText);
		return -1;
	}

	IOUSBDeviceInterface **dev = getRazerUSBDeviceInterface();
	if (dev == NULL) {
		return -1;  // Assume appropriate error message displayed during the lookup
	}
	
	const char* cmd = argv[1];
	if (strcmp("none", cmd) == 0) {
		razer_attr_write_mode_none(dev, "1", 1);	
	} else if (strcmp("pulsate", cmd) == 0) {
		razer_attr_write_mode_pulsate(dev, NULL, 1);
	} else if (strcmp("red", cmd) == 0) {
		char buf[] = {/*R*/0xFF, 0x0, 0x0};
		razer_attr_write_mode_static(dev, buf, 3);
	} else if (strcmp("green", cmd) == 0) {
		char buf[] = {0x0, /*G*/0xFF, 0x0};
		razer_attr_write_mode_static(dev, buf, 3);
	} else if (strcmp("blue", cmd) == 0) {
		char buf[] = {0x0, 0x0, /*B*/0xFF};
		razer_attr_write_mode_static(dev, buf, 3);
	} else if (strcmp("white", cmd) == 0) {
		char buf[] = {0xFF, 0xFF, 0xFF};
		razer_attr_write_mode_static(dev, buf, 3);
	} else if (strcmp("breathe1", cmd) == 0) {
		razer_attr_write_mode_breath(dev, "1", 1);
	} else if (strcmp("breathe2", cmd) == 0) {
		char buf[] = {0x0, 0xff, 0x0};
		razer_attr_write_mode_breath(dev, buf, 3);
	} else if (strcmp("breathe3", cmd) == 0) {
		char buf[] = {0x0, 0x0, 0xff, 0xff, 0x0, 0x0};
		razer_attr_write_mode_breath(dev, buf, 6);
	} else if (strcmp("starlight", cmd) == 0) {
		razer_attr_write_mode_starlight(dev, NULL, 1);
	} else if (strcmp("reactive", cmd) == 0) {
		char buf[] = {0x02, /*R*/ 0x00, /*G*/ 0xff, /*B*/ 0x00};
	    razer_attr_write_mode_reactive(dev, buf, 4);
	} else if (strcmp("spectrum", cmd) == 0) {
		razer_attr_write_mode_spectrum(dev, "1", 1);
	} else if (strcmp("wave_left", cmd) == 0) {
		razer_attr_write_mode_wave(dev, "1", 1);
	} else if (strcmp("wave_right", cmd) == 0) {
		razer_attr_write_mode_wave(dev, "2", 1);
	} else if (strcmp("logo_on", cmd) == 0) {
		razer_attr_write_set_logo(dev, "1", 1);
	} else if (strcmp("logo_off", cmd) == 0) {
		razer_attr_write_set_logo(dev, "0", 1);
	} else {
		printf("Unrecognized command -- %s\n", cmd);
		printf("%s", usageText);
	}

	(*dev)->USBDeviceClose(dev);
	(*dev)->Release(dev);
	
	return 0;
}
