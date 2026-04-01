import 'package:flutter/material.dart';
import 'package:gb_lottery_b2b/src/app/color_palette.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerUserListSection extends StatelessWidget {
  const CustomerUserListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final scale = w / 375;
    double s(double v) => v * scale;

    final users = [
      {"name": "S", "phone": "9874563212"},
      {"name": "Mani", "phone": "9874563212"},
      {"name": "Mani", "phone": "9874563212"},
      {"name": "S", "phone": "9874563212"},
      {"name": "Mani", "phone": "9874563212"},
      {"name": "Mani", "phone": "9874563212"},
    ];

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF24232A),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(s(10)),
              topLeft: Radius.circular(s(10)),
            ),
          ),
          child: Column(
            children: List.generate(users.length, (index) {
              final user = users[index];

              return Column(
                children: [
                  /// 🔹 LIST ITEM
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: s(10),
                      vertical: s(10),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: s(50),
                          width: s(50),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF1F1E24),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            user["name"]![0],
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w500,
                              color: ColorPalette.whitetext,
                              fontSize: s(24),
                            ),
                          ),
                        ),

                        SizedBox(width: s(12)),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user["name"]!,
                                style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w400,
                                  color: ColorPalette.whitetext,
                                  fontSize: s(16),
                                ),
                              ),
                              SizedBox(height: s(4)),
                              Text(
                                user["phone"]!,
                                style: GoogleFonts.dmSans(
                                  fontWeight: FontWeight.w400,
                                  color: ColorPalette.darktext,
                                  fontSize: s(14),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTapDown: (details) async {
                            final selected = await showMenu(
                              context: context,
                              color: const Color(0xFF313038),
                              position: RelativeRect.fromLTRB(
                                details.globalPosition.dx - s(200),
                                details.globalPosition.dy - s(-8),
                                s(60),
                                0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(s(12)),
                              ),
                              items: [
                                PopupMenuItem(
                                  value: "view",
                                  padding: EdgeInsets.zero,
                                  child: SizedBox(
                                    width: s(132),
                                    height: s(42),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: s(13),
                                          top: s(8),
                                          bottom: s(8),
                                        ),
                                        child: Text(
                                          "View",
                                          style: GoogleFonts.dmSans(
                                            color: ColorPalette.whitetext,
                                            fontSize: s(14),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                PopupMenuItem(
                                  enabled: false,
                                  padding: EdgeInsets.zero,
                                  height: s(1),
                                  child: Divider(
                                    color: ColorPalette.darktext.withOpacity(
                                      0.5,
                                    ),
                                    thickness: 0.5,
                                    height: 1,
                                  ),
                                ),

                                PopupMenuItem(
                                  value: "edit",
                                  padding: EdgeInsets.zero,
                                  child: SizedBox(
                                    width: s(132),
                                    height: s(42),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: s(13),
                                          top: s(8),
                                          bottom: s(8),
                                        ),
                                        child: Text(
                                          "Edit",
                                          style: GoogleFonts.dmSans(
                                            color: ColorPalette.whitetext,
                                            fontWeight: FontWeight.w400,
                                            fontSize: s(14),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );

                            if (selected == "view") {
                              print("View clicked");
                            } else if (selected == "edit") {
                              print("Edit clicked");
                            }
                          },

                          child: Padding(
                            padding: EdgeInsets.only(right: s(20)),
                            child: Icon(
                              Icons.more_vert,
                              color: ColorPalette.buttoncolor.withValues(
                                alpha: .80,
                              ),
                              size: s(23.9),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (index != users.length - 1)
                    Divider(
                      color: ColorPalette.darktext,
                      thickness: 0.5,
                      height: 0.5,
                    ),
                ],
              );
            }),
          ),
        ),
        SizedBox(height: s(44)),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: s(12)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Total 25004",
                style: GoogleFonts.dmSans(
                  fontSize: s(14),
                  fontWeight: FontWeight.w600,
                  color: ColorPalette.darktext,
                ),
              ),

              SizedBox(width: s(24)),
              Row(
                children: [
                  _pageNumber("1", true, s),
                  SizedBox(width: s(24)),
                  _pageNumber("2", false, s),
                  SizedBox(width: s(24)),
                  _pageNumber("3", false, s),

                  SizedBox(width: s(24)),
                  _navButton(Icons.chevron_left, s),

                  SizedBox(width: s(7)),
                  _navButton(Icons.chevron_right, s),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: s(10)),
      ],
    );
  }

  Widget _pageNumber(String text, bool isSelected, double Function(double) s) {
    return Text(
      text,
      style: GoogleFonts.dmSans(
        fontSize: s(14),
        fontWeight: FontWeight.w600,
        color: isSelected ? ColorPalette.whitetext : ColorPalette.darktext,
      ),
    );
  }

  Widget _navButton(IconData icon, double Function(double) s) {
    return Container(
      height: s(26),
      width: s(26),
      decoration: BoxDecoration(
        color: const Color(0xFF313038),
        borderRadius: BorderRadius.circular(s(6)),  
      ),
      child: Icon(icon, size: s(12), color: ColorPalette.whitetext),
    );
  }
}
