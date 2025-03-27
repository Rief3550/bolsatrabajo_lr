import 'package:flutter/material.dart';
import 'package:flutter_job_marketplace/routes.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> _chats = [
      {
        'name': 'Juan Pérez',
        'lastMessage': 'Hola, ¿cómo estás?',
        'time': '10:30 AM',
        'unread': 2,
        'image': 'https://randomuser.me/api/portraits/men/1.jpg',
      },
      {
        'name': 'María López',
        'lastMessage': 'Necesito un presupuesto para pintar mi casa',
        'time': 'Ayer',
        'unread': 0,
        'image': 'https://randomuser.me/api/portraits/women/1.jpg',
      },
      {
        'name': 'Carlos Rodríguez',
        'lastMessage': 'Gracias por tu ayuda',
        'time': 'Ayer',
        'unread': 0,
        'image': 'https://randomuser.me/api/portraits/men/2.jpg',
      },
      {
        'name': 'Ana Martínez',
        'lastMessage': '¿Cuándo podrías venir a revisar el jardín?',
        'time': 'Lun',
        'unread': 1,
        'image': 'https://randomuser.me/api/portraits/women/2.jpg',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mensajes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Search chats
            },
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: _chats.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final chat = _chats[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(chat['image']),
            ),
            title: Text(
              chat['name'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              chat['lastMessage'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  chat['time'],
                  style: TextStyle(
                    fontSize: 12,
                    color: chat['unread'] > 0 ? Theme.of(context).primaryColor : Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                if (chat['unread'] > 0)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      chat['unread'].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.chat);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // New chat
        },
        child: const Icon(Icons.chat),
      ),
    );
  }
}

