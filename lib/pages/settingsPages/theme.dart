import 'package:flutter/material.dart';
class Themes extends StatefulWidget {
  const Themes({super.key});

  @override
  State<Themes> createState() => _ThemesState();
}

class _ThemesState extends State<Themes> {

  bool isDarkModeEnabled = false;
  double fontSize = 16;
  bool showDecimals = true;
  String dropdownValue = 'Line';
  bool showGridLines = true;
  Color primaryColor = Colors.blue;

  void _applyChanges() {
    // TODO: logic to apply the selected theme settings.

    print('Dark Mode: $isDarkModeEnabled');
    print('Font Size: $fontSize');
    print('Show Decimals: $showDecimals');
    print('Chart Type: $dropdownValue');
    print('Show Grid Lines: $showGridLines');
    print('Primary Color: $primaryColor');


    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Changes saved!')),
    );
  }


  void _resetToDefaults() {
    setState(() {
      isDarkModeEnabled = false;
      fontSize = 16;
      showDecimals = true;
      dropdownValue = 'Line';
      showGridLines = true;
      primaryColor = Colors.blue;
    });


    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings reset to defaults!')),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Themes"),
        backgroundColor: Colors.grey[300],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color.fromARGB(100, 26, 35, 126)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Customize Theme',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Make the app truly yours',
                    style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                    ),
                    ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 153, 176, 187),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Color Scheme',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                          
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Primary Color',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Used for main elements',
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                  ),
                              ],
                            ),
                            SizedBox(width: 10,),
                            Container( // Primary color picker
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Select Primary Color'),
                                    content: SingleChildScrollView( // Use SingleChildScrollView for potentially long list
                                      child: Column(
                                        children: [
                                          for (final color in [Colors.red, Colors.green, Colors.blue, Colors.orange, Colors.purple, Colors.teal /* ...add more as needed */])
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  primaryColor = color;
                                                  Navigator.pop(context); // Close the dialog
                                                });
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.symmetric(vertical: 4),
                                                width: 50,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                  color: color,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            ),

                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                              color: Colors.blue,
                                borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),

                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 153, 176, 187),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Dark Mode',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                          
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Enable Dark Mode',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Easier on eyes at night',
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                  ),
                              ],
                            ),
                            SizedBox(width: 10,),
                            Switch(
                              value: isDarkModeEnabled, // Replace with your actual variable
                              onChanged: (value) {
                                setState(() {
                                  isDarkModeEnabled = value;
                                  // TODO: Implement logic to change app theme
                                });
                              },
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 153, 176, 187),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Font Size',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                          
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                                Text(
                                  'Font Size',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'x10',
                                  style: TextStyle(
                                    fontSize: 10,
                                  ),
                                  ),
                            SizedBox(height: 10,),
                            
                            Slider(
                            value: fontSize, // Your font size variable
                            min: 10, // Minimum font size
                            max: 30, // Maximum font size
                            onChanged: (newValue) {
                              setState(() {
                                fontSize = newValue;
                                // TODO: Apply the new font size
                                });
                              },
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 153, 176, 187),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Currency Display',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                          
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                                Text(
                                  'Show Decimals',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                            Switch(
                            value: showDecimals, // Your boolean variable
                            onChanged: (value) {
                              setState(() {
                                showDecimals = value;
                                // TODO: Implement logic to handle decimal display
                              });
                            },
                          ),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Currency Symbol'),
                            Text('₹'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 153, 176, 187),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Chart Preferences',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                          
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Default Chart Type',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),


                                        DropdownButton<String>(
                                          value: dropdownValue,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropdownValue = newValue!;
                                              // TODO: Apply the selected chart type
                                            });
                                          },
                                          items: <String>['Line', 'Bar', 'Pie'] // Example chart types
                                              .map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),

                                      ],
                                    ),
                                    
                                    Row(
                                      children: [
                                        Text(
                                          'Show Grid Lines',
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        
                                        Switch(
                                          value: showGridLines, // Your boolean variable
                                          onChanged: (value) {
                                            setState(() {
                                              showGridLines = value;
                                              // TODO: Implement logic to toggle grid lines on the chart
                                            });
                                          },
                                        ),


                                      ],
                                    ),
                                     SizedBox(width: 10,),
                                  ],
                                ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: _applyChanges, 
                    style: ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                      backgroundColor: WidgetStatePropertyAll(Colors.grey),
                    ),
                    child: Text('Save Changes'),
                    ),
                    SizedBox(height: 5,),
                  ElevatedButton(
                    onPressed: _resetToDefaults,
                    style: ButtonStyle(
                      // backgroundBuilder: WidgetStatePropertyAll(Colors.grey),
                      backgroundColor: WidgetStatePropertyAll(Colors.white),
                    ), 
                    child: Text('Reset to Defaults'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}