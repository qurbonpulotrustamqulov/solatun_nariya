import 'package:flutter/material.dart';

class DocumentPage extends StatelessWidget {
  const DocumentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.all(18),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Image.asset("assets/images/img_basmala.jpg",height: 70,),
            Image.asset("assets/images/img_solaatun_nariya_arabic.jpg", width: double.infinity,fit: BoxFit.fitWidth,),
            Image.asset("assets/images/img_solaatun_nariya_latin.jpg", width: double.infinity,fit: BoxFit.fitWidth,),
            Image.asset("assets/images/img_solaatun_nariya_manosi.jpg", width: double.infinity,fit: BoxFit.fitWidth,),
            Image.asset("assets/images/img_solaatun_nariya_izoh.jpg", width: double.infinity,fit: BoxFit.fitWidth,),
            Image.asset("assets/images/img_solaatun_nariya_izoh2.jpg", width: double.infinity,fit: BoxFit.fitWidth,),
            SizedBox(height: 15,),
            Text("Ma'lumot islom.uz saytidan olindi. Bu ilovaning sayt rahbariyati va adminlariga hech qanday aloqasi yo'q", style: TextStyle(fontStyle: FontStyle.italic),textAlign: TextAlign.center,)
          ],
        ),
      ),),
    );
  }
}
