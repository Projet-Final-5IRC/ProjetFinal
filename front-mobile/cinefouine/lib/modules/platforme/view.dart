import 'package:auto_route/auto_route.dart';
import 'package:cinefouine/modules/detailsMovie/view.dart';
import 'package:cinefouine/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class PlatformeView extends ConsumerWidget {
  const PlatformeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final platformes = ref.watch(platformeForMovieProvider);

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: AppColors.secondary,
      body: platformes!.isEmpty
          ? const Center(
              child: Text(
                "Aucune plateforme trouvée.",
                style: TextStyle(color: AppColors.white),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: platformes.length,
              itemBuilder: (context, index) {
                final platforme = platformes[index];
                return Card(
                  color: AppColors.primary,
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: ListTile(
                    leading: Image.network(
                      'https://image.tmdb.org/t/p/w500${platforme.logoPath}',
                      width: 40,
                      height: 40,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error, color: AppColors.white);
                      },
                    ),
                    title: Text(
                      platforme.providerName,
                      style: const TextStyle(color: AppColors.white),
                    ),
                    subtitle: Text(
                      platforme.tmdbLink,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    trailing: IconButton(
                        icon: const Icon(Icons.open_in_browser,
                            color: AppColors.white),
                        onPressed: () async {
                          final url = Uri.parse(platforme.tmdbLink);
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url,
                                mode: LaunchMode.externalApplication);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      "Impossible d'ouvrir le lien : ${platforme.tmdbLink}")),
                            );
                          }
                        }),
                  ),
                );
              },
            ),
    );
  }
}
