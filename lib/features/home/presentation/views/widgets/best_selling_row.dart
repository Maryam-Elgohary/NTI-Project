import 'package:flutter/material.dart';

class Most_Row extends StatelessWidget {
  const Most_Row({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 229,
      children: [
        Text(
          'الأكثر مبيعًا',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: const Color(0xFF0C0D0D) /* Grayscale-950 */,
            fontSize: 16,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          'المزيد',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: const Color(0xFF949D9E) /* Grayscale-400 */,
            fontSize: 13,
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w400,
            height: 1.60,
          ),
        ),
      ],
    );
  }
}
