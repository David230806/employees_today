extension MonthTitle on DateTime {
  String get monthTitle {
    switch (DateTime.now().month) {
      case 1:
        return "Янв";
      case 2:
        return "Фев";
      case 3:
        return "Мар";
      case 4:
        return "Апр";
      case 5:
        return "Май";
      case 6:
        return "Июн";
      case 7:
        return "Июл";
      case 8:
        return "Авг";
      case 9:
        return "Сен";
      case 10:
        return "Окт";
      case 11:
        return "Ноя";
      case 12:
        return "Дек";
      default:
        return "";
    }
  }
}
