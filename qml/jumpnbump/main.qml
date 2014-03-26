import QtQuick 2.0

Rectangle {
    property var bunnies: [dott, jiffy]

    width: 360
    height: 360
    focus: true

    Keys.onPressed: {
        if (event.key === Qt.Key_Up){
            dott.keys["up"] = true
        }

        if (!event.isAutoRepeat) {

            if (event.key === Qt.Key_Left){
                dott.start()
                dott.keys["left"] = true
            }

            if (event.key === Qt.Key_Right){
                dott.start()
                dott.keys["right"] = true
            }

            if (event.key === Qt.Key_W){
                jiffy.keys["up"] = true
            }

            if (event.key === Qt.Key_A){
                jiffy.keys["left"] = true
                jiffy.start()
            }

            if (event.key === Qt.Key_D){
                jiffy.keys["right"] = true
                jiffy.start()
            }
        }
        event.accepted = true;
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Up){
            dott.keys["up"] = false
        }

        if (!event.isAutoRepeat) {

            if (event.key === Qt.Key_Left){
                dott.stop()
                dott.keys["left"] = false
            }

            if (event.key === Qt.Key_Right){
                dott.stop()
                dott.keys["right"] = false
                console.log(!dott.keys["left"])
            }

            if (event.key === Qt.Key_W){
                jiffy.keys["up"] = false
            }

            if (event.key === Qt.Key_A){
                jiffy.keys["left"] = false
                jiffy.stop()
            }

            if (event.key === Qt.Key_D){
                jiffy.keys["right"] = false
                jiffy.stop()
            }
        }

        event.accepted = true;
    }

    Track {
        anchors.fill: parent
    }

    Bunny {
        id: dott
        name: "dott"
        imageSource: "qrc:///images/assets/dott2.gif"
        x: 100; y: 100;
        groundLevel: 100
        state: "OnGround"
    }

    Bunny {
        id: jiffy
        name: "jiffy"
        imageSource: "qrc:///images/assets/jiffy2.gif"
        x: 100; y: 100;
        groundLevel: 100
        state: "OnGround"
    }

    Timer {
        running: true
        repeat: true
        interval: 50

        onTriggered: {
            for (var i = 0; i < bunnies.length; i++) {
                var rabbit = bunnies[i]

                if(rabbit.keys["left"]) {
                    rabbit.moveLeft()
                }

                if(rabbit.keys["right"]) {
                    rabbit.moveRight()
                }

                if(rabbit.keys["up"] && rabbit.state !== "Jumping" && rabbit.y === rabbit.groundLevel) {
                    rabbit.jump()
                }
            }
        }
    }

}
