abstract class NewUserEvents {}

class FirstLoadEvent extends NewUserEvents {
  final String jobCd;
  final String strCd;
  final String empNo;
  final String corpFg;
  final String directorat;
  final int min;
  final int max;
  final int totalData;

  FirstLoadEvent(this.jobCd, this.strCd, this.empNo, this.corpFg, this.directorat, this.min, this.max, this.totalData);
}

class LoadMoreEvent extends NewUserEvents {}
