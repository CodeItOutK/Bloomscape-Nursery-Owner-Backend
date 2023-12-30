import 'package:bloomscape_backend/model/nursery_model.dart';
import 'package:bloomscape_backend/model/opening_hours_model.dart';
import 'package:bloomscape_backend/model/product_model.dart';
import 'package:bloomscape_backend/repositories/Nursery/base_nursery_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NurseryRepository extends BaseNurseryRepository{
  final FirebaseFirestore _firebaseFirestore;

  NurseryRepository({FirebaseFirestore? firebaseFirestore}):_firebaseFirestore=firebaseFirestore??FirebaseFirestore.instance;
  @override
  Future<void> addNursery(Nursery nursery)async {
    await _firebaseFirestore.collection('nurseries').add(nursery.toDocument());
  }

  @override
  Future<void> editNurseryOpeningHours(List<OpeningHours> openingHours)async {
    await _firebaseFirestore.collection('nurseries').doc('MbyvrvKY1hdNohNU11EL')
        .update({
      'openingHours':openingHours.map((openingHour){
        return openingHour.toDocument();
      }).toList(),
    });
  }

  @override
  Future<void> editNurserySettings(Nursery nursery)async {
    await _firebaseFirestore.collection("nurseries").doc("MbyvrvKY1hdNohNU11EL")
        .update(nursery.toDocument());
  }

  @override
  Future<void> editProducts(List<Product> products)async {
    await _firebaseFirestore.collection('nurseries').doc('MbyvrvKY1hdNohNU11EL')
        .update({
      'products':products.map((product){
        return product.toDocument();
      }).toList(),
    });
  }

  @override
  Stream<Nursery> getNursery() {
    return _firebaseFirestore.collection("nurseries").doc("MbyvrvKY1hdNohNU11EL")
        .snapshots().map((snapshot){
          return Nursery.fromSnapshot(snapshot);
    });
  }
  
}