(function(angular, _) {
  var module = angular.module('home/controller', ['cyberhawk']);

  module.config(['cyberhawkProvider', function(provider) {
    var Controller = provider.$get().controller;
  }]);
}(window.angular, window._));
