import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awid_app/core/constants.dart';
import 'package:awid_app/models/colis_model.dart';

class ColisScreen extends StatelessWidget {
  const ColisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes Colis"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              // TODO: Ouvrir un modal pour ajouter un colis
              print("Ajouter un colis");
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('colis')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Aucun colis trouvé"));
          }

          // 📦 Afficher la liste des colis
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final colis = ColisModel.fromFirestore(
                snapshot.data!.docs[index],
              );
              return _buildColisCard(context, colis);
            },
          );
        },
      ),
    );
  }

  Widget _buildColisCard(BuildContext context, ColisModel colis) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: colis.status == 'En attente'
              ? Colors.orange
              : colis.status == 'En cours'
                  ? Colors.blue
                  : Colors.green,
          child: Text(colis.numeroColis.substring(0, 2)),
        ),
        title: Text(colis.numeroColis),
        subtitle: Text(
          "Statut : ${colis.status}\n"
          "Destinataire : ${colis.destinataire}",
        ),
        trailing: IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () {
            // TODO: Ouvrir une page détaillée du colis
            print("Détails du colis ${colis.numeroColis}");
          },
        ),
      ),
    );
  }
}
