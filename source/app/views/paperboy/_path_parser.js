var PathParser = {
  match(path) {
    if (!path) {
      return true
    }

    return window.location.href == path;
  }
};

PaperboyUserScript.match = function(path) {
  return PathParser.match(path);
}

PaperboyUserScript.checkAndRun = function(path, func) {
  if (PathParser.match(path)) {
    func.call()
  }
};
