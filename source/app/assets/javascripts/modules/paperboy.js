(function(angular) {
  var module = angular.module('paperboy', [
    'global',
    'cyberhawk',
    'johto',
    'home',
    'login',
    'scripts'
  ]);

  module.config(['$httpProvider', function($httpProvider) {
    $httpProvider.defaults.headers.patch = {
      'Content-Type': 'application/json;charset=utf-8'
    };
  }]);
}(window.angular));
