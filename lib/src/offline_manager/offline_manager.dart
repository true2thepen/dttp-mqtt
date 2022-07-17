import 'package:dttp_mqtt/src/models/offlineClients.dart';

import '../models/subscription.dart';

/// OffLine Manager
///

class OffLineManager {
  static final OffLineManager _instance = OffLineManager._();
  OffLineClients offLineClients = OffLineClients(clients: [], totalClients: 0);

  OffLineManager._();

  static OffLineManager get instance => _instance;

  addClient(String clientId) {
    offLineClients.addSubscriber(Subscription(clientId: clientId, topic: topic));
  }

  removeSubscriber(String clientId, String topic) {
    subs.removeSubscriber(Subscription(clientId: clientId, topic: topic));
  }

  getSubscibersForTopic(String topic) {
    return subs.getSubscribersForTopic(topic);
  }

  getTopicsForSubscriber(String subscriber) {
    return subs.getTopicsForSubscriber(subscriber);
  }
}
