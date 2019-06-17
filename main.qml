import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ApplicationWindow {
    id: root

    readonly property int rows: rowsSpinBox.value
    readonly property int columns: columnsSpinBox.value
    readonly property int countOfObjects: rows * columns

    readonly property bool toggleMode: toggleModeButton.checked
    readonly property bool swapMode: swapModeButton.checked

    readonly property int objectWidth: width * 0.6 / columns
    readonly property int objectHeight: height * 0.6 / rows

    width: 920
    height: 480

    title: qsTr("Hello World")

    visible: true

    header: ToolBar {
        RowLayout {
            anchors.fill: parent

            RowLayout {
                Layout.fillHeight: true
                Layout.fillWidth: true

                RowLayout {
                    Label {
                        text: "Rows"
                    }

                    SpinBox {
                        id: rowsSpinBox

                        from: 1
                        to: 5
                    }
                }

                RowLayout {
                    Label {
                        text: "Columns"
                    }

                    SpinBox {
                        id: columnsSpinBox

                        from: 1
                        to: 6
                    }
                }
            }

            RowLayout {
                Layout.fillHeight: true
                Layout.fillWidth: true

                Label {
                    text: "Mode:"
                }

                ButtonGroup {
                    buttons: [toggleModeButton, swapModeButton]
                }

                RadioButton {
                    id: toggleModeButton

                    checked: true
                    text: "Toggle"
                }

                RadioButton {
                    id: swapModeButton

                    text: "Swap"
                }
            }
        }

    }

    Item {
        anchors.centerIn: parent

        height: parent.height * 0.6
        width: parent.width * 0.6

        GridLayout {
            id: gridLayout

            property bool anyObjectClicked: false
            property Item firstObject: null
            property Item secondObject: null

            function swapObjects(firstObject, secondObject) {
                var row = firstObject.row;
                var column = firstObject.column;
                firstObject.row = secondObject.row;
                firstObject.column = secondObject.column;
                secondObject.row = row;
                secondObject.column = column;
                firstObject.down = false;
                secondObject.down = false;
            }

            anchors.fill: parent

            Repeater {
                id: objectRepeater

                Layout.alignment: Qt.AlignCenter

                model: root.countOfObjects

                delegate: Object {
                    id: object

                    Layout.alignment: Qt.AlignCenter

                    Layout.row: row
                    Layout.column: column

                    implicitWidth: Math.min(root.objectWidth, root.objectHeight)
                    implicitHeight: Math.min(root.objectWidth, root.objectHeight)

                    row: index / root.columns
                    column: index - root.columns * row

                    labelText: index

                    toggleMode: root.toggleMode
                    swapMode: root.swapMode

                    onClicked: {
                        if (root.swapMode) {
                            object.down = true;
                            if (!gridLayout.anyObjectClicked) {
                                gridLayout.anyObjectClicked = true;
                                gridLayout.firstObject = object;
                            }
                            else {
                                gridLayout.secondObject = object;
                                gridLayout.swapObjects(gridLayout.firstObject, gridLayout.secondObject);
                                gridLayout.anyObjectClicked = false;
                            }
                        }
                        else if (root.toggleMode) {
                            object.active = !object.active;
                        }
                    }
                }
            }
        }
    }
}
