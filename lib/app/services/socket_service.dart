import 'package:chat/app/models/chat_message/chat_message.dart';
import 'package:chat/app/models/socked_events.dart';
import 'package:chat/app/routes/app_pages.dart';
import 'package:chat/app/services/user_service.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:get/get.dart';

class SocketService extends GetxService {
  static SocketService get to => Get.find();
  late Socket _socket;

  String get clientId => _socket.id ?? "";
  SocketService init() {
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
      sendLogInMesssage();
      Get.offNamed(Routes.CHAT);
    });
    _socket.onDisconnect((data) { 
      printInfo(info:"Disconnected");
      UserService.to.clearMessage();
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

    _socket.onAny((event, data) {
      var isKnown = SocketEvents.values.any((el) => el.name == event);
      if (!isKnown) return;
      data['type'] = event;
      var message = ChatMessage.fromJson(data);
      UserService.to.addMessageToList(message);
    });
    // преобразовываем data в map, что позволит использовать оператор [] для установки значения type
    // _socket.onAny((event, data) {
    //   var isKnown = SocketEvent.values.any((el) => el.name == event);
    //   if (!isKnown) {
    //     var dataMap = data as Map<String, dynamic>;
    //     dataMap['type'] = event;
    //     var message = ChatMessage.fromJson(data);
    //     UserService.to.addMessageToList(message);
    //   }
    // });
    return this;
  }
  void connect() {
    _socket.connect();
  }

  void disconnect() {
    sendLogOutMesssage();
    _socket.disconnect();
  }

  //сказать серверу, что мы подключились 
  void sendLogInMesssage() {
    _socket.emit(SocketEvents.login.name, UserService.to.username);
  }

  void sendLogOutMesssage() {
    _socket.emit(SocketEvents.logout.name);
  }

  void sendMessageToChat(String message) {
    _socket.emit(SocketEvents.newMessage.name, message);
  }

  void sendImageMessage(String file) {
    _socket.emit(SocketEvents.newImageMessage.name, file);
  }

  void sendTypingStart() {
    _socket.emit(SocketEvents.typingStart.name);
  }

  void sendTypingStop() {
    _socket.emit(SocketEvents.typingStop.name);
  }
}