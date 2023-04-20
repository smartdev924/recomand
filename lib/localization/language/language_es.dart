import 'languages.dart';

class LanguageEs extends Languages {
  // @override
  String get appName => "LocalService";
  // error

  String get kEmailNullError => "Por favor introduzca su correo electrónico";
  String get kInvalidEmailError =>
      "Por favor introduzca un correo electrónico válido";
  String get kPassNullError => "Por favor, introduzca su contraseña";
  String get kConfirmPasswordError => "Contraseña no coincidente";
  String get kShortPassError =>
      "La contraseña es demasiado corta, al menos 8 caracteres";
  String get kMatchPassError => "Las contraseñas no coinciden";
  String get kNameNullError => "Por favor ingresa tu nombre completo";
  String get kPhoneNumberNullError =>
      "Por favor, introduzca su número de teléfono";
  String get kAddressNullError => "Por favor Ingrese su dirección";
  String get kTitleNullError => "Por favor ingrese el título de su producto";
  String get kDescriptionNullError => "Por favor ingrese la descripción";
  String get kPriceNullError => "Por favor ingrese el precio";
  String get kDeadLineNullError => "Por favor, introduzca la fecha límite";

  //Splash screen, sign in, sign out, reset, etc - first screens
  String get slogan => '¡Hasta 7 ofertas con 1 pedido!';
  String get lab_continue => 'Continuar';
  String get signin => 'Registrarse';
  String get signup => 'Inscribirse';
  String get createaccount => 'Crear una cuenta';
  String get forgotpassword => 'Has olvidado tu contraseña';
  String get email => 'Correo electrónico';
  String get password => 'Clave';
  String get pleaseendteryouremail =>
      'Por favor introduzca su correo electrónico';
  String get pleaseenteryourpassword => 'Por favor, introduzca su contraseña';
  String get forgotpassword_description =>
      'Por favor, introduzca su dirección de correo electrónico. Recibirá un enlace para crear una nueva contraseña por correo electrónico.';
  String get lab_send => 'ENVIAR';
  String get changepassword => 'CAMBIA LA CONTRASEÑA';
  String get confirmpassword => 'Confirmar contraseña';
  String get resetpass_description =>
      'Introduzca la nueva contraseña y confirme.';
  String get resetpassword => 'Restablecer la contraseña';
  String get currentpassword => 'contraseña actual';
  String get enteryourcurrentpassword => 'introduce tu contraseña actual';
  String get newpassword => 'Nueva contraseña';
  String get enteryournewpassword => 'Introduzca su nueva contraseña';
  String get confirmnewpassword => 'Confirmar nueva contraseña';
  String get repeatyournewpassword => 'Repeat your new password';
  String get haveInvite => '¿Tienes un código de invitación?';
  String get inviteCode => 'Codigo de invitacion';
  String get inputCode => 'Por favor ingrese su código de invitación';
  String get name => 'Nombre';
  String get inputName => 'Por favor ingrese su nombre completo';
  String get workType => "TRABAJAR";
  String get hireType => "CONTRATAR";
  //Settings page
  String get lab_settings => "Ajustes";
  String get labelSelectLanguage => "Seleccione el idioma";
  String get labelLanguage => "Idioma";
  String get lab_colorstyle => 'Estilo de color';
  String get lab_changepassword => 'Cambia la contraseña';
  String get delete_account => "Borrar cuenta";

  //accountsetting page
  String get addproduct => 'Agregar producto';
  String get offersandpromos => 'Ofertas y Promociones';
  String get payments => 'Pagos';
  String get FAQ => 'Preguntas más frecuentes';
  String get paymentshistory => 'Historial de pagos';
  String get myproducts => 'Mis productos';
  String get notificaiton => 'Notificaciones';
  String get mysales => 'Mis ventas';
  String get myorders => 'Mis ordenes';
  String get favorites => 'Favoritos';
  String get signout => 'Desconectar';
  String get fromCamera => "De la cámara";
  String get fromFiles => "Desde archivos";
  String get switchToHire => "Cambiar a contratar";
  String get switchToWorker => "Cambiar a trabajador";
  //chatting room
  String get conversations => 'Conversaciones';
  String get nochattingroom => 'No hay salas de chat todavía';
  String get gohomepage => 'Ir a la página de inicio';
  String get goBrowserPage => "Explorar trabajo";

  String get cancel_btn => 'Cancelar';
  String get delete_btn => 'Borrar';
  String get areyousure => 'Estas seguro';
  String get delete_description =>
      'Esta sala se eliminará de forma permanente.';
  String get archiveroom => 'Archivar esta sala';
  String get deleteroom => 'Eliminar esta sala';

  //add product
  String get title => 'TÍTULO';
  String get description => 'DESCRIPCIÓN';
  String get price => 'PRECIO';
  String get next_btn => 'SIGUIENTE';

  //file
  String get publish_btn => 'PUBLICAR';
  String get backtohome => 'Volver a la página de inicio';
  String get copyClipboard => 'Copiado al portapapeles!';

  //add or remove product
  String get deleteImage => 'This image will be deleted.';

  //here is the new languages for local service app

  //browse request
  String get searchRequest => 'Buscar una solicitud';
  String get searchCategory => 'Search for a category';
  String get new_tab => 'Nuevo';
  String get active => 'Activo';
  String get previous => 'Previo';
  String get all => 'Todos';
  String get noItems => 'No hay artículos.';
  String get totalProposal => 'Propuesta total';
  String get selectedServices => ' servicios seleccionados';
  String get selectedCities => ' ciudades seleccionadas';
  //chat view
  String get unnamed => 'Sin nombre';
  String get depositCoins => 'Depositar ahora';
  String get requireCreditsDescription =>
      "Para poder ver las solicitudes de los clientes, debe tener al menos 1 crédito en su cuenta.";
  String get credits => "Créditos";

  //validation text

  String get integeronly => "Ingrese solo números enteros";
  String get filedMandatory => "Este campo es obligatorio";

  //hirestep 01
  String get serviceCall => 'El proveedor de servicios puede llamar';
  String get heading_request =>
      '¿Cuáles son los detalles de su solicitud de trabajo?';
  String get valid_question1 => '¿Algún otro detalle que veas relevante?';
  String get valid_question2 =>
      'Si no proporciona suficiente información. esto afectará la cantidad de cotizaciones que recibirá.';
  String get valid_question3 => 'Debe ingresar 100 letras por lo menos.';
  String get image_question => '¿Le gustaría agregar imágenes?';
  String get where_location => 'Dónde ? (Ubicación del trabajo)';
  String get location_validation =>
      'No podemos usar tu ubicación. Busque la ciudad o ingrese manualmente';
  String get userMyLocation => 'USAR MI UBICACIÓN';
  String get enterCity => 'Ingrese el nombre de su ciudad';
  String get when_job => 'Cuándo ? (fecha del trabajo)';
  String get answer_question => '¿Te gustaría responder a estas preguntas?';
  String get inputAnswer => 'Ingrese su respuesta aquí...';
  String get enterPhone => 'Introduce tu teléfono';
  String get phoneDescription =>
      'Nuestros profesionales pueden contactarlo más rápido si selecciona "El proveedor de servicios puede llamar".';
  String get enterPhoneNumber => 'Ingrese su número telefónico';
  String get sendRequest => 'ENVIAR PETICIÓN';
  String get alert_image => 'Sube al menos una imagen.';
  String get alert_description => 'Por favor ingrese la descripción.';
  String get alert_address => 'Por favor ingrese su dirección.';
  String get alert_one_option => 'Por favor selecciona una opcion.';
  String get alert_pick_date => 'Favor de recoger fecha.';
  String get alert_answer => 'Por favor conteste la pregunta';
  String get alert_phone => 'Por favor ingrese el número de teléfono.';
  String get request_success_msg => '¡Felicidades! ¡Has solicitado con éxito!';
  String get alert_close_description =>
      'Puede obtener cotizaciones gratis respondiendo algunas preguntas más.';
  String get go_on => 'CONTINUAR';
  String get quit => 'ABANDONAR';
  String get servicesCompanyReady => "Empresa de servicios lista";
  String get allow_contacts => "mostrar mi número de teléfono";
  String get dont_disturbme => "no me molestes";
  String get only_phone => "Contáctame solo por teléfono";
  String get only_offers => "Enviarme solo ofertas";
  String get only_whatsapp => "Contactame solo por whatsapp";

  //hire step 02
  String get alert_nocity =>
      'Lo sentimos, pero no podemos encontrar la ciudad que desea...';
  String get what_looking => 'Qué estás buscando';
  String get select_service => 'Seleccione tipo de servicio';
  String get remove_service => 'Eliminar este servicio';
  String get request_quote => 'Solicite 7 presupuestos gratuitos para';
  String get name_company => 'Nombre y apellidos (o empresa)';
  String get phone => 'Teléfono';
  String get search_city => 'Buscar una ciudad (Ingrese 3 letras por lo menos)';
  String get input_3 => 'Ingrese al menos 3 letras para buscar la ciudad';
  String get when_service => '¿Cuándo necesitas este servicio?';
  String get asap => 'Lo antes posible';
  String get flexible => 'Soy flexible';
  String get alert_name => 'Por favor ingrese nombre y apellido';
  String get alert_city => 'Por favor seleccione ciudad';
  String get request_success => 'Solicitud exitosa';
  String get tip_id => 'ID de la punta';
  String get success_thankyou =>
      'Gracias por elegir nuestro servicio y confianza para ayudarte con tus problemas';

  //home page
  String get hi => 'Hola';
  String get home_description =>
      'Busque varios expertos para resolver sus problemas. comienza a consultar ahora.';
  String get which_service => 'Qué servicios necesita ?';
  String get no_service => 'Sin servicios';

  // job detail
  String get no_city_info => 'Sin información de la ciudad';
  String get see_number => 'Ellos pueden llamar y ver mi numero';
  String get job_detail => 'Detalles del trabajo';
  String get aboutCustomer => "Acerca del cliente";
  String get receivedOffers => " Ofertas recibidas";
  String get noOffers => "No hay ofertas";
  String get reviews => "REVISIÓN";
  String get beFirstSend => "Sea el primero en enviar una oferta";

  //my account setting
  String get become_seller => 'Conviértase en vendedor';

  //my job offer
  String get job_offer => 'Ofertas de trabajo';
  String get deadline => 'Plazo';
  String get Price => 'Precio';
  String get no_proposal => 'Aún no hay propuestas.';
  String get update_offer => "oferta de actualización";
  //my job
  String get ACTIVE => 'ACTIVO';
  String get CANCELED => 'CANCELADO';
  String get Cancelled => 'Cancelado';
  String get my_jobs => 'Mis trabajos';
  String get card_onway =>
      '¡Las cotizaciones están en camino! Le informaremos cuando recibamos una cotización.';
  String get view_offer => 'Ver ofertas';
  String get see_details => 'VER DETALLES';
  String get cancel_request => 'CANCELAR PETICIÓN';

  //my request
  String get my_requests => 'Mis solicitudes';

  //order and pay
  String get oerder_pay => 'Ordena y paga';
  String get company_info => 'Información de la empresa';
  String get payment_method => 'Método de pago';
  String get credit_card => 'Tarjeta de crédito o débito';
  String get payment_bank => 'Pago por transferencia bancaria';
  String get request_10 => '10 solicitudes';
  String get subscription_desc =>
      '400 lei 360 lei/mes por 2 meses luego 400 lei/mes';
  String get paynow_01 => 'Paga ahora (primer mes): 428,40 lei (IVA incluido)';
  String get agree => 'Estoy de acuerdo con';
  String get terms_service => 'Términos y condiciones';
  String get payNow => 'PAGAR AHORA';
  String get name_company_02 => 'Su nombre o razón social';
  String get city => 'Ciudad';
  String get address => 'Dirección';

  //splash
  String get send_splash => 'Enviar una solicitud';
  String get receive_splash => 'Recibe hasta 17 ofertas';
  String get choose_splash => 'Elige el experto';

  //subscription
  String get choose_monthly => 'Elige suscripción mensual';
  String get sub_01 => '400 lei 360 lei/mes por 2 meses luego 400 lei/mes';
  String get on_average1 => 'De media, competirás con 3 profesionales.';
  String get no_contract =>
      'Sin periodo de contrato, puedes cancelar en cualquier momento';
  String get request_20 => '20 solicitudes';
  String get sub_02 => '800 lei 480 lei/mes por 2 meses luego 800 lei/mes';
  String get on_average2 => 'De media, competirás con 3 profesionales.';
  String get request_35 => '35 solicitudes';
  String get on_average3 => 'En promedio, competirás con 2 profesionales.';
  String get on_average4 =>
      'El precio medio por solicitud oscila entre 31,65 lei y 47,47 lei.';
  String get calc_description =>
      '*El número de solicitudes es orientativo y se calcula sobre la base del precio medio por solicitud. Los precios están detallados en la lista de precios.';

  //view service
  String get get_7 => 'Obtenga 7 Cotizaciones';

  //work step 1
  String get step1_des => '¿Qué servicios ofreces?';
  String get eliminate => 'Eliminar';
  String get step1_heading => '¿Qué servicios ofreces?';
  String get change_anytime => 'Usted puede cambiar esto en cualquier momento.';
  String get selected_service => 'Servicios seleccionados';
  String get alert_select_service =>
      '¡Seleccione el servicio de la lista a continuación para el siguiente paso!';

  //work step 2
  String get step2_heading => 'En que tipo de trabajo estas interesado?';

  //work step 3
  String get step3_heading => '¿En qué ciudad(es) trabajas como';
  String get selected_city => 'Ciudad(es) seleccionada(s)';
  String get alert_select_city =>
      'Debe seleccionar la ciudad para el siguiente paso';

  //country page
  String get ro => 'Rumania';
  String get de => 'Alemania';
  String get sp => 'España';
  String get fr => 'Francia';
  String get it => 'Italia';
  String get start => 'Comenzar';

  //missing
  String get selectCategory => 'SELECCIONA UNA CATEGORÍA';
  String get filters => 'filtros';
  String get priority => 'PRIORIDAD';
  String get search => 'Búsqueda';
  String get category => 'CATEGORÍA';

  String get buyCredits => 'Compra creditos';
  String get countryHeading => 'Por favor seleccione su país';
  String get creditHistory => 'Historial de crédito';
  String get ID => 'IDENTIFICACIÓN';
  String get amount => 'Monto';
  String get date => 'Fecha';
  String get noCredit => 'Sin historial crediticio';
  String get Congratulation => 'Felicitaciones';
  String get requestPriority => 'Solicitud de prioridad';
  String get acceptPolicy =>
      'Acepto el contrato de usuario y privacidad presionando “ENVIAR SOLICITUD”';
  String get willNotify =>
      'Le notificaremos por correo electrónico y sms cuando su solicitud reciba cotizaciones de profesionales.';
  String get receivedRequest => '¡Recibimos tu solicitud!';
  String get free => 'Gratis';
  String get priceCoins => 'PRECIO MONEDAS';
  String get type => 'ESCRIBE';
  String get planSelect =>
      'Elige tu plan de pago de acuerdo a la velocidad a la que necesitas encontrar expertos.';
  String get canceledRequest => '¡Has cancelado esta solicitud!';
  String get reasonSelect => 'Seleccione uno de los siguientes motivos.';
  String get reason_1 => 'Acuerdo con una oferta fuera de este sitio web.';
  String get reason_2 => 'Las tarifas son demasiado altas.';
  String get reason_3 => 'No estoy seguro acerca de la calidad.';
  String get reason_4 => 'No hay suficientes ofertas.';
  String get reason_5 => 'No pude obtener respuestas a mis consultas.';
  String get reason_6 => 'Yo no tumbona requiero este servicio';
  String get unlockedReq => '¡Has desbloqueado esta solicitud!';
  String get sureUnlock => '¿Estás seguro de desbloquear esta solicitud?';
  String get activeStatus => 'Estado: Activo';
  String get offers => 'OFERTAS';
  String get viewOffers => 'VER OFERTAS';
  String get jobID => 'IDENTIFICACIÓN DEL TRABAJO';
  String get unlockReq => 'Solicitud de desbloqueo';
  String get sendOffer => 'Enviar oferta';

  //my account
  String get myaccount => 'Mi cuenta';
  String get myDetails => 'Mis detalles';
  String get successUpdated => '¡Actualizado exitosamente!';
  String get imageSelectAlert => 'imagen no seleccionada';
  String get coins => 'monedas';
  String get myOffers => 'Mis ofertas';
  String get myservices => 'Mis servicios';
  String get offer => 'OFERTA';
  String get noJobs => 'AQUÍ NO HAY TRABAJO';
  String get noRequestDesc =>
      'No tiene ningún trabajo solicitado.\nSolicite el servicio que desea, ¡obtenga cotizaciones gratis!';

  String get browseServices => 'BUSCAR SERVICIOS';
  String get c_reason_1 => 'Cambié de opinión sobre el servicio.';
  String get c_reason_2 => 'Estoy ocupado con otro trabajo.';
  String get c_reason_3 => 'no me gusta el cliente';
  String get c_reason_4 => 'No es hora de trabajar.';
  String get c_reason_5 => 'Sin razón.';
  String get cancelOffer => 'Cancelar oferta';
  String get pauseReq => 'SOLICITUD DE PAUSA';
  String get cancelledOffer => '¡Has cancelado esta oferta!';
  String get startFrom => 'EMPEZAR DESDE';
  String get save => "Salvar";

  String get services => 'Servicios';
  String get cities => 'Ciudades';
  String get noService => '¡Sin servicios!';
  String get noServicesDesc =>
      'Aún no tiene ningún servicio.\nAgregue servicios si desea comenzar a ganar.';
  String get noCity => '¡Sin Ciudades!';
  String get noCityDesc =>
      'Aún no tienes ninguna ciudad.\nAgrega ciudades si quieres comenzar a ganar.';
  String get addService => 'Agregar servicio';
  String get searchService => 'Servicio de búsqueda';
  String get myServices => 'Mis servicios';
  String get myCities => 'mis ciudades';
  String get addCity => 'Añadir ciudad';
  String get searchCity => 'Buscar ciudad';

  String get newOffer => 'Nueva oferta';
  String get offerType => 'TIPO DE OFERTA';
  String get offerDescriptionHint =>
      "Muestre al cliente que comprende sus necesidades. Haz una oferta especial. Dile qué te hace diferente y por qué puede confiar en ti.";
  String get sentOffer => '¡Enviaste oferta!';
  String get updatedOffer => 'Has actualizado oferta!';
  String get noNotification => '¡No Notificaciones!';
  String get notificationDesc =>
      'Todavía no tienes ninguna notificación. Por favor haga su pedido';

  String get creditCard => 'Tarjeta de crédito';
  String get bank => 'Banco';
  String get proposalReq => 'Solicitud de propuestas';

  String get BECOME_SELLER => 'CONVIÉRTETE EN VENDEDOR';
  String get verifyCode => 'Código de verificación';
  String get codeVerifyDesc =>
      'Acabamos de enviarle un código de verificación. Revisa tu bandeja de entrada para obtenerlos.';
  String get resend_code => 'Reenviar código en';
  String get avg_rating => 'Puntuación media';
  String get verify_review => 'reseñas verificadas';

  String get noSearchResult => 'Sin resultado de búsqueda';
  String get inputThree => 'Por favor ingrese al menos 3 letras';

  String get nojobreq => 'No hay solicitud de trabajo.';
  String get nojobreq_des =>
      'No hay solicitud de empleo para sus servicios. Te enviaremos notificaciones cuando aparezcan nuevas solicitudes de tus servicios.';

  String get serviceReady => 'Empresa de servicios lista';
  String get everyear => 'Todos los años';
  String get peopleTrust => 'la gente confía en Servicios Locales para';

  //redeem code section
  String get redeemVoucher => 'CANJEAR CUPÓN';
  String get redeemAction => 'Este código se aplicará a su cuenta.';
  String get codeInvaild => 'El código ingresado no es válido.';
  String get couponSuccess => 'Código de cupón aplicado con éxito a su cuenta.';
  String get cousherCode => 'Código de cupón';
  String get tryAgain => 'INTENTAR OTRA VEZ';
  String get addNew => 'AÑADIR NUEVO';
  String get addBtn => 'AÑADIR';
  String get apply => 'SOLICITAR';
  String get haveRedeemCode => '¿Tienes un código de canje?';
  String get paymentMethod => 'Método de pago';

  String get specificTime => 'Tiempo específico (dentro de tres semanas)';
  String get inTwoMonth => 'En dos meses';
  String get inSixMonth => 'en seis meses';
  String get onlyPrice => 'Solo busco precio';
  String get flexibleTime => 'Flexible';
  String get allContact => 'Permitir contactos';
  String get onlyOffers => 'Solo Ofertas';
  String get onlyPhone => 'solo telefono';
  String get onlyWhatsapp => 'Solo WhatsApp';
  String get notDisturb => 'no me molestes';

  String get processing => "Procesando";
  String get thankyou => "Gracias";
  //become a seller
  String get companyNameHint => 'Nombre de la empresa o Nombre personal';
  String get companyNumberHint => 'Número de empresa o número personal';
  String get profileDescriptionHint => "Descripción del perfil";
  String get companyNameValidateError =>
      "Ingrese la empresa o el nombre personal";
  String get companyNumberValidateError =>
      "Ingrese la empresa o el número personal";
  String get profileDescriptionValidateError =>
      "Ingrese la descripción del perfil";
  String get addressValidateError => "Por favor ingrese la dirección";
  String get phoneValidateError => "Por favor ingrese el teléfono";
  String get optional => "(OPCIONAL)";
  String get becomeSellerApproved =>
      "Su solicitud para convertirse en vendedor ha sido enviada.";
  String get private => "PRIVADO";
  String get company => "EMPRESA";
  String get close => "CERCA";

  //other
  String get call => "LLAMADA";
  String get skip => "SALTAR";
  String get chat => "CHAT";
  String get seeAll => "VER TODO";
  String get award => "PREMIO";
  String get noPhoneNumber => "La Usuario no tiene número de teléfono.";
  String get about => "Acerca de";
  String get photos => "Fotos";
  String get feedBacks => "Comentarios";
  String get contact => "Contacto";
  String get favorite => "Favorito";
  String get share => "Cuota";
  String get clientMode => "Modo cliente";
  String get providerMode => "Modo proveedor";
  String get addButton => "Agregar";
  String get backButton => "Atrás";
  String get addSucceed => "Añadida exitosamente";

  // write review
  String get howWasService =>
      "¿Cómo fue el servicio que recibiste? \n¿Está satisfecho?";
  String get writeReview => "Escribe tu reseña";
  String get keepMeReviewHidden => "Mantener mi reseña oculta";
  String get inputReviewError => "Por favor ingrese su revisión";
  String get reviewedSuccess => "Su revisión con éxito";

  String get pleaseSelectReason => "Seleccione una de las siguientes razones.";
  String get confirm => "Confirmar";
  String get cancelRequestReason1 =>
      "Acuerdo con una oferta fuera de este sitio web.";
  String get cancelRequestReason2 => "Las tarifas son demasiado altas.";
  String get cancelRequestReason3 => "No estoy seguro acerca de la calidad.";
  String get cancelRequestReason4 => "No hay suficientes ofertas.";
  String get cancelRequestReason5 =>
      "No pude obtener respuestas a mis consultas.";
  String get cancelRequestReason6 => "Yo no tumbona requiero este servicio";
  String get minute => 'minuto';
  String get minutes => 'minutos';
  String get day => 'día';
  String get days => 'días';
  String get month => 'mes';
  String get months => 'meses';
  String get ago => 'atrás';
  String get hour => "hora";
  String get hours => "horas";
  String get headStringRegistered => 'registrado hace';
  String get tailStringRegistered => '';
  String get high => "alto";
  String get iWant => "Quiero";
  String get total => "total";
  String get availableFrom => "Disponible de";
  String get deadLineHint => 'en 5 dias';

  //chat widget
  String get typing => 'mecanografía';
  String get online => 'en línea';
  String get offline => 'desconectado';
  String get connecting => 'Conectando';
  String get joinRoom => 'Unirse a la habitación';
  String get hintTextMessage => "mensaje";
  String get fullScreen => "Pantalla completa";
  String get noOffersDesc =>
      "Todavía no tiene ninguna oferta. Vaya ahora a la página de solicitudes y envíe ofertas según las solicitudes de los clientes.";
}
