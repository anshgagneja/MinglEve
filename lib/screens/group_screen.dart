import 'package:flutter/material.dart';
import 'group_chat_screen.dart';

class GroupScreen extends StatelessWidget {
  final List<Group> groups = [
    Group(name: 'Weekend Bash', description: 'Discuss weekend parties and gatherings', image: 'assets/weekend_bash.png'),
    Group(name: 'Birthday Celebrations', description: 'Plan birthday parties and surprises', image: 'assets/birthday_celebrations.png'),
    Group(name: 'Holiday Trips', description: 'Organize holiday trips and vacations', image: 'assets/holiday_trips.png'),
    Group(name: 'Club Nights', description: 'Talk about clubbing plans and events', image: 'assets/club_nights.png'),
    Group(name: 'Festivals', description: 'Discuss upcoming festivals and events', image: 'assets/festivals.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Groups'),
      ),
      body: ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context, index) {
          final group = groups[index];
          return ListTile(
            leading: Image.asset(group.image),
            title: Text(group.name),
            subtitle: Text(group.description),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GroupChatScreen(group: group),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Group {
  final String name;
  final String description;
  final String image;

  Group({required this.name, required this.description, required this.image});
}
