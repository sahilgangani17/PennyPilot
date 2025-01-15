import 'package:flutter/material.dart';

class Accountdetails extends StatefulWidget {
  const Accountdetails({super.key});

  @override
  State<Accountdetails> createState() => _AccountdetailsState();
}

class _AccountdetailsState extends State<Accountdetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Details"),
        backgroundColor: Colors.grey[300],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey,
                      ),
                      // child: Text('Hello'),
                      child: ClipOval(
                        child: Image.network(
                          'https://wallpapers.com/images/hd/white-duck-face-close-up-ybtrbmo0scwowgn1.jpg',
                          fit: BoxFit.cover,
                          width: 100,
                          height: 50,
                        ),
                      ),

                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name'),
                    Text('emailf'),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          Container(
            decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey,
            ),
            child: Column(
              children: [
                Text('Login Details'),
                Column(
                  children: [
                    Column(
                      children: [
                        Text('Email:'),
                        Text('abc@gmail.com')
                      ],
                    ),
                    Column(
                      children: [
                        Text('Password'),
                        Row(
                          children: [
                            Text('abc@1234'),
                            ElevatedButton(onPressed: (){}, child:Text('Change'))
                          ],
                        )
                      ],
                    )
                  ],
                )
              ],
            ) ,
          ),
          SizedBox(height: 20,),
          Container(
            decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey,
            ),
            child:Column(
              children: [
                Text('Personal Details'),
                Column(
                  children: [
                    Column(
                      children: [
                        Text('Phone Number'),
                        Text('1234567890')
                      ],
                    ),
                    Column(
                      children: [
                        Text('DOB'),
                        Text('13/8/1997')
                      ],
                    ),
                    Column(
                      children: [
                        Text('Address'),
                        Text('abcdefghijklmnopqrstuvwxyz')
                      ],
                    )
                  ],
                )
              ],
            ) ,
          ),
          SizedBox(height: 20,),
          Container(
              decoration:BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey,
              ),
              child:Column(
                children: [
                  Text('Account Settings'),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text('Notification'),
                          // Switch(value: value, onChanged: onChanged)
                          // trailing: Switch(
                          //   value: _value,
                          //   onChanged: (newValue) {
                          //     setState(() {
                          //       _value = newValue;
                          //     });
                          //     widget.onChanged(newValue);
                          //   },
                          //   activeColor: Colors.blueGrey[300],
                          // ),
                          Text('Two factor Authentication'),
                        ],
                      )
                    ],
                  )
                ],
              )
          ),
          ElevatedButton(onPressed: () {}, child: Text('SIGN OUT'))
        ],
      ),
    );
  }
}
