import 'languages.dart';

class LanguageRu extends Languages {
  // @override
  String get appName => "LocalService";
// error

  String get kEmailNullError => "Пожалуйста, введите адрес электронной почты";
  String get kInvalidEmailError =>
      "Пожалуйста, введите действительный адрес электронной почты";
  String get kPassNullError => "Пожалуйста введите ваш пароль";
  String get kConfirmPasswordError => "Несоответствие пароля";
  String get kShortPassError => "Пароль слишком короткий, минимум 8 символов";
  String get kMatchPassError => "Пароли не совпадают";
  String get kNameNullError => "Пожалуйста введите свое полное имя";
  String get kPhoneNumberNullError => "Пожалуйста введите ваш номер телефона";
  String get kAddressNullError => "Пожалуйста, введите свой адрес";
  String get kTitleNullError => "Пожалуйста, введите название продукта";
  String get kDescriptionNullError => "Пожалуйста, введите описание";
  String get kPriceNullError => "Пожалуйста, введите цену";
  String get kDeadLineNullError => "Пожалуйста, введите крайний срок";

  //Splash screen, sign in, sign out, reset, etc - first screens
  String get slogan => 'Покупайте и продавайте цифровые товары';
  String get lab_continue => 'Продолжить';
  String get signin => 'Войти';
  String get signup => 'Регистрация';
  String get createaccount => 'Создать аккаунт';
  String get forgotpassword => 'Забыли пароль?';
  String get email => 'Емейл';
  String get password => 'Пароль';
  String get pleaseendteryouremail => 'введите ваш емейл';
  String get pleaseenteryourpassword => 'введите ваш пароль';
  String get forgotpassword_description =>
      'Пожалуйста введите Ваш емейл. Вы получите ссылку для сброса пароля на Вашу почту.';
  String get lab_send => 'ОТПРАВИТЬ';
  String get changepassword => 'ИЗМЕНИТЬ ПАРОЛЬ';
  String get confirmpassword => 'Подтвердите пароль';
  String get resetpass_description => 'Ввести новый пароль и подтвердить.';
  String get resetpassword => 'Сбросить пароль';
  String get currentpassword => 'Текущий пароль';
  String get enteryourcurrentpassword => 'Введите ваш текущий пароль';
  String get newpassword => 'Новый пароль';
  String get enteryournewpassword => 'Введите ваш новый пароль';
  String get confirmnewpassword => 'Подтвердите новый пароль';
  String get repeatyournewpassword => 'Повторите новый пароль';
  String get haveInvite => 'Есть код приглашения?';
  String get inviteCode => 'Код приглашения';
  String get inputCode => 'Пожалуйста введите ваш код приглашения';
  String get name => 'Имя';
  String get inputName => 'Введите полное имя';
  String get workType => "РАБОТАЙ";
  String get hireType => "НАЕМ";
  //Settings page
  String get lab_settings => "Настройки";
  String get labelSelectLanguage => "Выбрать язык";
  String get labelLanguage => "Язык";
  String get lab_colorstyle => 'Цветовая схема';
  String get lab_changepassword => 'Сменить пароль';
  String get labelInfo => "Это мультиязычное демо-приложение";
  String get delete_account => "Удалить аккаунт";

  //accountsetting page
  String get addproduct => 'Добавить продукт';
  String get offersandpromos => 'Услуги и промо';
  String get payments => 'Платежи';
  String get FAQ => 'FAQ';
  String get paymentshistory => 'История платежей';
  String get myproducts => 'Мои продукты';
  String get notificaiton => 'Оповещения';
  String get mysales => 'Мои продажи';
  String get myorders => 'Мои заказы';
  String get favorites => 'Избранное';
  String get signout => 'Выйти';
  String get closeAccount => 'Закрыть аккаунт';
  String get fromCamera => "С камеры";
  String get fromFiles => "Из файлов";
  String get switchToHire => "Перейти к найму";
  String get switchToWorker => "Переключиться на рабочего";

//chatting room
  String get conversations => 'Сообщения';
  String get nochattingroom => 'Пока нет чатов';
  String get gohomepage => 'Главная';
  String get goBrowserPage => "Просмотр вакансий";
  String get cancel_btn => 'Отмена';
  String get delete_btn => 'Удалить';
  String get areyousure => 'Вы уверены?';
  String get delete_description => 'Этот чат будет удален навсегда.';
  String get archiveroom => 'Архивировать чат';
  String get unarchiveroom => 'разархивировать комнату';
  String get deleteroom => 'Удалить чат';

  //add product
  String get title => 'ЗАГОЛОВОК';
  String get description => 'ОПИСАНИЕ';
  String get price => 'ЦЕНА';
  String get next_btn => 'ДАЛЕЕ';

  //file
  String get publish_btn => 'ОПУБЛИКОВАТЬ';
  String get backtohome => 'Вернуться на главную';
  String get copyClipboard => 'Скопировано в буфер!';

  //add or remove product
  String get deleteImage => 'Изображение будет удалено.';

  //here is the new languages for local service app

  //browse request
  String get searchRequest => 'Поиск запроса';
  String get searchCategory => 'Поиск категории';
  String get new_tab => 'Новый';
  String get active => 'Активный';
  String get previous => 'Предыдущий';
  String get all => 'Все';
  String get noItems => 'Нет предметов.';
  String get totalProposal => 'Всего предложение';
  String get selectedServices => ' услуги выбраны';
  String get selectedCities => ' города выбраны';
  //chat view
  String get unnamed => 'Безымянный';
  String get depositCoins => 'Депозит сейчас';
  String get requireCreditsDescription =>
      "Чтобы иметь возможность видеть запросы клиентов, в вашем аккаунте должен быть хотя бы 1 кредит.";
  String get credits => "Кредиты";

  //validation text

  String get integeronly => "Пожалуйста, введите только целое число";
  String get filedMandatory => "Это поле является обязательным";

  //hirestep 01
  String get serviceCall => 'Поставщик услуг может позвонить';
  String get heading_request => 'Каковы детали вашего запроса на работу?';
  String get valid_question1 =>
      'Любые другие детали, которые вы считаете важными?';
  String get valid_question2 =>
      'Если вы не предоставите достаточно информации. это повлияет на количество цитат, которые вы получите.';
  String get valid_question3 => 'Вы должны ввести не менее 100 букв.';
  String get image_question => 'Хотите добавить фотографии?';
  String get where_location => 'Где ? (Место работы)';
  String get location_validation =>
      'Мы не можем использовать ваше местоположение. Пожалуйста, найдите город или введите вручную';
  String get userMyLocation => 'ИСПОЛЬЗУЙТЕ МОЕ МЕСТОПОЛОЖЕНИЕ';
  String get enterCity => 'Введите название вашего города';
  String get when_job => 'Когда ? (дата работы)';
  String get answer_question => 'Хотите ответить на эти вопросы?';
  String get inputAnswer => 'Введите свой ответ здесь...';
  String get enterPhone => 'Введите свой телефон';
  String get phoneDescription =>
      'Наши специалисты свяжутся с вами быстрее, если вы выберете «Поставщик услуг может звонить».';
  String get enterPhoneNumber => 'Введите свой номер телефона';
  String get sendRequest => 'ПОСЛАТЬ ЗАПРОС';
  String get alert_image => 'Пожалуйста, загрузите хотя бы одно изображение.';
  String get alert_description => 'Пожалуйста, введите описание.';
  String get alert_address => 'Пожалуйста, введите свой адрес.';
  String get alert_one_option => 'Выберите один вариант.';
  String get alert_pick_date => 'Пожалуйста, выберите дату.';
  String get alert_answer => 'Пожалуйста, ответьте на вопрос';
  String get alert_phone => 'Пожалуйста, введите номер телефона.';
  String get request_success_msg => 'Поздравляем! Вы запросили успешно!';
  String get alert_close_description =>
      'Вы можете получить бесплатные цитаты, ответив еще на несколько вопросов.';
  String get go_on => 'ПРОДОЛЖАТЬ';
  String get quit => 'ПОКИДАТЬ';
  String get servicesCompanyReady => "Сервисная компания готова";
  String get allow_contacts => "Показать мой номер телефона";
  String get dont_disturbme => "Не беспокой меня";
  String get only_phone => "Свяжитесь со мной только по телефону";
  String get only_offers => "Присылайте мне только предложения";
  String get only_whatsapp => "Свяжитесь со мной только по WhatsApp";

  //hire step 02
  String get alert_nocity =>
      'Извините, но мы не можем найти город, который вы хотите...';
  String get what_looking => 'Что Вы ищете';
  String get select_service => 'Выберите тип услуги';
  String get remove_service => 'Удалить эту службу';
  String get request_quote => 'Запросите 7 бесплатных котировок для';
  String get name_company => 'Имя и фамилия (или компания)';
  String get phone => 'Телефон';
  String get search_city => 'Поиск города (Введите не менее 3 букв)';
  String get input_3 => 'Пожалуйста, введите не менее 3 букв для поиска города';
  String get when_service => 'Когда вам нужна эта услуга';
  String get asap => 'Как можно быстрее';
  String get flexible => 'я гибкий';
  String get alert_name => 'Пожалуйста, введите имя и фамилию';
  String get alert_city => 'Пожалуйста, выберите город';
  String get request_success => 'Запросить успех';
  String get tip_id => 'Идентификатор подсказки';
  String get success_thankyou =>
      'Спасибо, что выбрали наш сервис и доверили помощь в решении ваших проблем';

  //home page
  String get hi => 'Привет';
  String get home_description =>
      'Просмотрите количество экспертов, чтобы решить ваши проблемы. начните консультироваться прямо сейчас.';
  String get which_service => 'Какие услуги вам нужны?';
  String get no_service => 'Нет услуг';

  // job detail
  String get no_city_info => 'Нет информации о городе';
  String get see_number => 'Они могут позвонить и увидеть мой номер';
  String get job_detail => 'Детали работы';

  String get aboutCustomer => "О клиенте";
  String get receivedOffers => " Предложения получены";
  String get noOffers => "Нет предложений";
  String get reviews => "ОБЗОР";
  String get beFirstSend => "Будьте первым, кто отправит предложение";

  //my account setting
  String get become_seller => 'Стать продавцом';

  //my job offer
  String get job_offer => 'Предложения о работе';
  String get deadline => 'Срок';
  String get Price => 'Цена';
  String get no_proposal => 'Предложений пока нет.';
  String get update_offer => "обновить предложение";

  //my job
  String get ACTIVE => 'АКТИВНЫЙ';
  String get CANCELED => 'ОТМЕНЕНО';
  String get Cancelled => 'Отменено';
  String get my_jobs => 'Мои работы';
  String get card_onway =>
      'Цитаты в пути! Мы сообщим вам, когда предложение будет получено.';
  String get view_offer => 'Посмотреть предложения';
  String get see_details => 'СМОТРИТЕ ПОДРОБНОСТИ';
  String get cancel_request => 'ОТМЕНИТЬ ЗАПРОС';

  //my request
  String get my_requests => 'Мои запросы';

  //order and pay
  String get oerder_pay => 'Заказать и оплатить';
  String get company_info => 'Информация о компании';
  String get payment_method => 'Метод оплаты';
  String get credit_card => 'Кредитная или дебетовая карты';
  String get payment_bank => 'Оплата банковским переводом';
  String get request_10 => '10 запросов';
  String get subscription_desc =>
      '400 лей 360 лей/мес на 2 месяца, затем 400 лей/мес';
  String get paynow_01 =>
      'Оплатить сейчас (первый месяц): 428,40 лей (включая НДС)';
  String get agree => 'я согласен с';
  String get terms_service => 'Условия и положения';
  String get payNow => 'ЗАПЛАТИТЬ СЕЙЧАС';
  String get name_company_02 => 'Ваше имя или название компании';
  String get city => 'Город';
  String get address => 'Адрес';

  //splash
  String get send_splash => 'Отправить запрос';
  String get receive_splash => 'Получите до 17 предложений';
  String get choose_splash => 'Выберите эксперта';

  //subscription
  String get choose_monthly => 'Выбрать месячную подписку';
  String get sub_01 => '400 лей 360 лей/мес на 2 месяца, затем 400 лей/мес';
  String get on_average1 =>
      'В среднем вы будете соревноваться с 3 профессионалами.';
  String get no_contract =>
      'Нет срока контракта, вы можете отменить в любое время';
  String get request_20 => '20 запросов';
  String get sub_02 => '800 лей 480 лей/мес на 2 месяца, затем 800 лей/мес';
  String get on_average2 =>
      'В среднем вы будете соревноваться с 3 профессионалами.';
  String get request_35 => '35 запросов';
  String get on_average3 =>
      'В среднем вы будете соревноваться с 2 профессионалами.';
  String get on_average4 =>
      'Средняя цена за запрос составляет от 31,65 до 47,47 леев.';
  String get calc_description =>
      '*Количество запросов является ориентировочным и рассчитывается исходя из средней цены за один запрос. Цены подробно указаны в прайс-листе.';

  //view service
  String get get_7 => 'Получить 7 котировок';

  //work step 1
  String get step1_des => 'Какие услуги вы предлагаете?';
  String get eliminate => 'Устранять';
  String get step1_heading => 'Какие услуги вы предлагаете?';
  String get change_anytime => 'Вы можете изменить это в любое время.';
  String get selected_service => 'Выбранные услуги';
  String get alert_select_service =>
      'Пожалуйста, выберите услугу из списка ниже для следующего шага!';

  //work step 2
  String get step2_heading => 'Какой вид работы вас интересует?';

  //work step 3
  String get step3_heading => 'В каком городе(ах) вы работаете';
  String get selected_city => 'Выбранный город(а)';
  String get alert_select_city => 'Вы должны выбрать город для следующего шага';

  //country page
  String get ro => 'Румыния';
  String get de => 'Германия';
  String get sp => 'Испания';
  String get fr => 'Франция';
  String get it => 'Италия';
  String get start => 'Начинать';

  //missing
  String get selectCategory => 'ВЫБРАТЬ КАТЕГОРИЮ';
  String get filters => 'Фильтры';
  String get priority => 'ПРИОРИТЕТ';
  String get search => 'Поиск';
  String get category => 'КАТЕГОРИЯ';

  String get buyCredits => 'Купить кредиты';
  String get countryHeading => 'Пожалуйста, выберите вашу страну';
  String get creditHistory => 'Кредитная история';
  String get ID => 'Я БЫ';
  String get amount => 'Количество';
  String get date => 'Датировать';
  String get noCredit => 'Нет кредитной истории';
  String get Congratulation => 'Поздравление';
  String get requestPriority => 'Приоритет запроса';
  String get acceptPolicy =>
      'Я принимаю соглашение о пользователе и конфиденциальности, нажав «ОТПРАВИТЬ ЗАПРОС»';
  String get willNotify =>
      'Мы сообщим вам по электронной почте и смс, когда ваш запрос получит котировки от профессионалов.';
  String get receivedRequest => 'Мы получили ваш запрос!';
  String get free => 'Бесплатно';
  String get priceCoins => 'ЦЕНА МОНЕТ';
  String get type => 'ТИП';
  String get planSelect =>
      'Выберите тарифный план в соответствии со скоростью, с которой вам нужно найти экспертов.';
  String get canceledRequest => 'Вы отменили этот запрос!';
  String get reasonSelect => 'Выберите одну из приведенных ниже причин.';
  String get reason_1 => 'Согласен с предложением за пределами этого сайта.';
  String get reason_2 => 'Ставки завышены.';
  String get reason_3 => 'Не уверен в качестве.';
  String get reason_4 => 'Недостаточно предложений.';
  String get reason_5 => 'Не удалось получить ответы на мои вопросы.';
  String get reason_6 => 'Мне не нужна эта услуга в шезлонге';
  String get unlockedReq => 'Вы разблокировали этот запрос!';
  String get sureUnlock => 'Вы уверены, что хотите разблокировать этот запрос?';
  String get activeStatus => 'Статус: АКТИВНЫЙ';
  String get offers => 'ПРЕДЛОЖЕНИЯ';
  String get viewOffers => 'ПОСМОТРЕТЬ ПРЕДЛОЖЕНИЯ';
  String get jobID => 'Идентификатор задания';
  String get unlockReq => 'Разблокировать запрос';
  String get sendOffer => 'Отправить предложение';

  //my account
  String get myaccount => 'Мой аккаунт';
  String get myDetails => 'Мои детали';
  String get successUpdated => 'Успешно обновлено!';
  String get imageSelectAlert => 'изображение не выбрано';
  String get coins => 'монет';
  String get myOffers => 'Мои предложения';
  String get myservices => 'Мои услуги';
  String get offer => 'ПРЕДЛОЖЕНИЕ';
  String get noJobs => 'НЕ РАБОТА ЗДЕСЬ';
  String get noRequestDesc =>
      'У вас нет запрошенных вакансий.\nЗапросите услугу, которую вы хотите, и получите бесплатную оценку!';

  String get browseServices => 'ПОСМОТРЕТЬ УСЛУГИ';
  String get c_reason_1 => 'Я изменил свое мнение о сервисе.';
  String get c_reason_2 => 'Я занят другой работой.';
  String get c_reason_3 => 'я не люблю клиента';
  String get c_reason_4 => 'Не время работать.';
  String get c_reason_5 => 'Нет причин.';
  String get cancelOffer => 'Отменить предложение';
  String get pauseReq => 'ЗАПРОС ПРИОСТАНОВКИ';
  String get cancelledOffer => 'Вы отменили это предложение!';
  String get startFrom => 'НАЧИНАТЬ С';
  String get save => "Сохранить";

  String get services => 'Услуги';
  String get cities => 'Города';
  String get noService => 'Никаких услуг!';
  String get noServicesDesc =>
      'У вас пока нет ни одной услуги.\nПожалуйста, добавьте услуги, если хотите начать зарабатывать.';
  String get noCity => 'Нет городов!';
  String get noCityDesc =>
      'У вас еще нет городов.\nПожалуйста, добавьте города, если хотите начать зарабатывать.';
  String get addService => 'Добавить услугу';
  String get searchService => 'Служба поиска';
  String get myServices => 'Мои услуги';
  String get myCities => 'Мои города';
  String get addCity => 'Добавить город';
  String get searchCity => 'Поиск города';

  String get newOffer => 'Новое предложение';
  String get offerType => 'ТИП ПРЕДЛОЖЕНИЯ';
  String get offerDescriptionHint =>
      "Покажите клиенту, что вы понимаете его потребности. Сделайте специальное предложение. Расскажите ему, что отличает вас от других и почему он может вам доверять.";
  String get sentOffer => 'Вы отправили предложение!';
  String get updatedOffer => 'Вы обновили предложение!';
  String get noNotification => 'Нет уведомлений!';
  String get notificationDesc =>
      'У вас пока нет уведомлений. Пожалуйста, разместите заказ';

  String get creditCard => 'Кредитная карта';
  String get bank => 'Банк';
  String get proposalReq => 'Запрос предложений';

  String get BECOME_SELLER => 'СТАТЬ ПРОДАВЦОМ';
  String get verifyCode => 'Код подтверждения';
  String get codeVerifyDesc =>
      'Мы просто отправили вам код подтверждения. Проверьте свой почтовый ящик, чтобы получить их.';
  String get resend_code => 'Повторно отправить код в';
  String get avg_rating => 'средний рейтинг';
  String get verify_review => 'проверенные отзывы';

  String get noSearchResult => 'Нет результата поиска';
  String get inputThree => 'Пожалуйста, введите не менее 3 букв';

  String get nojobreq => 'Нет запроса на работу.';
  String get nojobreq_des =>
      'Нет запроса на работу для ваших услуг. Мы будем присылать вам уведомления при появлении новых запросов на ваши услуги.';

  String get serviceReady => 'Сервисная компания готова';
  String get everyear => 'Kаждый год';
  String get peopleTrust => 'люди доверяют Местным службам';

  //redeem code section
  String get redeemVoucher => 'АККУМУЛИРОВАТЬ ВАУЧЕР';
  String get redeemAction => 'Этот код будет применен к вашей учетной записи.';
  String get codeInvaild => 'Введенный код недействителен.';
  String get couponSuccess =>
      'Код купона успешно применен к вашей учетной записи.';
  String get cousherCode => 'Код ваучера';
  String get tryAgain => 'ПОПРОБУЙ СНОВА';
  String get addNew => 'ДОБАВИТЬ НОВОЕ';
  String get addBtn => 'ДОБАВИТЬ';
  String get apply => 'ПРИМЕНЯТЬ';
  String get haveRedeemCode => 'У вас есть код погашения?';
  String get paymentMethod => 'Метод оплаты';

  String get specificTime => 'Конкретное время (в течение трех недель)';
  String get inTwoMonth => 'В течение двух месяцев';
  String get inSixMonth => 'Через шесть месяцев';
  String get onlyPrice => 'Просто ищу цену';
  String get flexibleTime => 'Гибкий';
  String get allContact => 'Разрешить контакты';
  String get onlyOffers => 'Только предложения';
  String get onlyPhone => 'Только телефон';
  String get onlyWhatsapp => 'Только WhatsApp';
  String get notDisturb => 'Не беспокой меня';

  String get processing => "обработка";
  String get thankyou => "Спасибо";

  //become a seller
  String get companyNameHint => 'Название компании или личное имя';
  String get companyNumberHint => 'Номер компании или личный номер';
  String get profileDescriptionHint => "Описание профиля";
  String get companyNameValidateError =>
      "Пожалуйста, введите компанию или личное имя";
  String get companyNumberValidateError =>
      "Пожалуйста, введите номер компании или личный номер";
  String get profileDescriptionValidateError =>
      "Пожалуйста, введите описание профиля";
  String get addressValidateError => "Пожалуйста, введите адрес";
  String get phoneValidateError => "Пожалуйста, введите телефон";
  String get optional => "(ДОПОЛНИТЕЛЬНО)";
  String get becomeSellerApproved =>
      "Ваша заявка на статус продавца отправлена.";
  String get private => "ЧАСТНЫЙ";
  String get company => "КОМПАНИЯ";
  String get close => "ЗАКРЫТЬ";

  //other
  String get call => "ВЫЗОВ";
  String get skip => "ПРОПУСКАТЬ";
  String get chat => "ЧАТ";
  String get seeAll => "УВИДЕТЬ ВСЕ";
  String get award => "НАГРАДА";
  String get noPhoneNumber => "У Пользователь нет номера телефона.";
  String get about => "О";
  String get photos => "Фото";
  String get feedBacks => "Отзывы";
  String get contact => "Контакт";
  String get favorite => "Любимый";
  String get share => "Делиться";
  String get clientMode => "Режим клиента";
  String get providerMode => "Режим провайдера";
  String get addButton => "Добавлять";
  String get backButton => "Назад";
  String get addSucceed => "Успешно добавлено";
  // write review
  String get howWasService => "Как вы получили услугу? \nВы довольны?";
  String get writeReview => "напишите свой отзыв";
  String get keepMeReviewHidden => "Скрыть мой отзыв";
  String get inputReviewError => "Пожалуйста, введите свой отзыв";
  String get reviewedSuccess => "Ваш отзыв успешно";

  String get pleaseSelectReason => "Выберите одну из приведенных ниже причин.";
  String get confirm => "Подтверждать";
  String get cancelRequestReason1 =>
      "Согласен с предложением за пределами этого сайта.";
  String get cancelRequestReason2 => "Ставки завышены.";
  String get cancelRequestReason3 => "Не уверен в качестве.";
  String get cancelRequestReason4 => "Недостаточно предложений.";
  String get cancelRequestReason5 =>
      "Не удалось получить ответы на свои вопросы.";
  String get cancelRequestReason6 => "Мне не нужна эта услуга в шезлонге";
  String get minute => 'минута ';
  String get minutes => 'минуты ';
  String get day => 'день ';
  String get days => 'дни ';
  String get month => 'месяц ';
  String get hour => "час";
  String get hours => "часы";
  String get months => 'месяцы ';
  String get ago => 'назад ';
  String get headStringRegistered => 'зарегистрирован';
  String get tailStringRegistered => 'месяцы';
  String get high => "высокий";
  String get iWant => "Я хочу";
  String get total => "общий";
  String get availableFrom => "Доступна с";
  String get deadLineHint => 'через 5 дней';

  //chat widget
  String get typing => 'печатание';
  String get online => 'В сети';
  String get offline => 'не в сети';
  String get connecting => 'Подключение';
  String get joinRoom => 'Попробуйте еще раз';
  String get hintTextMessage => "сообщение";
  String get fullScreen => "Полноэкранный";
  String get noOffersDesc =>
      "У вас пока нет предложений. Перейдите на страницу запросов и отправьте предложения по запросам клиентов.";
}
