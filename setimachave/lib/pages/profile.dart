// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Profile extends StatefulWidget {
//   const Profile({Key? key}) : super(key: key);

//   @override
//   State<Profile> createState() => _ProfileState();
// }

// class _ProfileState extends State<Profile> {
//   late SharedPreferences _prefs;
//   String _username = "";
//   String _useremail = "";

//   @override
//   void initState() {
//     super.initState();
//     _loadPreferences();
//   }

//   Future<void> _loadPreferences() async {
//     _prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _username = _prefs.getString('userName') ?? "";
//       _useremail= _prefs.getString('userEmail') ?? "";
//     });
//   }

//   Future<void> _savePreferences(String username) async {
//     setState(() {
//       _username = username;
//     });
//     await _prefs.setString('username', username);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
//               child: ClipOval(
//                 child: Image.network(
//                   'https://lh3.googleusercontent.com/a/AAcHTtdDgZLF7oknFRvWkskpdezin2ePkGQsOtwxn1ri3uo8DUE=s96-c-rg-br100',
//                   width: 100, // Set the image width
//                   height: 100, // Set the image height
//                   fit: BoxFit.cover, // Choose the fill mode of the image
//                   loadingBuilder: (context, child, loadingProgress) {
//                     if (loadingProgress == null) return child;
//                     return Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   },
//                   errorBuilder: (context, error, stackTrace) {
//                     return Text('Error while loading the image');
//                   },
//                 ),
//               ),
//             ),
//             Text(
//               _username, 
//               style: TextStyle(
//                 fontSize: 20.0,
//                 fontFamily: 'Lora',
//                 fontWeight: FontWeight.w400
//               )
//             ),
//             Text(
//               _useremail, 
//               style: TextStyle(
//                 fontSize: 15.0,
//                 fontFamily: 'Lora',
//                 fontWeight: FontWeight.w400
//               )
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late SharedPreferences _prefs;
  String _username = "";
  String _useremail = "";
  File? _selectedImage; // Initialize to null

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = _prefs.getString('userName') ?? "";
      _useremail = _prefs.getString('userEmail') ?? "";
    });
  }

  Future<void> _savePreferences(String username) async {
    setState(() {
      _username = username;
    });
    await _prefs.setString('username', username);
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<String> _imageToBase64(File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    String mimeType = mime(imageFile.path) ?? "image/jpeg";
    String base64Image = base64Encode(imageBytes);
    return "data:$mimeType;base64,$base64Image";
  }

  Future<void> _uploadImageToApi() async {
    if (_selectedImage == null) {
      return;
    }

    String base64Image = await _imageToBase64(_selectedImage!);

    // Here, you can use the http package to send the base64Image to your API.
    // Replace 'YOUR_API_ENDPOINT' with the actual endpoint URL.
    final response = await http.post(
      Uri.parse('YOUR_API_ENDPOINT'),
      body: {
        'image': base64Image,
        // Add any other necessary data to the request body.
      },
    );

    // Handle the API response as needed.
    if (response.statusCode == 200) {
      // Image uploaded successfully.
      // Do something with the response.
    } else {
      // Failed to upload the image.
      // Handle the error.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: _pickImage,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
                child: _selectedImage != null
                    ? ClipOval(
                        child: Image.file(
                          _selectedImage!, // Use _selectedImage! with the non-null assertion
                          width: 100, // Set the image width
                          height: 100, // Set the image height
                          fit: BoxFit.cover, // Choose the fill mode of the image
                        ),
                      )
                    : ClipOval(
                        child: Image.network(
                          'https://lh3.googleusercontent.com/a/AAcHTtdDgZLF7oknFRvWkskpdezin2ePkGQsOtwxn1ri3uo8DUE=s96-c-rg-br100',
                          width: 100, // Set the image width
                          height: 100, // Set the image height
                          fit: BoxFit.cover, // Choose the fill mode of the image
                        ),
                      ),
              ),
            ),
            Text(
              _username,
              style: TextStyle(
                  fontSize: 20.0, fontFamily: 'Lora', fontWeight: FontWeight.w400),
            ),
            Text(
              _useremail,
              style: TextStyle(
                  fontSize: 15.0, fontFamily: 'Lora', fontWeight: FontWeight.w400),
            ),
            ElevatedButton(
              onPressed: _uploadImageToApi,
              child: Text('Upload Image to API'),
            ),
          ],
        ),
      ),
    );
  }
}
