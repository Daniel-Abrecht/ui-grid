import QtQuick 2.3
import QtQuick.Controls 2.4

Item {
    id: item_view_container
    objectName: "item_view_container"
    width: 496
    height: 800
    clip: true

    property int padding: 8
    property int iconWidth: 64
    readonly property int trueIconWidth: Math.min(this.iconWidth, this.width - this.padding * 2)
    readonly property int items_per_line: Math.max(1, Math.min( item_view.count, Math.floor((this.width - this.padding) / (this.trueIconWidth + this.padding)) ))

    ScrollBar {
        id: scrollbar
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.right: parent.right;
        active: true
    }

    GridView {
        id: item_view
        objectName: "item_view"
        clip: false
        flow: GridView.FlowLeftToRight
        width: this.cellWidth * parent.items_per_line + 2 /* The +2 is to compensate for rounding errors*/
        anchors.top: parent.top
        anchors.topMargin: parent.padding
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.padding
        boundsBehavior: Flickable.DragOverBounds
        flickableDirection: Flickable.VerticalFlick
        anchors.horizontalCenter: parent.horizontalCenter
        interactive: true
        cellWidth: Math.min((parent.width - parent.padding) / parent.items_per_line, (parent.trueIconWidth + parent.padding) * 1.5)
        ScrollBar.vertical: scrollbar

        signal item_clicked(string id)

        ListItem {
            id: example_item
            visible: false
            readonly property string _name: "^w^"
            readonly property string _icon: ""
            readonly property string _source: ""
        }
        cellHeight: example_item.height + parent.padding

        delegate: Item {
            width: item_view.cellWidth
            MouseArea {
                anchors.fill: item_content
                onClicked: item_view.item_clicked(_id)
            }
            ListItem { id: item_content }
        }
    }
}
