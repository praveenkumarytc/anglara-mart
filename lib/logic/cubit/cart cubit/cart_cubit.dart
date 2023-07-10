import 'package:bloc/bloc.dart';
import 'package:ecommerce/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../../../custom widgets/custom_snackbar.dart';
import '../../../data/model/cart_product_model.dart';
import '../../../data/model/product_model.dart';
import 'cart_state.dart';

// Cubit
class CartCubit extends Cubit<CartState> {
  List<CartProductModel> _cartItems = [];
  double _totalCartValue = 0.0;
  late Box<CartProductModel> _cartBox;

  CartCubit() : super(CartInitial()) {
    _initHive();
  }

  Future<void> _initHive() async {
    final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    Hive.registerAdapter(CartProductModelAdapter());
    Hive.registerAdapter(RatingAdapter());

    _cartBox = await Hive.openBox<CartProductModel>('cart_box');
    _loadCartData();
  }

  Future<void> _loadCartData() async {
    final cartData = _cartBox.values.toList();
    _cartItems = List<CartProductModel>.from(cartData);
    _calculateTotalCartValue();

    if (_cartItems.isEmpty) {
      await _cartBox.clear();
    }

    debugPrint('$_cartItems');

    emit(CartLoaded(_cartItems, _totalCartValue));
  }

  void _calculateTotalCartValue() {
    _totalCartValue = _cartItems.fold(0.0, (sum, cartProduct) => sum + (cartProduct.price! * cartProduct.quantity));
  }

  Future<void> addToCart(CartProductModel cartProduct) async {
    final existingIndex = _cartItems.indexWhere((item) => item.id == cartProduct.id);
    if (existingIndex != -1) {
      final existingProduct = _cartItems[existingIndex];
      final updatedProduct = existingProduct.copyWith(quantity: existingProduct.quantity + cartProduct.quantity);
      _cartItems[existingIndex] = updatedProduct;
      await _cartBox.putAt(existingIndex, updatedProduct);
      showCustomSnackBar('Quantity Increased', navigatorKey.currentContext!);
    } else {
      _cartItems.add(cartProduct);
      await _cartBox.add(cartProduct);
      showCustomSnackBar('Item Added to cart', navigatorKey.currentContext!);
    }

    _calculateTotalCartValue();
    emit(CartLoaded(_cartItems, _totalCartValue));
  }

  Future<void> removeFromCart(int productId) async {
    final indexToRemove = _cartItems.indexWhere((item) => item.id == productId);
    if (indexToRemove != -1) {
      _cartItems.removeAt(indexToRemove);
      await _cartBox.put('cart_items', _cartItems[indexToRemove]);

      _calculateTotalCartValue();
      emit(CartLoaded(_cartItems, _totalCartValue));
    }
  }

  Future<void> updateQuantity(int productId, double quantity) async {
    final cartItemIndex = _cartItems.indexWhere((item) => item.id == productId);
    if (cartItemIndex != -1) {
      _cartItems[cartItemIndex] = _cartItems[cartItemIndex].copyWith(quantity: quantity);
      await _cartBox.putAt(cartItemIndex, _cartItems[cartItemIndex]);
      _calculateTotalCartValue();
      emit(CartLoaded(_cartItems, _totalCartValue));
    }
  }
}

// Adapters
class CartProductModelAdapter extends TypeAdapter<CartProductModel> {
  @override
  final int typeId = 0;

  @override
  CartProductModel read(BinaryReader reader) {
    return CartProductModel(
      quantity: reader.readDouble(),
      id: reader.readInt(),
      title: reader.readString(),
      price: reader.readDouble(),
      description: reader.readString(),
      category: reader.readString(),
      image: reader.readString(),
      rating: reader.read() as Rating?,
    );
  }

  @override
  void write(BinaryWriter writer, CartProductModel obj) {
    writer.writeDouble(obj.quantity);
    writer.writeInt(obj.id ?? 0);
    writer.writeString(obj.title ?? '');
    writer.writeDouble(obj.price ?? 0.0);
    writer.writeString(obj.description ?? '');
    writer.writeString(obj.category ?? '');
    writer.writeString(obj.image ?? '');
    writer.write(obj.rating);
  }
}

class RatingAdapter extends TypeAdapter<Rating> {
  @override
  final int typeId = 1;

  @override
  Rating read(BinaryReader reader) {
    return Rating(
      rate: reader.readDouble(),
      count: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, Rating obj) {
    writer.writeDouble(obj.rate ?? 0);
    writer.writeInt(obj.count ?? 0);
  }
}
