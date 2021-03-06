import 'package:depth_spectrum/theme/colors.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
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
           const Center(child: Text("2D to 3D Imaging Based on Colorblindness Type")),
          const Padding(padding: EdgeInsets.all(10)),
          Row(
            children:  [
              const Padding(padding: EdgeInsets.all(10),),
              Image.asset("assets/images/andrew.jpg", width: 150.0),
              const Padding(padding: EdgeInsets.all(10),),
              const Flexible(
                child: Text("Andrew Varela | Project leader")
              )
            ],
          ),
          const Padding(padding: EdgeInsets.all(10)),
          Row(
            children:  [
              const Padding(padding: EdgeInsets.all(10),),
              Image.asset("assets/images/justin.jpg", width: 150.0, ),
              const Padding(padding: EdgeInsets.all(10),),
              const Flexible(
                child: Text("Justin Thoreson\nFullstack, Camera, UX/UI\n\nlinkedin.com/in/justinthoreson\ngithub.com/thoresonjd")
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.all(10)),
          Row(
            children:  [
              const Padding(padding: EdgeInsets.all(10),),
              Image.asset("assets/images/Devon.jpg", width: 150.0),
              const Padding(padding: EdgeInsets.all(10),),
              const Flexible(
                child: Text("Devon McKee\nBackend, Model Processing")
              )
            ],
          ),
          const Padding(padding: EdgeInsets.all(10)),
          Row(
            children:  [
              const Padding(padding: EdgeInsets.all(10),),
              Image.asset("assets/images/RyanRao.jpg", width: 150.0),
              const Padding(padding: EdgeInsets.all(10),),
              const Flexible(
                child: Text("Ryan Rao\nFrontend, UI")
              )
            ],
          ),
          const Padding(padding: EdgeInsets.all(10)),
          Row(
            children:  [
              const Padding(padding: EdgeInsets.all(10),),
              Image.asset("assets/images/RyanThomas.jpg", width: 150.0),
              const Padding(padding: EdgeInsets.all(10),),
              const Flexible(
                child: Text("Ryan Thomas\nFrontend, UI\nlinkedin.com/in/ryan-thomas01")
              )
            ],
          ),
        ],
      ),
    );
  }
}