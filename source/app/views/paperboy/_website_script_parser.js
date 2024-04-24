var WebsiteScriptParser = {
  matcher: new AsymetricMatcher(EqualMatcher),
  path_matcher: new AsymetricMatcher(PathMatcher),

  match(website_script) {
    var website = website_script.website,
        path = website_script.path;

    return this._matchWebsite(website) && this._matchPath(path);
  },

  _matchPath(path) {
    return this.path_matcher.match(path, window.location.pathname);
  },

  _matchWebsite(website) {
    if (! this.matcher.match(website.domain, window.location.hostname)) {
      return false;
    }

    if (! this.matcher.match(website.port, window.location.port)) {
      return false;
    }

    if (! this.matcher.match(website.protocol, window.location.protocol)) {
      return false;
    }

    return true;
  },
};
