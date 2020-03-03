import 'package:flutter/material.dart';

abstract class UserEvents {}

class FirstLoadEvent extends UserEvents {
  final String jobCd;
  final String strCd;
  final String empNo;
  final String corpFg;
  final int min;
  final int max;

  FirstLoadEvent(this.jobCd, this.strCd, this.empNo, this.corpFg, this.min, this.max);
}

class FirstLoadSearchEvent extends UserEvents {
  final String jobCd;
  final String strCd;
  final String empNo;
  final String corpFg;
  final int min;
  final int max;
  final String pilihan;
  final String konten;

  FirstLoadSearchEvent(this.jobCd, this.strCd, this.empNo, this.corpFg, this.min, this.max, this.pilihan, this.konten);


}

class LoadMoreEvent extends UserEvents {
  final String jobCd;
  final String strCd;
  final String empNo;
  final String corpFg;
  final int min;
  final int max;
  final int totalData;

  LoadMoreEvent(this.jobCd, this.strCd, this.empNo, this.corpFg, this.min, this.max, this.totalData);

}

class LoadMoreSearchEvent extends UserEvents {
  final String jobCd;
  final String strCd;
  final String empNo;
  final String corpFg;
  final int min;
  final int max;
  final int totalData;
  final String pilihan;
  final String konten;

  LoadMoreSearchEvent(this.jobCd, this.strCd, this.empNo, this.corpFg, this.min, this.max, this.totalData, this.pilihan, this.konten);
}
