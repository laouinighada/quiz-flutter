import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class VodPage extends StatefulWidget {
  @override
  _VodPageState createState() => _VodPageState();
}

class _VodPageState extends State<VodPage> {
  final List<Map<String, String>> _videos = [
    {
      'url': 'https://www.youtube.com/watch?v=1ukSR1GRtMU&list=PL4cUxeGkcC9jLYyp2Aoh6hcWuxFDX6PBJ',
      'title': 'Flutter Tutorial',
      'description': 'Learn how to build apps with Flutter.',
      'thumbnail': 'https://via.placeholder.com/800x450?text=Video+1', // Image générique
    },
    {
      'url': 'https://www.youtube.com/watch?v=2Vv-BfVoq4g',
      'title': 'Shape of You - Ed Sheeran',
      'description': 'Official Music Video.',
      'thumbnail': 'https://via.placeholder.com/800x450?text=Video+2', // Image générique
    },
    {
      'url': 'https://www.youtube.com/watch?v=JGwWNGJdvx8',
      'title': 'Thinking Out Loud - Ed Sheeran',
      'description': 'Official Music Video.',
      'thumbnail': 'https://via.placeholder.com/800x450?text=Video+3', // Image générique
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212932),
      appBar: AppBar(
        title: Text('Vidéo à la Demande'),
        backgroundColor: Colors.amber,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: _videos.length,
        itemBuilder: (context, index) {
          return _buildVideoCard(_videos[index]);
        },
      ),
    );
  }

  Widget _buildVideoCard(Map<String, String> video) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(video['url']!)!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Color(0xFF2A2E3D),
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(video['thumbnail']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.amber,
                    onReady: () {
                      // Une fois que le player est prêt, l'image est retirée
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              video['title']!,
              style: TextStyle(
                color: Colors.amber,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              video['description']!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Icon(Icons.thumb_up, color: Colors.grey),
                SizedBox(width: 10.0),
                Icon(Icons.thumb_down, color: Colors.grey),
                SizedBox(width: 10.0),
                Icon(Icons.share, color: Colors.grey),
                SizedBox(width: 10.0),
                Icon(Icons.download, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
