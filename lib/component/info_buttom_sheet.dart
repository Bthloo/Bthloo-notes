
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoButtomSheet extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          const SizedBox(height: 7,),
          Container(
            decoration: BoxDecoration(
              color:  Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(50),
            ),
            height: 8,
            width: 200,
          ),
          const SizedBox(height: 20,),
          const Text('Developed By Bassel Alaa',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
          const SizedBox(height: 40,),
          InkWell(
            onTap: (){
              openUrl('https://www.linkedin.com/in/bassel-alaa-9287b321b/');
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const  Text('Linkedin',style: TextStyle(
                      color: Colors.black,
                      fontSize: 25
                  ),),
                  SvgPicture.asset('assets/icons8-linked-in.svg',height: 30),
                ],
              ),
            ),
          ),

          InkWell(
            onTap: (){
              openUrl('https://github.com/Bthloo');
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Github',style: TextStyle(
                      color: Colors.black,
                      fontSize: 25

                  ),),
                  SvgPicture.asset('assets/icons8-github.svg',height: 30),
                ],
              ),
            ),
          ),

          InkWell(
            onTap: (){
              openUrl("https://api.whatsapp.com/send?phone=201111269525");
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Whatsapp',style: TextStyle(
                      color: Colors.black,
                      fontSize: 25

                  ),),
                  SvgPicture.asset('assets/icons8-whatsapp.svg',height: 30),

                ],
              ),
            ),
          ),

          InkWell(
            onTap: (){

              openUrl("https://t.me/Bthloo");
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Telegram',style: TextStyle(
                      color: Colors.black,
                      fontSize: 25

                  ),),
                  Icon(Icons.telegram,size: 30,)
                ],
              ),
            ),
          ),

          InkWell(
            onTap: (){
              openUrl("https://www.facebook.com/bthloo");
            },
            child: const Padding(
              padding:  EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('FaceBook',style: TextStyle(
                      color: Colors.black,
                      fontSize: 25

                  ),),
                  Icon(Icons.facebook,size: 30,)
                ],
              ),
            ),
          ),
          const Spacer(flex: 1,),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
              child: const Text('Version 1.0.1'),
          )
        ],
      ),
    );
  }

void openUrl(String url)async{
    var uri = Uri.parse(url);

    if(await canLaunchUrl(uri)){
      await launchUrl(uri,
          mode:LaunchMode.externalApplication );
    }
}
}
