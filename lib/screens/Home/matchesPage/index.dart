import 'package:ases/Widgets/information_modal.dart';
import 'package:ases/model/user_model.dart';
import 'package:ases/screens/Home/blocs/matches/matches_bloc.dart';
import 'package:ases/screens/Home/matchPage/index.dart';
import 'package:ases/style/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MatchesPage extends StatelessWidget {
  static const String routeName = '/matches';
  final User user;
  MatchesPage({this.user});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: const Text(
              'Матчи',
              style: TextStyle(color: Colors.white),
            ),
            bottom: const TabBar(
              indicatorColor: Color(0xFFFED12D),
              labelStyle: TextStyle(fontSize: 14),
              tabs: <Widget>[
                Tab(
                  text: "Текущие",
                ),
                Tab(
                  text: "Предстоящие",
                ),
                Tab(
                  text: "Завершенные",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Center(
                child: BlocProvider<MatchesBloc>(
                  create: (context) => MatchesBloc()..add(LiveMatches()),
                  child: BlocBuilder<MatchesBloc, MatchesState>(
                    builder: (context, state) {
                      if (state is MatchesInitial) {
                        return ListView(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.2,
                                horizontal: 5),
                            children: state.matches
                                .map((match) => LiveMatchCard(match: match))
                                .toList());
                      } else if (state is MatchesFailure) {
                        return ModalInformation(
                            title: "Ошибка", textContent: "Ошибка");
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ),
              Center(
                child: BlocProvider<MatchesBloc>(
                  create: (context) => MatchesBloc()..add(UpcomingMatches()),
                  child: BlocBuilder<MatchesBloc, MatchesState>(
                    builder: (context, state) {
                      if (state is MatchesInitial) {
                        return ListView(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * 0.2,
                                horizontal: 5),
                            children: state.matches
                                .map<Widget>((matchesDay) =>
                                    UpcomingMatchesBody(matchesDay: matchesDay))
                                .toList());
                      } else if (state is MatchesFailure) {
                        return ModalInformation(
                            title: "Ошибка", textContent: "Ошибка");
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Завершенные',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }
}

class UpcomingMatchesBody extends StatelessWidget {
  final matchesDay;
  UpcomingMatchesBody({this.matchesDay});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(matchesDay['date'],
          style: TextStyle(color: yellow100), textAlign: TextAlign.left),
      Column(
          children: matchesDay['mathes']
              .map<Widget>((match) => UpcomingMatchCard(match: match))
              .toList())
    ]);
  }
}

class UpcomingMatchCard extends StatelessWidget {
  final match;
  UpcomingMatchCard({this.match});

  @override
  Widget build(BuildContext context) {
    bool emptyMatchInfo = match['emptyMatchInfo'] ?? false;
    final Size size = MediaQuery.of(context).size;
    return InkWell(
        onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MatchPage(url: match['url'], live: false)))
            },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: !emptyMatchInfo ? size.height * 0.2 : size.height * 0.1,
            decoration: BoxDecoration(
                color: blue300, borderRadius: BorderRadius.circular(10)),
            child: !emptyMatchInfo
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width * 0.20,
                        child: TeamBlock(
                            title: match['team1']['team1Name'],
                            img: match['team1']['team1Logo']),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                         width: size.width * 0.3,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: size.width * 0.15,
                                child: Text(match['matchInfo']['matchMeta'],
                                    style: TextStyle(fontSize: 12),
                                    textAlign: TextAlign.center),
                              ),
                              Text(match['matchInfo']['matchTime'].trim(),
                                  style: TextStyle(fontSize: 32)),
                              Text(match['matchInfo']['matchEventName'],
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.blueGrey),
                                  textAlign: TextAlign.center)
                            ]),
                      ),
                      Container(
                        width: size.width * 0.2,
                        child: TeamBlock(
                            title: match['team2']['team2Name'],
                            img: match['team2']['team2Logo']),
                      ),
                    ],
                  )
                : Container(
                    alignment: Alignment.center,
                    child: Text(
                      match['matchInfo']['emptyMatchInfo'],
                      textAlign: TextAlign.center,
                    ))));
  }
}

class LiveMatchCard extends StatelessWidget {
  final match;
  LiveMatchCard({this.match});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
        onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MatchPage(url: match['url'], live: true)))
            },
        child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: size.height * 0.2,
        decoration: BoxDecoration(
            color: blue300, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: size.width * 0.20,
              child: TeamBlock(
                  title: match['team1']['name'], img: match['team1']['logo']),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
               width: size.width * 0.4,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: size.width * 0.15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(match['matchMeta'],
                              style: TextStyle(fontSize: 12)),
                          Text("LIVE",
                              style: TextStyle(color: Colors.red, fontSize: 12))
                        ],
                      ),
                    ),
                    Container(
                      width: size.width * 0.3,
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(match['team1']['score']['currentMap'].trim(),
                            style: TextStyle(fontSize: 32)),
                        Text(" Vs ",
                            style: TextStyle(color: Colors.red, fontSize: 16)),
                        Text(match['team2']['score']['currentMap'].trim(),
                            style: TextStyle(fontSize: 32)),
                      ],
                    ),
                    ),
                    Text(match['matchEventName'],
                        style: TextStyle(fontSize: 10, color: Colors.blueGrey),
                        textAlign: TextAlign.center)
                  ]),
            ),
            Container(
              width: size.width * 0.2,
              child: TeamBlock(
                  title: match['team2']['name'], img: match['team2']['logo']),
            ),
          ],
        )));
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
                  width: 50, height: 50) // Image.network(img)
              : Image.network(img),
          SizedBox(height: 10),
          Text(title,
              textAlign: TextAlign.center, style: TextStyle(fontSize: 14))
        ]);
  }
}
