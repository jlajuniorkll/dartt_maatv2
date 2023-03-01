import 'package:dartt_maat_v2/common/custom_textfield.dart';
import 'package:dartt_maat_v2/models/typeocurrency_model.dart';
import 'package:dartt_maat_v2/pages/ocurrency/controller/ocurrency_controller.dart';
import 'package:dartt_maat_v2/pages/typeocurrency/controller/typeocurrency_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class FormDescription extends StatefulWidget {
  const FormDescription({super.key});

  @override
  State<FormDescription> createState() => _FormDescriptionState();
}

class _FormDescriptionState extends State<FormDescription> {
  late bool iconClose;

  @override
  void initState() {
    super.initState();
    iconClose = false;
  }

  @override
  Widget build(BuildContext context) {
    final controllerType = Get.find<TypeOcurrencyController>();
    final controller = Get.find<OcurrencyController>();
    return Form(
        key: controller.formKeyDescription,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Text(
                'Detalhes da reclamação',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
                                    Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child: const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text:
                            'Escolha abaixo ou pesquise o tipo de reclamação, e após preencha o fato ocorrido.'),
                  ],
                ),
              ),
            ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TypeAheadFormField(
                  hideOnEmpty: false,
                  hideOnLoading: true,
                  hideSuggestionsOnKeyboardHide: true,
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: controller.typeOcurrencyController,
                    autofocus: false,
                    decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                            onTap: iconClose == false
                                ? null
                                : () {
                                    controller.setTypeOcurrecyController('');
                                    setState(() {
                                      iconClose = false;
                                    });
                                  },
                            child: iconClose == true
                                ? const Icon(Icons.close)
                                : const Icon(Icons.arrow_downward)),
                        isDense: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18)),
                        hintText: 'Selecione aqui o tipo de reclamação...'),
                  ),
                  suggestionsCallback: (pattern) async {
                    controller.setSuggestion(false);
                    return await controllerType.getSuggestions(pattern);
                  },
                  itemBuilder: (context, TypeOcurrencyModel suggestion) {
                    return ListTile(
                      title: Text(suggestion.name!),
                      subtitle: Text('${suggestion.description}'),
                    );
                  },
                  onSuggestionSelected: (TypeOcurrencyModel suggestion) {
                    controller.typeOcurrency = suggestion;
                    controller.setTypeOcurrecyController(suggestion.name!);
                    setState(() {
                      iconClose = true;
                    });
                    controller.setSuggestion(true);
                  },
                  onSaved: (value) =>
                      controller.setTypeOcurrecyController(value!),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Selecione o tipo de ocorrencia";
                    } else if (controller.notSuggestion.value == false) {
                      return "Selecione uma das opções abaixo";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: CustomTextField(
                  maxLines: null,
                  label: 'Descreva o fato ocorrido',
                  iniValue: controller.ocurrency.ocorrencia,
                  onSaved: (newValue) =>
                      controller.ocurrency.ocorrencia = newValue!,
                  validator: (ocorrencia) {
                    if (ocorrencia!.isEmpty) {
                      return 'O descrição do fato é obrigatório';
                    } else if (ocorrencia.trim().split(' ').length <= 2) {
                      return "Preencha a descrição do fato detalhadamente!";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ])));
  }
}
