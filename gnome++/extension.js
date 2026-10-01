import Gio from 'gi://Gio';
import GLib from 'gi://GLib';
import GObject from 'gi://GObject';
import Cairo from 'cairo';

import config from './settings.js';

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
const PanelMenu = Extension ? await import('resource:///org/gnome/shell/ui/panelMenu.js') : null;
const DND = Extension ? await import('resource:///org/gnome/shell/ui/dnd.js') : null;
const AppDisplay = Extension ? await import('resource:///org/gnome/shell/ui/appDisplay.js') : null;
const AppFavorites = Extension ? await import('resource:///org/gnome/shell/ui/appFavorites.js') : null;
const Clutter = Extension ? (await import('gi://Clutter')).default : null;
const Cogl = Extension ? (await import('gi://Cogl')).default : null;
const ModalDialog = Extension ? await import('resource:///org/gnome/shell/ui/modalDialog.js') : null;
const EndSessionDialog = Extension ? await import('resource:///org/gnome/shell/ui/endSessionDialog.js') : null;
const OsdWindow = Extension ? await import('resource:///org/gnome/shell/ui/osdWindow.js') : null;
const SwitcherPopup = Extension ? await import('resource:///org/gnome/shell/ui/switcherPopup.js') : null;
const Graphene = Extension ? (await import('gi://Graphene')).default : null;
const WorkspaceSwitcherPopup = Extension ? await import('resource:///org/gnome/shell/ui/workspaceSwitcherPopup.js') : null;

const UUID = 'gnome++@jukkapajarinen.com';

const CUSTOM_KEYBINDING_SCHEMA = 'org.gnome.settings-daemon.plugins.media-keys.custom-keybinding';
const CUSTOM_KEYBINDINGS_PATH = '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings';

// ##############################################################################
// Gnome configurations: [schema, key, value in GVariant text format]
// ##############################################################################
const SETTINGS = [
    ['org.gnome.desktop.input-sources', 'sources', "[('xkb', 'fi+mac')]"],
    // Ubuntu's tiling assistant would clash with the extension's own tiling mode.
    ['org.gnome.shell', 'disabled-extensions', "['ubuntu-dock@ubuntu.com', 'tiling-assistant@ubuntu.com']"],
    ['org.gnome.shell', 'app-picker-layout', '[]'],
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
    // Multitasking > Active Screen Edges: no resizing windows dragged to the edges.
    ['org.gnome.mutter', 'edge-tiling', 'false'],
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
}

function setTimezone(timezone) {
    if (!timezone)
        return;

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
    return [config.weekdays[now.get_day_of_week() - 1], now.format(config.clockFormat)].filter(text => text).join(' ');
}

// i3-style workspace buttons in place of the Activities dots. Clicking a number
// switches to that workspace; clicking the current one opens the overview,
// double-clicking a number switches that workspace between tiling mode and
// default mode, as does its right-click menu. Numbers
// of other workspaces that have windows are blue. Numbers of workspaces in
// tiling mode get a dotted border, and their dots in the
// popup shown when switching workspaces with the keyboard become squares.
function createWorkspaceButtons() {
    const manager = global.workspace_manager;
    const box = new St.BoxLayout({style_class: 'gnomeplusplus-workspaces', reactive: true});
    const tiler = new Tiler(() => update());

    const popup = WorkspaceSwitcherPopup.MonitorWorkspaceSwitcherPopup.prototype;
    const redisplay = popup.redisplay;
    popup.redisplay = function (...args) {
        redisplay.apply(this, args);
        this._list.get_children().forEach((indicator, i) => {
            if (tiler.isTiling(manager.get_workspace_by_index(i)))
                indicator.add_style_class_name('gnomeplusplus-tiling');
        });
    };

    box.connect('destroy', () => {
        tiler.destroy();
        popup.redisplay = redisplay;
    });

    // A click on the current number toggles the overview right away, without
    // waiting out the double-click time; a double-click toggles it back.
    let lastClick = null;

    // Right-clicking a number opens a menu to pick its mode. Both modes are
    // always listed; the current one is dotted and greyed out. The menus join
    // the top bar's own, so with any top bar menu open, moving the pointer
    // onto a number switches to its menu, and from there on to the next.
    const createModeMenu = (button, i) => {
        const menu = createPanelMenu(button);
        const items = [true, false].map(tiling => {
            const item = menu.addAction(tiling ? 'Tiling mode' : 'Default mode', () => {
                const workspace = manager.get_workspace_by_index(i);
                if (tiler.isTiling(workspace) !== tiling)
                    tiler.toggle(workspace);
            });
            return [item, tiling];
        });
        menu.connect('open-state-changed', (_menu, open) => {
            if (!open)
                return;
            const current = tiler.isTiling(manager.get_workspace_by_index(i));
            for (const [item, tiling] of items) {
                item.setSensitive(tiling !== current);
                item.setOrnament(tiling === current ? PopupMenu.Ornament.DOT : PopupMenu.Ornament.NONE);
            }
        });
        return menu;
    };

    const rebuild = () => {
        box.destroy_all_children();
        for (let i = 0; i < manager.n_workspaces; i++) {
            const content = new St.Widget({layout_manager: new Clutter.BinLayout(), x_expand: true, y_expand: true});
            content.add_child(new St.Label({
                text: `${i + 1}`,
                x_align: Clutter.ActorAlign.CENTER,
                y_align: Clutter.ActorAlign.CENTER,
            }));
            content.add_child(createDottedBorder());
            const button = new St.Button({
                child: content,
                style_class: 'gnomeplusplus-workspace',
                accessible_name: `${i + 1}`,
                button_mask: St.ButtonMask.ONE | St.ButtonMask.THREE,
            });
            const menu = createModeMenu(button, i);
            addTooltip(button, () => {
                const mode = tiler.isTiling(manager.get_workspace_by_index(i)) ? 'tiling' : 'default';
                return `Workspace ${i + 1} – ${mode} mode`;
            }, menu);
            button.connect('clicked', (_button, clickedButton) => {
                if (clickedButton === Clutter.BUTTON_SECONDARY) {
                    menu.toggle();
                    return;
                }
                menu.close();

                const time = global.get_current_time();
                const {double_click_time: doubleClickTime} = Clutter.Settings.get_default();
                const doubleClick = lastClick?.index === i && time - lastClick.time <= doubleClickTime;
                const current = i === manager.get_active_workspace_index();
                // Only a first click on the current number toggled the overview.
                const toggledOverview = doubleClick && lastClick.toggledOverview;
                lastClick = doubleClick ? null : {index: i, time, toggledOverview: current};

                if (doubleClick) {
                    if (toggledOverview)
                        Main.overview.toggle();
                    tiler.toggle(manager.get_workspace_by_index(i));
                } else if (current) {
                    Main.overview.toggle();
                } else {
                    manager.get_workspace_by_index(i).activate(time);
                }
            });
            manager.get_workspace_by_index(i).connectObject(
                'window-added', () => update(),
                'window-removed', () => update(),
                button);
            box.add_child(button);
        }
        update();
    };
    const update = () => box.get_children().forEach((button, i) => {
        const workspace = manager.get_workspace_by_index(i);
        button.checked = i === manager.get_active_workspace_index();
        button.child.last_child.visible = tiler.isTiling(workspace);
        // Other workspaces that have windows get a blue number.
        const occupied = global.display.get_tab_list(Meta.TabList.NORMAL, workspace)
            .some(window => !window.is_on_all_workspaces());
        if (occupied && !button.checked)
            button.add_style_class_name('gnomeplusplus-occupied');
        else
            button.remove_style_class_name('gnomeplusplus-occupied');
    });

    manager.connectObject(
        'notify::n-workspaces', rebuild,
        'active-workspace-changed', update,
        box);
    box.connect('scroll-event', (_actor, event) => Main.wm.handleWorkspaceScroll(event));

    rebuild();
    return box;
}

const MOVE_GRAB_OPS = Extension
    ? [Meta.GrabOp.MOVING, Meta.GrabOp.MOVING_UNCONSTRAINED, Meta.GrabOp.KEYBOARD_MOVING]
    : [];

// A menu under a top bar button, joined to the top bar's own menus.
function createPanelMenu(button) {
    const menu = new PopupMenu.PopupMenu(button, 0.5, St.Side.TOP);
    menu.actor.add_style_class_name('panel-menu');
    menu.actor.hide();
    Main.uiGroup.add_child(menu.actor);
    Main.panel.menuManager.addMenu(menu);
    button.connect('destroy', () => menu.destroy());
    return menu;
}

// Workspaces in tiling mode, with their tiled windows in order. Kept outside
// the extension so the modes survive it being disabled and re-enabled, which
// the shell does around the lock screen.
const tiledWorkspaces = new Map();

// bspwm-style tiling mode, switched on per workspace. Its windows are tiled one
// monitor at a time: the first window in the list takes half of the screen,
// split along the longer side, and the rest are tiled into the other half the
// same way. New windows go first, into the left half. Dropping a dragged
// window onto another tile swaps the two, and the tile it would land on is
// tinted blue during the drag. A fullscreen or maximized window
// goes back into its tile when another tiled window on its screen is focused.
class Tiler {
    constructor(onChange) {
        this._onChange = onChange;
        this._workspaces = new Map(); // workspace -> {windows, rects}
        this._queued = new Set();
        this._idleId = 0;
        this._grabbing = false;

        global.display.connectObject(
            'window-created', (_display, window) => this._watchNewWindow(window),
            'window-entered-monitor', (_display, _monitor, window) => this._queue(window.get_workspace()),
            'notify::focus-window', () => this._onFocus(global.display.focus_window),
            'grab-op-begin', (_display, window, op) => this._onGrabBegin(window, op),
            'grab-op-end', (_display, window, op) => this._onGrabEnd(window, op),
            this);

        for (const [workspace, windows] of tiledWorkspaces)
            this._start(workspace, windows);
    }

    isTiling(workspace) {
        return this._workspaces.has(workspace);
    }

    // Tiling mode on or off. Switching it off leaves windows where they are.
    toggle(workspace) {
        if (this._workspaces.has(workspace)) {
            this._stop(workspace);
            tiledWorkspaces.delete(workspace);
        } else {
            // Most recently used first, so the focused window gets the big tile.
            this._start(workspace, global.display.get_tab_list(Meta.TabList.NORMAL, workspace));
        }
        this._onChange();
    }

    destroy() {
        global.display.disconnectObject(this);
        this._hideDropTint();
        if (this._idleId)
            GLib.source_remove(this._idleId);
        for (const [workspace, state] of this._workspaces) {
            tiledWorkspaces.set(workspace, state.windows);
            this._stop(workspace);
        }
    }

    _start(workspace, windows) {
        const state = {windows: [], rects: new Map()};
        this._workspaces.set(workspace, state);
        tiledWorkspaces.set(workspace, state.windows);
        windows.forEach(window => this._add(workspace, window, false));
        // Windows that came to the workspace while the extension was disabled.
        global.display.get_tab_list(Meta.TabList.NORMAL, workspace)
            .forEach(window => this._add(workspace, window, true));

        workspace.connectObject(
            'window-added', (_workspace, window) => this._add(workspace, window, true),
            'window-removed', (_workspace, window) => this._remove(workspace, window),
            this);
        this._queue(workspace);
        return state;
    }

    _stop(workspace) {
        workspace.disconnectObject(this);
        this._workspaces.get(workspace).windows.forEach(window => window.disconnectObject(this));
        this._workspaces.delete(workspace);
    }

    _add(workspace, window, first) {
        const {windows} = this._workspaces.get(workspace);
        if (windows.includes(window) || window.get_workspace() !== workspace || !isTileable(window))
            return;

        if (first)
            windows.unshift(window);
        else
            windows.push(window);
        window.connectObject(
            'notify::minimized', () => this._queue(workspace),
            'notify::fullscreen', () => this._queue(workspace),
            'notify::maximized-horizontally', () => this._queue(workspace),
            'notify::maximized-vertically', () => this._queue(workspace),
            this);
        this._queue(workspace);
    }

    _remove(workspace, window) {
        const {windows, rects} = this._workspaces.get(workspace);
        const index = windows.indexOf(window);
        if (index < 0)
            return;

        windows.splice(index, 1);
        rects.delete(window);
        window.disconnectObject(this);
        this._queue(workspace);
    }

    // A new window only has its final size and size limits once it has drawn,
    // so add it again, in case it looked unresizable before, and tile then.
    // Windows that open maximized, e.g. restoring their last state, are tiled
    // too; only maximizing one later takes it out of the tiles.
    _watchNewWindow(window) {
        const actor = window.get_compositor_private();
        const id = actor?.connect('first-frame', () => {
            actor.disconnect(id);
            const workspace = window.get_workspace();
            if (!this._workspaces.has(workspace))
                return;
            // What kind of window it is can also settle late, e.g. a dialog
            // being tied to its parent.
            if (isTileable(window))
                this._add(workspace, window, true);
            else
                this._remove(workspace, window);
            if (this._workspaces.get(workspace).windows.includes(window) &&
                window.maximized_horizontally && window.maximized_vertically)
                window.unmaximize();
            this._queue(workspace);
        });
    }

    // Only a tiled window counts, so e.g. a fullscreen app's own dialogs
    // don't knock it out of fullscreen.
    _onFocus(focused) {
        const workspace = focused?.get_workspace();
        const state = this._workspaces.get(workspace);
        if (!state?.windows.includes(focused))
            return;

        for (const window of state.windows) {
            if (window === focused || window.get_monitor() !== focused.get_monitor())
                continue;
            if (window.is_fullscreen())
                window.unmake_fullscreen();
            if (window.maximized_horizontally && window.maximized_vertically)
                window.unmaximize();
        }
    }

    _onGrabBegin(window, op) {
        this._grabbing = true;
        const state = this._workspaces.get(window?.get_workspace());
        if (!state?.windows.includes(window) || !MOVE_GRAB_OPS.includes(op))
            return;

        // Tint the tile under the pointer, above its window but below the
        // dragged one.
        this._dropTint = new St.Widget({style_class: 'gnomeplusplus-tile-drop', visible: false});
        global.window_group.add_child(this._dropTint);
        this._dragged = window;
        window.connectObject('position-changed', () => {
            const target = this._dropTarget(state, window);
            const rect = state.rects.get(target);
            this._dropTint.visible = Boolean(target);
            if (!target)
                return;
            this._dropTint.set_position(rect.x, rect.y);
            this._dropTint.set_size(rect.width, rect.height);
            global.window_group.set_child_above_sibling(this._dropTint, target.get_compositor_private());
        }, this._dropTint);
    }

    _hideDropTint() {
        this._dragged?.disconnectObject(this._dropTint);
        this._dropTint?.destroy();
        this._dropTint = this._dragged = null;
    }

    // The tiled window whose tile is under the pointer, other than the dragged one.
    _dropTarget(state, window) {
        const [x, y] = global.get_pointer();
        return [...state.rects].find(([other, rect]) => other !== window &&
            x >= rect.x && x < rect.x + rect.width && y >= rect.y && y < rect.y + rect.height)?.[0];
    }

    _onGrabEnd(window, op) {
        this._grabbing = false;
        this._hideDropTint();
        const workspace = window?.get_workspace();
        const state = this._workspaces.get(workspace);
        if (!state?.windows.includes(window)) {
            this._queue(workspace);
            return;
        }

        if (MOVE_GRAB_OPS.includes(op)) {
            const target = this._dropTarget(state, window);
            if (target) {
                const {windows} = state;
                const from = windows.indexOf(window), to = windows.indexOf(target);
                [windows[from], windows[to]] = [target, window];
            }
        }
        // Anything dragged or resized snaps back into its tile.
        this._queue(workspace);
    }

    // Tile the workspace soon, along with any still waiting from a drag.
    _queue(workspace) {
        if (this._workspaces.has(workspace))
            this._queued.add(workspace);
        if (!this._queued.size)
            return;

        this._idleId ||= GLib.idle_add(GLib.PRIORITY_DEFAULT, () => {
            this._idleId = 0;
            // Don't pull windows about mid-drag; the drag's end tiles again.
            if (this._grabbing)
                return GLib.SOURCE_REMOVE;
            this._queued.forEach(queued => this._layout(queued));
            this._queued.clear();
            return GLib.SOURCE_REMOVE;
        });
    }

    // Minimized, fullscreen and fully maximized windows stay out of the tiles.
    _layout(workspace) {
        const state = this._workspaces.get(workspace);
        if (!state)
            return;

        state.rects.clear();
        const windows = state.windows.filter(window => isTileable(window) && !window.minimized &&
            !window.is_fullscreen() && !(window.maximized_horizontally && window.maximized_vertically));

        for (let monitor = 0; monitor < global.display.get_n_monitors(); monitor++) {
            const monitorWindows = windows.filter(window => window.get_monitor() === monitor);
            if (!monitorWindows.length)
                continue;

            const {x, y, width, height} = workspace.get_work_area_for_monitor(monitor);
            const gap = config.tileGap;
            const area = {x: x + gap, y: y + gap, width: width - 2 * gap, height: height - 2 * gap};
            splitArea(area, monitorWindows.length).forEach((rect, i) => {
                const window = monitorWindows[i];
                // Half-screen edge tiling counts as maximized vertically.
                if (window.maximized_horizontally || window.maximized_vertically)
                    window.unmaximize();
                window.move_resize_frame(true, rect.x, rect.y, rect.width, rect.height);
                state.rects.set(window, rect);
            });
        }
    }
}

// Mutter says fullscreen and maximized windows can't be resized, but they can
// once restored, so they are tiled then.
function isTileable(window) {
    const resizable = window.allows_resize() || window.is_fullscreen() ||
        window.maximized_horizontally || window.maximized_vertically;
    return window.get_window_type() === Meta.WindowType.NORMAL && !window.get_transient_for() &&
        !window.is_on_all_workspaces() && !window.is_skip_taskbar() && resizable && !isDialogLike(window);
}

// System dialogs an app opens through the desktop portal, e.g. the file
// chooser, come up as ordinary windows, not always tied to the app's window.
// The file chooser is a window of Files that isn't one of its registered app
// windows; the same goes for other GTK apps' free-standing dialogs.
function isDialogLike(window) {
    return window.get_wm_class()?.startsWith('xdg-desktop-portal') ||
        Boolean(window.get_gtk_application_id() && !window.get_gtk_window_object_path());
}

// Split an area into count rectangles: the first takes half of it, cut along
// the longer side, and the rest split the other half recursively.
function splitArea(area, count) {
    if (count === 1)
        return [area];

    const vertical = area.width >= area.height;
    const size = vertical ? area.width : area.height;
    const gap = config.tileGap;
    const half = Math.floor((size - gap) / 2);
    const first = {...area}, rest = {...area};
    if (vertical) {
        first.width = half;
        rest.x += half + gap;
        rest.width -= half + gap;
    } else {
        first.height = half;
        rest.y += half + gap;
        rest.height -= half + gap;
    }
    return [first, ...splitArea(rest, count - 1)];
}

// A tooltip under a top bar button, shown after hovering it for a moment, in
// the theme's style for the dash's app names. getText is asked each time, so
// the text can change. For a button that opens a menu, pass the menu: the
// tooltip stays away while it is open. Returns a function that removes it.

// Fades a tooltip in, centred under the stretch of the top bar that starts at
// x and is width wide, kept on the screen. Returns it; destroy it to hide it.
// Returns nothing when tooltips are switched off.
function showTooltip(text, x, width) {
    if (!config.tooltips)
        return null;

    const tooltip = new St.Label({style_class: 'dash-label', text, opacity: 0});
    Main.uiGroup.add_child(tooltip);

    const [, panelY] = Main.panel.get_transformed_position();
    const monitor = Main.layoutManager.findMonitorForActor(Main.panel);
    const {scaleFactor} = St.ThemeContext.get_for_stage(global.stage);
    const margin = 6 * scaleFactor;
    const tooltipX = Math.min(
        Math.max(x + (width - tooltip.width) / 2, monitor.x + margin),
        monitor.x + monitor.width - tooltip.width - margin);
    tooltip.set_position(Math.round(tooltipX), Math.round(panelY + Main.panel.height + margin));
    tooltip.ease({opacity: 255, duration: 150, mode: Clutter.AnimationMode.EASE_OUT_QUAD});
    return tooltip;
}

// While the pointer is on one of the top bar's clickable edges, its tooltip
// shows and the buttons' ones stay away.
let pointerOnEdge = false;
const hideButtonTooltips = new Set();

function addTooltip(button, getText, menu = null) {
    let tooltip = null;
    let timeoutId = 0;

    const hide = () => {
        if (timeoutId)
            GLib.source_remove(timeoutId);
        timeoutId = 0;
        tooltip?.destroy();
        tooltip = null;
    };

    const show = () => {
        if (pointerOnEdge)
            return;
        tooltip = showTooltip(getText(), button.get_transformed_position()[0], button.get_transformed_size()[0]);
    };
    hideButtonTooltips.add(hide);

    const ids = [
        button.connect('notify::hover', () => {
            hide();
            if (button.hover && !menu?.isOpen) {
                timeoutId = GLib.timeout_add(GLib.PRIORITY_DEFAULT, config.tooltipDelay, () => {
                    timeoutId = 0;
                    show();
                    return GLib.SOURCE_REMOVE;
                });
            }
        }),
        button.connect('destroy', hide),
    ];
    if (button instanceof St.Button)
        ids.push(button.connect('clicked', hide));
    const menuId = menu?.connect('open-state-changed', hide);

    button.connect('destroy', () => hideButtonTooltips.delete(hide));
    return () => {
        ids.forEach(id => button.disconnect(id));
        if (menuId)
            menu.disconnect(menuId);
        hide();
        hideButtonTooltips.delete(hide);
    };
}

// A dotted white border around a workspace number, drawn by hand as the shell's
// CSS only has solid borders.
function createDottedBorder() {
    const border = new St.DrawingArea({x_expand: true, y_expand: true, visible: false});
    border.connect('repaint', area => {
        const {scaleFactor} = St.ThemeContext.get_for_stage(global.stage);
        const [width, height] = area.get_surface_size();
        const line = 2 * scaleFactor;
        const inset = line / 2;
        const radius = 4 * scaleFactor - inset; // the button's border-radius
        const right = width - inset, bottom = height - inset;

        const cr = area.get_context();
        cr.newSubPath();
        cr.arc(right - radius, inset + radius, radius, -Math.PI / 2, 0);
        cr.arc(right - radius, bottom - radius, radius, 0, Math.PI / 2);
        cr.arc(inset + radius, bottom - radius, radius, Math.PI / 2, Math.PI);
        cr.arc(inset + radius, inset + radius, radius, Math.PI, 3 * Math.PI / 2);
        cr.closePath();
        // Near zero-length dashes with round caps draw as dots. Cairo in GJS
        // refuses a dash of exactly zero.
        cr.setSourceRGBA(1, 1, 1, 1);
        cr.setLineWidth(line);
        cr.setLineCap(Cairo.LineCap.ROUND);
        cr.setDash([0.01, 4 * scaleFactor], 0);
        cr.stroke();
        cr.$dispose();
    });
    return border;
}

// Stopwatches at the far right of the top bar. Each stopwatch's time so far in microseconds, and when it was last started
// if it is running. Kept outside the extension so they keep counting through
// it being disabled and re-enabled, which the shell does around the lock screen.
// The times are also saved to a file, so after a logout or reboot each
// stopwatch comes back paused at the time it had. Each also keeps a history of
// the times it had when it was ended in the last 24 hours, newest first:
// {elapsed, at}, with at the end's time in Unix seconds.
const STOPWATCH_FILE = GLib.build_filenamev([GLib.get_user_state_dir(), UUID, 'stopwatches.json']);

// Drop the measurements that ended longer ago than that.
function pruneStopwatchHistory(history) {
    const oldest = Math.floor(GLib.get_real_time() / 1e6) - config.stopwatchHistoryAge;
    return history.filter(entry => entry.at >= oldest);
}

function stopwatchElapsed(state) {
    return state.elapsed + (state.startedAt === null ? 0 : GLib.get_monotonic_time() - state.startedAt);
}

// A time in microseconds as hh:mm:ss.
function formatStopwatchTime(elapsed) {
    const seconds = Math.floor(elapsed / 1e6);
    const pad = number => `${number}`.padStart(2, '0');
    return `${pad(Math.floor(seconds / 3600))}:${pad(Math.floor(seconds / 60) % 60)}:${pad(seconds % 60)}`;
}

// A time in hours to the nearest half, e.g. 0.5, 1 or 1.5, for a timesheet.
// Exact quarters round up, and any time at all counts as 0.5.
function stopwatchHours(elapsed) {
    return `${Math.max(1, Math.round(elapsed / (30 * 60 * 1e6))) / 2}`;
}

function loadStopwatches() {
    let saved = [];
    try {
        const [, contents] = GLib.file_get_contents(STOPWATCH_FILE);
        saved = JSON.parse(new TextDecoder().decode(contents));
    } catch {
        // No file yet, or an unreadable one: start from zero.
    }
    // Before the history, the file was just the list of times.
    const times = Array.isArray(saved) ? saved : saved?.times ?? [];
    const histories = Array.isArray(saved) ? [] : saved?.history ?? [];
    return Array.from({length: config.stopwatchCount}, (_value, i) => ({
        elapsed: Number.isFinite(times[i]) && times[i] > 0 ? times[i] : 0,
        startedAt: null,
        history: pruneStopwatchHistory((Array.isArray(histories[i]) ? histories[i] : [])
            .filter(entry => Number.isFinite(entry?.elapsed) && Number.isFinite(entry?.at))),
    }));
}

function saveStopwatches() {
    try {
        GLib.mkdir_with_parents(GLib.path_get_dirname(STOPWATCH_FILE), 0o700);
        GLib.file_set_contents(STOPWATCH_FILE, JSON.stringify({
            times: stopwatches.map(stopwatchElapsed),
            history: stopwatches.map(state => state.history),
        }));
    } catch (e) {
        console.error(`${UUID}: failed to save stopwatches: ${e.message}`);
    }
}

const stopwatches = Extension ? loadStopwatches() : [];

// A stopwatch in the top bar: click to start or pause it, right-click for a
// menu with a row of buttons to start, pause or end it; ending stores its
// time and zeroes it.
// The menu also lists its measurements, the time now and the times at its
// last Ends; clicking one copies it in hours.
function createStopwatch(index) {
    const state = stopwatches[index];
    const name = config.stopwatchCount > 1 ? `Stopwatch ${index + 1}` : 'Stopwatch';
    const button = new PanelMenu.Button(0.5, name);
    const label = new St.Label({style_class: 'gnomeplusplus-stopwatch', y_align: Clutter.ActorAlign.CENTER});
    button.add_child(label);
    let timeoutId = 0;

    const elapsed = () => stopwatchElapsed(state);

    // Always hh:mm:ss. Running is blue, paused is white and an unused one is
    // dimmed.
    const update = () => {
        label.text = formatStopwatchTime(elapsed());

        const running = state.startedAt !== null;
        setActionSensitive(startAction, !running);
        setActionSensitive(pauseAction, running);
        const used = running || state.elapsed > 0;
        setActionSensitive(endAction, used);
        currentItem.visible = used;
        currentItem.label.text = `${label.text}  |  ${stopwatchHours(elapsed())} h  |  ${running ? 'In Progress' : 'Paused'}`;
        measurementsSeparator.visible = used || state.history.length > 0;
        setActionSensitive(clearAction, state.history.length > 0);
        for (const [name, on] of [['running', running], ['unused', !running && !state.elapsed]]) {
            if (on)
                label.add_style_class_name(`gnomeplusplus-stopwatch-${name}`);
            else
                label.remove_style_class_name(`gnomeplusplus-stopwatch-${name}`);
        }
        // The current measurement in the menu is blue while running as well.
        if (running)
            currentItem.label.add_style_class_name('gnomeplusplus-stopwatch-running');
        else
            currentItem.label.remove_style_class_name('gnomeplusplus-stopwatch-running');
    };

    // While it runs, redraw just after each whole second passes, and save the
    // time every few seconds: a shutdown gives no chance to.
    const tick = () => {
        if (timeoutId)
            GLib.source_remove(timeoutId);
        timeoutId = 0;
        update();
        if (state.startedAt === null)
            return;
        if (Math.floor(elapsed() / 1e6) % config.stopwatchSaveInterval === 0)
            saveStopwatches();
        const untilNextSecond = 1000 - Math.floor(elapsed() / 1000) % 1000;
        timeoutId = GLib.timeout_add(GLib.PRIORITY_DEFAULT, untilNextSecond + 10, () => {
            timeoutId = 0;
            tick();
            return GLib.SOURCE_REMOVE;
        });
    };

    // The button's own gesture opens the menu on any click.
    button._clickGesture.set_enabled(false);
    const startPause = () => {
        if (state.startedAt === null) {
            state.startedAt = GLib.get_monotonic_time();
        } else {
            state.elapsed = elapsed();
            state.startedAt = null;
        }
        tick();
        saveStopwatches();
    };
    const click = new Clutter.ClickGesture({required_button: Clutter.BUTTON_PRIMARY});
    click.connect('recognize', () => {
        button.menu.close();
        startPause();
    });
    button.add_action(click);
    const openMenu = new Clutter.ClickGesture({required_button: Clutter.BUTTON_SECONDARY});
    openMenu.connect('recognize', () => button.menu.toggle());
    button.add_action(openMenu);

    // End stores the time as a measurement and goes back to zero.
    const end = () => {
        state.history.unshift({elapsed: elapsed(), at: Math.floor(GLib.get_real_time() / 1e6)});
        state.elapsed = 0;
        state.startedAt = null;
        showHistory();
        tick();
        saveStopwatches();
    };

    // Start, Pause and End side by side in one row, each a third of it. All
    // always there; the ones that don't apply right now are greyed out. The
    // menu stays open, so the measurements below show what they did.
    const actionsItem = new PopupMenu.PopupBaseMenuItem({reactive: false, can_focus: false});
    const actions = new St.BoxLayout({style_class: 'gnomeplusplus-stopwatch-actions', x_expand: true});
    actions.layout_manager.homogeneous = true;
    actionsItem.add_child(actions);
    button.menu.addMenuItem(actionsItem);
    const addAction = (text, callback) => {
        const action = new St.Button({label: text, style_class: 'button', x_expand: true, can_focus: true});
        action.connect('clicked', callback);
        actions.add_child(action);
        return action;
    };
    const setActionSensitive = (action, sensitive) => action.set({reactive: sensitive, can_focus: sensitive});
    const startAction = addAction('Start', startPause);
    const pauseAction = addAction('Pause', startPause);
    const endAction = addAction('End', end);

    // Measurements: the time now, kept up to date while it runs, then the
    // times at the Ends of the last 24 hours with when they ended, newest first, e.g.
    // "01:15:00 | 1.5 h | 30.09.2026 – 14.05:09". Clicking one copies its hours.
    // Copying says so for a moment, in a tooltip under the stopwatch.
    let copiedNote = null;
    let copiedTimeoutId = 0;
    const hideCopiedNote = () => {
        if (copiedTimeoutId)
            GLib.source_remove(copiedTimeoutId);
        copiedTimeoutId = 0;
        copiedNote?.destroy();
        copiedNote = null;
    };
    const copyHours = time => {
        St.Clipboard.get_default().set_text(St.ClipboardType.CLIPBOARD, stopwatchHours(time));
        hideCopiedNote();
        copiedNote = showTooltip('Copied to clipboard', button.get_transformed_position()[0], button.get_transformed_size()[0]);
        copiedTimeoutId = GLib.timeout_add(GLib.PRIORITY_DEFAULT, config.copiedNoteTime, () => {
            copiedTimeoutId = 0;
            hideCopiedNote();
            return GLib.SOURCE_REMOVE;
        });
    };
    const measurementsSeparator = new PopupMenu.PopupSeparatorMenuItem('Measurements');
    button.menu.addMenuItem(measurementsSeparator);
    // Clear all, at the right end of that heading, forgets the ended ones.
    const clearAction = new St.Button({
        label: 'Clear all',
        style_class: 'button gnomeplusplus-stopwatch-clear',
        can_focus: true,
        y_align: Clutter.ActorAlign.CENTER,
    });
    clearAction.connect('clicked', () => {
        state.history = [];
        showHistory();
        update();
        saveStopwatches();
    });
    measurementsSeparator.add_child(clearAction);
    const currentItem = button.menu.addAction('', () => copyHours(elapsed()));
    const historySection = new PopupMenu.PopupMenuSection();
    button.menu.addMenuItem(historySection);
    const showHistory = () => {
        state.history = pruneStopwatchHistory(state.history);
        historySection.removeAll();
        for (const entry of state.history) {
            const when = GLib.DateTime.new_from_unix_local(entry.at).format('%d.%m.%Y – %H.%M:%S');
            const text = `${formatStopwatchTime(entry.elapsed)}  |  ${stopwatchHours(entry.elapsed)} h  |  ${when}`;
            historySection.addAction(text, () => copyHours(entry.elapsed));
        }
    };
    showHistory();
    // Also each time the menu opens, so ones that got too old are gone.
    button.menu.connect('open-state-changed', (_menu, open) => {
        if (open) {
            showHistory();
            update();
        }
    });

    addTooltip(button, () => name, button.menu);
    button.connect('destroy', () => {
        if (timeoutId)
            GLib.source_remove(timeoutId);
        hideCopiedNote();
        saveStopwatches();
    });
    tick();
    return button;
}

// Show desktop, in the top bar's right side between app indicators and the
// shell's own indicators: minimizes the current workspace's windows, and when
// none are left showing, a second click brings back the ones it minimized.
// From the overview or app grid it always closes them onto the bare desktop.
function createShowDesktopButton() {
    let minimized = [];
    const button = new St.Button({
        style_class: 'panel-button',
        child: new St.Icon({icon_name: 'user-desktop-symbolic', style_class: 'system-status-icon'}),
        accessible_name: 'Show Desktop',
    });
    addTooltip(button, () => 'Show Desktop');
    button.connect('clicked', () => {
        const workspace = global.workspace_manager.get_active_workspace();
        // Most recently used first.
        const windows = global.display.get_tab_list(Meta.TabList.NORMAL, workspace);
        const showing = windows.filter(window => !window.minimized && window.can_minimize());
        if (Main.overview.visible) {
            // Minimize first, so the overview closes straight onto the desktop.
            if (showing.length) {
                showing.forEach(window => window.minimize());
                minimized = showing;
            }
            Main.overview.hide();
        } else if (showing.length) {
            showing.forEach(window => window.minimize());
            minimized = showing;
        } else {
            // Back to front, so the last used window ends up on top and focused.
            const time = global.get_current_time();
            minimized.filter(window => windows.includes(window) && window.minimized)
                .reverse()
                .forEach(window => window.activate(time));
            minimized = [];
        }
    });
    return button;
}

// An app grid button and app launchers next to the workspace buttons. The
// launchers are the apps pinned to the (hidden) dash, so an app's "Pin to Dash"
// adds it. So does dropping it from the app grid among the launchers; dragging
// a launcher moves it, and its right-click menu unpins it.
// Clicking a launcher always opens a new window, even when the app is running,
// and closes the overview or app grid if it is open.
function createAppButtons() {
    const favorites = AppFavorites.getAppFavorites();
    const laters = global.compositor.get_laters();
    const box = new St.BoxLayout({style_class: 'gnomeplusplus-apps'});
    let launchers = []; // {id, button} of the pinned apps, in order
    let laterId = 0;

    const allApps = new St.Button({
        style_class: 'gnomeplusplus-app',
        child: new St.Icon({icon_name: 'view-app-grid-symbolic', style_class: 'gnomeplusplus-app-icon'}),
        accessible_name: 'Show Apps',
    });
    allApps.connect('clicked', toggleAppGrid);
    addTooltip(allApps, () => 'Show Apps');
    box.add_child(allApps);

    // Shows where a dragged app would land.
    const placeholder = new St.Widget({style_class: 'gnomeplusplus-app-placeholder'});
    let placeholderPosition = -1;
    const removePlaceholder = () => {
        if (placeholder.get_parent())
            box.remove_child(placeholder);
        placeholderPosition = -1;
    };

    // Changing the pinned apps rebuilds the launchers, so wait until the menu
    // item or drag that asked for it is done with them.
    const changeLater = change => {
        if (laterId)
            laters.remove(laterId);
        laterId = laters.add(Meta.LaterType.BEFORE_REDRAW, () => {
            laterId = 0;
            change();
            return GLib.SOURCE_REMOVE;
        });
    };

    const createLauncher = app => {
        const createIcon = () => new St.Icon({gicon: app.get_icon(), style_class: 'gnomeplusplus-app-icon'});
        const button = new St.Button({
            style_class: 'gnomeplusplus-app',
            child: createIcon(),
            accessible_name: app.get_name(),
            button_mask: St.ButtonMask.ONE | St.ButtonMask.THREE,
        });
        const menu = createPanelMenu(button);
        menu.addAction('Unpin', () => changeLater(() => favorites.removeFavorite(app.get_id())));
        // From the overview or app grid, close it so the new window shows.
        button.connect('clicked', (_button, clickedButton) => {
            if (clickedButton === Clutter.BUTTON_SECONDARY) {
                menu.toggle();
                return;
            }
            menu.close();
            Main.overview.hide();
            app.open_new_window(-1);
        });
        addTooltip(button, () => app.get_name(), menu);

        // The button stays in place, dimmed, while a copy of its icon is dragged.
        button._delegate = {app, getDragActor: createIcon, getDragActorSource: () => button};
        const draggable = DND.makeDraggable(button, {timeoutThreshold: 200});
        const endDrag = () => {
            button.opacity = 255;
            removePlaceholder();
        };
        draggable.connect('drag-begin', () => {
            menu.close();
            button.opacity = 100;
        });
        draggable.connect('drag-cancelled', endDrag);
        draggable.connect('drag-end', endDrag);
        return button;
    };

    const rebuild = () => {
        removePlaceholder();
        launchers.forEach(({button}) => button.destroy());
        launchers = [];
        for (const app of favorites.getFavorites()) {
            const button = createLauncher(app);
            launchers.push({id: app.get_id(), button});
            box.add_child(button);
        }
    };

    // The app of a dragged app grid icon or launcher.
    const getDraggedApp = source => {
        const app = source?.app;
        return app instanceof Shell.App && !app.is_window_backed() ? app : null;
    };

    // The launchers left of x, which is relative to the box.
    const getLaunchersBefore = x => launchers.filter(({button}) => {
        const {x1, x2} = button.get_allocation_box();
        return (x1 + x2) / 2 < x;
    });

    box._delegate = {
        handleDragOver(source, _actor, x) {
            const app = getDraggedApp(source);
            if (!app)
                return DND.DragMotionResult.NO_DROP;

            const position = getLaunchersBefore(x).length;
            if (position !== placeholderPosition) {
                // Skip the app grid button. The index is the one after taking
                // the placeholder out, as is the position.
                if (placeholder.get_parent())
                    box.set_child_at_index(placeholder, position + 1);
                else
                    box.insert_child_at_index(placeholder, position + 1);
                placeholderPosition = position;
            }
            return favorites.isFavorite(app.get_id()) ? DND.DragMotionResult.MOVE_DROP : DND.DragMotionResult.COPY_DROP;
        },

        acceptDrop(source, _actor, x) {
            const id = getDraggedApp(source)?.get_id();
            if (!id)
                return false;

            // Its place among the other pinned apps.
            const position = getLaunchersBefore(x).filter(launcher => launcher.id !== id).length;
            removePlaceholder();
            changeLater(() => {
                if (favorites.isFavorite(id))
                    favorites.moveFavoriteToPos(id, position);
                else
                    favorites.addFavoriteAtPos(id, position);
            });
            return true;
        },
    };

    // Drop the placeholder when the drag leaves the launchers or ends there
    // without a drop.
    const dragMonitor = {
        dragMotion: ({targetActor}) => {
            if (!box.contains(targetActor))
                removePlaceholder();
            return DND.DragMotionResult.CONTINUE;
        },
    };
    DND.addDragMonitor(dragMonitor);
    Main.overview.connectObject(
        'item-drag-end', removePlaceholder,
        'item-drag-cancelled', removePlaceholder,
        box);
    favorites.connectObject('changed', () => rebuild(), box);

    box.connect('destroy', () => {
        DND.removeDragMonitor(dragMonitor);
        if (laterId)
            laters.remove(laterId);
        removePlaceholder();
        placeholder.destroy();
    });

    rebuild();
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
    return new Shell.BlurEffect({mode, radius: config.blurRadius, brightness: config.blurBrightness});
}

// A blurred copy of one monitor's wallpaper, added to group.
function blurredWallpaper(group, monitorIndex) {
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
}

function createOverviewBackground() {
    const group = new Meta.BackgroundGroup();
    let managers = [];

    const rebuild = () => {
        managers.forEach(manager => manager.destroy());
        managers = Main.layoutManager.monitors.map((_monitor, monitorIndex) => blurredWallpaper(group, monitorIndex));
    };

    Main.layoutManager.connectObject('monitors-changed', rebuild, group);
    group.connect('destroy', () => managers.forEach(manager => manager.destroy()));
    rebuild();
    return group;
}

// Fades out the corners of the actor it is on, rounding it to a radius. The
// texture it draws is padded a little around the actor, so find the actor's
// own pixels inside it first. The curve sits a pixel inside the radius, so the
// soft edge of the actor's own rounded border doesn't show it.
const CORNER_DECLARATIONS = `
uniform vec2 texture_size;
uniform vec2 size;
uniform float radius;
`;
const CORNER_CODE = `
vec2 position = cogl_tex_coord_in[0].xy * texture_size - (texture_size - size) * 0.5;
vec2 edge = min(position, size - position);
if (edge.x < radius && edge.y < radius)
    cogl_color_out *= clamp(radius - distance(edge, vec2(radius)) - 0.5, 0.0, 1.0);
`;

const CornerEffect = Extension ? GObject.registerClass(
class GnomePlusPlusCornerEffect extends Shell.GLSLEffect {
    vfunc_build_pipeline() {
        this.add_glsl_snippet(Cogl.SnippetHook.FRAGMENT, CORNER_DECLARATIONS, CORNER_CODE, false);
    }

    setRadius(radius) {
        this.set_uniform_float(this.get_uniform_location('radius'), 1, [radius]);
        this.queue_repaint();
    }

    vfunc_paint_target(node, paintContext) {
        const [, textureWidth, textureHeight] = this.get_target_size();
        const actor = this.get_actor();
        this.set_uniform_float(this.get_uniform_location('texture_size'), 2, [textureWidth, textureHeight]);
        this.set_uniform_float(this.get_uniform_location('size'), 2, [actor.width, actor.height]);
        super.vfunc_paint_target(node, paintContext);
    }
}) : null;

// Blur-my-shell's static popup blur: while the actor shows, a blurred copy of
// the wallpaper sits right behind it, rounded to the actor's own corners and
// faded with it. The shell's live blur can only cover a square area, which
// shows as dark corners around a rounded popup. Returns a function that undoes it.
function roundedWallpaperBlur(target) {
    let backdrop = null, wallpaper = null, manager = null, monitorIndex = -1, shownRadius = -1;

    let updateId = 0;
    const hide = () => backdrop?.destroy();
    // Also when the shell destroys the backdrop, e.g. on logout, which takes
    // the wallpaper actors with it before the manager can.
    const onBackdropDestroyed = () => {
        global.stage.disconnect(updateId);
        if (manager) {
            manager.backgroundActor = manager._newBackgroundActor = null;
            manager.destroy();
        }
        backdrop = wallpaper = manager = null;
        monitorIndex = -1;
        shownRadius = -1;
    };

    // Called before every frame while the target shows, to follow it about.
    const sync = () => {
        let top = target;
        while (top && top.get_parent() !== Main.uiGroup)
            top = top.get_parent();
        if (!top || !target.mapped) {
            hide();
            return;
        }

        const index = Main.layoutManager.findIndexForActor(target);
        if (index !== monitorIndex) {
            manager?.destroy();
            manager = blurredWallpaper(wallpaper, index);
            monitorIndex = index;
        }

        // Nothing to follow until the target has been laid out.
        const {origin: {x, y}, size: {width, height}} = target.get_transformed_extents();
        backdrop.visible = [x, y, width, height].every(Number.isFinite) && width > 0 && height > 0;
        if (!backdrop.visible)
            return;
        if (backdrop.x !== x || backdrop.y !== y || backdrop.width !== width || backdrop.height !== height) {
            backdrop.set_position(x, y);
            backdrop.set_size(width, height);
            wallpaper.set_position(-x, -y);
        }
        if (backdrop.get_next_sibling() !== top)
            Main.uiGroup.set_child_below_sibling(backdrop, top);
        backdrop.opacity = target.get_paint_opacity();

        // Scaled along with the target, e.g. while a menu zooms open.
        // Pill shapes have a huge radius in the theme.
        const themeRadius = target.get_theme_node().get_border_radius(St.Corner.TOPLEFT) * width / (target.width || 1);
        const radius = Math.min(themeRadius, width / 2, height / 2);
        if (radius !== shownRadius) {
            backdrop.get_effect('gnomeplusplus-corners').setRadius(radius);
            shownRadius = radius;
        }
    };

    const show = () => {
        if (backdrop)
            return;
        backdrop = new Clutter.Actor({clip_to_allocation: true});
        backdrop.connect('destroy', onBackdropDestroyed);
        backdrop.add_effect_with_name('gnomeplusplus-corners', new CornerEffect());
        wallpaper = new Meta.BackgroundGroup();
        backdrop.add_child(wallpaper);
        Main.uiGroup.add_child(backdrop);
        updateId = global.stage.connect('before-update', sync);
        sync();
    };

    const mappedId = target.connect('notify::mapped', () => (target.mapped ? show() : hide()));
    const destroyId = target.connect('destroy', hide);
    if (target.mapped)
        show();

    return () => {
        target.disconnect(mappedId);
        target.disconnect(destroyId);
        hide();
    };
}

// Top bar menus, notification popups, volume and brightness popups, the
// Alt+Tab and workspace switchers, dialogs, app folders and the log out /
// restart / shut down dialog blur what is behind them too. The shell creates
// these on demand, so blur each one as it first appears. The rounded popups
// and dialogs get the wallpaper blur, the full-screen folders and log out
// dialog the live blur. Returns a function that undoes it.
function blurPopups() {
    const blurred = new Map(); // actor -> function that undoes its blur
    const blur = (actor, rounded = false) => {
        if (blurred.has(actor))
            return;
        let undo;
        if (rounded) {
            undo = roundedWallpaperBlur(actor);
        } else {
            actor.add_effect_with_name('gnomeplusplus-blur', blurEffect(Shell.BlurMode.BACKGROUND));
            undo = () => actor.remove_effect_by_name('gnomeplusplus-blur');
        }
        actor.add_style_class_name('gnomeplusplus-blurred');
        blurred.set(actor, () => {
            undo();
            actor.remove_style_class_name('gnomeplusplus-blurred');
        });
        actor.connect('destroy', () => blurred.delete(actor));
    };

    const menuOpen = PopupMenu.PopupMenu.prototype.open;
    PopupMenu.PopupMenu.prototype.open = function (...args) {
        if (this.sourceActor && Main.panel.contains(this.sourceActor))
            blur(this.box, true);
        return menuOpen.apply(this, args);
    };

    // An open folder covers the screen and shades everything behind it almost
    // black. Blur that whole area instead, and re-aim the shell's shade fades
    // at a light tint right after it starts them.
    const folder = AppDisplay.AppFolderDialog.prototype;
    const {popup, _zoomAndFadeIn: zoomAndFadeIn, _setLighterBackground: setLighterBackground} = folder;
    const {_zoomAndFadeOut: zoomAndFadeOut} = folder;
    const FOLDER_ANIMATION_TIME = 200; // the shell's FOLDER_DIALOG_ANIMATION_TIME
    const shade = (dialog, alpha) => dialog.ease({
        background_color: new Cogl.Color({red: 0, green: 0, blue: 0, alpha}),
        duration: FOLDER_ANIMATION_TIME,
        mode: Clutter.AnimationMode.EASE_OUT_QUAD,
    });
    // The blur grows in as the folder zooms open and fades out as it closes.
    const easeBlur = (dialog, radius, brightness) => {
        if (!dialog.get_effect('gnomeplusplus-blur'))
            return;
        const params = {duration: FOLDER_ANIMATION_TIME, mode: Clutter.AnimationMode.EASE_OUT_QUAD};
        dialog.ease_property('@effects.gnomeplusplus-blur.radius', radius, params);
        dialog.ease_property('@effects.gnomeplusplus-blur.brightness', brightness, params);
    };
    folder.popup = function (...args) {
        blur(this);
        return popup.apply(this, args);
    };
    folder._zoomAndFadeIn = function (...args) {
        zoomAndFadeIn.apply(this, args);
        shade(this, config.folderShade);
        this.get_effect('gnomeplusplus-blur')?.set({radius: 0, brightness: 1});
        easeBlur(this, config.blurRadius, config.blurBrightness);
    };
    folder._zoomAndFadeOut = function (...args) {
        zoomAndFadeOut.apply(this, args);
        easeBlur(this, 0, 1);
    };
    folder._setLighterBackground = function (lighter) {
        setLighterBackground.call(this, lighter);
        shade(this, lighter ? config.folderShadeLighter : config.folderShade);
    };

    // The end session dialog is a full-screen layer holding the shade and the
    // dialog box, so blurring the layer blurs the whole screen behind it.
    const modalOpen = ModalDialog.ModalDialog.prototype.open;
    // Other dialogs, e.g. Alt+F2 and password prompts, blur just their box.
    ModalDialog.ModalDialog.prototype.open = function (...args) {
        if (this instanceof EndSessionDialog.EndSessionDialog)
            blur(this);
        else
            blur(this.dialogLayout._dialog, true);
        return modalOpen.apply(this, args);
    };

    const osdShow = OsdWindow.OsdWindow.prototype.show;
    OsdWindow.OsdWindow.prototype.show = function (...args) {
        blur(this._hbox, true);
        return osdShow.apply(this, args);
    };

    // Alt+Tab adds its window thumbnails as a second list later on.
    const switcherShow = SwitcherPopup.SwitcherPopup.prototype.show;
    SwitcherPopup.SwitcherPopup.prototype.show = function (...args) {
        this.connectObject('child-added', (_popup, child) => {
            if (child.has_style_class_name?.('switcher-list'))
                blur(child, true);
        }, this);
        return switcherShow.apply(this, args);
    };

    const workspacePopup = WorkspaceSwitcherPopup.WorkspaceSwitcherPopup.prototype;
    const workspacePopupDisplay = workspacePopup.display;
    workspacePopup.display = function (...args) {
        workspacePopupDisplay.apply(this, args);
        for (const monitorPopup of this)
            blur(monitorPopup._list, true);
    };

    const bannerBin = Main.messageTray._bannerBin;
    const bannerId = bannerBin.connect('child-added', (_bin, banner) => blur(banner, true));

    return () => {
        PopupMenu.PopupMenu.prototype.open = menuOpen;
        Object.assign(folder, {
            popup,
            _zoomAndFadeIn: zoomAndFadeIn,
            _zoomAndFadeOut: zoomAndFadeOut,
            _setLighterBackground: setLighterBackground,
        });
        ModalDialog.ModalDialog.prototype.open = modalOpen;
        OsdWindow.OsdWindow.prototype.show = osdShow;
        SwitcherPopup.SwitcherPopup.prototype.show = switcherShow;
        workspacePopup.display = workspacePopupDisplay;
        bannerBin.disconnect(bannerId);
        blurred.forEach(undo => undo());
    };
}

// The app grid leaves out the apps pinned to the dash, and unpins one that is
// dropped on the grid. Keep the pins from it, so that every app is always in
// the grid, pinned or not.
function showPinnedAppsInGrid() {
    const favorites = AppFavorites.getAppFavorites();
    const methods = [
        [AppDisplay.AppDisplay.prototype, '_loadApps'],
        [AppDisplay.AppDisplay.prototype, '_onDragBegin'],
        [AppDisplay.AppDisplay.prototype, 'acceptDrop'],
        [AppDisplay.FolderView.prototype, '_loadApps'],
    ].map(([prototype, name]) => [prototype, name, prototype[name]]);

    for (const [prototype, name, method] of methods) {
        prototype[name] = function (...args) {
            favorites.isFavorite = () => false;
            try {
                return method.apply(this, args);
            } finally {
                delete favorites.isFavorite;
            }
        };
    }
    // Reload the grid and its folders.
    favorites.emit('changed');

    return () => {
        for (const [prototype, name, method] of methods)
            prototype[name] = method;
        favorites.emit('changed');
    };
}

// Double-clicking empty top bar space throws confetti over all screens for
// a while, with celebration.wav. Returns a function that undoes it.
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

        for (let i = 0; i < config.confettiPieces; i++) {
            const [red, green, blue] = config.confettiColors[Math.floor(Math.random() * config.confettiColors.length)];
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
            const delay = Math.random() * config.confettiDuration / 3;
            piece.ease({
                translation_x: (Math.random() - 0.5) * 300 * scaleFactor,
                translation_y: height + size * 2 - piece.y,
                rotation_angle_z: piece.rotation_angle_z + (Math.random() - 0.5) * 1080,
                delay,
                duration: config.confettiDuration - delay,
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

        timeoutId = GLib.timeout_add(GLib.PRIORITY_DEFAULT, config.confettiDuration, () => {
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

// The top bar has an empty strip at its left end, EDGE_WIDTH wide (the
// stylesheet leaves the room), which the pointer lands on when thrown into
// the top-left corner of the screen. Clicking it toggles the app grid.
const EDGE_WIDTH = 1;
const EDGES = [
    {
        text: 'Show Apps',
        start: () => Main.panel.get_transformed_position()[0],
        activate: () => toggleAppGrid(),
    },
];

function edgeWidth() {
    return EDGE_WIDTH * St.ThemeContext.get_for_stage(global.stage).scaleFactor;
}

// The edge at a point of the screen, if any.
function edgeAt(x, y) {
    const [, panelY] = Main.panel.get_transformed_position();
    if (y < panelY || y >= panelY + Main.panel.height)
        return null;
    return EDGES.find(edge => x >= edge.start() && x < edge.start() + edgeWidth()) ?? null;
}

// Returns a function that undoes it.
function setupEdgeClicks() {
    const pressId = Main.panel.connect('captured-event::button', (_panel, event) => {
        if (event.type() !== Clutter.EventType.BUTTON_PRESS || event.get_button() !== Clutter.BUTTON_PRIMARY)
            return Clutter.EVENT_PROPAGATE;

        const edge = edgeAt(...event.get_coords());
        if (!edge)
            return Clutter.EVENT_PROPAGATE;
        edge.activate();
        return Clutter.EVENT_STOP;
    });

    return () => Main.panel.disconnect(pressId);
}

// Tooltips for the top bar's clickable edges. They aren't buttons of
// their own, so follow the pointer over the top bar; once it is on an edge,
// keep checking it is still there, as leaving the bar sends no more motion.
// Returns a function that undoes it.
function setupEdgeTooltips() {
    let hovered = null;
    let tooltip = null;
    let timeoutId = 0;
    let pollId = 0;

    const leave = () => {
        for (const id of [timeoutId, pollId]) {
            if (id)
                GLib.source_remove(id);
        }
        timeoutId = pollId = 0;
        tooltip?.destroy();
        tooltip = hovered = null;
        pointerOnEdge = false;
    };

    const enter = edge => {
        leave();
        hovered = edge;
        pointerOnEdge = true;
        hideButtonTooltips.forEach(hide => hide());
        timeoutId = GLib.timeout_add(GLib.PRIORITY_DEFAULT, config.tooltipDelay, () => {
            timeoutId = 0;
            tooltip = showTooltip(edge.text, edge.start(), edgeWidth());
            return GLib.SOURCE_REMOVE;
        });
        // Check against where the edge is now: the top bar has no size for a
        // moment while the shell lays itself out again, e.g. as the app grid
        // opens, which would look like the pointer having left.
        const [left, right] = [edge.start(), edge.start() + edgeWidth()];
        const [, top] = Main.panel.get_transformed_position();
        const bottom = top + Main.panel.height;
        pollId = GLib.timeout_add(GLib.PRIORITY_DEFAULT, 100, () => {
            const [x, y] = global.get_pointer();
            if (x >= left && x < right && y >= top && y < bottom)
                return GLib.SOURCE_CONTINUE;
            pollId = 0;
            leave();
            return GLib.SOURCE_REMOVE;
        });
    };

    const eventId = Main.panel.connect('captured-event', (_panel, event) => {
        if (event.type() === Clutter.EventType.MOTION) {
            const edge = edgeAt(...event.get_coords());
            if (edge !== hovered) {
                if (edge)
                    enter(edge);
                else
                    leave();
            }
        } else if (event.type() === Clutter.EventType.BUTTON_PRESS) {
            leave();
        }
        return Clutter.EVENT_PROPAGATE;
    });

    return () => {
        Main.panel.disconnect(eventId);
        leave();
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

if (!Extension) {
    applySettings(Gio.File.new_for_uri(import.meta.url).get_parent());
    setTimezone(config.timezone);
}

export default class GnomePlusPlusExtension extends (Extension ?? Object) {
    // Sets up the features that are switched on in settings.js, each leaving
    // behind a function that undoes it.
    enable() {
        applySettings(this.dir);
        setTimezone(config.timezone);

        const undo = this._undo = [];
        const {dateMenu, quickSettings} = Main.panel.statusArea;

        const update = () => dateMenu._clockDisplay.set_text(formatClock());
        // Tied to the label, so the handler goes away if the shell destroys the
        // label first (on logout).
        dateMenu._clock.connectObject('notify::clock', update, dateMenu._clockDisplay);
        update();
        undo.push(() => {
            dateMenu._clock.disconnectObject(dateMenu._clockDisplay);
            dateMenu._clockDisplay.set_text(dateMenu._clock.clock);
        });

        if (config.workspaceButtons) {
            const {container: activities} = Main.panel.statusArea.activities;
            const workspaces = createWorkspaceButtons();
            activities.hide();
            Main.panel._leftBox.insert_child_at_index(workspaces, 0);
            undo.push(() => {
                workspaces.destroy();
                activities.show();
            });
        }

        const apps = createAppButtons();
        Main.panel._leftBox.insert_child_at_index(apps, 1);
        undo.push(() => apps.destroy());

        undo.push(
            addTooltip(dateMenu, () => 'Calendar and Notifications', dateMenu.menu),
            addTooltip(quickSettings, () => 'Quick Settings', quickSettings.menu));

        if (config.showDesktopButton) {
            const showDesktop = createShowDesktopButton();
            const shellIndicators = Main.sessionMode.panel.right.map(name => Main.panel.statusArea[name]?.container);
            const firstShellIndicator = Main.panel._rightBox.get_children().find(child => shellIndicators.includes(child));
            Main.panel._rightBox.insert_child_below(showDesktop, firstShellIndicator ?? null);
            undo.push(() => showDesktop.destroy());
        }

        if (config.stopwatch) {
            stopwatches.forEach((_state, i) => {
                const stopwatch = createStopwatch(i);
                Main.panel.addToStatusArea(`gnomeplusplus-stopwatch-${i + 1}`, stopwatch, -1, 'right');
                undo.push(() => stopwatch.destroy());
            });
        }

        // Hide the favourites dash in the overview. It stays "visible" because a
        // hidden dash never styles its icons and then errors when resizing them;
        // height 0 frees its space, and the clip and opacity hide what is left.
        Main.overview.dash.set({height: 0, opacity: 0, clip_to_allocation: true});
        undo.push(() => Main.overview.dash.set({height: -1, opacity: 255, clip_to_allocation: false}));

        if (config.blur) {
            // The overview already sits on a blurred wallpaper, so the top bar
            // doesn't blur it again.
            const panelBlur = blurEffect(Shell.BlurMode.BACKGROUND);
            Main.panel.add_effect(panelBlur);
            Main.overview.connectObject(
                'shown', () => (panelBlur.enabled = false),
                'hiding', () => (panelBlur.enabled = true),
                this);
            const overviewBackground = createOverviewBackground();
            Main.layoutManager.overviewGroup.insert_child_at_index(overviewBackground, 0);
            undo.push(() => {
                Main.overview.disconnectObject(this);
                Main.panel.remove_effect(panelBlur);
                overviewBackground.destroy();
            }, blurPopups());
        }

        undo.push(showPinnedAppsInGrid());
        if (config.confetti)
            undo.push(setupConfetti(this.dir));
        if (config.edgeClick)
            undo.push(setupEdgeClicks(), setupEdgeTooltips());
    }

    disable() {
        // Settings are persistent preferences; only the panel changes need undoing.
        this._undo.reverse().forEach(undo => undo());
        this._undo = null;
    }
}
