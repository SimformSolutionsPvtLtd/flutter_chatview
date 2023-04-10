import 'service/chat_database_service.dart';
import 'service/database_service.dart';

class ChatViewExtension {
  const ChatViewExtension({this.serviceExtension, this.widgetsExtension});

  final ServiceExtension? serviceExtension;

  final WidgetsExtension? widgetsExtension;
}

class ServiceExtension {
  const ServiceExtension({this.dataBaseService});

  final DataBaseService? dataBaseService;
}
