import QtQuick 2.7
import QtQuick.Layouts 1.3
import AlgWidgets 2.0
import AlgWidgets.Style 2.0
import "shaderparameterconnect.js" as ShaderConnect

GridLayout {
  id: layout
  columns: 2
  rowSpacing: AlgStyle.defaultSpacing

  function connectParameter(parameter) {
    var components = {
      "ao_intensity": aoIntensity,
      "nbSamples": samplingQuality.item,
      "DebugMode": debugMode,
      "DebugChannel": debugChannel.item
    };
    if (parameter.identifier in components) {
      components[parameter.identifier].parameter = parameter;
    }
  }

  function _initializeLabelComponent(component, labelComponent) {
    // The component triggers its label visibility
    labelComponent.visible = Qt.binding(function() { return component.visible });

    // When a shader parameter is connected, bind values changes
    component.parameterChanged.connect(function() {
      if (!component.parameter) return;

      // Apply the parameter label on the QML label
      var parameter = component.parameter;
      labelComponent.text = parameter.description.label;

      // Connect the QML component to the shader parameter
      ShaderConnect.connectPropertyToShaderParameter(component, "dataValue", parameter);
    });
  }

  // Use a QML Component to avoid duplication when declaring a AlgComboBox
  Component {
    id: comboBoxComponent
    AlgComboBox {
      property var parameter: null

      property var dataValue
      textRole: "label"
      model: parameter? parameter.description.enumValues : {}

      Component.onCompleted: {
        // Bind the index of the selected entry to its real value
        currentIndexChanged.connect(function() {
          dataValue = model[currentIndex].value;
        });
        dataValueChanged.connect(function() {
          for (var i in model) {
            if (model[i].value === dataValue) {
              currentIndex = i;
              break;
            }
          }
        });
      }
    }
  }

  // Ambient occlusion intensity
  AlgSlider {
    id: aoIntensity
    Layout.fillWidth: true
    Layout.columnSpan: 2
    property var parameter: null

    onParameterChanged: {
      if (!parameter) return;
      text = parameter.description.label;
      minValue = parameter.description.min;
      maxValue = parameter.description.max;

    // Connect the QML component to the shader parameter
      ShaderConnect.connectPropertyToShaderParameter(aoIntensity, "value", parameter);
    }
  }

  // Sampling quality combobox
  AlgLabel {
    id: labelSamplingQuality
  }
  Loader {
    Layout.fillWidth: true;
    id: samplingQuality
    sourceComponent: comboBoxComponent
    onLoaded: layout._initializeLabelComponent(item, labelSamplingQuality);
  }

  // Debug mode checkbox
  AlgLabel {
    id: labelDebugMode
  }
  AlgCheckBox {
    Layout.fillWidth: true;
    id: debugMode
    property alias dataValue: debugMode.checked
    property var parameter: null
    Component.onCompleted: layout._initializeLabelComponent(debugMode, labelDebugMode);
  }

  // Debugged channel combobox
  AlgLabel {
    id: labelDebugChannel
  }
  Loader {
    Layout.fillWidth: true;
    id: debugChannel
    sourceComponent: comboBoxComponent
    onLoaded: layout._initializeLabelComponent(item, labelDebugChannel);
    visible: debugMode.checked
  }
}