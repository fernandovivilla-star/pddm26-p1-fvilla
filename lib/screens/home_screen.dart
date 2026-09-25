import 'package:flutter/material.dart';

import '../data/products.dart';
import '../models/floral_product.dart';
import '../theme/app_theme.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String? _selectedCategory;
  String _searchQuery = '';
  final Set<String> _favoriteNames = {};

  void _toggleFavorite(FloralProduct product) {
    final wasFavorite = _favoriteNames.contains(product.name);
    setState(() {
      wasFavorite
          ? _favoriteNames.remove(product.name)
          : _favoriteNames.add(product.name);
    });
    _showMessage(
      wasFavorite ? 'Eliminado de tus favoritos' : 'Añadido a tus favoritos',
    );
  }

  void _addToBag(FloralProduct product) {
    _showMessage('${product.name} se añadió a tu bolsa');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _StorefrontPage(
        favoriteNames: _favoriteNames,
        selectedCategory: _selectedCategory,
        searchQuery: _searchQuery,
        onSearchChanged: (value) => setState(() => _searchQuery = value),
        onCategorySelected: (category) =>
            setState(() => _selectedCategory = category),
        onFavorite: _toggleFavorite,
        onAdd: _addToBag,
        onBrowseCategories: () => setState(() => _selectedIndex = 1),
      ),
      _CategoriesPage(
        favoriteNames: _favoriteNames,
        onFavorite: _toggleFavorite,
        onAdd: _addToBag,
        onCategorySelected: (category) {
          setState(() {
            _selectedCategory = category;
            _selectedIndex = 0;
          });
        },
      ),
      _FavoritesPage(
        favorites: floralProducts
            .where((product) => _favoriteNames.contains(product.name))
            .toList(),
        favoriteNames: _favoriteNames,
        onFavorite: _toggleFavorite,
        onAdd: _addToBag,
      ),
      const _ProfilePage(),
    ];

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _selectedIndex, children: pages),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        backgroundColor: Colors.white,
        selectedItemColor: AppTheme.forest,
        unselectedItemColor: const Color(0xFF766F6A),
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 11,
        ),
        unselectedLabelStyle: const TextStyle(fontSize: 11),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Categorías',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

class _StorefrontPage extends StatelessWidget {
  const _StorefrontPage({
    required this.favoriteNames,
    required this.selectedCategory,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.onCategorySelected,
    required this.onFavorite,
    required this.onAdd,
    required this.onBrowseCategories,
  });

  final Set<String> favoriteNames;
  final String? selectedCategory;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String?> onCategorySelected;
  final ValueChanged<FloralProduct> onFavorite;
  final ValueChanged<FloralProduct> onAdd;
  final VoidCallback onBrowseCategories;

  @override
  Widget build(BuildContext context) {
    final products = floralProducts.where((product) {
      final matchesCategory =
          selectedCategory == null || product.category == selectedCategory;
      final matchesSearch = product.name.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      return matchesCategory && matchesSearch;
    }).toList();

    return CustomScrollView(
      key: const ValueKey('home-scroll'),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                Container(
                  height: 46,
                  width: 46,
                  decoration: BoxDecoration(
                    color: AppTheme.forest,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.local_florist_rounded,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hola, qué gusto verte',
                        style: TextStyle(color: Colors.black54, fontSize: 12),
                      ),
                      Text(
                        'Bienvenida a Lion Flowers',
                        style: TextStyle(
                          color: AppTheme.forest,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onBrowseCategories,
                  tooltip: 'Explorar categorías',
                  icon: const Icon(Icons.tune_rounded, color: AppTheme.forest),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
          sliver: SliverToBoxAdapter(
            child: TextField(
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Busca tus flores favoritas',
                prefixIcon: const Icon(Icons.search_rounded),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 13),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFEDE6E0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFEDE6E0)),
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
          sliver: SliverToBoxAdapter(child: _SeasonBanner()),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Encuentra tu estilo',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.forest,
                    ),
                  ),
                ),
                if (selectedCategory != null)
                  TextButton(
                    onPressed: () => onCategorySelected(null),
                    child: const Text('Ver todo'),
                  ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 42,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              children: [
                _CategoryChip(
                  label: 'Todo',
                  selected: selectedCategory == null,
                  onTap: () => onCategorySelected(null),
                ),
                for (final category in productCategories)
                  _CategoryChip(
                    label: category,
                    selected: selectedCategory == category,
                    onTap: () => onCategorySelected(category),
                  ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
          sliver: SliverToBoxAdapter(
            child: Text(
              selectedCategory == null
                  ? 'Arreglos para alegrar tu día'
                  : selectedCategory!,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: AppTheme.forest,
              ),
            ),
          ),
        ),
        if (products.isEmpty)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text('No encontramos arreglos con esa búsqueda.'),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
            sliver: SliverGrid.builder(
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 230,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.73,
              ),
              itemBuilder: (context, index) => ProductCard(
                product: products[index],
                isFavorite: favoriteNames.contains(products[index].name),
                onFavorite: () => onFavorite(products[index]),
                onAdd: () => onAdd(products[index]),
              ),
            ),
          ),
      ],
    );
  }
}

class _SeasonBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF2E2D6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'UN DETALLE, MUCHAS SONRISAS',
                  style: TextStyle(
                    color: AppTheme.rose,
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'Flores frescas\nhechas para ti',
                  style: TextStyle(
                    color: AppTheme.forest,
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Georgia',
                    height: 1.2,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'Con cariño, desde nuestra tienda local',
                  style: TextStyle(color: AppTheme.forest, fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 82,
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8F0),
              borderRadius: BorderRadius.circular(42),
            ),
            child: const Icon(
              Icons.local_florist_rounded,
              size: 48,
              color: AppTheme.rose,
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        labelStyle: TextStyle(
          color: selected ? Colors.white : AppTheme.forest,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        selectedColor: AppTheme.forest,
        backgroundColor: Colors.white,
        side: BorderSide(
          color: selected ? AppTheme.forest : const Color(0xFFEDE6E0),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        showCheckmark: false,
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}

class _CategoriesPage extends StatelessWidget {
  const _CategoriesPage({
    required this.favoriteNames,
    required this.onFavorite,
    required this.onAdd,
    required this.onCategorySelected,
  });

  final Set<String> favoriteNames;
  final ValueChanged<FloralProduct> onFavorite;
  final ValueChanged<FloralProduct> onAdd;
  final ValueChanged<String> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverPadding(
          padding: EdgeInsets.fromLTRB(20, 24, 20, 8),
          sliver: SliverToBoxAdapter(
            child: Text(
              'Categorías',
              style: TextStyle(
                color: AppTheme.forest,
                fontSize: 27,
                fontWeight: FontWeight.w700,
                fontFamily: 'Georgia',
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          sliver: SliverList.builder(
            itemCount: productCategories.length,
            itemBuilder: (context, index) {
              final category = productCategories[index];
              final count = floralProducts
                  .where((product) => product.category == category)
                  .length;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFF2E2D6),
                    child: Icon(
                      Icons.local_florist_rounded,
                      color: AppTheme.rose,
                    ),
                  ),
                  title: Text(
                    category,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppTheme.forest,
                    ),
                  ),
                  subtitle: Text('$count arreglos disponibles'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => onCategorySelected(category),
                ),
              );
            },
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
          sliver: SliverGrid.builder(
            itemCount: floralProducts.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 230,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 0.73,
            ),
            itemBuilder: (context, index) => ProductCard(
              product: floralProducts[index],
              isFavorite: favoriteNames.contains(floralProducts[index].name),
              onFavorite: () => onFavorite(floralProducts[index]),
              onAdd: () => onAdd(floralProducts[index]),
            ),
          ),
        ),
      ],
    );
  }
}

class _FavoritesPage extends StatelessWidget {
  const _FavoritesPage({
    required this.favorites,
    required this.favoriteNames,
    required this.onFavorite,
    required this.onAdd,
  });

  final List<FloralProduct> favorites;
  final Set<String> favoriteNames;
  final ValueChanged<FloralProduct> onFavorite;
  final ValueChanged<FloralProduct> onAdd;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverPadding(
          padding: EdgeInsets.fromLTRB(20, 24, 20, 18),
          sliver: SliverToBoxAdapter(
            child: Text(
              'Tus favoritos',
              style: TextStyle(
                color: AppTheme.forest,
                fontSize: 27,
                fontWeight: FontWeight.w700,
                fontFamily: 'Georgia',
              ),
            ),
          ),
        ),
        if (favorites.isEmpty)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.favorite_border, size: 54, color: AppTheme.rose),
                    SizedBox(height: 14),
                    Text(
                      'Aquí guardaremos las flores que te encantan.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppTheme.forest, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
            sliver: SliverGrid.builder(
              itemCount: favorites.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 230,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.73,
              ),
              itemBuilder: (context, index) => ProductCard(
                product: favorites[index],
                isFavorite: favoriteNames.contains(favorites[index].name),
                onFavorite: () => onFavorite(favorites[index]),
                onAdd: () => onAdd(favorites[index]),
              ),
            ),
          ),
      ],
    );
  }
}

class _ProfilePage extends StatelessWidget {
  const _ProfilePage();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [
        SizedBox(height: 8),
        Text(
          'Tu perfil',
          style: TextStyle(
            color: AppTheme.forest,
            fontSize: 27,
            fontWeight: FontWeight.w700,
            fontFamily: 'Georgia',
          ),
        ),
        SizedBox(height: 24),
        CircleAvatar(
          radius: 38,
          backgroundColor: Color(0xFFF2E2D6),
          child: Icon(Icons.person_rounded, size: 42, color: AppTheme.forest),
        ),
        SizedBox(height: 12),
        Text(
          'Amante de las flores',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppTheme.forest,
            fontWeight: FontWeight.w700,
            fontSize: 17,
          ),
        ),
        SizedBox(height: 24),
        ListTile(
          leading: Icon(Icons.local_shipping_outlined, color: AppTheme.forest),
          title: Text('Mis pedidos'),
          trailing: Icon(Icons.chevron_right_rounded),
        ),
        Divider(height: 1),
        ListTile(
          leading: Icon(Icons.location_on_outlined, color: AppTheme.forest),
          title: Text('Direcciones'),
          trailing: Icon(Icons.chevron_right_rounded),
        ),
        Divider(height: 1),
        ListTile(
          leading: Icon(Icons.help_outline_rounded, color: AppTheme.forest),
          title: Text('Ayuda y contacto'),
          trailing: Icon(Icons.chevron_right_rounded),
        ),
      ],
    );
  }
}
