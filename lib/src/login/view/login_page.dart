// import 'package:flutter/material.dart';
// import 'package:gb_lottery_b2b/src/app/color_palette.dart';
// import 'package:gb_lottery_b2b/src/login/view/widgets/login_form_card.dart';
// import 'package:google_fonts/google_fonts.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   @override
//   Widget build(BuildContext context) {
//     final w = MediaQuery.of(context).size.width;
//     final scale = w / 375;
//     double s(double v) => v * scale;

//     return Scaffold(
//       backgroundColor: ColorPalette.background,
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: Column(
//                 children: [
//                   SizedBox(height: s(60)),

//                   /// Small Logo
//                   Image.asset(
//                     "assets/images/login/group.webp",
//                     width: s(72),
//                     height: s(50),
//                   ),

//                   SizedBox(height: s(8)),

//                   /// Main Logo
//                   Image.asset(
//                     "assets/images/login/logo.webp",
//                     width: s(167),
//                     height: s(82),
//                   ),

//                   SizedBox(height: s(18)),

//                   /// Title
//                   Text(
//                     "Welcome Dealer",
//                     style: GoogleFonts.dmSans(
//                       fontSize: s(26),
//                       color: ColorPalette.whitetext,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),

//                   SizedBox(height: s(7)),

//                   /// Subtitle
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: s(40)),
//                     child: Text(
//                       "Manage your lottery business, tickets, and\ncustomers in one place",
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.dmSans(
//                         fontSize: s(14),
//                           fontWeight: FontWeight.w400,
//                         color: ColorPalette.darktext,
//                       ),
//                     ),
//                   ),
//                   // SizedBox(height: s(32)),

//                   //  LoginFormCard(scale: scale),
//                 ],
//               ),
//             ),

//             LoginFormCard(scale: scale),
//           ],
//         ),
//       ),
//     );
//   }
// }