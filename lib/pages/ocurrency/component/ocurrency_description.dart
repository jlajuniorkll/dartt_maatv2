import 'package:dartt_maat_v2/common/custom_textfield.dart';
import 'package:dartt_maat_v2/models/typeocurrency_model.dart';
import 'package:dartt_maat_v2/pages/ocurrency/controller/ocurrency_controller.dart';
import 'package:dartt_maat_v2/pages/typeocurrency/controller/typeocurrency_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class FormDescription extends StatelessWidget {
  const FormDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OcurrencyController>();
    final controllerType = Get.find<TypeOcurrencyController>();
    return Form(
        key: controller.formKeyDescription,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Text(
                'Dados do Consumidor',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 16,
              ),
              TypeAheadFormField(
                hideOnEmpty: false,
                hideOnLoading: true,
                hideSuggestionsOnKeyboardHide: true,
                textFieldConfiguration: const TextFieldConfiguration(
                  autofocus: false,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.arrow_downward),
                      border: OutlineInputBorder(),
                      hintText: 'Selecione aqui o tipo de reclamação...'),
                ),
                suggestionsCallback: (pattern) async {
                  controllerType.setSuggestion(false);
                  return await controllerType.getSuggestions(pattern);
                },
                itemBuilder: (context, TypeOcurrencyModel suggestion) {
                  return ListTile(
                    title: Text(suggestion.name!),
                    subtitle: Text('${suggestion.description}'),
                  );
                },
                onSuggestionSelected: (TypeOcurrencyModel suggestion) {
                  controllerType.setSuggestion(true);
                },
                onSaved: (value) {},
                validator: (value) {},
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.camera),
                      label: const Text("Tirar foto")),
                  const SizedBox(
                    width: 32,
                  ),
                  ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.attach_file),
                      label: const Text("Anexar arquivo")),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: CustomTextField(
                  maxLines: null,
                  label: 'Descreva o fato ocorrido',
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
