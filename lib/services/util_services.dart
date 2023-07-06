import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class UtilsServices {
  final cpfFormatter = MaskTextInputFormatter(
      mask: '###.###.###-##', filter: {'#': RegExp(r'[0-9]')});

  final cepFormatter = MaskTextInputFormatter(
      mask: '#####-###', filter: {'#': RegExp(r'[0-9]')});

  final foneFormatter = MaskTextInputFormatter(
      mask: '(##)#.####-####', filter: {'#': RegExp(r'[0-9]')});
  final cnpjFormatter = MaskTextInputFormatter(
      mask: '##.###.###/####-##', filter: {'#': RegExp(r'[0-9]')});

  String getErrorString(String code) {
    switch (code) {
      case 'weak-password':
        return 'Sua senha é muito fraca.';
      case 'invalid-email':
        return 'Seu e-mail é inválido.';
      case 'email-already-in-use':
        return 'E-mail já está sendo utilizado em outra conta.';
      case 'invalid-credential':
        return 'Seu e-mail é inválido.';
      case 'wrong-password':
        return 'Sua senha está incorreta.';
      case 'user-not-found':
        return 'Não há usuário com este e-mail.';
      case 'user-disabled':
        return 'Este usuário foi desabilitado.';
      case 'too-many-requests':
        return 'Muitas solicitações. Tente novamente mais tarde.';
      case 'operation-not-allowed':
        return 'Operação não permitida.';

      default:
        return 'Erro desconhecido na autenticação.';
    }
  }

  String getDataAtual() {
    var dia = DateTime.now().day.toString();
    var mes = DateTime.now().month.toString();
    var ano = DateTime.now().year.toString();
    return '$dia/$mes/$ano';
  }

  String getDataHoraAtual() {
    var dia = DateTime.now().day;
    var mes = DateTime.now().month;
    var ano = DateTime.now().year.toString().padLeft(2, "0");
    var hora = DateTime.now().hour.toString().padLeft(2, "0");
    var min = DateTime.now().minute.toString().padLeft(2, "0");
    return '$dia/$mes/$ano - $hora:$min';
  }
}
