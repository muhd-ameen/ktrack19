class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent({this.image, this.title, this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
    title: 'Welcome To Pandamus',
    image: 'assets/images/welcome.svg',
    discription: "Pandamus is an Full-Fludged Covid-19 Tracker for Kerala People."
  ),
  UnbordingContent(
    title: 'Real-Time Kerala Covid Updates',
    image: 'assets/images/data.svg',
    discription: "simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the "
  ),
  UnbordingContent(
      title: 'Check Vaccine Slot',
      image: 'assets/images/vaccslot.svg',
      discription: "simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the "
  ),

];
