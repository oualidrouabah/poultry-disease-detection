import 'package:djaaja_siha/langage_constant.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
  var textStyle= const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
  );
  var textStyle1=  TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).primaryColor,
  );
  var textStyle2= TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: Theme.of(context).primaryColor,
  );
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).hintColor,
              )),
          title: Text(
            translation(context).drawer4,
            style: TextStyle(
              fontSize: 26,
              color: Theme.of(context).hintColor,
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      body: Container(
        padding: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(
                0.8, 0.0), // 10% of the width, so there are ten blinds.
            colors: [
              Color.fromARGB(31, 255, 255, 255),
              Color.fromARGB(38, 0, 238, 107)
            ], 
            tileMode: TileMode.mirror, // repeats the gradient over the canvas
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                translation(context).aboutIntro,
                style: textStyle,
              ),
              Text(
                translation(context).aboutIntro2,
                style: textStyle,
              ),
              Text(
                translation(context).aboutIntro3,
                style: textStyle,
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                thickness: 2,
              ),
              Text(
                translation(context).feature,
                style: textStyle1,
              ),
              Text(
                translation(context).feature_1_name,
                style: textStyle2,
              ),
              Text(
                translation(context).feature_1_description,
                style: textStyle,
              ),
              Text(
                translation(context).feature_2_name,
                style: textStyle2,
              ),
              Text(
                translation(context).feature_2_description,
                style: textStyle,
              ),
              Text(
                translation(context).feature_3_name,
                style: textStyle2,
              ),
              Text(
                translation(context).feature_3_description,
                style: textStyle,
              ),
              Text(
                translation(context).feature_4_name,
                style: textStyle2,
              ),
              Text(
                translation(context).feature_4_description,
                style: textStyle,
              ),
              Text(
                translation(context).feature_5_name,
                style: textStyle2,
              ),
              Text(
                translation(context).feature_5_description,
                style: textStyle,
              ),
              Text(
                translation(context).feature_6_name,
                style: textStyle2,
              ),
              Text(
                translation(context).feature_6_description,
                style: textStyle,
              ),
              Text(
                translation(context).feature_7_name,
                style: textStyle2,
              ),
              Text(
                translation(context).feature_7_description,
                style: textStyle,
              ),
               Text(
                translation(context).feature_8_name,
                style: textStyle2,
              ),
              Text(
                translation(context).feature_8_description,
                style: textStyle,
              ),
               Text(
                translation(context).feature_9_name,
                style: textStyle2,
              ),
              Text(
                translation(context).feature_9_description,
                style: textStyle,
              ),
               Text(
                translation(context).feature_10_name,
                style: textStyle2,
              ),
              Text(
                translation(context).feature_10_description,
                style: textStyle,
              ),
              Divider(
                color: Theme.of(context).primaryColor,
                thickness: 2,
              ),
              Text(
                translation(context).benefits,
                style: textStyle1,
              ),
              Text(
                translation(context).benefit_targeted_treatment,
                style: textStyle2,
              ),
              Text(
                translation(context).description_targeted_treatment,
                style: textStyle,
              ),
              Text(
                translation(context).benefit_cost_savings,
                style: textStyle2,
              ),
              Text(
                translation(context).description_cost_savings,
                style: textStyle,
              ),
              Text(
                translation(context).benefit_improved_productivity,
                style: textStyle2,
              ),
              Text(
                translation(context).description_improved_productivity,
                style: textStyle,
              ),
              Text(
                translation(context).benefit_data_driven_decisions,
                style: textStyle2,
              ),
              Text(
                translation(context).description_data_driven_decisions,
                style: textStyle,
              ),
              Text(
                translation(context).benefit_enhanced_biosecurity,
                style: textStyle2,
              ),
              Text(
                translation(context).description_enhanced_biosecurity,
                style: textStyle,
              ),
               Text(
                translation(context).benefit_peace_of_mind,
                style: textStyle2,
              ),
              Text(
                translation(context).description_peace_of_mind,
                style: textStyle,
              ),
            ],
          ),
        ),
      )
    );
  }
}