import 'package:citizens/models/responseDio/responseDio.dart';

abstract class ResetPasswordEvents {}

class FirstLoadEvent extends ResetPasswordEvents {
  final String pilihan;
  final String konten;

  FirstLoadEvent(this.pilihan,this.konten);
}

class ResetPasswordEvent extends ResetPasswordEvents{
  final ResponseDio responseDio;
  final String empNo;
  final String empNoReq;

  ResetPasswordEvent(this.responseDio, this.empNo,this.empNoReq);
}

class EnableUserEvent extends ResetPasswordEvents{
  final ResponseDio responseDio;
  final String empNo;
  final String empNoReq;

  EnableUserEvent(this.responseDio, this.empNo,this.empNoReq);
}

