import 'package:flutter/material.dart';

import '../models/floral_product.dart';

const floralProducts = <FloralProduct>[
  FloralProduct(
    name: 'Rosas de jardín',
    category: 'Rosas',
    price: 38,
    description: 'Doce rosas en tonos rosados, cortadas esta mañana.',
    color: Color(0xFFF6D9D8),
    flower: Icons.filter_vintage_rounded,
  ),
  FloralProduct(
    name: 'Día de peonías',
    category: 'Temporada',
    price: 46,
    description: 'Peonías suaves con follaje fresco de temporada.',
    color: Color(0xFFF3D4E1),
    flower: Icons.local_florist_rounded,
  ),
  FloralProduct(
    name: 'Sol de girasoles',
    category: 'Silvestres',
    price: 32,
    description: 'Girasoles luminosos y verdes aromáticos.',
    color: Color(0xFFF6E6B9),
    flower: Icons.wb_sunny_rounded,
  ),
  FloralProduct(
    name: 'Tulipanes alba',
    category: 'Tulipanes',
    price: 35,
    description: 'Tulipanes elegantes para alegrar cualquier espacio.',
    color: Color(0xFFEBDDF0),
    flower: Icons.spa_rounded,
  ),
  FloralProduct(
    name: 'Jardín silvestre',
    category: 'Silvestres',
    price: 42,
    description: 'Flores de campo combinadas a mano por nuestros floristas.',
    color: Color(0xFFDDE9D7),
    flower: Icons.grass_rounded,
  ),
  FloralProduct(
    name: 'Orquídea calma',
    category: 'Plantas',
    price: 54,
    description: 'Orquídea de interior en maceta artesanal.',
    color: Color(0xFFE5DDEE),
    flower: Icons.local_florist_rounded,
  ),
  FloralProduct(
    name: 'Rosas & eucalipto',
    category: 'Rosas',
    price: 49,
    description: 'Rosas clásicas con hojas frescas de eucalipto.',
    color: Color(0xFFE8D5D1),
    flower: Icons.filter_vintage_rounded,
  ),
  FloralProduct(
    name: 'Tulipanes de abril',
    category: 'Tulipanes',
    price: 39,
    description: 'Una mezcla alegre de tulipanes de colores.',
    color: Color(0xFFF5DFCA),
    flower: Icons.spa_rounded,
  ),
  FloralProduct(
    name: 'Lirios blancos',
    category: 'Temporada',
    price: 44,
    description: 'Lirios perfumados para un detalle inolvidable.',
    color: Color(0xFFE2E8D9),
    flower: Icons.local_florist_rounded,
  ),
  FloralProduct(
    name: 'Mini suculentas',
    category: 'Plantas',
    price: 28,
    description: 'Tres pequeñas suculentas listas para regalar.',
    color: Color(0xFFD9E7DB),
    flower: Icons.eco_rounded,
  ),
];

const productCategories = <String>[
  'Rosas',
  'Tulipanes',
  'Silvestres',
  'Temporada',
  'Plantas',
];
