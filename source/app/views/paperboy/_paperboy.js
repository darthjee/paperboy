PaperboyUserScript.loadScript = function(url) {
  var scrpt = document.createElement('script');
  scrpt.setAttribute('type','text/javascript');
  scrpt.setAttribute('src', url);
  document.querySelector('head').appendChild(scrpt);
};

PaperboyUserScript.processScript = function(script) {
  if (PathParser.match(script.script.url)) {
    this.loadScript(script.script.url);
  };
};

PaperboyUserScript.listScripts = function(tag) {
  var localUrl = window.location.origin,
    request = new XMLHttpRequest(),
    url = '<%= website_scripts_url(format: :json, url: '--URL--') %>'

  request.overrideMimeType("application/json");
  request.responseType = 'json';
  request.open('GET', url.replace(/--URL--/, location.origin));

  request.onload  = function() {
    PaperboyUserScript.parseResponse(request);
  };
  request.send(null);
};

PaperboyUserScript.parseResponse = function(request) {
  var index,
    scripts = request.response;

  for (var index = 0; index < scripts.length; index ++) {
    this.processScript(scripts[index]);
  }
};
