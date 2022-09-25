import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import AlgWidgets 2.0

ColumnLayout {
  id: root
  spacing: 0
  property alias text: label.text
  property var material: null
  property bool selected: false
  signal clicked()

  Component.onCompleted: {
    button.clicked.connect(clicked)
  }

  Button {
    id: button
    width: 50
    height: 50

    property var previewOpacity: selected?
      1 :
      pressed ? 0.2 : 0.6

    style: ButtonStyle {
      padding {
        left: 0
        right: 0
        top: 0
        bottom: 0
      }
      background: Rectangle{
        visible: false
      }
    }

    Image {
      mipmap: true
      cache: false
      anchors.fill: parent
      fillMode: Image.PreserveAspectFit
      opacity: button.previewOpacity
      visible: root.material && root.material.value
      source: "image://resources/" + ((root.material && root.material.value)?
        root.material.value : "")
    }

    Rectangle {
      anchors.fill: parent
      opacity: button.previewOpacity
      visible: !(root.material && root.material.value)
      radius: width*0.5
      color : "#111"
    }

    Rectangle {
      anchors.fill: parent
      visible: selected
      border.color: "#000"
      border.width: 1
      color: "transparent"
      opacity: 0.5
    }
  }
  AlgLabel {
    id: label
    Layout.alignment: Qt.AlignHCenter
  }
}
