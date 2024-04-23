var PathParser = {
  match(path) {
    return AsymetricMatcher.match(path, window.location.href);
  }
};

var WebsiteParser = {
  match(website) {
    if (! AsymetricMatcher.match(website.domain, window.location.hostname)) {
      return false;
    }

    return true;
  }
};

var AsymetricMatcher = {
  match(nullable_string, target) {
    if (!nullable_string || nullable_string == '') {
      return true
    }

    return nullable_string == target;
  }
}
