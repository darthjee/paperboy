var PathParser = {
  match(path) {
    if (!path || path == '') {
      return true
    }

    return window.location.href == path;
  }
};
