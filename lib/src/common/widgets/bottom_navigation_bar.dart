// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:gb_lottery_b2b/src/app/color_palette.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_fonts/google_fonts.dart';

// class MainNavigationScreen extends StatelessWidget {
//   final Widget child;
//   final String location;

//   const MainNavigationScreen({
//     super.key,
//     required this.child,
//     required this.location,
//   });

//   int _getIndex(String location) {
//     if (location.startsWith("/dashboard")) return 0;
//     if (location.startsWith("/customer")) return 1;
//     if (location.startsWith("/results")) return 2;
//     if (location.startsWith("/profile")) return 3;
//     return 0;
//   }

//   void _onTap(BuildContext context, int index) {
//     switch (index) {
//       case 0:
//         context.go("/dashboard");
//         break;
//       case 1:
//         context.go("/customer");
//         break;
//       case 2:
//         context.go("/results");
//         break;
//       case 3:
//         context.go("/profile");
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final scale = screenWidth / 375;

//     double s(double v) => v * scale;

//     final index = _getIndex(location);

//     return PopScope(
//       canPop: false,
//       onPopInvokedWithResult: (didPop, result) async {
//         final currentIndex = _getIndex(location);

//         /// not dashboard → go dashboard
//         if (currentIndex != 0) {
//           context.go("/dashboard");
//           return;
//         }

//         final shouldExit = await showDialog<bool>(
//           barrierColor: Colors.transparent,
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               backgroundColor: ColorPalette.whitetext,
//               title: Text(
//                 "Exit App",
//                 style: GoogleFonts.poppins(
//                   fontSize: s(18),
//                   fontWeight: FontWeight.w600,
//                   color: ColorPalette.background,
//                   height: s(1),
//                 ),
//               ),
//               content: Text(
//                 "Do you want to exit?",
//                 style: GoogleFonts.lato(
//                   fontSize: s(14),
//                   fontWeight: FontWeight.w600,
//                   color: ColorPalette.background,
//                   height: s(1),
//                 ),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context, false);
//                   },
//                   child: Text(
//                     "No",
//                     style: GoogleFonts.lato(
//                       fontSize: s(14),
//                       fontWeight: FontWeight.w600,
//                       color: ColorPalette.background,
//                       height: s(1),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: s(86),
//                   height: s(36),
//                   decoration: BoxDecoration(
//                     color: ColorPalette.background,
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                   child: TextButton(
//                     onPressed: () {
//                       Navigator.pop(context, true);
//                     },
//                     style: TextButton.styleFrom(
//                       padding: EdgeInsets.zero,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(s(8)),
//                       ),
//                     ),
//                     child: Text(
//                       "Yes",
//                       style: GoogleFonts.lato(
//                         fontWeight: FontWeight.w600,
//                         fontSize: s(14),
//                         height: 1,
//                         color: ColorPalette.whitetext,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         );

//         if (shouldExit == true) {
//           exit(0);
//         }
//       },

//       child: SafeArea(
//         bottom: true,
//         top: false,
//         child: Scaffold(
//           body: child,

//           bottomNavigationBar: Container(
//            // height: s(49),
//             decoration: BoxDecoration(
//               color:  Color(0xFF1C1B20),
//               boxShadow: [
//                 BoxShadow(
//                   color: const Color(0x19000000).withValues(alpha: .10),
//                   blurRadius: s(2),
//                 ),
//               ],
//             ),
//             child: BottomNavigationBar(
//               currentIndex: index,
//               onTap: (i) => _onTap(context, i),
//               type: BottomNavigationBarType.fixed,

//               backgroundColor:  Color(0xFF1C1B20),
//               elevation: 0,

//               selectedItemColor: ColorPalette.primary,
//               unselectedItemColor: ColorPalette.darktext,

//               selectedLabelStyle: GoogleFonts.poppins(
//                 fontSize: s(10),
//                  color: ColorPalette.primary,
//                 fontWeight: FontWeight.w400,
//               ),
//               unselectedLabelStyle: GoogleFonts.poppins(
//                 fontSize: s(10),
//                 color: ColorPalette.darktext,
//                 fontWeight: FontWeight.w400,
//               ),

//               items: [
//                 BottomNavigationBarItem(
//                   icon: _navIcon(
//                     context,
//                     "assets/images/dashboard/home.webp",
//                     index == 0,
//                   ),
//                   label: "Home",
//                 ),
//                 BottomNavigationBarItem(
//                   icon: _navIcon(
//                     context,
//                     "assets/images/dashboard/customers.webp",
//                     index == 1,
//                   ),
//                   label: "Customers",
//                 ),
//                 BottomNavigationBarItem(
//                   icon: _navIcon(
//                     context,
//                     "assets/images/dashboard/results.webp",
//                     index == 2,
//                   ),
//                   label: "Results",
//                 ),
//                 BottomNavigationBarItem(
//                   icon: _navIcon(
//                     context,
//                     "assets/images/dashboard/profile.webp",
//                     index == 3,
//                   ),
//                   label: "Profile",
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _navIcon(BuildContext context, String asset, bool selected) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final scale = screenWidth / 440;

//     double s(double v) => v * scale;

//     return SizedBox(
//       width: s(72),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Image.asset(
//             asset,
//             width: s(30),
//             height: s(30),
//               color: selected
//               ? ColorPalette.primary
//               : ColorPalette.darktext,
//           ),
//           SizedBox(height: s(2)),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class MainNavigationScreen extends StatelessWidget {
  final Widget child;
  final String location;

  const MainNavigationScreen({
    super.key,
    required this.child,
    required this.location,
  });

  int _getIndex(String location) {
    if (location.startsWith("/dashboard")) return 0;
    if (location.startsWith("/customer")) return 1;
    if (location.startsWith("/results")) return 2;
    if (location.startsWith("/profile")) return 3;
    return 0;
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go("/dashboard");
        break;
      case 1:
        context.go("/customer");
        break;
      case 2:
        context.go("/results");
        break;
      case 3:
        context.go("/profile");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final index = _getIndex(location);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        final currentIndex = _getIndex(location);

        if (currentIndex != 0) {
          context.go("/dashboard");
          return;
        }

        final shouldExit = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: ColorPalette.whitetext,
              title: Text(
                "Exit App",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: ColorPalette.background,
                ),
              ),
              content: Text(
                "Do you want to exit?",
                style: GoogleFonts.lato(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: ColorPalette.background,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text("No"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text("Yes"),
                ),
              ],
            );
          },
        );

        if (shouldExit == true) exit(0);
      },

      child: Scaffold(
        extendBody: true,
        body: child,
        bottomNavigationBar: _CustomBottomNav(
          selectedIndex: index,
          onTap: (i) => _onTap(context, i),
        ),
      ),
    );
  }
}

class _CustomBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _CustomBottomNav({required this.selectedIndex, required this.onTap});

  static const icons = [
    'assets/images/dashboard/home.webp',
    'assets/images/dashboard/customers.webp',
    'assets/images/dashboard/results.webp',
    'assets/images/dashboard/profile.webp',
  ];

  static const iconSizes = [
    Size(24, 22), // home
    Size(29, 22), // customers
    Size(18, 22), // results
    Size(23, 22), // profile
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Container(
        height: 80,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF161616),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white10),
        ),
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors: [Color(0xFF313038), Color(0xFF1C1B20)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Row(
            children: List.generate(4, (index) {
              final isSelected = selectedIndex == index;
              final showDivider =
                  index < 3 &&
                  selectedIndex != index &&
                  selectedIndex != (index + 1);

              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(index),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (showDivider)
                        Positioned(
                          right: 0,
                          child: Container(
                            width: 1,
                            height: 28,
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),

                      isSelected
                          ? _selectedIcon(index)
                          : Image.asset(
                              icons[index],
                              width: 26,
                              height: 26,
                              color: const Color(0xFF6B6B6B),
                            ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _selectedIcon(int index) {
    return Container(
      width: 64,
      height: 62,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(3),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFFFE684), width: 3),
        ),
        padding: const EdgeInsets.all(3),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [Color(0xFF313038), Color(0xFF1C1B20)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFFFFE684), Color(0xFF796B32)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds),
              child: Image.asset(
                icons[index],
                width: iconSizes[index].width,
                height: iconSizes[index].height,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
