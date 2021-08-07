import 'package:flutter/material.dart';
import 'package:flutter_hands_on/models/product.dart';

class ProductDetail extends StatelessWidget {
  // 画面を遷移するために必要なwidgetの名前を定義する
  static const routeName = '/productDetail';

  @override
  Widget build(BuildContext context) {
    // 画面遷移する際に渡した引数が格納されている
    // この引数はObject型として扱われるので、明示的にProduct型を指定する必要がある
    final Product product = ModalRoute.of(context).settings.arguments;

    // 新しい画面を表示するためにscaffoldでウィジェットを渡す
    return Scaffold(
      appBar: AppBar(
        title: Text("商品詳細"),
        ),
        body: _body(context, product),
      );
  }

  Widget _body(BuildContext context, Product product) {
    // SingleChildScrollViewは、childウィジェットが画面に収まりきらない時にスクロール表示できるようにするもの
    return SingleChildScrollView(
      // Columnは下にどんどん伸びていくので、scrollとの相性がいい
      child: Column(
        children: <Widget>[
          Center(
            child: Image.network(product.sampleImageUrl),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
            product.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(product.item.humanizeName),
          Text('${product.price.toString()}円'),
          Text('作った人: ${product.material.user.name}'),
          // product.material.descriptionは商品の説明
          // 空っぽであることもあるので、三項演算子で出すウィジェットを変える
          // String.isEmptyは空文字の時trueを返す
          product.material.description.isEmpty
          ? Container()
          : _descriotionSection(context, product),
        ],
        ),
    );
  }

  Widget _descriotionSection(context, product) {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      child: Column(
        children: <Widget>[
          Text(
            'このアイテムについて',
            style: TextStyle(
              color: Colors.grey,
              ),
          ),
          Container(
            margin: EdgeInsets.all(16.0),
            child: Text(product.material.description),
          ),
        ],
        )
    );

  }
}