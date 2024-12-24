class Comment {
  String? name;
  String? creation;
  String? content;
  String? owner;
  String? commentType;

  Comment(
      {this.name, this.creation, this.content, this.owner, this.commentType});

  Comment.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    creation = json['creation'];
    content = json['content'];
    owner = json['owner'];
    commentType = json['comment_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['creation'] = creation;
    data['content'] = content;
    data['owner'] = owner;
    data['comment_type'] = commentType;
    return data;
  }
}
