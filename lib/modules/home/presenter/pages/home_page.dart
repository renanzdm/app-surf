import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_app/infrastructure/dependecy_injection/service_locator.dart';
import 'package:surf_app/modules/auth/auth_page.dart';
import 'package:surf_app/modules/home/presenter/cubit/home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeController = getIt.get<HomeController>();
  final snackBar = SnackBar(
    content: Text('Opps...ocorreu um erro realize o login novamente'),
    backgroundColor: Colors.red,
  );
  late FloatingSearchBarController controller;

  @override
  void initState() {
    homeController.getUserInfo();
    controller = FloatingSearchBarController();
    homeController.filteredSearchHistory =
        homeController.filterSearchTerms(filter: null);

    WidgetsBinding.instance?.addPostFrameCallback(
      (timeStamp) {
        homeController.state.addListener(() {
          if (homeController.state.value == HomeState.error) {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Future.delayed(const Duration(milliseconds: 4500), () async {
              SharedPreferences _prefs = await SharedPreferences.getInstance();
              _prefs.clear();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => AuthPage()),
                (route) => false,
              );
            });
          }
        });
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // This is handled by the search bar itself.
        resizeToAvoidBottomInset: false,
        body: ValueListenableBuilder<HomeState>(
            valueListenable: homeController.state, builder: (_,value,child){
          if (value == HomeState.error) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.red),
              ),
            );
          } else if (value == HomeState.success) {
            return _buildHomeScreen();
          } else if (value == HomeState.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SizedBox.shrink();
          }
        }),
      ),
    );
  }

  Widget _buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      controller: controller,
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      closeOnBackdropTap: false,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 700),
      onQueryChanged: (query) {
        setState(() {
          homeController.filteredSearchHistory = homeController.filterSearchTerms(filter: query);
        });
      },
      onSubmitted: (query) {
        setState(() {
          homeController.addSearchTerm(query);
          homeController.selectedTerm = query;
        });
        controller.close();
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4,
            child: Builder(
              builder: (context) {
                if (homeController.filteredSearchHistory!.isEmpty &&
                    controller.query.isEmpty) {
                  return Container(
                    height: 56,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      'Start searching',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  );
                } else if (homeController.filteredSearchHistory!.isEmpty) {
                  return ListTile(
                    title: Text(controller.query),
                    leading: const Icon(Icons.search),
                    onTap: () {
                      setState(() {
                        homeController.addSearchTerm(controller.query);
                        homeController.selectedTerm = controller.query;
                      });
                      controller.close();
                    },
                  );
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: homeController.filteredSearchHistory!
                        .map(
                          (term) => ListTile(
                            title: Text(
                              term,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            leading: const Icon(Icons.history),
                            trailing: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  homeController.deleteSearchTerm(term);
                                });
                              },
                            ),
                            onTap: () {
                              setState(() {
                                homeController.putSearchTermFirst(term);
                                homeController.selectedTerm = term;
                              });
                              controller.close();
                            },
                          ),
                        )
                        .toList(),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildHomeScreen() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blueAccent, Colors.blue.shade300],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildFloatingSearchBar()),
        ],
      ),
    );
  }
}
