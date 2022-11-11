#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define STR_SIZE 100
#define DESKTOP_ID_SIZE 11
#define DESKTOP_NAME_SIZE 11
#define NUM_DESKTOPS 8

// globals
char desktop_id[DESKTOP_ID_SIZE];
char desktop_id_array[NUM_DESKTOPS][DESKTOP_ID_SIZE];
char desktop_name_array[NUM_DESKTOPS][DESKTOP_NAME_SIZE];

void get_desktop_id(char str[STR_SIZE]) {
  int desktop_idx = 0, idx = 0, field = 1;
  char curr = str[idx];
  while (curr != '\n') {
    if (curr == ' ') {
      field++;
    }
    if (field == 3 && curr != ' ') {
      desktop_id[desktop_idx] = curr;
      desktop_idx++;
    }
    idx++;
    curr = str[idx];
  }
}

void get_desktop_id_array() {
  FILE *DesktopIds;
  char id[DESKTOP_ID_SIZE];
  DesktopIds = popen("bspc query --desktops", "r");
  int i = 0;
  while (fgets(id, DESKTOP_ID_SIZE, DesktopIds)) {
    // returns content and newline separately
    if (i % 2 == 0) {
      strcpy(desktop_id_array[i / 2], id);
    }
    i++;
  }
  fclose(DesktopIds);
}

void get_desktop_name_array() {
  FILE *DesktopNames;
  char id[DESKTOP_NAME_SIZE];
  DesktopNames = popen("bspc query --desktops --names", "r");
  int i = 0;
  while (fgets(id, DESKTOP_NAME_SIZE, DesktopNames)) {
    id[strlen(id) - 1] = '\0';
    strcpy(desktop_name_array[i], id);
    i++;
  }
  fclose(DesktopNames);
}

void send_message() {
  for (int i = 0; i < NUM_DESKTOPS; i++) {
    if (strcmp(desktop_id, desktop_id_array[i]) == 0) {
      char message[100] = "dunstify -r 3 ";
      strcat(message, desktop_name_array[i]);
      popen(message, "r");
    }
  }
}

int main() {
  get_desktop_id_array();
  get_desktop_name_array();
  while (1) {
    char str[STR_SIZE];
    fgets(str, STR_SIZE, stdin);

    get_desktop_id(str);
    send_message();
  }
  return 0;
}
