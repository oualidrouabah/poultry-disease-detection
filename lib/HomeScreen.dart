import 'package:camera/camera.dart';
import 'package:djaaja_siha/TakePicture.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Theme.of(context).hintColor,
      body:Container(
        padding: const EdgeInsets.only(top: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        //open a side menu
                        
                      },
                      icon: const Icon(Icons.menu),
                      color: Theme.of(context).primaryColor,
                    ),
                ],
              ),
              const SizedBox(height: 50,),
              const Text('Welcome to Djaaja Siha', style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
              const SizedBox(height: 25,),
              Builder(builder:(context) => 
                Text('Take or Upload a picture', style: Theme.of(context).textTheme.bodyMedium,),
              ),
              const SizedBox(height: 25,),
              Builder(builder: (context) {
                return ElevatedButton(
                  onPressed: () async{
                    await availableCameras().then((value) => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => TakePicture())));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    backgroundColor: Theme.of(context).primaryColor,
                    //minimumSize: Size(100, 50),
                    fixedSize:const Size(190, 50),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Icon(Icons.camera_alt_outlined, color: Theme.of(context).hintColor,),
                      const SizedBox(width: 10,),
                      Text('Take a photo', style: Theme.of(context).textTheme.displayMedium,),
                    ],
                  )
                );
              }),
              const SizedBox(height: 20,),
              Text('or', style: Theme.of(context).textTheme.bodyMedium,),
              const SizedBox(height: 20,),
              Builder(builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    menu();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    backgroundColor: Theme.of(context).primaryColor,
                    //minimumSize: Size(100, 50),
                    fixedSize:const Size(150, 50),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Icon(Icons.file_upload_outlined, color: Theme.of(context).hintColor,),
                      const SizedBox(width: 10,),
                      Text('Upload', style: Theme.of(context).textTheme.displayMedium,),
                    ],
                  )
                );
              }),
            ],
          ),
        ),
      )
    );
  }
}

void menu() {
  print('menu');

}
