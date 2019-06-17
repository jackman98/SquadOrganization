import QtQuick 2.12
import QtQuick.Controls 2.12

MouseArea {
    id: root

    property string labelText: ""
    property int row: 0
    property int column: 0

    property bool toggleMode: true
    property bool swapMode: false
    property bool down: false
    property bool active: true

    width: 100
    height: 100

    Rectangle {
        id: background

        anchors.centerIn: parent

        width: parent.width
        height: parent.height

        radius: width / 2
        color: "#34c92c"

        visible: root.active

        Label {
            anchors.centerIn: parent

            text: root.labelText
        }
    }

    Image {
        id: image

        anchors.centerIn: parent
        anchors.verticalCenterOffset: -3

        width: root.width / 100 * 153
        height: root.width / 100 * 153

        source: "qrc:/images/perecherknutyj-belyj-krug-758.png"

        visible: !root.active
    }

    states: [
        State {
            name: "down"
            when: root.down
            PropertyChanges {
                target: background
                width: root.width * 1.25
                height: root.height * 1.25
            }
            PropertyChanges {
                target: image
                width: root.width / 100 * 153 * 1.25
                height: root.width / 100 * 153 * 1.25
            }
        }
    ]

    transitions: Transition {
        PropertyAnimation {
            properties: "width, height"
            duration: 200
        }
    }
}
