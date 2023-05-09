import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheImage extends StatefulWidget {
  const CacheImage({Key? key}) : super(key: key);

  @override
  State<CacheImage> createState() => _CacheImageState();
}

class _CacheImageState extends State<CacheImage> {
  final imageUrl =
      'https://www.metoffice.gov.uk/binaries/content/gallery/metofficegovuk/hero-images/advice/maps-satellite-images/satellite-image-of-globe.jpg';
  final List<String> imageList = [
    'https://cdn.ttgtmedia.com/rms/onlineimages/what_is_a_blog_used_for-f_mobile.png',
    'https://cdn.shopify.com/s/files/1/0070/7032/files/how-to-start-a-blog-illustration.png?format=jpg&quality=90&v=1595363254',
    'https://contenthub-static.grammarly.com/blog/wp-content/uploads/2017/11/how-to-write-a-blog-post.jpeg',
    'https://www.hostinger.com/tutorials/wp-content/uploads/sites/2/2022/03/what-is-a-blog-1.png',
    'https://www.searchenginejournal.com/wp-content/uploads/2020/08/7-ways-a-blog-can-help-your-business-right-now-5f3c06b9eb24e-1280x720.png',
    'https://images04.nicepage.com/feature/583347/ru/blog-category.jpg',
    'https://img.freepik.com/free-vector/blogging-fun-content-creation-online-streaming-video-blog-young-girl-making-selfie-for-social-network-sharing-feedback-self-promotion-strategy-vector-isolated-concept-metaphor-illustration_335657-855.jpg?w=2000',
    'https://www.thebalancemoney.com/thmb/PMAdMHDen5SHoS12Ol54ERLGZuQ=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/blogging-what-is-it-1794405-v2-5b60d316c9e77c0050f7eb9e.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CACHED NETWORK IMAGE'),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  _deleteCachedImage();
                  setState(() {});
                },
                child: const Text('Reload')),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    progressIndicatorBuilder: (context, url, progress) {
                      if (progress.progress != null) {
                        final percent = progress.progress! * 100;
                        return Center(child: Text('$percent% READY'));
                      }
                      return const Center(child: Text(' READY'));
                    },
                    imageUrl: imageList[index],
                    // placeholder: (context, url) =>
                    //     const CircularProgressIndicator(),
                    cacheManager: CacheManager(
                      Config(
                        'customCacheKey',
                        stalePeriod: const Duration(days: 7),
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      size: 100,
                      color: Colors.red,
                    ),
                    imageBuilder: (context, imageProvider) => Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 1, color: Colors.deepOrange),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: 5,
                  color: Colors.green,
                ),
                itemCount: imageList.length,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _deleteCachedImage() {
    CachedNetworkImage.evictFromCache(imageUrl);
  }
}
