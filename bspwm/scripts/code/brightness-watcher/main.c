#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/inotify.h>
#include <unistd.h>

#define BRIGHTNESS_LEN 12
#define EVENT_SIZE (sizeof(struct inotify_event))
#define EVENT_BUF_LEN (1024 * (EVENT_SIZE + 16))

int max_brightness;

// set max_brightness
void set_max_brightness() {
    char max_brightness_str[BRIGHTNESS_LEN];
    FILE* max_brightness_ptr;
    max_brightness_ptr =
        fopen("/sys/class/backlight/intel_backlight/max_brightness", "r");
    fgets(max_brightness_str, BRIGHTNESS_LEN, max_brightness_ptr);
    max_brightness = atoi(max_brightness_str);
}

// get current brightness
int get_brightness() {
    char brightness_str[BRIGHTNESS_LEN];
    FILE* brightness_ptr;
    brightness_ptr =
        fopen("/sys/class/backlight/intel_backlight/brightness", "r");
    fgets(brightness_str, BRIGHTNESS_LEN, brightness_ptr);
    return atoi(brightness_str);
}

int scaled_brightness() {
    return (int)(100 * get_brightness() / max_brightness);
}

int main() {}
