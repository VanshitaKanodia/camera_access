import 'package:aleemeno/screens/image_file.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: const Icon(Icons.arrow_back_rounded),
                ),
              )
            ],
          ),
          const Image(
            image: AssetImage('assets/images/img.png'),
            alignment: Alignment.center,
          ),
          Expanded(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 200,
                    width: 200,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                        PermissionStatus status = await Permission.camera.request();
                        if (status.isGranted) {
                          // Camera permission granted, open camera
                          // ignore: use_build_context_synchronously
                          Navigator.push(context, MaterialPageRoute(builder: (
                              context) => const MainScreen()));
                        } else if (status.isDenied) {
                          // Camera permission denied
                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                AlertDialog(
                                  title: const Text('Camera Permission'),
                                  content: const Text(
                                      'Please grant camera permission to use the camera feature.'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                  ],
                                ),
                          );
                        } else if (status.isPermanentlyDenied) {
                          // Camera permission permanently denied
                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                AlertDialog(
                                  title: const Text('Camera Permission'),
                                  content: const Text(
                                      'Camera permission is permanently denied. Please go to app settings and enable camera permission manually.'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                  ],
                                ),
                          );
                        }
                      },
                      child: const Icon(Icons.camera_alt),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.green),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                            const CircleBorder()),
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
