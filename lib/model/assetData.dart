class PreventionData {
  PreventionData({this.name, this.image});

  final String name;
  final String image;
}

List<PreventionData> prevention = [
  PreventionData(
    name: "Wash Hands",
    image: "assets/prevention/handwash.png",
  ),
  PreventionData(
    name: "Wear Mask",
    image: "assets/prevention/mask.png",
  ),
  PreventionData(
    name: "Social Distancing",
    image: "assets/prevention/social.png",
  ),
  PreventionData(
    name: "Get Vaccinated",
    image: "assets/prevention/hospital.png",
  ),
];
