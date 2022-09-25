import QtQuick 2.7
import QtQuick.Layouts 1.3
import Painter 1.0
import AlgWidgets 2.0
import AlgWidgets.Style 2.0

Rectangle {
  id: root
  color: AlgStyle.background.color.mainWindow
  width: 100
  height: mainLayout.height

  onHeightChanged: {
    if (height != mainLayout.height) {
      height = Qt.binding(function() {return mainLayout.height});
    }
  }

  property string displayedMaterial: ""
  property var materialsModel: {}

  function displayShaderParameters(shaderId) {
    try {
      // Retrieve the list of each shader parameters with its full description for each one
      var parameters = alg.shaders.parameters(shaderId);
      var materials = alg.shaders.materials(shaderId);

      var model = {};
      for (var i in materials) {
        model[materials[i].description.label] = {'material': materials[i], 'parameters': []};
      }

      // For each parameter, connect it to a QML component inside the
      // common parameters group or a material parameters group
      for (var i in parameters) {
        var parameter = parameters[i];
        if (parameter in materials) continue;
        var group = "group" in parameter.description? parameter.description.group : "";
        if (group in model) {
          model[group].parameters.push(parameter);
        }
        else {
          commonParameters.connectParameter(parameter);
        }
      }

      // Order parameters by the order of declaration in the shader
      for(var i in model) {
        model[i].parameters.sort(function(a,b) { return a.indexInShader-b.indexInShader })
      }
      materialsModel = Object.keys(model).map(function(v) { return model[v] })
        .sort(function(a,b) { return a.material.indexInShader-b.material.indexInShader });
      displayedMaterial = materialsModel[0].material.description.label;
    }
    catch(e) {
      alg.log.error(e.message);
    }
  }

  ColumnLayout {
    id: mainLayout
    width: parent.width
    spacing: AlgStyle.defaultSpacing

    AlgGroupWidget {
      text: "Common parameters"
      activeScopeBorder: true
      Layout.fillWidth: true
      toggled: true

      CommonParameters {
        Layout.fillWidth: true
        id: commonParameters
      }
    }

    AlgScrollView {
      Layout.fillWidth: true
      Layout.preferredHeight: contentHeight + bottomMargin

      RowLayout {
        Layout.fillWidth: true

        Repeater {
          model: materialsModel
          delegate: MaterialPreview {
            material: modelData.material
            text: modelData.material.description.label
            selected: displayedMaterial == text
            onClicked: {
              displayedMaterial = text;
              materialsGroup.toggled = true;
            }
          }
        }
      }
    }

    AlgGroupWidget {
      id: materialsGroup
      text: displayedMaterial + " parameters"
      activeScopeBorder: true
      Layout.fillWidth: true
      toggled: true

      ColumnLayout {
        Layout.fillWidth: true
        spacing: AlgStyle.defaultSpacing

        Repeater {
          model: materialsModel
          delegate: MaterialParameters {
            Layout.fillWidth: true
            visible: modelData.material.description.label == displayedMaterial
            materialData: modelData
          }
        }
      }
    }
  }
}
