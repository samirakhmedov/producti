import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:producti/data/core/error/error_codes.dart';
import 'package:producti/data/core/error/failure.dart';
import 'package:producti/domain/table/remote_table_repository.dart';
import 'package:producti/domain/table/table.dart';

@Injectable(as: RemoteTableRepository)
class RemoteTableRepositoryImpl extends RemoteTableRepository {
  final FirebaseFirestore _firestore;

  RemoteTableRepositoryImpl(this._firestore);

  DocumentReference<Map<String, dynamic>> _getUserTableDocument(String userId) {
    final tables = _firestore.collection('tables');

    final userDocument = tables.doc(userId);

    return userDocument;
  }

  @override
  Future<Either<Failure, List<Table>>> loadData(String userUid) async {
    try {
      final userDocument = _getUserTableDocument(userUid);

      final documentData = await userDocument.get();

      if (!documentData.exists) {
        await userDocument.set({
          'order': [],
        });

        return right([]);
      }

      final documentJson = documentData.data()!;

      final tablesOrder = documentJson['order'] as List<String>;

      List<Table> result = [];

      for (int i = 0; i < tablesOrder.length; i++) {
        result[i] = Table.fromJson(
            documentJson[tablesOrder[i]] as Map<String, dynamic>);
      }

      return right(result);
    } catch (e) {
      return left(const TableFailure(ErrorCode.failedToFetchUserData));
    }
  }

  @override
  Future<Either<Failure, void>> updateData(
      String userUid, List<Table> tables) async {
    try {
      final userDocument = _getUserTableDocument(userUid);

      Map<String, dynamic> json = {
        'order': [],
      };

      for (int i = 0; i < tables.length; i++) {
        final table = tables[i];

        json['order'].add(table.title);

        json[table.title] = table.toJson();
      }

      await userDocument.set(json);

      return right(null);
    } catch (e) {
      return left(const TableFailure(ErrorCode.failedToFetchUserData));
    }
  }
}
