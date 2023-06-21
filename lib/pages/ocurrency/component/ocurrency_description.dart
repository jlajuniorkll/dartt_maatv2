import 'package:dartt_maat_v2/config/custom_colors.dart';
import 'package:dartt_maat_v2/models/typeocurrency_model.dart';
import 'package:dartt_maat_v2/pages/ocurrency/controller/ocurrency_controller.dart';
import 'package:dartt_maat_v2/pages/typeocurrency/controller/typeocurrency_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class FormDescription extends StatelessWidget {
  FormDescription({super.key});

  late TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TypeOcurrencyModel typeOcurrencyModel = TypeOcurrencyModel();
    return GetBuilder<OcurrencyController>(builder: (controller) {
      return Form(
          key: controller.formKeyDescription,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  child: GetBuilder<TypeOcurrencyController>(
                      builder: (typeController) {
                    if (controller.ocurrency.typeOcurrencyId != null) {
                      typeOcurrencyModel =
                          controller.ocurrency.typeOcurrencyId!;
                      // controller.setTypeOcurrency(typeOcurrencyModel);
                      typeController.setTypeSelected(typeOcurrencyModel.id!);
                    }
                    return Column(mainAxisSize: MainAxisSize.min, children: [
                      const Text(
                        'Detalhes da reclamação',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        child: const Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text:
                                      'Escolha abaixo ou pesquise o tipo de reclamação.'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.search),
                                  suffixIcon: typeController
                                          .searchTitle.value.isNotEmpty
                                      ? IconButton(
                                          onPressed: () {
                                            searchController.clear();
                                            typeController.searchTitle.value =
                                                '';
                                            FocusScope.of(context).unfocus();
                                          },
                                          icon: const Icon(Icons.close))
                                      : null,
                                  labelText: 'Pesquisar o tipo de reclamação',
                                  isDense: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(18))),
                              maxLines: null,
                              controller: searchController,
                              onChanged: (value) {
                                typeController.searchTitle.value = value;
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount:
                              typeController.allTypeOcurrencyFiltered.length,
                          itemBuilder: (_, index) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border: typeController.isTypeSelected ==
                                        typeController
                                            .allTypeOcurrencyFiltered[index].id!
                                    ? Border.all(
                                        color: CustomColors
                                            .customSwatchColor, // Define a cor da borda
                                        width: 2.0, // Define a largura da borda
                                      )
                                    : null,
                              ),
                              child: RadioListTile<TypeOcurrencyModel>(
                                activeColor: CustomColors.customSwatchColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                value: typeController
                                    .allTypeOcurrencyFiltered[index],
                                groupValue: controller.typeOcurrency,
                                onChanged: (TypeOcurrencyModel? value) {
                                  //setState(() {
                                  // controller.typeOcurrency = value!;
                                  controller.setTypeOcurrency(value!);
                                  typeController.setTypeSelected(typeController
                                      .allTypeOcurrencyFiltered[index].id!);
                                  //});
                                },
                                title: Text(
                                    '${typeController.allTypeOcurrencyFiltered[index].name}'),
                                subtitle: Text(
                                    '${typeController.allTypeOcurrencyFiltered[index].description}'),
                                selected: typeController
                                        .allTypeOcurrencyFiltered[index] ==
                                    controller.typeOcurrency,
                              ),
                            );
                          },
                        ),
                      ),
                      /*TypeAheadFormField(
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
                  ),*/

                      const SizedBox(
                        height: 16,
                      ),
                    ]);
                  }))));
    });
  }
}
