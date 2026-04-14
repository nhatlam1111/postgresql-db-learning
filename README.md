# 📚 PostgreSQL Database Learning

Chương trình học **PostgreSQL từ cơ bản đến nâng cao** dành cho người mới bắt đầu, sử dụng **Excel làm cầu nối** để dễ hiểu các khái niệm.

---

## 🎯 Mục Tiêu

- Hiểu rõ cơ sở dữ liệu (CSDL) hoạt động như thế nào
- Từ làm quen công cụ → viết các query phức tạp
- Áp dụng vào dự án thực tế
- Dễ dàng chuyển đổi skills từ Excel sang SQL

---

## 👥 Đối Tượng

- Người **chưa từng học lập trình** nhưng **giỏi Excel**
- Muốn nâng cấp kỹ năng phân tích dữ liệu
- Sẵn sàng tập trung 3–5 giờ/tuần để học và thực hành

---

## 📂 Cấu Trúc Thư Mục

```
postgresql-db-learning/
├── README.md                 ← Bạn đang xem file này
├── plan.md                  ← Kế hoạch chi tiết 10 tuần
├── requirement.md           ← Yêu cầu cài đặt, công cụ
├── .gitignore
│
├── Week-1/                  ← Tuần 1: Tại sao cần CSDL?
│   ├── lesson.md           ← Bài học lý thuyết
│   ├── examples.sql        ← Ví dụ minh họa
│   └── exercises.md        ← Bài tập thực hành
│
├── Week-2/                  ← Tuần 2: Cài đặt & Làm quen công cụ
│   ├── lesson.md
│   ├── examples.sql
│   └── exercises.md
│
├── Week-3/                  ← Tuần 3: Tạo bảng & Nhập dữ liệu
│   ├── lesson.md
│   ├── examples.sql
│   ├── exercises.md
│   └── type_casting.md     ← 📎 Tham khảo thêm: Type Casting chi tiết
│
├── Week-4/                  ← Tuần 4: SELECT cơ bản
│   ├── lesson.md
│   ├── examples.sql
│   └── exercises.md
│
├── temp/                    ← Folder tạm để lưu notes, handover...
│   ├── handover.md
│   └── Week-*/plan.md
│
└── .claude/
    └── CLAUDE.md           ← Hướng dẫn cho AI assistant
```

---

## 📖 Nội Dung Học

### **Tuần 1: Tại Sao Cần Cơ Sở Dữ Liệu?**
- So sánh Excel vs CSDL
- Thuật ngữ nền tảng (Database, Table, Column, Row...)
- Tại sao chọn PostgreSQL?

### **Tuần 2: Cài Đặt PostgreSQL & Làm Quen Công Cụ**
- Cài đặt PostgreSQL trên máy
- Sử dụng pgAdmin (giao diện quản lý)
- Tạo kết nối đầu tiên

### **Tuần 3: Tạo Bảng & Nhập Dữ Liệu**
- Thiết kế bảng từ đầu
- Kiểu dữ liệu phổ biến (INTEGER, TEXT, DATE, BOOLEAN, NUMERIC...)
- **Chuyển đổi kiểu dữ liệu** (Type Casting) → [Xem chi tiết](Week-3/type_casting.md)
- INSERT dữ liệu vào bảng

### **Tuần 4: Truy Vấn Dữ Liệu — SELECT Cơ Bản**
- Câu lệnh SELECT đầu tiên
- Chọn cột cụ thể, tính toán trong query
- Alias (đặt tên lại cột)
- DISTINCT (loại bỏ trùng lặp)
- Hàm chuỗi, số, ngày cơ bản

### **Tuần 5: Lọc & Sắp Xếp Dữ Liệu**
- WHERE clause (lọc điều kiện)
- ORDER BY (sắp xếp)
- LIMIT (giới hạn số bản ghi)

### **Tuần 6: Hàm Tổng Hợp & GROUP BY**
- COUNT, SUM, AVG, MIN, MAX
- GROUP BY (tổng hợp theo nhóm)
- HAVING (lọc nhóm)

### **Tuần 7: Kết Nối Nhiều Bảng — JOIN**
- INNER JOIN
- LEFT JOIN, RIGHT JOIN
- FULL OUTER JOIN

### **Tuần 8: Truy Vấn Nâng Cao & Subquery**
- Subquery (truy vấn con)
- UNION (hợp dữ liệu từ nhiều bảng)
- CTE (Common Table Expressions)

### **Tuần 9: Cập Nhật & Quản Lý Dữ Liệu**
- UPDATE (sửa dữ liệu)
- DELETE (xóa dữ liệu)
- Transactions (giao dịch)

### **Tuần 10: Dự Án Tổng Hợp**
- Xây dựng CSDL từ đầu
- Viết query phức tạp
- Giải quyết các bài toán thực tế

---

## 🚀 Cách Sử Dụng Repo Này

### 1. **Bắt đầu học từ Tuần 1**
```
1. Đọc file lesson.md để hiểu lý thuyết
2. Chạy các ví dụ trong examples.sql
3. Làm bài tập trong exercises.md
4. Kiểm tra lại bài học tuần sau
```

### 2. **Chuẩn Bị Công Cụ**
Xem file [`requirement.md`](requirement.md) để biết cần cài đặt gì:
- PostgreSQL server
- pgAdmin hoặc công cụ SQL client khác
- (Optional) DBeaver cho giao diện hiện đại hơn

### 3. **Tham Khảo Nhanh**
Cần tra cứu cách chuyển đổi kiểu dữ liệu? → [Xem Type Casting Guide](Week-3/type_casting.md)

---

## 📎 Tài Liệu Tham Khảo Bổ Sung

| File | Mô tả |
|---|---|
| [Week-3/type_casting.md](Week-3/type_casting.md) | CAST, ::, TO_CHAR, TO_DATE, TO_NUMBER — đầy đủ ví dụ |

---

## 💡 Phương Pháp Học

### **Lấy Excel Làm Cầu Nối**
Mỗi khái niệm PostgreSQL sẽ được so sánh với thao tác tương ứng trong Excel:

| Excel | PostgreSQL | Giải thích |
|---|---|---|
| **Sheet** | **Table** | Nơi chứa dữ liệu có cấu trúc |
| **Cột A, B, C** | **Columns** | Loại thông tin (tên, tuổi, lương) |
| **Filter** | **WHERE** | Lọc dữ liệu theo điều kiện |
| **Pivot Table** | **GROUP BY** | Tổng hợp dữ liệu theo nhóm |
| **VLOOKUP** | **JOIN** | Kết nối dữ liệu từ nhiều sheet/bảng |

### **Học Kết Hợp**
- 🧠 **Lý thuyết** (30%): Hiểu khái niệm
- ✏️ **Ví dụ** (30%): Chạy query mẫu
- 💪 **Bài tập** (40%): Tự viết query, thử sai

### **Thời Gian Học**
- ⏱️ **3–5 giờ/tuần** để theo kịp
- 🔄 **Ôn tập**: Mỗi 2 tuần ôn lại kiến thức cũ
- 📊 **Dự án nhỏ**: Tuần 5, Tuần 8, Tuần 10

---

## 📚 Tài Liệu Tham Khảo

### **Chính Thức**
- [PostgreSQL Official Documentation](https://www.postgresql.org/docs/)
- [SQL Tutorial – w3schools](https://www.w3schools.com/sql/)

### **Hướng Dẫn Chi Tiết**
- [PostgreSQL Data Type Formatting](https://www.postgresql.org/docs/current/functions-formatting.html)
- [PostgreSQL Date/Time Functions](https://www.postgresql.org/docs/current/functions-datetime.html)

### **Công Cụ**
- **pgAdmin**: https://www.pgadmin.org/
- **DBeaver**: https://dbeaver.io/
- **PostgreSQL**: https://www.postgresql.org/download/

---

## 🎓 Các Giai Đoạn Học Tập

### **Giai Đoạn 1: Tìm Hiểu (Tuần 1–3)**
✅ Biết CSDL là gì, cài đặt công cụ, tạo bảng đầu tiên

### **Giai Đoạn 2: Truy Vấn Cơ Bản (Tuần 4–5)**
✅ SELECT, WHERE, ORDER BY — đủ để làm việc với dữ liệu

### **Giai Đoạn 3: Phân Tích Nâng Cao (Tuần 6–8)**
✅ GROUP BY, JOIN, Subquery — giải quyết bài toán phức tạp

### **Giai Đoạn 4: Thực Chiến (Tuần 9–10)**
✅ UPDATE/DELETE, Transactions, Dự án tổng hợp

---

## ❓ Câu Hỏi Thường Gặp

### **P: Tôi chưa biết lập trình, có học được không?**
A: Có! Khóa này được thiết kế dành riêng cho người chưa có background lập trình. Excel là nền tảng đủ rồi.

### **P: Cần bao lâu để thành thạo?**
A: Khoảng 8–10 tuần nếu học bài bản. Sau đó, cần thực hành thêm trên dự án thực tế.

### **P: Tôi quên cú pháp WHERE clause rồi?**
A: Quay lại Tuần 5 và ôn lại nhanh. Repo này được tổ chức theo tuần để dễ tham khảo lại.

### **P: Phải code trên máy tính?**
A: Có, bạn cần cài PostgreSQL + pgAdmin (miễn phí). Sau đó, mở pgAdmin và copy-paste query từ file .sql.

### **P: Có support không?**
A: Repo này là tài liệu tự học. Nếu gặp lỗi, hãy:
1. Đọc lại bài học
2. So sánh code với ví dụ
3. Tìm trên Google hoặc PostgreSQL docs

---

## 📝 Hướng Dẫn Tự Học

### **Mỗi Tuần Làm Như Sau:**

1. **Thứ 2–3: Đọc Bài Học**
   - Mở `Week-X/lesson.md`
   - Đọc lý thuyết từng phần
   - Vẽ sơ đồ hoặc note lại khái niệm chính

2. **Thứ 4–5: Chạy Ví Dụ**
   - Mở pgAdmin
   - Copy query từ `examples.sql`
   - Chạy từng câu 1, quan sát kết quả
   - Thử sửa query để hiểu sâu hơn

3. **Thứ 6–7: Làm Bài Tập**
   - Mở `exercises.md`
   - Tự viết query (không copy-paste!)
   - Kiểm tra kết quả
   - Ghi chú những chỗ khó

4. **Chủ Nhật: Ôn Lại**
   - Ôn lại bài học tuần này
   - Ôn 1 bài tuần trước (để ghi nhớ lâu)

---

## 🎯 Mục Tiêu Cuối Cùng

Sau khóa học này, bạn sẽ có thể:

✅ Thiết kế bảng CSDL từ đầu  
✅ Viết query SELECT phức tạp (JOIN, GROUP BY, Subquery)  
✅ Import/Export dữ liệu an toàn  
✅ Phân tích dữ liệu nhanh hơn Excel nhiều lần  
✅ Tự học thêm các kỹ năng PostgreSQL khác  

---

## 📞 Liên Hệ & Phản Hồi

Nếu bạn:
- Phát hiện lỗi trong tài liệu
- Muốn đề xuất thêm nội dung
- Có câu hỏi về bài học

**Hãy tạo Issue hoặc Pull Request** trên repository này.

---

## 📄 License

Tài liệu này được viết để phục vụ mục đích giáo dục. Tự do sử dụng, chia sẻ, và chỉnh sửa cho mục đích cá nhân hoặc giáo dục.

---

## 📅 Tiến Độ Học

| Tuần | Chủ Đề | Trạng Thái |
|---|---|---|
| 1 | Tại sao cần CSDL? | ✅ |
| 2 | Cài đặt & Công cụ | ✅ |
| 3 | Tạo bảng & Nhập dữ liệu | ✅ |
| 4 | SELECT cơ bản | ✅ |
| 5 | WHERE & ORDER BY | 📝 |
| 6 | GROUP BY & Aggregate | 📝 |
| 7 | JOIN | 📝 |
| 8 | Subquery & CTE | 📝 |
| 9 | UPDATE & DELETE | 📝 |
| 10 | Dự án tổng hợp | 📝 |

**Chú thích:** ✅ Hoàn thành | 📝 Đang soạn | 🔳 Chưa bắt đầu

---

**Happy Learning! 🎉**

*Cập nhật lần cuối: Tháng 4, 2026*
