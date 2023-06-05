import 'package:dartt_maat_v2/models/ocurrency_model.dart';
import 'package:dartt_maat_v2/models/procurador_model.dart';
import 'package:dartt_maat_v2/pages/ocurrency/controller/ocurrency_controller.dart';
import 'package:dartt_maat_v2/pages/ocurrency/view/ocurrency_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clipboard/clipboard.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ScreenDetail extends StatefulWidget {
  ScreenDetail({Key? key}) : super(key: key);
  // final OcurrencyModel ocurrency;
  final OcurrencyModel ocurrency = Get.arguments;

  @override
  State<ScreenDetail> createState() => _ScreenDetailState();
}

class _ScreenDetailState extends State<ScreenDetail> {
  String tooltipText = 'Clique para copiar';
  @override
  Widget build(BuildContext context) {
      final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();
      final controller = Get.find<OcurrencyController>();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Detalhes'),
          actions: [
            IconButton(
                onPressed: () async {
                  final filePDF =
                        await controller.fileOcurrencyPDF(widget.ocurrency);
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                OcurrencyView(file: filePDF)));
                },
                icon: const Icon(Icons.picture_as_pdf))
          ],
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(children: [
                Align(
                    alignment: Alignment.center,
                    child: Text("Reclamação - ${widget.ocurrency.protocolo}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold))),
                const SizedBox(height: 8.0),
                const Divider(),
                const SizedBox(height: 8.0),
                /*Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        Text('Última atualização: ${widget.ocurrency.dataAt}'),
                  ),*/
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'Data da reclamação: ${widget.ocurrency.dataRegistro}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'Canal de atendimento: ${widget.ocurrency.channel!.name}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Solicitante: ${widget.ocurrency.user!.name}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Situação: ${widget.ocurrency.status!.name}'),
                ),
                const Divider(),
                const SizedBox(height: 8.0),
                const Align(
                    alignment: Alignment.center,
                    child: Text("Dados do cliente",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold))),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 4,
                            child: Text(
                                'Nome: ${widget.ocurrency.cliente!.nome}')),
                        Expanded(
                          flex: 1,
                          child: Tooltip(
                              key: tooltipkey,
                              preferBelow: false,
                              triggerMode: TooltipTriggerMode.manual,
                              showDuration: const Duration(seconds: 1),
                              message: tooltipText,
                              child: IconButton(
                                  onPressed: () {
                                    FlutterClipboard.copy(
                                      '${widget.ocurrency.cliente!.nome}').then((value) {
                                        changeTooltipText();
                                        tooltipkey.currentState?.ensureTooltipVisible();
                                      });
                                  },
                                  icon: const Icon(Icons.copy_all))),
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 4,
                            child:
                                Text('CPF: ${widget.ocurrency.cliente!.cpf}')),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                                onTap: () {
                                  FlutterClipboard.copy(
                                          '${widget.ocurrency.cliente!.cpf}')
                                      // ignore: avoid_print
                                      .then((value) => print('copied'));
                                },
                                child: const Icon(Icons.copy_all)))
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 4,
                            child: Text(
                                'Data de nascimento: ${widget.ocurrency.cliente!.nascimento}')),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                                onTap: () {
                                  FlutterClipboard.copy(
                                          '${widget.ocurrency.cliente!.nascimento}')
                                      // ignore: avoid_print
                                      .then((value) => print('copied'));
                                },
                                child: const Icon(Icons.copy_all)))
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 4,
                            child: Text(
                                'Email: ${widget.ocurrency.cliente!.email}')),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                                onTap: () {
                                  FlutterClipboard.copy(
                                          '${widget.ocurrency.cliente!.email}')
                                      // ignore: avoid_print
                                      .then((value) => print('copied'));
                                },
                                child: const Icon(Icons.copy_all)))
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 4,
                            child: Text(
                                'Telefone/whatsapp: ${widget.ocurrency.cliente!.foneWhats}')),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                                onTap: () {
                                  FlutterClipboard.copy(
                                          '${widget.ocurrency.cliente!.foneWhats}')
                                      // ignore: avoid_print
                                      .then((value) => print('copied'));
                                },
                                child: const Icon(Icons.copy_all)))
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 4,
                            child: Text(
                                'Telefone: ${widget.ocurrency.cliente!.telefone}')),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                                onTap: () {
                                  FlutterClipboard.copy(
                                          '${widget.ocurrency.cliente!.telefone}')
                                      // ignore: avoid_print
                                      .then((value) => print('copied'));
                                },
                                child: const Icon(Icons.copy_all)))
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 4,
                            child:
                                Text('CEP: ${widget.ocurrency.cliente!.cep}')),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                                onTap: () {
                                  FlutterClipboard.copy(
                                          '${widget.ocurrency.cliente!.cep}')
                                      // ignore: avoid_print
                                      .then((value) => print('copied'));
                                },
                                child: const Icon(Icons.copy_all)))
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 4,
                            child: Text(
                                'Endereço: ${widget.ocurrency.cliente!.logradouro}')),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                                onTap: () {
                                  FlutterClipboard.copy(
                                          '${widget.ocurrency.cliente!.logradouro}')
                                      // ignore: avoid_print
                                      .then((value) => print('copied'));
                                },
                                child: const Icon(Icons.copy_all)))
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 4,
                            child: Text(
                                'Número: ${widget.ocurrency.cliente!.numero}')),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                                onTap: () {
                                  FlutterClipboard.copy(
                                          '${widget.ocurrency.cliente!.numero}')
                                      // ignore: avoid_print
                                      .then((value) => print('copied'));
                                },
                                child: const Icon(Icons.copy_all)))
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 4,
                            child: Text(
                                'Bairro: ${widget.ocurrency.cliente!.bairro}')),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                                onTap: () {
                                  FlutterClipboard.copy(
                                          '${widget.ocurrency.cliente!.bairro}')
                                      // ignore: avoid_print
                                      .then((value) => print('copied'));
                                },
                                child: const Icon(Icons.copy_all)))
                      ],
                    ),
                  ),
                ),
                if (widget.ocurrency.cliente!.procurador!.nome != null)
                  ScreenProcurador(
                      procurador: widget.ocurrency.cliente!.procurador!),
                const SizedBox(height: 8.0),
                for (var item in widget.ocurrency.fornecedores!)
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        Align(
                            alignment: Alignment.center,
                            child: Text(
                                'Dados do Fornecedor ${widget.ocurrency.fornecedores!.indexOf(item)}',
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold))),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 4, child: Text('CNPJ: ${item.cnpj}')),
                                Expanded(
                                    flex: 1,
                                    child: InkWell(
                                        onTap: () {
                                          FlutterClipboard.copy('${item.cnpj}')
                                              // ignore: avoid_print
                                              .then((value) => print('copied'));
                                        },
                                        child: const Icon(Icons.copy_all)))
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: Text(
                                        'Razão Social: ${item.razaoSocial}')),
                                Expanded(
                                    flex: 1,
                                    child: InkWell(
                                        onTap: () {
                                          FlutterClipboard.copy(
                                                  '${item.razaoSocial}')
                                              // ignore: avoid_print
                                              .then((value) => print('copied'));
                                        },
                                        child: const Icon(Icons.copy_all)))
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: Text(
                                        'Nome Fantasia: ${item.fantasia}')),
                                Expanded(
                                    flex: 1,
                                    child: InkWell(
                                        onTap: () {
                                          FlutterClipboard.copy(
                                                  '${item.fantasia}')
                                              // ignore: avoid_print
                                              .then((value) => print('copied'));
                                        },
                                        child: const Icon(Icons.copy_all)))
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: Text('Situação: ${item.situacao}')),
                                Expanded(
                                    flex: 1,
                                    child: InkWell(
                                        onTap: () {
                                          FlutterClipboard.copy(
                                                  '${item.situacao}')
                                              // ignore: avoid_print
                                              .then((value) => print('copied'));
                                        },
                                        child: const Icon(Icons.copy_all)))
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: Text('Telefone: ${item.telefone}')),
                                Expanded(
                                    flex: 1,
                                    child: InkWell(
                                        onTap: () {
                                          FlutterClipboard.copy(
                                                  '${item.telefone}')
                                              // ignore: avoid_print
                                              .then((value) => print('copied'));
                                        },
                                        child: const Icon(Icons.copy_all)))
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: Text('Email: ${item.email}')),
                                Expanded(
                                    flex: 1,
                                    child: InkWell(
                                        onTap: () {
                                          FlutterClipboard.copy('${item.email}')
                                              // ignore: avoid_print
                                              .then((value) => print('copied'));
                                        },
                                        child: const Icon(Icons.copy_all)))
                              ],
                            ),
                          ),
                        ),
                      ])),
                const SizedBox(height: 8.0),
                const Align(
                    alignment: Alignment.center,
                    child: Text("Detalhes",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold))),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 4,
                            child: Text(
                                'Data da compra/reclamação: ${widget.ocurrency.dataOcorrencia}')),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                                onTap: () {
                                  FlutterClipboard.copy(
                                          '${widget.ocurrency.dataOcorrencia}')
                                      // ignore: avoid_print
                                      .then((value) => print('copied'));
                                },
                                child: const Icon(Icons.copy_all)))
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 4,
                            child: Text(
                                'Tipo de ocorrência: ${widget.ocurrency.typeOcurrencyId!.name} - ${widget.ocurrency.typeOcurrencyId!.description}')),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                                onTap: () {
                                  FlutterClipboard.copy(
                                          '${widget.ocurrency.typeOcurrencyId!.name} - ${widget.ocurrency.typeOcurrencyId!.description}')
                                      // ignore: avoid_print
                                      .then((value) => print('copied'));
                                },
                                child: const Icon(Icons.copy_all)))
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 4,
                            child: Text(
                                'Descrição da reclamação: ${widget.ocurrency.ocorrencia}')),
                        Expanded(
                            flex: 1,
                            child: InkWell(
                                onTap: () {
                                  FlutterClipboard.copy(
                                          '${widget.ocurrency.ocorrencia}')
                                      // ignore: avoid_print
                                      .then((value) => print('copied'));
                                },
                                child: const Icon(Icons.copy_all)))
                      ],
                    ),
                  ),
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Comentários: ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                if (widget.ocurrency.comentarios != null)
                  for (var item in widget.ocurrency.comentarios!)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(item.description!),
                    ),
                Column(children: [
                  const Divider(),
                  const Align(
                      alignment: Alignment.center,
                      child: Text("Anexos",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold))),
                  const Divider(),
                  for (var an in widget.ocurrency.anexos!)
                    InkWell(
                        child: Text('${an.name}'),
                        onTap: () => launchUrlString('${an.url}'))
                ]),
              ]),
            ),
          ],
        ));
  }
    void changeTooltipText() {
    setState(() {
      tooltipText = 'Copiado!';
    });
  }
}

class ScreenProcurador extends StatelessWidget {
  const ScreenProcurador({super.key, required this.procurador});
  final ProcuradorModel procurador;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 8.0),
      const Align(
          alignment: Alignment.center,
          child: Text("Dados do procurador",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
      Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  flex: 4, child: Text('Nome procurador: ${procurador.nome}')),
              Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () {
                        FlutterClipboard.copy('${procurador.nome}').then(
                          (value) => const Tooltip(
                            triggerMode: TooltipTriggerMode.manual,
                            showDuration: Duration(seconds: 1),
                            message: 'Copiado',
                          ),
                        );
                      },
                      child: const Icon(Icons.copy_all)))
            ],
          ),
        ),
      ),
      Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(flex: 4, child: Text('CPF: ${procurador.cpf}')),
              Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () {
                        FlutterClipboard.copy('${procurador.cpf}')
                            // ignore: avoid_print
                            .then((value) => print('copied'));
                      },
                      child: const Icon(Icons.copy_all)))
            ],
          ),
        ),
      ),
      Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Text('Data de nascimento: ${procurador.nascimento}')),
              Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () {
                        FlutterClipboard.copy('${procurador.nascimento}')
                            // ignore: avoid_print
                            .then((value) => print('copied'));
                      },
                      child: const Icon(Icons.copy_all)))
            ],
          ),
        ),
      ),
    ]);
  }
}
