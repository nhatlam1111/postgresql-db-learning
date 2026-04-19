# PostgreSQL DB Learning

Chương trình học PostgreSQL bằng tiếng Việt dành cho người mới bắt đầu, đặc biệt phù hợp với người đã quen Excel, Pivot Table, VLOOKUP, Filter và muốn chuyển sang làm việc với cơ sở dữ liệu.

Repo này dùng Excel làm cầu nối để giải thích SQL:

| Excel | PostgreSQL / SQL |
|---|---|
| Workbook | Database |
| Sheet | Table |
| Filter | WHERE |
| Sort | ORDER BY |
| Remove Duplicates | DISTINCT |
| VLOOKUP / INDEX-MATCH | JOIN |
| Pivot Table | GROUP BY |
| SUM / AVERAGE / COUNT | SUM() / AVG() / COUNT() |
| IF / IFS | CASE WHEN |
| IFERROR | COALESCE |

Lộ trình tổng thể là 10 tuần. Hiện tại repo đã có học liệu từ tuần 1 đến tuần 9, kèm lesson, ví dụ SQL, bài tập thực hành và slide HTML.

## Học Online

- Website GitHub Pages: <https://nhatlam1111.github.io/postgresql-db-learning/>
- Bản local trong repo: `docs/index.html`
- Slide HTML đã xuất bản: thư mục `docs/Slides/`

## Dự Án Này Dùng Cho Ai?

- Người chưa từng học lập trình hoặc SQL
- Người làm việc nhiều với Excel và dữ liệu
- Người muốn học PostgreSQL theo cách thực hành, dễ liên hệ với công việc thật
- Người cần tài liệu bằng tiếng Việt, giải thích chậm và rõ ràng

## Cách Học Repo Này

Mỗi chủ đề được tách thành 3 phần để học từ lý thuyết đến thực hành:

1. Đọc file `*_lesson.md` để hiểu khái niệm
2. Chạy file `*_examples.sql` trong PostgreSQL hoặc DBeaver
3. Làm file `*_exercises.md` để tự luyện
4. Nếu muốn xem nhanh, mở slide HTML hoặc truy cập GitHub Pages

Lượt học đề xuất:

1. Bắt đầu từ tuần 1 và học theo thứ tự
2. Sau mỗi lesson, chạy toàn bộ ví dụ SQL để nhìn thấy kết quả thật
3. Tự viết lại query trước khi xem đáp án bài tập
4. Chỉ chuyển sang tuần mới khi đã hiểu tuần trước

## Cấu Trúc Project

> Cấu trúc bên dưới đã bỏ qua các file và thư mục nằm trong `.gitignore`.

```text
postgresql-db-learning/
|- docs/
|  |- index.html                  # Trang tổng hợp để học trên trình duyệt
|  `- Slides/                     # Slide HTML theo từng chủ đề đã xuất bản
|- Exercises/                     # Bài tập thực hành theo từng tuần / chủ đề
|- Lessons & Examples/
|  |- Example/                    # File SQL ví dụ có thể chạy trực tiếp
|  `- Lesson/                     # Bài học lý thuyết bằng Markdown
`- Reference/                     # Tài liệu tra cứu nhanh
```

## Học Liệu Hiện Có

| Tuần | Chủ đề | Lesson | Example SQL | Bài tập | Slide |
|---|---|---|---|---|---|
| 1 | Tại sao cần cơ sở dữ liệu? | [Lesson](Lessons%20%26%20Examples/Lesson/01.Why_Database_lesson.md) | [SQL](Lessons%20%26%20Examples/Example/01.Why_Database_examples.sql) | [Exercise](Exercises/01.Why_Database_exercises.md) | [HTML](docs/Slides/01.Why_Database_slides.html) |
| 2 | Cài đặt PostgreSQL & Làm quen công cụ | [Lesson](Lessons%20%26%20Examples/Lesson/02.Setup_PostgreSQL_lesson.md) | [SQL](Lessons%20%26%20Examples/Example/02.Setup_PostgreSQL_examples.sql) | [Exercise](Exercises/02.Setup_PostgreSQL_exercises.md) | [HTML](docs/Slides/02.Setup_PostgreSQL_slides.html) |
| 3 | Kiểu dữ liệu & Tạo bảng | [Lesson](Lessons%20%26%20Examples/Lesson/03.Datatype_and_Table_lesson.md) | [SQL](Lessons%20%26%20Examples/Example/03.Datatype_and_Table_examples.sql) | [Exercise](Exercises/03.Datatype_and_Table_exercises.md) | [HTML](docs/Slides/03.Datatype_and_Table_slides.html) |
| 4 | Truy vấn dữ liệu - SELECT cơ bản | [Lesson](Lessons%20%26%20Examples/Lesson/04.SELECT_Basics_lesson.md) | [SQL](Lessons%20%26%20Examples/Example/04.SELECT_Basics_examples.sql) | [Exercise](Exercises/04.SELECT_Basics_exercises.md) | [HTML](docs/Slides/04.SELECT_Basics_slides.html) |
| 5 | Lọc & Sắp xếp dữ liệu | [Lesson](Lessons%20%26%20Examples/Lesson/05.Filter_Data_lesson.md) | [SQL](Lessons%20%26%20Examples/Example/05.Filter_Data_examples.sql) | [Exercise](Exercises/05.Filter_Data_exercises.md) | [HTML](docs/Slides/05.Filter_Data_slides.html) |
| 6 | Hàm tổng hợp & GROUP BY | [Lesson](Lessons%20%26%20Examples/Lesson/06.Aggregate_Functions_lesson.md) | [SQL](Lessons%20%26%20Examples/Example/06.Aggregate_Functions_examples.sql) | [Exercise](Exercises/06.Aggregate_Functions_exercises.md) | [HTML](docs/Slides/06.Aggregate_Functions_slides.html) |
| 7 | Kết nối nhiều bảng - JOIN | [Lesson](Lessons%20%26%20Examples/Lesson/07.JOIN_lesson.md) | [SQL](Lessons%20%26%20Examples/Example/07.JOIN_examples.sql) | [Exercise](Exercises/07.JOIN_exercises.md) | [HTML](docs/Slides/07.JOIN_slides.html) |
| 8 | Truy vấn nâng cao | [Lesson](Lessons%20%26%20Examples/Lesson/08.Advanced_Queries_lesson.md) | [SQL](Lessons%20%26%20Examples/Example/08.Advanced_Queries_examples.sql) | [Exercise](Exercises/08.Advanced_Queries_exercises.md) | [HTML](docs/Slides/08.Advanced_Queries_slides.html) |
| 9 | Quản lý dữ liệu | [Lesson](Lessons%20%26%20Examples/Lesson/09.Data_Management_lesson.md) | [SQL](Lessons%20%26%20Examples/Example/09.Data_Management_examples.sql) | [Exercise](Exercises/09.Data_Management_exercises.md) | [HTML](docs/Slides/09.Data_Management_slides.html) |

## Cần Chuẩn Bị Gì Để Học?

- PostgreSQL trên máy tính Windows
- DBeaver để viết và chạy SQL
- Một database để thực hành, ví dụ `hoc_sql`

Nếu bạn chưa cài đặt xong, hãy bắt đầu từ học liệu tuần 2.

## Cách Chạy Các Ví Dụ SQL

1. Mở PostgreSQL và kết nối bằng DBeaver
2. Tạo hoặc chọn database học tập, ví dụ `hoc_sql`
3. Mở file trong thư mục `Lessons & Examples/Example/`
4. Chạy từng đoạn bằng `Ctrl+Enter` hoặc chạy cả file nếu phù hợp
5. So sánh kết quả trả về với phần giải thích trong lesson

## Đặc Điểm Của Học Liệu

- Toàn bộ giải thích được viết bằng tiếng Việt
- SQL keywords giữ nguyên bằng tiếng Anh theo quy ước chung
- Ví dụ dùng bộ bảng nhất quán để học dần theo độ khó
- Mỗi khái niệm mới đều có liên hệ với thao tác quen thuộc trong Excel
- Bài tập đi từ cơ bản đến nâng cao trong cùng một chủ đề

## Tài Liệu Tham Khảo Nhanh

- [Kiểu dữ liệu PostgreSQL](Reference/datatypes_reference.md)
- [Ép kiểu dữ liệu](Reference/type_casting.md)
- [PostgreSQL Cheatsheet](Reference/postgresql_cheatsheet.md)

## Ghi Chú

- Đây là repo học tập, ưu tiên sự rõ ràng và tính dễ hiểu trước khi tối ưu kỹ thuật.
- Khi học các lệnh có khả năng sửa dữ liệu như `UPDATE` hoặc `DELETE`, nên tập thói quen `SELECT` với cùng `WHERE` trước để tránh thao tác nhầm.
- Nếu bạn muốn học trên trình duyệt thay vì mở file Markdown, GitHub Pages là điểm vào tốt nhất.