import 'package:flutter/material.dart';
import 'package:forth_session/core/helps%20functions/getUserData.dart';

class HelloNotifyRow extends StatelessWidget {
  const HelloNotifyRow({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Row(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: screenWidth * 0.02,
          children: [
            CircleAvatar(
              radius: screenWidth * 0.05, // صورة بروفايل أكبر شوية
              backgroundImage: const NetworkImage(
                "https://thaka.bing.com/th?q=Profile+Logo+Cute&w=120&h=120&c=1&rs=1&qlt=70&o=7&cb=1&dpr=1.5&pid=InlineBlock&rm=3&mkt=en-XA&cc=EG&setlang=en&adlt=strict&t=1&mw=247",
              ),
            ),
            Column(
              spacing: screenHeight * 0.005,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateTime.now().hour < 12
                      ? 'صباح الخير !..'
                      : 'مساء الخير !..',

                  style: TextStyle(
                    color: const Color(0xFF949D9E),
                    fontSize: screenWidth * 0.035, // متناسب مع العرض
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                  ),
                ),
                Text(
                  getUser().name,
                  style: TextStyle(
                    color: const Color(0xFF0C0D0D),
                    fontSize: screenWidth * 0.038,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
        const Spacer(),
        Container(
          width: screenWidth * 0.12,
          height: screenWidth * 0.12,
          decoration: const ShapeDecoration(
            color: Color(0xFFEEF8ED),
            shape: CircleBorder(),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.notifications_outlined,
                color: const Color(0xFF1B5E37),
                size: screenWidth * 0.07,
              ),
              Positioned(
                top: screenHeight * 0.02,
                right: screenWidth * 0.048,
                child: Container(
                  width: screenWidth * 0.025,
                  height: screenWidth * 0.025,
                  decoration: const ShapeDecoration(
                    color: Color(0xFFF24035),
                    shape: OvalBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
