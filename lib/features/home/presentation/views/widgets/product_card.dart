import 'package:flutter/material.dart';
import 'package:forth_session/features/home/domain/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity productEntity;
  const ProductCard({Key? key, required this.productEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ناخد أبعاد الشاشة
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Card(
      color: Color.fromARGB(255, 230, 230, 230),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.03), // padding متناسب مع العرض
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Icon(
                Icons.favorite_border,
                color: Colors.grey,
                size: screenWidth * 0.06,
              ),
            ),
            Expanded(
              child: Image.network(
                productEntity.image ?? "",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productEntity.title ?? "",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.035, // responsive font
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${productEntity.price} \$",
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: screenWidth * 0.032,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                CircleAvatar(
                  radius: screenWidth * 0.05, // حجم الدائرة متناسب مع الشاشة
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: screenWidth * 0.05,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
