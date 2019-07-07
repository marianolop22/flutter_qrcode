class ScanModel {

    int id;
    String type;
    String valor;

    ScanModel({
        this.id,
        this.type,
        this.valor,
    }){

      if ( this.valor.contains('http')) {

        this.type = 'http';
      } else {
        this.type = 'geo';
      }
    }

    factory ScanModel.fromJson(Map<String, dynamic> json) => new ScanModel(
        id: json["id"],
        type: json["type"],
        valor: json["valor"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "valor": valor,
    };
}
