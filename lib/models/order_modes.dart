part of 'models.dart';

List<OrdersModel> ordersModelFromJson(String str) => List<OrdersModel>.from(
    json.decode(str).map((x) => OrdersModel.fromJson(x)));

String ordersModelToJson(List<OrdersModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrdersModel {
  OrdersModel({
    required this.id,
    required this.parentId,
    required this.status,
    required this.currency,
    required this.version,
    required this.pricesIncludeTax,
    required this.dateCreated,
    required this.dateModified,
    required this.discountTotal,
    required this.discountTax,
    required this.shippingTotal,
    required this.shippingTax,
    required this.cartTax,
    required this.total,
    required this.totalTax,
    required this.customerId,
    required this.orderKey,
    required this.billing,
    required this.shipping,
    required this.paymentMethod,
    required this.paymentMethodTitle,
    required this.transactionId,
    required this.customerIpAddress,
    required this.customerUserAgent,
    required this.createdVia,
    required this.customerNote,
    required this.dateCompleted,
    required this.datePaid,
    required this.cartHash,
    required this.number,
    required this.metaData,
    required this.lineItems,
    required this.taxLines,
    required this.shippingLines,
    required this.feeLines,
    required this.couponLines,
    required this.refunds,
    required this.paymentUrl,
    required this.isEditable,
    required this.needsPayment,
    required this.needsProcessing,
    required this.dateCreatedGmt,
    required this.dateModifiedGmt,
    required this.dateCompletedGmt,
    required this.datePaidGmt,
    required this.currencySymbol,
    required this.links,
  });

  int id;
  int parentId;
  String status;
  String currency;
  String version;
  bool pricesIncludeTax;
  DateTime dateCreated;
  DateTime dateModified;
  String discountTotal;
  String discountTax;
  String shippingTotal;
  String shippingTax;
  String cartTax;
  String total;
  String totalTax;
  int customerId;
  String orderKey;
  Ing billing;
  Ing shipping;
  String paymentMethod;
  String paymentMethodTitle;
  String transactionId;
  String customerIpAddress;
  String customerUserAgent;
  String createdVia;
  String customerNote;
  DateTime? dateCompleted;
  DateTime datePaid;
  String cartHash;
  String number;
  List<dynamic> metaData;
  List<LineItem> lineItems;
  List<dynamic> taxLines;
  List<ShippingLine> shippingLines;
  List<dynamic> feeLines;
  List<dynamic> couponLines;
  List<dynamic> refunds;
  String paymentUrl;
  bool isEditable;
  bool needsPayment;
  bool needsProcessing;
  DateTime dateCreatedGmt;
  DateTime dateModifiedGmt;
  DateTime? dateCompletedGmt;
  DateTime datePaidGmt;
  String currencySymbol;
  Links links;

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
        id: json["id"],
        parentId: json["parent_id"],
        status: json["status"],
        currency: json["currency"],
        version: json["version"],
        pricesIncludeTax: json["prices_include_tax"],
        dateCreated: DateTime.parse(json["date_created"]),
        dateModified: DateTime.parse(json["date_modified"]),
        discountTotal: json["discount_total"],
        discountTax: json["discount_tax"],
        shippingTotal: json["shipping_total"],
        shippingTax: json["shipping_tax"],
        cartTax: json["cart_tax"],
        total: json["total"],
        totalTax: json["total_tax"],
        customerId: json["customer_id"],
        orderKey: json["order_key"],
        billing: Ing.fromJson(json["billing"]),
        shipping: Ing.fromJson(json["shipping"]),
        paymentMethod: json["payment_method"],
        paymentMethodTitle: json["payment_method_title"],
        transactionId: json["transaction_id"],
        customerIpAddress: json["customer_ip_address"],
        customerUserAgent: json["customer_user_agent"],
        createdVia: json["created_via"],
        customerNote: json["customer_note"],
        dateCompleted: json["date_completed"] == null
            ? null
            : DateTime.parse(json["date_completed"]),
        datePaid: DateTime.parse(json["date_paid"]),
        cartHash: json["cart_hash"],
        number: json["number"],
        metaData: List<dynamic>.from(json["meta_data"].map((x) => x)),
        lineItems: List<LineItem>.from(
            json["line_items"].map((x) => LineItem.fromJson(x))),
        taxLines: List<dynamic>.from(json["tax_lines"].map((x) => x)),
        shippingLines: List<ShippingLine>.from(
            json["shipping_lines"].map((x) => ShippingLine.fromJson(x))),
        feeLines: List<dynamic>.from(json["fee_lines"].map((x) => x)),
        couponLines: List<dynamic>.from(json["coupon_lines"].map((x) => x)),
        refunds: List<dynamic>.from(json["refunds"].map((x) => x)),
        paymentUrl: json["payment_url"],
        isEditable: json["is_editable"],
        needsPayment: json["needs_payment"],
        needsProcessing: json["needs_processing"],
        dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
        dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
        dateCompletedGmt: json["date_completed_gmt"] == null
            ? null
            : DateTime.parse(json["date_completed_gmt"]),
        datePaidGmt: DateTime.parse(json["date_paid_gmt"]),
        currencySymbol: json["currency_symbol"],
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parent_id": parentId,
        "status": status,
        "currency": currency,
        "version": version,
        "prices_include_tax": pricesIncludeTax,
        "date_created": dateCreated.toIso8601String(),
        "date_modified": dateModified.toIso8601String(),
        "discount_total": discountTotal,
        "discount_tax": discountTax,
        "shipping_total": shippingTotal,
        "shipping_tax": shippingTax,
        "cart_tax": cartTax,
        "total": total,
        "total_tax": totalTax,
        "customer_id": customerId,
        "order_key": orderKey,
        "billing": billing.toJson(),
        "shipping": shipping.toJson(),
        "payment_method": paymentMethod,
        "payment_method_title": paymentMethodTitle,
        "transaction_id": transactionId,
        "customer_ip_address": customerIpAddress,
        "customer_user_agent": customerUserAgent,
        "created_via": createdVia,
        "customer_note": customerNote,
        "date_paid": datePaid.toIso8601String(),
        "cart_hash": cartHash,
        "number": number,
        "meta_data": List<dynamic>.from(metaData.map((x) => x)),
        "line_items": List<dynamic>.from(lineItems.map((x) => x.toJson())),
        "tax_lines": List<dynamic>.from(taxLines.map((x) => x)),
        "shipping_lines":
            List<dynamic>.from(shippingLines.map((x) => x.toJson())),
        "fee_lines": List<dynamic>.from(feeLines.map((x) => x)),
        "coupon_lines": List<dynamic>.from(couponLines.map((x) => x)),
        "refunds": List<dynamic>.from(refunds.map((x) => x)),
        "payment_url": paymentUrl,
        "is_editable": isEditable,
        "needs_payment": needsPayment,
        "needs_processing": needsProcessing,
        "date_created_gmt": dateCreatedGmt.toIso8601String(),
        "date_modified_gmt": dateModifiedGmt.toIso8601String(),
        "date_paid_gmt": datePaidGmt.toIso8601String(),
        "currency_symbol": currencySymbol,
        "_links": links.toJson(),
      };
}

class LineItem {
  LineItem({
    required this.id,
    required this.name,
    required this.productId,
    required this.variationId,
    required this.quantity,
    required this.taxClass,
    required this.subtotal,
    required this.subtotalTax,
    required this.total,
    required this.totalTax,
    required this.taxes,
    required this.metaData,
    required this.price,
    required this.parentName,
    required this.imageProduct,
  });

  int id;
  String name;
  int productId;
  int variationId;
  int quantity;
  String taxClass;
  String subtotal;
  String subtotalTax;
  String total;
  String totalTax;
  List<dynamic> taxes;
  List<MetaDatum> metaData;
  ImageOrder? imageProduct;

  dynamic price;

  dynamic parentName;

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
        id: json["id"],
        name: json["name"],
        productId: json["product_id"],
        variationId: json["variation_id"],
        quantity: json["quantity"],
        taxClass: json["tax_class"],
        subtotal: json["subtotal"],
        subtotalTax: json["subtotal_tax"],
        total: json["total"],
        totalTax: json["total_tax"],
        taxes: List<dynamic>.from(json["taxes"].map((x) => x)),
        metaData: List<MetaDatum>.from(
            json["meta_data"].map((x) => MetaDatum.fromJson(x))),
        price: json["price"],
        imageProduct:
            json["image"] == null ? null : ImageOrder.fromJson(json["image"]),
        parentName: json["parent_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "product_id": productId,
        "variation_id": variationId,
        "quantity": quantity,
        "tax_class": taxClass,
        "subtotal": subtotal,
        "subtotal_tax": subtotalTax,
        "total": total,
        "total_tax": totalTax,
        "taxes": List<dynamic>.from(taxes.map((x) => x)),
        "meta_data": List<dynamic>.from(metaData.map((x) => x.toJson())),
        "price": price,
        "image": imageProduct == null ? null : imageProduct!.toJson(),
        "parent_name": parentName,
      };
}

class ImageOrder {
  ImageOrder({
    required this.id,
    required this.src,
  });

  dynamic id;
  String src;

  factory ImageOrder.fromJson(Map<String, dynamic> json) => ImageOrder(
        id: json["id"],
        src: json["src"] == null ? null : json["src"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "src": src == null ? null : src,
      };
}
/* class Image {
  Image({
    required this.id,
    required this.src,
  });

  dynamic id;
  String src;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        src: json["src"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "src": src,
      };
} */

class MetaDatum {
  MetaDatum({
    required this.id,
    required this.key,
    required this.value,
    required this.displayKey,
    required this.displayValue,
  });

  int id;
  String key;
  String value;
  String displayKey;
  String displayValue;

  factory MetaDatum.fromJson(Map<String, dynamic> json) => MetaDatum(
        id: json["id"],
        key: json["key"],
        value: json["value"],
        displayKey: json["display_key"],
        displayValue: json["display_value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "key": key,
        "value": value,
        "display_key": displayKey,
        "display_value": displayValue,
      };
}

class ShippingLine {
  ShippingLine({
    required this.id,
    required this.methodTitle,
    required this.methodId,
    required this.instanceId,
    required this.total,
    required this.totalTax,
    required this.taxes,
    required this.metaData,
  });

  int id;
  String methodTitle;
  String methodId;
  String instanceId;
  String total;
  String totalTax;
  List<dynamic> taxes;
  List<dynamic> metaData;

  factory ShippingLine.fromJson(Map<String, dynamic> json) => ShippingLine(
        id: json["id"],
        methodTitle: json["method_title"],
        methodId: json["method_id"],
        instanceId: json["instance_id"],
        total: json["total"],
        totalTax: json["total_tax"],
        taxes: List<dynamic>.from(json["taxes"].map((x) => x)),
        metaData: List<dynamic>.from(json["meta_data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "method_title": methodTitle,
        "method_id": methodId,
        "instance_id": instanceId,
        "total": total,
        "total_tax": totalTax,
        "taxes": List<dynamic>.from(taxes.map((x) => x)),
        "meta_data": List<dynamic>.from(metaData.map((x) => x)),
      };
}
