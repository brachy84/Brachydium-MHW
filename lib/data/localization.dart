
mixin Localized {
  String get localizedName;

  bool matchesSearch(String searchValue) {
    return localizedName.toLowerCase().contains(searchValue);
  }

  int compareForSearch(Localized b, String searchValue) {
    var sa = localizedName.toLowerCase().startsWith(searchValue);
    var sb = b.localizedName.toLowerCase().startsWith(searchValue);
    if (sa && !sb) return -1;
    if (!sa && sb) return 1;
    return 0;
  }
}
