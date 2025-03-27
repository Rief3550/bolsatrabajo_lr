import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hola, ¿cómo estás?',
      'isMe': false,
      'time': DateTime.now().subtract(const Duration(days: 1, hours: 2)),
    },
    {
      'text': 'Hola, estoy bien, ¿y tú?',
      'isMe': true,
      'time': DateTime.now().subtract(const Duration(days: 1, hours: 1, minutes: 50)),
    },
    {
      'text': 'Bien, gracias. Quería consultarte sobre un trabajo de pintura para mi casa.',
      'isMe': false,
      'time': DateTime.now().subtract(const Duration(days: 1, hours: 1, minutes: 45)),
    },
    {
      'text': 'Claro, dime qué necesitas.',
      'isMe': true,
      'time': DateTime.now().subtract(const Duration(days: 1, hours: 1, minutes: 40)),
    },
    {
      'text': 'Necesito pintar el interior de mi casa, son aproximadamente 80m².',
      'isMe': false,
      'time': DateTime.now().subtract(const Duration(days: 1, hours: 1, minutes: 35)),
    },
    {
      'text': '¿Qué tipo de pintura prefieres? ¿Tienes algún color en mente?',
      'isMe': true,
      'time': DateTime.now().subtract(const Duration(days: 1, hours: 1, minutes: 30)),
    },
    {
      'text': 'Estaba pensando en pintura lavable, en tonos claros, principalmente blanco y beige.',
      'isMe': false,
      'time': DateTime.now().subtract(const Duration(days: 1, hours: 1, minutes: 25)),
    },
    {
      'text': 'Perfecto. ¿Cuándo te gustaría que realice el trabajo?',
      'isMe': true,
      'time': DateTime.now().subtract(const Duration(minutes: 20)),
    },
    {
      'text': 'Si es posible, la próxima semana.',
      'isMe': false,
      'time': DateTime.now().subtract(const Duration(minutes: 15)),
    },
    {
      'text': 'Déjame revisar mi agenda y te confirmo. ¿Te parece si te envío un presupuesto detallado?',
      'isMe': true,
      'time': DateTime.now().subtract(const Duration(minutes: 10)),
    },
    {
      'text': 'Sí, por favor. Gracias por tu rápida respuesta.',
      'isMe': false,
      'time': DateTime.now().subtract(const Duration(minutes: 5)),
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'text': _messageController.text.trim(),
        'isMe': true,
        'time': DateTime.now(),
      });
      _messageController.clear();
    });

    // Scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/1.jpg'),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Juan Pérez',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'En línea',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green[600],
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {
              // Call
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Show options
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: const Text('Ver perfil'),
                        onTap: () {
                          Navigator.pop(context);
                          // Navigate to profile
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.block),
                        title: const Text('Bloquear usuario'),
                        onTap: () {
                          Navigator.pop(context);
                          // Block user
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.delete),
                        title: const Text('Eliminar conversación'),
                        onTap: () {
                          Navigator.pop(context);
                          // Delete conversation
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final showDate = index == 0 ||
                    !DateUtils.isSameDay(
                      message['time'],
                      _messages[index - 1]['time'],
                    );

                return Column(
                  children: [
                    if (showDate)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _formatDate(message['time']),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    _buildMessage(message),
                  ],
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: () {
                    // Attach file
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Escribe un mensaje...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: null,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: Theme.of(context).primaryColor,
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(Map<String, dynamic> message) {
    final isMe = message['isMe'] as bool;
    final text = message['text'] as String;
    final time = message['time'] as DateTime;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isMe
              ? Theme.of(context).primaryColor
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(16).copyWith(
            bottomRight: isMe ? const Radius.circular(0) : null,
            bottomLeft: !isMe ? const Radius.circular(0) : null,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat('HH:mm').format(time),
              style: TextStyle(
                fontSize: 10,
                color: isMe ? Colors.white.withOpacity(0.7) : Colors.grey,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (DateUtils.isSameDay(date, now)) {
      return 'Hoy';
    } else if (DateUtils.isSameDay(date, now.subtract(const Duration(days: 1)))) {
      return 'Ayer';
    } else {
      return DateFormat('dd/MM/yyyy').format(date);
    }
  }
}

