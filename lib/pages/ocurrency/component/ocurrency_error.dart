import 'package:flutter/material.dart';

class OcurrencyError extends StatelessWidget {
  const OcurrencyError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.of(context).size.width < 800;
    var widhtMobile = MediaQuery.of(context).size.width;
    var widhtWeb = MediaQuery.of(context).size.width * .7;
    return Center(
      child: SizedBox(
        width: isMobile ? widhtMobile : widhtWeb,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(shrinkWrap: true, children: [
              Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: const Text(
                    'Atenção!',
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
                            text: 'Selecione uma das opções para prosseguir ',
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
