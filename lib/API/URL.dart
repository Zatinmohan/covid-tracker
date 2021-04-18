class URLs {
  static String baseUrl = "https://covid19.mathdro.id/api/";

  static String getState(String country) {
    if (country == null) return null;
    return baseUrl + "countries" + "/" + country + "/confirmed";
  }

  static String getCountry(String country) {
    if (country == null) return null;
    return baseUrl + "countries" + "/" + country;
  }

  static String getMonthlyList() {
    return baseUrl + "daily";
  }
}
