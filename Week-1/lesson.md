# Tuần 1: Tại Sao Cần Cơ Sở Dữ Liệu?

> **Thời lượng:** 3–4 giờ
> **Yêu cầu trước:** Không cần cài phần mềm gì — tuần này chỉ đọc và suy ngẫm
> **Phương pháp:** Mọi khái niệm mới đều được so sánh với Excel mà bạn đã quen

---

## Mục Tiêu Tuần Này

Sau khi hoàn thành tuần 1, bạn sẽ có thể:

- Giải thích được cơ sở dữ liệu là gì và khác Excel như thế nào
- Nhận ra và định nghĩa 8 thuật ngữ nền tảng: *database, table, column, row, field, data type, SQL, PostgreSQL*
- Đọc và hiểu một câu SQL đơn giản như đọc tiếng Anh thông thường
- Nhận biết khi nào nên dùng Excel và khi nào nên dùng database

---

## Phần 1: Câu Chuyện Bắt Đầu

Hãy để mình kể cho bạn nghe câu chuyện của Linh.

Linh làm phân tích dữ liệu tại một công ty phân phối hàng tiêu dùng. Năm đầu tiên, công ty nhỏ — chỉ 80 nhân viên, 200 khách hàng, vài trăm đơn hàng mỗi tháng. Linh quản lý tất cả trong Excel: một file `quan_ly.xlsx` với vài sheet gọn gàng, mọi thứ rất ổn.

Rồi công ty bắt đầu phát triển nhanh.

Năm thứ hai: 300 nhân viên, 5.000 khách hàng. File Excel của Linh bắt đầu có dấu hiệu "lên cân" — mở mất gần 1 phút, lưu mất thêm 1 phút nữa.

Năm thứ ba: Công ty mua lại một doanh nghiệp khác. Đột nhiên có thêm 800 nhân viên và 30.000 khách hàng cần nhập vào hệ thống. Linh bắt đầu nhận ra Excel không còn đáp ứng được nữa khi:

- **File quá nặng:** File Excel chứa dữ liệu khách hàng nặng 150MB, mỗi lần mở mất gần 3 phút, đôi khi treo máy
- **Nhiều người cùng sửa:** 4 người trong team cùng cập nhật dữ liệu — nhưng mỗi người lưu phiên bản riêng. Không ai biết đâu là phiên bản mới nhất, đâu là dữ liệu chính xác
- **Dữ liệu thiếu nhất quán:** Cùng là "Hà Nội" nhưng có người gõ "Ha Noi", "HÀ NỘI", "hà nội" — báo cáo theo thành phố bị sai hoàn toàn
- **Không thể tự động hóa:** Mỗi tuần Linh phải tay tạo báo cáo doanh thu từ đầu, dù dữ liệu nguồn không thay đổi cách lấy
- **Không có phân quyền:** File lương nhân viên — ai có file là ai xem được, không thể ẩn riêng từng phần

Linh cảm thấy mình đang dùng một cái xe đạp để chuyên chở hàng container.

Điều Linh cần không phải là một file Excel tốt hơn — mà là một **công cụ khác hoàn toàn**, được thiết kế đặc biệt để quản lý lượng dữ liệu lớn, nhiều người dùng, và đảm bảo tính chính xác. Công cụ đó tên là **cơ sở dữ liệu** (database).

> **Tin tốt cho bạn:** Bạn đã có nền tảng rất vững — Excel và database có cùng một *logic* phân tích dữ liệu. Bạn chỉ cần học thêm *ngôn ngữ* mới mà thôi.

---

## Phần 2: Hai Thế Giới, Một Logic — Excel và Database

### 2.1 Bức Tranh Tổng Thể

Trước khi đi vào chi tiết, hãy nhìn bức tranh lớn:

```
FILE EXCEL                               DATABASE (PostgreSQL)
quan_ly_cong_ty.xlsx                     quan_ly_cong_ty
╔═══════════════════════════════╗        ╔══════════════════════════════╗
║                               ║        ║                              ║
║  📄 Sheet: Nhân viên          ║   ↔    ║  📋 Table: nhan_vien         ║
║  📄 Sheet: Phòng ban          ║        ║  📋 Table: phong_ban         ║
║  📄 Sheet: Lương tháng 1      ║        ║  📋 Table: bang_luong        ║
║  📄 Sheet: Lương tháng 2      ║        ║      (gộp thành 1 table,     ║
║  📄 Sheet: Lương tháng 3      ║        ║       có thêm cột "tháng")   ║
║  📄 Sheet: Khách hàng         ║        ║  📋 Table: khach_hang        ║
║  📄 Sheet: Đơn hàng           ║        ║  📋 Table: don_hang          ║
║                               ║        ║                              ║
╚═══════════════════════════════╝        ╚══════════════════════════════╝

Một file Excel workbook          =        Một database
Một sheet trong file             =        Một table trong database
```

**Nhận xét quan trọng:** Để ý rằng 3 sheet "Lương tháng 1/2/3" được gộp thành 1 bảng trong database. Đây là cách database tổ chức dữ liệu thông minh hơn — thay vì tạo sheet mới mỗi tháng, bạn chỉ thêm dữ liệu vào cùng một bảng với thêm một cột "tháng".

---

### 2.2 Khám Phá Từng Khái Niệm Chi Tiết

#### Khái Niệm 1: Database = Workbook (File Excel)

| | Excel | Database |
|---|---|---|
| Thuật ngữ | Workbook / File .xlsx | **Database** (Cơ sở dữ liệu) |
| Ví dụ | `quan_ly_nhan_su.xlsx` | `quan_ly_nhan_su` |
| Chứa gì? | Nhiều sheet | Nhiều table |

**Database** là nơi chứa toàn bộ dữ liệu của một hệ thống — giống như một workbook Excel là nơi chứa toàn bộ dữ liệu của một dự án.

Sự khác biệt: Database không phải một file lưu trên máy tính bình thường — nó được quản lý bởi một phần mềm chuyên dụng (PostgreSQL), luôn sẵn sàng phục vụ nhiều người cùng lúc, không bao giờ "treo" vì quá nặng.

---

#### Khái Niệm 2: Table = Sheet (Trang tính)

```
Sheet "Nhân viên" trong Excel            Table "nhan_vien" trong PostgreSQL
┌──────┬──────────────┬──────────────┐   ┌──────┬──────────────┬──────────────┐
│  A   │      B       │      C       │   │  id  │    ho_ten    │  phong_ban   │
├──────┼──────────────┼──────────────┤   ├──────┼──────────────┼──────────────┤
│  1   │ Trần Thị Mai │ Kế toán      │   │  1   │ Trần Thị Mai │ Kế toán      │
│  2   │ Nguyễn Văn An│ Kinh doanh   │   │  2   │ Nguyễn Văn An│ Kinh doanh   │
│  3   │ Lê Thị Bình  │ Nhân sự      │   │  3   │ Lê Thị Bình  │ Nhân sự      │
└──────┴──────────────┴──────────────┘   └──────┴──────────────┴──────────────┘
```

**Table** (bảng) là đơn vị lưu trữ dữ liệu cơ bản trong database — giống hệt một sheet trong Excel. Mỗi table chứa dữ liệu về một *chủ thể* cụ thể: bảng nhân viên, bảng sản phẩm, bảng đơn hàng...

Sự khác biệt nhỏ: Trong Excel, sheet có thể chứa bất cứ thứ gì — công thức, biểu đồ, text tự do. Table trong database chỉ chứa dữ liệu có cấu trúc nghiêm ngặt.

---

#### Khái Niệm 3: Column = Cột (A, B, C...)

```
Excel: Cột A, B, C...              Database: Column có tên rõ ràng

  A           B           C              id        ho_ten      phong_ban
┌─────────┬───────────┬──────────┐    ┌──────┬────────────┬────────────┐
│  (STT)  │ (Họ tên)  │(Phòng ban│    │  id  │  ho_ten    │ phong_ban  │
│         │           │          │    │      │            │            │
```

**Column** (cột) đại diện cho một *loại thông tin* cụ thể — giống các cột trong Excel, nhưng trong database mỗi cột **bắt buộc phải có tên** (không dùng A, B, C) và **bắt buộc phải khai báo kiểu dữ liệu** (xem khái niệm 6).

Ví dụ trong bảng nhân viên:
- Cột `ho_ten` → chứa họ tên
- Cột `luong` → chứa mức lương
- Cột `ngay_sinh` → chứa ngày sinh
- Cột `email` → chứa địa chỉ email

---

#### Khái Niệm 4: Row / Record = Hàng

```
Mỗi hàng = 1 bản ghi hoàn chỉnh về 1 nhân viên

 id │    ho_ten     │ phong_ban  │   luong    │  ngay_sinh │ email
────┼───────────────┼────────────┼────────────┼────────────┼─────────────────
  1 │ Trần Thị Mai  │ Kế toán    │ 15,000,000 │ 1995-03-20 │ mai.tran@cty.com  ← ROW 1
  2 │ Nguyễn Văn An │ Kinh doanh │ 20,000,000 │ 1990-07-15 │ an.nguyen@cty.com ← ROW 2
  3 │ Lê Thị Bình   │ Nhân sự    │ 18,000,000 │ 1992-11-03 │ binh.le@cty.com   ← ROW 3
  4 │ Phạm Minh Châu│ IT         │ 25,000,000 │ 1988-01-25 │ chau.pham@cty.com ← ROW 4
  5 │ Hoàng Thị Dung│ Kế toán    │ 13,000,000 │ 1996-09-10 │ (trống)           ← ROW 5
  6 │ Võ Văn Em     │ Kinh doanh │ 22,000,000 │ 1993-05-30 │ em.vo@cty.com     ← ROW 6
```

**Row** (hàng) hay **Record** (bản ghi) là một dòng dữ liệu — giống hệt một hàng trong Excel. Mỗi row chứa tất cả thông tin về *một đối tượng* cụ thể: một nhân viên, một sản phẩm, một đơn hàng.

> **Lưu ý:** Ở cột email của hàng 5 (Hoàng Thị Dung), giá trị là `(trống)`. Trong database, giá trị "không có gì" được gọi là **NULL** — đây là khái niệm quan trọng sẽ gặp nhiều về sau.

---

#### Khái Niệm 5: Field = Ô (Cell)

```
Excel: Ô B3 chứa giá trị "Lê Thị Bình"

     A     B               C
1   id    ho_ten          phong_ban
2    1    Trần Thị Mai    Kế toán
3    2    Lê Thị Bình  ←── Ô B3 = Field tại cột ho_ten, hàng thứ 3
4    3    ...
```

**Field** (trường) là một ô dữ liệu cụ thể — giao điểm của một column và một row, giống hệt một cell trong Excel. Ít khi bạn cần dùng từ này trong thực tế, nhưng tốt là biết.

---

#### Khái Niệm 6: Data Type = Data Validation (Kiểu dữ liệu)

Trong Excel, bạn có thể dùng Data Validation để quy định ô chỉ nhận số nguyên, hoặc chỉ nhận ngày tháng. Trong database, khái niệm này được nâng lên thành **bắt buộc** và gọi là **Data Type** (kiểu dữ liệu).

**So sánh:**

| Bạn muốn cột chứa... | Excel (Data Validation) | Database (Data Type) |
|---|---|---|
| Số nguyên (1, 2, 100...) | Validation: Whole number | `INTEGER` |
| Số thập phân (99.99) | Validation: Decimal | `NUMERIC(10,2)` |
| Chữ (tên, địa chỉ...) | Validation: Text length | `VARCHAR(100)` |
| Ngày tháng | Validation: Date | `DATE` |
| Ngày + Giờ | (không có sẵn) | `TIMESTAMP` |
| Đúng/Sai | Validation: List (Có/Không) | `BOOLEAN` |

**Tại sao Data Type quan trọng hơn Data Validation?**

- Data Validation trong Excel có thể bị bỏ qua (copy-paste bỏ qua validation)
- Data Type trong database là **không thể vi phạm** — nếu bạn cố nhập chữ vào cột số, database sẽ từ chối ngay lập tức, không cho lưu

---

#### Khái Niệm 7: WHERE = Filter (Bộ lọc)

Trong Excel, bạn dùng Filter để lọc dữ liệu. Trong SQL, bạn dùng từ khóa `WHERE`.

```
Excel: Filter cột "Phòng ban" = "IT"

        Kết quả:
        ┌────┬───────────────┬──────────┬────────────┐
        │ id │    ho_ten     │phong_ban │   luong    │
        ├────┼───────────────┼──────────┼────────────┤
        │  4 │ Phạm Minh Châu│ IT       │ 25,000,000 │
        └────┴───────────────┴──────────┴────────────┘

SQL:    SELECT * FROM nhan_vien WHERE phong_ban = 'IT';

        Kết quả giống hệt!
```

---

#### Khái Niệm 8: ORDER BY = Sort (Sắp xếp)

```
Excel: Sort cột "Lương" → Largest to Smallest (Z→A)

SQL:   SELECT * FROM nhan_vien ORDER BY luong DESC;
       (DESC = Descending = Giảm dần)
       (ASC  = Ascending  = Tăng dần  ← mặc định)

Kết quả:
 id │    ho_ten     │ phong_ban  │   luong
────┼───────────────┼────────────┼────────────
  4 │ Phạm Minh Châu│ IT         │ 25,000,000  ← cao nhất
  6 │ Võ Văn Em     │ Kinh doanh │ 22,000,000
  2 │ Nguyễn Văn An │ Kinh doanh │ 20,000,000
  3 │ Lê Thị Bình   │ Nhân sự    │ 18,000,000
  1 │ Trần Thị Mai  │ Kế toán    │ 15,000,000
  5 │ Hoàng Thị Dung│ Kế toán    │ 13,000,000  ← thấp nhất
```

---

#### Khái Niệm 9: JOIN = VLOOKUP / INDEX-MATCH

Đây là một trong những khái niệm quan trọng nhất và cũng là điểm mạnh lớn của database so với Excel.

**Vấn đề với Excel:**
```
❌ Cách Excel — Dữ liệu bị lặp lại:
┌──────────────┬──────────────┬─────────────────┐
│  Nhân viên   │  Phòng ban   │  Trưởng phòng   │
├──────────────┼──────────────┼─────────────────┤
│ Trần Thị Mai │ Kế toán      │ Nguyễn Văn Khoa │  ← lặp
│ Hoàng Thị D  │ Kế toán      │ Nguyễn Văn Khoa │  ← lặp
│ Lý Thị C     │ Kế toán      │ Nguyễn Văn Khoa │  ← lặp
│ Phạm Minh C  │ IT           │ Trần Thị Hương  │  ← lặp
│ Bùi Văn D    │ IT           │ Trần Thị Hương  │  ← lặp
└──────────────┴──────────────┴─────────────────┘
→ Khi đổi trưởng phòng Kế toán: phải tìm và sửa 50 ô!
```

**Giải pháp Database — Tách thành 2 bảng, liên kết bằng ID:**
```
✅ Cách Database — Không lặp lại:

Bảng nhan_vien:                     Bảng phong_ban:
┌────┬──────────────┬────────┐      ┌────┬──────────┬─────────────────┐
│ id │    ho_ten    │ pb_id  │      │ id │  ten_pb  │   truong_phong  │
├────┼──────────────┼────────┤      ├────┼──────────┼─────────────────┤
│  1 │ Trần Thị Mai │   1    │──┐   │  1 │ Kế toán  │ Nguyễn Văn Khoa │
│  5 │ Hoàng Thị D  │   1    │──┤──▶│  2 │ IT       │ Trần Thị Hương  │
│  4 │ Phạm Minh C  │   2    │──┘   │  3 │ KD       │ Lê Văn Minh     │
└────┴──────────────┴────────┘      └────┴──────────┴─────────────────┘

→ Đổi trưởng phòng Kế toán: chỉ sửa 1 ô trong bảng phong_ban!
→ JOIN = kết nối 2 bảng qua pb_id (giống VLOOKUP)
```

Hiện tại bạn chưa cần biết cách viết JOIN — chỉ cần hiểu *tại sao* cần nó. Chúng ta sẽ học chi tiết ở Tuần 7.

---

#### Khái Niệm 10: GROUP BY = Pivot Table

```
Excel: Pivot Table
  Row Labels: Phòng ban
  Values:     COUNT of Nhân viên, AVERAGE of Lương

SQL tương đương:
  SELECT phong_ban, COUNT(*), AVG(luong)
  FROM nhan_vien
  GROUP BY phong_ban;

Kết quả:
 phong_ban  │ count │    avg
────────────┼───────┼────────────
 Kế toán    │   2   │ 14,000,000
 Kinh doanh │   2   │ 21,000,000
 Nhân sự    │   1   │ 18,000,000
 IT         │   1   │ 25,000,000
```

GROUP BY sẽ là tuần học yêu thích của bạn — vì bạn đã quen với Pivot Table rồi, và SQL GROUP BY còn mạnh mẽ hơn nhiều!

---

#### Khái Niệm 11: Aggregate Functions = SUM, COUNT, AVERAGE...

| Hàm SQL | Hàm Excel | Ý nghĩa |
|---|---|---|
| `COUNT(*)` | `=COUNTA()` | Đếm số hàng |
| `SUM(luong)` | `=SUM()` | Tính tổng |
| `AVG(luong)` | `=AVERAGE()` | Tính trung bình |
| `MIN(luong)` | `=MIN()` | Giá trị nhỏ nhất |
| `MAX(luong)` | `=MAX()` | Giá trị lớn nhất |

Cú pháp SQL trông khác, nhưng logic hoàn toàn giống Excel. Ví dụ:
- Excel: `=SUM(C2:C100)` → SQL: `SELECT SUM(luong) FROM nhan_vien`
- Excel: `=AVERAGE(C2:C100)` → SQL: `SELECT AVG(luong) FROM nhan_vien`

---

### 2.3 Bảng Tổng Hợp: Excel ↔ Database

| Bạn muốn làm gì? | Trong Excel | Trong Database (SQL) |
|---|---|---|
| Mở dữ liệu | Mở file .xlsx | `SELECT * FROM ten_bang` |
| Lọc dữ liệu | Filter | `WHERE` |
| Sắp xếp | Sort | `ORDER BY` |
| Loại bỏ trùng | Remove Duplicates | `DISTINCT` |
| Tính tổng | `=SUM()` | `SUM()` |
| Đếm | `=COUNTA()` | `COUNT(*)` |
| Trung bình | `=AVERAGE()` | `AVG()` |
| Pivot Table | Pivot Table | `GROUP BY` |
| Tra cứu liên bảng | `VLOOKUP` | `JOIN` |
| Công thức IF | `=IF()` | `CASE WHEN` |
| Nối chuỗi | `=CONCATENATE()` / `&` | `\|\|` |
| Xử lý ô trống | `=IFERROR()` | `COALESCE()` |

---

## Phần 3: Khi Nào Nên Chuyển Sang Database?

Không phải lúc nào cũng cần database — Excel vẫn là công cụ tuyệt vời cho nhiều tình huống. Dưới đây là 5 dấu hiệu cho thấy bạn đang cần database:

### Dấu Hiệu 1: Dữ Liệu Quá Lớn

**Tình huống:** Bộ phận bán hàng cần phân tích lịch sử 3 năm giao dịch — khoảng 2 triệu dòng.

**Với Excel:**
- File .xlsx bị giới hạn 1.048.576 hàng — không đủ chứa!
- Dù chứa được, file nặng vài GB, mở mất 5–10 phút, mọi công thức tính toán cực kỳ chậm
- Máy tính dễ bị treo, mất dữ liệu khi crash

**Với Database:**
- Không có giới hạn số hàng — hàng triệu, thậm chí hàng tỷ bản ghi
- Truy vấn được tối ưu hóa: lọc 2 triệu hàng trong chưa đến 1 giây
- Dữ liệu được lưu an toàn trên server, không mất khi máy treo

> **Ngưỡng thực tế:** Khi dữ liệu vượt quá 50.000–100.000 hàng và cần truy vấn thường xuyên, database bắt đầu có ưu thế rõ rệt.

---

### Dấu Hiệu 2: Nhiều Người Cùng Làm Việc

**Tình huống:** Team 5 người cùng cập nhật danh sách khách hàng trong ngày.

**Với Excel:**
```
9:00  - An mở file, thêm 20 khách mới → lưu thành "khach_hang_v2.xlsx"
9:30  - Bình (không biết An đã sửa) mở file gốc, sửa 15 địa chỉ → lưu đè
10:00 - Ai đúng? File nào là mới nhất?
→ Kết quả: dữ liệu bị mất, mâu thuẫn, không ai tin tưởng file nào
```

**Với Database:**
```
9:00  - An kết nối vào database, thêm 20 khách mới (lưu ngay lập tức)
9:30  - Bình kết nối vào cùng database, thấy 20 khách An vừa thêm,
         sửa 15 địa chỉ (lưu ngay lập tức)
10:00 - Cả team nhìn vào cùng một nguồn dữ liệu duy nhất, luôn cập nhật
→ Không bao giờ có xung đột phiên bản
```

---

### Dấu Hiệu 3: Cần Đảm Bảo Tính Chính Xác Dữ Liệu

**Tình huống:** Báo cáo phân tích theo giới tính nhân viên bị sai vì dữ liệu không nhất quán.

**Với Excel:**
```
Cột "Giới tính" chứa hỗn hợp:
- "Nam", "Nữ"          ← đúng format
- "nam", "nữ"          ← chữ thường
- "NAM", "NỮ"          ← chữ hoa
- "M", "F"             ← tiếng Anh
- "1", "0"             ← dùng số
→ =COUNTIF(A:A,"Nữ") cho kết quả sai!
```

**Với Database:**
```sql
-- Khi tạo bảng, khai báo ràng buộc:
gioi_tinh VARCHAR(3) CHECK (gioi_tinh IN ('Nam', 'Nữ'))

-- Khi ai cố nhập giá trị khác:
→ Database từ chối ngay lập tức với thông báo lỗi rõ ràng
→ Không bao giờ có dữ liệu "Nam", "nam", "NAM" lẫn lộn
```

---

### Dấu Hiệu 4: Cần Bảo Mật Theo Cấp Độ

**Tình huống:** File lương nhân viên — kế toán trưởng cần xem và sửa, quản lý phòng ban chỉ được xem lương người trong phòng, nhân viên thường không được xem gì.

**Với Excel:**
```
Ai có link / được gửi file → xem được tất cả
Password protect? → Dễ bị phá, cồng kềnh khi chia sẻ
→ Thực tế: thường gửi file lương "ẩn cột", không thực sự bảo mật
```

**Với Database:**
```
Phân quyền chi tiết:
- User "ke_toan_truong"  → FULL ACCESS (xem + sửa tất cả)
- User "quan_ly_pb_IT"   → CHỈ xem nhân viên phòng IT
- User "nhan_vien"       → Không có quyền xem bảng lương
→ Mỗi người đăng nhập bằng tài khoản riêng, thấy đúng những gì được phép
```

---

### Dấu Hiệu 5: Cần Tự Động Hóa và Kết Nối Hệ Thống

**Tình huống:** Mỗi tuần phải tạo báo cáo doanh thu — tải dữ liệu từ hệ thống bán hàng, làm sạch, tổng hợp trong Excel, rồi gửi email. Mất 4 tiếng mỗi tuần.

**Với Excel:**
```
Quy trình thủ công:
Export CSV → Mở Excel → Xóa dữ liệu cũ → Import mới → 
Chạy Pivot → Format bảng → Copy sang template → Gửi email
→ Lặp lại mỗi tuần, không bao giờ tự động được hoàn toàn
```

**Với Database:**
```
Database kết nối trực tiếp với hệ thống bán hàng → dữ liệu tự động cập nhật
Báo cáo = 1 câu SQL được lưu sẵn → chạy tự động mỗi sáng thứ Hai
→ Từ 4 tiếng/tuần xuống còn 0 tiếng
```

---

### Tóm Tắt: Excel hay Database?

```
Nên dùng EXCEL khi:              Nên dùng DATABASE khi:
✓ Dữ liệu nhỏ (< 50K hàng)     ✓ Dữ liệu lớn (> 100K hàng)
✓ 1–2 người dùng               ✓ Nhiều người dùng cùng lúc
✓ Phân tích ad-hoc nhanh       ✓ Cần dữ liệu luôn nhất quán
✓ Làm báo cáo trực quan        ✓ Cần phân quyền chi tiết
✓ Dữ liệu cá nhân              ✓ Cần tự động hóa, kết nối app
✓ Prototype, thử nghiệm        ✓ Hệ thống dài hạn, sản xuất
```

> **Sự thật thú vị:** Nhiều doanh nghiệp dùng cả hai — database lưu trữ và xử lý dữ liệu, Excel kết nối vào database để làm báo cáo trực quan. Kỹ năng Excel của bạn sẽ vẫn cực kỳ có giá trị!

---

## Phần 4: PostgreSQL — Công Cụ Chúng Ta Sẽ Học

### PostgreSQL là gì?

Hãy nghĩ về nó thế này:

```
Microsoft Excel   =  Phần mềm xử lý BẢNG TÍNH
PostgreSQL        =  Phần mềm xử lý CƠ SỞ DỮ LIỆU
```

**PostgreSQL** là một **hệ quản trị cơ sở dữ liệu quan hệ** (Relational Database Management System — RDBMS). Tên đầy đủ khá dài và kỹ thuật, nhưng bạn chỉ cần hiểu: đây là phần mềm giúp bạn tạo, quản lý, và truy vấn database.

**"Quan hệ" (Relational) nghĩa là gì?**

"Quan hệ" không phải là khái niệm tình cảm — nó có nghĩa là dữ liệu được tổ chức thành nhiều bảng có thể **liên kết** với nhau. Đây chính là sức mạnh cốt lõi: thay vì nhét tất cả vào 1 bảng khổng lồ, bạn tách thành nhiều bảng nhỏ, mỗi bảng chứa một loại thông tin, rồi liên kết chúng khi cần.

### Tại sao chọn PostgreSQL?

Có nhiều phần mềm database khác nhau (MySQL, SQL Server, Oracle...). Chúng ta chọn PostgreSQL vì:

| Tiêu chí | PostgreSQL |
|---|---|
| Giá | **Hoàn toàn miễn phí** — mã nguồn mở |
| Độ phổ biến | Top 4 database được dùng nhiều nhất thế giới |
| Độ mạnh | Xử lý được các bài toán doanh nghiệp phức tạp |
| Giao diện | Có **DBeaver** — giao diện đồ họa thân thiện, miễn phí |
| Học tập | SQL học được ở đây áp dụng được cho hầu hết database khác |

**Ai đang dùng PostgreSQL?**
- **Apple** — lưu trữ dữ liệu iTunes
- **Instagram** — quản lý dữ liệu hàng tỷ bức ảnh
- **Spotify** — danh sách bài hát và playlist
- **Grab, Shopee** — các siêu ứng dụng tại Đông Nam Á
- Hàng triệu startup và doanh nghiệp vừa nhỏ

### DBeaver — "Giao Diện Excel" của PostgreSQL

Khi học Excel, bạn không phải gõ lệnh — bạn click chuột, kéo thả, dùng menu. Để làm việc với PostgreSQL theo cách tương tự, chúng ta dùng **DBeaver** — một công cụ giao diện đồ họa miễn phí, chạy được trên Windows/Mac/Linux và kết nối được với hầu hết mọi loại database.

```
DBeaver trông như thế này:

┌─────────────────────────┬────────────────────────────────────────┐
│  Database Navigator     │  SQL Editor                            │
│  (bên trái — cây kết    │                                        │
│   nối, giống Windows    │  [Viết SQL ở đây]                      │
│   Explorer)             │  ──────────────────────────────────    │
│                         │  SELECT * FROM nhan_vien;              │
│  > PostgreSQL           │                                        │
│    > Databases          │  [Kết quả hiện ở đây]                  │
│      > hoc_sql          │  ──────────────────────────────────    │
│        > Schemas        │   id  │   ho_ten    │ phong_ban │ luong │
│          > public       │    1  │ Trần Thị Mai│ Kế toán  │ 15tr  │
│            > Tables     │    2  │ Nguyễn V. An│ KD       │ 20tr  │
│              nhan_vien  │                                        │
│              san_pham   │  Ctrl+Enter = chạy câu SQL             │
│                         │  Alt+X      = chạy toàn bộ script      │
└─────────────────────────┴────────────────────────────────────────┘
Bên trái:                          Bên phải:
- Cây kết nối database             - Viết câu SQL ở phần trên
  (mở rộng để xem bảng,            - Nhấn Ctrl+Enter để chạy
   cột, dữ liệu)                   - Kết quả hiện ở phần dưới
                                   - Giống Formula Bar + bảng kết
                                     quả trong Excel
```

Tuần sau chúng ta sẽ cài đặt PostgreSQL và DBeaver — bạn sẽ thấy ngay rằng kết nối chúng với nhau rất đơn giản.

---

## Phần 5: SQL — Ngôn Ngữ Giao Tiếp Với Database

### SQL là gì?

**SQL** viết tắt của **Structured Query Language** — Ngôn ngữ Truy vấn Có Cấu trúc.

Đây là "ngôn ngữ" bạn dùng để nói chuyện với database — giống như công thức Excel là cách bạn "nói chuyện" với Excel.

**Điều quan trọng cần biết ngay:**

> SQL **không phải** ngôn ngữ lập trình phức tạp như Python hay Java. SQL gần với tiếng Anh thông thường hơn bất kỳ ngôn ngữ máy tính nào khác.

Hãy so sánh:
```
Python (lập trình):
for row in cursor.execute("SELECT * FROM employees"):
    if row['salary'] > 15000000:
        print(row['name'])

SQL (truy vấn):
SELECT ho_ten FROM nhan_vien WHERE luong > 15000000;
```

SQL dễ đọc hơn nhiều phải không?

### Quy Tắc Cơ Bản của SQL

**1. Kết thúc bằng dấu chấm phẩy `;`**
```sql
SELECT * FROM nhan_vien;   ← đúng
SELECT * FROM nhan_vien    ← thiếu dấu ;
```

**2. Không phân biệt CHỮ HOA và chữ thường**
```sql
SELECT * FROM nhan_vien;
select * from nhan_vien;
Select * From Nhan_Vien;
-- Ba câu trên hoàn toàn giống nhau!
```

**3. Quy ước: Viết từ khóa SQL bằng CHỮ HOA**
```sql
SELECT ho_ten FROM nhan_vien WHERE luong > 15000000;
-- SELECT, FROM, WHERE → chữ HOA (từ khóa SQL)
-- ho_ten, nhan_vien, luong → chữ thường (tên bảng/cột của bạn)
```

**4. Comment (ghi chú) bắt đầu bằng `--`**
```sql
-- Đây là ghi chú, SQL sẽ bỏ qua dòng này
SELECT * FROM nhan_vien; -- Ghi chú cuối dòng cũng được
```

### SQL Đọc Như Tiếng Anh

Đây là điều thú vị nhất về SQL. Hãy đọc các câu dưới đây như tiếng Anh tự nhiên:

| Câu SQL | Dịch sang tiếng Anh | Ý nghĩa tiếng Việt |
|---|---|---|
| `SELECT * FROM nhan_vien` | Select all from employees | Lấy tất cả từ bảng nhân viên |
| `SELECT ho_ten, luong FROM nhan_vien` | Select name, salary from employees | Lấy tên và lương từ bảng nhân viên |
| `SELECT * FROM nhan_vien WHERE phong_ban = 'IT'` | Select all from employees where department is IT | Lấy tất cả nhân viên phòng IT |
| `SELECT * FROM nhan_vien WHERE luong > 15000000` | Select all from employees where salary > 15M | Lấy nhân viên có lương trên 15 triệu |
| `SELECT ho_ten FROM nhan_vien ORDER BY luong DESC` | Select name from employees, order by salary descending | Lấy tên, sắp xếp theo lương giảm dần |
| `SELECT COUNT(*) FROM nhan_vien` | Count all from employees | Đếm tổng số nhân viên |

### Thử Thách Nhỏ — Đoán Trước Khi Đọc Đáp Án

Với bảng `nhan_vien` có các cột: `id, ho_ten, phong_ban, luong, ngay_sinh, email`

Câu hỏi: Ba câu SQL sau đây *làm gì*? Hãy đoán trước khi nhìn xuống đáp án.

```sql
-- Câu 1:
SELECT DISTINCT phong_ban FROM nhan_vien;

-- Câu 2:
SELECT ho_ten, luong FROM nhan_vien
WHERE phong_ban = 'Kế toán'
ORDER BY luong DESC;

-- Câu 3:
SELECT COUNT(*) FROM nhan_vien
WHERE luong > 18000000;
```

*(Suy nghĩ vài giây...)*

**Đáp án:**
- **Câu 1:** Liệt kê tất cả phòng ban (DISTINCT = không trùng lặp). Kết quả: `Kế toán, Kinh doanh, Nhân sự, IT`
- **Câu 2:** Xem tên và lương nhân viên phòng Kế toán, sắp xếp lương từ cao đến thấp. Kết quả: `Trần Thị Mai (15tr), Hoàng Thị Dung (13tr)`
- **Câu 3:** Đếm số nhân viên có lương trên 18 triệu. Kết quả: `3` (Nguyễn Văn An, Phạm Minh Châu, Võ Văn Em)

Nếu bạn đoán đúng — chúc mừng! Bạn vừa "đọc SQL" lần đầu tiên.
Nếu chưa đúng — hoàn toàn bình thường, đây mới là tuần 1!

---

## Tóm Tắt Tuần 1

### Từ Vựng Mới Đã Học

| Thuật ngữ | Định nghĩa ngắn | Tương đương Excel |
|---|---|---|
| **Database** | Nơi chứa toàn bộ dữ liệu | Workbook (.xlsx file) |
| **Table** | Một tập dữ liệu có cấu trúc | Sheet (trang tính) |
| **Column** | Một loại thông tin | Cột (A, B, C...) |
| **Row / Record** | Một mục dữ liệu | Hàng (1, 2, 3...) |
| **Field** | Một giá trị cụ thể | Ô (Cell) |
| **Data Type** | Quy định loại giá trị | Data Validation |
| **NULL** | Không có giá trị (ô trống) | Ô trống |
| **SQL** | Ngôn ngữ giao tiếp với DB | Công thức Excel |
| **PostgreSQL** | Phần mềm quản lý database | Microsoft Excel (engine) |
| **DBeaver** | Giao diện đồ họa để làm việc với database | Giao diện Excel |
| **Query** | Câu lệnh SQL | Công thức |
| **Primary Key** | Mã định danh duy nhất cho mỗi hàng | Cột STT không trùng |

---

### Checklist Tự Kiểm Tra

Trước khi chuyển sang Tuần 2, hãy tự hỏi:

- [ ] Tôi có thể giải thích tại sao database hữu ích hơn Excel khi dữ liệu lớn
- [ ] Tôi biết database, table, column, row là gì
- [ ] Tôi hiểu data type là gì và tại sao quan trọng
- [ ] Tôi biết PostgreSQL là phần mềm gì và DBeaver là gì
- [ ] Tôi có thể đọc và hiểu một câu `SELECT ... FROM ... WHERE ...` đơn giản
- [ ] Tôi đã làm ít nhất Bài A và Bài B trong file `exercises.md`

Nếu có mục nào chưa chắc — hãy đọc lại phần tương ứng trước khi sang tuần 2.

---

### Chuẩn Bị Cho Tuần 2

Tuần sau chúng ta sẽ **thực hành thật** — cài PostgreSQL, kết nối DBeaver, và gõ câu SQL đầu tiên.

**Việc cần làm trước Tuần 2:**
1. Đọc phần cài đặt trong `plan.md` (Tuần 2, mục 2.1) để biết cần chuẩn bị gì
2. Đảm bảo máy tính có ít nhất 4GB RAM và 2GB dung lượng trống
3. Nếu có thể, tải trước bộ cài PostgreSQL (link trong plan.md Tuần 2) để tiết kiệm thời gian

**Mục tiêu Tuần 2:** Kết thúc buổi học, bạn sẽ tự tay gõ được câu SQL và nhìn thấy kết quả trả về từ database — khoảnh khắc đó sẽ rất thú vị!

---

*Hẹn gặp lại ở Tuần 2!*
