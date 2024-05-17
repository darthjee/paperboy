(function(_, angular, Cyberhawk) {
  var app = angular.module("scripts/website_controller", [
    'cyberhawk/builder'
  ]);

  var ControllerMethods = {
  };

  function Controller(builder) {
    builder.build(this);
  }

  _.extend(Controller.prototype, ControllerMethods);

  app.controller("Scripts.WebsitesController",[
    'cyberhawk_builder', Controller
  ]);
}(window._, window.angular, window.Cyberhawk));
