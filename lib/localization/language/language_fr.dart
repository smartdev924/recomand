import 'languages.dart';

class LanguageFr extends Languages {
  // @override
  String get appName => "LocalService";
// error

  String get kEmailNullError => "Veuillez saisir votre e-mail";
  String get kInvalidEmailError => "Veuillez saisir une adresse e-mail valide";
  String get kPassNullError => "S'il vous plait entrez votre mot de passe";
  String get kConfirmPasswordError => "Mot de passe incompatible";
  String get kShortPassError =>
      "Le mot de passe est trop court, au moins 8 caractères";
  String get kMatchPassError => "Les mots de passe ne correspondent pas";
  String get kNameNullError => "S'il vous plait entrez votre nom entier";
  String get kPhoneNumberNullError =>
      "Veuillez entrer votre numéro de téléphone";
  String get kAddressNullError => "Veuillez entrer votre adresse";
  String get kTitleNullError => "Veuillez entrer le titre de votre produit";
  String get kDescriptionNullError => "Veuillez entrer la description";
  String get kPriceNullError => "Veuillez entrer le prix";
  String get kDeadLineNullError => "Veuillez saisir la date limite";

  //Splash screen, sign in, sign out, reset, etc - first screens
  String get slogan => 'Jusqu\'à 7 offres avec 1 demande !';
  String get lab_continue => 'Continuer';
  String get signin => "S\'identifier";
  String get signup => "S\'inscrire";
  String get createaccount => 'Créer un compte';
  String get forgotpassword => 'Mot de passe oublié';
  String get email => 'E-mail';
  String get password => 'Mot de passe';
  String get pleaseendteryouremail => 'Veuillez saisir votre e-mail';
  String get pleaseenteryourpassword =>
      's\'il vous plait entrez votre mot de passe';
  String get forgotpassword_description =>
      'Veuillez saisir votre adresse e-mail. Vous recevrez un lien pour créer un nouveau mot de passe par e-mail.';
  String get lab_send => 'ENVOYER';
  String get changepassword => 'CHANGER LE MOT DE PASSE';
  String get confirmpassword => 'Confirmez le mot de passe';
  String get resetpass_description =>
      'Entrez le nouveau mot de passe et confirmez.';
  String get resetpassword => 'réinitialiser le mot de passe';
  String get currentpassword => 'Mot de passe actuel';
  String get enteryourcurrentpassword => 'Entrer votre mot de passe actuel';
  String get newpassword => 'Nouveau mot de passe';
  String get enteryournewpassword => 'Entrez votre nouveau mot de passe';
  String get confirmnewpassword => 'Confirmer le nouveau mot de passe';
  String get repeatyournewpassword => 'Répétez votre nouveau mot de passe';
  String get haveInvite => 'Vous avez un code d\'invitation ?';
  String get inviteCode => 'Code d\'invitation';
  String get inputCode => 'Veuillez entrer votre code d\'invitation';
  String get name => 'Nom';
  String get inputName => 'Veuillez entrer votre nom complet';
  String get workType => "TRAVAIL";
  String get hireType => "LOUER";
  //Settings page
  String get lab_settings => "Réglages";
  String get labelSelectLanguage => "Choisir la langue";
  String get labelLanguage => "Langue";
  String get lab_colorstyle => 'Style de couleur';
  String get lab_changepassword => 'Changer le mot de passe';
  String get delete_account => "Supprimer le compte";

  //accountsetting page
  String get addproduct => 'Ajouter un produit';
  String get offersandpromos => 'Offres et promotions';
  String get payments => 'Paiements';
  String get FAQ => 'FAQ';
  String get paymentshistory => 'Historique des paiements';
  String get myproducts => 'Mes produits';
  String get notificaiton => 'Avis';
  String get mysales => 'Mes ventes';
  String get myorders => 'Mes commandes';
  String get favorites => 'Favoris';
  String get signout => 'Se déconnecter';
  String get fromCamera => "De la caméra";
  String get fromFiles => "De la caméra";
  String get switchToHire => "Passer à l'embauche";
  String get switchToWorker => "Basculer vers Worker";

  //chatting room
  String get conversations => 'Conversations';
  String get nochattingroom => 'Pas encore de chatrooms';
  String get gohomepage => 'Aller à la page d\'accueil';
  String get goBrowserPage => "Parcourir l'emploi";
  String get cancel_btn => 'Annuler';
  String get delete_btn => 'Effacer';
  String get areyousure => 'Êtes-vous sûr ?';
  String get delete_description => 'Cette salle sera définitivement supprimée.';
  String get archiveroom => 'Archiver cette salle';
  String get deleteroom => 'Supprimer cette salle';

  //add product
  String get title => 'TITRE';
  String get description => 'LA DESCRIPTION';
  String get price => 'LE PRIX';
  String get next_btn => 'SUIVANT';

  //file
  String get publish_btn => 'PUBLIER';
  String get backtohome => 'Retour à la page d\'accueil';
  String get copyClipboard => 'Copié dans le presse-papier!';

  //add or remove product
  String get deleteImage => 'Cette image sera supprimée.';

  //browse request
  String get searchRequest => 'Rechercher une demande';
  String get searchCategory => 'Rechercher une catégorie';
  String get new_tab => 'Nouveau';
  String get active => 'Actif';
  String get previous => 'Précédent';
  String get all => 'Tout';
  String get noItems => 'Il n\'y a pas d\'articles.';
  String get totalProposal => 'Proposition totale';
  String get selectedServices => ' prestations sélectionnées';
  String get selectedCities => ' villes sélectionnées';
  String get depositCoins => 'Déposez maintenant';
  String get requireCreditsDescription =>
      "Pour pouvoir voir les demandes des clients, vous devez avoir au moins 1 crédit sur votre compte.";
  String get credits => "Crédits";
  //chat view
  String get unnamed => 'Anonyme';

  //validation text

  String get integeronly => "Veuillez saisir uniquement un nombre entier";
  String get filedMandatory => "Ce champ est obligatoire";

  //hirestep 01
  String get serviceCall => 'Le fournisseur de services peut appeler';
  String get heading_request =>
      'Quels sont les détails de votre demande d\'emploi ?';
  String get valid_question1 => 'D\'autres détails que vous jugez pertinents ?';
  String get valid_question2 =>
      'Si vous ne fournissez pas suffisamment d\'informations. cela affectera le nombre de devis que vous recevrez.';
  String get valid_question3 => 'Vous devez saisir au moins 100 lettres.';
  String get image_question => 'Souhaitez-vous ajouter des images ?';
  String get where_location => 'Où ? (Lieu du travail)';
  String get location_validation =>
      'Nous ne pouvons pas utiliser votre emplacement. Veuillez rechercher la ville ou saisir manuellement';
  String get userMyLocation => 'UTILISE MA LOCATION';
  String get enterCity => 'Entrez le nom de votre ville';
  String get when_job => 'Lorsque ? (date du travail)';
  String get answer_question => 'Souhaitez-vous répondre à ces questions ?';
  String get inputAnswer => 'Entrez votre réponse ici...';
  String get enterPhone => 'Entrez votre téléphone';
  String get phoneDescription =>
      'Nos pros con vous contactent plus rapidement si vous sélectionnez "Le fournisseur de services peut appeler".';
  String get enterPhoneNumber => 'Entrez votre numéro de téléphone';
  String get sendRequest => 'ENVOYER UNE DEMANDE';
  String get alert_image => 'Veuillez télécharger au moins une image.';
  String get alert_description => 'Veuillez saisir une description.';
  String get alert_address => 'Veuillez entrer votre adresse.';
  String get alert_one_option => 'Veuillez sélectionner une option.';
  String get alert_pick_date => 'Veuillez prendre la date.';
  String get alert_answer => 'Veuillez répondre à la question';
  String get alert_phone => 'Veuillez entrer le numéro de téléphone.';
  String get request_success_msg =>
      'Félicitations ! Vous avez demandé avec succès !';
  String get alert_close_description =>
      'Vous pouvez obtenir des devis gratuits en répondant à quelques questions supplémentaires.';
  String get go_on => 'CONTINUE';
  String get quit => 'QUITTER';
  String get servicesCompanyReady => "Société de services prête";
  String get allow_contacts => "Afficher mon numéro de téléphone";
  String get dont_disturbme => "Ne me dérange pas";
  String get only_phone => "Me contacter uniquement par téléphone";
  String get only_offers => "Envoyez-moi uniquement des offres";
  String get only_whatsapp => "Contactez-moi uniquement par WhatsApp";

  //hire step 02
  String get alert_nocity =>
      'Désolé mais nous ne pouvons pas trouver la ville que vous voulez...';
  String get what_looking => 'Que cherchez-vous';
  String get select_service => 'Sélectionnez le type de service';
  String get remove_service => 'Supprimer ce service';
  String get request_quote => 'Demandez 7 devis gratuits pour';
  String get name_company => 'Nom et prénom (ou société)';
  String get phone => 'Téléphoner';
  String get search_city =>
      'Rechercher une ville (Saisissez au moins 3 lettres)';
  String get input_3 =>
      'Veuillez saisir au moins 3 lettres pour rechercher la ville';
  String get when_service => 'Quand avez-vous besoin de ce service';
  String get asap => 'Dès que possible';
  String get flexible => 'Je suis flexible';
  String get alert_name => 'Veuillez saisir le nom et le prénom';
  String get alert_city => 'Veuillez sélectionner la ville';
  String get request_success => 'Demande réussie';
  String get tip_id => 'ID de pourboire';
  String get success_thankyou =>
      'Merci d\'avoir choisi notre service et confiance pour vous aider avec vos problèmes';

  //home page
  String get hi => 'Salut';
  String get home_description =>
      'Parcourez le nombre d\'experts pour résoudre vos problèmes. commencer à consulter maintenant.';
  String get which_service => 'De quels services avez-vous besoin ?';
  String get no_service => 'Aucun service';

  // job detail
  String get no_city_info => 'Aucune information sur la ville';
  String get see_number => 'Ils peuvent appeler et voir mon numéro';
  String get job_detail => 'Détails du poste';

  String get aboutCustomer => "À propos du client";
  String get receivedOffers => " Offres reçues";
  String get noOffers => "Aucune offre";
  String get reviews => "REVOIR";
  String get beFirstSend => "Soyez le premier à envoyer une offre";

  //my account setting
  String get become_seller => 'Devenez vendeur';

  //my job offer
  String get job_offer => 'Offres d\'emplois';
  String get deadline => 'Date limite';
  String get Price => 'Prix';
  String get no_proposal => 'Il n\'y a pas encore de propositions.';
  String get update_offer => "offre de mise à jour";

  //my job
  String get ACTIVE => 'ACTIVE';
  String get CANCELED => 'ANNULÉ';
  String get Cancelled => 'Annulé';
  String get my_jobs => 'Mes travaux';
  String get card_onway =>
      'Les devis sont en route ! Nous vous informerons lorsqu\'un devis sera reçu.';
  String get view_offer => 'Voir les offres';
  String get see_details => 'VOIR LES DÉTAILS';
  String get cancel_request => 'DEMANDE D\'ANNULATION';

  //my request
  String get my_requests => 'Mes demandes';

  //order and pay
  String get oerder_pay => 'Commandez et payez';
  String get company_info => 'Informations sur la société';
  String get payment_method => 'Mode de paiement';
  String get credit_card => 'carte de crédit ou de débit';
  String get payment_bank => 'Paiement par virement bancaire';
  String get request_10 => '10 requêtes';
  String get subscription_desc =>
      '400 lei 360 lei/mois pendant 2 mois puis 400 lei/mois';
  String get paynow_01 =>
      'Payez maintenant (premier mois): 428,40 lei (TVA incluse)';
  String get agree => 'Je suis d\'accord avec';
  String get terms_service => 'Termenii și condițiile';
  String get payNow => 'PAYEZ MAINTENANT';
  String get name_company_02 => 'Votre nom ou raison sociale';
  String get city => 'Ville';
  String get address => 'Adresse';

  //splash
  String get send_splash => 'Envoyer une demande';
  String get receive_splash => 'Recevez jusqu\'à 17 offres';
  String get choose_splash => 'Choisissez l\'expert';

  //subscription
  String get choose_monthly => 'Optez pour un abonnement mensuel';
  String get sub_01 => '400 lei 360 lei/mois pendant 2 mois puis 400 lei/mois';
  String get on_average1 =>
      'En moyenne, vous serez en concurrence avec 3 professionnels.';
  String get no_contract =>
      'Aucune durée de contrat, vous pouvez résilier à tout moment';
  String get request_20 => '20 demandes';
  String get sub_02 => '800 lei 480 lei/mois pendant 2 mois puis 800 lei/mois';
  String get on_average2 =>
      'En moyenne, vous serez en concurrence avec 3 professionnels.';
  String get request_35 => '35 demandes';
  String get on_average3 =>
      'En moyenne, vous serez en concurrence avec 2 professionnels.';
  String get on_average4 =>
      'Le prix moyen par demande se situe entre 31,65 lei et 47,47 lei.';
  String get calc_description =>
      '*Le nombre de demandes est indicatif et est calculé sur la base du prix moyen par demande. Les prix sont détaillés dans la liste des prix.';

  //view service
  String get get_7 => 'Obtenez 7 devis';

  //work step 1
  String get step1_des => 'Quels services offrez-vous?';
  String get eliminate => 'Éliminer';
  String get step1_heading => 'Quels services offrez-vous?';
  String get change_anytime => 'Vous pouvez changer cela à tout moment.';
  String get selected_service => 'Prestations sélectionnées';
  String get alert_select_service =>
      'Veuillez sélectionner le service dans la liste ci-dessous pour la prochaine étape !';

  //work step 2
  String get step2_heading => 'Quel type de travail vous intéresse?';

  //work step 3
  String get step3_heading =>
      'Dans quelle(s) ville(s) travaillez-vous en tant que';
  String get selected_city => 'Ville(s) sélectionnée(s)';
  String get alert_select_city =>
      'Vous devez sélectionner la ville pour la prochaine étape';

  //country page
  String get ro => 'Roumanie';
  String get de => 'Allemagne';
  String get sp => 'Espagne';
  String get fr => 'France';
  String get it => 'Italie';
  String get start => 'Démarrer';

  //missing
  String get selectCategory => 'CHOISIR UNE CATÉGORIE';
  String get filters => 'Filtres';
  String get priority => 'PRIORITÉ';
  String get search => 'Chercher';
  String get category => 'CATÉGORIE';

  String get buyCredits => 'Acheter des crédits';
  String get countryHeading => 'S\'il vous plaît sélectionnez votre pays';
  String get creditHistory => 'Histoire de credit';
  String get ID => 'IDENTIFIANT';
  String get amount => 'Quantité';
  String get date => 'Date';
  String get noCredit => 'Aucun historique de crédit';
  String get Congratulation => 'Félicitation';
  String get requestPriority => 'Priorité de la demande';
  String get acceptPolicy =>
      'I accept user and accord de confidentialité en appuyant sur "ENVOYER LA DEMANDE"';
  String get willNotify =>
      'We will notify you par mail et sms lorsque votre demande reçoit des devis de pros.';
  String get receivedRequest => 'Nous avons bien reçu votre demande !';
  String get free => 'Libérer';
  String get priceCoins => 'PIÈCES DE PRIX';
  String get type => 'TAPER';
  String get planSelect =>
      'Choose your payment plan  selon la vitesse à laquelle vous devez trouver des experts.';
  String get canceledRequest => 'Vous avez annulé cette demande !';
  String get reasonSelect =>
      'Veuillez sélectionner l\'une des raisons ci-dessous.';
  String get reason_1 => 'J\'ai accepté une offre en dehors de ce site Web.';
  String get reason_2 => 'Les tarifs sont trop élevés.';
  String get reason_3 => 'Pas sûr de la qualité.';
  String get reason_4 => 'Pas assez d\'offres.';
  String get reason_5 => 'Impossible d\'obtenir des réponses à mes questions.';
  String get reason_6 => 'Je n\'ai pas besoin de ce service';
  String get unlockedReq => 'Vous avez déverrouillé cette demande !';
  String get sureUnlock => 'Êtes-vous sûr de déverrouiller cette demande ?';
  String get activeStatus => 'Statut : ACTIF';
  String get offers => 'DES OFFRES';
  String get viewOffers => 'VOIR LES OFFRES';
  String get jobID => 'ID DE TRAVAIL';
  String get unlockReq => 'Déverrouiller la demande';
  String get sendOffer => 'Envoyer une offre';

  //my account
  String get myaccount => 'Mon compte';
  String get myDetails => 'Mes Details';
  String get successUpdated => 'Mise à jour réussie!';
  String get imageSelectAlert => 'image non sélectionnée';
  String get coins => 'pièces';
  String get myOffers => 'Mes offres';
  String get myservices => 'Mes services';
  String get offer => 'OFFRIR';
  String get noJobs => 'PAS DES EMPLOIS ICI';
  String get noRequestDesc =>
      'You don’t have any travail demandé.\nDemandez le service que vous souhaitez, obtenez des devis gratuits !';

  String get browseServices => 'PARCOURIR LES SERVICES';
  String get c_reason_1 => 'J\'ai changé d\'avis sur le service.';
  String get c_reason_2 => 'Je suis occupé par d\'autres travaux.';
  String get c_reason_3 => 'je n\'aime pas le client';
  String get c_reason_4 => 'Pas le temps de travailler.';
  String get c_reason_5 => 'Sans raison.';
  String get cancelOffer => 'Annuler l\'offre';
  String get pauseReq => 'DEMANDE DE PAUSE';
  String get cancelledOffer => 'Vous avez annulé cette offre !';
  String get startFrom => 'COMMENCER À PARTIR DE';
  String get save => "Sauver";

  String get services => 'Prestations de service';
  String get cities => 'Villes';
  String get noService => 'Aucun service !';
  String get noServicesDesc =>
      'You don\'t have n\'importe quel service pour le moment.\nVeuillez ajouter des services si vous souhaitez commencer à gagner.';
  String get noCity => 'Pas de Villes !';
  String get noCityDesc =>
      'You don\'t have toutes les villes pour le moment.\nVeuillez ajouter des villes si vous souhaitez commencer à gagner.';
  String get addService => 'Ajouter un service';
  String get searchService => 'Service de recherche';
  String get myServices => 'Mes services';
  String get myCities => 'Mes villes';
  String get addCity => 'Ajouter une ville';
  String get searchCity => 'Rechercher une ville';

  String get newOffer => 'Nouvelle offre';
  String get offerType => 'TYPE D\'OFFRE';
  String get offerDescriptionHint =>
      "Montrez au client que vous comprenez ses besoins. Faire une offre spéciale. Dites-lui ce qui vous rend différent et pourquoi il peut vous faire confiance.";
  String get sentOffer => 'Vous avez envoyé une offre !';
  String get updatedOffer => 'Votre offre mise à jour !';
  String get noNotification => 'Aucune notification!';
  String get notificationDesc =>
      'You dont have any notification encore. Veuillez passer commande';

  String get creditCard => 'Carte de crédit';
  String get bank => 'Banque';
  String get proposalReq => 'Demande de propositions';

  String get BECOME_SELLER => 'DEVENEZ VENDEUR';
  String get verifyCode => 'Le code de vérification';
  String get codeVerifyDesc =>
      'We just send you un code de vérification. Vérifiez votre boîte de réception pour les obtenir.';
  String get resend_code => 'Renvoyer le code dans';
  String get avg_rating => 'note moyenne';
  String get verify_review => 'avis vérifiés';

  String get noSearchResult => 'Aucun résultat de recherche';
  String get inputThree => 'Veuillez saisir au moins 3 lettres';

  String get nojobreq => 'Aucune demande d\'emploi.';
  String get nojobreq_des =>
      'Aucune demande d\'emploi pour vos services. Nous vous enverrons des notifications lorsque de nouvelles demandes pour vos services apparaîtront.';

  String get serviceReady => 'Société de services prête';
  String get everyear => 'Chaque année';
  String get peopleTrust => 'personnes font confiance à Local Services pour';

  //redeem code section
  String get redeemVoucher => 'UTILISER LE BON';
  String get redeemAction => 'Ce code sera appliqué à votre compte.';
  String get codeInvaild => 'Le code saisi n\'est pas valide.';
  String get couponSuccess =>
      'Code de coupon appliqué avec succès à votre compte.';
  String get cousherCode => 'Votre code';
  String get tryAgain => 'RÉESSAYER';
  String get addNew => 'AJOUTER NOUVEAU';
  String get addBtn => 'AJOUTER';
  String get apply => 'APPLIQUER';
  String get haveRedeemCode => 'Avez-vous un code d\'échange ?';
  String get paymentMethod => 'Mode de paiement';

  String get specificTime => 'Moment précis (dans les trois semaines)';
  String get inTwoMonth => 'Dans deux mois';
  String get inSixMonth => 'Dans six mois';
  String get onlyPrice => 'Je cherche juste le prix';
  String get flexibleTime => 'Flexible';
  String get allContact => 'Autoriser les contacts';
  String get onlyOffers => 'Uniquement les offres';
  String get onlyPhone => 'Téléphone uniquement';
  String get onlyWhatsapp => 'Seulement Whatsapp';
  String get notDisturb => 'Ne me dérange pas';

  String get processing => "En traitement";
  String get thankyou => "Merci";
  //become a seller
  String get companyNameHint => 'Nom de l\'entreprise ou nom personnel';
  String get companyNumberHint => 'Numéro d\'entreprise ou numéro personnel';
  String get profileDescriptionHint => "Description du profil";
  String get companyNameValidateError =>
      "Veuillez saisir l'entreprise ou le nom personnel";
  String get companyNumberValidateError =>
      "Veuillez saisir le numéro d'entreprise ou personnel";
  String get profileDescriptionValidateError =>
      "Veuillez saisir la description du profil";
  String get addressValidateError => "Veuillez entrer l'adresse";
  String get phoneValidateError => "Veuillez entrer le téléphone";
  String get optional => "(OPTIONNEL)";
  String get becomeSellerApproved =>
      "Votre candidature pour devenir vendeur a été soumise.";
  String get private => "PRIVÉ";
  String get company => "COMPAGNIE";
  String get close => "FERMER";

  //other
  String get call => "APPEL";
  String get skip => "SAUTER";
  String get chat => "DISCUTER";
  String get seeAll => "VOIR TOUT";
  String get award => "PRIX";
  String get noPhoneNumber => "Le Utilisateur n'a pas de numéro de téléphone.";
  String get about => "Acerca de";
  String get photos => "Fotos";
  String get feedBacks => "Comentarios";
  String get contact => "Contacter";
  String get favorite => "Préféré";
  String get share => "Partager";
  String get clientMode => "Mode client";
  String get providerMode => "Mode fournisseur";
  String get addButton => "Ajouter";
  String get backButton => "Dos";
  String get addSucceed => "Ajouté avec succès";
  // write review
  String get howWasService =>
      "Comment avez-vous reçu le service ? \nÊtes-vous satisfait ?";
  String get writeReview => "Donnez votre avis";
  String get keepMeReviewHidden => "Garder mon avis caché";
  String get inputReviewError => "Veuillez saisir votre avis";
  String get reviewedSuccess => "Votre évaluation a réussi";

  String get pleaseSelectReason =>
      "Veuillez sélectionner l'une des raisons ci-dessous.";
  String get confirm => "Confirmer";
  String get cancelRequestReason1 =>
      "J'ai accepté une offre en dehors de ce site Web.";
  String get cancelRequestReason2 => "Les tarifs sont trop élevés.";
  String get cancelRequestReason3 => "Pas sûr de la qualité.";
  String get cancelRequestReason4 => "Pas assez d'offres.";
  String get cancelRequestReason5 =>
      "Impossible d'obtenir des réponses à mes questions.";
  String get cancelRequestReason6 => "Je n'ai pas besoin de ce service";
  String get minute => 'minute ';
  String get minutes => 'minutes ';
  String get day => 'jour ';
  String get days => 'jours ';
  String get month => 'mois ';
  String get months => 'mois ';
  String get ago => 'il y a ';
  String get hour => "heure";
  String get hours => "heures";
  String get headStringRegistered => 'inscrit il y a';
  String get tailStringRegistered => '';
  String get high => "haut";
  String get iWant => "Je veux";
  String get total => "total";
  String get availableFrom => "Disponible depuis";
  String get deadLineHint => 'dans 5 jours';

  //chat widget
  String get typing => 'dactylographie';
  String get online => 'en ligne';
  String get offline => 'hors ligne';
  String get connecting => 'De liaison';
  String get joinRoom => 'Rejoindre la chambre';
  String get hintTextMessage => "message";
  String get fullScreen => "Plein écran";
  String get noOffersDesc =>
      "Vous n'avez pas encore d'offres. Accédez maintenant à la page des demandes et envoyez des offres sur les demandes des clients.";
}
