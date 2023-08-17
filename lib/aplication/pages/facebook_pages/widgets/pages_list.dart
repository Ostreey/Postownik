import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../facebook_pages_provider.dart';
import 'list_elements.dart';

class PagesList extends ConsumerWidget {
  const PagesList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(facebookPagesProvider);

    return asyncValue.when(
      data: (fbPages) {
        return ListView.builder(
            itemCount: fbPages.data.length,
            itemBuilder: (context, index){
              return ListTile(
                title: ListElement(pageProperties: fbPages.data[index],),
                onTap: (){
                  ref.read(saveToSharedPreffsTwoProvider.notifier).execute(fbPages.data[index]);
                },
              );
            }
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => Text('Error: $error'),
    );

  }
}