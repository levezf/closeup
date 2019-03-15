class Filme {
  static const LINK_IMAGE = "https://image.tmdb.org/t/p/w500";
  static const LINK_IMAGE_NULL =
      "https://image.flaticon.com/icons/svg/263/263068.svg";
  final String titulo;
  final String urlPoster;
  final String descricao;
  final double popularidade;
  final double votoMedio;
  final int qtdadeVotos;
  final String dataLancamento;
  final String urlBackdrop;
  final String tituloOriginal;
  final String linguagemOriginal;
  final String id;

  Filme(
      {this.titulo,
      this.urlPoster,
      this.descricao,
      this.popularidade,
      this.votoMedio,
      this.qtdadeVotos,
      this.dataLancamento,
      this.urlBackdrop,
      this.tituloOriginal,
      this.linguagemOriginal,
      this.id});

  factory Filme.fromJson(Map<String, dynamic> json) {
    String poster = json["poster_path"] != null
        ? "$LINK_IMAGE${json["poster_path"]}"
        : null;
    String backdrop = json["backdrop_path"] != null
        ? "$LINK_IMAGE${json["backdrop_path"]}"
        : null;

    return Filme(
        id: json["id"].toString(),
        titulo: json["title"],
        urlPoster: poster,
        descricao: json["overview"],
        urlBackdrop: backdrop,
        popularidade: json["popularity"],
        votoMedio: double.parse(json["vote_average"].toString()),
        qtdadeVotos: json["vote_count"],
        dataLancamento: json["release_date"],
        linguagemOriginal: json["original_language"],
        tituloOriginal: json["original_title"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": titulo,
      "overview": descricao,
      "poster_path": urlPoster.replaceAll(LINK_IMAGE, ""),
      "backdrop_path": urlBackdrop.replaceAll(LINK_IMAGE, ""),
      "popularity": popularidade,
      "vote_average": votoMedio,
      "vote_count": qtdadeVotos,
      "release_date": dataLancamento,
      "original_language": linguagemOriginal,
      "original_title": tituloOriginal
    };
  }
}
