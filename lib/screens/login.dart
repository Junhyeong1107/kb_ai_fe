import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // JSON 인코딩 및 디코딩
import './main/summary.dart';
import 'dart:async';
import './loading.dart';
import 'package:provider/provider.dart';
import '../providers/UserProvider.dart'; // UserProvider 임포트

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _useridController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final String userid = _useridController.text;
    final String password = _passwordController.text;

    final response = await http.post(
      Uri.parse('http://43.200.7.249:8080/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userid': userid,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // 로그인 성공 시 UserProvider에 userid 저장
      Provider.of<UserProvider>(context, listen: false).setUserId(userid);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoadingScreen()),
      );

      // 3초 후에 SummaryPage로 이동
      await Future.delayed(Duration(seconds: 3));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SummaryPage()),
      );
    } else {
      // 로그인 실패
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('로그인 실패'),
            content: Text('아이디 또는 비밀번호가 잘못되었습니다.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('확인'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Color(0xFFECECEC), // 백그라운드 색상 설정
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // 요소들을 상단으로 정렬
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/kb_logo.png',
                height: 60,
                alignment: Alignment.centerLeft,
              ),
              SizedBox(height: 60),
              Center(
                child: Text(
                  '로그인',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w900,
                    height: 36.31 / 30, // line-height를 반영하기 위해 fontSize로 나누어줌
                    color: Colors.black.withOpacity(0.8), // 80% 불투명도
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  'AI를 통해 소비 습관을 분석하고 당신의 마음을 알아보세요',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    height: 17 / 13, // line-height를 반영하기 위해 fontSize로 나누어줌
                    letterSpacing: -0.05,
                    color: Colors.black.withOpacity(0.3), // 30% 불투명도
                  ),
                ),
              ),
              SizedBox(height: 40),
              TextField(
                controller: _useridController,
                decoration: InputDecoration(
                  labelText: '아이디',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: Icon(Icons.visibility_off),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // 비밀번호 찾기 클릭 시
                  },
                  child: Text(
                    '비밀번호를 잊으셨나요?',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFCC00), // 버튼 배경 색상
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: Text(
                  '로그인',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(child: Divider(thickness: 1, color: Colors.black26)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '소셜 로그인',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  Expanded(child: Divider(thickness: 1, color: Colors.black26)),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialLoginButton('assets/google_icon.png'),
                  SizedBox(width: 20),
                  _buildSocialLoginButton('assets/facebook_icon.png'),
                  SizedBox(width: 20),
                  _buildSocialLoginButton('assets/apple_icon.png'),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '계정이 아직 없으신가요?',
                    style: TextStyle(color: Colors.black54),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SummaryPage()),
                      );
                    },
                    child: Text(
                      '회원가입',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              Spacer(flex: 2), // 하단에 여백 추가
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLoginButton(String assetName) {
    return InkWell(
      onTap: () {
        // 소셜 로그인 버튼 클릭 시
      },
      child: CircleAvatar(
        backgroundImage: AssetImage(assetName),
        radius: 24,
        backgroundColor: Colors.white,
      ),
    );
  }
}
