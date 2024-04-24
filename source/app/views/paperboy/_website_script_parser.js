class EqualMatcher {
  match(value, target) {
    return value == target;
  }
}

class AsymetricMatcher {
  constructor(matcher) {
    this.matcher = matcher;
  }

  match(value, target) {
    if (!value || value == '') {
      return true
    }
    return this.matcher.match(value, target);
  }
}

var WebsiteScriptParser = {
  matcher: new AsymetricMatcher(new EqualMatcher()),

  match(website_script) {
    var website = website_script.website,
        path = website_script.script.path;

    return this.match_website(website) && this.match_path(path)
  },

  match_path(path) {
    return this.matcher.match(path, window.location.href);
  },

  match_website(website) {
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
}
