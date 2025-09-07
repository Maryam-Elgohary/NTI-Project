import 'package:flutter/material.dart';

class OffersListView extends StatelessWidget {
  const OffersListView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> offersBanner = [
      {"image": "assets/images/image1.png", "discount": "خصم 25%"},
      {"image": "assets/images/image2.png", "discount": "خصم 40%"},
      {"image": "assets/images/image1.png", "discount": "خصم 25%"},
      {"image": "assets/images/image2.png", "discount": "خصم 40%"},
    ];
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return SizedBox(
      height: screenHeight * 0.22, // نسبة من الشاشة
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: offersBanner.length,
        itemBuilder: (context, index) {
          final banner = offersBanner[index];
          return Padding(
            padding: const EdgeInsets.only(left: 16, right: 8),
            child: Container(
              width: screenWidth * 0.4, // العرض نسبي للشاشة
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(banner['image']!),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double parentWidth = constraints.maxWidth;
                      double parentHeight = constraints.maxHeight;
                      return Container(
                        width: parentWidth * 0.65,
                        height: parentHeight,
                        decoration: ShapeDecoration(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100),
                              bottomLeft: Radius.circular(100),
                            ),
                          ),
                          color: Colors.green[500],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'عروض العيد',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.01, // نص نسبي
                                  fontFamily: 'Cairo',
                                ),
                              ),
                              Text(
                                banner["discount"]!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.02, // نص نسبي
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.05,
                                    vertical: screenHeight * 0.005,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text(
                                  "تسوق الآن",
                                  style: TextStyle(
                                    color: Colors.green[500],
                                    fontSize: screenWidth * 0.01,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
