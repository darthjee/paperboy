(function(_, angular, Cyberhawk) {
  var app = angular.module("home/controller", [
    "cyberhawk/controller",
    "cyberhawk/notifier",
  ]);


  function Controller(builder, notifier, $location, $timeout, pagination, route) {
    this.construct(builder, notifier, $location, $timeout, pagination, route);
    window.debug = this;
  }

  var fn = Controller.prototype;

  _.extend(fn, Cyberhawk.Controller.prototype);

  app.controller("Scripts.WebsitesController", [
    "cyberhawk_requester", "cyberhawk_notifier", "$location",
    "$timeout",
    "cyberhawk_pagination",
    "$route",
    Controller
  ]);
}(window._, window.angular, window.Cyberhawk));
