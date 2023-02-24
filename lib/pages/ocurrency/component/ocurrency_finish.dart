import 'package:flutter/material.dart';

class OcurrencyFinish extends StatelessWidget {
  const OcurrencyFinish({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.of(context).size.width < 800;
    var widhtMobile = MediaQuery.of(context).size.width;
    var widhtWeb = MediaQuery.of(context).size.width * .7;
    return Center(
      child: SizedBox(
        width: isMobile ? widhtMobile : widhtWeb,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              shrinkWrap: true,
              children: [
              Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: const Text(
                    'Reclamação realizada com sucesso',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  )),
              const SizedBox(
                height: 16,
              ),
              const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'Sua reclamação foi efetuada com sucesso! ',
                            style: TextStyle(fontSize: 16)),
                        TextSpan(
                            text: 'Prazo para retorno em 10 dias. ',
                            style:
                                TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                'Ao fechar esta tela aparecerá a lista de suas reclamações. Acompanhe a sua reclamação quando quiser, utilizando o mesmo link e digitando seu usuário e senha cadastrado. ',
                            style: TextStyle(fontSize: 16)),
                        TextSpan(
                            text: 'Fique de olho em seu email ',
                            style:
                                TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: '(verifique sua caixa de spam), ',
                            style:
                                TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
                        TextSpan(
                            text:
                                'podemos dar um retorno por este canal. Agradecemos o seu contato.',
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  )),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 44,
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("OK")),
                      ),
                    ),
                  ])
            ]),
          ),
        ),
      ),
    );
  }
}

