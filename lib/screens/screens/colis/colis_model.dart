import 'package:cloud_firestore/cloud_firestore.dart';

class ColisModel {
  final String id;
  final String numeroColis;
  final String destinataire;
  final String status;
  final DateTime date;
  final String? expediteur; // Optionnel

  ColisModel({
    required this.id,
    required this.numeroColis,
    required this.destinataire,
    required this.status,
    required this.date,
    this.expediteur,
  });

  // 📦 Convertir un document Firestore en ColisModel
  factory ColisModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ColisModel(
      id: doc.id,
      numeroColis: data['numeroColis'] ?? 'N/A',
      destinataire: data['destinataire'] ?? 'Inconnu',
      status: data['status'] ?? 'En attente',
      date: (data['date'] as Timestamp).toDate(),
      expediteur: data['expediteur'],
    );
  }

  // 📦 Convertir un ColisModel en Map (pour Firestore)
  Map<String, dynamic> toMap() {
    return {
      'numeroColis': numeroColis,
      'destinataire': destinataire,
      'status': status,
      'date': date,
      'expediteur': expediteur,
    };
  }
}
