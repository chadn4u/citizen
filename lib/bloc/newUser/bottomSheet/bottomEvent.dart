
abstract class BottomEvent{}

class GetDivisionEvent extends BottomEvent{
  final String jobCd;
  final String strCd;

  GetDivisionEvent(this.jobCd, this.strCd);
}

class GetStoreEvent extends BottomEvent{
  final String strCd;
  final String jobCd;
  final String allCorp;

  GetStoreEvent(this.strCd, this.jobCd, this.allCorp);


}

class SubmitUser extends BottomEvent{
  final String empNoReq;
  final String empNo;
  final String empNm;
  final String jobCd;
  final String strCd;
  final String empId;
  final String emailFg;
  final String sapFg;
  final String b2bFg;
  final String netFg;
  final String gmdFg;
  final String wifiFg;
  final String corpFg;
  final String mobileFg;

  SubmitUser(this.empNoReq, this.empNo, this.empNm, this.jobCd, this.strCd, this.empId, this.emailFg, this.sapFg, this.b2bFg, this.netFg, this.gmdFg, this.wifiFg, this.corpFg, this.mobileFg);

}