import 'package:flutter/material.dart';
import 'package:solaatun_nariya/main.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String>historyZikr = repository.readHistory();
     int sanoq=0;
    for(int i = 0; i < historyZikr.length;i++){
      sanoq+=int.parse(historyZikr[i].split("=>").toList().last);
    }
    return Scaffold(
      appBar: AppBar(centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 1,
      title: const Text("Sanoq tarixi", style: TextStyle(color: Colors.black),),),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text("Bugungi kungacha jami: $sanoq", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
          children: [for(int i=0;i<historyZikr.length;i++)
            Center(child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(child: Text(historyZikr[i].split("=>").toList().first)),
                Text("Sanoq: ${historyZikr[i].split("=>").toList().last}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              ],
            ))],
        ),
      ),
    );
  }
}

