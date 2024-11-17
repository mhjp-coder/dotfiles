import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
  id: passwordField
  focus: true
  selectByMouse: true
  placeholderText: "Password"
  placeholderTextColor: config.surface2
  echoMode: TextInput.Password
  passwordCharacter: "•"
  passwordMaskDelay: config.PasswordShowLastLetter
  selectionColor: config.overlay0
  renderType: Text.NativeRendering
  font.family: config.Font
  font.pointSize: config.FontSize
  font.bold: true
  color: config.text
  horizontalAlignment: TextInput.AlignHCenter
  background: Rectangle {
    id: passFieldBackground
    color: config.surface0
    radius: 20
    border.color: config.mauve
    border.width: 1
  }
  states: [
    State {
      name: "focused"
      when: passwordField.activeFocus
      PropertyChanges {
        target: passFieldBackground
        color: config.surface1
      }
    },
    State {
      name: "hovered"
      when: passwordField.hovered
      PropertyChanges {
        target: passFieldBackground
        color: config.surface1
      }
    }
  ]
  transitions: Transition {
    PropertyAnimation {
      properties: "color"
      duration: 300
    }
  }
}
