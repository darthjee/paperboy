class ScriptLoader {
  constructor(path, func) {
    this.path = path;
    this.func = func;
  }

  _match() {
    return PathParser.match(path, window.location.pathname);
  }

  call() {
    if (! this._match()) { return; }
    if (this.loaded) { return; }

    this.func.call();

    this.loaded = true;;
  }
}

ScriptLoader.load = function(path, func) {
  new ScriptLoader(path, func).call();
};
