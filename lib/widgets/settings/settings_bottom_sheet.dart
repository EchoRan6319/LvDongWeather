import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Material You 风格的底部弹窗组件
///
/// 遵循 Material 3 设计规范，提供统一的视觉风格和交互体验
class SettingsBottomSheet extends StatelessWidget {
  /// 弹窗标题
  final String title;

  /// 子组件列表
  final List<Widget> children;

  /// 初始高度比例
  final double initialChildSize;

  /// 最小高度比例
  final double minChildSize;

  /// 最大高度比例
  final double maxChildSize;

  /// 是否可展开
  final bool expand;

  /// 底部操作按钮（可选）
  final Widget? bottomAction;

  const SettingsBottomSheet({
    super.key,
    required this.title,
    required this.children,
    this.initialChildSize = 0.5,
    this.minChildSize = 0.3,
    this.maxChildSize = 0.7,
    this.expand = false,
    this.bottomAction,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DraggableScrollableSheet(
      initialChildSize: initialChildSize,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      expand: expand,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 拖动指示器
              _buildHandle(context),
              // 标题
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
              // 内容区域
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  children: children,
                ),
              ),
              // 底部操作按钮
              if (bottomAction != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: bottomAction,
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHandle(BuildContext context) {
    return Center(
      child: Container(
        width: 32,
        height: 4,
        margin: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.outlineVariant,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

/// Material You 风格的选择项组件
class SettingsSelectionItem extends StatelessWidget {
  /// 标题
  final String title;

  /// 副标题（可选）
  final String? subtitle;

  /// 图标
  final IconData icon;

  /// 是否选中
  final bool isSelected;

  /// 点击回调
  final VoidCallback onTap;

  /// 是否启用
  final bool enabled;

  const SettingsSelectionItem({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final backgroundColor = isSelected
        ? colorScheme.secondaryContainer
        : colorScheme.surfaceContainerLow;

    final iconColor = isSelected
        ? colorScheme.onSecondaryContainer
        : enabled
            ? colorScheme.onSurfaceVariant
            : colorScheme.onSurface.withValues(alpha: 0.38);

    final titleColor = isSelected
        ? colorScheme.onSecondaryContainer
        : enabled
            ? colorScheme.onSurface
            : colorScheme.onSurface.withValues(alpha: 0.38);

    final subtitleColor = isSelected
        ? colorScheme.onSecondaryContainer.withValues(alpha: 0.7)
        : enabled
            ? colorScheme.onSurfaceVariant
            : colorScheme.onSurface.withValues(alpha: 0.38);

    final bool hasSubtitle = subtitle != null && subtitle!.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 24,
                  color: iconColor,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: titleColor,
                          height: 1.3,
                        ),
                      ),
                      if (hasSubtitle) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: textTheme.bodySmall?.copyWith(
                            color: subtitleColor,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: colorScheme.onSecondaryContainer,
                  ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(
      delay: Duration(milliseconds: key.hashCode % 5 * 50),
      duration: 200.ms,
    );
  }
}

/// 显示设置底部弹窗的便捷方法
Future<void> showSettingsBottomSheet({
  required BuildContext context,
  required String title,
  required List<Widget> children,
  double initialChildSize = 0.5,
  double minChildSize = 0.3,
  double maxChildSize = 0.7,
  Widget? bottomAction,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => SettingsBottomSheet(
      title: title,
      initialChildSize: initialChildSize,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      bottomAction: bottomAction,
      children: children,
    ),
  );
}
