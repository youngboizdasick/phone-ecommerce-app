import 'package:flutter/material.dart';

import 'smartphone.dart';

class Store {
  final List<SmartPhone> _smartPhones = [
    // iPhone Series

    // iPhone 14
    SmartPhone(
      price: 25567000,
      imagePATH: './assets/images/iPhone/14_black.png',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque semper arcu ligula, id accumsan tellus pellentesque et. In sollicitudin tincidunt.',
      rating: 4.8,
      name: 'iPhone 14',
      category: SmartPhoneCategory.iPhone,
      model: 'iPhone 14',
      modelColors: [
        ModelColor(
          imagePATH: './assets/images/iPhone/14_black.png',
          color: Colors.black,
          name: 'Màu Đen',
          additionalPrice: 0,
        ),
        ModelColor(
          imagePATH: './assets/images/iPhone/14_blue.png',
          color: Colors.blue.shade200,
          name: 'Màu Xanh Dương',
          additionalPrice: 1000000,
        ),
        ModelColor(
          imagePATH: './assets/images/iPhone/14_purple.png',
          color: Colors.purple.shade200,
          name: 'Màu Tím',
          additionalPrice: 0,
        ),
        ModelColor(
          imagePATH: './assets/images/iPhone/14_red.png',
          color: Colors.red,
          name: 'Màu Đỏ',
          additionalPrice: 0,
        ),
        ModelColor(
          imagePATH: './assets/images/iPhone/14_white.png',
          color: Colors.white,
          name: 'Màu Trắng',
          additionalPrice: 500000,
        ),
        ModelColor(
          imagePATH: './assets/images/iPhone/14_yellow.png',
          color: Colors.yellow,
          name: 'Màu Vàng',
          additionalPrice: 500000,
        ),
      ],
      modelMemories: [
        ModelMemory(memory: 128, additionalPrice: 0),
        ModelMemory(memory: 256, additionalPrice: 5000000),
        ModelMemory(memory: 512, additionalPrice: 10000000),
        ModelMemory(memory: 1, additionalPrice: 15000000),
      ],
      warehouses: [
        '18/25 Nguyễn Đình Chiểu,P.Đa Kao, Quận 1',
        '48/14 Đặng Dung, P.Tân Định, Quận 1',
        '314/38 Lê Văn Quới, P.Bình Hưng Hòa A, Q.Bình Tân',
        '156/11 Lê Thị Hồng, P.Phước Long A, Q.Thủ Đức',
        '67/42 Trần Hưng Đạo, P.Phường Nguyễn Cư Trinh, Quận 1',
        '280/44 Vạn Kiếp, Phường 3, Q.Bình Thạnh',
        '30/28 Nguyễn Bỉnh Khiêm, P.Bến Nghé, Quận 1',
        '102/12 Huỳnh Văn Bánh, Phường 15, Q.Phú Nhuận',
        '53/18A Trần Quốc Toản, Phường 8, Quận 3',
        '140/56 Nguyễn Duy Trinh, P.Bình Trưng Tây, Q.Thủ Đức',
      ],
    ),

    // iPhone 14 Pro Max
    SmartPhone(
      price: 28567000,
      imagePATH: './assets/images/iPhone/14_promax_black.png',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque semper arcu ligula, id accumsan tellus pellentesque et. In sollicitudin tincidunt.',
      rating: 5.0,
      name: 'iPhone 14 Pro Max',
      category: SmartPhoneCategory.iPhone,
      model: 'iPhone 14',
      modelColors: [
        ModelColor(
          imagePATH: './assets/images/iPhone/14_promax_black.png',
          color: Colors.black,
          name: 'Màu Đen',
          additionalPrice: 0,
        ),
        ModelColor(
          imagePATH: './assets/images/iPhone/14_promax_purple.png',
          color: Colors.purple.shade200,
          name: 'Màu Tím',
          additionalPrice: 0,
        ),
        ModelColor(
          imagePATH: './assets/images/iPhone/14_promax_white.png',
          color: Colors.white,
          name: 'Màu Trắng',
          additionalPrice: 500000,
        ),
        ModelColor(
          imagePATH: './assets/images/iPhone/14_promax_yellow.png',
          color: Colors.yellow,
          name: 'Màu Vàng',
          additionalPrice: 500000,
        ),
      ],
      modelMemories: [
        ModelMemory(memory: 128, additionalPrice: 0),
        ModelMemory(memory: 256, additionalPrice: 5000000),
        ModelMemory(memory: 512, additionalPrice: 10000000),
        ModelMemory(memory: 1, additionalPrice: 15000000),
      ],
      warehouses: [
        '18/25 Nguyễn Đình Chiểu,P.Đa Kao, Quận 1',
        '48/14 Đặng Dung, P.Tân Định, Quận 1',
        '314/38 Lê Văn Quới, P.Bình Hưng Hòa A, Q.Bình Tân',
        '156/11 Lê Thị Hồng, P.Phước Long A, Q.Thủ Đức',
        '67/42 Trần Hưng Đạo, P.Phường Nguyễn Cư Trinh, Quận 1',
        '280/44 Vạn Kiếp, Phường 3, Q.Bình Thạnh',
        '30/28 Nguyễn Bỉnh Khiêm, P.Bến Nghé, Quận 1',
        '102/12 Huỳnh Văn Bánh, Phường 15, Q.Phú Nhuận',
        '53/18A Trần Quốc Toản, Phường 8, Quận 3',
        '140/56 Nguyễn Duy Trinh, P.Bình Trưng Tây, Q.Thủ Đức',
      ],
    ),

    // iPhone 15
    SmartPhone(
      price: 25567000,
      imagePATH: './assets/images/iPhone/15_black.png',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque semper arcu ligula, id accumsan tellus pellentesque et. In sollicitudin tincidunt.',
      rating: 4.8,
      name: 'iPhone 15',
      category: SmartPhoneCategory.iPhone,
      model: 'iPhone 15',
      modelColors: [
        ModelColor(
          imagePATH: './assets/images/iPhone/15_black.png',
          color: Colors.black,
          name: 'Màu Đen',
          additionalPrice: 0,
        ),
        ModelColor(
          imagePATH: './assets/images/iPhone/15_blue.png',
          color: Colors.blue.shade200,
          name: 'Màu Xanh Dương',
          additionalPrice: 1000000,
        ),
        ModelColor(
          imagePATH: './assets/images/iPhone/15_yellow.png',
          color: Colors.yellow,
          name: 'Màu Vàng',
          additionalPrice: 500000,
        ),
        ModelColor(
          imagePATH: './assets/images/iPhone/15_green.png',
          color: Colors.green.shade200,
          name: 'Màu Xanh',
          additionalPrice: 500000,
        ),
        ModelColor(
          imagePATH: './assets/images/iPhone/15_pink.png',
          color: Colors.pink.shade200,
          name: 'Màu Hồng',
          additionalPrice: 1000000,
        ),
      ],
      modelMemories: [
        ModelMemory(memory: 256, additionalPrice: 0),
        ModelMemory(memory: 512, additionalPrice: 10000000),
        ModelMemory(memory: 1, additionalPrice: 15000000),
      ],
      warehouses: [
        '18/25 Nguyễn Đình Chiểu,P.Đa Kao, Quận 1',
        '48/14 Đặng Dung, P.Tân Định, Quận 1',
        '314/38 Lê Văn Quới, P.Bình Hưng Hòa A, Q.Bình Tân',
        '156/11 Lê Thị Hồng, P.Phước Long A, Q.Thủ Đức',
        '67/42 Trần Hưng Đạo, P.Phường Nguyễn Cư Trinh, Quận 1',
        '280/44 Vạn Kiếp, Phường 3, Q.Bình Thạnh',
        '30/28 Nguyễn Bỉnh Khiêm, P.Bến Nghé, Quận 1',
        '102/12 Huỳnh Văn Bánh, Phường 15, Q.Phú Nhuận',
        '53/18A Trần Quốc Toản, Phường 8, Quận 3',
        '140/56 Nguyễn Duy Trinh, P.Bình Trưng Tây, Q.Thủ Đức',
      ],
    ),

    // iPhone 15 Pro Max
    SmartPhone(
      price: 32567000,
      imagePATH: './assets/images/iPhone/15_promax_black.png',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque semper arcu ligula, id accumsan tellus pellentesque et. In sollicitudin tincidunt.',
      rating: 5.0,
      name: 'iPhone 15 Pro Max',
      category: SmartPhoneCategory.iPhone,
      model: 'iPhone 15',
      modelColors: [
        ModelColor(
          imagePATH: './assets/images/iPhone/15_promax_black.png',
          color: Colors.black,
          name: 'Màu Đen',
          additionalPrice: 0,
        ),
        ModelColor(
          imagePATH: './assets/images/iPhone/15_promax_grey.png',
          color: Colors.grey,
          name: 'Màu Xám',
          additionalPrice: 500000,
        ),
        ModelColor(
          imagePATH: './assets/images/iPhone/15_promax_white.png',
          color: Colors.white,
          name: 'Màu Trắng',
          additionalPrice: 500000,
        ),
        ModelColor(
          imagePATH: './assets/images/iPhone/15_promax_silver.png',
          color: const Color(0xFFC0C0C0),
          name: 'Màu Bạc',
          additionalPrice: 500000,
        ),
      ],
      modelMemories: [
        ModelMemory(memory: 256, additionalPrice: 5000000),
        ModelMemory(memory: 512, additionalPrice: 10000000),
        ModelMemory(memory: 1, additionalPrice: 15000000),
      ],
      warehouses: [
        '18/25 Nguyễn Đình Chiểu,P.Đa Kao, Quận 1',
        '48/14 Đặng Dung, P.Tân Định, Quận 1',
        '314/38 Lê Văn Quới, P.Bình Hưng Hòa A, Q.Bình Tân',
        '156/11 Lê Thị Hồng, P.Phước Long A, Q.Thủ Đức',
        '67/42 Trần Hưng Đạo, P.Phường Nguyễn Cư Trinh, Quận 1',
        '280/44 Vạn Kiếp, Phường 3, Q.Bình Thạnh',
        '30/28 Nguyễn Bỉnh Khiêm, P.Bến Nghé, Quận 1',
        '102/12 Huỳnh Văn Bánh, Phường 15, Q.Phú Nhuận',
        '53/18A Trần Quốc Toản, Phường 8, Quận 3',
        '140/56 Nguyễn Duy Trinh, P.Bình Trưng Tây, Q.Thủ Đức',
      ],
    ),

    // SamSung Products
    SmartPhone(
      price: 29308468,
      imagePATH: './assets/images/samsung/s24_ultra_black.png',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque semper arcu ligula, id accumsan tellus pellentesque et. In sollicitudin tincidunt.',
      rating: 5.0,
      name: 'Samsung Galaxy s24 Ultra',
      category: SmartPhoneCategory.Samsung,
      model: 'S24',
      modelColors: [
        ModelColor(
          imagePATH: './assets/images/samsung/s24_ultra_black.png',
          color: Colors.black,
          name: 'Màu Đen',
          additionalPrice: 0,
        ),
        ModelColor(
          imagePATH: './assets/images/samsung/s24_ultra_grey.png',
          color: Colors.grey,
          name: 'Màu Xám',
          additionalPrice: 500000,
        ),
        ModelColor(
          imagePATH: './assets/images/samsung/s24_ultra_purple.png',
          color: Colors.purple.shade200,
          name: 'Màu Tím',
          additionalPrice: 0,
        ),
        ModelColor(
          imagePATH: './assets/images/samsung/s24_ultra_yellow.png',
          color: Colors.yellow,
          name: 'Màu Vàng',
          additionalPrice: 0,
        ),
      ],
      modelMemories: [
        ModelMemory(memory: 256, additionalPrice: 0),
        ModelMemory(memory: 512, additionalPrice: 5000000),
        ModelMemory(memory: 1, additionalPrice: 10000000),
      ],
      warehouses: [
        '18/25 Nguyễn Đình Chiểu,P.Đa Kao, Quận 1',
        '48/14 Đặng Dung, P.Tân Định, Quận 1',
        '314/38 Lê Văn Quới, P.Bình Hưng Hòa A, Q.Bình Tân',
        '156/11 Lê Thị Hồng, P.Phước Long A, Q.Thủ Đức',
        '67/42 Trần Hưng Đạo, P.Phường Nguyễn Cư Trinh, Quận 1',
        '280/44 Vạn Kiếp, Phường 3, Q.Bình Thạnh',
        '30/28 Nguyễn Bỉnh Khiêm, P.Bến Nghé, Quận 1',
        '102/12 Huỳnh Văn Bánh, Phường 15, Q.Phú Nhuận',
        '53/18A Trần Quốc Toản, Phường 8, Quận 3',
        '140/56 Nguyễn Duy Trinh, P.Bình Trưng Tây, Q.Thủ Đức',
      ],
    ),

    // Oppo Products
    SmartPhone(
      price: 21685036,
      imagePATH: './assets/images/oppo/find_n3_5g_black.png',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque semper arcu ligula, id accumsan tellus pellentesque et. In sollicitudin tincidunt.',
      rating: 4.3,
      name: 'Oppo Find N3 5G',
      category: SmartPhoneCategory.Oppo,
      model: 'Find N3',
      modelColors: [
        ModelColor(
          imagePATH: './assets/images/oppo/find_n3_5g_black.png',
          color: Colors.black,
          name: 'Màu Đen',
          additionalPrice: 0,
        ),
        ModelColor(
          imagePATH: './assets/images/oppo/find_n3_5g_yellow.png',
          color: Colors.yellow,
          name: 'Màu Vàng',
          additionalPrice: 0,
        ),
      ],
      modelMemories: [
        ModelMemory(memory: 256, additionalPrice: 0),
        ModelMemory(memory: 512, additionalPrice: 5000000),
        ModelMemory(memory: 1, additionalPrice: 10000000),
      ],
      warehouses: [
        '18/25 Nguyễn Đình Chiểu,P.Đa Kao, Quận 1',
        '48/14 Đặng Dung, P.Tân Định, Quận 1',
        '314/38 Lê Văn Quới, P.Bình Hưng Hòa A, Q.Bình Tân',
        '156/11 Lê Thị Hồng, P.Phước Long A, Q.Thủ Đức',
        '67/42 Trần Hưng Đạo, P.Phường Nguyễn Cư Trinh, Quận 1',
        '280/44 Vạn Kiếp, Phường 3, Q.Bình Thạnh',
        '30/28 Nguyễn Bỉnh Khiêm, P.Bến Nghé, Quận 1',
        '102/12 Huỳnh Văn Bánh, Phường 15, Q.Phú Nhuận',
        '53/18A Trần Quốc Toản, Phường 8, Quận 3',
        '140/56 Nguyễn Duy Trinh, P.Bình Trưng Tây, Q.Thủ Đức',
      ],
    ),

    // XiaoMi Products
    SmartPhone(
      price: 24528451,
      imagePATH: './assets/images/xiaomi/14_black.png',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque semper arcu ligula, id accumsan tellus pellentesque et. In sollicitudin tincidunt.',
      rating: 4.5,
      name: 'XiaoMi 14',
      category: SmartPhoneCategory.XiaoMi,
      model: 'XiaoMi 14',
      modelColors: [
        ModelColor(
          imagePATH: './assets/images/xiaomi/14_black.png',
          color: Colors.black,
          name: 'Màu Đen',
          additionalPrice: 0,
        ),
        ModelColor(
          imagePATH: './assets/images/xiaomi/14_green.png',
          color: Colors.green.shade200,
          name: 'Màu Xanh',
          additionalPrice: 0,
        ),
        ModelColor(
          imagePATH: './assets/images/xiaomi/14_white.png',
          color: Colors.white,
          name: 'Màu Trắng',
          additionalPrice: 500000,
        ),
      ],
      modelMemories: [
        ModelMemory(memory: 256, additionalPrice: 0),
        ModelMemory(memory: 512, additionalPrice: 5000000),
        ModelMemory(memory: 1, additionalPrice: 10000000),
      ],
      warehouses: [
        '18/25 Nguyễn Đình Chiểu,P.Đa Kao, Quận 1',
        '48/14 Đặng Dung, P.Tân Định, Quận 1',
        '314/38 Lê Văn Quới, P.Bình Hưng Hòa A, Q.Bình Tân',
        '156/11 Lê Thị Hồng, P.Phước Long A, Q.Thủ Đức',
        '67/42 Trần Hưng Đạo, P.Phường Nguyễn Cư Trinh, Quận 1',
        '280/44 Vạn Kiếp, Phường 3, Q.Bình Thạnh',
        '30/28 Nguyễn Bỉnh Khiêm, P.Bến Nghé, Quận 1',
        '102/12 Huỳnh Văn Bánh, Phường 15, Q.Phú Nhuận',
        '53/18A Trần Quốc Toản, Phường 8, Quận 3',
        '140/56 Nguyễn Duy Trinh, P.Bình Trưng Tây, Q.Thủ Đức',
      ],
    ),

    // OnePlus Products
    SmartPhone(
      price: 19847133,
      imagePATH: './assets/images/oneplus/11_5g_black.png',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque semper arcu ligula, id accumsan tellus pellentesque et. In sollicitudin tincidunt.',
      rating: 4.0,
      name: 'OnePlus 11 5G',
      category: SmartPhoneCategory.OnePlus,
      model: 'OnePlus 11',
      modelColors: [
        ModelColor(
          imagePATH: './assets/images/oneplus/11_5g_black.png',
          color: Colors.black,
          name: 'Màu Đen',
          additionalPrice: 0,
        ),
        ModelColor(
          imagePATH: './assets/images/oneplus/11_5g_green.png',
          color: Colors.green.shade200,
          name: 'Màu Xanh',
          additionalPrice: 0,
        ),
      ],
      modelMemories: [
        ModelMemory(memory: 256, additionalPrice: 0),
        ModelMemory(memory: 512, additionalPrice: 5000000),
        ModelMemory(memory: 1, additionalPrice: 10000000),
      ],
      warehouses: [
        '18/25 Nguyễn Đình Chiểu,P.Đa Kao, Quận 1',
        '48/14 Đặng Dung, P.Tân Định, Quận 1',
        '314/38 Lê Văn Quới, P.Bình Hưng Hòa A, Q.Bình Tân',
        '156/11 Lê Thị Hồng, P.Phước Long A, Q.Thủ Đức',
        '67/42 Trần Hưng Đạo, P.Phường Nguyễn Cư Trinh, Quận 1',
        '280/44 Vạn Kiếp, Phường 3, Q.Bình Thạnh',
        '30/28 Nguyễn Bỉnh Khiêm, P.Bến Nghé, Quận 1',
        '102/12 Huỳnh Văn Bánh, Phường 15, Q.Phú Nhuận',
        '53/18A Trần Quốc Toản, Phường 8, Quận 3',
        '140/56 Nguyễn Duy Trinh, P.Bình Trưng Tây, Q.Thủ Đức',
      ],
    ),
  ];

  // G E T T E R S
  List<SmartPhone> get getAllSmartPhones => _smartPhones;

  // danh sách sản phẩm đầu tiên của mỗi category
  List<SmartPhone> getFirstProductOfEachCategory(List<SmartPhone> productList) {
    Map<SmartPhoneCategory, SmartPhone> firstProductsMap = {};

    // Lặp qua danh sách sản phẩm để tìm sản phẩm đầu tiên của mỗi category
    for (var product in productList) {
      if (!firstProductsMap.containsKey(product.category)) {
        // Nếu chưa có sản phẩm của category này trong map, thêm vào
        firstProductsMap[product.category] = product;
      }
    }

    return firstProductsMap.values.toList();
  }

  // danh sách category dạng string
  List<String> getSmartPhoneCategoriesAsStringList() {
    List<String> categories = [];

    // Lặp qua tất cả các giá trị trong enum SmartPhoneCategory và chuyển chúng thành chuỗi
    for (var category in SmartPhoneCategory.values) {
      categories.add(category.toString().split('.').last);
    }

    return categories;
  }

  // lấy danh sách sản phẩm nổi bật
  List<SmartPhone> getSmartPhonesPopular(
      double rating, List<SmartPhone> allSmartPhone) {
    return allSmartPhone
        .where((smartPhone) => smartPhone.rating >= rating)
        .toList();
  }

  // lấy danh sách sản phẩm ứng với category
  List<SmartPhone> getSmartPhonesByCategory(SmartPhoneCategory category) {
    List<SmartPhone> smartPhonesByCategory;
    smartPhonesByCategory =
        _smartPhones.where((phone) => phone.category == category).toList();
    return smartPhonesByCategory;
  }

  // lấy danh sách model của category
  List<String> getUniqueModelsByCategory(
      List<SmartPhone> allSmartPhones, String category) {
    SmartPhoneCategory smartPhoneCategory;
    switch (category.toLowerCase()) {
      case "iphone":
        smartPhoneCategory = SmartPhoneCategory.iPhone;
        break;
      case "samsung":
        smartPhoneCategory = SmartPhoneCategory.Samsung;
        break;
      case "oppo":
        smartPhoneCategory = SmartPhoneCategory.Oppo;
        break;
      case "xiaomi":
        smartPhoneCategory = SmartPhoneCategory.XiaoMi;
        break;
      case "oneplus":
        smartPhoneCategory = SmartPhoneCategory.OnePlus;
        break;
      default:
        throw Exception("Unknown category");
    }
    // Tạo một danh sách để lưu các model duy nhất
    List<String> uniqueModels = [];

    // Duyệt qua danh sách smartphone
    for (SmartPhone phone in allSmartPhones) {
      // Nếu smartphone thuộc category cần kiểm tra
      if (phone.category == smartPhoneCategory) {
        // Kiểm tra xem model của smartphone đã tồn tại trong danh sách uniqueModels chưa
        if (!uniqueModels.contains(phone.model)) {
          // Nếu chưa tồn tại, thêm model vào danh sách uniqueModels
          uniqueModels.add(phone.model);
        }
      }
    }

    // Trả về danh sách các model duy nhất theo category
    return uniqueModels;
  }
}
