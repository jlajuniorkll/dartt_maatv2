import 'package:dartt_maat_v2/config/custom_colors.dart';
import 'package:flutter/material.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Comentários'),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFF3366FF),
                    Color(0xFF00CCFF),
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
        ),
        body: Stack(
          children: [
            Positioned(
                bottom: 4,
                left: 8,
                right: 80,
                child: Card(
                  elevation: 10,
                  child: TextFormField(
                      // initialValue: initialText,
                      autofocus: true,
                      textInputAction: TextInputAction.search,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Digite aqui seu comentário...",
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 24),
                      ),
                      onFieldSubmitted: (text) {
                        Navigator.of(context).pop(text);
                      }),
                )),
            Positioned(
              bottom: 4,
              right: 0,
              child: RawMaterialButton(
                onPressed: () {},
                elevation: 5,
                fillColor: CustomColors.customSwatchColor,
                padding: const EdgeInsets.all(15.0),
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.send,
                  size: 24.0,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ));
  }
}
