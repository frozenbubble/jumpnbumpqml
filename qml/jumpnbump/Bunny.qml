import QtQuick 2.0

Item {
    property string name
    property string imageSource
    property double velocity
    property bool canJump
    property int groundLevel
    property bool moving
    property var keys:{"up":false, "left":false, "right":false}

    id:bunny

    AnimatedImage {
        anchors.centerIn: parent
        id: gif
        source: imageSource
        paused: true
    }

    states: [
        State{
            name: "OnGround"

            PropertyChanges {
                target: bunny
                y: bunny.groundLevel
            }
        },

        State{
            name: "Jumping"

            PropertyChanges {
                target: bunny
                y: bunny.groundLevel - 60
            }
        }
    ]

    transitions: [
        Transition {
            from: "OnGround"
            to: "Jumping"

            SequentialAnimation{
                NumberAnimation {target: bunny; properties:"y" ;duration: 400; easing.type: Easing.OutQuad}
                ScriptAction{ script:{ bunny.state = "OnGround"; gif.currentFrame = 3}}
            }
        },

        Transition {
            from: "Jumping"
            to: "OnGround"

            SequentialAnimation {
                NumberAnimation {target: bunny; properties:"y"; duration: 400; easing.type: Easing.InQuad}
                ScriptAction {script: {gif.currentFrame = 4; gif.paused = !keys["left"] && !keys["right"]}}
            }
        }
    ]

    function jump() {
        console.log(name + " jumps")
        state="Jumping"
        gif.paused = true
        gif.currentFrame = 2
    }

    function stop() {
        gif.paused = true
    }

    function start() {
        gif.paused = false
    }

    function moveLeft(){
        gif.mirror = true
        bunny.x = bunny.x - 10
        moving = true
    }

    function moveRight(){
        gif.mirror = false
        bunny.x = bunny.x + 10
    }

    Behavior on x {
        SmoothedAnimation {velocity: 200}
    }
}
