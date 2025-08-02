import 'package:flutter/material.dart';
import '../widgets/messaging_screen.dart';

class MVVMHomeScreen extends StatefulWidget {
  const MVVMHomeScreen({super.key});

  @override
  State<MVVMHomeScreen> createState() => _MVVMHomeScreenState();
}

class _MVVMHomeScreenState extends State<MVVMHomeScreen> {
  int _currentIndex = 0;

  final List<FamilyPost> _posts = [
    FamilyPost(
      userName: 'John',
      userLocation: 'Post, Chennai,TamilNadu',
      userAvatar: 'https://picsum.photos/150/150?random=1',
      postImage: 'https://picsum.photos/400/600?random=10',
      timeAgo: '2h',
      description: 'Had an amazing day with family! 🏠❤️ Nothing beats spending quality time together. #FamilyTime #Blessed',
    ),
    FamilyPost(
      userName: 'Sarah',
      userLocation: 'Family Gathering, Mumbai',
      userAvatar: 'https://picsum.photos/150/150?random=2',
      postImage: 'https://picsum.photos/400/600?random=11',
      timeAgo: '4h',
      description: 'Beautiful family gathering in Mumbai! So grateful for these precious moments with everyone. 🌟👨‍👩‍👧‍👦',
    ),
  ];

  final List<StoryUser> _stories = [
    StoryUser(
      name: 'Your Story',
      avatar: 'https://picsum.photos/150/150?random=3',
      isAddStory: true,
    ),
    StoryUser(
      name: 'Mom',
      avatar: 'https://picsum.photos/150/150?random=4',
      hasStory: true,
    ),
    StoryUser(
      name: 'Dad',
      avatar: 'https://picsum.photos/150/150?random=5',
      hasStory: true,
    ),
    StoryUser(
      name: 'Sister',
      avatar: 'https://picsum.photos/150/150?random=6',
      hasStory: true,
    ),
    StoryUser(
      name: 'Brother',
      avatar: 'https://picsum.photos/150/150?random=7',
      hasStory: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Text(
              'Family!',
              style: TextStyle(
                color: Color(0xFFD2691E),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add_circle_outline,
                color: Color(0xFF2C1810),
                size: 28,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_border,
                color: Color(0xFF2C1810),
                size: 28,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MessagingScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.chat_bubble_outline,
                color: Color(0xFF2C1810),
                size: 28,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Stories Section
          Container(
            height: 95, // Reduced height to prevent overflow
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: _stories.length,
              itemBuilder: (context, index) {
                final story = _stories[index];
                return Container(
                  width: 70, // Fixed width to prevent overflow
                  margin: const EdgeInsets.only(right: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // Prevent overflow
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: story.hasStory
                              ? Border.all(
                                  color: const Color(0xFFD2691E),
                                  width: 2,
                                )
                              : null,
                        ),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundImage: NetworkImage(story.avatar),
                              onBackgroundImageError: (exception, stackTrace) {
                                // Handle image loading error
                              },
                              child: story.avatar.isEmpty
                                  ? const Icon(
                                      Icons.person,
                                      size: 30,
                                      color: Colors.grey,
                                    )
                                  : null,
                            ),
                            if (story.isAddStory)
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFD2691E),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4), // Reduced spacing
                      Flexible(
                        child: Text(
                          story.name,
                          style: const TextStyle(
                            fontSize: 11, // Slightly smaller font
                            color: Color(0xFF2C1810),
                          ),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          
          const Divider(height: 1, color: Color(0xFFE0E0E0)),
          
          // Posts Section
          Expanded(
            child: ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                final post = _posts[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Post Header
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(post.userAvatar),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post.userName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Color(0xFF2C1810),
                                    ),
                                  ),
                                  Text(
                                    post.userLocation,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF666666),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.more_vert,
                                color: Color(0xFF2C1810),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Post Image
                      SizedBox(
                        width: double.infinity,
                        height: 400,
                        child: Image.network(
                          post.postImage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: double.infinity,
                              height: 400,
                              color: Colors.grey[300],
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image_not_supported,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Image not available',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              width: double.infinity,
                              height: 400,
                              color: Colors.grey[200],
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xFFD2691E),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      
                      // Post Actions
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite_border,
                                color: Color(0xFF2C1810),
                                size: 28,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.chat_bubble_outline,
                                color: Color(0xFF2C1810),
                                size: 28,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.send_outlined,
                                color: Color(0xFF2C1810),
                                size: 28,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.bookmark_border,
                                color: Color(0xFF2C1810),
                                size: 28,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Post Description
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '${post.userName} ',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Color(0xFF2C1810),
                                    ),
                                  ),
                                  TextSpan(
                                    text: post.description,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF2C1810),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              post.timeAgo,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF666666),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFD2691E),
        unselectedItemColor: const Color(0xFF666666),
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Gift',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_tree),
            label: 'Family',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class FamilyPost {
  final String userName;
  final String userLocation;
  final String userAvatar;
  final String postImage;
  final String timeAgo;
  final String description;

  FamilyPost({
    required this.userName,
    required this.userLocation,
    required this.userAvatar,
    required this.postImage,
    required this.timeAgo,
    required this.description,
  });
}

class StoryUser {
  final String name;
  final String avatar;
  final bool hasStory;
  final bool isAddStory;

  StoryUser({
    required this.name,
    required this.avatar,
    this.hasStory = false,
    this.isAddStory = false,
  });
}
