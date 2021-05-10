# Snapbar

### Your last 5 screenshots in your macOS menu bar.

Snapbar's always watching for when you take screenshots. 

It helps keep your desktop nice and tidy by squirreling them away for you and making them easy to grab from the menu bar to do things with.

It has a quiet but firm opinion that most of us really only need the last few screenshots we took anyway, so it only keeps the last five around and gets rid of all the older ones.


### Get Snapbar

[Download](https://github.com/stakes/Snapbar/releases/download/1.0-alpha/Snapbar.zip) and unzip the app, then put it into your Applications folder.

### What it does

Snapbar does a few things for you: it gives you easy access from your Mac's menu bar to your last five screenshots. It keeps your desktop clean by moving those screenshots off the desktop for you. And it keeps your screenshots manageable by automatically deleting screenshots and limiting screenshot inventory to five. 

If you need to save screenshots for posterity or like keeping more than five around, Snapbar is not the utility for you.

### How it works

When you launch Snapbar it'll take up residence in your menu bar.

The first time you take a screenshot with Snapbar running, it'll ask you to allow it to access files in your Desktop folder. It needs this access to grab screenshots and move them for you.

Whenever Snapbar is running, it'll be watching for new screenshots. It intervenes behind the scenes whenever your Mac tries to put a new screenshot on the desktop. This means you can still use those little floating screenshot thumbnails that MacOS creates; but instead of them "sliding off" onto your desktop, they'll "slide off" into Snapbar.

You can then grab screenshots and use them from Snapbar's tray, as well as in the Finder in `Documents/Snapbar`.

### Find a bug?

Please [create an issue](https://github.com/stakes/Snapbar/issues) for it!
