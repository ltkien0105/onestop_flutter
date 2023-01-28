import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:onestop_dev/globals/my_colors.dart';
import 'package:onestop_dev/globals/my_fonts.dart';
import 'package:onestop_dev/widgets/lostfound/new_page_button.dart';
import 'package:onestop_dev/widgets/lostfound/progress_bar.dart';


class DetailsUpsp extends StatefulWidget {
  const DetailsUpsp({Key? key}) : super(key: key);

  @override
  State<DetailsUpsp> createState() => _DetailsUpspState();
}

class _DetailsUpspState extends State<DetailsUpsp> {
  String? selectedLocation;
  String? selectedDropdown;
  List<String> hostels = [
    "Hostel",
    "Brahmaputra",
    "Dihing",
    "Manas",
    "Lohit",
    "Dhansiri",
    "Subansiri",
    "Disang",
    "Kameng",
    "Umiam",
    "Barak"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kBlueGrey,
        title: Text(
          "  2. Your Details",
          style: MyFonts.w600.size(16).setColor(kWhite),
        ),
      ),
      body: Column(
        children: [
          const ProgressBar(blue: 2, grey: 0),
          Container(
            color: kBlueGrey,
            child: Container(
              margin: const EdgeInsets.only(top: 10, left: 16, right: 16, bottom: 15),
              child: Text(
                "Fill this One stop form to  address your Academic, Technical, Cultural or Welfare problems directly to the respective boards.",
                style: MyFonts.w400.size(14).setColor(kWhite),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 15, bottom: 10),
                    child: Text(
                      "Contact Number",
                      style: MyFonts.w600.size(16).setColor(kWhite),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                            border: Border.all(color: kGrey2),
                            color: kBackground, borderRadius: BorderRadius.circular(24)),
                        child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: TextField(
                              style: MyFonts.w500.size(16).setColor(kWhite),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Your Answer',
                                hintStyle: TextStyle(color: kGrey8),
                              ),
                            )
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 15, bottom: 10),
                    child: Text(
                      "Roll Number",
                      style: MyFonts.w600.size(16).setColor(kWhite),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                            border: Border.all(color: kGrey2),
                            color: kBackground, borderRadius: BorderRadius.circular(24)),
                        child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: TextField(
                              style: MyFonts.w500.size(16).setColor(kWhite),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: '190101009',
                                hintStyle: TextStyle(color: kGrey8),
                              ),
                            )
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 15, bottom: 10),
                    child: Text(
                      "Your Hostel",
                      style: MyFonts.w600.size(16).setColor(kWhite),
                    ),
                  ),

                  Theme(
                    data: Theme.of(context).copyWith(canvasColor: kBlueGrey),
                    child: Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      child: DropdownButtonFormField<String>(
                        value: selectedDropdown == "Disang"
                            ? selectedLocation
                            : "Hostel",
                        icon: const Icon(
                          FluentIcons.chevron_down_24_regular,
                          color: kWhite,
                        ),
                        style: MyFonts.w600.size(14).setColor(kWhite),
                        onChanged: (data) {
                          setState(() {
                            selectedLocation = data!;
                            selectedDropdown = "Hostel";
                          });
                        },
                        items: hostels.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Text(
                                value,
                                style: MyFonts.w600.size(14).setColor(kWhite),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                    },
                    child: const NextButton(
                      title: "Submit",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
