

import 'package:material_ui/material_ui.dart';
import '../models/producto.dart';

class ProductoCard extends StatelessWidget {
  final Producto producto;
  final VoidCallback onEditar;
  final VoidCallback onEliminar;

  const ProductoCard({
    super.key,
    required this.producto,
    required this.onEditar,
    required this.onEliminar,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      child: ListTile(
        leading: const Icon(
          Icons.inventory_2_outlined,
          size: 32,
        ),
        title: Text(
          producto.nombre,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              producto.descripcion?.trim().isNotEmpty == true
                  ? producto.descripcion!
                  : 'Sin descripción',
            ),
            Text(
              'Precio: \$${producto.precio.toStringAsFixed(2)}',
            ),
            Text('Cantidad: ${producto.cantidad}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              tooltip: 'Editar producto',
              onPressed: onEditar,
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              color: Colors.red,
              tooltip: 'Eliminar producto',
              onPressed: onEliminar,
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}