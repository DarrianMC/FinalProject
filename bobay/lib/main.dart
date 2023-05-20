import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  late String name;
  late String photo;
  late String moto;
  late bool verified;
  late int age;
  late String email;
  String theme = "light";
  String addType = "generic";
  late String password;
  List<String> messages = ["1st"];
  List<bool> wasTherePhoto = [false];
  List <Widget> photoarr = [];
  // Constructor with parameters
  User(
      String name,
      String photo,
      String moto,
      bool verified,
      int age,
      String email,
      String password,

      {String theme = "light", String addType = "generic"}
      ) {
    this.name = name;
    this.photo = photo;
    this.moto = moto;
    this.verified = verified;
    this.age = age;
    this.email = email;
    this.theme = theme;
    this.addType = addType;
    this.password = password;
  }
}

List<User> ListOfUsers = [User("Ann Land","photos/photo.jpeg","A Mother, A child, A friend",
    true, 25,"AnnLand@gmail.com", "password"
)];
User currentUser = ListOfUsers[0];

Future<void> main() async {
  //var t = await classifyInput("Lebron James scored 56 points");
  //print(t);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/' ,
      routes: {
        '/' : (context) => SignInScreen(),
        '/second' : (context) =>  UserPage(title: '',),
        '/createAccountPage' : (context) => CreateAccountPage(),
        '/MyAccount' : (context) => MyAccountPage(),
      },
    );
  }
}

/*

      SIGN-IN SCREEN *************************************************************

 */


Color getColor(int i)
{
  if(currentUser.theme == "light")
  {
    if (i == 0) {
      return Colors.white;
    } else if (i == 1) {
      return Colors.black;
    } else if (i == 2) {
      return Colors.green;
    } else {
      return Colors.orange;
    }
  }
  else
  {
    if (i == 0) {
      return Colors.black;
    } else if (i == 1) {
      return Colors.white;
    } else if (i == 2) {
      return Colors.yellow;
    } else {
      return Colors.orange;
    }
  }
}






class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  bool confirmPass(String email, String password) {

    for(int i = 0; i < ListOfUsers.length; i++)
    {
        print(email);
        print(password);
        if(ListOfUsers[i].email == email)
        {
          if(ListOfUsers[i].password == password)
          {
            currentUser = ListOfUsers[i];
            return true;
          }
        }

    }
    return false;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        backgroundColor: Colors.orange ,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),

              SizedBox(height: 16.0),

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: ()
                {
                  if(confirmPass(usernameController.text, passwordController.text))
                  {

                    Navigator.pushNamed(context, '/second');
                  }
                  else
                  {

                  }
                },
                child: const Text('Sign In'),
              ),
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/createAccountPage');
                },
                child: const Text(
                  'Create an Account',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
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


















/*

                SIGNED IN USER PAGE *************************************************************************

*/
class UserPage extends StatefulWidget {
  const UserPage({super.key, required this.title});

  final String title;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
{
  String ADD = "Hunting";
  int _counter = 0;
  List <Widget> p = [];

  final myController = TextEditingController();

  bool photoTaken = false;
  File? _image;
  int adCount = -1;
  List <String> huntingAd = ["photos/HuntingAd1.jpg","photos/HuntingAd2.jpeg","photos/HuntingAd3.jpeg"];
  List <String> sportsAd = ["photos/SportAd1.jpeg", "photos/SportAd2.jpeg", "photos/SportAd3.jpg"];
  List <String> beautyAd = ["photos/BeautyAd1.jpg", "photos/BeautyAd2.jpg", "photos/BeautyAd3.jpg"];

  Future<void> determineAd()
  async {
    //var t = await classifyInput("Lebron James scored 56 points");
    //print(t);

    //create String of messages
    String packet = "";
    for(int i = 1; i < currentUser.messages.length; i++)
    {
      packet = packet + currentUser.messages[i] + " ";
    }
    String stringWithExtraSpaces = packet;
    packet = stringWithExtraSpaces.trim().replaceAll(RegExp(r'\s+'), ' ');
    print(packet);
    var t = await classifyInput(packet);
    String gg = t.toString();
    if(gg == "Beautiful")
    {
      print("BBBBBB");
      ADD = "Beauty";
      currentUser.addType = "Beauty";
    }
    else if(gg == "Sports")
    {
      ADD = "Sports";
      currentUser.addType == "Sports";
    }
    else
    {
      ADD = "Hunting";
      currentUser.addType == "Hunting";
    }


    print(packet);
    print(t);

  }




  Widget returnAdd() {
    adCount++;

    if (ADD == "Beauty") {
      return Container(
        width: 400,
        height: 300,
        child: Image.asset(
          beautyAd[adCount % 3],
          fit: BoxFit.cover,
        ),
      );
    } else if (ADD == "Hunting") {
      return Container(
        width: 400,
        height: 300,
        child: Image.asset(
          huntingAd[adCount % 3],
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Container(
        width: 400,
        height: 300,
        child: Image.asset(
          sportsAd[adCount % 3],
          fit: BoxFit.cover,
        ),
      );
    }
  }




  Future<void> _getImage() async {
    final ImagePicker picker = ImagePicker();
    // Capture a photo
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    XFile? p = photo;
    setState(() {

      if(photo != null)
      {
        photoTaken = true;
        _image = File(photo.path);
        currentUser.photoarr.add(
            Image.file(
              _image!,
              width: 400,  // set the width to 200 pixels
              height: 250, // set the height to 200 pixels
              fit: BoxFit.fill, // don't scale the image,
            )
        );
      }
      else
      {
        currentUser.wasTherePhoto[_counter - 1] = false;
      }

    });
  }



  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  String _function(){

    return "Verified";
  }




  void _addPost()
  {

    if(myController.text != '')
    {
      currentUser.wasTherePhoto.add(photoTaken);
      photoTaken = false;
      currentUser.messages.add(myController.text);
      myController.text = '';

      setState(() {
        determineAd();
        _counter++;
      });
    }

  }








  void getProfilePic()
  {


  }

  void getPhoto(i)
  {

  }

  List <Widget> createHomepage() {
    p = [];
    late Color color1;
    if (currentUser.theme == "light") {
      const color1 = Colors.black;
    }
    else {
      const color1 = Colors.white;
    }
    p.add(const SizedBox(height: 50));
    p.add(

      Row(
        children:  [
          SizedBox(width: 25),

          CircleAvatar(
            backgroundImage: ExactAssetImage(currentUser.photo),
            // Optional as per your use case
            minRadius: 30,
            maxRadius: 70,
          ),
          const SizedBox(width: 25),
          Text(
              currentUser.moto
          ),
        ],
      ),);
    p.add(Text(
        _function()
    ),);
    p.add(const SizedBox(height: 100));
    p.add(
      TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Type Your message",
        ),
        controller: myController,

      ),


    );
    int photoCount = currentUser.photoarr.length - 1;

    for (int i = currentUser.messages.length - 1; i > 0; i--) {
      print(currentUser.messages.length);
      print(currentUser.wasTherePhoto.length);

      if (currentUser.wasTherePhoto[i]) {
        if (currentUser.theme == "light") {
          p.add(
            Container(
              width: 400,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    currentUser.photoarr[photoCount],
                    Text(
                      currentUser.messages[i],
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),

                    ),
                  ],
                ),
              ),
            ),
          );
          photoCount--;
        }
        else // Dark Theme
        {
          if (currentUser.theme == "light"){
            p.add(
            Container(
              width: 400,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    currentUser.photoarr[photoCount],
                    Text(
                      currentUser.messages[i],
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),

                    ),
                  ],
                ),
              ),
            ),
          );
          photoCount--;
        }}
      }
      else { // There is no photo ****************************************************
        if (currentUser.theme == "light"){
          p.add(
          Container(
            width: 400,
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    currentUser.messages[i],
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );}
        else
        {
          p.add(
            Container(
              width: 400,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      currentUser.messages[i],
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }// If not photo



    p.add(const SizedBox(height: 4));
    p.add(returnAdd());
      p.add(const SizedBox(height: 4));
    }// end for loop

    return p;
  }

  @override
  Widget build(BuildContext context)
  {
    if(currentUser.theme == "light")
    {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("HomePage"),
          backgroundColor: Colors.orange ,
        actions: [

          PopupMenuButton(
            // add icon, by default "3 dot" icon
            // icon: Icon(Icons.book)
              itemBuilder: (context){
                return [
                  const PopupMenuItem<int>(
                    value: 0,
                    child: Text("My Account"),
                  ),

                  const PopupMenuItem<int>(
                    value: 1,
                    child: Text("Settings"),
                  ),

                  const PopupMenuItem<int>(
                    value: 2,
                    child: Text("Logout"),
                  ),
                ];
              },
              onSelected:(value){
                if(value == 0){
                  Navigator.pushNamed(context, '/MyAccount');
                }else if(value == 1){
                  Navigator.pushNamed(context, '/myAccount');
                }else if(value == 2){
                  Navigator.pushNamed(context, '/');
                }
              }
          ),

        ],
      ),
      body: Scrollbar(
        child: ListView(
          children:
          [Column(
          children: createHomepage()
        ),]
      ),),
      floatingActionButton: Row(
        children: [
          const SizedBox (width: 10,),
          Expanded(
            child: Container(
              alignment: Alignment.bottomLeft,
              child: Tooltip(
                message: 'Launch the camera',
                child: ElevatedButton(
                  onPressed: _getImage,
                  child: const Icon(Icons.photo_camera),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              child: Tooltip(
                message: 'Add a post',
                child: ElevatedButton(
                  onPressed: _addPost,
                  child: const Icon(Icons.add),
                ),
              ),
            ),
          ),
        ],
      )

    );}
    else{
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("HomePage"),
          backgroundColor: Colors.orange ,
          actions: [

            PopupMenuButton(
              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
                itemBuilder: (context){
                  return [
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Text("My Account"),
                    ),

                    const PopupMenuItem<int>(
                      value: 1,
                      child: Text("Settings"),
                    ),

                    const PopupMenuItem<int>(
                      value: 2,
                      child: Text("Logout"),
                    ),
                  ];
                },
                onSelected:(value){
                  if(value == 0){
                    Navigator.pushNamed(context, '/');
                  }else if(value == 1){
                    Navigator.pushNamed(context, '/');
                  }else if(value == 2){
                    Navigator.pushNamed(context, '/');
                  }
                }
            ),

          ],
        ),
        body: Scrollbar(
          child: ListView(
              children:
              [Column(
                  children: createHomepage()
              ),]
          ),),
        floatingActionButton: Row(
          children: [
            const SizedBox (width: 10,),
            Expanded(
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Tooltip(
                  message: 'Launch the camera',
                  child: ElevatedButton(
                    onPressed: _getImage,
                    child: const Icon(Icons.photo_camera),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                child: Tooltip(
                  message: 'Add a post',
                  child: ElevatedButton(
                    onPressed: _addPost,
                    child: const Icon(Icons.add),
                  ),
                ),
              ),
            ),
          ],
        )

    );


    }




  }
}



class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {

    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController emailController = TextEditingController();



    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        backgroundColor: Colors.orange ,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Username',

                ),
                controller: usernameController,
              ),
              const SizedBox(height: 16.0),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Password',

                ),
                controller: passwordController,
              ),
              const SizedBox(height: 16.0),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Email',

                ),
                controller: emailController,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if(usernameController.text != '' && passwordController.text != '' && emailController.text != '') {
                    createTheAccount(
                        usernameController.text, passwordController.text,
                        emailController.text);
                    Navigator.pushNamed(context, '/second');
                  }
                },
                child: const Text('Create Account'),
              )

            ],
          ),
        ),
      ),
    );
  }
  void createTheAccount(String user, String pass, String email)
  {
    currentUser = User(user,"photos/generic.jpeg","Some Description about Me",
        true, 25, email, pass
    );



  }
}








class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  bool value = false;

  void changeTheme() {
    setState(() {
      if (currentUser.theme == 'light') {
        currentUser.theme = 'dark';
      } else {
        currentUser.theme = 'light';
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const Text(
                    'Delete Account',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 200),
                  ElevatedButton(
                    onPressed: ()
                    {
                      changeTheme();
                    },
                    child: const Text('Push'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    'Reset All Settings',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 200),
                  ElevatedButton(
                    onPressed: ()
                    {
                      changeTheme();
                    },
                    child: const Text('Push'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    "Dark Mode",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 200),
                  ElevatedButton(
                    onPressed: ()
                    {
                      changeTheme();
                    },
                    child: const Text('Push'),
                  ),

                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}





















/*

          API CALL

 */


Future<String> classifyInput(String input) async {
  final url = Uri.parse('http://34.16.130.77:8080/classify');
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({'input': input});
  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final result = data['p'];
    return result.toString();
  } else {
    return "Generic";
  }
}






