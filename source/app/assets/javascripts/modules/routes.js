(function(angular) {
  var module = angular.module("paperboy");

  module.config(["kantoProvider", function(provider) {
    provider.defaultConfig = {
      controller: "Cyberhawk.Controller",
      controllerAs: "gnc",
      templateBuilder: function(route, params) {
        return route + "?ajax=true";
      }
    }

    provider.configs = [{
      routes: ["/"],
      config: {
        controller: "Home.Controller",
        controllerAs: "hc"
      }
    }, {
      routes: ["/websites", "/websites/new", "/websites/:id", "/websites/:id/edit"]
    }, {
      routes: ["/scripts", "/scripts/new", "/scripts/:id", "/scripts/:id/edit"]
    }];
    provider.$get().bindRoutes();
  }]);
}(window.angular));

