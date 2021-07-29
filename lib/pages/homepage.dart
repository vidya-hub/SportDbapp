import 'package:flutter/material.dart';
import 'package:teamwaveapp/models/allSports.dart';
import 'package:teamwaveapp/models/sportsList.dart';
import 'package:teamwaveapp/pages/sportsDisplay.dart';
import 'package:teamwaveapp/services/apiServices.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List sportsList = [];
  @override
  initState() {
    ApiService.getAllSports().then((value) {
      setState(() {
        sportsList.add(value.sports);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.12,
              ),
              Text(
                "The Sports DB",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Expanded(
                flex: 1,
                child: FutureBuilder(
                  future: ApiService.getCountries(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.data.countries.length != 0) {
                      // setState(() {
                      snapshot.data.countries.sort((a, b) {
                        return a.nameEn
                            .toString()
                            .toLowerCase()
                            .compareTo(b.nameEn.toString().toLowerCase());
                      });
                      // });
                    }
                    // print(snapshot.data.countries);
                    return snapshot.hasData
                        ? snapshot.data.countries.length == 0
                            ? Center(
                                child: Text("No Leagues Found"),
                              )
                            : ListView.builder(
                                itemCount: snapshot.data.countries.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        // print(sportsList);
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return SportsListPage(
                                            allSports: sportsList[0],
                                            countryName: snapshot
                                                .data.countries[index].nameEn,
                                          );
                                        }));
                                      },
                                      child: Card(
                                        child: Center(
                                          child: ListTile(
                                            leading: Text(
                                              snapshot
                                                  .data.countries[index].nameEn,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            trailing: Icon(
                                              Icons.arrow_forward_rounded,
                                              size: 30,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
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
      ),
    );
  }
}
