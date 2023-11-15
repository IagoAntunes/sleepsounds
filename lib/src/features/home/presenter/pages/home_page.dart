import 'package:flutter/material.dart';
import 'package:sleepsounds/src/features/home/data/home_datasource.dart';
import 'package:sleepsounds/src/features/home/domain/home_repository.dart';
import 'package:sleepsounds/src/features/home/presenter/controllers/home_controller.dart';
import 'package:sleepsounds/src/features/home/presenter/state/home_state.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController homeController = HomeController(
    repository: HomeRepository(
      datasource: HomeDatasource(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sleep",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ValueListenableBuilder(
                valueListenable: homeController.state,
                builder: (context, value, child) {
                  return Expanded(
                    child: Column(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: homeController.selectedIndex,
                          builder: (context, value, child) {
                            return SizedBox(
                              height: 100,
                              child: ListView.separated(
                                itemCount: homeController.listMenus.length,
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  width: 16,
                                ),
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () {
                                    homeController.changeMenuIndex(index);
                                  },
                                  child: Chip(
                                    side: homeController.selectedIndex.value ==
                                            index
                                        ? BorderSide.none
                                        : null,
                                    backgroundColor:
                                        homeController.selectedIndex.value ==
                                                index
                                            ? Theme.of(context)
                                                .colorScheme
                                                .onSecondary
                                            : null,
                                    label: Text(
                                      homeController.listMenus[index],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        switch (homeController.state.value) {
                          SuccessHomeState() => Expanded(
                              child: GridView.builder(
                                itemCount: (homeController.state.value
                                        as SuccessHomeState)
                                    .listCategories
                                    .length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16.0,
                                  mainAxisSpacing: 8,
                                ),
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () {
                                    //
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.network(
                                          'https://www.zup.com.br/wp-content/uploads/2021/03/5ce2fde702ef93c1e994d987_flutter.png',
                                        ),
                                      ),
                                      Text(
                                        (homeController.state.value
                                                as SuccessHomeState)
                                            .listCategories[index]
                                            .name,
                                        style: const TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "${(homeController.state.value as SuccessHomeState).listCategories[index].sounds.length} Songs - ${(homeController.state.value as SuccessHomeState).listCategories[index].category}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          FailureHomeState() => const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                  size: 48,
                                ),
                                Text(
                                  "Erro Inesperado!",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          LoadingHomeState() =>
                            const CircularProgressIndicator(),
                          _ => Container(),
                        }
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
