abstract class DatabaseServices {
  Future storeData({
    required String path,
    required dynamic data,
    String? id,
    String? subCollectionName,
    String? subCollectionID,
  });

  Future<Map<String, dynamic>> fetchData({required String path, String? id});


  Future<List<Map<String, dynamic>>> fetchAllData({required String path ,required String id , String? subCollectionName});

  Future<bool> checkIfDataExist({
    required String path,
    required String id,
    String? subCollectionName,
    String? subCollectionID,
  });

 Future<void> updateUserData({ String? userName , String? userPhone, required String userID});

  Future<int> getNumberOfRecords({
    required String path,
    required String id,
    String? subCollectionName,
  });
}
