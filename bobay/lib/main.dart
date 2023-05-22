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
  List<String> messagesToMe = ["1st"];
  List<String> nameOfSender = ["1st"];
  List<bool> wasTherePhoto = [false];
  List<String> friends = [];
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

List<User> ListOfUsers = [
  User("Ann Land","photos/photo.jpeg","A Mother, A child, A friend",
    true, 25,"AnnLand@gmail.com", "password"
),

  User("Tom Fold","photos/HunterGuy.jpg","A Family Man",
      false, 30,"TomFord@gmail.com", "password"
  ),

];
User currentUser = ListOfUsers[0];
User otherUser = ListOfUsers[1];
Future<void> main() async {
  // Set up Dummy messages
  User currentUser = ListOfUsers[0];
  currentUser.messagesToMe.add("Hi Ann! How are you");
  currentUser.nameOfSender.add("Tom Fold");
  currentUser.messagesToMe.add("Did you have a good weekend?");
  currentUser.nameOfSender.add("Tom Fold");
  currentUser.messagesToMe.add("I wanted to share a funny story with you.");
  currentUser.nameOfSender.add("Tom Fold");
  currentUser.messagesToMe.add("Are you free for a chat later today?");
  currentUser.nameOfSender.add("Tom Fold");
  currentUser.messagesToMe.add("By the way, have you seen the latest movie?");
  currentUser.nameOfSender.add("Tom Fold");
  currentUser.messagesToMe.add("I found a great restaurant we should try together.");
  currentUser.nameOfSender.add("Tom Fold");


  ListOfUsers[1].messagesToMe.add("Hey Tom! I'm doing well, thank you. How about you?");
  ListOfUsers[1].nameOfSender.add("Ann Land");
  ListOfUsers[1].messagesToMe.add("Yes, I had a fantastic weekend! I went hiking and spent time with friends. How about you?");
  ListOfUsers[1].nameOfSender.add("Ann Land");
  ListOfUsers[1].messagesToMe.add("Oh, I love funny stories! Go ahead and share it with me.");
  ListOfUsers[1].nameOfSender.add("Ann Land");
  ListOfUsers[1].messagesToMe.add("Sure, I should be available later today. What time works for you?");
  ListOfUsers[1].nameOfSender.add("Ann Land");
  ListOfUsers[1].messagesToMe.add("Yes, I watched it last weekend. It was amazing! Have you seen it?");
  ListOfUsers[1].nameOfSender.add("Ann Land");
  ListOfUsers[1].messagesToMe.add("That sounds exciting! I'm always up for trying new places. Let me know when you want to go.");
  ListOfUsers[1].nameOfSender.add("Ann Land");
  ListOfUsers[1].messagesToMe.add("Absolutely! We should plan something fun. Maybe a dinner or a movie night?");
  ListOfUsers[1].nameOfSender.add("Ann Land");

  ListOfUsers[1].friends.add("Ann Land");
  ListOfUsers[0].friends.add("Tom Fold");


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
      initialRoute: '/FriendView',
      routes: {
        '/' : (context) => SignInScreen(),
        '/second' : (context) =>  UserPage(title: '',),
        '/createAccountPage' : (context) => CreateAccountPage(),
        '/MyAccount' : (context) => MyAccountPage(),
        '/DMPage' : (context) => MessageView(),
        '/FriendView' : (context) => FriendView(),
        '/OtherUser' : (context) =>  OtherUserPage(title: '',),

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
                    value: 3,
                    child: Text("My Friends and Messages"),
                  ),

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
                  Navigator.pushNamed(context, '/second');
                }else if(value == 1){
                  Navigator.pushNamed(context, '/MyAccount');
                }else if(value == 2){
                  Navigator.pushNamed(context, '/');
                }
                else if(value == 3){
                  Navigator.pushNamed(context, '/FriendView');
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
                      value: 3,
                      child: Text("My Friends and Messages"),
                    ),

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
                    Navigator.pushNamed(context, '/second');
                  }else if(value == 1){
                    Navigator.pushNamed(context, '/MyAccount');
                  }else if(value == 2){
                    Navigator.pushNamed(context, '/');
                  }
                  else if(value == 3){
                    Navigator.pushNamed(context, '/FriendView');
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

class OtherUserPage extends StatefulWidget {
  const OtherUserPage({super.key, required this.title});

  final String title;

  @override
  State<OtherUserPage> createState() => _OtherUserPageState();
}

class _OtherUserPageState extends State<OtherUserPage>
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

  Widget returnAdd()
  {
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
        otherUser.photoarr.add(
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
        otherUser.wasTherePhoto[_counter - 1] = false;
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
      otherUser.wasTherePhoto.add(photoTaken);
      photoTaken = false;
      otherUser.messages.add(myController.text);
      myController.text = '';

      setState(() {
        determineAd();
        _counter++;
      });
    }

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
            backgroundImage: ExactAssetImage(otherUser.photo),
            // Optional as per your use case
            minRadius: 30,
            maxRadius: 70,
          ),
          const SizedBox(width: 25),
          Text(
              otherUser.moto
          ),
        ],
      ),);
    p.add(Text(
        _function()
    ),);
    p.add(const SizedBox(height: 100));

    int photoCount = otherUser.photoarr.length - 1;

    for (int i = otherUser.messages.length - 1; i > 0; i--) {
      print(otherUser.messages.length);
      print(otherUser.wasTherePhoto.length);

      if (otherUser.wasTherePhoto[i]) {
        if (otherUser.theme == "light") {
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
                    otherUser.photoarr[photoCount],
                    Text(
                      otherUser.messages[i],
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
          if (otherUser.theme == "light"){
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
                      otherUser.photoarr[photoCount],
                      Text(
                        otherUser.messages[i],
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
        if (otherUser.theme == "light"){
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
                      otherUser.messages[i],
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
                      otherUser.messages[i],
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
                      value: 3,
                      child: Text("My Friends and Messages"),
                    ),

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
                    Navigator.pushNamed(context, '/second');
                  }else if(value == 1){
                    Navigator.pushNamed(context, '/MyAccount');
                  }else if(value == 2){
                    Navigator.pushNamed(context, '/');
                  }
                  else if(value == 3){
                    Navigator.pushNamed(context, '/FriendView');
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


      );

    }
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
                      value: 3,
                      child: Text("My Friends and Messages"),
                    ),

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
                    Navigator.pushNamed(context, '/second');
                  }else if(value == 1){
                    Navigator.pushNamed(context, '/MyAccount');
                  }else if(value == 2){
                    Navigator.pushNamed(context, '/');
                  }
                  else if(value == 3){
                    Navigator.pushNamed(context, '/FriendView');
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







class MessageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Direct Messages'),
        backgroundColor: Colors.orange,
      ),
      body: Scrollbar(
        child: ListView(
          children: [
            Container(
              child: Column(
                children: [
                  ...getDMs(),
                  SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? findUserPhoto(String name)
  {
    for(int i = 0; i < ListOfUsers.length; i++)
    {
      if(name == ListOfUsers[i].name)
      {
        return ListOfUsers[i].photo;
      }
    }

  }

  List<Widget> getDMs() {

    List<Widget> returnList = [];
    for(int i = currentUser.messagesToMe.length - 1; i > 0; i--)
    {
      String photoPath = findUserPhoto(currentUser.nameOfSender[i]) ?? "photos/generic.jpeg";
      print(currentUser.messagesToMe[i]);
      returnList.add(
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    // Handle container tap event
                    print('Container 1 tapped!');
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [

                          CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(photoPath), // Replace with your own image path
                          ),

                          SizedBox(
                            width: 10,
                          ),

                          Container(
                            width: 300,
                            height: 150,
                            color: Colors.grey,
                            child:
                              Text(
                                currentUser.messagesToMe[i],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),

                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ],
            ),
      );
    }

    return returnList;
  }
}






class FriendView extends StatelessWidget {
  void showMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("Direct Messages"),
                onTap: () {
                  Navigator.pop(context, 1); // Return the selected value
                },
              ),
              ListTile(
                title: Text('User\'s Page'),
                onTap: () {
                  Navigator.pushNamed(context, '/OtherUser');// Return the selected value
                },
              ),
            ],
          ),
        );
      },
    ).then((value) {
      // Handle menu item selection here
      if (value != null) {
        print('Selected menu item: $value');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Friends View"),
        backgroundColor: Colors.orange ,
        actions: [

          PopupMenuButton(
            // add icon, by default "3 dot" icon
            // icon: Icon(Icons.book)
              itemBuilder: (context){
                return [
                  const PopupMenuItem<int>(
                    value: 3,
                    child: Text("My Friends and Messages"),
                  ),

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
                  Navigator.pushNamed(context, '/second');
                }else if(value == 1){
                  Navigator.pushNamed(context, '/MyAccount');
                }else if(value == 2){
                  Navigator.pushNamed(context, '/');
                }
                else if(value == 3){
                  Navigator.pushNamed(context, '/FriendView');
                }
              }
          ),

        ],
      ),
      body: ListView(
        children: getFriends(context) ,
      ),
    );
  }

  String findUserPhoto(String name)
  {
    print(ListOfUsers.length);
    for(int i = 0; i < ListOfUsers.length; i++)
    {
      print(ListOfUsers[i].name);
      if(name == ListOfUsers[i].name)
      {
        print("fFFFFFFFFFFFFFFFFFFFFF");
        print(ListOfUsers[i].name);
        return ListOfUsers[i].photo;
      }
    }
    return "photos/generic.jpg";

  }

  List<Widget> getFriends(BuildContext context) {
    List<Widget> returnList = [];
    for(int i = 0; i < currentUser.friends.length; i++)
    {
      String photoPath = findUserPhoto(currentUser.friends[i]);
      print(photoPath);
      returnList.add(GestureDetector(
        onTap: () {
          // Handle container tap event
          print('Container ${currentUser.friends[i]} tapped!');
          showMenu(context);
        },
        child: Column(
          children: [
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(photoPath), // Replace with your own image path
                ),
                SizedBox(width: 10),
                Container(
                  width: 300,
                  height: 150,
                  color: Colors.grey,
                  child: Text(
                    currentUser.friends[i],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ));
    }
    return returnList;
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








