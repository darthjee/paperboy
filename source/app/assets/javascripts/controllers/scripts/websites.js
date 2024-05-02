(function(_, angular, Cyberhawk) {
  var app = angular.module("scripts/website_controller", [
    'cyberhawk/builder'
  ]);

  function Controller(builder) {
    builder.build(this);
  }

  app.controller("Scripts.WebsitesController",[
    'cyberhawk_builder', Controller
  ]);
}(window._, window.angular, window.Cyberhawk));
