import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surf_app/infrastructure/dependecy_injection/service_locator.dart';
import 'package:surf_app/modules/auth/auth_page.dart';
import 'package:surf_app/modules/home/presenter/cubit/home_cubit.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeCubit cubit = getIt.get<HomeCubit>();
  final snackBar = SnackBar(
    content: Text('Opps...ocorreu um erro realize o login novamente'),
    backgroundColor: Colors.red,
  );
  late FloatingSearchBarController controller;

  @override
  void initState() {
    cubit.getUserInfo();
    controller = FloatingSearchBarController();
    cubit.filteredSearchHistory = cubit.filterSearchTerms(filter: null);

    WidgetsBinding.instance?.addPostFrameCallback(
      (timeStamp) {
        cubit.stream.listen((state) {
          if (state is HomeErrorState) {
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
    cubit.close();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // This is handled by the search bar itself.
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<HomeCubit, HomeState>(
        bloc: cubit,
        builder: (_, state) {
          if (state is HomeErrorState) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.red),
              ),
            );
          } else if (state is HomeUserLoadedState) {
            return _buildHomeScreen();
          } else if (state is HomeLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SizedBox.shrink();
          }
        },
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
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 700),
      onQueryChanged: (query) {
        setState(() {
          cubit.filteredSearchHistory = cubit.filterSearchTerms(filter: query);
        });
      },
      onSubmitted: (query) {
        setState(() {
          cubit.addSearchTerm(query);
          cubit.selectedTerm = query;
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
                if (cubit.filteredSearchHistory!.isEmpty &&
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
                } else if (cubit.filteredSearchHistory!.isEmpty) {
                  return ListTile(
                    title: Text(controller.query),
                    leading: const Icon(Icons.search),
                    onTap: () {
                      setState(() {
                        cubit.addSearchTerm(controller.query);
                        cubit.selectedTerm = controller.query;
                      });
                      controller.close();
                    },
                  );
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: cubit.filteredSearchHistory!
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
                                  cubit.deleteSearchTerm(term);
                                });
                              },
                            ),
                            onTap: () {
                              setState(() {
                                cubit.putSearchTermFirst(term);
                                cubit.selectedTerm = term;
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
