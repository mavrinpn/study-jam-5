## Описание

Приложение на Flutter в рамках Surf Flutter Study Jam # 5. Работает на iOS и Android.

**PS:**
- ветка study-jam-5 - то, что было сделано в рамках хакатона
- ветка main - доработанная и улучшенная

## Краткие тезисы и реализованные фичи

### **Базовый уровень**

✅ возможность выбрать картинку из интернета - по ссылке

✅ возможность ввести текст - модалка с TextField

### **Средний уровень** 🔥

✅ возможность выбирать картинки из галереи - пакет image_picker

✅ возможность делиться полученным демотиватором - пакет share_plus

### **Продвинутый уровень** 🔥🔥

✅ экран со списком доступных шаблонов - ListView.builder из массива из Hive

✅ возможность выбрать шаблон из списка и перейти на экран создания мема с выбранным шаблоном - Navigator.pushNamed

✅ шаблон представляет из себя: картинку и текстовые поля - модель данных с наследованием для типов контента и мапперами для сохранения в БД

### **Очень продвинутый уровень** 🔥🔥🔥🔥

✅/❌ экран создания нового шаблона - на базе экрана самого генератора, требуется рефакторинг и расширение функционала

### **Уровень: Безумие** 🔥🔥🔥🔥🔥

✅/❌ хранение шаблонов в локальной базе данных - данные хранятся в Hive, требуется нормальный data слой и CRUDы

### **Бонусные задания**

❌ CRUD для шаблонов

❌ Масштабирование и позиционирование картинки в шаблоне

✅/❌ Адаптив под альбомную ориентацию, десктоп и веб - запускается на MacOS, альбомная ориентация верстка не крашится, но выглядит "убого"

✅/❌ Адаптация размера шрифта под размер текстового поля - при увеличении кол-ва слов в текстовых полях, верстка макета демотиватора начинает скроллится, позволяя ввести текст любой длины


# Главный экран - список шаблонов

- Список шаблонов хранится в базе данных Hive.
- Если это первый запуск приложения и в базе пусто, то в базу добавятся преднастроенные шаблоны.

![Meme](https://github.com/mavrinpn/study-jam-5/raw/main/docs/images/1-9.png)


# Экран создания нового шаблона

- Экран открывается по нажатию на "+" из AppBar.
- Изначально в шаблоне присутствует плейсхолдер изображения с равным соотношением сторон.
- Для изменнения соотношения нужно нажать на плейсхолдер. Откроется модальное окно с доступными вариантами. При выборе нужного варианта он автоматически применяется.

![Meme](https://github.com/mavrinpn/study-jam-5/raw/main/docs/images/2-3.png)


- Кнопками "Добавить Заголовок" и "Добавить Подпись" добавляются соответствующие поля внизу.
- Заголовков и Подписей может быть любое количество. Изображение может быть только одно.
- Для сортировки текстовых полей и изображения можно использовать стандартную функцию drag and drop.

![Meme](https://github.com/mavrinpn/study-jam-5/raw/main/docs/images/4-5.png)


- При нажатии на кнопку "Сохранить шаблон" открывается модальное окно с предложением задать название шаблона.

![Meme](https://github.com/mavrinpn/study-jam-5/raw/main/docs/images/6.png)

# Экран генерации демотиватора

- Экран открывается по нажатию на нужный шаблон на главном экране. Демотиватор автоматически форматируется по заданному шаблону.
- При нажатии на место размещения изображения откроется модально окно с вариантами: выбрать картинку из галереии или загрузить по ссылке из Интернета.
- Галерея реализована через пакет image_picker.
- При загрузке из Интернета, в случае ошибки, она будет выведена в окно изображения.

![Meme](https://github.com/mavrinpn/study-jam-5/raw/main/docs/images/7-8.png)

- Готовым демотиватором можно поделиться через кнопка-иконку в правом углу на AppBar. Используется пакет share_plus.

![Meme](https://github.com/mavrinpn/study-jam-5/raw/main/docs/images/9-10.png)

## Что хотелось бы добавить, если бы было больше времени

- Более продвинутые функции настройки шаблона - выбор шрифта и размера. В модели эти праметры уже учтены, но для изменения пользователем недоступны.

- Возможность удалить Заголовок/Подпись из шаблона.

- Функция Редактирования и Удаления шаблона.

- В списке шаблонов отображать небольшое превью самого шаблона.

- Продвинутый редактор демотиватора - изменение размера и перемещения изображения.

- Нормальный data слой и полноценный CRUD для данных.

- Добавить какой-либо state manager.

- Отрефакторить и возможно объединить виджеты шаблона и самого редактора, так как у них в итоге оказалось много общего.
