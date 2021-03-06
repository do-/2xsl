2XSL: генератор XSLT
====================

Инструмент генерации XSLT-шаблонов из готовых XML-документов.

СМЫСЛ ЗАТЕИ
-----------

По ходу внедрения XML в качестве базового типа данных MS Office у разработчиков информационных систем появилась возможность генерировать по имеющимся данным офисные документы, используя шаблоны фомата [XSLT](https://www.w3.org/TR/xslt).

Это удобно, поскольку XSLT -- установившийся, широко известный, поддерживаемый, подробнейшим образом документированный стандарт, имеющий множество совместимых реализаций на разнобразных программных платформах.

В частности, современные Web-браузеры позволяют производить XSL-трансформации на клиенте и предлагать их результаты на сохранение в локальной файловой системе, что ощутимо снижает потребность в "серверах печати" для Intranet-систем.

НАЧАЛО РАБОТЫ
-------------

Как правило, у разработчика на входе имеется образец документа и требования привязать в нём некоторые фрагменты текста к определённым полям БД.

В теории было бы достаточно сохранить файл как Office XML, обернуть его элементами xsl:stylesheet / xsl:template и далее вставлять по тексту xsl:value-of. Однако...

ПРОБЛЕМЫ
--------

...выясняется, что содержимое Office XML не годится к использованию в качестве XSL-шаблона. А именно:

* узлы типа processing instruction (в частности, `<?mso-application progid="Word.Document"?>`) игнорируютя XSLT-процессорами и не попадают в результат;
* значения атрибутов, заключённые в фигурные скобки в тегах вроде `<w:guid w:val="{DD78C2BA-25B9-4AE1-B133-50156EF35023}"/>`, считаются не текстом, а шаблонами для подстановки переменных.

В результате, помимо вышеупомянутого обёртывания верхнеуровневыми элементами, разработчику предстоит ещё зачистка внутреннего содержимого.

РЕШЕНИЕ
-------

Впрочем, её можно выполнить при помощи того же самого механизма: XSLT.

Достаточно обработать исходный XML-документ приложенным `2.xsl` -- и на выходе получится готовый корретный шаблон.

Для обработки можно использовать любой XSLT-процессор командной строки.

Для ясности к данному проекту приложен скрипт `xsl.pl`. Его использование требует наличия на машине Perl5 с модулями XML::LibXML и XML::LibXSLT.

ЕЩЁ РАЗ, ПО ШАГАМ
-----------------

Шпаргалка для тех кто согласен использовать `xsl.pl`:

### Шаг 0. Готовим директорию

Создаём пустую временную директорию.

Копируем туда `2.xsl`, `xsl.pl` и заодно `data.xml`.

### Шаг 1. Из Word в XML

Открываем файл .docx.

Нажимаем `F12`.

Выбираем "Тип файла": "XML-документ Word".

Сохраняем в ранее заготовненную директорию.

Допустим, файл называется `my_doc.xml`.

### Шаг 2. Из XML в XSLT

Открываем командную строку во временной директории.

`xsl.pl 2.xsl < my_doc.xml > my_doc.xsl`
 
Шаблон `my_doc.xsl` готов.

### Шаг 3. Проверка

Применяем полученный `my_doc.xsl` к тестовым (пустым) данным

`xsl.pl my_doc.xsl < data.xml > test.doc`

Теперь можно открыть test.doc -- содержимое должно быть, как у исходного файла.

ЧТО ДАЛЬШЕ?
-----------

Переносить `my_doc.xsl` в программный код своей системы, искать там избранные фрагменты и заменять их на value-of, for-each и прочие элементы привязки к данным.

По желанию можно заменить `data.xml` на образец данных и повторять вышеописанный "Шаг 3" для отладки XSL вне системы.
