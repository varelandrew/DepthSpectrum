import 'package:depth_spectrum/theme/colors.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Depth Spectrum"),
        backgroundColor: DSColors.red,
      ),
      body: ListView(
        children: [
          const Padding(padding: EdgeInsets.all(10)),
          const Center(
            child: Text(
              "We are Depth Spectrum!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.all(10)),
          Row(
            children:  [
              const Padding(padding: EdgeInsets.all(10),),
              Image.asset(
                "assets/images/andrew.jpg",
                width: 150.0,            
              ),
              const Padding(padding: EdgeInsets.all(10),),
              const Flexible(
                child: Text("Andrew Varela")
              )
            ],
          ),
          const Padding(padding: EdgeInsets.all(10)),
          Row(
            children:  [
              const Padding(padding: EdgeInsets.all(10),),
              Image.asset(
                "assets/images/justin.jpg",
                width: 150.0,
              ),
              const Padding(padding: EdgeInsets.all(10),),
              const Flexible(
                child: Text("Justin Thoreson\nSenior CS student @ SU\n\ngithub.com/thoresonjd\nlinkedin.com/justinthoreson")),
            ],
          ),
          const Padding(padding: EdgeInsets.all(10)),
          Row(
            children:  [
              const Padding(padding: EdgeInsets.all(10),),
              Image.asset(
                "assets/images/andrew.jpg",
                width: 150.0,
            
              ),
              const Padding(padding: EdgeInsets.all(10),),
              const Flexible(
                child: Text("sample")
              )
            ],
          ),
          const Padding(padding: EdgeInsets.all(10)),
          Row(
            children:  [
              const Padding(padding: EdgeInsets.all(10),),
              Image.asset(
                "assets/images/andrew.jpg",
                width: 150.0,
            
              ),
              const Padding(padding: EdgeInsets.all(10),),
              const Flexible(
                child: Text("sample")
              )
            ],
          ),
           const Padding(padding: EdgeInsets.all(10)),
          Row(
            children:  [
              const Padding(padding: EdgeInsets.all(10),),
              Image.asset(
                "assets/images/andrew.jpg",
                width: 150.0,
            
              ),
              const Padding(padding: EdgeInsets.all(10),),
              const Flexible(
                child: Text("sample")
              )
            ],
          ),
        ],
      ),
    );
  }
}