import 'package:flutter/material.dart';
import 'package:setimachave/utils/colors.dart';
import 'package:image_picker/image_picker.dart';

class PickerImgBtn extends StatelessWidget {
  final String text;
  final background;
  final VoidCallback onPressed;
  
  const PickerImgBtn({
    Key? key,
    required this.text,
    required this.background,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40.0),
      child: ElevatedButton(
        onPressed: () async {
          final picker = ImagePicker();
          final pickedImage = await picker.pickImage(source: ImageSource.gallery);

          if (pickedImage != null) {
            // Do something with the selected image, such as displaying a preview
          } else {
            // The user didn't select an image
          }
        },
        child: Text('Selecionar Imagem'),
      ),
    );
  }
}
