import 'package:flutter/material.dart';

class CustomColors {
  final Color _activePrimaryButton = const Color(
    0xFF1ABC9C,
  ); // Verde-azulado claro
  final Color _activeSecondaryButton = const Color(
    0xFF16A085,
  ); // Verde mais escuro
  final Color _gradientMainColor = const Color(
    0xFF1ABC9C,
  ); // Começo do gradiente
  // final Color _gradientMidColor = const Color(0xFF14967F); // Novo tom intermediário
  final Color _gradientSecColor = const Color(0xFF16A085); // Fim do gradiente
  final Color _appBarMainColor = const Color(
    0xFF16A085,
  ); // Cor mais escura para a AppBar
  final Color _mainBackgroundColor = const Color(
    0xFFF8F8FF,
  ); // Mantendo o fundo claro

  Color getActivePrimaryButtonColor() {
    return _activePrimaryButton;
  }

  Color getActiveSecondaryButtonColor() {
    return _activeSecondaryButton;
  }

  Color getGradientMainColor() {
    return _gradientMainColor;
  }

  Color getGradientSecColor() {
    return _gradientSecColor;
  }

  Color getAppBarMainColor() {
    return _appBarMainColor;
  }

  Color getMainBackgroundColor() {
    return _mainBackgroundColor;
  }
}
