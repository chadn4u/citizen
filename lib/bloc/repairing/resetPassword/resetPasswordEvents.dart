abstract class ResetPasswordEvents {}

class FirstLoadEvent extends ResetPasswordEvents {
  final String pilihan;
  final String konten;

  FirstLoadEvent(this.pilihan,this.konten);
}

