(function(_, angular, Cyberhawk) {
  var app = angular.module("scripts/website_controller", [
    'cyberhawk/builder'
  ]);

  app.controller("Scripts.WebsitesController",[
    'cyberhawk_builder', function(builder) { builder.build(this); }
  ]);
}(window._, window.angular, window.Cyberhawk));
