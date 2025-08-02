import 'package:flutter/material.dart';

class MessagingScreen extends StatefulWidget {
  const MessagingScreen({super.key});

  @override
  State<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  int _selectedIconIndex = 0; // Track which icon is selected
  
  final List<FamilyContact> _contacts = [
    FamilyContact(
      name: 'Colleen',
      subtitle: 'when will it be ready?',
      avatar: 'https://picsum.photos/150/150?random=20',
      time: '06:32 pm',
      hasNotification: true,
    ),
    FamilyContact(
      name: 'Shane',
      subtitle: 'when will it be ready?',
      avatar: 'https://picsum.photos/150/150?random=21',
      time: '07:34 am',
      hasNotification: true,
    ),
    FamilyContact(
      name: 'Esther',
      subtitle: 'when will it be ready?',
      avatar: 'https://picsum.photos/150/150?random=22',
      time: '04:02 am',
      hasNotification: true,
    ),
    FamilyContact(
      name: 'Angel',
      subtitle: 'when will it be ready?',
      avatar: 'https://picsum.photos/150/150?random=23',
      time: '07:19 pm',
      hasNotification: true,
    ),
    FamilyContact(
      name: 'Eduardo',
      subtitle: 'when will it be ready?',
      avatar: 'https://picsum.photos/150/150?random=24',
      time: '10:24 pm',
      hasNotification: true,
    ),
    FamilyContact(
      name: 'Greg',
      subtitle: 'when will it be ready?',
      avatar: 'https://picsum.photos/150/150?random=25',
      time: '04:15 am',
      hasNotification: true,
    ),
    FamilyContact(
      name: 'Aubrey',
      subtitle: 'when will it be ready?',
      avatar: 'https://picsum.photos/150/150?random=26',
      time: '02:02 am',
      hasNotification: true,
    ),
    FamilyContact(
      name: 'Kyle',
      subtitle: 'when will it be ready?',
      avatar: 'https://picsum.photos/150/150?random=27',
      time: '06:51 am',
      hasNotification: true,
    ),
    FamilyContact(
      name: 'Arlene',
      subtitle: 'when will it be ready?',
      avatar: 'https://picsum.photos/150/150?random=28',
      time: '01:09 am',
      hasNotification: true,
    ),
    FamilyContact(
      name: 'Cameron',
      subtitle: 'when will it be ready?',
      avatar: 'https://picsum.photos/150/150?random=29',
      time: '07:59 pm',
      hasNotification: true,
    ),
  ];

  // Show search dialog
  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Search Family Members',
            style: TextStyle(color: Color(0xFF2C1810)),
          ),
          content: TextField(
            decoration: const InputDecoration(
              hintText: 'Enter name to search...',
              prefixIcon: Icon(Icons.search, color: Color(0xFFD2691E)),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFD2691E)),
              ),
            ),
            onChanged: (value) {
              // Implement search functionality
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color(0xFF666666)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Implement search action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD2691E),
              ),
              child: const Text(
                'Search',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }



  // Build content based on selected icon
  Widget _buildSelectedContent() {
    switch (_selectedIconIndex) {
      case 0: // People icon
        return _buildPeopleSection();
      case 1: // Chat icon
        return _buildChatSection();
      case 2: // Settings icon
        return _buildSettingsSection();
      case 3: // Phone icon
        return _buildPhoneSection();
      default:
        return _buildPeopleSection();
    }
  }

  // People section (default)
  Widget _buildPeopleSection() {
    return Column(
      children: [
        // My Family group section
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFE0E0E0),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage('https://picsum.photos/150/150?random=100'),
                    onBackgroundImageError: (exception, stackTrace) {},
                  ),
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD2691E),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          '1',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Family',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C1810),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'when will it be ready?',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '11:41 pm',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF666666),
                    ),
                  ),
                  SizedBox(height: 4),
                  Icon(
                    Icons.push_pin_outlined,
                    size: 16,
                    color: Color(0xFF666666),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // "Peoples you may know" section header
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: const Color(0xFFF5F5F5),
          child: const Text(
            'Peoples you may know',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF666666),
            ),
          ),
        ),
        
        // Individual contacts list for people section
        Expanded(
          child: ListView.builder(
            itemCount: 8, // Show first 8 contacts for people section
            itemBuilder: (context, index) {
              final peopleContacts = [
                {'name': 'Debra', 'subtitle': 'Say Hello!', 'avatar': 'https://picsum.photos/150/150?random=101'},
                {'name': 'Dianne', 'subtitle': 'Say Hello!', 'avatar': 'https://picsum.photos/150/150?random=102'},
                {'name': 'Arlene', 'subtitle': 'Say Hello!', 'avatar': 'https://picsum.photos/150/150?random=103'},
                {'name': 'Kristin', 'subtitle': 'Say Hello!', 'avatar': 'https://picsum.photos/150/150?random=104'},
                {'name': 'Ronald', 'subtitle': 'Say Hello!', 'avatar': 'https://picsum.photos/150/150?random=105'},
                {'name': 'Soham', 'subtitle': 'Say Hello!', 'avatar': 'https://picsum.photos/150/150?random=106'},
                {'name': 'Mitchell', 'subtitle': 'Say Hello!', 'avatar': 'https://picsum.photos/150/150?random=107'},
                {'name': 'Darrell', 'subtitle': 'Say Hello!', 'avatar': 'https://picsum.photos/150/150?random=108'},
              ];
              
              final contact = peopleContacts[index];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFFF0F0F0),
                      width: 0.5,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(contact['avatar']!),
                      onBackgroundImageError: (exception, stackTrace) {},
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            contact['name']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF2C1810),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            contact['subtitle']!,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF888888),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD2691E),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Message',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Chat section - This is where your chat list goes
  Widget _buildChatSection() {
    return ListView.builder(
      itemCount: _contacts.length,
      itemBuilder: (context, index) {
        final contact = _contacts[index];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFF0F0F0),
                width: 0.5,
              ),
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(contact.avatar),
                onBackgroundImageError: (exception, stackTrace) {},
                child: contact.avatar.isEmpty
                    ? const Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.grey,
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C1810),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      contact.subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    contact.time,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF666666),
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (contact.hasNotification)
                    Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD2691E),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          '1',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Settings section (Status)
  Widget _buildSettingsSection() {
    return Column(
      children: [
        // My Status section
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFE0E0E0),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage('https://picsum.photos/150/150?random=200'),
                    onBackgroundImageError: (exception, stackTrace) {},
                  ),
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD2691E),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Status',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C1810),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Tap to add status update',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        // Status updates list
        Expanded(
          child: ListView.builder(
            itemCount: 8,
            itemBuilder: (context, index) {
              final statusUpdates = [
                {'name': 'Gladys', 'time': 'Today 10:34 am', 'avatar': 'https://picsum.photos/150/150?random=201'},
                {'name': 'Shawn', 'time': 'Today 06:02 am', 'avatar': 'https://picsum.photos/150/150?random=202'},
                {'name': 'Courtney', 'time': 'Today 07:10 pm', 'avatar': 'https://picsum.photos/150/150?random=203'},
                {'name': 'Cody', 'time': 'Yesterday 10:22 pm', 'avatar': 'https://picsum.photos/150/150?random=204'},
                {'name': 'Shane', 'time': 'Yesterday 06:15 am', 'avatar': 'https://picsum.photos/150/150?random=205'},
                {'name': 'Arthur', 'time': 'Yesterday 04:15 am', 'avatar': 'https://picsum.photos/150/150?random=206'},
                {'name': 'Soham', 'time': 'Yesterday 04:15 am', 'avatar': 'https://picsum.photos/150/150?random=207'},
                {'name': 'Leslie', 'time': 'Yesterday 04:15 am', 'avatar': 'https://picsum.photos/150/150?random=208'},
              ];
              
              final status = statusUpdates[index];
              final isViewed = index >= 5; // First 5 are recent, rest are viewed
              
              // Add "Viewed" header before viewed statuses
              if (index == 5) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: const Text(
                        'Viewed',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ),
                    _buildStatusItem(status, isViewed),
                  ],
                );
              }
              
              return _buildStatusItem(status, isViewed);
            },
          ),
        ),
      ],
    );
  }
  
  Widget _buildStatusItem(Map<String, String> status, bool isViewed) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFF0F0F0),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isViewed ? Colors.grey[400]! : const Color(0xFFD2691E),
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage(status['avatar']!),
              onBackgroundImageError: (exception, stackTrace) {},
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status['name']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C1810),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  status['time']!,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Phone section
  Widget _buildPhoneSection() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        final callLogs = [
          {
            'name': 'Colleen',
            'type': 'incoming',
            'time': '06:32 pm',
            'avatar': 'https://picsum.photos/150/150?random=301',
            'isVideo': false
          },
          {
            'name': 'Shane',
            'type': 'outgoing',
            'time': '07:34 am',
            'avatar': 'https://picsum.photos/150/150?random=302',
            'isVideo': false
          },
          {
            'name': 'Esther',
            'type': 'missed',
            'time': '04:02 am',
            'avatar': 'https://picsum.photos/150/150?random=303',
            'isVideo': false
          },
          {
            'name': 'Angel',
            'type': 'missed',
            'time': '07:10 pm',
            'avatar': 'https://picsum.photos/150/150?random=304',
            'isVideo': true
          },
          {
            'name': 'Eduardo',
            'type': 'outgoing',
            'time': '10:22 pm',
            'avatar': 'https://picsum.photos/150/150?random=305',
            'isVideo': true
          },
          {
            'name': 'Greg',
            'type': 'incoming',
            'time': '04:15 am',
            'avatar': 'https://picsum.photos/150/150?random=306',
            'isVideo': true
          },
          {
            'name': 'Esther',
            'type': 'missed',
            'time': '04:02 am',
            'avatar': 'https://picsum.photos/150/150?random=307',
            'isVideo': false
          },
          {
            'name': 'Angel',
            'type': 'missed',
            'time': '07:10 pm',
            'avatar': 'https://picsum.photos/150/150?random=308',
            'isVideo': true
          },
          {
            'name': 'Eduardo',
            'type': 'outgoing',
            'time': '10:22 pm',
            'avatar': 'https://picsum.photos/150/150?random=309',
            'isVideo': true
          },
          {
            'name': 'Greg',
            'type': 'incoming',
            'time': '04:15 am',
            'avatar': 'https://picsum.photos/150/150?random=310',
            'isVideo': true
          },
        ];
        
        final call = callLogs[index];
        return _buildCallLogItem(call);
      },
    );
  }
  
  Widget _buildCallLogItem(Map<String, dynamic> call) {
    Color getCallTypeColor() {
      switch (call['type']) {
        case 'incoming':
          return Colors.green;
        case 'outgoing':
          return Colors.blue;
        case 'missed':
          return Colors.red;
        default:
          return Colors.grey;
      }
    }
    
    IconData getCallTypeIcon() {
      switch (call['type']) {
        case 'incoming':
          return Icons.call_received;
        case 'outgoing':
          return Icons.call_made;
        case 'missed':
          return Icons.call_received;
        default:
          return Icons.call;
      }
    }
    
    String getCallTypeText() {
      if (call['isVideo']) {
        switch (call['type']) {
          case 'incoming':
            return 'Incoming video';
          case 'outgoing':
            return 'Outgoing video';
          case 'missed':
            return 'Missed incoming video';
          default:
            return 'Video call';
        }
      } else {
        switch (call['type']) {
          case 'incoming':
            return 'Incoming';
          case 'outgoing':
            return 'Outgoing';
          case 'missed':
            return 'Missed incoming';
          default:
            return 'Call';
        }
      }
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFF0F0F0),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundImage: NetworkImage(call['avatar']),
            onBackgroundImageError: (exception, stackTrace) {},
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  call['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C1810),
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(
                      getCallTypeIcon(),
                      size: 14,
                      color: getCallTypeColor(),
                    ),
                    const SizedBox(width: 4),
                    if (call['isVideo'])
                      const Icon(
                        Icons.videocam,
                        size: 14,
                        color: Color(0xFF666666),
                      ),
                    if (call['isVideo']) const SizedBox(width: 4),
                    Text(
                      getCallTypeText(),
                      style: TextStyle(
                        fontSize: 13,
                        color: call['type'] == 'missed' ? Colors.red : const Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                call['time'],
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF666666),
                ),
              ),
              const SizedBox(height: 4),
              Icon(
                call['isVideo'] ? Icons.videocam : Icons.phone,
                size: 20,
                color: const Color(0xFFD2691E),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF2C1810),
          ),
        ),
        title: const Text(
          'Family!',
          style: TextStyle(
            color: Color(0xFFD2691E),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showSearchDialog(context);
            },
            icon: const Icon(
              Icons.search,
              color: Color(0xFF2C1810),
              size: 28,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // 4 Icon sections below app bar
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFE0E0E0),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // People/Users icon
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIconIndex = 0;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _selectedIconIndex == 0 ? const Color(0xFFD2691E) : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.people,
                      color: _selectedIconIndex == 0 ? Colors.white : const Color(0xFF666666),
                      size: 24,
                    ),
                  ),
                ),
                // Chat/Message icon
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIconIndex = 1;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _selectedIconIndex == 1 ? const Color(0xFFD2691E) : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.chat_bubble_outline,
                      color: _selectedIconIndex == 1 ? Colors.white : const Color(0xFF666666),
                      size: 24,
                    ),
                  ),
                ),
                // Settings/Gear icon
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIconIndex = 2;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _selectedIconIndex == 2 ? const Color(0xFFD2691E) : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.autorenew_rounded,
                      color: _selectedIconIndex == 2 ? Colors.white : const Color(0xFF666666),
                      size: 24,
                    ),
                  ),
                ),
                // Phone/Call icon
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIconIndex = 3;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _selectedIconIndex == 3 ? const Color(0xFFD2691E) : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.phone,
                      color: _selectedIconIndex == 3 ? Colors.white : const Color(0xFF666666),
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content based on selected icon
          Expanded(
            child: _buildSelectedContent(),
          ),
        ],
      ),
    );
  }
}

class FamilyContact {
  final String name;
  final String subtitle;
  final String avatar;
  final String time;
  final bool hasNotification;

  FamilyContact({
    required this.name,
    required this.subtitle,
    required this.avatar,
    required this.time,
    this.hasNotification = false,
  });
}
