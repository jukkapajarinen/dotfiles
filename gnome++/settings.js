// Gnome++ settings. Log out and in after changing them.

export default {
    // Numbered workspace buttons with tiling mode, in place of Activities.
    workspaceButtons: true,
    // A button at the right of the top bar that minimizes the workspace's windows.
    showDesktopButton: true,
    // A stopwatch at the far right of the top bar.
    stopwatch: true,
    // Blur the wallpaper behind the top bar, overview, menus and dialogs.
    blur: true,
    // Double-clicking empty top bar space throws confetti.
    confetti: true,
    // Clicking the top-left corner of the screen toggles the app grid.
    edgeClick: true,
    // Tooltips under the top bar's buttons.
    tooltips: true,

    // Set on login; empty leaves the system's timezone alone.
    timezone: 'Europe/Helsinki',
    // Names for the clock, from Monday; empty leaves the weekday out.
    weekdays: ['Ma', 'Ti', 'Ke', 'To', 'Pe', 'La', 'Su'],
    // What follows the weekday, in strftime format.
    clockFormat: '%d.%m.%Y – %H.%M:%S',

    // Pixels around and between tiled windows.
    tileGap: 8,

    // Blur strength and dimming, blur-my-shell's defaults.
    blurRadius: 30,
    blurBrightness: 0.6,
    // Black shade over the blur behind an open app folder (0-255), and while an
    // icon is dragged out of it. The shell's own shades are 204 and 85.
    folderShade: 77,
    folderShadeLighter: 25,

    confettiPieces: 300,
    confettiDuration: 3000, // ms
    confettiColors: [
        [249, 65, 68], [248, 150, 30], [249, 199, 79], [144, 190, 109],
        [67, 170, 139], [53, 132, 228], [155, 89, 182], [255, 255, 255],
    ],

    // How long a button is hovered before its tooltip shows.
    tooltipDelay: 400, // ms

    stopwatchCount: 1,
    // How often a running stopwatch's time is saved to its file.
    stopwatchSaveInterval: 5, // seconds
    // How long ended measurements stay in a stopwatch's history.
    stopwatchHistoryAge: 24 * 60 * 60, // seconds
    // How long the "copied" note shows after copying a time.
    copiedNoteTime: 2000, // ms
};
