import QtQuick 2.0

Item {
    id: track

    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.log("asd")
            console.log(redRect.contains(Qt.point(mouse.x, mouse.y)))
        }
    }

    Grid {
        columns: 15
        rows: 15
        rowSpacing: 0

        Rectangle {
            id: redRect
            height: 24
            width: 24
            color: "red"
        }




    }
}
