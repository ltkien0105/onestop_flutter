import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:onestop_dev/globals/my_colors.dart';
import 'package:onestop_dev/stores/mapbox_store.dart';
import 'package:onestop_dev/widgets/mapbox/carousel_card.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:onestop_dev/globals/my_fonts.dart';

class MapBox extends StatefulWidget {
  MapBox({
    Key? key,
  }) : super(key: key);

  @override
  State<MapBox> createState() => _MapBoxState();
}

DateTime now = DateTime.now();
String formattedTime = DateFormat.jm().format(now);

class _MapBoxState extends State<MapBox> {
  String mapString = '';
  late GoogleMapController controller;
  final myToken =
      'pk.eyJ1IjoibGVhbmQ5NjYiLCJhIjoiY2t1cmpreDdtMG5hazJvcGp5YzNxa3VubyJ9.laphl_yeaw_9SUbcebw9Rg';
  final pointIcon = 'assets/images/pointicon.png';
  final busIcon = 'assets/images/busicon.png';

  double zoom = 13.0;

  void initState() {
    super.initState();
    rootBundle
        .loadString('assets/json/map_style.json')
        .then((value) => mapString = value);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      var mapbox_store = context.read<MapBoxStore>();
      print("rebuildMap Box");
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Stack(
          children: [
            FutureBuilder(
                future: mapbox_store.getLocation(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Observer(builder: (context) {
                      print("BUilder rebuild");
                      return Container(
                        height: 365,
                        width: double.infinity,
                        child: GoogleMap(
                          onMapCreated: (mapcontroller) {
                            controller = mapcontroller;
                            controller.setMapStyle(mapString);
                            mapbox_store.mapController = mapcontroller;
                          },
                          initialCameraPosition: CameraPosition(
                              target: snapshot.data as LatLng, zoom: 15),
                          markers: mapbox_store.markers.toSet(),
                          // polylines: poly.toSet(),
                          myLocationEnabled: true,
                          myLocationButtonEnabled: false,
                          compassEnabled: true,
                          trafficEnabled: true,
                          zoomControlsEnabled: false,
                        ),
                      );
                    });
                  }
                  return Shimmer.fromColors(
                      child: Container(
                        height: 365,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: kBlack,
                            borderRadius: BorderRadius.circular(25)),
                      ),
                      period: Duration(seconds: 1),
                      baseColor: kHomeTile,
                      highlightColor: lGrey);
                }),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        mapbox_store.setIndexMapBox(0);
                        mapbox_store.generate_bus_markers();
                      },
                      //padding: EdgeInsets.only(left: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                        child: Container(
                          height: 32,
                          width: 83,
                          color: (mapbox_store.indexBusesorFerry == 0)
                              ? lBlue2
                              : kBlueGrey,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconData(0xe1d5, fontFamily: 'MaterialIcons'),
                                color: (mapbox_store.indexBusesorFerry == 0)
                                    ? kBlueGrey
                                    : kWhite,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  "Bus",
                                  style: (mapbox_store.indexBusesorFerry == 0)
                                      ? MyFonts.w500.setColor(kBlueGrey)
                                      : MyFonts.w500.setColor(kWhite),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          mapbox_store.setIndexMapBox(1);
                        });
                      },
                      //padding: EdgeInsets.only(left: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                        child: Container(
                          height: 32,
                          width: 83,
                          color: (mapbox_store.indexBusesorFerry == 1)
                              ? lBlue2
                              : kBlueGrey,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                IconData(0xefc2, fontFamily: 'MaterialIcons'),
                                color: (mapbox_store.indexBusesorFerry == 1)
                                    ? kBlueGrey
                                    : kWhite,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text("Ferry",
                                    style: (mapbox_store.indexBusesorFerry == 1)
                                        ? MyFonts.w500.setColor(kBlueGrey)
                                        : MyFonts.w500.setColor(kWhite)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    /*(!mapbox_store.isTravelPage)
                        ? TextButton(
                            onPressed: () {
                              setState(() {
                                mapbox_store.setIndexMapBox(2);
                                mapbox_store.generate_restaraunt_markers();
                              });
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(40),
                              ),
                              child: Container(
                                height: 32,
                                width: 83,
                                color: (mapbox_store.indexBusesorFerry == 2)
                                    ? lBlue2
                                    : kBlueGrey,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.bus_alert,
                                      color:
                                          (mapbox_store.indexBusesorFerry == 2)
                                              ? kBlueGrey
                                              : kWhite,
                                    ),
                                    Text("Food",
                                        style: (mapbox_store
                                                    .indexBusesorFerry ==
                                                2)
                                            ? MyFonts.w500.setColor(kBlueGrey)
                                            : MyFonts.w500.setColor(kWhite)),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),*/
                  ],
                ),
                SizedBox(
                  height: 90,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 4, bottom: 8),
                          child: FloatingActionButton(
                            heroTag: null,
                            onPressed: () {},
                            child: Icon(Icons.navigate_before_outlined),
                            mini: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8, right: 4),
                          child: FloatingActionButton(
                            heroTag: null,
                            onPressed: () {
                              // _mapController.
                              // moveAndRotate(
                              //     LatLng(mapbox_store.userlat,
                              //         mapbox_store.userlong),
                              //     15,
                              //     17);
                              zoomInMarker(
                                  mapbox_store.userlat, mapbox_store.userlong);
                            },
                            child: Icon(Icons.my_location),
                            mini: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                (!mapbox_store.isTravelPage)
                    ? CarouselSlider(
                        items: mapbox_store.buses_carousel
                            .map((e) => GestureDetector(
                                  child: context
                                              .read<MapBoxStore>()
                                              .selectedCarouselIndex ==
                                          (e as CarouselCard).index
                                      ? e
                                      : ColorFiltered(
                                          colorFilter: ColorFilter.mode(
                                              Colors.grey.shade600, BlendMode.modulate),
                                          child: e,
                                        ),
                                  onTap: () {
                                    context
                                        .read<MapBoxStore>()
                                        .selectedCarousel(
                                            (e as CarouselCard).index);
                                    zoomTwoMarkers(
                                        LatLng(
                                            mapbox_store.bus_carousel_data[
                                                    mapbox_store
                                                        .selectedCarouselIndex]
                                                ['lat'],
                                            mapbox_store.bus_carousel_data[
                                                    mapbox_store
                                                        .selectedCarouselIndex]
                                                ['long']),
                                        LatLng(mapbox_store.userlat,
                                            mapbox_store.userlong));
                                  },
                                ))
                            .toList(),
                        options: CarouselOptions(
                          height: 100,
                          viewportFraction: 0.7,
                          initialPage: 0,
                          enableInfiniteScroll: false,
                          scrollDirection: Axis.horizontal,
                          // onPageChanged:
                          //     (int index, CarouselPageChangedReason reason) async {
                          //
                          // },
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ],
        ),
      );
    });
  }

  void zoomInMarker(double lat, double long) {
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(lat, long), zoom: 17.0, bearing: 90.0, tilt: 45.0)));
  }

  void zoomTwoMarkers(LatLng ans, LatLng user) async {
    double startLatitude = user.latitude;
    double startLongitude = user.longitude;

    double destinationLatitude = ans.latitude;
    double destinationLongitude = ans.longitude;
    double miny = (startLatitude <= destinationLatitude)
        ? startLatitude
        : destinationLatitude;
    double minx = (startLongitude <= destinationLongitude)
        ? startLongitude
        : destinationLongitude;
    double maxy = (startLatitude <= destinationLatitude)
        ? destinationLatitude
        : startLatitude;
    double maxx = (startLongitude <= destinationLongitude)
        ? destinationLongitude
        : startLongitude;

    double southWestLatitude = miny;
    double southWestLongitude = minx;

    double northEastLatitude = maxy;
    double northEastLongitude = maxx;

    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          northeast: LatLng(northEastLatitude, northEastLongitude),
          southwest: LatLng(southWestLatitude, southWestLongitude),
        ),
        100.0,
      ),
    );
  }
}
