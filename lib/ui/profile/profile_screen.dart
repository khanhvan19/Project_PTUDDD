import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../manager/auth_manager.dart';

class ProfileScreen extends StatelessWidget {
   const ProfileScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        title: const Text('Thông tin',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        titleSpacing: 10,
        backgroundColor: const Color(0xFF0C9869),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: const Color(0X800C9869),
                borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      CircleAvatar(
                        backgroundColor: Colors.greenAccent,
                        radius: 30,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/images/avt.png'),
                          radius: 25,
                        )
                      ),
                      SizedBox(width: 10),
                      Text("Hi! Friend",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                        ),
                      )
                    ]
                  ),
                  const SizedBox(height: 20),
                  const Text('COMING SOON...')
                ],
              ),
            ),
            
            Row( 
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width *0.46,
                  decoration: BoxDecoration(
                    color: const Color(0xBDFF5722),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(Icons.security, color: Colors.white,),
                        SizedBox(height: 20),
                        Text('Điều khoản sử dụng',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                          ),
                        )
                    ])
                  ),
                ),
                Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width *0.46,
                  decoration: BoxDecoration(
                    color: const Color(0xBD2195F3),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(Icons.question_answer_outlined,  color: Colors.white,),
                        SizedBox(height: 20),
                        Text('Liên hệ và góp ý',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                          ),
                        )
                    ])
                  ),
                ), 
              ]
            ),

            const SizedBox(height: 30),
            const Text('Tài khoản',
              style: TextStyle(
                color: Color(0XFF0C9869),
                fontWeight: FontWeight.w800,
                fontSize: 22
              ),
            ),

            const SizedBox(height: 8),
            Card(
              elevation: 4,
              child: TextButton(
                onPressed: () {},
                child: Row(children: const [
                  Icon(Icons.person_outline, color: Colors.black),
                  SizedBox(width: 5),
                  Text('Thông tin cá nhân', style: TextStyle(
                    fontSize: 18,
                    color: Colors.black
                  ))
                ])
              ),
            ),

            Card(
              elevation: 4,
              child: TextButton(
                onPressed: () {},
                child: Row(children: const [
                  Icon(Icons.border_color_outlined, color: Colors.black),
                  SizedBox(width: 5),
                  Text('Đổi mật khẩu', style: TextStyle(
                    fontSize: 18,
                    color: Colors.black
                  ))
                ])
              ),
            ),

            Card(
              elevation: 4,
              child: TextButton(
                onPressed: () {},
                child: Row(children: const [
                  Icon(Icons.subdirectory_arrow_right, color: Colors.black),
                  SizedBox(width: 5),
                  Text('Địa chỉ đã lưu', style: TextStyle(
                    fontSize: 18,
                    color: Colors.black
                  ))
                ])
              ),
            ),

            Card(
              elevation: 4,
              child: TextButton(
                onPressed: () {},
                child: Row(children: const [
                  Icon(Icons.settings, color: Colors.black),
                  SizedBox(width: 5),
                  Text('Cài đặt', style: TextStyle(
                    fontSize: 18,
                    color: Colors.black
                  ))
                ])
              ),
            ),

            Card(
              elevation: 4,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context)
                    .pushReplacementNamed('/');
                    context.read<AuthManager>().logout();
                },
                child: Row(children: const [
                  Icon(Icons.exit_to_app_outlined, color: Colors.black),
                  SizedBox(width: 5),
                  Text('Đăng xuất', style: TextStyle(
                    fontSize: 18,
                    color: Colors.black
                  ))
                ])
              ),
            )
          ]
        ),
      ),
    );
  }
}