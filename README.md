# ui-grid

The ui-grid application displays a grid of labeled icons.
It is designed to be easily integratable into other applications & supports xembed.

The things to be displayed are read from stdin. The protocol is as follows:

 * If the line starts with `{` it is interpreted as a json object describind a new icon.
   All properties are optional, but at least one should be specified.
   The object can contain the following properties:
   * `id`: If specified, printed to stdout when the item is clicked on (a json with the properties is printed otherwise). The path is also used as item id.
   * `name`: The label to be displayed below the icon. If no icon is specified, it is assumed that the name is also the icon
   * `icon`: The name of an icon available in the icon theme, or a path to a file for which a fitting icon needs to be choosen
   * `image`: Use the specified image file as icon
   * `desktop`: The path to a .desktop file. If `name` or `icon`/`image` isn't specified, it'll figure them out from the desktop file.
 * If the line doesn't start with `:`, `-` or `{` then it is assumed to be the path to a file.
   If it's a .desktop file, it's parsed to figure out the name and icon.
   Otherwise, it'll use the full file name as `name`, and the whole path/line as `icon`.
 * If the line starts with `:`, it's a command. The only command currently available is `:clear`, which removes all entries
 * If the line starts with `-`, there are items to be removed.
   If a `{` follows, it's a json object specifying which ones.
   Otherwise, the line is assumed to be the items `id`.
   It's generally save to remove an object the same way it was added.

If an item is clicked on, if it has an `id`, that will be printed to stdout.
If it doen't have an id, the other properties are printed to stdout.
If it wasn't added as a json, the line to add it is printed out.

## Usage

    usage: ui-grid [-h] [-e] [--into XID] [--icon-width IWIDTH]
                   [--item-padding IPADDING]

    optional arguments:
      -h, --help                show this help message and exit
      -e, --xid                 Print out xid on first line of stdout
      --into XID, --embed XID   Reparent to window with specified xid
      --icon-width IWIDTH       Width of icons
      --item-padding IPADDING

## Example

Display the files in / and output the path of any file clicked on:

    find / -maxdepth 1 -not -name '.*' | ui-grid

Display installed applications and launch them when clicked on:

    find /usr/share/applications/ -iname "*.desktop" | ui-grid | while read app; do xdg-open "$app"; done

Display some other custom stuff:

    ui-grid <<EOF
    {"name": "Firefox", "icon": "firefox-esr"}
    {"name": "chromium"}
    {"desktop": "/usr/share/applications/galculator.desktop"}
    {"id": 123, "image":"/usr/share/icons/Adwaita/scalable/apps/text-editor-symbolic.svg"}
    {"name": "Folder", "icon": "/"}
    EOF
