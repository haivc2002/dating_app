class LocationCurrentModel {
  List<Results>? results;
  Query? query;

  LocationCurrentModel({this.results, this.query});

  LocationCurrentModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
    query = json['query'] != null ? Query.fromJson(json['query']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    if (query != null) {
      data['query'] = query!.toJson();
    }
    return data;
  }
}

class Results {
  Datasource? datasource;
  String? country;
  String? countryCode;
  String? state;
  String? county;
  String? city;
  String? road;
  double? lon;
  double? lat;
  double? distance;
  String? resultType;
  String? formatted;
  String? addressLine1;
  String? addressLine2;
  Timezone? timezone;
  String? plusCode;
  String? plusCodeShort;
  Rank? rank;
  String? placeId;
  Bbox? bbox;

  Results(
      {this.datasource,
        this.country,
        this.countryCode,
        this.state,
        this.county,
        this.city,
        this.road,
        this.lon,
        this.lat,
        this.distance,
        this.resultType,
        this.formatted,
        this.addressLine1,
        this.addressLine2,
        this.timezone,
        this.plusCode,
        this.plusCodeShort,
        this.rank,
        this.placeId,
        this.bbox});

  Results.fromJson(Map<String, dynamic> json) {
    datasource = json['datasource'] != null
        ? Datasource.fromJson(json['datasource'])
        : null;
    country = json['country'];
    countryCode = json['country_code'];
    state = json['state'];
    county = json['county'];
    city = json['city'];
    road = json['road'];
    lon = json['lon'];
    lat = json['lat'];
    distance = json['distance'];
    resultType = json['result_type'];
    formatted = json['formatted'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    timezone = json['timezone'] != null
        ? Timezone.fromJson(json['timezone'])
        : null;
    plusCode = json['plus_code'];
    plusCodeShort = json['plus_code_short'];
    rank = json['rank'] != null ? Rank.fromJson(json['rank']) : null;
    placeId = json['place_id'];
    bbox = json['bbox'] != null ? Bbox.fromJson(json['bbox']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (datasource != null) {
      data['datasource'] = datasource!.toJson();
    }
    data['country'] = country;
    data['country_code'] = countryCode;
    data['state'] = state;
    data['county'] = county;
    data['city'] = city;    data['road'] = road;
    data['lon'] = lon;
    data['lat'] = lat;
    data['distance'] = distance;
    data['result_type'] = resultType;
    data['formatted'] = formatted;
    data['address_line1'] = addressLine1;
    data['address_line2'] = addressLine2;
    if (timezone != null) {
      data['timezone'] = timezone!.toJson();
    }
    data['plus_code'] = plusCode;
    data['plus_code_short'] = plusCodeShort;
    if (rank != null) {
      data['rank'] = rank!.toJson();
    }
    data['place_id'] = placeId;
    if (bbox != null) {
      data['bbox'] = bbox!.toJson();
    }
    return data;
  }
}

class Datasource {
  String? sourcename;
  String? attribution;
  String? license;
  String? url;

  Datasource({this.sourcename, this.attribution, this.license, this.url});

  Datasource.fromJson(Map<String, dynamic> json) {
    sourcename = json['sourcename'];
    attribution = json['attribution'];
    license = json['license'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sourcename'] = sourcename;
    data['attribution'] = attribution;
    data['license'] = license;
    data['url'] = url;
    return data;
  }
}

class Timezone {
  String? name;
  String? offsetSTD;
  int? offsetSTDSeconds;
  String? offsetDST;
  int? offsetDSTSeconds;

  Timezone(
      {this.name,
        this.offsetSTD,
        this.offsetSTDSeconds,
        this.offsetDST,
        this.offsetDSTSeconds});

  Timezone.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    offsetSTD = json['offset_STD'];
    offsetSTDSeconds = json['offset_STD_seconds'];
    offsetDST = json['offset_DST'];
    offsetDSTSeconds = json['offset_DST_seconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['offset_STD'] = offsetSTD;
    data['offset_STD_seconds'] = offsetSTDSeconds;
    data['offset_DST'] = offsetDST;
    data['offset_DST_seconds'] = offsetDSTSeconds;
    return data;
  }
}

class Rank {
  double? importance;
  double? popularity;

  Rank({this.importance, this.popularity});

  Rank.fromJson(Map<String, dynamic> json) {
    importance = json['importance'];
    popularity = json['popularity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['importance'] = importance;
    data['popularity'] = popularity;
    return data;
  }
}

class Bbox {
  double? lon1;
  double? lat1;
  double? lon2;
  double? lat2;

  Bbox({this.lon1, this.lat1, this.lon2, this.lat2});

  Bbox.fromJson(Map<String, dynamic> json) {
    lon1 = json['lon1'];
    lat1 = json['lat1'];
    lon2 = json['lon2'];
    lat2 = json['lat2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lon1'] = lon1;
    data['lat1'] = lat1;
    data['lon2'] = lon2;
    data['lat2'] = lat2;
    return data;
  }
}

class Query {
  double? lat;
  double? lon;
  String? plusCode;

  Query({this.lat, this.lon, this.plusCode});

  Query.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
    plusCode = json['plus_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    data['plus_code'] = plusCode;
    return data;
  }
}
