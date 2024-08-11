import 'package:flutter/material.dart';
import 'advertise.dart'; // advertise.dart 파일을 import

class AlarmPage extends StatelessWidget {
  // 알림 팝업을 표시하는 메서드
  static void showAlarmPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '알림',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                Divider(),
                _buildNotificationList(context), // 수정된 부분: context를 전달
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AlarmPage(),
                      ),
                    );
                  },
                  child: Text('알림 전체 보기'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 알림 목록 빌드 메서드
  static Widget _buildNotificationList(BuildContext context) {
    return Container(
      height: 200.0,
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('새로운 알림이 있습니다.'),
            subtitle: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdvertisePage(),
                  ),
                );
              },
              child: Text(
                '읽지 않은 알림.',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('알림'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('새로운 알림이 있습니다.'),
            subtitle: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdvertisePage(),
                  ),
                );
              },
              child: Text(
                '읽지 않은 알림.',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
