import 'package:flutter/material.dart';

class CitySelection extends StatefulWidget {
  @override
  State < CitySelection > createState() => _CitySelectionState();
}

class _CitySelectionState extends State < CitySelection > {
  final TextEditingController _textController = TextEditingController();
  final List < String > famous = [
    'Delhi',
    'Mumbai',
    'Patna',
    'Chennai',
    'Kolkata',
    'Pune',
    'Bangalore',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: < Widget > [
            Positioned(
              top: 40,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),                
                child: Text('Popular Places', style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),),
              ),
            ),
            Positioned(
              top: 70,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Wrap(
                    spacing: 15,
                    children: famous.map((fcity) => InkWell(
                      onTap: () => Navigator.pop(context, fcity),
                      child: Chip(
                        backgroundColor: Colors.grey[200],
                        label: Text(fcity, style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold), ),
                      ),
                    )).toList()
                  ),
                ),
              ),
            ),
            Center(
              child: Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.ideographic,
                  children: [
                    Container(
                      width: 0.75 * MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          controller: _textController,
                          decoration: InputDecoration(
                            labelText: 'City',
                            hintText: 'Chicago',
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      padding: EdgeInsets.all(10),
                      onPressed: () {
                        Navigator.pop(context, _textController.text);
                      },
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: -250,
              left: -250,
              child: Container(
                transform: Matrix4.translationValues(0, 50, -99),
                width: MediaQuery.of(context).size.width, child: Image.asset('assets/img/city2.webp', )),
            )
          ],
        ),
      ),
    );
  }
}