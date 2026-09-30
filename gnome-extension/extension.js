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

const UUID = 'dotfiles@jukkapajarinen.com';
const TIMEZONE = 'Europe/Helsinki';
const WEEKDAYS = ['Ma', 'Ti', 'Ke', 'To', 'Pe', 'La', 'Su'];

// Launchers shown right of the workspace buttons, as desktop file IDs.
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

    // ##########################################################################
    // Gnome keybindings
    // ##########################################################################
    ['org.gnome.settings-daemon.plugins.media-keys', 'custom-keybindings', `['${CUSTOM_KEYBINDINGS_PATH}/custom0/']`],
    ['org.gnome.settings-daemon.plugins.media-keys', 'screensaver', "['<Super>l']"],
    [`${CUSTOM_KEYBINDING_SCHEMA}:${CUSTOM_KEYBINDINGS_PATH}/custom0/`, 'binding', "'<Super>Return'"],
    [`${CUSTOM_KEYBINDING_SCHEMA}:${CUSTOM_KEYBINDINGS_PATH}/custom0/`, 'command', "'/usr/bin/kitty'"],
    [`${CUSTOM_KEYBINDING_SCHEMA}:${CUSTOM_KEYBINDINGS_PATH}/custom0/`, 'name', "'Kitty terminal'"],
    ['org.gnome.desktop.wm.keybindings', 'move-to-workspace-1', "['<Shift><Super>1']"],
    ['org.gnome.desktop.wm.keybindings', 'move-to-workspace-2', "['<Shift><Super>2']"],
    ['org.gnome.desktop.wm.keybindings', 'move-to-workspace-3', "['<Shift><Super>3']"],
    ['org.gnome.desktop.wm.keybindings', 'move-to-workspace-4', "['<Shift><Super>4']"],
    ['org.gnome.desktop.wm.keybindings', 'switch-applications', "['<Super>Tab']"],
    ['org.gnome.desktop.wm.keybindings', 'switch-applications-backward', "['<Shift><Super>Tab']"],
    ['org.gnome.desktop.wm.keybindings', 'switch-to-workspace-1', "['<Super>1']"],
    ['org.gnome.desktop.wm.keybindings', 'switch-to-workspace-2', "['<Super>2']"],
    ['org.gnome.desktop.wm.keybindings', 'switch-to-workspace-3', "['<Super>3']"],
    ['org.gnome.desktop.wm.keybindings', 'switch-to-workspace-4', "['<Super>4']"],
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
    return `${WEEKDAYS[now.get_day_of_week() - 1]} ${now.format('%d.%m.%Y - %H.%M:%S')}`;
}

// i3-style workspace buttons in place of the Activities dots. Clicking a number
// switches to that workspace; clicking the current one opens the overview.
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
    rebuild();
    return box;
}

// App launchers next to the workspace buttons. Clicking always opens a new
// window, even when the app is already running.
function createAppButtons() {
    const appSystem = Shell.AppSystem.get_default();
    const box = new St.BoxLayout({style_class: 'dotfiles-apps'});

    for (const id of APPS) {
        const app = appSystem.lookup_app(id);
        if (!app) {
            console.warn(`${UUID}: skipping missing app ${id}`);
            continue;
        }

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
        this._clockId = dateMenu._clock.connect('notify::clock', update);
        update();

        Main.panel.statusArea.activities.container.hide();
        this._workspaces = createWorkspaceButtons();
        Main.panel._leftBox.insert_child_at_index(this._workspaces, 0);
        this._apps = createAppButtons();
        Main.panel._leftBox.insert_child_at_index(this._apps, 1);
    }

    disable() {
        // Settings are persistent preferences; only the panel changes need undoing.
        const dateMenu = Main.panel.statusArea.dateMenu;
        dateMenu._clock.disconnect(this._clockId);
        dateMenu._clockDisplay.set_text(dateMenu._clock.clock);
        this._clockId = null;

        this._workspaces.destroy();
        this._workspaces = null;
        this._apps.destroy();
        this._apps = null;
        Main.panel.statusArea.activities.container.show();
    }
}
