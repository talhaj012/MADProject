import 'package:authentication/pages/user/categories.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int activeIndex = 0;
  final urlImages = [
    'https://images.unsplash.com/photo-1528716321680-815a8cdb8cbe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bW90aXZhdGlvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1564410267841-915d8e4d71ea?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bW90aXZhdGlvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=700&q=60',
    'https://images.unsplash.com/photo-1589561253898-768105ca91a8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8bW90aXZhdGlvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=700&q=60',
    'https://images.unsplash.com/photo-1556711905-4bd1b6603275?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fG1vdGl2YXRpb258ZW58MHx8MHx8&auto=format&fit=crop&w=700&q=60',
    'https://images.unsplash.com/photo-1537444532052-2afbf769b76c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8bW90aXZhdGlvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=700&q=60',

  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Text('A New Day, A New Motivation!!',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,

          ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20, bottom: 20),
          child: CarouselSlider.builder(
            options: CarouselOptions(
                height: 450.0,
                autoPlay: true,
                // autoPlayInterval: Duration(seconds: 2),
                // viewportFraction: 1,
                enlargeCenterPage: true,
              onPageChanged: (index, reason) =>
                  setState(() => activeIndex = index)
            ),
            itemCount: urlImages.length,
            itemBuilder: (context, index, realIndex ){
              final urlImage = urlImages[index];

              return buildImage(urlImage,index);
            },
          ),
        ),

        buildIndicator(),

        Categories(),
      ],
    );
  }

  Widget buildImage(String urlImage, int index){
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        color: Colors.grey,
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
        ),
      );
  }


  Widget buildIndicator(){
    return AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: urlImages.length,
        effect: ExpandingDotsEffect(
          dotWidth: 20,
          dotColor: Colors.grey,
          dotHeight: 20,
          activeDotColor: Colors.purple,
        )
    );
  }

}
