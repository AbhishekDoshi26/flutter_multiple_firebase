import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/firebase_options.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isFirebaseInitialized = false;
  ProjectType projectType = ProjectType.project1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
      body: Column(
        children: [
          Center(
            child: DropdownMenu<ProjectType>(
              onSelected: (value) {
                setState(() {
                  projectType = value ?? ProjectType.project1;
                });
              },
              dropdownMenuEntries: const [
                DropdownMenuEntry(
                  value: ProjectType.project1,
                  label: 'Project 1',
                ),
                DropdownMenuEntry(
                  value: ProjectType.project2,
                  label: 'Project 2',
                ),
              ],
            ),
          ),
          Text('Firebase Apps: ${Firebase.apps}'),
          ElevatedButton(
            onPressed: () async {
              if (isFirebaseInitialized) {
                await Firebase.app().delete();
                await Firebase.initializeApp(
                  options: DefaultFirebaseOptions.currentPlatform(),
                );
                setState(() {
                  isFirebaseInitialized = false;
                });
              }

              await Firebase.initializeApp(
                name: projectType == ProjectType.project1
                    ? 'project1'
                    : 'project2',
                options: DefaultFirebaseOptions.currentPlatform(
                  projectType: projectType,
                ),
              ).then((value) {
                setState(() {
                  isFirebaseInitialized = true;
                });
              });
            },
            child: const Text('Initialize'),
          ),
        ],
      ),
    );
  }
}
