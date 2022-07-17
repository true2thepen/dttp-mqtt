class Subscription {
  final String clientId;
  final String topic;

  Subscription({required this.clientId, required this.topic});
}

class Subscriptions {
  Map<String, List> subscriptions = {};

  addSubscriber(Subscription subscription) {
    if (subscriptions.containsKey(subscription.topic)) {
      subscriptions[subscription.topic]!.add(subscription.clientId);
    } else {
      subscriptions.addAll({
        subscription.topic: [subscription.clientId]
      });
    }
  }

  removeSubscriber(Subscription subscription) {
    if (subscriptions.containsKey(subscription.topic)) {
      subscriptions[subscription.topic]!.remove(subscription.clientId);
    }
  }

  List getTopicsForSubscriber(String clientId) {
    List topics = [];
    for (var topic in subscriptions.keys) {
      if (subscriptions[topic]!.contains(clientId)) {
        topics.add(topic);
      }
    }
    return topics;
  }

  List getSubscribersForTopic(String topic) {
    if (subscriptions.containsKey(topic)) {
      return subscriptions[topic]!;
    } else {
      return [];
    }
  }
}

