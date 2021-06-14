import 'package:admin/models/Product.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    @required this.product,
    this.onItemAddToCart,
  }) : super(key: key);

  final Product product;
  final Function(Product, int, int) onItemAddToCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: Color(0xFFF5F6F9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: double.infinity,
                child: Hero(
                  tag: product.id.toString(),
                  child: Image.network(
                    product.images[0],
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Image.asset("assets/images/bottom_img_1.png"),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10).copyWith(top: 10),
            child: Text(
              product.title,
              style: TextStyle(color: Colors.black),
              maxLines: 2,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              product.description,
              style: TextStyle(color: Colors.grey),
              maxLines: 2,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10, left: 10),
            child: Text(
              "₹${product.price}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
          )
        ],
      ),
    );
  }
}
