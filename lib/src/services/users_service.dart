import 'package:appsicanet/src/models/users_model.dart';
import 'package:appsicanet/src/models/usuarios_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersService {
  final referenciaUsuario = FirebaseFirestore.instance.collection('users');

  Future<void> addUser({UserModel usuario}) async {
    final id = referenciaUsuario.doc().id;
    usuario.id = id;
    await referenciaUsuario.doc(id).set(usuario.toMap());
  }

  Future<void> addUseridAuto() async {
    await referenciaUsuario
        .add({'email': 'flowisg@gmail.com', 'nummovil': '9512425856'});
  }

  Future<void> addUseridFijo() async {
    await referenciaUsuario
        .doc('idfijo')
        .set({'email': 'user@gmail.com', 'nummovil': '9511235856'});
  }

  Future<bool> existeNumCel(String numcel) async {
    final user =
        await referenciaUsuario.where('nummovil', isEqualTo: numcel).get();

    final documentos = user.docs.length;
    return documentos > 0 ? true : false;
  }

  Future<UserModel> getUser(String numcel) async {
    UserModel usuario;

    QuerySnapshot querysnapshot =
        await referenciaUsuario.where('nummovil', isEqualTo: numcel).get();
    print(querysnapshot.docs.length);

    usuario = UserModel.fromJsonMap(querysnapshot.docs.first.data());

    return usuario;
  }
}
