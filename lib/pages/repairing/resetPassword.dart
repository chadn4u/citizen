import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:citizens/bloc/repairing/resetPassword/resetPasswordBloc.dart';
import 'package:citizens/bloc/repairing/resetPassword/resetPasswordEvents.dart';
import 'package:citizens/bloc/repairing/resetPassword/resetPasswordState.dart';
import 'package:citizens/models/repairing/resetPassword/searchList.dart';
import 'package:citizens/models/repairing/resetPassword/searchListFeed.dart';
import 'package:citizens/models/responseDio/responseDio.dart';
import 'package:citizens/provider/resetPasswordProvider.dart';
import 'package:citizens/utils/colors.dart';
import 'package:citizens/utils/const.dart';
import 'package:citizens/utils/extensions.dart';
import 'package:citizens/utils/mainUtils.dart';
import 'package:citizens/widget/newUser/button4.dart';
import 'package:dio/dio.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatelessWidget {
  final String empNo;

  ResetPassword({Key key, this.empNo}) : super(key: key);
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
                                          context,
                                          searchListFeed.data[idx],
                                          responseDio);
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

  Widget _cardList(
      BuildContext context, SearchListReset data, ResponseDio responseDio) {
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
                MaterialButton(
                  child: text('Reset Password',
                      fontSize: textSizeLargeMedium,
                      textColor: colorWhite,
                      fontFamily: fontMedium),
                  textColor: colorWhite,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                  color: colorPrimary,
                  onPressed: () {
                    Future.delayed(const Duration(milliseconds: 500), () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => CustomDialog(
                          textDialog: 'reset password',
                          empNo: data.empNo,
                          flagBloc: 0,
                          responseDio: responseDio,
                          empNoReq: empNo,
                          resetPasswordBloc: resetPasswordBloc,
                        ),
                      );
                    });
                  },
                ),
                MaterialButton(
                  child: text('Enable User',
                      fontSize: textSizeLargeMedium,
                      textColor: colorWhite,
                      fontFamily: fontMedium),
                  textColor: colorWhite,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                  color: colorPrimary,
                  onPressed: () {
                    Future.delayed(const Duration(milliseconds: 500), () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => CustomDialog(
                          textDialog: 'enable user',
                          empNo: data.empNo,
                          flagBloc: 1,
                          responseDio: responseDio,
                          empNoReq: empNo,
                          resetPasswordBloc: resetPasswordBloc,
                        ),
                      );
                    });
                  },
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

class CustomDialog extends StatelessWidget {
  final String textDialog;
  final String empNo;
  final dynamic flagBloc;
  final ResponseDio responseDio;
  final String empNoReq;
  final ResetPasswordBloc resetPasswordBloc;

  const CustomDialog(
      {Key key, this.textDialog, this.empNo, this.flagBloc, this.responseDio,this.empNoReq,this.resetPasswordBloc})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context, textDialog,empNo,flagBloc,responseDio,empNoReq,resetPasswordBloc),
    );
  }
}

dialogContent(BuildContext context, String textDialog,String empNo,dynamic flagBloc,
ResponseDio responseDio,String empNoReq,ResetPasswordBloc resetPasswordBloc){
  return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          text("Are you sure you want to $textDialog?",
              fontSize: textSizeLargeMedium,
              maxLine: 2,
              isCentered: true,
              textColor: textColorPrimary,
              fontFamily: fontSemibold),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              T4Button(
                textContent: 'Submit',
                onPressed: () {
                  
                  if(flagBloc == 0){
                      resetPasswordBloc.add(ResetPasswordEvent(responseDio, empNo, empNoReq));
                  }else if(flagBloc == 1){
                    resetPasswordBloc.add(EnableUserEvent(responseDio, empNo, empNoReq));
                  }
                  else print(flagBloc);

                  Navigator.pop(context);
                },
              ),
              SizedBox(
                width: 24,
              ),
              T4Button(
                textContent: 'Cancel',
                isStroked: true,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ));
}
