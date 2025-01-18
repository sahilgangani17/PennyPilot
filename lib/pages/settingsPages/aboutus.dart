
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  Widget appCard(Widget? child) {
    return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Padding(
            padding: EdgeInsets.all(20),
            child: child
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),

        backgroundColor: Colors.grey[300],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
        child: Column(
          children: [
            //TODO: Riddhi Kar re baba
            appCard(
              Column(
                children: [
                  //Image(image:''),   //Image to be Inserted
                  Text('PennyPilot', style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),),
                  Text('Keep your Finance flying High!', style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),),
                  SizedBox(height: 10,),
                  Text('A financial management application designed to assist individuals in monitoring their financial activities, enabling them to effectively manage their budgets and achieve their financial objectives.',textAlign: TextAlign.center, style: TextStyle(
                    fontSize: 12,
                  ),),
                ],
              ),
            ),
            appCard(
            Column(
                children: [
                  Text('About our Team',textAlign: TextAlign.center, style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),),
                  SizedBox(height: 15,),
                  // Generated code for this Row Widget...
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Color(0x4D9489F5),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Image.asset(
                                'lib/src/assets/images/Sankalp_photo.jpeg',
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            'Sankalp Dawda',textAlign: TextAlign.center, style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                          ),
                          Text(
                            'Member 1',
                          ),
                        ]
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Color(0x4E39D2C0),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Image.asset(
                                'lib/src/assets/images/Sahil_photo.jpeg',
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            'Sahil Gangani',
                            textAlign: TextAlign.center, style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                          ),
                          Text(
                            'Member 2',

                      ),
                    ]
                  ),
                  ],
              ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Color(0x4D9489F5),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Image.asset(
                                  'lib/src/assets/images/Aryan_photo.jpeg',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                                'Aryan Madhavi',textAlign: TextAlign.center, style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                            ),
                            Text(
                              'Member 3',

                            ),
                          ]
                      ),
                      Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Color(0x4E39D2C0),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Image.asset(
                                  'lib/src/assets/images/riddhi_photo.jpeg',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(
                              'Riddhi Chauhan',textAlign: TextAlign.center, style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                            ),
                            Text(
                              'Member 4',

                            ),
                          ]
                      ),
                    ],
                  ),
                    SizedBox(height: 20),
                    Text('During the intense coding sessions at Codecratz 2025, Our team Carbonari collaborated seamlessly, combining diverse skills in software development, design, and finance. Our dedication and teamwork resulted in a user-friendly interface that simplifies financial management for individuals and families alike.',textAlign: TextAlign.left, style: TextStyle(
                      fontSize: 13,
                      //fontWeight: FontWeight.w700,
                    ),),
                ],
        ),
            )
                ]
    ),

    )
      ) );
  }
}
