import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Particles 2.0
import QtGraphicalEffects 1.0
ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    id:root
    color: "black"
    Image{
        id: car
        source:"../Resources/liquid_crystal_panel.png"
        anchors.fill: parent
        smooth: true
    }
    Rectangle{
            id:pointer
            x:(root.width-pointer.width)/2
            y:(root.height/2-pointer.height)
            transform: Rotation{
                id: rotate
                origin.x:pointer.width/2
                origin.y:pointer.height
                angle: 20
            }
            width: 22
            height: 216
            color:"transparent"
        Image{
            id:pointer_image
            source:"../Resources/pointer_main.png"
           // anchors.top: parent.top
            y:25
            width:17
            height:77
        }
        ParticleSystem {
                id: particles
                running: true
            }

            ImageParticle {
                system: particles
                source: "../Resources/star.png"
                alpha: 0.1
                colorVariation: 0.6
            }

            Emitter {
                id: emmiter
                system: particles

                size: 36;
                sizeVariation: 10;
                emitRate: 20;
                lifeSpan: 4000;
                lifeSpanVariation: 200;
                x:  pointer.width/2
                y:  pointer_image.y
                velocity: PointDirection {xVariation: 8; yVariation: 8;}
                acceleration: PointDirection {xVariation: 12; yVariation: 12;}
    //            velocity: TargetDirection {
    //                targetItem: target;
    //                targetX: target.width/2;
    //                targetY: 0;
    //                targetVariation: target.width/2;
    //                magnitude: root.height/3;
    //            }
            }
    }

    MouseArea {
          anchors.fill: parent
          onClicked: particles.running = !particles.running
      }
    Timer{
       interval: 50
       repeat: true
       running: true
       property bool positive: true
       onTriggered:{
           if(positive)
           {
               rotate.angle+=1;
               if(rotate.angle>120)
               {
                   positive=false;
               }
           }
           else
           {
               rotate.angle-=1;
               if(rotate.angle<-120)
               {
                   positive=true;
               }
           }
       }
    }
    property int velAngle: 0
    Rectangle {
            id: target;
            color: "transparent";
            width: parent.width/2;
            height: 100;
            anchors.top: parent.top;
            anchors.right: parent.right;
            anchors.margins: 4;
        }

}
