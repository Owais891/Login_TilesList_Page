import 'package:flutter/material.dart';

import '../models/tile_model.dart';

class DashboardTile extends StatefulWidget {
  const DashboardTile({required this.tile, required this.onTap, super.key});

  final TileModel tile;
  final VoidCallback onTap;

  @override
  State<DashboardTile> createState() => _DashboardTileState();
}

class _DashboardTileState extends State<DashboardTile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final tile = widget.tile;
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 180;
        return AnimatedScale(
          scale: _pressed ? 0.97 : 1,
          duration: const Duration(milliseconds: 120),
          child: Semantics(
            button: true,
            label: '${tile.title}. ${tile.description}',
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              child: InkWell(
                key: ValueKey('tile-${tile.id}'),
                borderRadius: BorderRadius.circular(24),
                onTap: widget.onTap,
                onHighlightChanged: (pressed) =>
                    setState(() => _pressed = pressed),
                child: Container(
                  padding: EdgeInsets.all(compact ? 14 : 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: const Color(0xFFEDF0F6)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x080F1B3D),
                        blurRadius: 16,
                        offset: Offset(0, 7),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: compact ? 42 : 48,
                        height: compact ? 42 : 48,
                        decoration: BoxDecoration(
                          color: tile.color.withValues(alpha: 0.11),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          tile.icon,
                          color: tile.color,
                          size: compact ? 23 : 25,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        tile.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: const Color(0xFF18233D),
                              fontWeight: FontWeight.w700,
                              fontSize: compact ? 14 : null,
                            ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        tile.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF7C8497),
                          height: 1.35,
                          fontSize: compact ? 11 : null,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: tile.color,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
