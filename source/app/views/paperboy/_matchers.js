var EqualMatcher = {
  match(value, target) {
    return value.toString() === target.toString();
  }
};

class AsymetricMatcher {
  constructor(matcher) {
    this.matcher = matcher;
  }

  match(value, target) {
    if (!value || value.toString() === '') {
      return true;
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
