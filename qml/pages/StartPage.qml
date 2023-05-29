import QtQuick 2.0
import Sailfish.Silica 1.0


Item {
    width: 400
    height: 400

    Canvas {
        id: canvas
        anchors.fill: parent

        property int pointSize: 50
        property var points: [
            { x: 50, y: 50, color: "red", isSelected: false },
            { x: 150, y: 150, color: "blue", isSelected: false },
            { x: 250, y: 250, color: "green", isSelected: false }
        ]

        function drawPoint(ctx, point) {
            ctx.fillStyle = point.color;
            ctx.fillRect(point.x - (pointSize / 2), point.y - (pointSize / 2), pointSize, pointSize);

            if (point.isSelected) {
                ctx.strokeStyle = "black";
                ctx.lineWidth = 5;
                ctx.strokeRect(point.x - (pointSize / 2) - 2, point.y - (pointSize / 2) - 2, pointSize + 4, pointSize + 4);
            }
        }

        onPaint: {
            var ctx = getContext("2d");
            ctx.clearRect(0, 0, canvas.width, canvas.height);

            for (var i = 0; i < points.length; i++) {
                var point = points[i];
                drawPoint(ctx, point);
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            var mouseX = mouse.x;
            var mouseY = mouse.y;

            for (var i = 0; i < canvas.points.length; i++) {
                var point = canvas.points[i];
                var x = point.x - (canvas.pointSize / 2);
                var y = point.y - (canvas.pointSize / 2);

                if (mouseX >= x && mouseX <= x + canvas.pointSize && mouseY >= y && mouseY <= y + canvas.pointSize) {
                    point.isSelected = true;
                    console.log("Clicked color:", point.color);
                } else {
                    point.isSelected = false;
                }
            }

            canvas.requestPaint();
        }
    }
}
