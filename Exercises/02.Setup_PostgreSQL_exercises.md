# Bài Tập Tuần 2: Cài Đặt PostgreSQL & Làm Quen Công Cụ

> **Nguyên tắc Tuần 2:** Đây là tuần thực hành cài đặt — hầu hết bài tập yêu cầu bạn **làm thật** và ghi lại kết quả. Không có đáp án "đúng tuyệt đối" vì kết quả phụ thuộc vào máy tính của bạn.

---

## Nhóm A: Cài Đặt & Kết Nối (Cơ Bản — Bắt Buộc)

> Hoàn thành nhóm A trước khi làm bất kỳ bài nào khác.

### Bài A1 — Cài Đặt PostgreSQL

Thực hiện cài đặt PostgreSQL theo hướng dẫn trong bài giảng, rồi trả lời:

```
1. Bạn đã cài phiên bản PostgreSQL nào?
   (VD: PostgreSQL 16.2)
   Trả lời: _______________________________________________

2. Mật khẩu bạn đặt cho tài khoản postgres là gì?
   ⚠️ Quan trọng: Ghi mật khẩu này ra đây (và ra giấy riêng) để không quên!
   Mật khẩu: _______________________________________________

3. Kiểm tra PostgreSQL đang chạy (qua Task Manager hoặc Services):
   [ ] Đang chạy (Status: Running) ✅
   [ ] Chưa chạy → Thử khởi động lại máy tính và kiểm tra lại

4. PostgreSQL được cài ở thư mục nào?
   (Mặc định thường là: C:\Program Files\PostgreSQL\16\)
   Trả lời: _______________________________________________
```

---

### Bài A2 — Cài Đặt DBeaver và Kết Nối

Cài DBeaver Community và tạo kết nối đến PostgreSQL, rồi trả lời:

```
1. Bạn đã tải DBeaver phiên bản nào?
   Trả lời: _______________________________________________

2. Khi nhấn "Test Connection" trong DBeaver, kết quả là gì?
   [ ] Hiện thông báo "Connected" ✅
   [ ] Hiện thông báo lỗi → Ghi lại lỗi và xem phần xử lý lỗi trong bài giảng:
       Thông báo lỗi: _______________________________________________
       Đã xử lý bằng cách: _______________________________________________

3. Sau khi kết nối thành công, Database Navigator bên trái hiện gì?
   (Liệt kê các database bạn thấy)
   Trả lời: _______________________________________________

4. Mô tả giao diện DBeaver bằng lời của bạn — nó trông như thế nào?
   (Không cần kỹ thuật — chỉ cần mô tả tự nhiên như bạn giải thích cho người khác)
   Trả lời: _______________________________________________
```

---

### Bài A3 — Tạo Database hoc_sql

```
Tạo database hoc_sql theo 2 cách:

Cách 1: Dùng menu click chuột trong DBeaver
[ ] Đã thử và thành công

Cách 2: Dùng lệnh SQL trong SQL Editor:
    CREATE DATABASE hoc_sql;
[ ] Đã thử và thành công

(Nếu Cách 1 đã tạo rồi, Cách 2 sẽ báo lỗi — điều đó BÌNH THƯỜNG)

Sau khi tạo xong, kiểm tra:
[ ] hoc_sql xuất hiện trong Database Navigator (sau khi Refresh)
```

---

## Nhóm B: Khám Phá Giao Diện DBeaver (Trung Bình)

> Đảm bảo đã hoàn thành Nhóm A trước khi bắt đầu nhóm này.

### Bài B1 — Nhận Diện Các Khu Vực Giao Diện

Nhìn vào DBeaver đang mở trên máy bạn, sau đó điền tên cho từng khu vực trong sơ đồ dưới đây:

```
┌──────────────────────────────────────────────────────────────┐
│  DBeaver Community                                  _ □ ×    │
├──────────────────────────────────────────────────────────────┤
│  [File][Edit][Navigate][Window][Help]                        │
├───────────────────┬──────────────────────────────────────────┤
│                   │                                          │
│                   │                                          │
│    KHU VỰC (1)    │           KHU VỰC (2)                   │
│                   │                                          │
│                   │                                          │
│                   ├──────────────────────────────────────────┤
│                   │                                          │
│                   │           KHU VỰC (3)                   │
│                   │                                          │
└───────────────────┴──────────────────────────────────────────┘

Khu vực (1): _______________________________________________
             (Gợi ý: đây là nơi bạn thấy cây kết nối, bảng...)

Khu vực (2): _______________________________________________
             (Gợi ý: đây là nơi bạn gõ câu SQL)

Khu vực (3): _______________________________________________
             (Gợi ý: đây là nơi kết quả SQL hiện ra)
```

---

### Bài B2 — Phím Tắt Quan Trọng

Điền vào chỗ trống:

```
1. Để chạy câu SQL tại vị trí con trỏ, nhấn: _______________

2. Để chạy TOÀN BỘ script SQL (tất cả các câu), nhấn: _______________

3. Để comment (vô hiệu hóa) một dòng SQL, nhấn: _______________

4. Để undo (hoàn tác) thao tác vừa làm, nhấn: _______________

5. Trong SQL Editor, mỗi tab là gì?
   (Gợi ý: giống gì trong Excel?)
   Trả lời: _______________________________________________
```

---

### Bài B3 — Điều Hướng Trong Database Navigator

Thực hiện trên DBeaver đang mở và trả lời:

```
1. Mở rộng cây kết nối theo đường dẫn sau:
   PostgreSQL → Databases → hoc_sql → Schemas → public → Tables

   Bạn thấy bảng nào trong Tables?
   [ ] Chưa có bảng nào (nếu chưa làm phần 6.2 trong bài giảng)
   [ ] Thấy bảng nhan_vien (nếu đã thử phần 6.2)

2. Click chuột PHẢI vào "hoc_sql" trong Navigator.
   Liệt kê 5 tùy chọn bạn thấy trong menu:
   - _______________________________________________
   - _______________________________________________
   - _______________________________________________
   - _______________________________________________
   - _______________________________________________

3. Double-click vào "postgres" (database mặc định) trong Navigator.
   Một tab mới mở ra — nó hiển thị thông tin gì?
   Trả lời: _______________________________________________

4. Trong SQL Editor, bạn có thể mở nhiều tab cùng lúc không?
   (Thử: click dấu + để mở tab SQL mới)
   [ ] Có — mỗi tab là một SQL script riêng
   [ ] Không
```

---

## Nhóm C: Chạy SQL Thật (Trung Bình → Nâng Cao)

> Mở SQL Editor trong DBeaver, kết nối đến hoc_sql, và chạy từng câu.

### Bài C1 — Câu SQL Kiểm Tra Hệ Thống

Chạy từng câu SQL sau trong DBeaver và ghi lại kết quả thật của bạn:

```sql
-- Câu 1
SELECT version();
```
Kết quả thật của bạn: _______________________________________________

---

```sql
-- Câu 2
SELECT current_date;
```
Kết quả thật của bạn: _______________________________________________

---

```sql
-- Câu 3
SELECT 2024 * 12 AS so_thang_trong_nam;
```
Kết quả mong đợi là bao nhiêu? (Tính tay trước khi chạy): _______________
Kết quả thật từ DBeaver: _______________

---

```sql
-- Câu 4
SELECT 'Họ tên: ' || 'Trần Thị Mai' AS thong_tin_nhan_vien;
```
Kết quả thật của bạn: _______________________________________________
Giải thích || làm gì trong câu này: _______________________________________________

---

```sql
-- Câu 5
SELECT
    current_date AS ngay_hom_nay,
    current_date + 7 AS mot_tuan_sau;
```
Kết quả thật của bạn (ghi cả 2 cột):
- ngay_hom_nay: _______________
- mot_tuan_sau: _______________

*(Bạn vừa học được rằng PostgreSQL có thể cộng số ngày vào ngày tháng! Trong Excel tương đương với =TODAY()+7)*

---

### Bài C2 — Thử Lệnh CREATE DATABASE

```
1. Trong SQL Editor (kết nối vào "postgres"), chạy:
   CREATE DATABASE thu_nghiem;

   Kết quả thành công trông như thế nào?
   Trả lời: _______________________________________________

2. Click phải "Databases" → Refresh.
   Bạn thấy "thu_nghiem" chưa?
   [ ] Có
   [ ] Chưa thấy → thử Refresh lại

3. Thử chạy CÙNG lệnh đó một lần nữa:
   CREATE DATABASE thu_nghiem;

   Lần này có lỗi không? Thông báo lỗi là gì?
   Trả lời: _______________________________________________

   Tại sao lại có lỗi đó? (Giải thích bằng lời của bạn)
   Trả lời: _______________________________________________

   → So sánh: trong Excel, bạn có thể đặt tên 2 sheet giống nhau không?
   Trả lời: _______________________________________________
```

---

### Bài C3 — Thách Thức: Tạo Bảng nhan_vien (Nâng Cao — Tùy Chọn)

> Bài này là "nếm thử" Tuần 3. Không bắt buộc, nhưng rất được khuyến khích!

Đảm bảo đang kết nối vào **hoc_sql** trước khi bắt đầu.

```
Bước 1: Mở SQL Editor từ hoc_sql (click phải hoc_sql → SQL Editor)

Bước 2: Chạy lệnh CREATE TABLE từ file examples.sql (Phần 4)
[ ] Thành công — thấy thông báo gì? _______________________________________________
[ ] Lỗi — thông báo lỗi: _______________________________________________

Bước 3: Chạy lệnh INSERT 6 nhân viên (Phần 5 trong examples.sql)
[ ] Thành công — DBeaver hiện "X rows affected", X là: _______________

Bước 4: Chạy câu SELECT này và điền kết quả:
    SELECT * FROM nhan_vien;
Bạn thấy bao nhiêu hàng dữ liệu? _______________

Bước 5: Thử câu SELECT khác:
    SELECT ho_ten, luong FROM nhan_vien ORDER BY luong DESC;
Nhân viên có lương cao nhất là ai? _______________
```

---

## Nhóm D: Ôn Lại Tuần 1 Với Dữ Liệu Thật (Nâng Cao)

> Làm bài này sau khi đã tạo bảng nhan_vien và nhập 6 nhân viên (Bài C3).

### Bài D1 — Chạy Lại Ví Dụ Từ Tuần 1

Tuần 1 bạn chỉ đọc các câu SQL trong `Week-1/examples.sql`. Bây giờ chạy chúng thật!

Mở file `Week-1/examples.sql` trong DBeaver (File → Open File) và chạy từng phần.

Ghi lại kết quả của các câu quan trọng:

```
Câu 1: SELECT COUNT(*) FROM nhan_vien;
Kết quả: _______________

Câu 2: SELECT * FROM nhan_vien WHERE phong_ban = 'Kế toán';
Có bao nhiêu người phòng Kế toán? _______________
Tên họ là: _______________________________________________

Câu 3: SELECT ho_ten, luong FROM nhan_vien ORDER BY luong DESC;
Xếp từ cao xuống thấp, 3 người đầu là:
1. _______________________________________________
2. _______________________________________________
3. _______________________________________________

Câu 4: SELECT DISTINCT phong_ban FROM nhan_vien;
Có bao nhiêu phòng ban khác nhau? _______________
Tên các phòng ban: _______________________________________________
```

---

### Bài D2 — Câu Hỏi Tư Duy

Trả lời dựa vào những gì bạn đã trải nghiệm với DBeaver và PostgreSQL:

```
1. Khi bạn chạy SELECT * FROM nhan_vien, kết quả hiện ở đâu trong DBeaver?
   Trả lời: _______________________________________________
   → Trong Excel, điều tương đương là gì?
   Trả lời: _______________________________________________

2. SQL không phân biệt chữ HOA/thường có nghĩa là gì trong thực tế?
   Thử chạy 2 câu sau và so sánh kết quả:
     (a) SELECT * FROM nhan_vien;
     (b) select * from nhan_vien;
   Kết quả có khác nhau không? _______________
   Kết luận của bạn: _______________________________________________

3. Trong DBeaver, bạn có thể click vào ô trong Results Panel để sửa dữ liệu không?
   (Thử double-click vào một ô trong kết quả của SELECT * FROM nhan_vien)
   Trả lời: _______________________________________________
   → Theo bạn, điều này có lợi hay bất lợi gì?
   Trả lời: _______________________________________________

4. Nếu bạn muốn chạy 3 câu SQL cùng một lúc, bạn làm thế nào?
   (Gợi ý: thử viết 3 câu trong SQL Editor, ngăn cách bằng ; rồi nhấn Alt+X)
   Trả lời: _______________________________________________

5. Theo bạn, tại sao chúng ta tạo database hoc_sql riêng thay vì dùng database "postgres" mặc định?
   (Không có đáp án đúng/sai — cứ viết suy nghĩ của bạn)
   Trả lời: _______________________________________________
```

---

## Đáp Án Gợi Ý

> **Lưu ý:** Đây là gợi ý — một số bài không có đáp án cố định vì phụ thuộc vào máy tính của bạn (phiên bản phần mềm, ngày chạy...).

---

### Đáp Án Nhóm B

**Bài B1 — Tên các khu vực:**
- Khu vực (1): **Database Navigator** — cây kết nối bên trái, giống File Explorer
- Khu vực (2): **SQL Editor** — nơi viết SQL, giống thanh công thức Excel
- Khu vực (3): **Results Panel** — kết quả SQL, giống bảng dữ liệu sau khi dùng công thức

**Bài B2 — Phím tắt:**
- Câu 1: `Ctrl + Enter`
- Câu 2: `Alt + X`
- Câu 3: `Ctrl + /`
- Câu 4: `Ctrl + Z`
- Câu 5: Mỗi tab trong SQL Editor giống như một **sheet riêng** trong Excel — mỗi tab là một file SQL độc lập

---

### Đáp Án Nhóm C

**Bài C1 — Kết quả mong đợi:**

| Câu SQL | Kết quả mong đợi |
|---|---|
| `SELECT version()` | Chuỗi dài có "PostgreSQL X.Y..." |
| `SELECT current_date` | Ngày hôm nay dạng YYYY-MM-DD |
| `SELECT 2024 * 12` | `24288` |
| `'Họ tên: ' \|\| 'Trần Thị Mai'` | `Họ tên: Trần Thị Mai` |

- Giải thích `||`: Ký hiệu nối chuỗi trong PostgreSQL — ghép hai chuỗi văn bản thành một. Giống `&` trong Excel hoặc `CONCATENATE()`

**Bài C2 — Lỗi khi tạo database lần 2:**
- Thông báo lỗi: `ERROR: database "thu_nghiem" already exists`
- Lý do: Database `thu_nghiem` đã được tạo ở lần đầu — không thể tạo thêm database cùng tên
- So sánh Excel: Không thể đặt tên hai sheet giống nhau trong cùng một workbook

**Bài C3 — Bảng nhan_vien:**
- Thành công: "6 rows affected"
- SELECT * FROM nhan_vien → 6 hàng dữ liệu
- Lương cao nhất: Phạm Minh Châu (25,000,000)

---

### Đáp Án Nhóm D

**Bài D1 — Kết quả đúng:**
- `COUNT(*)`: 6
- Phòng Kế toán: 2 người (Trần Thị Mai và Hoàng Thị Dung)
- Top 3 lương cao: Phạm Minh Châu (25tr) → Võ Văn Em (22tr) → Nguyễn Văn An (20tr)
- Số phòng ban: 4 (Kế toán, Kinh doanh, Nhân sự, IT)

**Bài D2 — Câu hỏi tư duy:**
- Câu 1: Kết quả hiện trong **Results Panel** bên dưới SQL Editor. Trong Excel tương đương là kết quả của công thức hoặc bảng Pivot hiện ở vùng trang tính.
- Câu 2: Hai câu `SELECT *` và `select *` cho kết quả giống hệt nhau. SQL không phân biệt hoa/thường với từ khóa và tên bảng/cột. Nhưng quy ước viết từ khóa HOA (`SELECT`) và tên bảng thường (`nhan_vien`) để dễ đọc.
- Câu 3: Có thể sửa — DBeaver cho phép sửa trực tiếp trong Results Panel. Điều này tiện nhưng cần cẩn thận vì sửa trực tiếp vào database thật.
- Câu 4: Viết cả 3 câu trong SQL Editor (ngăn cách bằng `;`), rồi nhấn `Alt+X` để chạy tất cả. Kết quả từng câu hiện riêng biệt.
- Câu 5: Gợi ý lý do: database `postgres` là database hệ thống — nên để yên. Tạo `hoc_sql` riêng giúp quản lý rõ ràng hơn (dễ xóa nếu cần, không ảnh hưởng hệ thống) — giống tạo workbook riêng cho từng dự án thay vì nhét tất cả vào một file.

---

## Tự Kiểm Tra Cuối Tuần 2

Đánh dấu ✅ vào những mục bạn đã hoàn thành:

```
[ ] Cài PostgreSQL thành công và đang chạy (Running)
[ ] Cài DBeaver Community thành công
[ ] Tạo kết nối DBeaver ↔ PostgreSQL, "Test Connection" ra "Connected"
[ ] Biết tên 3 khu vực chính của DBeaver
[ ] Biết phím tắt Ctrl+Enter và Alt+X
[ ] Tạo database hoc_sql thành công
[ ] Chạy được ít nhất 3 câu SQL từ Nhóm C
[ ] (Tùy chọn) Tạo bảng nhan_vien và nhập 6 nhân viên
[ ] (Tùy chọn) Chạy lại toàn bộ examples.sql từ Tuần 1
```

**Nếu bạn tick được 6/8 ô đầu tiên → Bạn đã sẵn sàng cho Tuần 3!** 🎉
