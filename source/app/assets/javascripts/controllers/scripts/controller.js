(function(_, angular, Cyberhawk) {
  var app = angular.module("scripts/controller", [
    'cyberhawk/builder'
  ]);

  var ControllerMethods = {
    _buildCallback() {
    }
  };

  function Controller(builder) {
    builder.buildAndRequest(this, this._buildCallback);
  }

  _.extend(Controller.prototype, ControllerMethods);

  app.controller("Scripts.Controller",[
    'cyberhawk_builder', Controller
  ]);
}(window._, window.angular, window.Cyberhawk));
