// These are the jobs that can create documents. The ranks in templateGrades can create templates for this job.
const AVAILABLE_JOBS = [
  {
    job: "police",
    templateGrades: [4, 5],
    logo: "https://i.imgur.com/YQsB8is.png",
  },
  {
    job: "ambulance",
    templateGrades: [4],
    logo: "https://i.pinimg.com/564x/6b/88/4f/6b884f7ebe28ff56a0e1fd9f5c47890a.jpg",
  },
  {
    job: "lawyer",
    templateGrades: [0],
    logo: "https://imgur.com/tNqYJgz.png",
  },
];

// These templates are visible to all players. If you don't want
// any citizen templates, delete everything inside the [] like this:
//    const CITIZEN_TEMPLATES = []
//
// If these templates are empty, the issued documents tab will
// not be visible to players who fon't have a specified job.
const CITIZEN_TEMPLATES = [
  {
    id: "citizen_contract",
    documentName: "Граждански Договор",
    documnetDescription:
      "Това е документ между двамата граждани от Los Santos. Този документ е официален и легален.",
    fields: [
      {
        name: "Име",
        value: "",
      },
      {
        name: "Фамилия",
        value: "",
      },
      {
        name: "Валиден до",
        value: "",
      },
    ],
    infoName: "ИНФОРМАЦИЯ",
    infoTemplate: "",
  },
];

const COLORS = {
  // These are hexadecimal color codes for the main theme. You can change them as you wish.
  // Primary colors are colors of buttons, and some texts, while secondary color is used for the cancel button.
  primary: "#38a2e5",
  secondary: "#DCAF62",

  // These two should stay RGBA to give them a 90% opacity. Only change the first 3 numbers with any RGB code
  // i.e. rgba([red], [green], [blue], 0.9)
  menuGradientBottom: "rgba(152, 198, 227, 0.9)",
  menuGradientTop: "rgba(176, 218, 245, 0.9)",
};

// These are the texts that show up on the NUI. Translate them as you wish. If you'd like to change
// the client texts, go to the config.lua file.

const TEXTS = {
  myDocumentsTitle: "Моите Документи",
  issuedDocumentsTitle: "Издадени Документи",
  templatesTitle: "Темплейти",
  customDocumentName: "Име на документ",
  documentType: "Тип",
  documentName: "Име",
  unnamed: "Без име",
  actions: "Действия",
  edit: "Редактирай",
  cancel: "Откажи",
  delete: "Изтрий",
  view: "Виж",
  show: "Покажи",
  copy: "Копие",
  newTemplateBtn: "Нов темплейт",
  deleteTemplateTitle: "Изтрий темплейт",
  deleteTemplateQuestion: "Сигурен ли си, че искаш да изтриеш този темплейт?",
  date: "Дата",
  newDocumentBtn: "Нов документ",
  newCitizenDocumentBtn: "Нов граждански документ",
  deleteDocumentTitle: "Изтрий документ",
  deleteDocumentQuestion: "Сигурен ли си, че искаш да изтриеш този документ?",
  signHereText: "Подпиши се тук",
  selectDocumentType: "Избери тип документ",
  cannotIssueDocument: "Не може да издавате документ с текущата ви работата",
  issuerFirstname: "ИМЕ НА ИЗДАТЕЛ",
  issuerLastname: "ФАМИЛИЯ НА ИЗДАТЕЛ",
  issuerDOB: "ДАТА НА РАЖДАНЕ НА ИЗДАТЕЛ",
  issuerJob: "РАБОТНА ПОЗИЦИЯ НА ИЗДАТЕЛ",
  termsAndSigning: "УСЛОВИЯ И ПОДПИСВАНЕ",
  terms1:
    "Когато този документ бъде подписа, той става напълно официален и легален.",
  terms2:
    "С подписването на този документ вие сте правно обвързани с неговия контекст и приемате всички правни последици, които той може да породи.",
  terms3:
    "Всяко копие на този документ е равностойно на оригинала. Бъдете изключително внимателни, когато давате копия.",
  terms4:
    "Уверете се, че сте напълно наясно с контекста на този документ, преди да подпишете.",
  terms5:
    "Не се колебайте да потърсите помощ от правен съвет, преди да подпишете.",
  requiredError: "Това поле е задължително",
  docNameField: "ИМЕ НА ДОКУМЕНТ",
  docDescField: "ОПИСАНИЕ НА ДОКУМЕНТ",
  docFieldField: "ИМЕ НА ПОЛЕ",
  docAddField: "Добави поле",
  docInfoNameField: "ЗАГЛАВИЕ",
  docInfoValueField: "ТЕМПЛЕЙТ",
  docMinGradeField: "МИНИМАЛНА РАБОТНА ПОЗИЦИЯ (Пр: 0 - Кадет)",
  editTemplateBtn: "РЕДАКТИРАЙ ТЕМПЛЕЙТ",
  createTemplateBtn: "СЪЗДАЙ ТЕМПЛЕЙТ",
  createDocumentBtn: "СЪЗДАЙ ДОКУМЕНТ",
  documentCopy: "КОПИЕ",
};
