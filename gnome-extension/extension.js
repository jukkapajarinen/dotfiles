import Gio from 'gi://Gio';
import GLib from 'gi://GLib';

// Inside GNOME Shell this is an extension. Outside it (`gjs -m extension.js`,
// used by INSTALL.sh) the Shell modules are missing and the settings are applied
// straight away to the current session.
const {Extension} = await import('resource:///org/gnome/shell/extensions/extension.js')
    .catch(() => ({Extension: null}));
const Main = Extension ? await import('resource:///org/gnome/shell/ui/main.js') : null;
const St = Extension ? (await import('gi://St')).default : null;
const Shell = Extension ? (await import('gi://Shell')).default : null;
const Meta = Extension ? (await import('gi://Meta')).default : null;
const Background = Extension ? await import('resource:///org/gnome/shell/ui/background.js') : null;
const PopupMenu = Extension ? await import('resource:///org/gnome/shell/ui/popupMenu.js') : null;
const AppDisplay = Extension ? await import('resource:///org/gnome/shell/ui/appDisplay.js') : null;
const Clutter = Extension ? (await import('gi://Clutter')).default : null;
const Cogl = Extension ? (await import('gi://Cogl')).default : null;
const Workspace = Extension ? await import('resource:///org/gnome/shell/ui/workspace.js') : null;
const ModalDialog = Extension ? await import('resource:///org/gnome/shell/ui/modalDialog.js') : null;
const EndSessionDialog = Extension ? await import('resource:///org/gnome/shell/ui/endSessionDialog.js') : null;
const Graphene = Extension ? (await import('gi://Graphene')).default : null;

const UUID = 'dotfiles@jukkapajarinen.com';
const TIMEZONE = 'Europe/Helsinki';
const WEEKDAYS = ['Ma', 'Ti', 'Ke', 'To', 'Pe', 'La', 'Su'];

// Blur strength and dimming, blur-my-shell's defaults.
const BLUR_RADIUS = 30;
const BLUR_BRIGHTNESS = 0.6;

// Black shade over the blur behind an open app folder (0-255), and while an
// icon is dragged out of it. The shell's own shades are 204 and 85.
const FOLDER_SHADE = 77;
const FOLDER_SHADE_LIGHTER = 25;

// Visible corner radius of workspace previews in the overview and app grid.
const WORKSPACE_PREVIEW_RADIUS = 12;

// Confetti thrown by double-clicking empty top bar space.
const CONFETTI_PIECES = 300;
const CONFETTI_DURATION = 3000; // ms
const CONFETTI_COLORS = [
    [249, 65, 68], [248, 150, 30], [249, 199, 79], [144, 190, 109],
    [67, 170, 139], [53, 132, 228], [155, 89, 182], [255, 255, 255],
];

// Launchers shown right of the workspace buttons, as desktop file IDs, in the
// order they appear in the top bar.
const APPS = [
    'google-chrome.desktop',
    'org.gnome.Nautilus.desktop',
    'org.gnome.Calculator.desktop',
    'org.gnome.clocks.desktop',
    'kitty.desktop',
    'com.microsoft.VSCode.desktop',
    'org.keepassxc.KeePassXC.desktop',
];

const CUSTOM_KEYBINDING_SCHEMA = 'org.gnome.settings-daemon.plugins.media-keys.custom-keybinding';
const CUSTOM_KEYBINDINGS_PATH = '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings';

// ##############################################################################
// Gnome configurations: [schema, key, value in GVariant text format]
// ##############################################################################
const SETTINGS = [
    ['org.gnome.desktop.input-sources', 'sources', "[('xkb', 'fi+mac')]"],
    ['org.gnome.shell', 'disabled-extensions', "['ubuntu-dock@ubuntu.com']"],
    ['org.gnome.shell', 'app-picker-layout', '[]'],
    ['org.gnome.shell', 'favorite-apps', '[]'],
    ['org.gnome.desktop.interface', 'color-scheme', "'prefer-dark'"],
    ['org.gnome.desktop.interface', 'gtk-theme', "'Yaru-blue-dark'"],
    ['org.gnome.desktop.interface', 'icon-theme', "'Yaru-blue-dark'"],
    ['org.gnome.desktop.interface', 'accent-color', "'blue'"],
    ['org.gnome.desktop.peripherals.mouse', 'natural-scroll', 'true'],
    ['org.gnome.desktop.calendar', 'show-weekdate', 'true'],
    ['org.gnome.desktop.default-applications.terminal', 'exec', "'kitty'"],
    ['org.gnome.desktop.interface', 'clock-show-seconds', 'true'],
    ['org.gnome.desktop.interface', 'clock-show-weekday', 'true'],
    ['org.gnome.desktop.interface', 'clock-format', "'24h'"],
    ['org.gnome.desktop.datetime', 'automatic-timezone', 'false'],
    ['org.gnome.desktop.wm.preferences', 'num-workspaces', '4'],
    ['org.gnome.mutter', 'dynamic-workspaces', 'false'],
    ['org.gnome.mutter', 'workspaces-only-on-primary', 'false'],
    ['org.gnome.shell.extensions.ding', 'start-corner', "'top-left'"],
    ['org.gnome.shell.extensions.ding', 'show-home', 'true'],
    ['org.gnome.shell.extensions.ding', 'show-trash', 'true'],
    ['org.gnome.shell.extensions.ding', 'show-volumes', 'false'],
    ['org.gnome.shell.extensions.ding', 'show-network-volumes', 'false'],
    ['org.gtk.gtk4.Settings.FileChooser', 'show-hidden', 'true'],

    // ##########################################################################
    // Gnome keybindings
    // ##########################################################################
    ['org.gnome.settings-daemon.plugins.media-keys', 'custom-keybindings', `['${CUSTOM_KEYBINDINGS_PATH}/custom0/']`],
    ['org.gnome.settings-daemon.plugins.media-keys', 'screensaver', "['<Super>l']"],
    [`${CUSTOM_KEYBINDING_SCHEMA}:${CUSTOM_KEYBINDINGS_PATH}/custom0/`, 'binding', "'<Super>Return'"],
    [`${CUSTOM_KEYBINDING_SCHEMA}:${CUSTOM_KEYBINDINGS_PATH}/custom0/`, 'command', "'/usr/bin/kitty'"],
    [`${CUSTOM_KEYBINDING_SCHEMA}:${CUSTOM_KEYBINDINGS_PATH}/custom0/`, 'name', "'Kitty terminal'"],
    ['org.gnome.desktop.wm.keybindings', 'move-to-workspace-1', "['<Shift><Control><Super>1']"],
    ['org.gnome.desktop.wm.keybindings', 'move-to-workspace-2', "['<Shift><Control><Super>2']"],
    ['org.gnome.desktop.wm.keybindings', 'move-to-workspace-3', "['<Shift><Control><Super>3']"],
    ['org.gnome.desktop.wm.keybindings', 'move-to-workspace-4', "['<Shift><Control><Super>4']"],
    ['org.gnome.desktop.wm.keybindings', 'switch-applications', "['<Super>Tab']"],
    ['org.gnome.desktop.wm.keybindings', 'switch-applications-backward', "['<Shift><Super>Tab']"],
    ['org.gnome.desktop.wm.keybindings', 'switch-to-workspace-1', "['<Control><Super>1']"],
    ['org.gnome.desktop.wm.keybindings', 'switch-to-workspace-2', "['<Control><Super>2']"],
    ['org.gnome.desktop.wm.keybindings', 'switch-to-workspace-3', "['<Control><Super>3']"],
    ['org.gnome.desktop.wm.keybindings', 'switch-to-workspace-4', "['<Control><Super>4']"],
];

function applySettings(dir) {
    const source = Gio.SettingsSchemaSource.get_default();

    for (const [schemaSpec, key, text] of [...SETTINGS, ...wallpaperSettings(dir)]) {
        const [schemaId, path] = schemaSpec.split(':');
        const schema = source.lookup(schemaId, true);
        if (!schema?.has_key(key)) {
            console.warn(`${UUID}: skipping missing ${schemaId} ${key}`);
            continue;
        }

        try {
            const settings = new Gio.Settings(path ? {settings_schema: schema, path} : {settings_schema: schema});
            const type = schema.get_key(key).get_value_type();
            const value = GLib.Variant.parse(type, text, null, null);
            if (!settings.get_value(key).equal(value))
                settings.set_value(key, value);
        } catch (e) {
            console.error(`${UUID}: failed to set ${schemaSpec} ${key}: ${e.message}`);
        }
    }

    Gio.Settings.sync();
    setTimezone(TIMEZONE);
}

function setTimezone(timezone) {
    // The timezone is system-wide, so it lives in systemd-timedated rather than
    // gsettings. Ubuntu's polkit rules let sudo users change it without a prompt.
    try {
        const timedate = Gio.DBusProxy.new_for_bus_sync(Gio.BusType.SYSTEM, Gio.DBusProxyFlags.NONE, null,
            'org.freedesktop.timedate1', '/org/freedesktop/timedate1', 'org.freedesktop.timedate1', null);
        if (timedate.get_cached_property('Timezone')?.unpack() === timezone)
            return;

        timedate.call_sync('SetTimezone', new GLib.Variant('(sb)', [timezone, false]), Gio.DBusCallFlags.NONE, -1, null);
    } catch (e) {
        console.error(`${UUID}: failed to set timezone ${timezone}: ${e.message}`);
    }
}

// Top bar clock, e.g. "Ke 30.09.2026 - 16.06:41". GNOME has no setting for a
// custom format, so overwrite the label each time the shell's clock ticks. Our
// handler is connected after the shell's text binding, so it runs last.
function formatClock() {
    const now = GLib.DateTime.new_now_local();
    return `${WEEKDAYS[now.get_day_of_week() - 1]} ${now.format('%d.%m.%Y – %H.%M:%S')}`;
}

// i3-style workspace buttons in place of the Activities dots. Clicking a number
// switches to that workspace; clicking the current one opens the overview, and
// clicking the top-left corner opens the app grid.
function createWorkspaceButtons() {
    const manager = global.workspace_manager;
    const box = new St.BoxLayout({style_class: 'dotfiles-workspaces', reactive: true});

    const rebuild = () => {
        box.destroy_all_children();
        for (let i = 0; i < manager.n_workspaces; i++) {
            const button = new St.Button({label: `${i + 1}`, style_class: 'dotfiles-workspace'});
            button.connect('clicked', () => {
                if (i === manager.get_active_workspace_index())
                    Main.overview.toggle();
                else
                    manager.get_workspace_by_index(i).activate(global.get_current_time());
            });
            box.add_child(button);
        }
        update();
    };
    const update = () => box.get_children().forEach((button, i) => {
        button.checked = i === manager.get_active_workspace_index();
    });

    manager.connectObject(
        'notify::n-workspaces', rebuild,
        'active-workspace-changed', update,
        box);
    box.connect('scroll-event', (_actor, event) => Main.wm.handleWorkspaceScroll(event));

    // Clicking the top-left corner, left of the first number, toggles the app
    // grid. Target phase, so clicks on the numbers themselves don't count.
    const corner = new Clutter.ClickGesture();
    corner.connect('recognize', () => {
        const [boxX] = box.get_transformed_position();
        if (corner.get_coords_abs().x < boxX + (box.get_first_child()?.x ?? 0))
            toggleAppGrid();
    });
    box.add_action_full('dotfiles-corner', Clutter.EventPhase.TARGET, corner);

    rebuild();
    return box;
}

// An app grid button and app launchers next to the workspace buttons.
// Clicking a launcher always opens a new window, even when the app is running.
function createAppButtons() {
    const appSystem = Shell.AppSystem.get_default();
    const box = new St.BoxLayout({style_class: 'dotfiles-apps'});

    const apps = APPS.map(id => {
        const app = appSystem.lookup_app(id);
        if (!app)
            console.warn(`${UUID}: skipping missing app ${id}`);
        return app;
    }).filter(app => app);

    const allApps = new St.Button({
        style_class: 'dotfiles-app',
        child: new St.Icon({icon_name: 'view-app-grid-symbolic', style_class: 'dotfiles-app-icon'}),
        accessible_name: 'Show Apps',
    });
    allApps.connect('clicked', toggleAppGrid);
    box.add_child(allApps);

    for (const app of apps) {
        const button = new St.Button({
            style_class: 'dotfiles-app',
            child: new St.Icon({gicon: app.get_icon(), style_class: 'dotfiles-app-icon'}),
            accessible_name: app.get_name(),
        });
        button.connect('clicked', () => app.open_new_window(-1));
        box.add_child(button);
    }

    return box;
}

// Open the app grid, or close it if it is already showing. The overview
// ignores showApps() while it is open, so flip the (hidden) dash button then.
function toggleAppGrid() {
    const showAppsButton = Main.overview.dash.showAppsButton;
    if (!Main.overview.visible)
        Main.overview.showApps();
    else if (showAppsButton.checked)
        Main.overview.hide();
    else
        showAppsButton.checked = true;
}

// Simplified blur-my-shell: the top bar blurs whatever is behind it, and the
// overview and app grid sit on a blurred copy of the wallpaper.
function blurEffect(mode) {
    return new Shell.BlurEffect({mode, radius: BLUR_RADIUS, brightness: BLUR_BRIGHTNESS});
}

function createOverviewBackground() {
    const group = new Meta.BackgroundGroup();
    let managers = [];

    const rebuild = () => {
        managers.forEach(manager => manager.destroy());
        managers = Main.layoutManager.monitors.map((_monitor, monitorIndex) => {
            const manager = new Background.BackgroundManager({container: group, monitorIndex});
            // The manager swaps in a new actor when the wallpaper changes. Its
            // wallpaper starts dimmed to 0.5; undo that so only the blur dims.
            const blur = () => {
                manager.backgroundActor.content.brightness = 1;
                manager.backgroundActor.add_effect(blurEffect(Shell.BlurMode.ACTOR));
            };
            manager.connect('changed', blur);
            blur();
            return manager;
        });
    };

    Main.layoutManager.connectObject('monitors-changed', rebuild, group);
    group.connect('destroy', () => managers.forEach(manager => manager.destroy()));
    rebuild();
    return group;
}

// Top bar menus, notification popups, app folders and the log out / restart /
// shut down dialog blur what is behind them too. The shell creates these on demand, so blur each one as it first
// appears. Returns a function that undoes it.
function blurPopups() {
    const blurred = new Set();
    const blur = actor => {
        if (blurred.has(actor))
            return;
        actor.add_effect_with_name('dotfiles-blur', blurEffect(Shell.BlurMode.BACKGROUND));
        actor.add_style_class_name('dotfiles-blurred');
        blurred.add(actor);
        actor.connect('destroy', () => blurred.delete(actor));
    };

    const menuOpen = PopupMenu.PopupMenu.prototype.open;
    PopupMenu.PopupMenu.prototype.open = function (...args) {
        if (this.sourceActor && Main.panel.contains(this.sourceActor))
            blur(this.box);
        return menuOpen.apply(this, args);
    };

    // An open folder covers the screen and shades everything behind it almost
    // black. Blur that whole area instead, and re-aim the shell's shade fades
    // at a light tint right after it starts them.
    const folder = AppDisplay.AppFolderDialog.prototype;
    const {popup, _zoomAndFadeIn: zoomAndFadeIn, _setLighterBackground: setLighterBackground} = folder;
    const shade = (dialog, alpha) => dialog.ease({
        background_color: new Cogl.Color({red: 0, green: 0, blue: 0, alpha}),
        duration: 200, // the shell's FOLDER_DIALOG_ANIMATION_TIME
        mode: Clutter.AnimationMode.EASE_OUT_QUAD,
    });
    folder.popup = function (...args) {
        blur(this);
        return popup.apply(this, args);
    };
    folder._zoomAndFadeIn = function (...args) {
        zoomAndFadeIn.apply(this, args);
        shade(this, FOLDER_SHADE);
    };
    folder._setLighterBackground = function (lighter) {
        setLighterBackground.call(this, lighter);
        shade(this, lighter ? FOLDER_SHADE_LIGHTER : FOLDER_SHADE);
    };

    // The end session dialog is a full-screen layer holding the shade and the
    // dialog box, so blurring the layer blurs the whole screen behind it.
    const modalOpen = ModalDialog.ModalDialog.prototype.open;
    ModalDialog.ModalDialog.prototype.open = function (...args) {
        if (this instanceof EndSessionDialog.EndSessionDialog)
            blur(this);
        return modalOpen.apply(this, args);
    };

    const bannerBin = Main.messageTray._bannerBin;
    const bannerId = bannerBin.connect('child-added', (_bin, banner) => blur(banner));

    return () => {
        PopupMenu.PopupMenu.prototype.open = menuOpen;
        Object.assign(folder, {popup, _zoomAndFadeIn: zoomAndFadeIn, _setLighterBackground: setLighterBackground});
        ModalDialog.ModalDialog.prototype.open = modalOpen;
        bannerBin.disconnect(bannerId);
        blurred.forEach(actor => {
            actor.remove_effect_by_name('dotfiles-blur');
            actor.remove_style_class_name('dotfiles-blurred');
        });
    };
}

// Workspace previews round their wallpaper at 30px in full-screen size, so
// the small previews above the app grid end up almost square. Scale the radius
// up by how much the preview is shrunk, keeping the shell's value as the
// minimum. Returns a function that undoes it.
function roundWorkspacePreviews() {
    const background = Workspace.WorkspaceBackground.prototype;
    const updateBorderRadius = background._updateBorderRadius;

    background._updateBorderRadius = function () {
        updateBorderRadius.call(this);
        // The preview size changes without a state change (window picker to
        // app grid), so also follow the size.
        this._dotfilesSizeId ??= this.connect('notify::width', () => this._updateBorderRadius());

        const content = this._bgManager.backgroundActor.content;
        const monitor = Main.layoutManager.monitors[this._monitorIndex];
        const {scaleFactor} = St.ThemeContext.get_for_stage(global.stage);
        const shrink = this.width > 0 ? monitor.width / this.width : 1;
        const radius = WORKSPACE_PREVIEW_RADIUS * scaleFactor * shrink * this._stateAdjustment.value;
        content.rounded_clip_radius = Math.max(content.rounded_clip_radius, radius);
    };

    return () => {
        background._updateBorderRadius = updateBorderRadius;
    };
}

// Double-clicking empty top bar space throws confetti over all screens for
// CONFETTI_DURATION, with celebration.wav. Returns a function that undoes it.
function setupConfetti(dir) {
    const sound = dir.get_child('celebration.wav');
    let confetti = null;
    let timeoutId = 0;

    const stop = () => {
        if (timeoutId)
            GLib.source_remove(timeoutId);
        timeoutId = 0;
        if (confetti) {
            confetti.destroy();
            confetti = null;
            global.compositor.enable_unredirect();
        }
    };

    const celebrate = () => {
        if (confetti)
            return;

        const {width, height} = global.stage;
        const {scaleFactor} = St.ThemeContext.get_for_stage(global.stage);
        confetti = new Clutter.Actor({width, height});
        // A fullscreen window skips the compositor and goes straight to the
        // screen, which leaves no shell drawing on top of it. Composite while
        // the confetti falls so it shows over e.g. fullscreen Chrome.
        global.compositor.disable_unredirect();
        Main.layoutManager.uiGroup.add_child(confetti);
        global.display.get_sound_player().play_from_file(sound, 'Confetti', null);

        for (let i = 0; i < CONFETTI_PIECES; i++) {
            const [red, green, blue] = CONFETTI_COLORS[Math.floor(Math.random() * CONFETTI_COLORS.length)];
            const size = (6 + Math.random() * 6) * scaleFactor;
            const x = Math.random() * width;
            const piece = new Clutter.Actor({
                x,
                y: -size * 2 - Math.random() * height * 0.2,
                width: size,
                height: size * 2.5,
                pivot_point: new Graphene.Point({x: 0.5, y: 0.5}),
                rotation_angle_z: Math.random() * 360,
                background_color: new Cogl.Color({red, green, blue, alpha: 255}),
            });
            confetti.add_child(piece);

            // Staggered start, and every piece is off screen when time is up.
            // Move with translation rather than x/y: changing the position
            // re-lays out the whole confetti layer every frame, translation
            // only changes how the piece is drawn.
            const delay = Math.random() * CONFETTI_DURATION / 3;
            piece.ease({
                translation_x: (Math.random() - 0.5) * 300 * scaleFactor,
                translation_y: height + size * 2 - piece.y,
                rotation_angle_z: piece.rotation_angle_z + (Math.random() - 0.5) * 1080,
                delay,
                duration: CONFETTI_DURATION - delay,
                mode: Clutter.AnimationMode.EASE_IN_QUAD,
            });
            // Tumble by squashing the height back and forth, a flat stand-in
            // for spinning around the x axis: 3D rotation gives the pieces
            // depth, and they break into white blocks over fullscreen windows.
            piece.ease({
                scale_y: -1,
                delay,
                duration: 150 + Math.random() * 350,
                mode: Clutter.AnimationMode.EASE_IN_OUT_SINE,
                repeatCount: -1,
                autoReverse: true,
            });
        }

        timeoutId = GLib.timeout_add(GLib.PRIORITY_DEFAULT, CONFETTI_DURATION, () => {
            timeoutId = 0;
            stop();
            return GLib.SOURCE_REMOVE;
        });
    };

    // Count clicks ourselves, watching presses before the top bar's own
    // gesture sees them: with a maximized window that gesture starts a window
    // move, which takes over input and swallows a gesture's second click.
    let last = null;
    const pressId = Main.panel.connect('captured-event::button', (_panel, event) => {
        if (event.type() !== Clutter.EventType.BUTTON_PRESS || event.get_button() !== Clutter.BUTTON_PRIMARY)
            return Clutter.EVENT_PROPAGATE;

        // Only presses on the top bar itself, not on its buttons.
        const [x, y] = event.get_coords();
        if (global.stage.get_actor_at_pos(Clutter.PickMode.REACTIVE, x, y) !== Main.panel) {
            last = null;
            return Clutter.EVENT_PROPAGATE;
        }

        const settings = Clutter.Settings.get_default();
        const time = event.get_time();
        if (last && time - last.time <= settings.double_click_time &&
            Math.hypot(x - last.x, y - last.y) <= settings.double_click_distance) {
            last = null;
            celebrate();
        } else {
            last = {time, x, y};
        }
        return Clutter.EVENT_PROPAGATE;
    });

    return () => {
        Main.panel.disconnect(pressId);
        stop();
    };
}

function wallpaperSettings(dir) {
    // The extension directory is symlinked from the dotfiles repo, so resolve
    // the link to find images/ in the repo root.
    const info = dir.query_info('standard::is-symlink,standard::symlink-target', Gio.FileQueryInfoFlags.NOFOLLOW_SYMLINKS, null);
    const extensionDir = info.get_is_symlink() ? dir.get_parent().resolve_relative_path(info.get_symlink_target()) : dir;
    const wallpaper = extensionDir.resolve_relative_path('../images/Wallpaper.png');
    if (!wallpaper.query_exists(null)) {
        console.warn(`${UUID}: wallpaper not found at ${wallpaper.get_path()}`);
        return [];
    }

    const uri = new GLib.Variant('s', wallpaper.get_uri()).print(false);
    return [
        ['org.gnome.desktop.background', 'picture-uri', uri],
        ['org.gnome.desktop.background', 'picture-uri-dark', uri],
        ['org.gnome.desktop.background', 'picture-options', "'zoom'"],
    ];
}

if (!Extension)
    applySettings(Gio.File.new_for_uri(import.meta.url).get_parent());

export default class DotfilesExtension extends (Extension ?? Object) {
    enable() {
        applySettings(this.dir);

        const dateMenu = Main.panel.statusArea.dateMenu;
        const update = () => dateMenu._clockDisplay.set_text(formatClock());
        // Tied to the label, so the handler goes away if the shell destroys the
        // label first (on logout).
        dateMenu._clock.connectObject('notify::clock', update, dateMenu._clockDisplay);
        update();

        Main.panel.statusArea.activities.container.hide();
        this._workspaces = createWorkspaceButtons();
        Main.panel._leftBox.insert_child_at_index(this._workspaces, 0);
        this._apps = createAppButtons();
        Main.panel._leftBox.insert_child_at_index(this._apps, 1);

        // Hide the favourites dash in the overview. It stays "visible" because a
        // hidden dash never styles its icons and then errors when resizing them;
        // height 0 frees its space, and the clip and opacity hide what is left.
        Main.overview.dash.set({height: 0, opacity: 0, clip_to_allocation: true});

        this._panelBlur = blurEffect(Shell.BlurMode.BACKGROUND);
        Main.panel.add_effect(this._panelBlur);
        this._overviewBackground = createOverviewBackground();
        Main.layoutManager.overviewGroup.insert_child_at_index(this._overviewBackground, 0);
        this._unblurPopups = blurPopups();
        this._unroundWorkspacePreviews = roundWorkspacePreviews();
        this._removeConfetti = setupConfetti(this.dir);
    }

    disable() {
        // Settings are persistent preferences; only the panel changes need undoing.
        const dateMenu = Main.panel.statusArea.dateMenu;
        dateMenu._clock.disconnectObject(dateMenu._clockDisplay);
        dateMenu._clockDisplay.set_text(dateMenu._clock.clock);

        this._workspaces.destroy();
        this._workspaces = null;
        this._apps.destroy();
        this._apps = null;
        Main.panel.statusArea.activities.container.show();
        Main.overview.dash.set({height: -1, opacity: 255, clip_to_allocation: false});

        Main.panel.remove_effect(this._panelBlur);
        this._panelBlur = null;
        this._overviewBackground.destroy();
        this._overviewBackground = null;
        this._unblurPopups();
        this._unblurPopups = null;
        this._unroundWorkspacePreviews();
        this._unroundWorkspacePreviews = null;
        this._removeConfetti();
        this._removeConfetti = null;
    }
}
