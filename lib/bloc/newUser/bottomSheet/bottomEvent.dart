
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