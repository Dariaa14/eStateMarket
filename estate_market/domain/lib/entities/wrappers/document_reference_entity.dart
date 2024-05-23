abstract class DocumentReferenceEntity {
  Future<void> set(Map<String, Object?> json);
  Future<void> delete();

  void listen({required void Function() onModify, required void Function() onDelete});
}
