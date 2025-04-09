import 'package:flutter/material.dart';
import '../../models/my_emotion.dart';

class AddEmotionDialog extends StatelessWidget {
  final List<String> sentimentos;
  final TextEditingController titleController;
  final TextEditingController descpController;
  final String itemSelecionado;
  final Function(String) onItemChanged;
  final Function(MyEmotion) onEmotionAdded;
  final DateTime date;

  const AddEmotionDialog({
    super.key,
    required this.sentimentos,
    required this.titleController,
    required this.descpController,
    required this.itemSelecionado,
    required this.onItemChanged,
    required this.onEmotionAdded,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nova emoção!'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            isExpanded: true,
            items:
                sentimentos.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
            onChanged: (String? novoItemSelecionado) {
              if (novoItemSelecionado != null) {
                onItemChanged(novoItemSelecionado);
              }
            },
            value: itemSelecionado,
          ),
          const SizedBox(height: 20.0),
          TextField(
            controller: descpController,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: 'Insirá a descrição:',
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        TextButton(
          child: const Text('Adicionar'),
          onPressed: () {
            if (titleController.text.isEmpty && descpController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Entre com a emoção do dia:'),
                  duration: Duration(seconds: 3),
                ),
              );
              return;
            } else {
              onEmotionAdded(
                MyEmotion(
                  emocao: titleController.text,
                  descricao: descpController.text,
                  data: date,
                ),
              );
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
