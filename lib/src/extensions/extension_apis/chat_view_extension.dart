import 'package:chatview/src/extensions/extension_apis/service/backend_service.dart';
import 'package:chatview/src/extensions/extension_apis/widgets%20extension/widget_extension.dart';
import '../../../chatview.dart';

/// `ChatViewExtension` API is used for extending services and using
/// this package with custom plugins. `ChatViewExtension` can be used for
/// extending support for custom messages and custom servies.
/// [ChatViewController] and [ChatView] can utilise only one `ChatViewExtension`
/// at a time.
/// `ChatViewExtension` hold [ServiceExtension] and [WidgetsExtension] for
/// extending services and support for new messages respectively. See [ServiceExtension] and
/// [WidgetsExtension] for more info.
class ChatViewExtension {
  const ChatViewExtension({this.serviceExtension, this.widgetsExtension});

  /// Used for extending services see [ServiceExtension].
  final ServiceExtension? serviceExtension;

  /// Used for adding support to new messages and widgets see [WidgetsExtension]
  final WidgetsExtension? widgetsExtension;
}

/// `ServiceExtension` are used to allocate services such as
/// 1. [DataBaseService]
/// 2. [BackendManager]
///
/// ### DataBaseService
/// `DataBaseService` is used for providing support for custom
/// database, it consists of various CRUD methods that will be utilised by
/// [ChatView] under the hood.
/// It is the place where you can implement persistence and storing logics see [DataBaseService] for more.
///
///### BackendManager
/// `BackendManager` is used for providing support for handling transmission and recieving messages
/// [ChatView] will utlise this when a [Room] sends or recieves a message see [BackendManager] for more info.
class ServiceExtension<T extends DataBaseService> {
  const ServiceExtension({this.dataBaseService, this.backendService});

  final T? dataBaseService;

  final BackendManager? backendService;
}
