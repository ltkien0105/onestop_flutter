import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:onestop_dev/functions/travel/has_left.dart';
import 'package:onestop_dev/globals/my_colors.dart';
import 'package:onestop_dev/globals/my_fonts.dart';
import 'package:onestop_dev/models/travel/travel_timing_model.dart';
import 'package:onestop_dev/pages/travel/data.dart';
import 'package:onestop_dev/stores/mapbox_store.dart';
import 'package:onestop_dev/stores/travel_store.dart';
import 'package:onestop_dev/widgets/travel/timing_tile.dart';
import 'package:onestop_dev/widgets/travel/travel_drop_down.dart';
import 'package:onestop_dev/widgets/ui/list_shimmer.dart';
import 'package:provider/provider.dart';
import '../../functions/travel/next_time.dart';

class FerryDetails extends StatefulWidget {
  const FerryDetails({Key? key}) : super(key: key);

  @override
  State<FerryDetails> createState() => _FerryDetailsState();
}

class _FerryDetailsState extends State<FerryDetails> {
  @override
  void initState() {
    super.initState();
    if (DateTime.now().weekday == DateTime.sunday) {
      context.read<TravelStore>().setFerryDayType("Sunday");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      var direction = context.read<TravelStore>().ferryDirection;
      var daytype = context.read<TravelStore>().ferryDayType;
      if (context.read<TravelStore>().ferryTimings.status ==
          FutureStatus.fulfilled) {
        TravelTiming ferryModel = context
            .read<TravelStore>()
            .ferryTimings
            .value!
            .firstWhere((element) =>
                element.stop == context.read<TravelStore>().selectedFerryGhat);
        print("Ferry model");
        print(ferryModel);
        // var ferryMap = ferryModel.toJson();
        return Column(children: [
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: ferryGhats
                  .map((e) => TextButton(
                        onPressed: () {
                          context.read<TravelStore>().setFerryGhat(e['name']);
                          var mapboxStore = context.read<MapBoxStore>();
                          int i = mapboxStore.allLocationData.indexWhere(
                              (element) => e['name'] == element['name']);
                          mapboxStore.selectedCarousel(i);
                          mapboxStore.zoomTwoMarkers(
                              mapboxStore.selectedCarouselLatLng,
                              LatLng(mapboxStore.userlat, mapboxStore.userlong),
                              90.0);
                        },
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(40),
                          ),
                          child: Container(
                            color: (context
                                        .read<TravelStore>()
                                        .selectedFerryGhat ==
                                    e['name'])
                                ? lBlue2
                                : kGrey2,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  e['name'],
                                  style: (context
                                              .read<TravelStore>()
                                              .selectedFerryGhat ==
                                          e['name'])
                                      ? MyFonts.w500.setColor(kBlueGrey)
                                      : MyFonts.w500.setColor(kWhite),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TravelDropDown(
                    value: context.read<TravelStore>().ferryDirection,
                    onChange: context.read<TravelStore>().setFerryDirection,
                    items: const ["Campus to City", "City to Campus"]),
                TravelDropDown(
                    value: context.read<TravelStore>().ferryDayType,
                    onChange: context.read<TravelStore>().setFerryDayType,
                    items: const ["Mon - Sat", "Sunday"])
              ],
            ),
          ),
          if (daytype == "Sunday") ...[
            ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: direction == "Campus to City"
                    ? ferryModel.weekend.fromCampus.length
                    : ferryModel.weekend.toCampus.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TimingTile(
                      time: direction == "Campus to City"
                          ? formatTime(ferryModel.weekend.fromCampus[index])
                          : formatTime(ferryModel.weekend.toCampus[index]),
                      isLeft: direction == "Campus to City"
                          ? hasLeft(ferryModel.weekend.fromCampus[index])
                          : hasLeft(ferryModel.weekend.toCampus[index]),
                      icon: FluentIcons.vehicle_ship_16_filled,
                    ),
                  );
                }),
          ] else ...[
            ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: direction == "Campus to City"
                    ? ferryModel.weekdays.fromCampus.length
                    : ferryModel.weekdays.toCampus.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TimingTile(
                      time: direction == "Campus to City"
                          ? formatTime(ferryModel.weekdays.fromCampus[index])
                          : formatTime(ferryModel.weekdays.toCampus[index]),
                      isLeft: direction == "Campus to City"
                          ? hasLeft(ferryModel.weekdays.fromCampus[index])
                          : hasLeft(ferryModel.weekdays.toCampus[index]),
                      icon: FluentIcons.vehicle_ship_16_filled,
                    ),
                  );
                }),
          ]
        ]);
      }
      return ListShimmer(
        count: 3,
        height: 50,
      );
    });
  }
}
