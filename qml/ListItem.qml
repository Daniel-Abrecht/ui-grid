import QtQuick 2.3

Column {
  id: list_item
  width: item_view_container.trueIconWidth
  clip: true
  spacing: 5
  anchors.horizontalCenter: parent.horizontalCenter

  Image {
      width: parent.width
      height: parent.width
      source: _source ? _source : "image://icon/" + this.width + 'x' + this.height + "/" + _icon
      fillMode: Image.PreserveAspectFit
      anchors.horizontalCenter: parent.horizontalCenter
  }
    
  Text {
    text: _name
    clip: true
    textFormat: Text.PlainText
    elide: Text.ElideRight
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
    wrapMode: Text.NoWrap
    width: parent.width
    color: '#FFFFFF'
  }
}
