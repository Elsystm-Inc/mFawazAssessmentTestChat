class DummyDataGenerator {
  DummyDataGenerator() {
    for (int i = 0; i < 4; i++) {
      //   DummyDataHolder.rawCategories.forEach((element) {
      //     categoires.add(
      //       CategoryModel.fromJson(element),
      //     );
      //   });
      //   DummyDataHolder.rawProducts.forEach((element) {
      //     products.add(
      //       ProductModel.fromJson(element),
      //     );
      //   });

      //   DummyDataHolder.rawAddresses.forEach((element) {
      //     addressModel.add(
      //       AddressModel.fromJson(element),
      //     );
      //   });
      // }
      // DummyDataHolder.rawCart["items"].forEach((element) {
      //   cartItems.add(CartItemModel.fromJson(element));
      // });
      // cartModel = CartModel.fromJson(DummyDataHolder.rawCart["pricy"]);
    }
    // static CartModel cartModel;
    // static List<CategoryModel> categoires = [];
    // static List<ProductModel> products = [];
    // static List<CartItemModel> cartItems = [];
    // static List<AddressModel> addressModel = [];
  }
}

//Class that hold JSON data that will parsed by the corspoinding Model by the DummyDataGenerator
//DummyDataGenerator will be called in each screen that needs it as an object.
class _DummyDataHolder {
  // ignore: unused_field
  static const orgDataModel = const {
    "id": 1,
    "name": "المدرسة الالمانيه بالمنيا - لغات",
    "org_type": "مدرسة, المنيا",
    "address": "Educational compound - industrial zone - minya",
    "phone": "01151730000",
    "website": "www.al-almanya.com",
    "employee_count": "65-150",
    "last_edit": 1602265881,
    "verified": true,
    "cover": "https://elesystm-upload-files.ams3.digitaloceanspaces.com/335/E1C91CB1-F15B-40C7-949E-2823728CCEC5.jpeg",
    "avatar": "https://elesystm-upload-files.ams3.digitaloceanspaces.com/333/AD35DD64-E522-45AE-915A-37ADE3BACB43.jpeg",
  };
}
