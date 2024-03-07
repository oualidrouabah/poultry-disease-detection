import 'package:connectivity/connectivity.dart';
import 'package:djaaja_siha/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoConnectionScreen extends StatefulWidget {
  const NoConnectionScreen({super.key});

  @override
  State<NoConnectionScreen> createState() => _NoConnectionScreenState();
}

class _NoConnectionScreenState extends State<NoConnectionScreen> {
   
  Future<void> checkConnection(BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>const NoConnectionScreen()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>const HomeScreen()),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).hintColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Builder(
                builder: (context) {
                  return Icon(Icons.wifi_off, size: 100, color: Theme.of(context).primaryColor,);
                }
              ),
              const SizedBox(height: 20,),
              Builder(
                builder: (context) {
                  return Text( AppLocalizations.of(context)!.nocnxmessage, style: Theme.of(context).textTheme.bodyMedium,);
                }
              ),
               const SizedBox(height: 20,),
              Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () => checkConnection(context),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      backgroundColor: Theme.of(context).primaryColor,
                      //minimumSize: Size(100, 50),
                      fixedSize:const Size(190, 50),
                    ),
                    child: Text(AppLocalizations.of(context)!.again, style: Theme.of(context).textTheme.bodyMedium,),
              
                  );
                }
              ),
            ]
          )
        )
      ),
    );
  }
}