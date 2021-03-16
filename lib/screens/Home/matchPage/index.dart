import 'package:ases/Widgets/information_modal.dart';
import 'package:ases/screens/Home/blocs/match/match_bloc.dart';
import 'package:ases/style/colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MatchPage extends StatelessWidget {
  final url;
  final live;
  MatchPage({this.url, this.live});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              shadowColor: blue100.withOpacity(0),
              title: const Text(
                'Матч',
                style: TextStyle(color: Colors.white),
              ),
              bottom: const TabBar(
                indicatorColor: Color(0xFFFED12D),
                labelStyle: TextStyle(fontSize: 14),
                tabs: <Widget>[
                  Tab(
                    text: "Информация",
                  ),
                  Tab(
                    text: "Аналитик",
                  ),
                ],
              ),
            ),
            body: TabBarView(children: <Widget>[
              BlocProvider<MatchBloc>(
                create: (context) => MatchBloc()..add(GetMatch(url: url)),
                child: BlocBuilder<MatchBloc, MatchState>(
                  builder: (context, state) {
                    if (state is MatchInitial) {
                      return ListView(
                          padding: EdgeInsets.only(top: 100),
                          children: [
                            MatchInfo(match: [
                              state.match[0],
                              state.match[1],
                              state.match[3]
                            ], live: live),
                            MatchMapInfo(match: state.match)
                          ]);
                    } else if (state is MatchFailure) {
                      return ModalInformation(
                          title: "Ошибка", textContent: "Ошибка");
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              BlocProvider<MatchBloc>(
                create: (context) => MatchBloc()..add(MatchAnalitik(url: url)),
                child: BlocBuilder<MatchBloc, MatchState>(
                  builder: (context, state) {
                    if (state is MatchAnalitikInitial) {
                      return ListView(
                          padding: EdgeInsets.only(top: 100),
                          children: [
                            MatchAnalitikInfo(
                              match: state.analitik,
                            )
                          ]);
                    } else if (state is MatchFailure) {
                      return ModalInformation(
                          title: "Ошибка", textContent: "Ошибка");
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ])));
  }
}

class MatchMapInfo extends StatelessWidget {
  final match;
  MatchMapInfo({this.match});

  @override
  Widget build(BuildContext context) {
    final maps = match[2];
    final team1logo = match[0]['logo'];
    final team2logo = match[1]['logo'];
    final Size size = MediaQuery.of(context).size;
    return Column(children: [
      Text(
        "Карты",
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.left,
      ),
      Column(
          children: maps
              .map<Widget>((map) =>
                  CardMap(map: map, team1logo: team1logo, team2logo: team2logo))
              .toList())
    ]);
  }
}

class CardMap extends StatelessWidget {
  final map;
  String team1logo;
  String team2logo;
  CardMap({this.map, this.team2logo, this.team1logo});

  @override
  Widget build(BuildContext context) {
    team1logo = team1logo == null || !team1logo.contains('https://')
        ? 'https://www.hltv.org/img/static/team/placeholder.svg'
        : team1logo;
    team2logo = team2logo == null || !team2logo.contains('https://')
        ? 'https://www.hltv.org/img/static/team/placeholder.svg'
        : team2logo;
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: blue300, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Container(
                height: 27,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  image: DecorationImage(
                      image: NetworkImage("https://www.hltv.org${map['img']}"),
                      fit: BoxFit.cover),
                ),
                child: Text(
                  map['name_map'],
                  textAlign: TextAlign.center,
                )),
            Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      team1logo.contains('.svg')
                          ? SvgPicture.network(team1logo, width: 35, height: 35)
                          : Image.network(
                              team1logo,
                              width: 35,
                            ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              "${map['team1_score'].trim()} : ${map['team2_score'].trim()}",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 24)),
                          SizedBox(height: 10),
                          Text(map['map_score'],
                              style: TextStyle(fontSize: 12),
                              textAlign: TextAlign.center),
                        ],
                      ),
                      team2logo.contains('.svg')
                          ? SvgPicture.network(team2logo, width: 35, height: 35)
                          : Image.network(
                              team2logo,
                              width: 35,
                            )
                    ]))
          ],
        ));
  }
}

class MatchInfo extends StatelessWidget {
  final match;
  final live;
  MatchInfo({this.match, this.live});

  @override
  Widget build(BuildContext context) {
    print(match);
    final Size size = MediaQuery.of(context).size;
    return Container(
        alignment: Alignment.topCenter,
        child: Stack(alignment: Alignment.center, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            match[0]['flag'] != null
                ? Image.network(
                    "https://www.hltv.org${match[0]['flag']}",
                    width: size.width * 0.4,
                  )
                : SizedBox(
                    width: size.width * 0.4,
                  ),
            match[1]['flag'] != null
                ? Image.network(
                    "https://www.hltv.org${match[1]['flag']}",
                    width: size.width * 0.4,
                  )
                : SizedBox(
                    width: size.width * 0.4,
                  )
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0, 0.6],
                    colors: [
                      blue100.withOpacity(0.4),
                      blue100.withOpacity(1),
                    ],
                  ),
                ),
                width: size.width * 0.5,
                height: 170,
              ),
              Container(
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    stops: [0, 0.6],
                    colors: [
                      blue100.withOpacity(0.4),
                      blue100.withOpacity(1),
                    ],
                  ),
                ),
                width: size.width * 0.5,
                height: 170,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                width: size.width * 0.22,
                child:
                    TeamBlock(title: match[0]['name'], img: match[0]['logo']),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.33,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(match[2]['time'], style: TextStyle(fontSize: 26)),
                      SizedBox(height: 5),
                      Text(match[2]['event'],
                          style: TextStyle(fontSize: 9, color: Colors.blueGrey),
                          textAlign: TextAlign.center),
                      SizedBox(height: 5),
                      Text(match[2]['countdown'],
                          style: TextStyle(
                              fontSize: 14,
                              color: match[2]['countdown'] == 'LIVE'
                                  ? Colors.red
                                  : Colors.white)),
                    ]),
              ),
              Container(
                padding: EdgeInsets.only(right: 10),
                width: size.width * 0.22,
                child:
                    TeamBlock(title: match[1]['name'], img: match[1]['logo']),
              ),
            ],
          )
        ]));
  }
}

class MatchAnalitikInfo extends StatelessWidget {
  final match;
  MatchAnalitikInfo({this.match});

  @override
  Widget build(BuildContext context) {
    double teamsResults = match[0][0]['team1'] + match[0][0]['team2'];

    int team1Results = ((match[0][0]['team1'] / teamsResults) * 100).toInt();
    int team2Results = ((match[0][0]['team2'] / teamsResults) * 100).toInt();

    final Size size = MediaQuery.of(context).size;
    return Container(
        alignment: Alignment.topCenter,
        child: Stack(alignment: Alignment.center, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            match[1][0]['flag'] != null
                ? Image.network(
                    "https://www.hltv.org${match[1][0]['flag']}",
                    width: size.width * 0.4,
                  )
                : SizedBox(
                    width: size.width * 0.4,
                  ),
            match[1][1]['flag'] != null
                ? Image.network(
                    "https://www.hltv.org${match[1][1]['flag']}",
                    width: size.width * 0.4,
                  )
                : SizedBox(
                    width: size.width * 0.4,
                  )
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0, 0.6],
                    colors: [
                      blue100.withOpacity(0.4),
                      blue100.withOpacity(1),
                    ],
                  ),
                ),
                width: size.width * 0.5,
                height: 170,
              ),
              Container(
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    stops: [0, 0.6],
                    colors: [
                      blue100.withOpacity(0.4),
                      blue100.withOpacity(1),
                    ],
                  ),
                ),
                width: size.width * 0.5,
                height: 170,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                width: size.width * 0.22,
                child: TeamBlock(
                    title: match[1][0]['name'], img: match[1][0]['logo']),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.40,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("$team1Results%",
                          style: TextStyle(
                              fontSize: 26,
                              color: team1Results < 50
                                  ? Colors.red
                                  : Colors.green)),
         
                      Text("$team2Results%",
                          style: TextStyle(
                              fontSize: 26,
                              color: team2Results < 50
                                  ? Colors.red
                                  : Colors.green)),
                    ]),
              ),
              Container(
                padding: EdgeInsets.only(right: 10),
                width: size.width * 0.22,
                child: TeamBlock(
                    title: match[1][1]['name'], img: match[1][1]['logo']),
              ),
            ],
          )
        ]));
  }
}

class TeamBlock extends StatelessWidget {
  String img;
  final title;
  TeamBlock({this.img, this.title});

  @override
  Widget build(BuildContext context) {
    img = img == null || !img.contains('https://')
        ? 'https://www.hltv.org/img/static/team/placeholder.svg'
        : img;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          img.contains('.svg')
              ? SvgPicture.network(img,
                  width: 55, height: 55) // Image.network(img)
              : Image.network(img, width: 55, height: 55),
          SizedBox(height: 10),
          Text(title,
              textAlign: TextAlign.center, style: TextStyle(fontSize: 14))
        ]);
  }
}
