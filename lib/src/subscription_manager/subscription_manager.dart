import '../models/subscription.dart';

/// Subscription Manager
///

class SubscriptionManager {
  Subscriptions subscriptions = Subscriptions();
  static final SubscriptionManager _instance = SubscriptionManager._();
  final Subscriptions subs = Subscriptions();

  SubscriptionManager._();

  static SubscriptionManager get instance => _instance;

  addSubscriber(String clientId, String topic) {
    subs.addSubscriber(Subscription(clientId: clientId, topic: topic));
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
