import QtQuick 2.7
import QtQuick.Layouts 1.3
import AlgWidgets 2.0
import AlgWidgets.Style 2.0
import "shaderparameterconnect.js" as ShaderConnect

ColumnLayout {
  property var materialData: null
  spacing: AlgStyle.defaultSpacing

  AlgResourceWidget {
    id: resourceWidget
    Layout.fillWidth: true
    visible: !!parameter
    property var parameter: materialData? materialData.material : null
    filters: AlgResourcePicker.DECAL | AlgResourcePicker.TEXTURE | AlgResourcePicker.FILTER |
             AlgResourcePicker.MATERIAL | AlgResourcePicker.PRESET_MATERIAL;
    refineQuery: "u:material Cyberpunk";
    defaultLabel: "Select material " + (parameter? parameter.description.label : "")

    onParameterChanged: {
      if (!parameter) return;
      // Connect the QML component to the shader parameter
      requestUrl(parameter.value);
      urlChanged.connect(ShaderConnect.protectSignalRetroAction(resourceWidget, function() {
        parameter.value = url;
      }));
      parameter.valueChanged.connect(ShaderConnect.protectSignalRetroAction(resourceWidget, function() {
        requestUrl(parameter.value);
      }));
    }
  }

  // As materials parameters are only sliders, we just repeat 4 sliders
  // and affect a shader parameter object on each one
  Repeater {
    model: materialData.parameters
    delegate: AlgSlider {
      id: slider
      Layout.fillWidth: true
      visible: !!modelData
      text: modelData.description.label
      minValue: modelData.description.min
      maxValue: modelData.description.max

      Component.onCompleted: { // Connect the QML component to the shader parameter
        ShaderConnect.connectPropertyToShaderParameter(slider, "value", modelData);
      }
    }
  }
}
