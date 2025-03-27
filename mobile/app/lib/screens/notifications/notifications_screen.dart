import 'package:flutter/material.dart';
import 'package:flutter_job_marketplace/models/notification.dart' as app_notification;
import 'package:flutter_job_marketplace/routes.dart';
import 'package:intl/intl.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<app_notification.Notification> _notifications = [
    app_notification.Notification(
      id: '1',
      userId: 'USER_123',
      type: 'request',
      content: 'Solicita presupuesto a trabajo de pintura',
      date: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: false,
    ),
    app_notification.Notification(
      id: '2',
      userId: 'USER_12',
      type: 'request',
      content: 'Solicita presupuesto para trabajo de pintura 80mts2',
      date: DateTime.now().subtract(const Duration(hours: 5)),
      isRead: false,
    ),
    app_notification.Notification(
      id: '3',
      userId: 'USER_234',
      type: 'request',
      content: 'Solicita cotización pintura de galpón 1200mts2',
      date: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
    ),
    app_notification.Notification(
      id: '4',
      userId: 'USER_77',
      type: 'request',
      content: 'Solicita presupuesto pintura cocina 52mts2',
      date: DateTime.now().subtract(const Duration(days: 2)),
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificaciones'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check_circle_outline),
            onPressed: () {
              // Mark all as read
              setState(() {
                for (var notification in _notifications) {
                  notification = app_notification.Notification(
                    id: notification.id,
                    userId: notification.userId,
                    type: notification.type,
                    content: notification.content,
                    date: notification.date,
                    isRead: true,
                  );
                }
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              child: Row(
                children: [
                  const Icon(Icons.notifications),
                  const SizedBox(width: 8),
                  Text(
                    '${_notifications.where((n) => !n.isRead).length} nuevas notificaciones',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: _notifications.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final notification = _notifications[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: notification.isRead
                          ? Colors.grey[300]
                          : Theme.of(context).primaryColor,
                      child: Text(
                        notification.userId.substring(notification.userId.length - 2),
                        style: TextStyle(
                          color: notification.isRead ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(
                          notification.userId,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(' : '),
                        Expanded(
                          child: Text(
                            notification.content,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      DateFormat('dd/MM/yyyy HH:mm').format(notification.date),
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    trailing: notification.isRead
                        ? null
                        : Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                    onTap: () {
                      // Mark as read and navigate to work details
                      setState(() {
                        _notifications[index] = app_notification.Notification(
                          id: notification.id,
                          userId: notification.userId,
                          type: notification.type,
                          content: notification.content,
                          date: notification.date,
                          isRead: true,
                        );
                      });
                      Navigator.pushNamed(context, AppRoutes.workDetails);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

