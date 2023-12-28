class GenderDta{
  final String title, imgUrl;

  GenderDta({this.title = "", this.imgUrl = "",});
}

List genderList = [
  GenderDta(
    title: "Male",
    imgUrl: "asset/images/icon/man.png"
  ),
  GenderDta(
      title: "Female",
      imgUrl:"asset/images/icon/femaleIcon.png"
  ),

];

List<String> gender = [
  "Select Gender",
  "Male",
  "Female",
  "Others"
];