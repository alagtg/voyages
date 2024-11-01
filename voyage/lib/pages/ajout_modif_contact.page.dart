import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:voyage/model/contact.model.dart';
import 'package:voyage/services/contact.service.dart';

class AjoutModifContactPage extends StatefulWidget {
  AjoutModifContactPage({this.contact, this.modifMod = false});
  final Contact? contact;
  final bool modifMod;
  @override
  State<AjoutModifContactPage> createState() => _AjoutModifContactPageState();
}

class _AjoutModifContactPageState extends State<AjoutModifContactPage> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  Contact contact = Contact();
  ContactService contactService = ContactService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.modifMod
              ? 'Page Modifier Contact'
              : 'Page Ajouter Contact')),
      body: Form(
        child: _formUI(context),
        key: globalKey,
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FormHelper.submitButton(
              widget.modifMod ? "Modifier" : "Ajouter",
              () {
                if (validateAndSave()) {
                  if (widget.modifMod)
                    contactService
                        .ajouterContact(contact!)
                        .then((value) => Navigator.pop(context));
                  else
                    contactService
                        .ajouterContact(contact!)
                        .then((value) => Navigator.pop(context));
                }
              },
              borderColor: Colors.grey,
              btnColor: Colors.grey,
              borderRadius: 10,
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.modifMod) contact = widget.contact!;
  }

  _formUI(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              FormHelper.inputFieldWidgetWithLabel(context, "nom", "Nom", "",
                  (onValidate) {
                if (onValidate.isEmpty) {
                  return "* Required";
                }
                return null;
              }, (onSaved) {
                contact!.nom = onSaved.toString().trim();
              },
                  initialValue: widget.modifMod ? contact!.nom! : "",
                  showPrefixIcon: true,
                  prefixIcon: const Icon(Icons.text_fields),
                  borderRadius: 10,
                  contentPadding: 15,
                  fontSize: 14,
                  labelFontSize: 14,
                  paddingLeft: 0,
                  paddingRight: 0,
                  prefixIconPaddingLeft: 10),
              FormHelper.inputFieldWidgetWithLabel(
                  context, "telephone", "Téléphone", "", (onValidate) {
                if (onValidate.isEmpty) {
                  return "* Required";
                }
                return null;
              }, (onSaved) {
                contact!.tel = int.parse(onSaved.toString().trim());
              },
                  initialValue: widget.modifMod ? contact!.tel.toString() : "",
                  showPrefixIcon: true,
                  prefixIcon: const Icon(Icons.text_fields),
                  borderRadius: 10,
                  contentPadding: 15,
                  fontSize: 14,
                  labelFontSize: 14,
                  paddingLeft: 0,
                  paddingRight: 0,
                  prefixIconPaddingLeft: 10,
                  isNumeric: true)
            ],
          )),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
