class RemoveProvince {
  static String cancel(String data) {
    return data.replaceAll("Province", "").trim();
  }
}
