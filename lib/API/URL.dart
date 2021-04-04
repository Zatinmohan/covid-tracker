class URLs {
  static String baseUrl = "https://covid19.mathdro.id/api/";

  static String getSummary(String country) {
    return baseUrl + "countries" + "/" + country + "/confirmed";
  }
}
