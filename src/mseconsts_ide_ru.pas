{ MSEgui Copyright (c) 1999-2018 by Martin Schreiber

    See the file COPYING.MSE, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
} 

unit mseconsts_ide_ru;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
  mseconsts_ide;

implementation

uses
  msetypes{msestrings},
  SysUtils,
  msestockobjects,
  mseformatstr;

const

ru_modalresulttext: defaultmodalresulttextty =
 (
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '&Отменить',   {&Cancel}
  '&Прервать',   {&Abort}
  '&Готово',   {&OK}
  '&Да',   {&Yes}
  '&Нет',   {&No}
  '&Все',   {Yes &all}
  '&Все',   {Yes &all}
  'Н&ет всему',   {N&o all}
  'Нева&жно',   {&Ignore}
  '&Пропустить',   {&Skip}
  'Пропустить &все',   {Skip a&ll}
  '&Продолжить);'   {Co&ntinue}
 );

ru_modalresulttextnoshortcut: defaultmodalresulttextty =
 (
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  'Отменить',   {Cancel}
  'Прервать',   {Abort}
  'Готово',   {OK}
  'Да',   {Yes}
  'Нет',   {No}
  'Все',   {Yes all}
  'Все',   {Yes all}
  'Нет всему',   {No all}
  'Неважно',   {Ignore}
  'Пропустить',   {Skip}
  'Пропустить все',   {Skip all}
  'Продолжить'   {Continue}
 );

ru_projectoptionscontext: projectoptionsconaty =
 (
  'Неправильная кодировка может повредить ваши исходные файлы.',   {Wrong encoding can damage your source files.}
  'Вы хотите установить кодировку',   {Do you wish to set encoding to}
  '*** ПРЕДУПРЕЖДЕНИЕ ***',   {*** WARNING ***}
  'Вешать трубку',   {Hangup}
  'Прерывать',   {Interrupt}
  'Покидать',   {Quit}
  'Незаконное указание',   {Illegal instruction}
  'Trace trap',   {Trace trap}
  'Прервать',   {Abort}
  'Ошибка шины',   {BUS error}
  'Исключение с плавающей точкой',   {Floating-point exception}
  'Убийство',   {Kill}
  'Пользовательский сигнал 1',   {User-defined signal 1}
  'Нарушение сегментации',   {Segmentation violation}
  'Пользовательский сигнал 2',   {User-defined signal 2}
  'Сломанная труба',   {Broken pipe}
  'Будильник',   {Alarm clock}
  'Прекращение действия',   {Termination}
  'Ошибка стека',   {Stack fault}
  'Статус ребенка изменился',   {Child status has changed}
  'Продолжить',   {Continue}
  'Стоп неблокируемый',   {Stop, unblockable}
  'Остановка клавиатуры',   {Keyboard stop}
  'Фон читать с tty',   {Background read from tty}
  'Фоновая запись на tty',   {Background write to tty}
  'Срочное состояние розетки',   {Urgent condition on socket}
  'Превышен лимит ЦП',   {CPU limit exceeded}
  'Превышен предел размера файла',   {File size limit exceeded}
  'Виртуальный будильни',   {Virtual alarm clock}
  'Профильный будильник',   {Profiling alarm clock}
  'Изменение размера окна',   {Window size change}
  'Ввод / вывод теперь возможен',   {I/O now possible}
  'Перезапуск при сбое питания'   {Power failure restart}
 );

ru_actionsmoduletext: actionsmoduleaty =
 (
  'Настроить ideU',   {Configure ideU}
  'Идентификатор процесса',   {Process ID}
  'Присоединить к процессу',   {Attach to process}
  'Неизвестный класс модуля для "',   {Unknown moduleclass for "}
  'Унаследованный компонент "',   {Inherited component "}
  '"нельзя удалить.',   {" can not be deleted.}
  'ОШИБКА',   {ERROR}
  'Сделать прерванным.',   {Make aborted.}
  'Загрузка прервана.',   {Download aborted.}
  'Runerror с "',   {Runerror with "}
  'Ошибка: тайм-аут.',   {Error: Timeout.}
  'Изготовление.',   {Making.}
  'Сделать не работающим.',   {Make not running.}
  'Скачивание.',   {Downloading.}
  'Загрузка не выполняется.',   {Download not running.}
  '" Бег.',   {" running.}
  'Сценарий',   {Script}
  'Рекурсивное наследование формы "',   {Recursive form inheritance of "}
  'Составная часть "',   {Component "}
  '" существуют.',   {" exists.}
  'Предок по "',   {Ancestor for "}
  '" не найден.',   {" not found.}
  'Модуль "',   {Module "}
  'Неверное имя "',   {Invalid name "}
  'Неверное имя метода',   {Invalid methodname}
  'Модуль не найден',   {Module not found}
  'Метод не найден',   {Method not found}
  'Опубликованный (управляемый) метод',   {Published (managed) method}
  'не существует.',   {does not exist.}
  'Вы хотите удалить мероприятие?',   {Do you wish to delete the event?}
  'ПРЕДУПРЕЖДЕНИЕ',   {WARNING}
  'Метод',   {Method}
  'имеет разные параметры.',   {has different parameters.}
  'Модуль "',   {A module "}
  '"уже открыт.',   {" is already open.}
  'Неразрешенные ссылки на',   {Unresolved reference(s) to}
  'Модуль (и):',   {Module(s):}
  'Невозможно прочитать файл формы "',   {Can not read formfile "}
  'Недействительное имя компонента.',   {Invalid component name.}
  'Недействительное исключение',   {Invalid exception}
  'Инструменты',   {T&ools}
  'Формы',   {Forms}
  'Источник',   {Source}
  'Все файлы',   {All Files}
  'Программа MSE',   {MSE Program}
  'MSE Unit',   {MSE Unit}
  'Текстовый файл MSE',   {MSE Textfile}
  'Майнформ',   {Mainform}
  'Простая форма',   {Simple Form}
  'Форма стыковки',   {Docking Form}
  'Datamodule',   {Datamodule}
  'Подчиненная',   {Subform}
  'Scrollboxform',   {Scrollboxform}
  'Табформ',   {Tabform}
  'Докпанель',   {Dockpanel}
  'Отчет',   {Report}
  'Scriptform',   {Scriptform}
  'Унаследованная форма',   {Inherited Form}
  'Вы хотите заменить настройки на',   {Do you want to replace the settings by}
  'Файл "',   {File "}
  'Вы хотите перезаписать?',   {Do you want to overwrite?}
  'Неизвестный',   {Unknown}
  'Ошибка',   {Error}
  'Запускать',   {Startup}
  'Исключение',   {Exception}
  'GDB умер',   {GDB died}
  'Точка останова достигнута',   {Breakpoint hit}
  'Сработала точка наблюдения',   {Watchpoint triggered}
  'Считать срабатывание точки наблюдения',   {Read Watchpoint triggered}
  'Сработала точка наблюдения за доступом',   {Access Watchpoint triggered}
  'Конец диапазона шага',   {End stepping range}
  'Функция завершена',   {Function finished}
  'Нормальный выход',   {Exited normally}
  'Выход',   {Exited}
  'Отдельно',   {Detached}
  'Сигнал получен',   {Signal received}
  'Stop error',   {Stop error}
  'Не могу прочитать проект',   {Can not read project}
  'О',   {About}
  'Инспектор объектов',   {Object Inspector}
  'Магазин комплектующих',   {Store Component}
  'Процесс прикрепления',   {Attaching Process}
  'Загрузка'   {Loading}
 );

ru_mainformtext: mainformaty =
 (
  'Неразрешенные ссылки в',   {Unresolved references in}
  'к',   {to}
  'Вы хотите выполнить поиск в файле формы?',   {Do you wish to search the formfile?}
  'ПРЕДУПРЕЖДЕНИЕ',   {WARNING}
  'Formfile для',   {Formfile for}
  'Formfiles',   {Formfiles}
  'Иерархия рекурсивной формы для "',   {Recursive form hierarchy for "}
  'ОШИБКА',   {ERROR}
  'Тип занятия',   {Classtype}
  'не найден.',   {not found.}
  'Проект',   {Project}
  'изменен. Сохранить?',   {is modified. Save?}
  'Подтверждение',   {Confirmation}
  'Невозможно открыть файл "',   {Unable to open file "}
  '*** Бег ***',   {*** Running ***}
  'Скачивание',   {Downloading}
  'Скачано',   {Downloaded}
  'Запустить команду сервера gdb "',   {Start gdb server command "}
  '" Бег.',   {" running.}
  'Запустить сервер gdb',   {Start gdb Server}
  'ошибка запуска сервера gdb',   {gdb server start error}
  'запуск сервера gdb отменен.',   {gdb server start canceled.}
  'Невозможно запустить команду start gdb.',   {Can not run start gdb command.}
  'Uploadcommand "',   {Uploadcommand "}
  'Download *** ERROR ***',   {Download ***ERROR***}
  'Загрузка завершена.',   {Download finished.}
  'Загрузка отменена.',   {Download canceled.}
  'Файл "',   {File "}
  '" не найден.',   {" not found.}
  '" существуют.',   {" exists.}
  'Новый',   {New}
  'Выбрать предка',   {Select ancestor}
  'Новая форма',   {New form}
  'Файлы Паскаля',   {Pascal Files}
  'новый',   {new}
  'Невозможно загрузить проект "',   {Can not load Project "}
  'Выбрать шаблон проекта',   {Select project template}
  'Файлы проекта',   {Project files}
  'Все файлы',   {All files}
  'Выбрать файл программы',   {Select program file}
  'Программные файлы Pascal',   {Pascal program files}
  'Программные файлы C',   {C program files}
  'Новый проект',   {New Project}
  'Невозможно запустить процесс',   {Can not start process}
  'Процесс',   {Process}
  'Бег.',   {running.}
  'Процесс прекращен',   {Process terminated}
  'Процесс завершен нормально.',   {Process terminated normally.}
  'Сделать *** ОШИБКУ ***',   {Make ***ERROR***}
  'Сделать ОК.',   {Make OK.}
  'Источник изменился хочешь переделать проект?',   {Source has changed, do you wish to remake project?}
  'Загрузить макет окна',   {Load Window Layout}
  'Зона стыковки'   {Docking area}
 );

ru_sourceformtext: sourceformaty =
 (
  'Файл "',   {File "}
  '"изменилось.',   {" has changed.}
  'Также есть модификации в буфере редактирования.',   {There are modifications in edit buffer also.}
  'Вы хотите перезагрузить с диска?',   {Do you wish to reload from disk?}
  'Подтверждение',   {Confirmation}
  '<нет>',   {<none>}
  'Вы хотите заменить:',   {Do you wish to replace:}
  'с участием:',   {with:}
  '<новый>',   {<new>}
  'Syntaxdeffile:',   {Syntaxdeffile:}
  'Текст',   {Text}
  'не найден.',   {not found.}
  'Перезагрузить с начала файла?',   {Restart from begin of file?}
  'Отмена?',   {Cancel?}
  'Вы хотите заменить это появление?',   {Do you wish to to replace this occurence?}
  'Перейти к номеру строки:',   {Go to line number:}
  'Найти линию',   {Find line}
  'Также есть модификации в буфере редактирования.'   {There are modifications in edit buffer also.}
 );

ru_settingstext: isettingsaty =
 (
  'Применять',   {Apply}
  'sak голосовой помощник',   {sak voice assistive config}
  'Родительский справочник sakit',   {Parent directory of sakit}
  'Включить sak при загрузке',   {Enable sak assistive at loading}
  'Схема системы',   {System layout}
  'Универсальные каталоги',   {Universal path layout}
  'Нет обработки Z-заказа',   {No Z order handling}
  'Клавиша Shift для выбора слова',   {Use shift key to select a word}
  'Автофокус в главном меню',   {Auto focus in main-menu}
  'Полный путь к проекту в заголовке',   {Full path of project in window title}
  'Установить диалог как модальный',   {Set dialog-forms as modal vs as tool}
  'Высота шрифта',   {Font height}
  'Название шрифта',   {Font name}
  'Нет подтверждения удаление строки',   {No confirmation to delete row}
  'Мигающая вставка',   {Blinking caret}
  'Перекрасить холст',   {Repaint canvas}
  'Редактор исходного кода',   {Source Editor}
  'Используйте эти параметры',   {Use those options instead of project options}
  'Пробел после запятой при автоанализе',   {Add space after comma -> auto-parsing}
  'Когда файл был изменен:',   {When a file has changed}
  'Нет диалога => перезагрузить новый',   {No dialog box => reload the new one}
  'Нет диалога => сохранить старое',   {No dialog box => keep the old one}
  'Диалог спрашивает что делать ...',   {A dialog box ask what to do...}
  'Прямоугольник вокруг выделения'   {Rectangle around multi-select}
 );

ru_projectoptionstext: projectoptionsaty =
 (
  'Варианты проекта',   {Project options}
  'редактор',   {Editor}
  'Правое поле',   {Right margin line}
  'Отметить скобки',   {Mark Brackets}
  'Номера строк',   {Line Numbers}
  'Отметить парные слова',   {Mark Pairwords}
  'Обрезать пробелы',   {Trim trailing whitespace on save}
  'Автоматический отступ',   {Auto Indent}
  'Нет редактора исходного кода',   {No Source Editor}
  'Отступ табуляции',   {Tab indent}
  'Вкладка Пробел"',   {Space tab}
  'Показать вкладки',   {Show tabs}
  'Шрифт со сглаживанием',   {Anti aliased font}
  'кодировка',   {Encoding}
  'Цвет марки',   {Mark Color}
  'Цвет статистики',   {Stat Color}
  'Поло. Y',   {Scr Y}
  'Кол. сим.',   {Nb char}
  'EOL Стиль',   {EOL Style}
  'Рез. коп.',   {Backup}
  'Табуляторы',   {Tabstops}
  'Отступ',   {Indent}
  'Доп. прос.',   {ExtS}
  'Дополнительное пространство между строками',   {Extra space between lines}
  'Ширина',   {Width}
  'Рост',   {Height}
  'Шрифт',   {Font}
  'Цвет шрифта фона',   {Font Bk. color}
  'Цвет шрифта',   {Font color}
  'Файловый фильтр',   {File filter}
  'Имя',   {Name}
  'Маска файла',   {File mask}
  'Файл определения синтаксиса',   {Syntax definition file}
  'Шаблоны кода',   {Code Templates}
  'Каталоги шаблонов кода расширение файла = .mct',   {Code template directories, file extension = .mct}
  'Выберите каталог объекта',   {Select unit directory}
  '&Отладчик',   {&Debugger}
  'Отладчик проекта',   {Project Debugger}
  'Каталоги поиска',   {Search &Directories}
  'Путь поиска для получения информации о коде',   {Search path to get infos about code}
  'Выберите исходный каталог',   {Select source directory}
  'Каталог базы объектов (пусто = Создать каталог)',   {Object &Base Directory (empty = Make Directory)}
  'Выберите исходный базовый каталог',   {Select source base directory}
  'Определяет',   {Defi&nes}
  '&Сигналы',   {&Signals}
  '&Исключение',   {&Exception}
  '&Цель',   {&Target}
  'Запустить цель подключения команды сервера gdb',   {Start gdb server command attach target}
  'Не ждать выхода',   {No wait for exit}
  'gdb скрипт перед подключением',   {Before connect gdb script}
  'gdb скрипт перед загрузкой',   {Before load gdb script}
  'gdb скрипт перед запуском',   {Before run gdb script}
  'gdb скрипт после подключения',   {After connect gdb script}
  'gdb скрипт после загрузки',   {After load gdb script}
  'Запустить команду сервера gdb запустить цель',   {Start gdb server command run target}
  'Подождите перед подключением',   {Wait before connect}
  'Начать один раз',   {Start once}
  'Команда загрузки',   {Download command}
  'Процессор',   {Processor}
  'Симулятор',   {Simulator}
  'gdb скачать',   {gdb download}
  'Запуск БКПТ',   {Startup BKPT}
  'Целевое соединение',   {Target connection}
  'Всегда скачивать',   {Always download}
  'Всегда загружайте перед запуском',   {Always download before run}
  'Время ожидания загрузки',   {Load Timeout}
  '&Внешняя консоль',   {&Extern Console}
  '&Оста. искл.',   {&Stop on Exc}
  'Остановить при исключении',   {Stop on exceptions}
  '&Акт.пере;',   {&Acti-Break}
  'Активировать в перерыве',   {Activate on Break}
  '&Ценность подсказок',   {&Value Hints}
  'Вызов GUI_DEB',   {Call GUI_DEB}
  'Освободите захват мыши с помощью целевой остановки. gdb иногда дает сбой с этой опцией.',   {Release mouse grab by target stop. gdb sometimes crashes with this option.}
  'Установить TT&Y',   {Set TT&Y}
  '&Под/пере',   {&Raise-Break}
  'Поднимать в перерыве',   {Raise on break}
  '&Ошибки FPC',   {&FPC bugs}
  'Используйте обходные пути для ошибок FPC / gdb',   {Use workarounds for FPC/gdb bugs}
  'Цель отладки',   {Debug &target}
  'команда xterm',   {xterm command}
  '&Запустите команду',   {Run command}
  '&Отладчик по умолчанию',   {Default Debugger}
  'Варианты отладки',   {Debug &options}
  '&Делать',   {&Make}
  'Марка умолчанию',   {Default make col}
  'Главный файл',   {Mainfile}
  'Выбрать основной файл',   {Select mainfile}
  'Имя цели',   {Targetfile name}
  'Выбрать цель',   {Select target file}
  'Компилятор умолчанию',   {Default Compiler}
  'Выбрать команда сделать',   {Select make command}
  'Показать командную строку',   {Show Command Line}
  'Копировать сообщения файл',   {Copy messages to file}
  'Закрыть сообщения',   {Close message}
  'Заголовки проверки',   {Check head}
  'Заголовки методов проверки',   {Check method headers}
  'Компилятор проекта',   {Project Compiler}
  'Команда до',   {Command before}
  'Сделать варианты',   {Make options}
  'Справочники',   {Directories}
  'Выберите каталог объекта',   {Select unit directory}
  'Команда после',   {Command after}
  'Расширение Exe',   {Exe Extension}
  'Комментарии',   {Comments}
  'Каталог производителей',   {Make Directory}
  'Каталог производителей',   {Select make directory}
  'Цвет ошибки',   {Error Color}
  'Цвет предупреждения',   {Warning Color}
  'Цвет примечания',   {Note Color}
  'Полоска ESC',   {Strip ESC}
  'Убрать последовательности ESC в сообщениях и терминале',   {Strip ESC sequences in Messages and Terminal form}
  'Показать консоль',   {Show Console}
  'Цель',   {Purpose}
  'Выходной файл сообщений',   {Message output file}
  'Выбрать цель',   {Select target file}
  'Макросы',   {Macros}
  'Активная группа',   {Active group}
  'Псевдоним шрифта',   {&Font Alias}
  'Дизайнеров',   {Designers}
  'Пользовательские цвета',   {User &Colors}
  'Скопируйте код setcolormapvalue в буфер обмена',   {Copy "setcolormapvalue" code to clipboard}
  'Форматировать макросы',   {F&ormat Macros}
  'Используется formatfloatmse() и formatdatetimemse()',   {Used by formatfloatmse() and formatdatetimemse()}
  'Шаблоны',   {Templates}
  'Новый проект',   {New project}
  'Скрипт перед копии',   {Script before copy}
  'Скрипт после копии',   {Script after copy}
  'Новый файл',   {New File}
  'Новая форма',   {New Form}
  'Инструменты',   {Tools}
  'Хранилище',   {Storage}
  'Информация',   {Infos}
  'Полное название проекта',   {Full name of project}
  'Создатель',   {Creator}
  'Лицензия',   {License}
  'Дата создания'   {Date of creation}
 );

ru_stockcaption: stockcaptionaty =
(
  '',   {}
  '- неверно',   {is invalid}
  'Несоответствие формату',   {Format error}
  'Требуется значение',   {Value is required}
  'Ошибка',   {Error}
  'Мин.',   {Min}
  'Макс.',   {Max}
  'Несоответствие диапазону',   {Range error}
  '&Вернуть',   {&Undo}
  '&Повтор',   {&Redo}
  '&Копировать',   {&Copy}
  'Вы&резать',   {Cu&t}
  '&Вставить',   {&Paste}
  '&Выбрать все',   {Select &all}
  '&Вставить строку',   {&Insert Row}
  '&Добавить строку',   {&Append Row}
  '&Удалить строку',   {&Delete Row}
  '&Каталог',   {&Dir}
  '&Дом.',   {&Home}
  '&Вверх',   {&Up}
  '&Нов. кат-г',   {&New}
  'На&звание',   {&Name}
  'Показ. &скрыт. файлы',   {&Show hidden files}
  '&Фильтр',   {&Filter}
  'Сохранить',   {Save}
  'Открыть',   {Open}
  'Имя',   {Name}
  'Создать новый каталог',   {Create new directory}
  'Назад',   {Back}
  'Вперёд',   {Forward}
  'Вверх',   {Up}
  'Файл',   {File}
  'уже есть‚ перезаписать?',   {exists, do you want to overwrite?}
  'изменен. Сохранить?',   {is modified. Save?}
  'ПРЕДУПРЕЖДЕНИЕ',   {WARNING}
  'ОШИБКА',   {ERROR}
  'Исключение',   {Exception}
  'Система',   {System}
  'не существует',   {does not exist}
  'ПАРОЛЬ',   {PASSWORD}
  'Введите пароль',   {Enter password}
  'Неверный пароль!',   {Invalid password!}
  'Не удаётся прочесть содержимое каталога',   {Can not read directory}
  'Графический формат не поддерживается',   {Graphic format not supported}
  'Графические данные не соответствуют формату',   {Graphic format error}
  'BMP-изображение',   {MS Bitmap}
  'ICO-изображение',   {MS Icon}
  'JPEG-изображение',   {JPEG Image}
  'PNG-изображение',   {PNG Image}
  'XPM-изображение',   {XPM Image}
  'PNM-изображение',   {PNM Image}
  'TARGA-изображение',   {TARGA Image}
  'TIFF-изображение',   {TIFF Image}
  'Все',   {All}
  'Подтверждение',   {Confirmation}
  'Удалить запись?',   {Delete record?}
  'Копировать запись?',   {Copy record?}
  'Закрыть страницу',   {Close page}
  'Сначала',   {First}
  'Приор',   {Prior}
  'Далее',   {Next}
  'Вконец',   {Last}
  'Добавить',   {Append}
  'Удалить',   {Delete}
  'Править',   {Edit}
  'Постер',   {Post}
  'Отменить',   {Cancel}
  'Освежить',   {Refresh}
  'Изменить фильтр',   {Edit filter}
  'Изменить мин. фильтр',   {Edit filter minimum}
  'Изменить макс. фильтр',   {Edit filter maximum}
  'Сбросить фильтр',   {Reset filter}
  'Вкл. фильтр',   {Filter on}
  'Поиск',   {Search}
  'Автомат. правка',   {Auto edit}
  'Копировать запись',   {Copy record}
  'Диалог',   {Dialog}
  'Вставить',   {Insert}
  'Копировать',   {Copy}
  'Вставить',   {Paste}
  'Вставить строку',   {Row insert}
  'Добавить строку',   {Row append}
  'Удалить строку',   {Row delete}
  'Вернуть',   {Undo}
  'Повтор',   {Redo}
  'Вырезать',   {Cut}
  'Выделить всё',   {Select all}
  'Откл. фильтр',   {Filter off}
  'Альбомная',   {Portrait}
  'Книжная',   {Landscape}
  'Удалить строку?',   {Delete row?}
  'выбранные строки?',   {selected rows?}
  'Только простой пункт',   {Single item only}
  'Копировать ячейки',   {Copy Cells}
  'Вставить ячейки',   {Paste Cells}
  'Закрыть',   {Close}
  'Развернуть',   {Maximize}
  'Нормализовать',   {Normalize}
  'Минимизировать',   {Minimize}
  'Фиксированный размер',   {Fix size}
  'Плавающий',   {Float}
  'Оставаться сверху',   {Stay on top}
  'Оставаться в фоне',   {Stay in background}
  'Блокировать потомков',   {Lock children}
  'Не блокировать',   {No lock}
  'Ввод',   {Input}
  'Кнопка',   {Button}
  'Вкл',   {On}
  'Выкл',   {Off}
  'Левая граница',   {Left border}
  'Верхняя граница',   {Top border}
  'Правая граница',   {Right border}
  'Нижняя граница',   {Bottom border}
  'Начало текста',   {Begin of text}
  'Конец текста',   {End of text}
  'Режим ввода',   {Inputmode}
  'Переписать',   {Overwrite}
  'Удалён',   {Deleted}
  'Скопирован',   {Copied}
  'Вклеен',   {Inserted}
  'Вставлен',   {Pasted}
  'Изъят',   {Withdrawn}
  'Окно активировано',   {Window activated}
  'Меню',   {Menu}
  'Начало файла',   {Beginning of file}
  'Конец файла',   {End of file}
  'Голосовой вывод',   {Voice output}
  'Произнести снова',   {Speak again}
  'Первый столбец',   {First column}
  'Первая строка',   {First row}
  'Последний столбец',   {Last column}
  'Последняя строка',   {Last row}
  'Выделение',   {Selection}
  'Произнести путь',   {Speak path}
  'Отключенная кнопка',   {Disabled button}
  'Первое поле',   {First field}
  'Последнее поле',   {Last field}
  'Первый элемент',   {First element}
  'Последний элемент',   {Last element}
  'Медленнее',   {Slower}
  'Быстрее',   {Faster}
  'Окно',   {Window}
  'Зона',   {Area}
  'Зона активирована',   {Area activated}
  'Снизить громкость',   {Volume down}
  'Повысить громкость',   {Volume up}
  'Отменить речь',   {Cancel speech}
  'Цель',   {Target}
  'Вид',   {View}
  'Формы',   {Forms}
  'Макет',   {Layout}
  'Синтаксис',   {Syntax}
  'Проект',   {Project}
  'Отредактировано',   {Edited}
  'Виджеты',   {Widgets}
  'Настройки',   {Settings}
  'О',   {About}
  'Новый',   {New}
  'Сохранить как ...',   {Save as...}
  'Сохранить все',   {Save all}
  'Закрыть все',   {Close all}
  'Распечатать',   {Print}
  'Покидать',   {Quit}
  'Линия',   {Line}
  'Искать снова',   {Search again}
  'Искать назад',   {Search back}
  'Найти и заменить',   {Find & replace}
  'Найти в файлах',   {Find in files}
  'Список процедур',   {Procedures list}
  'Выберите страницу редактирования',   {Select edit page}
  'Скопировать слово под курсором',   {Copy word at cursor}
  'Копировать LaTeX',   {Copy LaTeX}
  'Отступ',   {Indent}
  'Непроверенный',   {Unindent}
  'окружающая обстановка',   {Environment}
  'Присоединить процесс',   {Attach process}
  'Прикрепите цель',   {Attach target}
  'Отсоединить цель',   {Detach target}
  'Скачать',   {Download}
  'Инструменты',   {Tools}
  'Делать',   {Make}
  'Строить',   {Build}
  'Прервать создание',   {Abort make}
  'Отладка / Запуск',   {Debug-Run}
  'Опции',   {Options}
  'Дерево',   {Tree}
  'Источник',   {Source}
  'Открыть копию',   {Open copy}
  'Сохранить копию как ...',   {Save copy as}
  'Украшение',   {Beautifier}
  'Панели',   {Panels}
  'Принудительный Z-порядок',   {Force Z order}
  'Древовидный список',   {Tree list}
  'Сообщения',   {Messages}
  'Результат поиска',   {Find result}
  'Командир',   {Commander}
  'Символы',   {Symbols}
  'бдительность',   {Watches}
  'Куча',   {Stack}
  'Потоки',   {Threads}
  'CPU',   {CPU}
  'Assembler',   {Assembler}
  'Контрольные точки',   {Breakpoints}
  'Точки наблюдения',   {Watchpoints}
  'объем памяти',   {Memory}
  'Целевая консоль',   {Target console}
  'Переключить форму / блок',   {Toggle form/unit}
  'Модули MSE',   {MSE modules}
  'Закройте все модули MSE',   {Close all MSE modules}
  'Общие настройки',   {General settings}
  'Дополнительные настройки',   {Extra settings}
  'Языки',   {Languages}
  'Настроить виджеты',   {Configure widgets}
  'Настроить компиляторы',   {Configure compilers}
  'Настроить отладчики',   {Configure debuggers}
  'Темы',   {Themes}
  'Каталог',   {Directory}
  'Без иконок',   {No icons}
  'Без бокового',   {No lateral}
  'Компакт',   {Compact}
  'Открыть проект',   {Open project}
  'Открыть файл',   {Open file}
  'Путь',   {Path}
  'Другой',   {Other}
  'Команда печати',   {Print command}
  'Ярлык',   {Shortcut}
  'Ценить',   {Value}
  'Деликатный случай',   {Case sensitive}
  'Только выбрано',   {Selected only}
  'Целое слово',   {Whole word}
  'Текст для поиска',   {Text to find}
  'Искать в текущем файле',   {Search in current file}
  'Искать в открытых файлах',   {Search in open files}
  'Искать в каталоге проекта',   {Search in project directory}
  'Искать в каталогах',   {Search in directories}
  'Включить подкаталоги',   {Include subdirectories}
  'Заменять',   {Replace}
  'Заменить все',   {Replace all}
  'Заменить',   {Replace with}
  'Запрашивать замену',   {Prompt on replace}
  'Палитра компонентов',   {Components palette}
  'Найти компоненты',   {Find components}
  'Сброс',   {Reset}
  'Шаг',   {Step}
  'Шаговая инструкция',   {Step instruction}
  'Следующая инструкция',   {Next instruction}
  'Перезапустить отладчик',   {Restart debugger}
  'Переключить точку останова',   {Toggle breakpoint}
  'Включить точку останова',   {Toggle breakpoint enabled}
  'Включение / выключение подсказки по выполненным строкам',   {Executed lines hint on/off}
  'Пожалуйста сначала скомпилируйте это.',   {Please compile it first.}
  'Готово',   {Finish}
  'Набор по умолчанию',   {Set as default}
  'Хост',   {Host}
  'Авторское право'   {Copyright}
 );

ru_langnamestext: array[0..6] of msestring =
(
  'Английский',   {English}
  'Русский',   {Russian}
  'Французский',   {French}
  'Немецкий',   {German}
  'Испанский',   {Spanish}
  'Португальский',   {Portuguese}
  'Chinese (not complete)'                 //6_chinese
 );

ru_extendedtext: extendedaty =
(
  'Удалить выбранную строку?',   {Delete selected row?}
  'Удалить %s выбранные строки? ?'   {Delete %s selected rows?}
 );

function delete_n_selected_rows(const params: array of const): msestring;
begin
  with params[0] do
    if vinteger = 1 then
      Result := ru_extendedtext[ex_del_row_selected]
    else
      Result := StringReplace(ru_extendedtext[ex_del_rows_selected], #37#115, inttostrmse(vinteger), [rfReplaceAll]);
end;

const
ru_textgenerator: defaultgeneratortextty = (
 {$ifdef FPC} @{$endif}delete_n_selected_rows);

initialization

registerlangconsts(langnames[la_ru], @ru_langnamestext, @ru_extendedtext, @ru_mainformtext, @ru_sourceformtext,
                   @ru_projectoptionscontext, @ru_actionsmoduletext, @ru_settingstext, @ru_projectoptionstext,
                   @ru_stockcaption, @ru_modalresulttext, @ru_modalresulttextnoshortcut, @ru_textgenerator);

end.

