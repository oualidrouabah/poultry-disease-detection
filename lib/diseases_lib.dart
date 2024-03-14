import 'package:djaaja_siha/langage_constant.dart';
import 'package:flutter/material.dart';

class DiseaseLib extends StatelessWidget {
  const DiseaseLib({super.key});
  @override
  Widget build(BuildContext context) {
    var textStyle1 = TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).primaryColor);

    var textStyle2 = TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: Theme.of(context).primaryColor);

    var textStyle3 = TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).primaryColor);

    var textStyle4 = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
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
            translation(context).drawer1,
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
          color: Theme.of(context).hintColor,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  translation(context).libHead,
                  style: textStyle4,
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  thickness: 2,
                ),
                //############################################################################################################
                Text(
                  translation(context).sec1,
                  style: textStyle1,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "1.${translation(context).salmo}",
                  style: textStyle2,
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(translation(context).pathogn, style: textStyle3),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("\u2022 ${translation(context).salmopath1}",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).salmopath2}",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).salmopath3}",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).salmopath4}",
                                style: textStyle4),
                          ],
                        ),
                      ),
                      Text(translation(context).clicSign, style: textStyle3),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "\u2022 ${translation(context).salmoClicSign1}",
                                style: textStyle4),
                            Text(
                                "\u2022 ${translation(context).salmoClicSign2}",
                                style: textStyle4),
                            Text(
                                "\u2022 ${translation(context).salmoClicSign3}",
                                style: textStyle4),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(translation(context).trans, style: textStyle3),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("\u2022 ${translation(context).salmoTrans1}",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).salmoTrans2}",
                                style: textStyle4),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(translation(context).zoonotic, style: textStyle3),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "\u2022 ${translation(context).salmoZoonotic1}",
                                style: textStyle4),
                            Text(
                                "\u2022 ${translation(context).salmoZoonotic2}",
                                style: textStyle4),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(translation(context).diag, style: textStyle3),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("\u2022 ${translation(context).salmoDiag1}",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).salmoDiag2}",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).salmoDiag3}",
                                style: textStyle4),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(translation(context).control, style: textStyle3),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("\u2022 ${translation(context).salmoControl1}",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).salmoControl2}",
                                style: textStyle4),
                            Text(
                                "\u2022 ${translation(context).salmoControl3} ",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).salmoControl4}",
                                style: textStyle4),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "2.${translation(context).fowl}",
                  style: textStyle2,
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(translation(context).pathogn, style: textStyle3),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("\u2022 ${translation(context).fowlpath1}",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).fowlpath2}",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).fowlpath3}",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).fowlpath4}",
                                style: textStyle4),
                          ],
                        ),
                      ),
                      Text(translation(context).clicSign, style: textStyle3),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("\u2022 ${translation(context).fowlClicSign1}",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).fowlClicSign2}",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).fowlClicSign3}",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).fowClicSign4}",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).fowClicSign5}",
                                style: textStyle4),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(translation(context).trans, style: textStyle3),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("\u2022 ${translation(context).fowlTrans1}",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).fowlTrans2}",
                                style: textStyle4),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(translation(context).zoonotic, style: textStyle3),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("\u2022 ${translation(context).fowlZoonotic1}",
                                style: textStyle4),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(translation(context).diag, style: textStyle3),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("\u2022 ${translation(context).fowlDiag1}",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).fowlDiag2}",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).fowlDiag3}",
                                style: textStyle4),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(translation(context).control, style: textStyle3),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("\u2022 ${translation(context).fowlControl1}",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).fowlControl2}",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).fowlControl3}",
                                style: textStyle4),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  thickness: 1,
                ),
                Text(
                  translation(context).sec2,
                  style: textStyle1,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "1.${translation(context).ndv}",
                  style: textStyle2,
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(translation(context).pathogn, style: textStyle3),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("\u2022 ${translation(context).ndvpath1}",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).ndvpath2}",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).ndvpath3}",
                                style: textStyle4),
                            //Text("\u2022 ${translation(context).salmopath4}", style: textStyle4),
                          ],
                        ),
                      ),
                      Text(translation(context).clicSign, style: textStyle3),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("\u2022 ${translation(context).ndvClicSign1}",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).ndvClicSign2}",
                                style: textStyle4),
                            //Text("\u2022 ${translation(context).salmoClicSign3}", style: textStyle4),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(translation(context).trans, style: textStyle3),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("\u2022 ${translation(context).ndvTrans1}",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).ndvTrans2}",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).ndvTrans3}",
                                style: textStyle4),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(translation(context).zoonotic, style: textStyle3),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("\u2022 ${translation(context).ndvZoonotic1}",
                                style: textStyle4),
                            //Text("\u2022 ${translation(context).salmoZoonotic2}", style: textStyle4),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(translation(context).diag, style: textStyle3),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("\u2022 ${translation(context).ndvDiag1}",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).ndvDiag2}",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).ndvDiag3}",
                                style: textStyle4),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(translation(context).control, style: textStyle3),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("\u2022 ${translation(context).ndvControl1}",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).ndvControl2}",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).ndvControl3} ",
                                style: textStyle4),
                            //Text("\u2022 ${translation(context).ndvControl4}", style: textStyle4),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  thickness: 1,
                ),
                Text(
                  translation(context).sec3,
                  style: textStyle1,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "1.${translation(context).helminths}",
                  style: textStyle2,
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(translation(context).worms, style: textStyle4),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(translation(context).intanNema, style: textStyle3),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("\u2022 ${translation(context).intanNema1}",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).intanNema2}",
                                style: textStyle4),
                            Text("\u2022 ${translation(context).intanNema3}",
                                style: textStyle4),
                            //Text("\u2022 ${translation(context).helminthsIntanNema4}", style: textStyle4),
                          ],
                        ),
                      ),
                      Text(translation(context).gapeworm, style: textStyle3),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(translation(context).gapworm1, style: textStyle4),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(translation(context).tapworm, style: textStyle3),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(translation(context).tapeworm1, style: textStyle4),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
