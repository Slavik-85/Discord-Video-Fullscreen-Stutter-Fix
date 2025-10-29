# Discord Video Fullscreen Stutter Fix
## Elaborate please!
For some users (me, as an example), when you try to watch a video in fullscreen, the video becomes a laggy, buggy and stuttering mess, and it's annoying cuz you don't see shit in a small window, but in full screen it just DOESN'T play cuz of the lag! So I made this patch to fix that!

## What it does to fix it?
It automatically disables Full Screen Optimization (FSO) for the latest Discord version installed on your computer. Whenever Discord updates, restarts, or Windows reboots, FSO is instantly disabled—ensuring smoother performance and no graphical quirks.

## How it works
The .bat file is a one-click installer/launcher that registers itself in the Registry Run key for automatic launch at every login (for the fastest possible startup).

On each run, the batch file downloads the latest discordfsooff.ps1 PowerShell script from this repository, executes it hidden, and then deletes the .ps1 file (keeping your system clean).

A temporary VBScript file is created and used to launch the PowerShell script truly hidden and make no windows ever stay open in the desktop. The VBScript file (runfso.vbs) is saved in %temp%, used, and then automatically deleted as part of the process.

The PowerShell script runs in the background, monitoring your Discord installation. When Discord updates or the executable changes, it automatically disables Full Screen Optimization for the newest version.

The process needs no user attention after initial setup—it’s fully invisible.

## How it's NOT a virus
- The whole project is open source, and all actions occur locally on your machine.
- It does NOT transmit data, modify unrelated settings, or perform any destructive operations.
- You can inspect both scripts here before running them.
- Removal is easy and fully reversible (see below).

## Installation Guide
1. Download discordfsoautopatch.bat (the batch file) from this repository.
2. Run with admin or just double click the .bat file to run it (because there is an automatic admin rights check).
3. On first launch, Windows may show a Security Warning ("Unknown Publisher") — you must click Launch/Run to continue.
4. A Command Prompt window will briefly open.
5. A second security prompt will appear, just confirm Launch/Run again.
6. Administrator Permission Required: If you didn't launch as admin, you will be asked for admin rights to make registry changes for autostart. Click Yes/Run if prompted.
7. After permissions, a command window will briefly appear (2-3 seconds), then close.
8. The patch is now fully installed!
- The patch will automatically work in the background and on future system startups, with no windows or prompts from now on.

## Uninstallation Guide
1. Press Win + R, type regedit and press Enter.
2. Go to: *HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run*
3. Find and delete the entry: *DiscordFSOAutopatch*
4. Delete the discordfsoautopatch.bat file (location is shown in the registry value).
5. Reboot the pc to stop any active background scripts.

## Troubleshooting
- Some antivirus programs may warn about unknown scripts—check the code for peace of mind.
- If Discord is still getting FSO enabled after major updates, manually run the batch file again to refresh the registry autorun path.
- For maximum effect, run the installer batch with admin privileges the first time.

## License
MIT License — Free for personal and educational use.
