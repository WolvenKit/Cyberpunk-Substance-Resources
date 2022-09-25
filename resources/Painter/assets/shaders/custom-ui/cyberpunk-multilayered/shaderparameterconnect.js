// Block signals while applying a function on a QML component
// @param qmlComponent QML component to protect
// @param fn Function to protect
function protectSignalRetroAction(qmlComponent, fn) {
  return function() {
    var state = qmlComponent.state;
    if (state == "blockSignals") return;
    qmlComponent.state = "blockSignals";
    fn();
    qmlComponent.state = state;
  };
}

// Connect a shader parameter to the property of a QML component
// @param qmlComponent QML component
// @param propertyKey QML component key to bind
// @param shaderParameter Shader parameter object
function connectPropertyToShaderParameter(qmlComponent, propertyKey, shaderParameter) {
  // Set QML property to the current parameter value
  qmlComponent[propertyKey] = shaderParameter.value;

  // When the QML property has changed, update shader parameter data
  qmlComponent[propertyKey+"Changed"].connect(protectSignalRetroAction(qmlComponent, function() {
    shaderParameter.value = qmlComponent[propertyKey];
  }));

  // When the shader parameter data has changed, update the QML property
  shaderParameter.valueChanged.connect(protectSignalRetroAction(qmlComponent, function() {
    qmlComponent[propertyKey] = shaderParameter.value;
  }));
}
