# Dotfiles
This repository contains my dotfiles of which I still use (and improve) most.

## Installation
I recommend using [GNU Stow](https://www.gnu.org/software/stow/). With this application installed, using e.g. my bash dotfiles is as easy as executing `stow -t ~ bash` in the repository root. Nota bene: both `fonts` and `system` must be executed with the target directory parameter set to `/`. For more information, please refer to the [GNU Stow manual](https://www.gnu.org/software/stow/manual/stow.html).

## Included programs' dotfiles
* bash
  * General terminal configuration
  * Global variables
  * Functions
    * Set CPU frequency by changing its governor
    * Read and set [`vga_switcheroo`](http://gentoo-en.vfose.ru/wiki/Vga_switcheroo) status
    * Set Radeon power mode
    * Fix permissions on music directory
    * Un-/mount LUKS encrypted device
    * Backup music
    * Downsize album art
    * Convert lossless M4A, FLAC or MP3 to OGG
    * Compute and add [ReplayGain](http://wiki.hydrogenaud.io/index.php?title=Replaygain) to audio files
    * Screencast and save it as GIF
    * Un/-mount an MTP device
    * Optimise an Arch system
    * Remove temporary LaTeX files
    * Delete Steam libraries after an update
    * En-/decrypt a file using [GNU Privacy Guard](https://gnupg.org/)
    * Connect to Internet via Ethernet or WiFi and disable the other
  * Load [PulseAudio](https://wiki.freedesktop.org/www/Software/PulseAudio/) and other programs when starting [X](http://www.x.org/wiki/)
  * Extend ANSI keyboard layout
    * Disable caps key
    * Ensure altgr is loaded
    * Add `—`, `…`, `§`
    * Add `\``, `'`, `^`
    * Invert scrolling direction
  * [Solarised colours](http://ethanschoonover.com/solarized) and other configuration for [xterm](http://invisible-island.net/xterm/)
* [Dunst](https://github.com/knopwob/dunst)
  * Position dunst notifications on top of the i3bar
  * [Solarised colours](http://ethanschoonover.com/solarized)
* [Mozilla Firefox](https://www.mozilla.org/en-US/firefox/products/)
  * UI customisations (no close button, rectangular tabs…)
  * CSS rules to replace some fonts for clearer rendering
  * Disable middle mouse button loads tab if clipboard contains a URL
* [Fluxbox](http://www.fluxbox.org/)
  * Configuration files
  * My themes (Seon, Enos…)
* Fonts
  * Font smoothing
  * Fixes for Gimp
  * Also install Firefox dotfiles if you are using this configuration
* [Git](https://www.git-scm.com/)
  * My local configuration, not of any interest for you
* [GTK](http://www.gtk.org/)
  * Configuration for GTK 2 and 3
* [i3](http://i3wm.org/)
  * i3 configuration (uses, but does not include, [i3-exit](https://github.com/ashinkarov/i3-extras/blob/master/i3-exit) and [i3lock-wrapper](https://github.com/ashinkarov/i3-extras/blob/master/i3lock-wrapper))
  * Somewhat [solarised theme](http://ethanschoonover.com/solarized)
  * Conky JSON configuration for use with MPD
  * Scripts
    * En-/disable display timeout
    * Load ANSI altgr intl keyboard layout and custom keys (if any)
    * En-/disable monitors and set wallpaper
* [mpd](http://www.musicpd.org/)
  * Configuration for `mpd` user with Pulse and HTTP stream output
* [ncmpcpp](http://ncmpcpp.rybczak.net/)
  * Custom key bindings (more `vim` like)
  * Custom UI colours
* system
  * Enable Magic SysRQ key
  * Set journal max size
  * Don't sleep laptop if lid is closed
  * Load keyboard configuration automatically, when pok3r is connected
  * Enable British, US and German locales
  * Set console layout to something ANSI like with the possibility for Umlauts etc.
* [top](http://linux.about.com/od/commands/l/blcmdl1_top.htm)
  * 4 panels
* [vim](http://www.vim.org/)
  * Enable undo support
  * Load [solarised theme](http://ethanschoonover.com/solarized)
  * Load [vim-latexsuite](http://www.vim.org/scripts/script.php?script_id=475) and disable some of its features
  * Loads of smaller tweaks and customisation
* [vimperator](http://www.vimperator.org/vimperator/)
  * Somewhat [solarised theme](http://ethanschoonover.com/solarized) (modified)
  * Optimise GUI for space
  * Improve usability by introducing some regular browser keyboard shortcuts
  * Make [Zotero](https://www.zotero.org/) accessible through a keyboard
* [zathura](https://pwmt.org/projects/zathura/)
  * [Solarise](http://ethanschoonover.com/solarized) colours