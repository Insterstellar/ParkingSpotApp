import 'package:flutter/material.dart';
import 'package:parking/misc/mycolors/mycolors.dart';
import 'package:parking/models/Gallery.dart';
import 'package:parking/models/parking_model.dart';
import 'package:parking/pages/parking_details.dart';
import 'package:parking/repo/controller/parking_controller.dart';
import 'package:parking/repo/controller/user_parking_controller.dart';
import 'package:parking/repo/services/ParkingServices.dart';
import 'package:parking/repo/services/user_parking_service.dart';
import 'package:parking/widgets/custom_list.dart';
import 'package:parking/widgets/custom_text.dart';

class SaveParking extends StatefulWidget {
  const SaveParking({super.key});

  @override
  State<SaveParking> createState() => _SaveParkingState();
}

class _SaveParkingState extends State<SaveParking> {


  List<String> fakePlaces = [
    "Central Park Garage",
    "Downtown Plaza Parking",
    "Riverside Parking Lot",
    "Sunset Boulevard Parking",
    "Market Street Parking Deck",
    "University Campus Parking",
    "City Center Parking",
    "Eastside Parking Complex",
    "Westfield Mall Parking",
    "Harborview Parking",
    "Airport Long-Term Parking",
    "Metro Station Parking",
    "Hilltop Parking Garage",
    "Lakeside Parking Lot",
    "Northgate Parking Facility",
    "Library Square Parking",
    "Stadium Parking Zone",
    "Convention Center Parking"
  ];

  List<String> addresses = [
    "1 Fjordview Road, Bergen, Norway",
    "25 Mountain Path, Bergen, Norway",
    "10 Seaside Boulevard, Bergen, Norway",
    "17 Harbor Street, Bergen, Norway",
    "5 Viking Way, Bergen, Norway",
    "8 Nordic Lane, Bergen, Norway",
    "34 Glacier Avenue, Bergen, Norway",
    "22 Aurora Drive, Bergen, Norway",
    "19 Birch Grove, Bergen, Norway",
    "11 Fisherman's Wharf, Bergen, Norway",
    "30 Old Town Road, Bergen, Norway",
    "28 Coastal Route, Bergen, Norway",
    "14 Castle Hill, Bergen, Norway",
    "7 Harborview Terrace, Bergen, Norway",
    "3 Northern Lights Lane, Bergen, Norway",
    "6 Fjordland Street, Bergen, Norway",
    "13 Maple Ridge, Bergen, Norway",
    "20 Seafarer's Lane, Bergen, Norway",
  ];
  var parkingController;
  var userParkingFavorites;
  List<bool> notAdded = [];
  var allFavorites = [];
  int userId = 2;
  var userParkingController = UserParkingController(UserParkingService());
  List<Parking> parkingSpots = [];
  List<Parking> filterdParkingSpots = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //get all parking places
    parkingController = ParkingController(ParkingServices());
    getAllParkingSpots();
    //get all parking favorites
    userParkingFavorites = UserParkingController(UserParkingService());
    addToFavorites();
  }

//to be refefoctered with stream controller or bloc
  Future<void> addToFavorites() async {
    allFavorites = await userParkingController.allFavorites(userId);
  }

  Future<void> getAllParkingSpots() async {
    parkingSpots = await parkingController.getAllParkingSpots();
    setState(() {
      filterdParkingSpots = parkingSpots;
      notAdded.clear();
      for (int a = 0; a < filterdParkingSpots.length; a++) {
        notAdded.add(true);
      }

      for (int a = 0; a < allFavorites.length; a++) {
        for (int i = 0; i < filterdParkingSpots.length; i++) {
          if (allFavorites[a].id == filterdParkingSpots[i].id) {
            notAdded[i] = false;
          }
        }
      }
    });
  }

  void searchItems(String query) {
    List<Parking> filterSpots = parkingSpots.where((item) {
      return item.name!.toString().toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      filterdParkingSpots = filterSpots;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: MyColors.primarylight0),
                  child: Icon(Icons.menu_rounded)),
              CustomText(
                  text: "Search Parking",
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  textColor: MyColors.grey_1),
              ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    "assets/images/carpark.jpeg",
                    fit: BoxFit.cover,
                    height: 50,
                    width: 50,
                  )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: MyColors.primarylight0,
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 5),
                      Icon(Icons.search, color: MyColors.grey_1),
                      SizedBox(width: 5),
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            searchItems(value);
                          },
                          decoration: const InputDecoration(
                            hintText: 'Search parking ....',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: MyColors.grey_1,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: MyColors.grey_1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
//
              SizedBox(
                width: 12,
              ),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: MyColors.primarylight0),
                child: Icon(
                  Icons.tune_outlined,
                  color: MyColors.grey_3,
                ),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: filterdParkingSpots.length,
                itemBuilder: (context, index) {
                  List<Gallery>? imageUrl = filterdParkingSpots[index].gallery;

                  return CustomListWidget(
                    parkingName: filterdParkingSpots[index].name ?? "",
                    address: filterdParkingSpots[index].location ?? "",
                    onTap: () {
                      String? clickedItem = filterdParkingSpots[index].name;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ParkingDetails(
                              parkingDetails: filterdParkingSpots[index]),
                        ),
                      );
                    },
                    price: filterdParkingSpots?[index]?.price ?? "",
                    distance: filterdParkingSpots[index].distance ?? "",
                    imageUrl: imageUrl?[0].imageUrl ?? "",
                    addFavorite: () async {
                      setState(() {
                        if (notAdded[index] == true) {
                          userParkingFavorites.addToFavorites(
                              userId, filterdParkingSpots[index].id);

                          notAdded[index] = false;
                        } else {
                          userParkingController.deleteUserFavorite(
                              userId, filterdParkingSpots[index].id!);

                          notAdded[index] = true;
                        }
                      });
                    },
                    isAdded: notAdded[index],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
