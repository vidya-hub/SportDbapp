import 'package:flutter/material.dart';
import 'package:teamwaveapp/models/allSports.dart';
import 'package:teamwaveapp/services/apiServices.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class SportsListPage extends StatefulWidget {
  List<Sport> allSports;
  String countryName;
  SportsListPage({this.countryName, this.allSports});
  @override
  _SportsListPageState createState() => _SportsListPageState();
}

class _SportsListPageState extends State<SportsListPage> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    print(widget.countryName);
    _init();
    super.initState();
  }

  _init() {
    ApiService.getSportsLeagues(widget.countryName).then((value) {
      print(value);
    });
  }

  String getSportUrl(String sportName) {
    return widget.allSports
        .where((element) => (element.strSport == sportName))
        .first
        .strSportThumb;
  }

  bool searchEnabled = false;
  String filterString = "";

  _launchURL(String url) async {
    if (!url.contains('http')) {
      setState(() {
        url = 'https://$url';
      });
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text(widget.countryName),
        // actions: [Text(widget.countryName)],
      ),
      body: Container(
        height: _height,
        width: _width,
        child: Column(
          children: [
            SizedBox(
              height: _height * 0.01,
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 8,
                ),
                child: TextFormField(
                  // enabled: enabledKey,
                  // cursorColor: kPrimaryColor,
                  // cursorWidth: 2.0,
                  // keyboardType: keyBoardType,
                  toolbarOptions: ToolbarOptions(
                    cut: true,
                    copy: true,
                    selectAll: true,
                    paste: true,
                  ),
                  onTap: () {
                    // print("Tap[");
                    setState(() {
                      searchEnabled = true;
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      filterString = value;
                    });
                  },
                  // autofocus: true,
                  controller: controller,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
                    hintText: "Search leagues...",
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(5),
                      ),
                      borderSide: new BorderSide(
                        color: Colors.black.withOpacity(0.1),
                        width: 0.1,
                      ),
                    ),
                  ),
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1.0), fontSize: 18),
                  // maxLines: 10,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: searchEnabled && controller.text != ""
                    ? ApiService.getFilteredSportsLeagues(
                        widget.countryName, filterString.trim())
                    : ApiService.getSportsLeagues(widget.countryName),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? Container(
                          height: _height,
                          child: snapshot.data.countrys.length != 0
                              ? ListView.builder(
                                  itemCount: snapshot.data.countrys.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.045,
                                          vertical: 10),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            child: Image.network(
                                              getSportUrl(snapshot.data
                                                  .countrys[index].strSport),
                                              fit: BoxFit.cover,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                snapshot.data.countrys[index]
                                                    .strLeague,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: _height * 0.12,
                                            left: _width * 0.03,
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  snapshot.data.countrys[index]
                                                              .strTwitter !=
                                                          ""
                                                      ? GestureDetector(
                                                          onTap: () async {
                                                            print(snapshot
                                                                .data
                                                                .countrys[index]
                                                                .strTwitter);
                                                            await _launchURL(
                                                                snapshot
                                                                    .data
                                                                    .countrys[
                                                                        index]
                                                                    .strTwitter);
                                                          },
                                                          child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                4,
                                                              ),
                                                              child: SvgPicture
                                                                  .asset(
                                                                "assets/twitter.svg",
                                                                color: Colors
                                                                    .white,
                                                                width: 25.0,
                                                                height: 25.0,
                                                              )),
                                                        )
                                                      : Container(),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                _width * 0.01),
                                                    child: snapshot
                                                                .data
                                                                .countrys[index]
                                                                .strFacebook !=
                                                            ""
                                                        ? GestureDetector(
                                                            onTap: () async {
                                                              print(snapshot
                                                                  .data
                                                                  .countrys[
                                                                      index]
                                                                  .strFacebook);
                                                              await _launchURL(
                                                                  snapshot
                                                                      .data
                                                                      .countrys[
                                                                          index]
                                                                      .strFacebook);
                                                            },
                                                            child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  4,
                                                                ),
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  "assets/facebook.svg",
                                                                  color: Colors
                                                                      .white,
                                                                  width: 25.0,
                                                                  height: 25.0,
                                                                )),
                                                          )
                                                        : Container(),
                                                  ),

                                                  //
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: _height * 0.09,
                                            left: _width * 0.52,
                                            child: snapshot.data.countrys[index]
                                                        .strLogo !=
                                                    null
                                                ? ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      4,
                                                    ),
                                                    child: Image.network(
                                                      snapshot
                                                          .data
                                                          .countrys[index]
                                                          .strLogo,
                                                      // color: Colors.white,
                                                      width: _width * 0.4,
                                                      height: _height * 0.05,
                                                    ))
                                                : Container(),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                )
                              : Center(
                                  child: Text(
                                    "No Data Found",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
