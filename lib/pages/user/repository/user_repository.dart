import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartt_maat_v2/models/user_model.dart';
import 'package:dartt_maat_v2/pages/user/result/auth_result.dart';
import 'package:dartt_maat_v2/results/generics_result.dart';
import 'package:dartt_maat_v2/services/util_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final utilServices = UtilsServices();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final fireRef = FirebaseFirestore.instance.collection('users');

// buscar todas os canais
  Future<GenericsResult<UserModel>> getAllUser() async {
    try {
      final QuerySnapshot snapUsers =
          await fireRef.where('typeUser', isNotEqualTo: 'Cliente').get();

      if (snapUsers.docs.isNotEmpty) {
        List<UserModel> data =
            snapUsers.docs.map((d) => UserModel.fromDocument(d)).toList();
        return GenericsResult<UserModel>.success(data);
      } else {
        return GenericsResult.error('Não existem usuários cadastrados!');
      }
    } catch (e) {
      return GenericsResult.error(
          'Erro ao recuperar os dados do servidor -Usuario-');
    }
  }

// salvar os canais
  Future<void> addUser({required UserModel user}) async {
    // user.id = fireRef.doc().id; este recupera o id que foi salvo no firebase após persistir
    try {
      await fireRef.doc(user.id).set(user.toJson());
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

// deletar canais
  Future<void> deleteUser({required String userId}) async {
    try {
      await fireRef.doc(userId).delete();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

// editar canais
  Future<void> updateUser({required UserModel user}) async {
    try {
      await fireRef.doc(user.id).update(user.toJson());
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future<AuthResult<UserModel>> signIn({required UserModel usuario}) async {
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: usuario.email!,
        password: usuario.password!,
      );
      final User? currentUser = result.user ?? auth.currentUser;
      if (currentUser != null) {
        final DocumentSnapshot docUser =
            await fireRef.doc(currentUser.uid).get();
        final UserModel userModel = UserModel.fromDocument(docUser);
        return AuthResult<UserModel>.success(userModel);
      } else {
        return AuthResult<UserModel>.error('Erro ao buscar usuário logado!');
      }
      // await _loadCurrentUser(firebaseUser: result.user);
    } on FirebaseAuthException catch (e) {
      return AuthResult.error(utilServices.getErrorString(e.code));
    }
  }

  Future<AuthResult<UserModel>> signUp({required UserModel usuario}) async {
    try {
      final resultEmail =
          await fireRef.where("email", isEqualTo: usuario.email).get();
      if (resultEmail.docs.isEmpty) {
        final UserCredential result = await auth.createUserWithEmailAndPassword(
          email: usuario.email!,
          password: usuario.password!,
        );
        usuario.id = result.user!.uid;
        addUser(user: usuario);
        return AuthResult<UserModel>.success(usuario);
      } else {
        return AuthResult.error('E-mail já está cadastrado!');
      }
    } on FirebaseAuthException catch (e) {
      return AuthResult.error(utilServices.getErrorString(e.code));
    }
  }
    Future<void> resetUser({required String email}) async {
      try {
            await auth.sendPasswordResetEmail(email: email);
      } catch (e) {
              // ignore: avoid_print
      print(e.toString()); 
      }
  }
}
