(function(_, angular, Cyberhawk) {
  var app = angular.module("scripts/website_controller", [
    'cyberhawk/builder'
  ]);

  var ControllerMethods = {
    _getPath() {
      console.info(this.location.$$path);
      if ( !this.path ) {
        this.path = this.location.$$path.replace(/(\/edit)?$/, "/websites");
      }
      return this.path;
    }
  };

  function Controller(builder) {
    builder.build(this);
  }

  _.extend(Controller.prototype, ControllerMethods);

  app.controller("Scripts.WebsitesController",[
    'cyberhawk_builder', Controller
  ]);
}(window._, window.angular, window.Cyberhawk));
