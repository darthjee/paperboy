(function(_, angular, Cyberhawk) {
  var app = angular.module("scripts/website_controller", [
    'cyberhawk/builder'
  ]);

  var ControllerMethods = {
    _getPath() {
      if ( !this.path ) {
        this.path = this.location.$$path.replace(/(\/edit)?$/, "/websites");
      }
      return this.path;
    },

    _buildCallback() {
    }
  };

  function Controller(builder) {
    builder.buildAndRequest(this, this._buildCallback);
  }
  Controller.namee = "webites_script"

  _.extend(Controller.prototype, ControllerMethods);

  app.controller("Scripts.WebsitesController",[
    'cyberhawk_builder', Controller
  ]);
}(window._, window.angular, window.Cyberhawk));
