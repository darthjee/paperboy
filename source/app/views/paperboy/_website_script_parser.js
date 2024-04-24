EqualMatcher = {
  match(value, target) {
    return value == target;
  }
};

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

class PathMatcher {
  constructor(value) {
    value ||= "";

    this.regexp = new RegExp(value.replace("*", ".*"));
  }

  match(target) {
    return target.match(this.regexp);
  }
}

PathMatcher.match = function(value, target) {
  return new this(value).match(target);
}

var WebsiteScriptParser = {
  matcher: new AsymetricMatcher(EqualMatcher),
  path_matcher: new AsymetricMatcher(new PathMatcher()),

  match(website_script) {
    var website = website_script.website,
        path = website_script.script.path;

    return this.match_website(website) && this.match_path(path)
  },

  match_path(path) {
    return this.path_matcher.match(path, window.location.href);
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
