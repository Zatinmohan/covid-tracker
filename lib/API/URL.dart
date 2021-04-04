class URLs {
  static String baseUrl = "https://covid19.mathdro.id/api/";

  static String getState(String country) {
    return baseUrl + "countries" + "/" + country + "/confirmed";
  }

  static String getCountry(String country) {
    return baseUrl + "countries" + "/" + country;
  }
}
