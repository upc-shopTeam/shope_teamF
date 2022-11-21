import 'package:flutter/material.dart';
import 'package:shop_team/inventory/edit_profile.dart';

class ProfileOwner extends StatefulWidget {
  const ProfileOwner({Key? key}) : super(key: key);

  @override
  State<ProfileOwner> createState() => _ProfileOwnerState();
}

class _ProfileOwnerState extends State<ProfileOwner> {

  final double coverHeight = 280;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PERFIL'),
          actions: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => EditProfile()));
              },
            ),
          ],
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

  Widget buildTop() {
    final top = coverHeight - profileHeight / 2;
    final bottom = coverHeight - profileHeight;

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
        ),
      ],
    );
  }

  Widget buildContent() => Container(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          numberWidget(),
          const SizedBox(height: 8),
          Text(
            'Nombre:',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Apellido:',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Correo:',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Puesto:',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
        ],
      )
  );

  Widget buildCoverImage() => Container(
    color: Colors.grey,
    child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTjUznZU94myktAJchjCH0fwFf9Q9Cv5wYjdg&usqp=CAU',
      width: double.infinity,
      height: coverHeight,
      fit: BoxFit.cover,
    ),
  );

  Widget buildProfileImage() => CircleAvatar(
    radius: profileHeight / 2,
    backgroundColor: Colors.grey.shade800,
    backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8C0eZ51cUVq9NO5x1H7Avc0eOMZrACwC_gIYztkQCcjMX_Ma5qf1fNWkSAoyU00YASkQ&usqp=CAU'),
  );

  Widget numberWidget() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      buildButton(text: 'Ventas', number: 14),
      buildDivider(),
      buildButton(text: 'Horas', number: 27),
      buildDivider(),
      buildButton(text: 'Estrellas', number: 4),
      buildDivider(),
    ],
  );

  Widget buildDivider()=> Container(
    height: 24,
    child: VerticalDivider(),
  );

  Widget buildButton({
    required String text,
    required int number})
  => MaterialButton(
    padding: EdgeInsets.symmetric(vertical: 4),
    onPressed: () {},
    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          '$number',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
  }
