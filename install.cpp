#include <stdio.h>
#include <string>
#include <vector>
#include <dirent.h>
#include <iostream>
#include <stdlib.h>
using namespace std;

vector<string> find_dotfiles() {

  DIR* dir = opendir(".");
  struct dirent* entry;

  vector<string> files;
  while(entry = readdir(dir)) {

    if (string(entry->d_name).compare(string(".")) == 0)
      continue;

    if (string(entry->d_name).compare(string("..")) == 0)
      continue;

    if (string(entry->d_name).compare(string(".git")) == 0)
      continue;
    
    if (string(entry->d_name).at(0) == '.')
      files.push_back(entry->d_name);

  }

  return files;
}

void create_symlink(string file) {

  string command = string("ln -s ") + "~/dotfiles/" + file + " ~/" + file;
  cout << "Executing: " << command << endl;
  system(command.c_str());
}

int main(int argc, char* argv[]) {

  // We run this installation from dotfiles dir. (NOTE)

  // 1. Scan all dotfiles in the directory. Ignore dirs.

  vector<string> dotfiles = find_dotfiles();
  
  // 2. For each dotfile, create symlink in home dir.

  for (int i=0; i<dotfiles.size(); i++) {
    cout << dotfiles.at(i) << endl;
    create_symlink(dotfiles.at(i));
  }
  
  return 0;
}
