# Optimises pacman and its caches and also deletes unused locales.
function optimiseSystem {
  echo 'Seemingly unused packages:'
  pacman -Qdt
  echo 'Only continue if you want these packages removed!'
  sudo pacman -Rsn $(pacman -Qdtq)
  sudo pkgcacheclean
  sudo pacman-optimize
  sudo sync
  sudo localepurge
  sudo journalctl --vacuum-time=7d
}

function deleteLaTeXTempFiles {
  rm *.{snm,nav,aux,bbl,bcf,blg,log,out,toc,run.xml,glo,glsdefs,glg,gls,ist} > /dev/null 2>&1
}

# @see https://wiki.archlinux.org/index.php/steam#Steam_runtime_issues
function deleteSteamLibraries {
  rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/i386/usr/lib/i386-linux-gnu/libstdc++.so.6
  rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/i386/lib/i386-linux-gnu/libgcc_s.so.1
  rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/amd64/lib/x86_64-linux-gnu/libgcc_s.so.1
  rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/amd64/usr/lib/x86_64-linux-gnu/libstdc++.so.6
  rm ~/.local/share/Steam/ubuntu12_32/steam-runtime/i386/usr/lib/i386-linux-gnu/libxcb.so.1
}

function removeEXIFMetadata {
   exiftool -HistorySoftwareAgent= \
     -Software= \
     -HistoryWhen= \
     -HistoryAction= -HistoryChanged= \
     -HistoryInstanceID= \
     -DocumentID= \
     -InstanceID= \
     -OriginalDocumentID= \
     -XMPToolkit= \
     -Rating= \
     -PrimaryPlatform= \
     -UserComment= \
     -PhotoshopThumbnail= \
     -PhotoshopFormat= \
     -PhotoshopQuality=  \
     $1
}
