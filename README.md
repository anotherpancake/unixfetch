# unixfetch
[![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)](https://www.linux.org/)
[![Unix](https://img.shields.io/badge/Unix-000000?style=for-the-badge&logo=unix&logoColor=white)](https://www.unix.org/)
## Introducing Unixfetch:
Unixfetch is a fetch cli tool for Unix-based and Unix-like Systems that display a summary about your hardware and software written in pure Bash for lazy users
## Showcase:
<img width="1920" height="1080" alt="20260127_19h56m08s_grim" src="https://github.com/user-attachments/assets/ab76e298-46bd-42a3-820d-ba6047dd23bd" />

## Installation:
### Requirements:
   - Git
   - Flatpak (Optional)
   - Brew (Optional) 
### Automated Installation:
 ```bash
 $ git clone https://codeberg.org//YetAnotherSky/unixfetch
 ```
```bash
 $ cd unixfetch
 $ chmod +x setup.sh
 $ ./setup.sh
```
### Manual Installation:
```bash
$ git clone https://codeberg.org//YetAnotherSky/unixfetch
```
```bash
$ cd unixfetch
$ chmod +x unixfetch.sh
$ mv unixfetch.sh ~/.local/bin/unixfetch
```
#### Before you run the last command check if you have ~/.local/bin, if not:

```bash
$ mkdir -p ~/.local/bin # if you don't have .local already
$ mkdir .local/bin # if .local already exists 
```
#### For fish, you may need to add this in your config to allow "unixfetch" to be executed as a binary:
```bash
$ echo "set -gx PATH $HOME/.local/bin $PATH" >> ~/.config/fish/config.fish
```
## (New Update!) Summary:

- Tested on 4 Distros:

  [![Fedora](https://img.shields.io/badge/Fedora-294172?style=for-the-badge&logo=fedora&logoColor=white)](https://getfedora.org)
  [![Arch](https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)](https://archlinux.org)
  [![Gentoo](https://img.shields.io/badge/Gentoo-54487A?style=for-the-badge&logo=gentoo&logoColor=white)](https://www.gentoo.org/)
  [![Debian](https://img.shields.io/badge/Debian-A81D33?style=for-the-badge&logo=debian&logoColor=white)](https://www.debian.org/)
  
- Support Brought for BSD!
- Fixed Issues Related to:
  - Local IP not being accurate
  - Package Managers Error Handling
- Support for MacOS and NixOS is very soon!

## Future Improvements && Goals:

- Bringing Support to MacOS and NixOS.
- Adding flags && arguments.
- Adding it to Fedora Copr, AUR, and Brew if possible.
- Improving the CLI for unixfetch the most possible.
