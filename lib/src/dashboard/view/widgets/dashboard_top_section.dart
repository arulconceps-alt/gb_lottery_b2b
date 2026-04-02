import 'package:flutter/material.dart';

class DashboardTopSection extends StatelessWidget {
  const DashboardTopSection({super.key});

  @override
  Widget build(BuildContext context) {
     final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal:  s(32)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
               Container(
                height: s(42),
                width: s(165.5),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/dashboard/welcome.webp"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: s(9)),
               Padding(
                 padding:  EdgeInsets.symmetric(horizontal:  s(3)),
                 child: Container(
                  height: s(6),
                  width: s(120.5),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/dashboard/one_wallet.webp"),
                      fit: BoxFit.cover,
                    ),
                  ),
                               ),
               ),
            ],
          ),
      
          const SizedBox(width: 40.5),
      
          Column(
            children:  [
             Container(
                height: s(86),
                width: s(106),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/dashboard/gb_logoo.webp"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class FirstColumnImage extends StatelessWidget {
  final String imagePath;

  const FirstColumnImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
