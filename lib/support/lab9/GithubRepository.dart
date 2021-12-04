class GithubRep{
  final int id;
  final String name;
  final String owner;
  final String ownerImage;
  final String description;

  GithubRep({
    required this.id,
    required this.name,
    required this.description,
    required this.owner,
    required this.ownerImage
  });

  factory GithubRep.fromJson(Map<String, dynamic> json){
    return GithubRep(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        owner: json['owner']['login'],
        ownerImage: json['owner']['avatar_url']
    );
  }
}