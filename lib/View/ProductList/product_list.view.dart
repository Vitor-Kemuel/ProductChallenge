import 'package:brasil_fields/brasil_fields.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:product_challenge/Components/drop_down_button2_custom.components.dart';
import 'package:product_challenge/Components/text_form_fiel_custom.components.dart';
import 'package:product_challenge/Model/product.model.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = <Product>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Product product01 = Product(
      name: "Banana",
      description: "Banana Nanica",
      price: 5.99,
      available: true,
    );

    Product product02 = Product(
      name: "Pera",
      description: "Pera do interior",
      price: 3.59,
      available: false,
    );

    Product product03 = Product(
      name: "Maçã",
      description: "Maçã vermelha",
      price: 7.99,
      available: true,
    );
    setState(() {
      products.add(product01);
      products.add(product02);
      products.add(product03);
    });
  }

  editProduct(Product product, int index) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        TextEditingController name = TextEditingController(text: product.name);
        TextEditingController description =
            TextEditingController(text: product.description);
        TextEditingController price = TextEditingController(
            text: product.price.toString().replaceAll(".", ','));
        final List<String> items = [
          'Disponivel',
          'Indisponivel',
        ];
        String? selectedValue;

        selectedValue = product.available == true ? items[0] : items[1];

        return ListView(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
              child: Column(
                children: [
                  CustomTextField(
                    controller: name,
                    labelText: "Nome",
                    placeholder: "Caixa de Chocolates",
                  ),
                  CustomTextField(
                    controller: description,
                    labelText: "Descrição",
                    placeholder: "Caixa de Chocolates",
                  ),
                  CustomTextField(
                    controller: price,
                    labelText: "Preço",
                    placeholder: "Caixa de Chocolates",
                    prefix: const Text(
                      "R\$ ",
                      style: TextStyle(
                        color: Color.fromARGB(200, 0, 0, 0),
                      ),
                    ),
                    inputType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CentavosInputFormatter(),
                    ],
                  ),
                  CustomDropdownButton(
                    labelText:
                        'Disponivel para venda: $selectedValue',
                    value: selectedValue,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value as String;
                      });
                    },
                    items: items,
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          setState(() {});
                        },
                        child: const Text("Cancelar"),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          products[index].name = name.text;
                          products[index].description = description.text;
                          products[index].price =
                              double.parse(price.text.replaceAll(',', '.'));
                          products[index].available =
                              selectedValue == "Disponivel" ? true : false;

                          Navigator.of(context).pop();
                          setState(() {});
                        },
                        child: const Text("Salvar"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                if (products[products.length - 1].name == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container(
                  margin: EdgeInsets.fromLTRB(50, 30, 50, 20),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 240, 240, 240),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(70, 10, 10, 10),
                          spreadRadius: 3,
                          blurRadius: 3,
                          offset: Offset(0, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    title: Text(products[index].name!),
                    subtitle: Text(products[index].description!),
                    trailing: Text("R\$: ${products[index].price!}"),
                    leading: products[index].available == true
                        ? Icon(Icons.verified)
                        : Icon(Icons.disabled_by_default_outlined),
                    onTap: () {
                      editProduct(products[index], index);
                    },
                  ),
                );
              },
            ),
          ),
          TextButton(
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  TextEditingController name = TextEditingController();
                  TextEditingController description = TextEditingController();
                  TextEditingController price = TextEditingController();
                  final List<String> items = [
                    'Disponivel',
                    'Indisponivel',
                  ];
                  String? selectedValue;

                  return ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                        child: Column(
                          children: [
                            CustomTextField(
                              controller: name,
                              labelText: "Nome",
                              placeholder: "Caixa de Chocolates",
                            ),
                            CustomTextField(
                              controller: description,
                              labelText: "Descrição",
                              placeholder: "Caixa de Chocolates",
                            ),
                            CustomTextField(
                              controller: price,
                              labelText: "Preço",
                              placeholder: "Caixa de Chocolates",
                              prefix: const Text(
                                "R\$ ",
                                style: TextStyle(
                                  color: Color.fromARGB(200, 0, 0, 0),
                                ),
                              ),
                              inputType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CentavosInputFormatter(),
                              ],
                            ),
                            CustomDropdownButton(
                              labelText:
                                  'Disponivel para venda: ${selectedValue ?? "Selecione"}',
                              value: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value as String;
                                });
                              },
                              items: items,
                            ),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    setState(() {});
                                  },
                                  child: const Text("Cancelar"),
                                ),
                                Spacer(),
                                TextButton(
                                  onPressed: () {
                                    products.add(
                                      Product(
                                          name: name.text,
                                          description: description.text,
                                          price: double.parse(
                                              price.text.replaceAll(',', '.')),
                                          available:
                                              selectedValue == "Disponivel"
                                                  ? true
                                                  : false),
                                    );
                                    Navigator.of(context).pop();
                                    setState(() {});
                                  },
                                  child: const Text("Salvar"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: Text("Adicionar produto"),
          ),
        ],
      ),
    );
  }
}
