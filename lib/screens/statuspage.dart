import 'package:flutter/material.dart';
import 'package:viticare/helper/token.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../api/apis.dart';
import '../helpers/dialogues.dart';
import '../main.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  List<Token> _list=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FloatingActionButton(
          child: Icon(Icons.delete_forever),onPressed: (){},backgroundColor: Colors.red,
        ),
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: StreamBuilder(
                stream: APIs.getTokenStatus(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                    case ConnectionState.active:
                    case ConnectionState.done:
                      final data = snapshot.data?.docs;
                      _list=data?.map((e)=> Token.fromJson(e.data())).toList() ?? [];
                      Dialogues.showToast(context, _list.length.toString());
                      final Token token=Token(id: _list[0].id, name: _list[0].id,
                          roomNo: _list[0].roomNo, block: _list[0].block, otp: _list[0].otp,
                          isdone: true, datetime: _list[0].datetime);
                      if (_list[0].isdone==false) {
                        return Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        Text("Show this QR Code once cleaning is over...",style: GoogleFonts.oswald(fontSize: 20),),
                        SizedBox(height: 50,),
                        Center(child: QrImageView(data: token.toJson().toString())),
                        SizedBox(height: 50),
                          Text('Scheduled Time : '+getFormattedTime(context: context, time: _list[0].datetime),style: GoogleFonts.oswald(fontSize: 20),),

                        ],
                        ),
                        );
                      } else {
                        return Center(
                            child:
                            Text('No Applied Cleanings',style: TextStyle(fontSize: 25)));
                      }
                  }   }
            ),
            )
        ],
      ),
    );
  }
  static String getFormattedTime(
      {required BuildContext context, required String time}) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    return TimeOfDay.fromDateTime(date).format(context);
  }
}
