/// 主机监控响应模型类
class HostResponseModel {
  List<HostModel>? content;
  Pageable? pageable;
  bool? last;
  int? totalPages;
  int? totalElements;
  int? number;
  Sort? sort;
  int? size;
  int? numberOfElements;
  bool? first;
  bool? empty;

  HostResponseModel({
    this.content,
    this.pageable,
    this.last,
    this.totalPages,
    this.totalElements,
    this.number,
    this.sort,
    this.size,
    this.numberOfElements,
    this.first,
    this.empty,
  });

  HostResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['content'] != null) {
      content = <HostModel>[];
      json['content'].forEach((v) {
        content!.add(HostModel.fromJson(v));
      });
    }
    pageable = json['pageable'] != null ? Pageable.fromJson(json['pageable']) : null;
    last = json['last'];
    totalPages = json['totalPages'];
    totalElements = json['totalElements'];
    number = json['number'];
    sort = json['sort'] != null ? Sort.fromJson(json['sort']) : null;
    size = json['size'];
    numberOfElements = json['numberOfElements'];
    first = json['first'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (content != null) {
      data['content'] = content!.map((v) => v.toJson()).toList();
    }
    if (pageable != null) {
      data['pageable'] = pageable!.toJson();
    }
    data['last'] = last;
    data['totalPages'] = totalPages;
    data['totalElements'] = totalElements;
    data['number'] = number;
    if (sort != null) {
      data['sort'] = sort!.toJson();
    }
    data['size'] = size;
    data['numberOfElements'] = numberOfElements;
    data['first'] = first;
    data['empty'] = empty;
    return data;
  }
}

/// 主机模型类
class HostModel {
  int? id;
  String? title;
  String? cpu;
  String? ram;
  String? disk;
  String? ip;
  String? location;
  String? bandwidth;
  String? price;
  String? productUrl;
  String? promoCode;
  String? remark;
  int? monitorStatus;
  int? flag;
  String? monitorTime;
  int? level;

  HostModel({
    this.id,
    this.title,
    this.cpu,
    this.ram,
    this.disk,
    this.ip,
    this.location,
    this.bandwidth,
    this.price,
    this.productUrl,
    this.promoCode,
    this.remark,
    this.monitorStatus,
    this.flag,
    this.monitorTime,
    this.level,
  });

  HostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    cpu = json['cpu'];
    ram = json['ram'];
    disk = json['disk'];
    ip = json['ip'];
    location = json['location'];
    bandwidth = json['bandwidth'];
    price = json['price'];
    productUrl = json['productUrl'];
    promoCode = json['promoCode'];
    remark = json['remark'];
    monitorStatus = json['monitorStatus'];
    flag = json['flag'];
    monitorTime = json['monitorTime'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['cpu'] = cpu;
    data['ram'] = ram;
    data['disk'] = disk;
    data['ip'] = ip;
    data['location'] = location;
    data['bandwidth'] = bandwidth;
    data['price'] = price;
    data['productUrl'] = productUrl;
    data['promoCode'] = promoCode;
    data['remark'] = remark;
    data['monitorStatus'] = monitorStatus;
    data['flag'] = flag;
    data['monitorTime'] = monitorTime;
    data['level'] = level;
    return data;
  }
}

class Pageable {
  Sort? sort;
  int? offset;
  int? pageNumber;
  int? pageSize;
  bool? paged;
  bool? unpaged;

  Pageable({this.sort, this.offset, this.pageNumber, this.pageSize, this.paged, this.unpaged});

  Pageable.fromJson(Map<String, dynamic> json) {
    sort = json['sort'] != null ? Sort.fromJson(json['sort']) : null;
    offset = json['offset'];
    pageNumber = json['pageNumber'];
    pageSize = json['pageSize'];
    paged = json['paged'];
    unpaged = json['unpaged'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sort != null) {
      data['sort'] = sort!.toJson();
    }
    data['offset'] = offset;
    data['pageNumber'] = pageNumber;
    data['pageSize'] = pageSize;
    data['paged'] = paged;
    data['unpaged'] = unpaged;
    return data;
  }
}

class Sort {
  bool? sorted;
  bool? unsorted;
  bool? empty;

  Sort({this.sorted, this.unsorted, this.empty});

  Sort.fromJson(Map<String, dynamic> json) {
    sorted = json['sorted'];
    unsorted = json['unsorted'];
    empty = json['empty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sorted'] = sorted;
    data['unsorted'] = unsorted;
    data['empty'] = empty;
    return data;
  }
}
