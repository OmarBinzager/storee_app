import 'package:equatable/equatable.dart';

class BackupMetadata extends Equatable {
  final String filePath;
  final String fileName;
  final String version;
  final DateTime createdAt;
  final String checksum;
  final int customerCount;
  final int orderCount;
  final int walletCount;
  final int transactionCount;
  final int purchaseBatchCount;
  final int payloadSizeBytes;

  const BackupMetadata({
    required this.filePath,
    required this.fileName,
    required this.version,
    required this.createdAt,
    required this.checksum,
    required this.customerCount,
    required this.orderCount,
    required this.walletCount,
    required this.transactionCount,
    required this.purchaseBatchCount,
    required this.payloadSizeBytes,
  });

  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'createdAt': createdAt.toIso8601String(),
      'checksum': checksum,
      'customerCount': customerCount,
      'orderCount': orderCount,
      'walletCount': walletCount,
      'transactionCount': transactionCount,
      'purchaseBatchCount': purchaseBatchCount,
      'payloadSizeBytes': payloadSizeBytes,
    };
  }

  factory BackupMetadata.fromJson(Map<String, dynamic> json, {String filePath = '', String fileName = ''}) {
    return BackupMetadata(
      filePath: filePath,
      fileName: fileName,
      version: json['version'] as String? ?? '1.0.0',
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
      checksum: json['checksum'] as String? ?? '',
      customerCount: json['customerCount'] as int? ?? 0,
      orderCount: json['orderCount'] as int? ?? 0,
      walletCount: json['walletCount'] as int? ?? 0,
      transactionCount: json['transactionCount'] as int? ?? 0,
      purchaseBatchCount: json['purchaseBatchCount'] as int? ?? 0,
      payloadSizeBytes: json['payloadSizeBytes'] as int? ?? 0,
    );
  }

  @override
  List<Object?> get props => [
        filePath,
        fileName,
        version,
        createdAt,
        checksum,
        customerCount,
        orderCount,
        walletCount,
        transactionCount,
        purchaseBatchCount,
        payloadSizeBytes,
      ];
}
