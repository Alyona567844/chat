import 'package:chat/app/models/chat_message/chat_message.dart';
import 'package:chat/app/models/socked_events.dart';
import 'package:chat/app/routes/app_pages.dart';
import 'package:chat/app/services/user_service.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:get/get.dart';

class SocketService extends GetxService {
  static SocketService get to => Get.find();
  late Socket _socket;
  Future<SocketService> init() async {
    _socket = io('https://masqed.ru',
    OptionBuilder()
    .setTransports(['websocket'])
    .setPath('/chat/socket.io')
    .disableAutoConnect()
    .disableReconnection()
    .build(),
    );
    _socket.onConnect((data) {
      printInfo(info: "Socket connected");
      _sendLogInMesssage();
      Get.offNamed(Routes.CHAT);
    });
    _socket.onDisconnect((data) { 
      printInfo(info:"Disconnected");
      Get.offNamed(Routes.HOME);
    });
    _socket.onConnectError((data)=> printInfo(info:"Connection error"));
    // _socket.onAny((event, data)=> printInfo(info:"event: $event \t $data"));

    // SocketEvent.newMessage.name это NewMessage - приведение к строке
    // _socket.on(SocketEvent.newMessage.name, (data) {
    //   data['type'] = SocketEvent.newMessage.name;
    //   var message = ChatMessage.fromJson(data);
    //   UserService.to.addMessageToList(message);
    // });

    // _socket.on(SocketEvent.login.name, (data){
    //   data['type'] = SocketEvent.login.name;
    //   var message = ChatMessage.fromJson(data);
    //   UserService.to.addMessageToList(message);
    // });

    // _socket.on(SocketEvent.logout.name, (data){
    //   data['type'] = SocketEvent.logout.name;
    //   var message = ChatMessage.fromJson(data);
    //   UserService.to.addMessageToList(message);
    // });

    // _socket.onAny((event, data) {
    //   var isKnown = SocketEvent.values.any((el) => el.name == event);
    //   if (isKnown) return;
    //   data['type'] = event;
    //   var message = ChatMessage.fromJson(data);
    //   UserService.to.addMessageToList(message);
    // });
    // преобразовываем data в map, что позволит использовать оператор [] для установки значения type
    _socket.onAny((event, data) {
      var isKnown = SocketEvent.values.any((el) => el.name == event);
      if (!isKnown) {
        var dataMap = data as Map<String, dynamic>;
        dataMap['type'] = event;
        var message = ChatMessage.fromJson(data);
        UserService.to.addMessageToList(message);
      }
    });
    return this;
  }
  void connect() {
    _socket.connect();
  }

  void disconnect() {
    _sendLogOutMesssage();
    _socket.disconnect();
  }

  //сказать серверу, что мы подключились
  void _sendLogInMesssage() {
    _socket.emit(SocketEvent.login.name, UserService.to.username);
  }

  void _sendLogOutMesssage() {
    _socket.emit(SocketEvent.logout.name);
  }

  void sendMessageToChat(String message) {
    _socket.emit(SocketEvent.newMessage.name, message);
  }
}