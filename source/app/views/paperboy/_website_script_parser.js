var WebsiteScriptParser = {
  match(website_script) {
    var website = website_script.website,
        path = website_script.script.path;

    return this.match_website(website) && this.match_path(path)
  },

  match_path(path) {
    return this.asymetric_match(path, window.location.href);
  },

  match_website(website) {
    if (! this.asymetric_match(website.domain, window.location.hostname)) {
      return false;
    }

    if (! this.asymetric_match(website.port, window.location.port)) {
      return false;
    }

    if (! this.asymetric_match(website.protocol, window.location.protocol)) {
      return false;
    }

    return true;
  },

  asymetric_match(nullable_string, target) {
    if (!nullable_string || nullable_string == '') {
      return true
    }

    return nullable_string == target;
  }
}
