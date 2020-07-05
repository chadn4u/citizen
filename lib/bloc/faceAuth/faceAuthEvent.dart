abstract class FaceAuthEvents {}

class CheckStatusEvent extends FaceAuthEvents {
  final String empNo;

  CheckStatusEvent(
    this.empNo,
  );
}
