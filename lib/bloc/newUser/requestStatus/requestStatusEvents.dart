abstract class RequestStatusEvents {}

class FirstLoadEventRS extends RequestStatusEvents {
  final String jobCd;
  final String strCd;
  final String empNo;
  final String corpFg;
  final String directorat;
  final String allCorp;

  FirstLoadEventRS(this.jobCd,this.strCd,this.empNo,this.corpFg,this.directorat,this.allCorp);

}