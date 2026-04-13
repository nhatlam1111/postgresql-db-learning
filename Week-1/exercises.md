# Bài Tập Tuần 1
## "Tại Sao Cần Cơ Sở Dữ Liệu? — Excel vs Database Concepts"

> **Lưu ý:** Tuần 1 chưa cần cài PostgreSQL — tất cả bài tập đều là tư duy và phân tích, không cần phần mềm.
>
> **Cách dùng file này:** Làm bài trước, sau đó mới giở phần đáp án ở cuối file.

---

## Hướng Dẫn Chung

**Có 3 nhóm bài tập, tăng dần độ khó:**

| Nhóm | Tên | Mức độ | Phù hợp với ai |
|---|---|---|---|
| **A** | Nhận Diện Khái Niệm | Cơ bản | Tất cả mọi người |
| **B** | Phân Tích Thực Tế | Trung bình | Làm sau khi xong nhóm A |
| **C** | Đọc Hiểu SQL | Nâng cao | Thử thách nếu muốn tiến xa hơn |

**Thời gian dự kiến:** 60–90 phút nếu làm đầy đủ cả 3 nhóm.

**Dữ liệu mẫu dùng xuyên suốt bài tập:**

Bảng `nhan_vien` — 6 nhân viên của công ty Minh Phát:

| id | ho_ten | phong_ban | luong | ngay_sinh | email |
|---|---|---|---|---|---|
| 1 | Trần Thị Mai | Kế toán | 15,000,000 | 1995-03-20 | mai.tran@cty.com |
| 2 | Nguyễn Văn An | Kinh doanh | 20,000,000 | 1990-07-15 | an.nguyen@cty.com |
| 3 | Lê Thị Bình | Nhân sự | 18,000,000 | 1992-11-03 | binh.le@cty.com |
| 4 | Phạm Minh Châu | IT | 25,000,000 | 1988-01-25 | chau.pham@cty.com |
| 5 | Hoàng Thị Dung | Kế toán | 13,000,000 | 1996-09-10 | (trống) |
| 6 | Võ Văn Em | Kinh doanh | 22,000,000 | 1993-05-30 | em.vo@cty.com |

---

## Nhóm A: Nhận Diện Khái Niệm (Cơ Bản)

### Bài A1 — Ghép Cặp

Ghép mỗi khái niệm ở cột trái với khái niệm tương đương ở cột phải bằng cách điền chữ cái vào ô trống.

**Cột trái — Khái niệm Excel:**

| STT | Khái niệm Excel | Trả lời |
|---|---|---|
| 1 | File workbook (.xlsx) | _____ |
| 2 | Sheet (trang tính) | _____ |
| 3 | Cột (Column A, B, C...) | _____ |
| 4 | Hàng (Row 1, 2, 3...) | _____ |
| 5 | Ô (Cell) | _____ |
| 6 | Data Validation | _____ |
| 7 | Filter | _____ |
| 8 | Sort (sắp xếp) | _____ |
| 9 | VLOOKUP / INDEX-MATCH | _____ |
| 10 | Pivot Table | _____ |

**Cột phải — Khái niệm Database/SQL:**

```
A. Column
B. ORDER BY
C. GROUP BY
D. Table
E. WHERE
F. Row / Record
G. Database
H. Field
I. JOIN
J. Data Type
```

---

### Bài A2 — Điền Vào Chỗ Trống

Đọc đoạn văn dưới đây và điền từ thích hợp vào chỗ trống.
*(Từ gợi ý: database, table, column, row, field, NULL, SQL, PostgreSQL, query, primary key)*

---

Một **[1] ___________** là nơi chứa toàn bộ dữ liệu của một hệ thống — giống như một file Excel workbook. Bên trong, dữ liệu được tổ chức thành các **[2] ___________**, mỗi cái giống một sheet trong Excel.

Mỗi bảng có cấu trúc gồm các **[3] ___________** (đại diện cho loại thông tin, ví dụ: "họ tên", "lương") và các **[4] ___________** (đại diện cho từng mục dữ liệu cụ thể, ví dụ: thông tin của một nhân viên).

Giao điểm của một cột và một hàng gọi là **[5] ___________**. Khi ô đó không có giá trị (để trống), trong database gọi là **[6] ___________**.

Mỗi bảng thường có một cột đặc biệt gọi là **[7] ___________** — đây là mã định danh duy nhất cho mỗi hàng, không bao giờ được trùng nhau (ví dụ: mã nhân viên, mã sản phẩm).

Để giao tiếp với database — truy vấn, thêm, sửa, xóa dữ liệu — chúng ta dùng ngôn ngữ **[8] ___________**. Mỗi câu lệnh trong ngôn ngữ này gọi là một **[9] ___________**.

Phần mềm chúng ta sẽ dùng để quản lý database trong khóa học này là **[10] ___________** — một hệ quản trị cơ sở dữ liệu miễn phí, mạnh mẽ và phổ biến trên toàn thế giới.

---

### Bài A3 — Đúng hay Sai?

Đọc mỗi phát biểu và đánh dấu Đúng (Đ) hoặc Sai (S). Nếu Sai, hãy giải thích tại sao.

| STT | Phát biểu | Đ/S | Giải thích (nếu Sai) |
|---|---|---|---|
| 1 | Một database có thể chứa nhiều table, giống một workbook có nhiều sheet | | |
| 2 | SQL phân biệt chữ hoa và chữ thường — `SELECT` khác với `select` | | |
| 3 | Data Type trong database nghiêm ngặt hơn Data Validation trong Excel | | |
| 4 | PostgreSQL là phần mềm trả phí, phải mua bản quyền hàng năm | | |
| 5 | Mỗi câu lệnh SQL nên kết thúc bằng dấu chấm phẩy (`;`) | | |
| 6 | NULL có nghĩa là số 0 | | |
| 7 | Database chỉ phù hợp cho các công ty lớn, doanh nghiệp nhỏ không cần | | |
| 8 | DBeaver là giao diện đồ họa giúp làm việc với PostgreSQL mà không cần gõ lệnh | | |
| 9 | Một row trong database tương đương với một hàng trong Excel | | |
| 10 | JOIN trong SQL dùng để kết nối dữ liệu từ nhiều bảng, tương tự VLOOKUP trong Excel | | |

---

## Nhóm B: Phân Tích Thực Tế (Trung Bình)

### Bài B1 — Phân Tích File Excel Của Bạn

Hãy lấy một file Excel bạn đang dùng trong công việc (hoặc một file học tập quen thuộc). Trả lời các câu hỏi sau:

**Phần 1: Hiểu cấu trúc hiện tại**

```
File Excel bạn chọn: ___________________________________

1. File này có bao nhiêu sheet?
   Trả lời: _____ sheet

2. Nếu "dịch" file này sang database, cần bao nhiêu TABLE?
   (Gợi ý: mỗi sheet có thể = 1 table, nhưng đôi khi nhiều sheet
    tương tự nhau có thể gộp thành 1 table có thêm cột phân loại)
   Trả lời: _____ table
   Giải thích: _____________________________________________

3. Lấy sheet quan trọng nhất. Liệt kê tên các cột:
   Sheet: ___________________
   Các cột: ________________________________________________

   Trong database, đây sẽ là tên các COLUMN trong bảng này.

4. Mỗi hàng trong sheet đó đại diện cho điều gì?
   (VD: "Mỗi hàng = 1 nhân viên", "Mỗi hàng = 1 đơn hàng"...)
   Trả lời: ________________________________________________

5. Có cột nào chứa giá trị lặp đi lặp lại không?
   (VD: cột "Phòng ban" → nhiều người cùng phòng, giá trị lặp lại)
   Trả lời: ________________________________________________
   → Trong database, dữ liệu lặp lại nên được tách thành bảng riêng
     và liên kết qua ID.
```

**Phần 2: Chuyển đổi sang thiết kế database**

Dựa trên phân tích ở trên, hãy thiết kế sơ bộ cấu trúc database:

```
Database: _________________________ (đặt tên cho database)

Bảng 1: _________________________
  - Cột 1: _______________________
  - Cột 2: _______________________
  - Cột 3: _______________________
  ...

Bảng 2 (nếu có): _________________
  - Cột 1: _______________________
  ...

Các bảng liên kết với nhau như thế nào?
(Bảng nào dùng ID của bảng nào?)
Trả lời: ________________________________________________
```

---

### Bài B2 — Excel Hay Database?

Với mỗi tình huống dưới đây, hãy quyết định: dùng **Excel** hay **Database**? Và giải thích ngắn gọn lý do.

*(Không có đáp án tuyệt đối — quan trọng là lý giải được)*

---

**Tình huống 1:**
Bạn cần theo dõi chi tiêu cá nhân hàng tháng. Mỗi tháng có khoảng 50–100 khoản chi. Chỉ bạn sử dụng, và bạn muốn có biểu đồ trực quan.

- Lựa chọn: **Excel** / **Database** (khoanh tròn)
- Lý do: _________________________________________________

---

**Tình huống 2:**
Công ty thương mại điện tử cần quản lý 500.000 đơn hàng mỗi tháng. Hệ thống bán hàng, kho, vận chuyển và kế toán đều cần truy cập dữ liệu này cùng lúc.

- Lựa chọn: **Excel** / **Database** (khoanh tròn)
- Lý do: _________________________________________________

---

**Tình huống 3:**
Một team 2 người cần theo dõi danh sách 300 khách hàng tiềm năng trong quá trình bán hàng. Họ dùng chung 1 file, thay nhau cập nhật trạng thái mỗi ngày.

- Lựa chọn: **Excel** / **Database** (khoanh tròn)
- Lý do (nêu cả ưu và nhược điểm của lựa chọn bạn chọn):
  ________________________________________________________

---

**Tình huống 4:**
Bệnh viện cần lưu hồ sơ bệnh nhân: thông tin cá nhân, lịch sử khám bệnh, đơn thuốc, kết quả xét nghiệm. Dữ liệu tuyệt mật, bác sĩ chỉ được xem bệnh nhân của mình, y tá chỉ được xem ca trực của mình.

- Lựa chọn: **Excel** / **Database** (khoanh tròn)
- Lý do: _________________________________________________

---

**Tình huống 5:**
Bộ phận HR cần tạo báo cáo tổng hợp lương nhân viên mỗi tháng. Dữ liệu nguồn từ phần mềm chấm công, cần tính thêm các khoản thưởng/phạt tùy theo quy định từng tháng, rồi format thành file đẹp để trình ban giám đốc.

- Lựa chọn: **Excel** / **Database** / **Cả hai** (khoanh tròn)
- Lý do (giải thích nếu chọn "Cả hai"):
  ________________________________________________________

---

**Tình huống 6 (Thêm — tự đặt):**
Nghĩ ra một tình huống từ công việc thực tế của bạn hoặc của người bạn biết. Mô tả và quyết định dùng gì.

```
Mô tả tình huống:
_______________________________________________________________

Lựa chọn: ___________________
Lý do: ________________________
```

---

## Nhóm C: Đọc Hiểu SQL (Nâng Cao)

> **Lưu ý:** Nhóm C là thử thách — nếu chưa chắc, hãy thử đoán trước, sau đó kiểm tra đáp án. Không cần chạy SQL thật ở tuần này.

### Bài C1 — SQL Nói Gì?

Sử dụng bảng `nhan_vien` ở đầu file (6 nhân viên), đọc mỗi câu SQL và mô tả:
1. Câu SQL này *làm gì*?
2. *Kết quả* trả về trông như thế nào? (Liệt kê dữ liệu cụ thể từ bảng mẫu)

---

**Câu SQL 1:**
```sql
SELECT * FROM nhan_vien;
```
Làm gì: _________________________________________________
Kết quả (có bao nhiêu hàng, cột nào?): ___________________

---

**Câu SQL 2:**
```sql
SELECT ho_ten, luong FROM nhan_vien;
```
Làm gì: _________________________________________________
Kết quả (liệt kê cụ thể): ________________________________

---

**Câu SQL 3:**
```sql
SELECT * FROM nhan_vien WHERE phong_ban = 'IT';
```
Làm gì: _________________________________________________
Kết quả (ai thỏa điều kiện?): ____________________________

---

**Câu SQL 4:**
```sql
SELECT * FROM nhan_vien WHERE luong > 18000000;
```
Làm gì: _________________________________________________
Kết quả (ai thỏa điều kiện? Gợi ý: kiểm tra từng người): __

---

**Câu SQL 5:**
```sql
SELECT ho_ten FROM nhan_vien ORDER BY luong DESC;
```
Làm gì: _________________________________________________
Kết quả (liệt kê tên theo thứ tự đúng): ___________________

---

**Câu SQL 6:**
```sql
SELECT COUNT(*) FROM nhan_vien;
```
Làm gì: _________________________________________________
Kết quả (một con số cụ thể): _____________________________

---

**Câu SQL 7:**
```sql
SELECT * FROM nhan_vien
WHERE phong_ban = 'Kế toán' AND luong > 14000000;
```
Làm gì: _________________________________________________
Kết quả (ai thỏa CẢ HAI điều kiện?): _____________________

---

**Câu SQL 8:**
```sql
SELECT ho_ten, luong FROM nhan_vien
WHERE phong_ban = 'Kinh doanh'
ORDER BY luong DESC;
```
Làm gì: _________________________________________________
Kết quả (liệt kê cụ thể): ________________________________

---

### Bài C2 — Viết SQL Đơn Giản *(Tùy chọn — Thử thách)*

Sử dụng bảng `san_pham` có cấu trúc như sau:

| Tên cột | Kiểu | Ví dụ giá trị |
|---|---|---|
| `id` | Số | 1, 2, 3... |
| `ten_sp` | Chữ | 'iPhone 15', 'Samsung TV'... |
| `danh_muc` | Chữ | 'Điện thoại', 'TV', 'Laptop'... |
| `gia` | Số | 5000000, 15000000... |
| `so_luong_ton` | Số | 0, 50, 200... |

Viết câu SQL tương ứng với mỗi yêu cầu:

**Yêu cầu 1:** "Cho tôi xem tất cả sản phẩm"
```sql
-- Trả lời:
_______________________________________________
```

**Yêu cầu 2:** "Cho tôi xem tên và giá của tất cả sản phẩm"
```sql
-- Trả lời:
_______________________________________________
```

**Yêu cầu 3:** "Cho tôi xem các sản phẩm thuộc danh mục 'Điện thoại'"
```sql
-- Trả lời:
_______________________________________________
```

**Yêu cầu 4:** "Đếm có bao nhiêu sản phẩm trong bảng"
```sql
-- Trả lời:
_______________________________________________
```

**Yêu cầu 5:** "Cho tôi tên và giá sản phẩm, sắp xếp theo giá từ thấp đến cao"
```sql
-- Trả lời:
_______________________________________________
```

**Yêu cầu 6 (Khó hơn):** "Cho tôi xem các sản phẩm còn hàng (số lượng tồn > 0) và có giá dưới 10 triệu"
```sql
-- Trả lời:
_______________________________________________
```

---

## Đáp Án Gợi Ý

*(Chỉ đọc sau khi đã tự làm!)*

---

### Đáp Án Bài A1 — Ghép Cặp

| STT | Khái niệm Excel | Đáp án |
|---|---|---|
| 1 | File workbook (.xlsx) | **G** — Database |
| 2 | Sheet (trang tính) | **D** — Table |
| 3 | Cột (Column A, B, C...) | **A** — Column |
| 4 | Hàng (Row 1, 2, 3...) | **F** — Row / Record |
| 5 | Ô (Cell) | **H** — Field |
| 6 | Data Validation | **J** — Data Type |
| 7 | Filter | **E** — WHERE |
| 8 | Sort (sắp xếp) | **B** — ORDER BY |
| 9 | VLOOKUP / INDEX-MATCH | **I** — JOIN |
| 10 | Pivot Table | **C** — GROUP BY |

---

### Đáp Án Bài A2 — Điền Vào Chỗ Trống

1. **database**
2. **table** (bảng)
3. **column** (cột)
4. **row** (hàng) / record (bản ghi)
5. **field** (trường)
6. **NULL**
7. **primary key** (khóa chính)
8. **SQL**
9. **query** (truy vấn)
10. **PostgreSQL**

---

### Đáp Án Bài A3 — Đúng hay Sai?

| STT | Đ/S | Giải thích |
|---|---|---|
| 1 | **Đ** | Đúng — đây là so sánh cơ bản nhất |
| 2 | **S** | SQL **không** phân biệt hoa/thường — `SELECT` = `select` = `Select` |
| 3 | **Đ** | Đúng — Data Validation có thể bị bỏ qua (copy-paste), Data Type thì không |
| 4 | **S** | PostgreSQL hoàn toàn **miễn phí** — đây là phần mềm mã nguồn mở |
| 5 | **Đ** | Đúng — dấu `;` kết thúc câu lệnh SQL |
| 6 | **S** | NULL **không phải** số 0. NULL = "không có giá trị", khác hoàn toàn với 0 |
| 7 | **S** | Database phù hợp với mọi quy mô — nhiều startup nhỏ dùng database từ ngày đầu |
| 8 | **Đ** | Đúng — DBeaver là giao diện đồ họa (click chuột) cho PostgreSQL |
| 9 | **Đ** | Đúng — row và hàng là tương đương nhau |
| 10 | **Đ** | Đúng — JOIN là phiên bản mạnh hơn của VLOOKUP |

---

### Đáp Án Bài B2 — Excel Hay Database?

**Tình huống 1:** → **Excel**
- Dữ liệu nhỏ (~100 hàng/tháng), 1 người dùng, cần biểu đồ trực quan → Excel là lựa chọn tốt nhất, không cần phức tạp hóa

**Tình huống 2:** → **Database** (bắt buộc)
- 500.000 đơn/tháng vượt xa giới hạn Excel
- Nhiều bộ phận cần truy cập đồng thời
- Cần tích hợp với nhiều hệ thống khác

**Tình huống 3:** → **Database** (tốt hơn) hoặc **Excel** (có thể chấp nhận được)
- 300 khách, 2 người cùng sửa → Excel sẽ gặp vấn đề xung đột phiên bản
- Database giải quyết tốt hơn, nhưng nếu team nhỏ và chấp nhận quy trình "1 người sửa, 1 người đợi" thì Excel vẫn dùng được

**Tình huống 4:** → **Database** (bắt buộc)
- Yêu cầu phân quyền nghiêm ngặt → chỉ database làm được
- Dữ liệu y tế tuyệt mật → không thể dùng file Excel chia sẻ

**Tình huống 5:** → **Cả hai** (Database + Excel)
- Database: lưu trữ dữ liệu gốc từ phần mềm chấm công, tính toán lương
- Excel: format kết quả đẹp, tạo báo cáo trình bày cho ban giám đốc
- Đây là mô hình phổ biến nhất trong thực tế!

---

### Đáp Án Bài C1 — SQL Nói Gì?

**Câu 1:** `SELECT * FROM nhan_vien;`
- Làm gì: Lấy **tất cả** dữ liệu từ bảng nhân viên (`*` = tất cả cột)
- Kết quả: 6 hàng, 6 cột (id, ho_ten, phong_ban, luong, ngay_sinh, email)

**Câu 2:** `SELECT ho_ten, luong FROM nhan_vien;`
- Làm gì: Lấy **chỉ cột ho_ten và luong** từ bảng nhân viên
- Kết quả: 6 hàng, 2 cột:
  ```
  Trần Thị Mai   | 15,000,000
  Nguyễn Văn An  | 20,000,000
  Lê Thị Bình    | 18,000,000
  Phạm Minh Châu | 25,000,000
  Hoàng Thị Dung | 13,000,000
  Võ Văn Em      | 22,000,000
  ```

**Câu 3:** `SELECT * FROM nhan_vien WHERE phong_ban = 'IT';`
- Làm gì: Lấy tất cả nhân viên **thuộc phòng IT**
- Kết quả: 1 hàng — chỉ có Phạm Minh Châu (id=4)

**Câu 4:** `SELECT * FROM nhan_vien WHERE luong > 18000000;`
- Làm gì: Lấy nhân viên có **lương trên 18 triệu** (không bao gồm đúng bằng 18 triệu)
- Kết quả: 3 hàng:
  - Nguyễn Văn An: 20,000,000 ✓
  - Phạm Minh Châu: 25,000,000 ✓
  - Võ Văn Em: 22,000,000 ✓
  - *(Lê Thị Bình 18,000,000 — không thỏa vì dùng `>` không phải `>=`)*

**Câu 5:** `SELECT ho_ten FROM nhan_vien ORDER BY luong DESC;`
- Làm gì: Lấy **tên nhân viên**, sắp xếp theo **lương giảm dần**
- Kết quả (theo thứ tự):
  ```
  1. Phạm Minh Châu  (25tr)
  2. Võ Văn Em       (22tr)
  3. Nguyễn Văn An   (20tr)
  4. Lê Thị Bình     (18tr)
  5. Trần Thị Mai    (15tr)
  6. Hoàng Thị Dung  (13tr)
  ```

**Câu 6:** `SELECT COUNT(*) FROM nhan_vien;`
- Làm gì: **Đếm** tổng số hàng trong bảng nhân viên
- Kết quả: `6`

**Câu 7:** `SELECT * FROM nhan_vien WHERE phong_ban = 'Kế toán' AND luong > 14000000;`
- Làm gì: Lấy nhân viên **vừa ở phòng Kế toán VÀ có lương trên 14 triệu** (cả 2 điều kiện phải đúng)
- Kết quả: 1 hàng:
  - Trần Thị Mai: Kế toán, 15,000,000 ✓
  - *(Hoàng Thị Dung: Kế toán nhưng lương 13tr < 14tr → không thỏa)*

**Câu 8:** `SELECT ho_ten, luong FROM nhan_vien WHERE phong_ban = 'Kinh doanh' ORDER BY luong DESC;`
- Làm gì: Lấy **tên và lương** nhân viên **phòng Kinh doanh**, sắp theo **lương giảm dần**
- Kết quả:
  ```
  Võ Văn Em      | 22,000,000
  Nguyễn Văn An  | 20,000,000
  ```

---

### Đáp Án Bài C2 — Viết SQL Đơn Giản

```sql
-- Yêu cầu 1: Xem tất cả sản phẩm
SELECT * FROM san_pham;

-- Yêu cầu 2: Chỉ xem tên và giá
SELECT ten_sp, gia FROM san_pham;

-- Yêu cầu 3: Sản phẩm danh mục 'Điện thoại'
SELECT * FROM san_pham WHERE danh_muc = 'Điện thoại';

-- Yêu cầu 4: Đếm số sản phẩm
SELECT COUNT(*) FROM san_pham;

-- Yêu cầu 5: Tên và giá, sắp xếp giá tăng dần
SELECT ten_sp, gia FROM san_pham ORDER BY gia ASC;
-- (ASC = Ascending = tăng dần, đây là mặc định nên có thể bỏ ASC)

-- Yêu cầu 6: Còn hàng VÀ giá < 10 triệu
SELECT * FROM san_pham
WHERE so_luong_ton > 0 AND gia < 10000000;
```

---

*Chúc mừng đã hoàn thành bài tập Tuần 1! Hẹn gặp lại ở Tuần 2 — lần này chúng ta sẽ thực hành thật với PostgreSQL.*
