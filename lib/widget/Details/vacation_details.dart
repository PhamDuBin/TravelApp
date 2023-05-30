import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/model/aTour.dart';
import 'package:travel_app/pages/flight_ticket.dart';
import 'package:travel_app/values/custom_text.dart';
import 'package:like_button/like_button.dart';
import '../../model/tourDetails.dart';

class VacationDetails extends StatelessWidget {
  const VacationDetails({Key? key, required this.tour}) : super(key: key);
  final aTour tour; //Trong đây nó có idUserCurrent

  Future<tourDetails?> readTourDetail(String idTour) async {
    final docTourDetails = FirebaseFirestore.instance
        .collection("TourDetails")
        .where('idTour', isEqualTo: idTour);
    final snapshot = await docTourDetails.get();

    if (snapshot.docs.isNotEmpty) {
      return tourDetails.fromJson(snapshot.docs.first.data());
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //Thông số size của điện thoại
    return FutureBuilder(
      future: readTourDetail(tour.idTour.toString()),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          final tourDetails = snapShot.data;
          print('${tourDetails!.idTour}');
          return (tourDetails == null)
              ? Center(
                  child: Text('No Find Tour !'),
                )
              : Stack(
                  children: <Widget>[
                    Container(
                      width: size.width,
                      height: size.height * 3 / 6,
                      child: Image.asset("assets/images/picture_tours/${tourDetails.imageTourDetails}.jpg",
                          // child: Image.asset("assets/images/picture_tours/ChinaMounDetails.jpg",
                          fit: BoxFit.cover),
                    ),
                    Positioned(
                      top: 15,
                      child: Row(children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(left: 22, top: 65),
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: OutlinedButton.styleFrom(
                              shape: const CircleBorder(),
                              padding: const EdgeInsets.all(10),
                              backgroundColor: Colors.black12,
                            ),
                            child: const Icon(
                              Icons.arrow_back,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ]),
                    ),
                    Positioned(
                        width: size.width,
                        height: 500,
                        top: size.height * 4 / 10,
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 25, top: 30, right: 25),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(35),
                                  topRight: Radius.circular(35)),
                              color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: size.width,
                                child: Row(children: <Widget>[
                                  CustomText(
                                    text: tour.nameTour.toString(),
                                    fontSize: 26,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.13,
                                    height: 1.3,
                                    color: Colors.black,
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: LikeButton(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      size: 35,
                                      circleColor: CircleColor(
                                          start: Color(0xff00ddff),
                                          end: Color(0xff0099cc)),
                                      bubblesColor: BubblesColor(
                                        dotPrimaryColor: Color(0xff33b5e5),
                                        dotSecondaryColor: Color(0xff0099cc),
                                      ),
                                      likeBuilder: (bool isLiked) {
                                        return FaIcon(
                                          FontAwesomeIcons.solidHeart,
                                          color: isLiked
                                              ? Colors.pink
                                              : Colors.grey,
                                          size: 35,
                                        );
                                      },
                                    ),
                                  ),
                                ]),
                              ),
                              SizedBox(height: 6),
                              Row(
                                children: <Widget>[
                                  FaIcon(
                                    FontAwesomeIcons.locationDot,
                                    size: 12,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(width: 8),
                                  CustomText(
                                    text: tourDetails.placeTour.toString(),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.13,
                                    height: 1.5,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                              SizedBox(height: 22),
                              CustomText(
                                  text: 'Details',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.10,
                                  height: 1.5,
                                  color: Colors.black87),
                              SizedBox(height: 15),
                              CustomText(
                                  text: tourDetails.description.toString(),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 0.5,
                                  height: 1.8,
                                  color: Colors.black),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text.rich(TextSpan(
                                      text: '\$ ${tour.priceTour.toString()}',
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 24,
                                          decoration: TextDecoration.none,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: '/',
                                            style: GoogleFonts.plusJakartaSans(
                                              fontSize: 20,
                                              decoration: TextDecoration.none,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w500,
                                            )),
                                        TextSpan(
                                            text: 'Person',
                                            style: GoogleFonts.plusJakartaSans(
                                                fontSize: 16,
                                                decoration: TextDecoration.none,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 1))
                                      ])),
                                  SizedBox(width: 10),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FlightTicket(
                                                      nameTours: tour.nameTour
                                                          .toString(),
                                                      addressCurrent:
                                                          'addressCurrent',
                                                      tour: tour,
                                                      //Chuyển thêm cái id nữa
                                                    )));
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.pink,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(14.0),
                                        child: CustomText(
                                            text: 'Book Now',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 1.5,
                                            height: 0,
                                            color: Colors.white),
                                      )),
                                ],
                              )
                            ],
                          ),
                        ))
                  ],
                );
        } else if (snapShot.hasError) {
          return Center(child: Text('Error: ${snapShot.error}'));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
