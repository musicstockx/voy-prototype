import 'package:flutter/material.dart';

void main() => runApp(const VOYPrototype());

const purple = Color(0xFF7655D9);
const backgroundColor = Color(0xFFF7F6FB);
const userAvatar = 'https://i.pravatar.cc/300?img=11';

class VOYPrototype extends StatelessWidget {
  const VOYPrototype({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'VOY Presentation',
    theme: ThemeData(useMaterial3: true, scaffoldBackgroundColor: backgroundColor, colorScheme: ColorScheme.fromSeed(seedColor: purple), appBarTheme: const AppBarTheme(backgroundColor: Colors.white, foregroundColor: Colors.black87, elevation: 0)),
    home: const PresentationScreen(),
  );
}

class Creator {
  String name, location, bio, image;
  List<String> categories, genres, skills, portfolio, achievements;
  Creator({required this.name, required this.location, required this.bio, required this.image, required this.categories, required this.genres, required this.skills, required this.portfolio, required this.achievements});
}

class Collaboration {
  String title, description, role, genre, creator;
  Collaboration({required this.title, required this.description, required this.role, required this.genre, required this.creator});
}

class VOYSubmission {
  String title, genre, description, audioUrl, videoUrl, creator, status;
  List<String> collaborators;
  VOYSubmission({required this.title, required this.genre, required this.description, required this.audioUrl, required this.videoUrl, required this.collaborators, this.creator = 'Demo creator', this.status = 'Pending review'});
}

class VOYData {
  static final List<VOYSubmission> submissions = [
    VOYSubmission(title: 'Midnight Frequency', genre: 'Hip-Hop', description: 'An original independent hip-hop track.', audioUrl: 'https://example.com/audio', videoUrl: 'https://youtube.com', collaborators: ['Aarav Mehta — Vocalist', 'Riya Sharma — Producer'], creator: 'Aarav Mehta'),
    VOYSubmission(title: 'Neon Skies', genre: 'Electronic Pop', description: 'A melodic electronic-pop visualiser project.', audioUrl: 'https://example.com/neon-audio', videoUrl: 'https://youtube.com', collaborators: ['Riya Sharma — Producer'], creator: 'Riya Sharma', status: 'Selected'),
  ];

  static final List<Creator> creators = [
    Creator(name: 'Aarav Mehta', location: 'Mumbai, India', bio: 'Independent vocalist and songwriter exploring new sounds.', image: 'https://i.pravatar.cc/300?img=12', categories: ['Vocalist', 'Lyricist'], genres: ['Hip-Hop', 'R&B'], skills: ['Songwriting', 'Melody Writing'], portfolio: ['Instagram', 'YouTube'], achievements: ['VOY featured project']),
    Creator(name: 'Riya Sharma', location: 'Delhi, India', bio: 'Music producer creating electronic and experimental sounds.', image: 'https://i.pravatar.cc/300?img=47', categories: ['Music Producer'], genres: ['Electronic', 'Pop'], skills: ['Beat Making', 'Sound Design'], portfolio: ['SoundCloud'], achievements: []),
    Creator(name: 'Kabir Khan', location: 'Pune, India', bio: 'Videographer and visual storyteller.', image: 'https://i.pravatar.cc/300?img=14', categories: ['Videographer', 'Video Editor'], genres: ['Hip-Hop', 'Cinematic'], skills: ['Music Videos', 'Editing'], portfolio: ['Instagram'], achievements: ['Artist collaboration']),
  ];
}

// Reusable avatar with automatic initials fallback.
class CreatorAvatar extends StatelessWidget {
  final String name, image;
  final double radius;
  const CreatorAvatar({super.key, required this.name, required this.image, this.radius = 28});

  @override
  Widget build(BuildContext context) => CircleAvatar(
    radius: radius,
    backgroundColor: const Color(0xFFE9E2FF),
    child: ClipOval(
      child: Image.network(
        image,
        width: radius * 2,
        height: radius * 2,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Center(child: Text(
          name.trim().isEmpty ? '?' : name.trim().split(RegExp(r'\s+')).take(2).map((e) => e[0].toUpperCase()).join(),
          style: TextStyle(color: purple, fontWeight: FontWeight.bold, fontSize: radius * 0.65),
        )),
      ),
    ),
  );
}

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});
  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;
  final List<String> slideImages = [
    'https://ik.imagekit.io/qv9d1ds23/slide1.png?updatedAt=1795502839309',
    'https://ik.imagekit.io/qv9d1ds23/slide2.png?updatedAt=1795502839347',
    'https://ik.imagekit.io/qv9d1ds23/slide3.png?updatedAt=1795502839388',
    'https://ik.imagekit.io/qv9d1ds23/slide%205.png',
    'https://ik.imagekit.io/qv9d1ds23/slide%207.png?updatedAt=1795534954433',
    'https://ik.imagekit.io/qv9d1ds23/slide%208.png?updatedAt=1795534938096',
  ];

  void goToPage(int page) {
    if (page < 0 || page > 7) return;
    _controller.animateToPage(page, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('VoY Presentation', style: TextStyle(fontWeight: FontWeight.bold)), actions: [
      IconButton(onPressed: () => goToPage(currentPage - 1), icon: const Icon(Icons.chevron_left), tooltip: 'Previous slide'),
      Center(child: Text('${currentPage + 1} / 8', style: const TextStyle(fontWeight: FontWeight.w600))),
      IconButton(onPressed: () => goToPage(currentPage + 1), icon: const Icon(Icons.chevron_right), tooltip: 'Next slide'),
      const SizedBox(width: 6),
    ]),
    body: PageView(controller: _controller, onPageChanged: (index) => setState(() => currentPage = index), children: [
      SlideImage(url: slideImages[0]), SlideImage(url: slideImages[1]), SlideImage(url: slideImages[2]),
      const MainPage(), SlideImage(url: slideImages[3]), const AdminPanelPage(),SlideImage(url: slideImages[4]), SlideImage(url: slideImages[5]),
    ]),
  );
}

class SlideImage extends StatelessWidget {
  final String url;
  const SlideImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) => Container(
    color: Colors.black,
    alignment: Alignment.center,
    child: InteractiveViewer(minScale: 0.8, maxScale: 4, child: Image.network(
      url, fit: BoxFit.contain, width: double.infinity, height: double.infinity,
      loadingBuilder: (context, child, progress) => progress == null ? child : const Center(child: CircularProgressIndicator(color: Colors.white)),
      errorBuilder: (_, __, ___) => const Center(child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.broken_image_outlined, color: Colors.white, size: 50), SizedBox(height: 12),
          Text('Unable to load slide image. Check your internet connection or image URL.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
        ]),
      )),
    )),
  );
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int selectedTab = 0;
  final List<Collaboration> collaborations = [
    Collaboration(title: 'Looking for a Music Producer', description: 'Need a producer for an original hip-hop track.', role: 'Music Producer', genre: 'Hip-Hop', creator: 'Aarav Mehta'),
    Collaboration(title: 'Music Video Project', description: 'Looking for a videographer for an independent song.', role: 'Videographer', genre: 'Pop', creator: 'Riya Sharma'),
  ];
  final List<String> categories = ['Lyricist', 'Vocalist', 'Music Producer', 'Mixing & Mastering Engineer', 'Videographer', 'Video Editor'];
  final List<String> myCategories = ['Vocalist', 'Lyricist'], myGenres = ['Hip-Hop', 'Rap'], mySkills = ['Songwriting', 'Freestyle'], portfolioLinks = [], achievements = ['Independent music creator'];
  final nameController = TextEditingController(text: 'Your Name');
  final bioController = TextEditingController(text: 'Independent music creator.');

  void showMessage(String message) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));

  @override
  void dispose() { nameController.dispose(); bioController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('VoY - user app prototype', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17))),
    body: Column(children: [
      Expanded(child: IndexedStack(index: selectedTab, children: [discoverPage(), collaboratePage(), submitPage(), profilePage()])),
      Container(
        decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Color(0xFFEAE8EF)))),
        child: NavigationBar(
          selectedIndex: selectedTab, backgroundColor: Colors.white, indicatorColor: purple.withValues(alpha: 0.13),
          onDestinationSelected: (index) => setState(() => selectedTab = index),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore), label: 'Discover'),
            NavigationDestination(icon: Icon(Icons.people_outline), selectedIcon: Icon(Icons.people), label: 'Collaborate'),
            NavigationDestination(icon: Icon(Icons.upload_outlined), selectedIcon: Icon(Icons.upload), label: 'Submit'),
            NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    ]),
  );

  Widget discoverPage() => CustomScrollView(slivers: [
    SliverToBoxAdapter(child: Padding(
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Discover Creators', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6), const Text('Find creative minds. Build something together.', style: TextStyle(color: Colors.black54)),
        Image.network('https://images.unsplash.com/photo-1516280440614-37939bbacd81?auto=format&fit=crop&w=1200&q=80', height: 150, width: double.infinity, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const SizedBox.shrink()),
        const SizedBox(height: 18),
        TextField(decoration: InputDecoration(hintText: 'Search creators, genres or skills', prefixIcon: const Icon(Icons.search), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none))),
        const SizedBox(height: 16), const Text('Explore creators', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ]),
    )),
    SliverPadding(padding: const EdgeInsets.fromLTRB(16, 4, 16, 20), sliver: SliverList(delegate: SliverChildBuilderDelegate(
      (context, index) { final creator = VOYData.creators[index]; return CreatorCard(creator: creator, onTap: () => openCreator(creator)); },
      childCount: VOYData.creators.length,
    ))),
  ]);

  void openCreator(Creator creator) => Navigator.push(context, MaterialPageRoute(builder: (_) => CreatorDetailPage(creator: creator)));

  Widget collaboratePage() => CustomScrollView(slivers: [
    SliverToBoxAdapter(child: Padding(
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Collaborate', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6), const Text('Find collaborators or start your own project.', style: TextStyle(color: Colors.black54)),
        const SizedBox(height: 18),
        SizedBox(width: double.infinity, child: FilledButton.icon(
          style: FilledButton.styleFrom(backgroundColor: purple, padding: const EdgeInsets.all(14)),
          onPressed: createCollaboration, icon: const Icon(Icons.add), label: const Text('Create collaboration'),
        )),
        const SizedBox(height: 20), const Text('Open opportunities', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ]),
    )),
    SliverPadding(padding: const EdgeInsets.fromLTRB(16, 0, 16, 20), sliver: SliverList(delegate: SliverChildBuilderDelegate(
      (context, index) {
        final item = collaborations[index];
        final creator = VOYData.creators.where((c) => c.name == item.creator).firstOrNull;
        return Card(color: Colors.white, margin: const EdgeInsets.only(bottom: 12), child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            const SizedBox(height: 8), Text(item.description), const SizedBox(height: 12),
            Wrap(spacing: 7, children: [Tag(text: item.role), Tag(text: item.genre)]),
            const SizedBox(height: 12),
            Row(children: [
              CreatorAvatar(name: item.creator, image: creator?.image ?? userAvatar, radius: 17),
              const SizedBox(width: 8), Expanded(child: Text(item.creator)),
              TextButton(onPressed: () => showMessage('Collaboration request feature is a prototype.'), child: const Text('Connect')),
            ]),
          ]),
        ));
      },
      childCount: collaborations.length,
    ))),
  ]);

  void createCollaboration() {
    final title = TextEditingController(), description = TextEditingController(), role = TextEditingController(), genre = TextEditingController();
    showDialog(context: context, builder: (dialogContext) => AlertDialog(
      title: const Text('Create collaboration'),
      content: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [
        TextField(controller: title, decoration: const InputDecoration(labelText: 'Project title')),
        TextField(controller: description, decoration: const InputDecoration(labelText: 'Description')),
        TextField(controller: role, decoration: const InputDecoration(labelText: 'Required creator role')),
        TextField(controller: genre, decoration: const InputDecoration(labelText: 'Genre')),
      ])),
      actions: [
        TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancel')),
        FilledButton(onPressed: () {
          if (title.text.trim().isEmpty) return;
          setState(() => collaborations.insert(0, Collaboration(title: title.text.trim(), description: description.text.trim(), role: role.text.trim().isEmpty ? 'Open role' : role.text.trim(), genre: genre.text.trim().isEmpty ? 'All genres' : genre.text.trim(), creator: nameController.text)));
          Navigator.pop(dialogContext); showMessage('Collaboration created.');
        }, child: const Text('Create')),
      ],
    ));
  }

  Widget submitPage() => SubmitForm(creatorName: nameController.text, onSubmit: (submission) {
    setState(() => VOYData.submissions.insert(0, submission));
    showMessage('Project submitted. It is now visible in the admin panel.');
  });

  Widget profilePage() => ListView(padding: const EdgeInsets.all(18), children: [
    const Text('Creator Profile', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
    const SizedBox(height: 20),
    Center(child: Column(children: [
      CreatorAvatar(name: nameController.text, image: userAvatar, radius: 48),
      const SizedBox(height: 12), Text(nameController.text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const Text('Independent Creator', style: TextStyle(color: Colors.black54)),
    ])),
    const SizedBox(height: 24),
    sectionCard(title: 'Basic information', child: Column(children: [
      TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Your name'), onChanged: (_) => setState(() {})),
      TextField(controller: bioController, maxLines: 2, decoration: const InputDecoration(labelText: 'About you')),
    ])),
    sectionCard(title: 'Creator categories', subtitle: 'Select all roles that describe your work.', child: Wrap(spacing: 8, runSpacing: 8, children: categories.map((category) {
      final selected = myCategories.contains(category);
      return FilterChip(label: Text(category), selected: selected, selectedColor: purple.withValues(alpha: 0.15), onSelected: (value) => setState(() { if (value) { myCategories.add(category); } else { myCategories.remove(category); } }));
    }).toList())),
    sectionCard(title: 'Genres', subtitle: 'Add the genres you work with.', child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Wrap(spacing: 8, runSpacing: 8, children: myGenres.map((e) => Tag(text: e)).toList()),
      TextButton.icon(onPressed: () => addTag(myGenres, 'Add genre'), icon: const Icon(Icons.add), label: const Text('Add genre')),
    ])),
    sectionCard(title: 'Skills & specialisations', subtitle: 'Showcase your creative capabilities.', child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Wrap(spacing: 8, runSpacing: 8, children: mySkills.map((e) => Tag(text: e)).toList()),
      TextButton.icon(onPressed: () => addTag(mySkills, 'Add skill'), icon: const Icon(Icons.add), label: const Text('Add skill')),
    ])),
    sectionCard(title: 'Portfolio & external links', subtitle: 'Link your creative work and social profiles.', child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ...portfolioLinks.map((link) => ListTile(dense: true, leading: const Icon(Icons.link), title: Text(link))),
      TextButton.icon(onPressed: () => addTag(portfolioLinks, 'Add portfolio or social link'), icon: const Icon(Icons.add), label: const Text('Add link')),
    ])),
    sectionCard(title: 'Achievements', subtitle: 'Recognition and completed VOY projects.', child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ...achievements.map((achievement) => ListTile(dense: true, leading: const Icon(Icons.verified_outlined, color: purple), title: Text(achievement))),
      TextButton.icon(onPressed: () => addTag(achievements, 'Add achievement'), icon: const Icon(Icons.add), label: const Text('Add achievement')),
    ])),
    sectionCard(title: 'My VOY submissions', child: VOYData.submissions.isEmpty
      ? const Text('Your submitted projects will appear here.', style: TextStyle(color: Colors.black54))
      : Column(children: VOYData.submissions.map((item) => ListTile(contentPadding: EdgeInsets.zero, leading: const Icon(Icons.music_note), title: Text(item.title), subtitle: Text('${item.genre} • ${item.status}'))).toList())),
    const SizedBox(height: 20),
  ]);

  Widget sectionCard({required String title, String? subtitle, required Widget child}) => Card(
    color: Colors.white, margin: const EdgeInsets.only(bottom: 14),
    child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
      if (subtitle != null) ...[const SizedBox(height: 5), Text(subtitle, style: const TextStyle(color: Colors.black54, fontSize: 13))],
      const SizedBox(height: 12), child,
    ])),
  );

  void addTag(List<String> target, String title) {
    final controller = TextEditingController();
    showDialog(context: context, builder: (dialogContext) => AlertDialog(
      title: Text(title), content: TextField(controller: controller, autofocus: true, decoration: const InputDecoration(hintText: 'Enter here')),
      actions: [
        TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancel')),
        FilledButton(onPressed: () { final value = controller.text.trim(); if (value.isNotEmpty) setState(() => target.add(value)); Navigator.pop(dialogContext); }, child: const Text('Add')),
      ],
    ));
  }
}

class CreatorCard extends StatelessWidget {
  final Creator creator;
  final VoidCallback onTap;
  const CreatorCard({super.key, required this.creator, required this.onTap});

  @override
  Widget build(BuildContext context) => Card(
    color: Colors.white, margin: const EdgeInsets.only(bottom: 13),
    child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(12), child: Padding(
      padding: const EdgeInsets.all(14),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CreatorAvatar(name: creator.name, image: creator.image, radius: 31),
        const SizedBox(width: 13),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(creator.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 3), Text(creator.location, style: const TextStyle(color: Colors.black54, fontSize: 12)),
          const SizedBox(height: 8), Text(creator.bio, maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 8),
          Wrap(spacing: 5, runSpacing: 5, children: [...creator.categories.map((e) => Tag(text: e)), ...creator.genres.map((e) => Tag(text: e))]),
        ])),
        const Icon(Icons.chevron_right),
      ]),
    )),
  );
}

class CreatorDetailPage extends StatelessWidget {
  final Creator creator;
  const CreatorDetailPage({super.key, required this.creator});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Creator Profile')),
    body: ListView(padding: const EdgeInsets.all(20), children: [
      Center(child: CreatorAvatar(name: creator.name, image: creator.image, radius: 54)),
      const SizedBox(height: 14),
      Text(creator.name, textAlign: TextAlign.center, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
      Text(creator.location, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black54)),
      const SizedBox(height: 20), Text(creator.bio), const SizedBox(height: 20),
      detailSection('Categories', creator.categories), detailSection('Genres', creator.genres),
      detailSection('Skills', creator.skills), detailSection('Portfolio', creator.portfolio),
      detailSection('Achievements', creator.achievements), const SizedBox(height: 20),
      FilledButton.icon(
        style: FilledButton.styleFrom(backgroundColor: purple, padding: const EdgeInsets.all(14)),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MessagePage(creatorName: creator.name, creatorImage: creator.image))),
        icon: const Icon(Icons.chat_bubble_outline), label: const Text('Message creator'),
      ),
    ]),
  );

  Widget detailSection(String title, List<String> items) => Padding(
    padding: const EdgeInsets.only(bottom: 18),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
      const SizedBox(height: 8),
      if (items.isEmpty) const Text('Not added yet', style: TextStyle(color: Colors.black54))
      else Wrap(spacing: 8, runSpacing: 8, children: items.map((item) => Tag(text: item)).toList()),
    ]),
  );
}

class MessagePage extends StatefulWidget {
  final String creatorName, creatorImage;
  const MessagePage({super.key, required this.creatorName, this.creatorImage = userAvatar});
  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final TextEditingController controller = TextEditingController();
  final List<String> messages = [];

  @override
  void dispose() { controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Row(children: [
      CreatorAvatar(name: widget.creatorName, image: widget.creatorImage, radius: 18),
      const SizedBox(width: 10), Expanded(child: Text(widget.creatorName)),
    ])),
    body: Column(children: [
      Expanded(child: messages.isEmpty
        ? const Center(child: Text('Start a conversation', style: TextStyle(color: Colors.black54)))
        : ListView.builder(
          padding: const EdgeInsets.all(16), itemCount: messages.length,
          itemBuilder: (context, index) => Align(alignment: Alignment.centerRight, child: Container(
            padding: const EdgeInsets.all(12), margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(color: purple.withValues(alpha: 0.13), borderRadius: BorderRadius.circular(14)),
            child: Text(messages[index]),
          )),
        )),
      SafeArea(child: Padding(padding: const EdgeInsets.all(12), child: Row(children: [
        Expanded(child: TextField(controller: controller, decoration: InputDecoration(
          hintText: 'Write a message...', filled: true, fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
        ))),
        IconButton(onPressed: () {
          if (controller.text.trim().isEmpty) return;
          setState(() { messages.add(controller.text.trim()); controller.clear(); });
        }, icon: const Icon(Icons.send, color: purple)),
      ]))),
    ]),
  );
}

class SubmitForm extends StatefulWidget {
  final ValueChanged<VOYSubmission> onSubmit;
  final String creatorName;
  const SubmitForm({super.key, required this.onSubmit, required this.creatorName});
  @override
  State<SubmitForm> createState() => _SubmitFormState();
}

class _SubmitFormState extends State<SubmitForm> {
  final titleController = TextEditingController(), genreController = TextEditingController(), descriptionController = TextEditingController(), audioController = TextEditingController(), videoController = TextEditingController(), collaboratorController = TextEditingController();
  final List<String> collaborators = [];

  @override
  void dispose() {
    titleController.dispose(); genreController.dispose(); descriptionController.dispose();
    audioController.dispose(); videoController.dispose(); collaboratorController.dispose();
    super.dispose();
  }

  void addCollaborator() {
    final value = collaboratorController.text.trim();
    if (value.isEmpty) return;
    setState(() { collaborators.add(value); collaboratorController.clear(); });
  }

  void submit() {
    if (titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a project title.')));
      return;
    }
    widget.onSubmit(VOYSubmission(
      title: titleController.text.trim(), genre: genreController.text.trim(),
      description: descriptionController.text.trim(), audioUrl: audioController.text.trim(),
      videoUrl: videoController.text.trim(), collaborators: List.from(collaborators), creator: widget.creatorName,
    ));
    titleController.clear(); genreController.clear(); descriptionController.clear();
    audioController.clear(); videoController.clear(); setState(() => collaborators.clear());
  }

  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(18), children: [
    const Text('Submit Your Project', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
    const SizedBox(height: 6), const Text('Share your original music and audiovisual work with VOY.', style: TextStyle(color: Colors.black54)),
    const SizedBox(height: 22),
    formField(titleController, 'Project title'), formField(genreController, 'Genre'),
    formField(descriptionController, 'Project description', maxLines: 3),
    const SizedBox(height: 12), const Text('Project links', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
    const SizedBox(height: 8), formField(audioController, 'Audio link (YouTube, SoundCloud, etc.)'),
    formField(videoController, 'Music video / visualiser link'),
    const SizedBox(height: 12), const Text('Collaborators', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
    const SizedBox(height: 8),
    Row(children: [
      Expanded(child: TextField(controller: collaboratorController, decoration: const InputDecoration(hintText: 'Collaborator name and role', filled: true, fillColor: Colors.white, border: OutlineInputBorder()))),
      IconButton(onPressed: addCollaborator, icon: const Icon(Icons.add_circle, color: purple, size: 30)),
    ]),
    const SizedBox(height: 10),
    Wrap(spacing: 8, runSpacing: 8, children: collaborators.map((item) => InputChip(label: Text(item), onDeleted: () => setState(() => collaborators.remove(item)))).toList()),
    const SizedBox(height: 22),
    FilledButton.icon(style: FilledButton.styleFrom(backgroundColor: purple, padding: const EdgeInsets.all(15)), onPressed: submit, icon: const Icon(Icons.upload), label: const Text('Submit project')),
    const SizedBox(height: 12),
    const Text('Prototype note: Links and project details are stored locally during this session. Actual media uploads, collaborator approvals and evaluation require backend integration.', style: TextStyle(color: Colors.black54, fontSize: 12)),
  ]);

  Widget formField(TextEditingController controller, String hint, {int maxLines = 1}) => Padding(
    padding: const EdgeInsets.only(bottom: 13),
    child: TextField(controller: controller, maxLines: maxLines, decoration: InputDecoration(
      hintText: hint, filled: true, fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
    )),
  );
}

// Responsive admin panel: bottom navigation on phones, side rail on wider screens.
class AdminPanelPage extends StatefulWidget {
  const AdminPanelPage({super.key});
  @override
  State<AdminPanelPage> createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends State<AdminPanelPage> {
  int selectedSection = 0;
  final List<String> sections = ['Overview', 'Submissions', 'Creators', 'Content'];
  int get pendingCount => VOYData.submissions.where((s) => s.status == 'Pending review').length;
  int get selectedCount => VOYData.submissions.where((s) => s.status == 'Selected').length;

  final List<Widget> _icons = const [
    Icon(Icons.dashboard_outlined), Icon(Icons.library_music_outlined),
    Icon(Icons.people_outline), Icon(Icons.video_library_outlined),
  ];
  final List<Widget> _selectedIcons = const [
    Icon(Icons.dashboard), Icon(Icons.library_music), Icon(Icons.people), Icon(Icons.video_library),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('VoY - admin panel prototype', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)), actions: [
      Padding(padding: const EdgeInsets.only(right: 14), child: CircleAvatar(
        radius: 17, backgroundColor: purple.withValues(alpha: 0.13),
        child: const Icon(Icons.admin_panel_settings, color: purple, size: 19),
      )),
    ]),
    body: LayoutBuilder(builder: (context, constraints) {
      final wide = constraints.maxWidth >= 650;
      final content = IndexedStack(index: selectedSection, children: [
        overviewSection(), submissionsSection(), creatorsSection(), contentSection(),
      ]);

      if (wide) {
        return Row(children: [
          NavigationRail(
            selectedIndex: selectedSection,
            onDestinationSelected: (index) => setState(() => selectedSection = index),
            labelType: NavigationRailLabelType.all,
            backgroundColor: Colors.white,
            selectedIconTheme: const IconThemeData(color: purple),
            selectedLabelTextStyle: const TextStyle(color: purple, fontWeight: FontWeight.w700),
            destinations: List.generate(4, (i) => NavigationRailDestination(
              icon: _icons[i], selectedIcon: _selectedIcons[i], label: Text(sections[i]),
            )),
          ),
          const VerticalDivider(width: 1, thickness: 1),
          Expanded(child: content),
        ]);
      }

      return Column(children: [
        Expanded(child: content),
        NavigationBar(
          height: 66,
          selectedIndex: selectedSection,
          onDestinationSelected: (index) => setState(() => selectedSection = index),
          backgroundColor: Colors.white,
          indicatorColor: purple.withValues(alpha: 0.13),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: List.generate(4, (i) => NavigationDestination(
            icon: _icons[i], selectedIcon: _selectedIcons[i], label: sections[i],
          )),
        ),
      ]);
    }),
  );

  Widget overviewSection() => ListView(padding: const EdgeInsets.all(18), children: [
    const Text('Dashboard overview', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
    const SizedBox(height: 5), const Text('Monitor creator activity and project submissions.', style: TextStyle(color: Colors.black54)),
    Image.network('https://images.unsplash.com/photo-1598488035139-bdbb2231ce04?auto=format&fit=crop&w=1200&q=80', height: 150, width: double.infinity, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const SizedBox.shrink()),
    const SizedBox(height: 18),
    GridView.count(
      crossAxisCount: MediaQuery.of(context).size.width > 700 ? 4 : 2,
      shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 1.45,
      children: [
        metricCard('Creators', '${VOYData.creators.length}', Icons.people_alt_outlined, Colors.blue),
        metricCard('Submissions', '${VOYData.submissions.length}', Icons.library_music_outlined, purple),
        metricCard('Pending review', '$pendingCount', Icons.pending_actions, Colors.orange),
        metricCard('Selected projects', '$selectedCount', Icons.check_circle_outline, Colors.green),
      ],
    ),
    const SizedBox(height: 22), const Text('Recent submissions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    const SizedBox(height: 10), ...VOYData.submissions.take(4).map(submissionSummaryCard),
    const SizedBox(height: 16),
    Card(color: Colors.white, child: const Padding(padding: EdgeInsets.all(14), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(Icons.info_outline, color: purple), SizedBox(width: 10),
      Expanded(child: Text('Admin preview: actions update sample data locally for this running session. Authentication, role permissions and server-side records are not connected.', style: TextStyle(fontSize: 12, color: Colors.black54))),
    ]))),
  ]);

  Widget metricCard(String title, String value, IconData icon, Color color) => Card(
    color: Colors.white, child: Padding(padding: const EdgeInsets.all(12), child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(icon, color: color, size: 25),
        Text(value, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
        Text(title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, color: Colors.black54)),
      ],
    )),
  );

  Widget submissionsSection() => ListView(padding: const EdgeInsets.all(16), children: [
    const Text('Submission management', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    const SizedBox(height: 5), const Text('Review projects and update their selection status.', style: TextStyle(color: Colors.black54)),
    const SizedBox(height: 14),
    if (VOYData.submissions.isEmpty) const EmptyState(icon: Icons.library_music_outlined, message: 'No projects have been submitted yet.')
    else ...VOYData.submissions.map(submissionAdminCard),
  ]);

  Widget submissionAdminCard(VOYSubmission submission) {
    final statusColor = submission.status == 'Selected' ? Colors.green : submission.status == 'Rejected' ? Colors.red : Colors.orange;
    return Card(color: Colors.white, margin: const EdgeInsets.only(bottom: 12), child: Padding(
      padding: const EdgeInsets.all(14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const CircleAvatar(backgroundColor: Color(0xFFECE6FF), child: Icon(Icons.music_note, color: purple)),
          const SizedBox(width: 10),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(submission.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('${submission.creator} • ${submission.genre}', style: const TextStyle(fontSize: 12, color: Colors.black54)),
          ])),
          Flexible(child: StatusPill(text: submission.status, color: statusColor)),
        ]),
        const SizedBox(height: 10),
        Text(submission.description.isEmpty ? 'No description provided.' : submission.description),
        const SizedBox(height: 8),
        Text('Collaborators: ${submission.collaborators.isEmpty ? "Not listed" : submission.collaborators.join(", ")}', style: const TextStyle(fontSize: 12, color: Colors.black54)),
        const SizedBox(height: 10),
        Wrap(spacing: 8, runSpacing: 4, children: [
          if (submission.audioUrl.isNotEmpty) const Chip(avatar: Icon(Icons.audiotrack, size: 16), label: Text('Audio link added')),
          if (submission.videoUrl.isNotEmpty) const Chip(avatar: Icon(Icons.play_circle_outline, size: 16), label: Text('Video link added')),
        ]),
        const SizedBox(height: 8),
        Wrap(alignment: WrapAlignment.end, spacing: 6, runSpacing: 4, children: [
          OutlinedButton(onPressed: () => showSubmissionDetails(submission), child: const Text('View details')),
          if (submission.status != 'Selected') FilledButton.tonal(onPressed: () => updateStatus(submission, 'Selected'), child: const Text('Select')),
          if (submission.status != 'Rejected') TextButton(onPressed: () => updateStatus(submission, 'Rejected'), child: const Text('Reject', style: TextStyle(color: Colors.red))),
          if (submission.status != 'Pending review') TextButton(onPressed: () => updateStatus(submission, 'Pending review'), child: const Text('Reset')),
        ]),
      ]),
    ));
  }

  Widget submissionSummaryCard(VOYSubmission submission) {
    final color = submission.status == 'Selected' ? Colors.green : submission.status == 'Rejected' ? Colors.red : Colors.orange;
    return Card(color: Colors.white, child: ListTile(
      leading: const Icon(Icons.music_note, color: purple), title: Text(submission.title),
      subtitle: Text('${submission.creator} • ${submission.genre}'),
      trailing: StatusPill(text: submission.status, color: color),
    ));
  }

  void updateStatus(VOYSubmission submission, String status) {
    setState(() => submission.status = status);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('"${submission.title}" marked $status.')));
  }

  void showSubmissionDetails(VOYSubmission submission) {
    showDialog(context: context, builder: (dialogContext) => AlertDialog(
      title: Text(submission.title),
      content: SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
        Text('Creator: ${submission.creator}'), Text('Genre: ${submission.genre}'),
        const SizedBox(height: 10), Text(submission.description.isEmpty ? 'No project description.' : submission.description),
        const SizedBox(height: 12), const Text('Collaborators', style: TextStyle(fontWeight: FontWeight.bold)),
        ...submission.collaborators.map((e) => Text('• $e')),
        const SizedBox(height: 12), const Text('Audio link', style: TextStyle(fontWeight: FontWeight.bold)),
        SelectableText(submission.audioUrl.isEmpty ? 'Not provided' : submission.audioUrl),
        const SizedBox(height: 8), const Text('Video link', style: TextStyle(fontWeight: FontWeight.bold)),
        SelectableText(submission.videoUrl.isEmpty ? 'Not provided' : submission.videoUrl),
      ])),
      actions: [TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Close'))],
    ));
  }

  Widget creatorsSection() => ListView(padding: const EdgeInsets.all(16), children: [
    const Text('Creator management', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    const SizedBox(height: 5), const Text('Browse creator profiles and their public-facing details.', style: TextStyle(color: Colors.black54)),
    const SizedBox(height: 14),
    ...VOYData.creators.map((creator) => Card(color: Colors.white, margin: const EdgeInsets.only(bottom: 10), child: ListTile(
      leading: CreatorAvatar(name: creator.name, image: creator.image, radius: 22),
      title: Text(creator.name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text('${creator.location}\n${creator.categories.join(" • ")}'),
      isThreeLine: true,
      trailing: IconButton(icon: const Icon(Icons.visibility_outlined), onPressed: () => showCreatorDetails(creator)),
    ))),
  ]);

  void showCreatorDetails(Creator creator) {
    showDialog(context: context, builder: (dialogContext) => AlertDialog(
      title: Row(children: [
        CreatorAvatar(name: creator.name, image: creator.image, radius: 22),
        const SizedBox(width: 10), Expanded(child: Text(creator.name)),
      ]),
      content: SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
        Text(creator.location), const SizedBox(height: 8), Text(creator.bio), const SizedBox(height: 12),
        Text('Categories: ${creator.categories.join(", ")}'),
        Text('Genres: ${creator.genres.join(", ")}'),
        Text('Skills: ${creator.skills.join(", ")}'),
        Text('Portfolio: ${creator.portfolio.join(", ")}'),
        Text('Achievements: ${creator.achievements.join(", ")}'),
      ])),
      actions: [TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Close'))],
    ));
  }

  Widget contentSection() {
    final selected = VOYData.submissions.where((submission) => submission.status == 'Selected').toList();
    return ListView(padding: const EdgeInsets.all(16), children: [
      const Text('Content management', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      const SizedBox(height: 5), const Text('Selected projects ready for VOY channel planning and publication tracking.', style: TextStyle(color: Colors.black54)),
      const SizedBox(height: 14),
      if (selected.isEmpty) const EmptyState(icon: Icons.video_library_outlined, message: 'No selected projects are ready for content planning.')
      else ...selected.map((submission) => Card(color: Colors.white, margin: const EdgeInsets.only(bottom: 12), child: ListTile(
        leading: const CircleAvatar(backgroundColor: Color(0xFFFFE8E8), child: Icon(Icons.play_arrow, color: Colors.red)),
        title: Text(submission.title),
        subtitle: Text('${submission.creator} • ${submission.genre}\nStatus: Selected for distribution'),
        isThreeLine: true,
        trailing: PopupMenuButton(
          onSelected: (value) => setState(() {
            if (value == 'Published') { submission.status = 'Published'; }
            else if (value == 'Selected') { submission.status = 'Selected'; }
          }),
          itemBuilder: (_) => const [
            PopupMenuItem(value: 'Published', child: Text('Mark as published')),
            PopupMenuItem(value: 'Selected', child: Text('Reset to selected')),
          ],
        ),
      ))),
      const SizedBox(height: 10),
      const Text('This is a local content-planning preview. It does not publish videos to YouTube or connect to a channel.', style: TextStyle(fontSize: 12, color: Colors.black54)),
    ]);
  }
}

class StatusPill extends StatelessWidget {
  final String text;
  final Color color;
  const StatusPill({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
    decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(30)),
    child: Text(text, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w700)),
  );
}

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String message;
  const EmptyState({super.key, required this.icon, required this.message});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(30),
    child: Column(children: [
      Icon(icon, size: 42, color: Colors.black38), const SizedBox(height: 12),
      Text(message, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black54)),
    ]),
  );
}

class Tag extends StatelessWidget {
  final String text;
  const Tag({super.key, required this.text});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(color: purple.withValues(alpha: 0.10), borderRadius: BorderRadius.circular(20)),
    child: Text(text, style: const TextStyle(color: purple, fontSize: 11, fontWeight: FontWeight.w600)),
  );
}
