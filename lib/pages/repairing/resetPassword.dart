import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:citizens/bloc/repairing/resetPassword/resetPasswordBloc.dart';
import 'package:citizens/bloc/repairing/resetPassword/resetPasswordEvents.dart';
import 'package:citizens/bloc/repairing/resetPassword/resetPasswordState.dart';
import 'package:citizens/models/repairing/resetPassword/searchList.dart';
import 'package:citizens/models/repairing/resetPassword/searchListFeed.dart';
import 'package:citizens/models/responseDio/responseDio.dart';
import 'package:citizens/provider/resetPasswordProvider.dart';
import 'package:citizens/utils/colors.dart';
import 'package:citizens/utils/mainUtils.dart';
import 'package:dio/dio.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  ResetPasswordBloc resetPasswordBloc;

  @override
  Widget build(BuildContext context) {
    resetPasswordBloc = ResetPasswordBloc();
    ProgressDialog pr =
        ProgressDialog(context, isDismissible: true, showLogs: true);
    pr.style(message: 'Please Wait...');
    return ChangeNotifierProvider<ResetPasswordProvider>(
      create: (context) => ResetPasswordProvider(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Reset Password + Enable'),
          backgroundColor: colorPrimary,
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5),
                width: double.infinity,
                child: ExpandablePanel(
                  header: ListTile(
                    title: Consumer<ResetPasswordProvider>(
                        builder: (context, resetPasswordProvider, _) =>
                            TextFormField(
                              textInputAction: TextInputAction.go,
                              onFieldSubmitted: (value) {
                                if (value.isNotEmpty) {
                                  resetPasswordProvider.isSearch = true;
                                  String pilihan = 'EMP_NO';

                                  if (resetPasswordProvider.isSelectedEmpId)
                                    pilihan = 'EMP_NO';
                                  else if (resetPasswordProvider
                                      .isSelectedEmpNm) pilihan = 'EMP_NM';

                                  resetPasswordBloc
                                      .add(FirstLoadEvent(pilihan, value));
                                } else {
                                  _scaffoldKey.currentState
                                      .removeCurrentSnackBar();
                                  _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Search string cant null')));
                                }
                              },
                              controller: searchController,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                hintText: 'Search',
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 15),
                                prefixIcon: GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    if (searchController.text.isNotEmpty) {
                                      if (resetPasswordProvider.isSearch) {
                                        searchController.clear();
                                        resetPasswordProvider.isSearch = false;
                                      } else {
                                        resetPasswordProvider.isSearch = true;

                                        String pilihan = 'EMP_NO';

                                        if (resetPasswordProvider
                                            .isSelectedEmpId)
                                          pilihan = 'EMP_NO';
                                        else if (resetPasswordProvider
                                            .isSelectedEmpNm)
                                          pilihan = 'EMP_NM';

                                        resetPasswordBloc.add(FirstLoadEvent(
                                            pilihan, searchController.text));
                                      }
                                    } else {
                                      if (resetPasswordProvider.isSearch) {
                                        resetPasswordProvider.isSearch = false;
                                      } else {
                                        _scaffoldKey.currentState
                                            .removeCurrentSnackBar();
                                        _scaffoldKey.currentState.showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    'Search string cant be null')));
                                      }
                                    }
                                  },
                                  child: Icon(
                                    (resetPasswordProvider.isSearch)
                                        ? Icons.close
                                        : Icons.search,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )),
                    trailing: Icon(Icons.filter_list),
                  ),
                  hasIcon: false,
                  expanded: Column(
                    children: <Widget>[
                      SizedBox(height: 14),
                      Text('Filter By'),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Consumer<ResetPasswordProvider>(
                            builder: (context, resetPasswordProvider, _) =>
                                GestureDetector(
                              onTap: () {
                                if (resetPasswordProvider.isSelectedEmpId)
                                  resetPasswordProvider.isSelectedEmpId = false;
                                else
                                  resetPasswordProvider.isSelectedEmpId = true;
                              },
                              child: Chip(
                                padding: EdgeInsets.all(10),
                                label: Text(
                                  'Employee Id',
                                  style: TextStyle(color: colorWhite),
                                ),
                                backgroundColor:
                                    resetPasswordProvider.colorEmployeeId,
                              ),
                            ),
                          ),
                          Consumer<ResetPasswordProvider>(
                            builder: (context, resetPasswordProvider, _) =>
                                GestureDetector(
                              onTap: () {
                                if (resetPasswordProvider.isSelectedEmpNm)
                                  resetPasswordProvider.isSelectedEmpNm = false;
                                else
                                  resetPasswordProvider.isSelectedEmpNm = true;
                              },
                              child: Chip(
                                padding: EdgeInsets.all(10),
                                label: Text(
                                  'Employee Name',
                                  style: TextStyle(color: colorWhite),
                                ),
                                backgroundColor:
                                    resetPasswordProvider.colorEmployeeNm,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    color: colorWhite,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                          spreadRadius: 2.0,
                          offset: Offset(2, 5))
                    ],
                    border: Border.all(width: 1, color: Colors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
              ),
              SizedBox(
                height: 20,
              ),
              BlocProvider(
                create: (BuildContext context) => resetPasswordBloc,
                child: Expanded(
                  child: Container(
                    child: Consumer<ResetPasswordProvider>(
                      builder: (context, resetPasswordProvider, _) {
                        if (resetPasswordProvider.isSearch) {
                          return BlocBuilder<ResetPasswordBloc,
                              ResetPasswordState>(
                            builder: (ctx, state) {
                              if (state is SearchListUninitialized) {
                                Future.microtask(() async => await pr.show());
                                return Center(
                                    child: Text('Uninitialized State'));
                              } else if (state is SearchListEmpty) {
                                print('wadaw');
                                return Center(child: Text('No Data Found'));
                              } else if (state is SearchListLoading) {
                                return Center(
                                  child: TypewriterAnimatedTextKit(
                                      speed: Duration(milliseconds: 1000),
                                      totalRepeatCount: 5,
                                      text: ['Loading Data...'],
                                      textStyle: TextStyle(
                                          fontSize: 30.0, fontFamily: "Agne"),
                                      textAlign: TextAlign.start,
                                      alignment: AlignmentDirectional.topStart),
                                );
                              } else if (state is SearchListError) {
                                final stateError = state;
                                DioError dioError = stateError.dioError;
                                Utils()
                                    .onError(_scaffoldKey, dioError, context);
                                Future.delayed(Duration(seconds: 3))
                                    .then((value) {
                                  pr.hide();
                                });

                                return Center(
                                  child: Text(dioError.response.toString()),
                                );
                              } else {
                                Future.delayed(Duration(seconds: 1))
                                    .then((value) {
                                  pr.hide();
                                });
                                final stateAsListFetched =
                                    state as SearchListFetched;
                                ResponseDio responseDio =
                                    stateAsListFetched.responsedio;
                                SearchListFeed searchListFeed =
                                    responseDio.data;

                                return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: searchListFeed.data.length,
                                    itemBuilder: (BuildContext ctx, int idx) {
                                      return _cardList(
                                          context, searchListFeed.data[idx]);
                                    });
                              }
                            },
                          );
                        } else {
                          return Center(
                            child: Text('Search Something'),
                          );
                        }
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardList(BuildContext context, SearchListReset data) {
    return Container(
      padding: EdgeInsets.all(5),
      width: double.infinity,
      child: ExpandablePanel(
        header: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(data.empNm),
            subtitle: Text(data.empNo),
          ),
        ),
        expanded: Column(
          children: <Widget>[
            SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Reset Password',
                      style: TextStyle(color: colorWhite),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        color: colorPrimary),
                  ),
                ),
                InkWell(
                  onTap: () {
                    print('asdw');
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Enable User',
                        style: TextStyle(color: colorWhite),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          color: colorPrimary)),
                ),
              ],
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
          color: colorWhite,
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
                spreadRadius: 2.0,
                offset: Offset(2, 5))
          ],
          border: Border.all(width: 1, color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(4))),
    );
  }
}
