import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseLoginAsPage extends StatelessWidget {
  const ChooseLoginAsPage({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/app_logo.png',
                height: 175,
                width: 175,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity, // match parent
              height: 50,
              child: ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  elevation: 4,
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Masuk',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.black
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity, // match parent
              height: 50,
              child: ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  elevation: 4,
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Masuk',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.black
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}