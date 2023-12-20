import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQFLiteDatabase {
  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await sqlLiteInit();
      return _database;
    } else {
      return _database;
    }
  }

  sqlLiteInit() async {
    String databasePath = await getDatabasesPath();
    String fullPath = join(databasePath, "bloodDonationDatabase.db");

    Database database = await openDatabase(fullPath, onCreate: _databaseCreation, version: 2);

    return database;
  }

  Future<void> _databaseCreation(Database db, int version) async {
    await db.execute('''
      CREATE TABLE Person (
        Id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        Type TEXT NOT NULL,
        FirstName TEXT NOT NULL,
        LastName TEXT NOT NULL,
        Address TEXT NOT NULL,
        ContactNumber TEXT NOT NULL,
        Email TEXT NOT NULL,
        Username TEXT NOT NULL,
        Password TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE MedicalHistory (
        HistoryId INTEGER PRIMARY KEY,
        MedicalHistory TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE BloodType (
        BloodId INTEGER PRIMARY KEY,
        Type TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE compatibleType (
        compatibleType TEXT NOT NULL,
        BloodId INTEGER NOT NULL,
        FOREIGN KEY (BloodId) REFERENCES BloodType(BloodId)
      )
    ''');

    await db.execute('''
      CREATE TABLE Donor (
        BirthDate TEXT NOT NULL,
        Weight INTEGER NOT NULL,
        DonorId INTEGER PRIMARY KEY,
        HistoryId INTEGER NOT NULL,
        FOREIGN KEY (DonorId) REFERENCES Person(Id),
        FOREIGN KEY (HistoryId) REFERENCES MedicalHistory(HistoryId)
      )
    ''');

    await db.execute('''
      CREATE TABLE Donation (
        DonationId INTEGER PRIMARY KEY,
        DonationDate TEXT NOT NULL,
        ExpirationDate TEXT NOT NULL,
        DonateAmount INTEGER NOT NULL,
        Status TEXT NOT NULL,
        AdminId INTEGER NOT NULL,
        DonorId INTEGER NOT NULL,
        FOREIGN KEY (AdminId) REFERENCES Person(Id),
        FOREIGN KEY (DonorId) REFERENCES Donor(DonorId)
      )
    ''');

    await db.execute('''
      CREATE TABLE Received (
        ReceivedAmount INTEGER NOT NULL,
        DonationId INTEGER NOT NULL,
        ReceivedId INTEGER NOT NULL,
        FOREIGN KEY (DonationId) REFERENCES Donation(DonationId),
        FOREIGN KEY (ReceivedId) REFERENCES Person(Id)
      )
    ''');
    await db.execute('''
    CREATE TABLE Recipient (
      RecipientId INTEGER NOT NULL,
      HistoryId INTEGER NOT NULL,
      ReceivedAmount INTEGER NOT NULL,
      FOREIGN KEY (RecipientId) REFERENCES Person(Id),
      FOREIGN KEY (HistoryId) REFERENCES MedicalHistory(HistoryId)
    )
  ''');

    await db.execute('''

    CREATE TABLE RequestBlood (
      RequestId INTEGER PRIMARY KEY,
      RecipientId INTEGER NOT NULL,
      BloodId INTEGER NOT NULL,
      BloodAmount INTEGER NOT NULL,
      IsApproved INTEGER NOT NULL,
      FOREIGN KEY (RecipientId) REFERENCES Person(Id),
      FOREIGN KEY (BloodId) REFERENCES BloodType(BloodId)
    )

  ''');

    await db.execute('''
    CREATE TABLE BloodCollectionDrive (
      DriveId INTEGER PRIMARY KEY,
      CollectedAmount INTEGER NOT NULL,
      TargetAmount INTEGER NOT NULL,
      StartDate TEXT NOT NULL,
      EndDate TEXT NOT NULL,
      CampaignType TEXT NOT NULL
    )

  ''');

    await db.execute('''
      CREATE TABLE UpdateInfoRequest (
        PersonId INTEGER NOT NULL ,
        Type TEXT NOT NULL,
        FirstName TEXT NOT NULL,
        LastName TEXT NOT NULL,
        Address TEXT NOT NULL,
        ContactNumber TEXT NOT NULL,
        Email TEXT NOT NULL,
        Username TEXT NOT NULL,
        Password TEXT NOT NULL,
        BirthDate TEXT NOT NULL,
        Weight INTEGER NOT NULL,
        Status TEXT NOT NULL,
        MedicalHistory TEXT NOT NULL
      )
    ''');
  }

  // Insert operations

  Future<int> insertPerson(Map<String, dynamic> person) async {
    final Database? db = await database;
    return await db!.insert('Person', person);
  }

  Future<int> insertBloodType(Map<String, dynamic> bloodType) async {
    final Database? db = await database;
    return await db!.insert('BloodType', bloodType);
  }

  Future<int> insertCompatibleType(Map<String, dynamic> compatibleType) async {
    final Database? db = await database;
    return await db!.insert('compatibleType', compatibleType);
  }

  Future<int> insertMedicalHistory(Map<String, dynamic> medicalHistory) async {
    final Database? db = await database;
    return await db!.insert('MedicalHistory', medicalHistory);
  }

  Future<int> insertDonor(Map<String, dynamic> donor) async {
    final Database? db = await database;
    return await db!.insert('Donor', donor);
  }

  Future<int> insertDonation(Map<String, dynamic> donation) async {
    final Database? db = await database;
    return await db!.insert('Donation', donation);
  }

  Future<int> insertReceived(Map<String, dynamic> received) async {
    final Database? db = await database;
    return await db!.insert('Received', received);
  }

  Future<void> insertRecipient(Map<String, dynamic> recipient) async {
    final db = await database;
    await db!.insert('Recipient', recipient);
  }

  Future<void> insertRequestBlood(Map<String, dynamic> requestBlood) async {
    final db = await database;
    await db!.insert('RequestBlood', requestBlood);
  }

  Future<void> insertBloodCollectionDrive(Map<String, dynamic> collectionDrive) async {
    final db = await database;
    await db!.insert('BloodCollectionDrive', collectionDrive);
  }

  Future<void> insertUpdateInfoRequest(Map<String, dynamic> updateInfo) async {
    final db = await database;
    await db!.insert('UpdateInfoRequest', updateInfo);
  }

  // Delete operations

  Future<int> deletePerson(int id) async {
    final Database? db = await database;
    return await db!.delete('Person', where: 'Id = ?', whereArgs: [id]);
  }

  Future<int> deleteBloodType(int bloodId) async {
    final Database? db = await database;
    return await db!.delete('BloodType', where: 'BloodId = ?', whereArgs: [bloodId]);
  }

  Future<int> deleteCompatibleType(int bloodId) async {
    final Database? db = await database;
    return await db!.delete('compatibleType', where: 'BloodId = ?', whereArgs: [bloodId]);
  }

  Future<int> deleteMedicalHistory(int historyId) async {
    final Database? db = await database;
    return await db!.delete('MedicalHistory', where: 'HistoryId = ?', whereArgs: [historyId]);
  }

  Future<int> deleteDonor(int donorId) async {
    final Database? db = await database;
    return await db!.delete('Donor', where: 'DonorId = ?', whereArgs: [donorId]);
  }

  Future<int> deleteDonation(int donationId) async {
    final Database? db = await database;
    return await db!.delete('Donation', where: 'DonationId = ?', whereArgs: [donationId]);
  }

  Future<int> deleteReceived(int receivedId) async {
    final Database? db = await database;
    return await db!.delete('Received', where: 'ReceivedId = ?', whereArgs: [receivedId]);
  }

  Future<void> deleteRecipient(int recipientId) async {
    final db = await database;
    await db!.delete('Recipient', where: 'RecipientId = ?', whereArgs: [recipientId]);
  }

  Future<void> deleteRequestBlood(int requestId) async {
    final db = await database;
    await db!.delete('RequestBlood', where: 'RequestId = ?', whereArgs: [requestId]);
  }

  Future<void> deleteBloodCollectionDrive(int driveId) async {
    final db = await database;
    await db!.delete('BloodCollectionDrive', where: 'DriveId = ?', whereArgs: [driveId]);
  }

  Future<void> deleteUpdateInfoRequest(int personId) async {
    final db = await database;
    await db!.delete('UpdateInfoRequest', where: 'PersonId = ?', whereArgs: [personId]);
  }
  // update operations

  Future<int> updatePerson(Map<String, dynamic> person) async {
    final Database? db = await database;
    final id = person['Id'];
    return await db!.update('Person', person, where: 'Id = ?', whereArgs: [id]);
  }

  Future<int> updateBloodType(Map<String, dynamic> bloodType) async {
    final Database? db = await database;
    final bloodId = bloodType['BloodId'];
    return await db!.update('BloodType', bloodType, where: 'BloodId = ?', whereArgs: [bloodId]);
  }

  Future<int> updateCompatibleType(Map<String, dynamic> compatibleType) async {
    final Database? db = await database;
    final bloodId = compatibleType['BloodId'];
    return await db!.update('compatibleType', compatibleType, where: 'BloodId = ?', whereArgs: [bloodId]);
  }

  Future<int> updateMedicalHistory(Map<String, dynamic> medicalHistory) async {
    final Database? db = await database;
    final historyId = medicalHistory['HistoryId'];
    return await db!.update('MedicalHistory', medicalHistory, where: 'HistoryId = ?', whereArgs: [historyId]);
  }

  Future<int> updateDonor(Map<String, dynamic> donor) async {
    final Database? db = await database;
    final donorId = donor['DonorId'];
    return await db!.update('Donor', donor, where: 'DonorId = ?', whereArgs: [donorId]);
  }

  Future<int> updateDonation(Map<String, dynamic> donation) async {
    final Database? db = await database;
    final donationId = donation['DonationId'];
    return await db!.update('Donation', donation, where: 'DonationId = ?', whereArgs: [donationId]);
  }

  Future<int> updateReceived(Map<String, dynamic> received) async {
    final Database? db = await database;
    final receivedId = received['ReceivedId'];
    return await db!.update('Received', received, where: 'ReceivedId = ?', whereArgs: [receivedId]);
  }

  Future<void> updateRecipient(Map<String, dynamic> recipient) async {
    final db = await database;
    final recipientId = recipient['RecipientId'];
    await db!.update('Recipient', recipient, where: 'RecipientId = ?', whereArgs: [recipientId]);
  }

  Future<void> updateRequestBlood(Map<String, dynamic> requestBlood) async {
    final db = await database;
    final requestId = requestBlood['RequestId'];
    await db!.update('RequestBlood', requestBlood, where: 'RequestId = ?', whereArgs: [requestId]);
  }

  Future<void> updateBloodCollectionDrive(Map<String, dynamic> collectionDrive) async {
    final db = await database;
    final driveId = collectionDrive['DriveId'];
    await db!.update('BloodCollectionDrive', collectionDrive, where: 'DriveId = ?', whereArgs: [driveId]);
  }

  // get operations

  Future<List<Map<String, dynamic>>> getAllPersons() async {
    final Database? db = await database;
    return await db!.query('Person');
  }

  Future<List<Map<String, dynamic>>> getBloodTypes() async {
    final Database? db = await database;
    return await db!.query('BloodType');
  }

  Future<List<Map<String, dynamic>>> getCompatibleTypes() async {
    final Database? db = await database;
    return await db!.query('compatibleType');
  }

  Future<List<Map<String, dynamic>>> getMedicalHistories() async {
    final Database? db = await database;
    return await db!.query('MedicalHistory');
  }

  Future<List<Map<String, dynamic>>> getDonors() async {
    final Database? db = await database;
    return await db!.query('Donor');
  }

  Future<List<Map<String, dynamic>>> getDonations() async {
    final Database? db = await database;
    return await db!.query('Donation');
  }

  Future<List<Map<String, dynamic>>> getReceived() async {
    final Database? db = await database;
    return await db!.query('Received');
  }

  Future<List<Map<String, dynamic>>> getBloodCollectionDrives() async {
    final Database? db = await database;
    return await db!.query('BloodCollectionDrive');
  }

  // this method List of all blood donations received in a week or a month
  Future<List<Map<String, dynamic>>> getBloodDonationsInPeriod(DateTime startDate, DateTime endDate) async {
    final Database? db = await database;
    return await db!.query(
      'Donation',
      where: 'donationDate BETWEEN ? AND ?',
      whereArgs: [startDate.toIso8601String(), endDate.toIso8601String()],
    );
  }

  // this method List the aggregated amount available for each blood type
  Future<Map<String, int>> getAggregatedBloodAmount() async {
    final db = await database;

    final results = await db!.rawQuery('''
    SELECT BloodType.Type, 
          (SUM(Donation.DonateAmount) - IFNULL(SUM(Received.ReceivedAmount), 0)) AS AggregatedAmount
    FROM BloodType
    LEFT JOIN Donation ON BloodType.BloodId = Donation.BloodId
    LEFT JOIN Received ON Donation.DonationId = Received.DonationId
    GROUP BY BloodType.Type
  ''');

    final bloodAmountMap = <String, int>{};

    for (final row in results) {
      final bloodType = row['Type'] as String;
      final aggregatedAmount = row['AggregatedAmount'] as int;
      bloodAmountMap[bloodType] = aggregatedAmount;
    }

    return bloodAmountMap;
  }

  // this method List all Collection Drive and total blood collected during each drive
  Future<List<Map<String, dynamic>>> getCollectionDrives() async {
    final db = await database;

    final results = await db!.rawQuery('''
    SELECT BloodCollectionDrive.DriveId,
           (SELECT SUM(DonateAmount) FROM Donation
            WHERE Donation.DonationDate >= BloodCollectionDrive.StartDate
              AND Donation.DonationDate <= BloodCollectionDrive.EndDate
            ) AS CollectedAmount
    FROM BloodCollectionDrive
  ''');

    final collectionDrives = <Map<String, dynamic>>[];

    for (final row in results) {
      final driveId = row['DriveId'] as int;
      final collectedAmount = row['CollectedAmount'] as int;
      final collectionDrive = {
        'driveId': driveId,
        'collectedAmount': collectedAmount,
      };
      collectionDrives.add(collectionDrive);
    }

    return collectionDrives;
  }
}
