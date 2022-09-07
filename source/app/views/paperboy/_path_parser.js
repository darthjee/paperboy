var PathParser = {
  match(path) {
    if (!path) {
      return true
    }

    return window.location.href == path;
  }
};
