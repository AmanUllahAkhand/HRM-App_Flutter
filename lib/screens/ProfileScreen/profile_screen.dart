import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final double coverHeight = 220;
  final double profileHeight = 144;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            buildTop(),
            buildContent(),
          ],
        )
    );
  }

  Widget buildCoverImage() => Container(
    color: Colors.grey,
    child: Image.network(
      "https://img.freepik.com/free-vector/app-development-banner_33099-1720.jpg?w=1060&t=st=1696396661~exp=1696397261~hmac=89877111fcf5d4c75d488e7a09fd0353bb54636230dcee24eab7dead3ddb1b96",
      width: double.infinity,
      height: coverHeight,
      fit: BoxFit.cover,
    ),
  );

  Widget buildProfileImage() => Container(
    width: profileHeight,
    height: profileHeight,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: Colors.white,
        width: 2.0, // Adjust the border width as needed
      ),
    ),
    child: CircleAvatar(
      radius: profileHeight / 2,
      backgroundColor: Colors.grey.shade800,
      backgroundImage: NetworkImage(
        "https://scontent.fdac135-1.fna.fbcdn.net/v/t39.30808-6/310521649_3324426967819959_2548953486416457678_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=1b51e3&_nc_ohc=6YHe9V6hek4AX_3uCm4&_nc_ht=scontent.fdac135-1.fna&oh=00_AfDPhuNFfHNjRX_ouowb8JyHPlWvBJ0ppJPNkSEJTikgbQ&oe=65225E1C",
      ),
    ),
  );

  Widget buildTop(){
    final bottom = profileHeight/2;
    final top = coverHeight-profileHeight/2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage(),
        ),
        Positioned(
          top: top,
          child: buildProfileImage(),
        )
      ],
    );
  }
  Widget buildContent() {
    return Column(
      children: [
        SizedBox(height: 16), // Add some space between profile image and name
        Text(
          'Aman Ullah Akhand', // Replace with the actual name
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8), // Add some space between name and title
        Text(
          'iOS App Developer', // Replace with the actual title
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),


        SizedBox(height: 16), // Add some space between personal details and buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.email),
                  onPressed: () {
                    // Implement the action for sending an email
                  },
                ),
                Text('Send Email'), // Icon title
              ],
            ),
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.chat),
                  onPressed: () {
                    // Implement the action for starting a chat
                  },
                ),
                Text('Start Chat'), // Icon title
              ],
            ),
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.call),
                  onPressed: () {
                    // Implement the action for saving as a favorite
                  },
                ),
                Text('Phone'), // Icon title
              ],
            ),
          ],
        ),
        SizedBox(height: 16), // Add some space between title and personal details

        // Personal Details
        ListTile(
          leading: Icon(Icons.business),
          title: Text('Department'),
          subtitle: Text('App Developer'),
        ),
        ListTile(
          leading: Icon(Icons.work),
          title: Text('Position'),
          subtitle: Text('Software Engineer - Mobile App (iOS)'),
        ),
        ListTile(
          leading: Icon(Icons.location_on),
          title: Text('Location'),
          subtitle: Text('Dhaka, Bangladesh'),
        ),
        ListTile(
          leading: Icon(Icons.info),
          title: Text('About Me'),
          subtitle: Text(
            "I would like to devote all my knowledge, skills, and experience to the IT profession in a prosperous way where honesty, transparency, and accountability would be evaluated. I will provide the best performance with the help of my previous experience and energy. I could utilize the opportunity to strengthen the organization and build up my own career also.",
          ),
        )

      ],
    );
  }

}