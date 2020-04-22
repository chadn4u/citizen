import 'package:citizens/bloc/newUser/newUserBloc.dart';
import 'package:citizens/bloc/newUser/newUserEvents.dart';
import 'package:citizens/models/newUser/newUser.dart';
import 'package:citizens/utils/colors.dart';
import 'package:citizens/widget/newUser/requestTab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:citizens/pages/newUser/tab/submitRequests.dart';

class NewUserMain extends StatefulWidget {
  final String jobCd;
  final String strCd;
  final String empNo;
  final String corpFg;
  final String allCorp;
  final String directorat;

  const NewUserMain(
      {Key key,
      this.jobCd,
      this.strCd,
      this.empNo,
      this.corpFg,
      this.directorat,
      this.allCorp})
      : super(key: key);
  @override
  _NewUserMainState createState() => _NewUserMainState();
}

class _NewUserMainState extends State<NewUserMain>
    with SingleTickerProviderStateMixin {
  final List<NewUser> newUser = [];
  final List<NewUser> newUserSearch = [];
  final List<NewUser> newUserTemp = [];
  final int initialMin = 0;
  final int initialMax = 20;
  ScrollController _scrollViewController;
  TabController _tabController;

  NewUserBloc newUserBloc;
  ScrollController scrollController = new ScrollController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    newUserBloc.close();
    _scrollViewController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    newUserBloc = NewUserBloc();
    newUserBloc.add(FirstLoadEvent(widget.jobCd, widget.strCd, widget.empNo,
        widget.corpFg, widget.directorat, 0, 20, null));

    _scrollViewController = new ScrollController();
    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  Widget build(BuildContext context) {
    ProgressDialog pr =
        ProgressDialog(context, isDismissible: true, showLogs: true);
    pr.style(message: 'Please Wait...');
    return BlocProvider(
      create: (BuildContext context) => newUserBloc,
      child: Scaffold(
        key: _scaffoldKey,
        body: NestedScrollView(
          controller: _scrollViewController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            //<-- headerSliverBuilder
            return <Widget>[
              new SliverAppBar(
                title: Text('New User'),
                pinned: true, //<-- pinned to true
                floating: true, //<-- floating to true
                forceElevated:
                    innerBoxIsScrolled, //<-- forceElevated to innerBoxIsScrolled
                bottom: TabBar(
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(Icons.file_upload),
                      text: "Submit Requests",
                    ),
                    Tab(
                      icon: Icon(Icons.library_books),
                      text: "Request Status",
                    )
                  ],
                  controller: _tabController,
                ),
                backgroundColor: colorPrimary,
              ),
            ];
          },
          body: TabBarView(
            children: <Widget>[
              tab1(pr),
              tab2(pr),
            ],
            controller: _tabController,
          ),
        ),
      ),
    );
  }

  Widget tab1(ProgressDialog pr) {
    return SubmitRequest(
      allCorp: widget.allCorp,
      strCd: widget.strCd,
      jobCd: widget.jobCd,
      empNo: widget.empNo,
      corpFg: widget.corpFg,
      directorat: widget.directorat,
      scrollControllers: _scrollViewController,
    );
  }

  tab2(ProgressDialog pr) {
    return RequestStatus(
      strCd: widget.strCd,
      jobCd: widget.jobCd,
      empNo: widget.empNo,
      directorat: widget.directorat,
      corpFg: widget.corpFg,
      allCorp: widget.allCorp,
    );
  }
}
