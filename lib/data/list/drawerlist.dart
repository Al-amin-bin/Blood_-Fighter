class DrawerListData{
  final String title, imgUrl;
  final int id;

  DrawerListData({this.title = "", this.imgUrl = "",this.id=0,});
}
List drawerList = [

  DrawerListData(
    title: "Blood Request",
    imgUrl: "asset/images/icon/blood.png",
    id: 1,
  ),

  DrawerListData(
    title: "Blood donors",
    imgUrl: "asset/images/icon/blood-donation.png",
    id: 2,
  ),
  DrawerListData(
      title: "Blood Search",
      imgUrl: "asset/images/icon/search.png",
    id: 3,
  ),
  DrawerListData(
    title: "Blood organization",
    imgUrl: "asset/images/icon/teamwork.png",
    id: 4,
  ),

  DrawerListData(
      title: "Ambulance",
      imgUrl: "asset/images/icon/ambulance.png",
    id: 5,
  ),

  DrawerListData(
      title: "Nurse",
      imgUrl: "asset/images/icon/nurse.png",
    id: 6,
  ),
  DrawerListData(
      title: "Emergency",
      imgUrl: "asset/images/icon/svg.png",
    id: 7,
  ),DrawerListData(
      title: "Blog",
      imgUrl: "asset/images/icon/blog.png",
    id: 8,
  ),DrawerListData(
      title: "Profile",
      imgUrl: "asset/images/icon/man.png",
    id: 9,
  ),


];
