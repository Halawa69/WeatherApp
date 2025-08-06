import 'package:flutter/material.dart';
import 'homePage.dart';

class Intropage extends StatelessWidget {
  const Intropage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors:[Color(0xFF3E2D8F) , Color(0xFF8E78C8) ], 
          )
        ),
        child: Padding(padding: EdgeInsets.all(20) , 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/download.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                'Weather',
                style:TextStyle(
                  color: Colors.white,
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                ) 
              ),
              SizedBox(height: 5),
              Text(
                'Forecasts',
                style:TextStyle(
                  color: Colors.yellow,
                  fontSize: 64,
                ) 
              ),
              SizedBox(height: 30),
              InkWell(
                onTap: () {
                  Navigator.push(context, DialogRoute(context: context, builder: (context) => Homepage(),));
                },
                child: Container(
                  width: 250,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        color: Color(0xFF3E2D8F),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}