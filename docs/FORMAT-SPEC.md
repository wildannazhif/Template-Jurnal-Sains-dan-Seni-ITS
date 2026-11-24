# Spesifikasi Format — Jurnal Sains dan Seni ITS

Dokumen ini adalah **sumber kebenaran** format repo ini. Setiap angka diukur langsung dari template resmi ITS, bukan dari kebiasaan LaTeX atau perkiraan.

## Sumber pengukuran

| Berkas | Isi | Dipakai untuk |
|---|---|---|
| `reference/template-its.doc` | Template Word resmi DRPM ITS (`3a.-Templat-artikel-Jurnal-Sains-dan-Seni-ITS.doc`) | Nama style, margin, kolom, spasi paragraf, ukuran style |
| `reference/template-its.pdf` | Render PDF resmi (Microsoft Word for Microsoft 365, 2024-02-02) | Ukuran huruf ter-render, posisi (bbox), pitch baris, garis tabel |

Cara ukur: `python-docx` (styles + `sectPr` + `w:cols`) untuk `.doc` (dikonversi ke `.docx` via LibreOffice), dan PyMuPDF (`get_text("dict")`, `get_drawings`) untuk `.pdf`. Catatan pengukuran mentah ada di `docs/docx-spec.txt` dan `docs/spec-extract.txt`.

> Catatan: halaman 5 PDF resmi berukuran Letter (612×792 pt) dan kosong — itu artefak section break terakhir di `.doc`, bukan bagian dari format. Format yang berlaku adalah A4 (hal. 1–4).

## 1. Halaman dan margin

| Elemen | Nilai | Sumber |
|---|---|---|
| Kertas | A4, 210 × 297 mm (595,3 × 841,9 pt) | `sectPr/pgSz` |
| Margin atas | 50,5 pt (17,8 mm) | `pgMar top=1009` twips |
| Margin bawah | 50,5 pt (17,8 mm) | `pgMar bottom=1009` twips |
| Margin kiri | 46,8 pt (16,5 mm) | `pgMar left=936` twips |
| Margin kanan | 46,8 pt (16,5 mm) | `pgMar right=936` twips |
| Lebar teks | 501,7 pt (176,9 mm) | 595,3 − 2×46,8 |
| Tinggi teks | 740,9 pt | 841,9 − 2×50,5 |
| Header: jarak dari tepi atas | 21,6 pt | `pgMar header=431` twips; teks header di y = 21,9 pt (PDF) |
| Footer | tidak ada (`footer=0`) | `pgMar` |

## 2. Kolom

| Elemen | Nilai | Sumber |
|---|---|---|
| Jumlah kolom | 2, lebar sama | `w:cols num=2 equalWidth` |
| Jarak antar-kolom | 288 twips = **14,4 pt** | `w:cols space=288` |
| Lebar tiap kolom | **243,65 pt** (85,9 mm) | (501,7 − 14,4) / 2 |
| Kolom kiri (PDF) | x = 46,8 → 293,0 pt | bbox teks |
| Kolom kanan (PDF) | x = 304,9 → 551,1 pt | bbox teks |
| Tanpa garis pemisah kolom | `sep=false` | `w:cols` |

## 3. Huruf

Seluruh dokumen memakai **Times New Roman**, warna hitam (`000000`) di semua teks. Tidak ada warna lain.

| Elemen | Ukuran | Gaya | Leading (pitch baris terukur) |
|---|---|---|---|
| Tubuh teks | 10 pt | regular | 12,0–12,2 pt |
| Judul artikel | 24 pt | regular (+ kata tertentu *italic*) | 27,6 pt |
| Penulis / afiliasi / e-mail | 11 pt | regular (`e-mail` italic) | 12,6 pt |
| Abstrak | 9 pt | **bold** seluruhnya | 10,4 pt |
| Kata kunci | 9 pt | **bold** seluruhnya | 10,4 pt |
| Heading bab | 10 pt | regular, KAPITAL | — |
| Subbagian | 10 pt | *italic* | — |
| Sub-subbagian | 10 pt | *italic* | — |
| Heading tingkat 4 | 9 pt | *italic* | — |
| Heading tingkat 5 | 9 pt | regular | — |
| Keterangan gambar | 8 pt | regular | — |
| Judul tabel | 8 pt | regular | — |
| Isi tabel | 8 pt | regular | — |
| Daftar pustaka | 8 pt | regular | 9,2 pt, tanpa jarak antar-entri |
| Catatan kaki | 8 pt | regular | — |
| Running head | 10 pt | regular | — |
| Huruf awal paragraf (drop cap "D") | 28 pt | regular | — |
| Tulisan di dalam gambar | 8 pt | (open type font) | — |

Font di PDF resmi: `TimesNewRomanPSMT`, `TimesNewRomanPS-BoldMT`, `TimesNewRomanPS-ItalicMT`, `TimesNewRomanPS-BoldItalicMT`; sisipan `ArialMT`/`Arial-ItalicMT` hanya pada spasi pemisah tertentu. Di LaTeX dipakai `newtxtext`/`newtxmath` (klon Times; fallback `mathptmx`).

## 4. Paragraf tubuh

| Elemen | Nilai | Sumber |
|---|---|---|
| Perataan | Justify (rata kiri-kanan) | style `Text` |
| Indent baris pertama | **10,1 pt** (0,35 cm) | style `Text` first indent; terukur 57,0 − 46,8 = 10,2 pt di PDF |
| Jarak antar-paragraf | 0 pt (pemisah hanya indent) | style `Text` |
| Line spacing (Word) | 1,05 | style `Text` — tetapi pitch ter-render 12 pt, jadi LaTeX memakai leading standar 12 pt |
| Spasi setelah titik/koma | 1 spasi | §III.F template |
| Penekanan | *italic*, bukan underline | §I template |

## 5. Judul, penulis, running head

Judul dan penulis di template Word berada di **textbox mengambang** di atas kolom (frame), bukan di aliran kolom:

| Elemen | Nilai |
|---|---|
| Judul | 24 pt, rata tengah, lebar frame 468 pt rata tengah halaman; 2 baris pada contoh. Kata `Template` dimiringkan. |
| Penulis | Style `Authors`: 11 pt, rata tengah, spasi sesudah 16 pt (320 twips). Isi: baris 1 nama penulis, baris 2 afiliasi, baris 3 `e-mail` (miring) + `: alamat`. Lebar frame 453,6 pt. |
| Jarak judul → penulis | ~26 pt (dasar baris judul kedua y≈103 pt → penulis y≈129 pt) |
| Jarak penulis → abstrak | ~28 pt (e-mail y≈154 pt → abstrak y≈193 pt) |
| Running head | Di **semua** halaman termasuk hal. 1. Kiri: `JURNAL SAINS DAN SENI ITS Vol. X, No. Y (TAHUN), 2337-3520 (2301-928X Print)`, 10 pt. Kanan: nomor halaman, 10 pt. Tanpa garis. Jarak header dari tepi atas 21,6 pt. |

## 6. Abstrak dan kata kunci

| Elemen | Nilai |
|---|---|
| Abstrak | Style `Abstract`: 9 pt **bold**, justify, indent baris pertama 10,1 pt (di render: baris pertama mulai di margin kiri karena label `Abstrak`), spasi sebelum 1 pt. Label `Abstrak` bold-italic + em dash tanpa spasi: `Abstrak—...`. Satu paragraf, 100–300 kata, tanpa acuan daftar pustaka, Bahasa Indonesia baku. |
| Jeda abstrak → kata kunci | Satu baris kosong 9 pt (paragraf kosong bergaya Abstract; pitch 10,4 pt). Terukur: baris terakhir abstrak y=369,3 pt → `Kata Kunci` y=390,9 pt. |
| Kata kunci | Style `IndexTerms`: 9 pt **bold**, justify, indent baris pertama 10,1 pt. Label `Kata Kunci` bold-italic + em dash: `Kata Kunci—...`. Maksimal 5 buah, urutan alfabet, dipisah koma, Title Case. |

## 7. Heading

| Tingkat | Style Word | Format | Spasi sebelum / sesudah |
|---|---|---|---|
| Bab (`\section`) | Heading 1 | 10 pt regular, **KAPITAL**, rata tengah, nomor Romawi `I.` | 12 pt / 4 pt |
| Subbagian (`\subsection`) | Heading 2 | 10 pt *italic*, rata kiri, nomor huruf `A.` | 6 pt / 3 pt |
| Sub-subbagian (`\subsubsection`) | Heading 3 | 10 pt *italic*, rata kiri, nomor Arab | — (bawaan) |
| Tingkat 4 (`\paragraph`) | Heading 4 | 9 pt *italic* | 12 pt / 3 pt |
| Tingkat 5 (`\subparagraph`) | Heading 5 | 9 pt regular | 12 pt / 3 pt |
| Lampiran / Ucapan Terima Kasih / Daftar Pustaka | Reference Head | 10 pt regular, KAPITAL, rata tengah (tanpa nomor) | seperti Heading 1 |

Judul bab ditulis kapital di naskah template (`PENDAHULUAN`); di LaTeX, kelas mengubah judul menjadi kapital otomatis.

## 8. Gambar

| Elemen | Nilai |
|---|---|
| Lebar | 1 kolom (3½ inci = 8,89 cm) atau 2 kolom (7¹⁄₁₆ inci = 17,93 cm); tidak kurang dari 1 kolom. Contoh: 248,2 × 174,4 pt (kolom penuh). |
| Resolusi | Foto/grayscale 400 dpi, tanpa kompresi, 8 bit/piksel. |
| Garis tepi | Tidak ada. |
| Keterangan | Style `Figure Caption` (di `.doc` tertulis sebagai `FootnoteText`): **8 pt**, rata kiri-kanan, **di bawah** gambar. Format: `Gambar 1.  <teks>` — dua spasi setelah titik. Nomor Arab. Gambar berbagian dilabel `(a)`, `(b)` di dalam gambar. |
| Rujukan | Setiap gambar yang dirujuk harus ada, dan setiap gambar harus dirujuk. Label sumbu memakai kata, bukan simbol. |

## 9. Tabel

| Elemen | Nilai |
|---|---|
| Lebar | 1 kolom (8,89 cm) atau 2 kolom (17,93 cm). Contoh Tabel 1: 248,4 pt, kolom `Id` 49,65 pt, `Pasangan` 85,5 pt, `Rata-Rata CR*` ±113 pt. |
| Judul | Style `Table Title`: **8 pt, rata tengah, di atas** tabel, dua baris: `Tabel 1.` lalu judulnya (`Nilai constant ratio untuk berbagai kombinasi pasangan`). |
| Isi | **8 pt**, sel rata tengah (`w:sz=16` half-point, `jc=center`). |
| Garis | **Tanpa garis vertikal.** Garis horizontal: **ganda** di atas (dua garis 0,6 pt berjarak 0,6 pt, y≈75,2–77,0), **tunggal** di bawah judul kolom (y≈99,4–100,0), **ganda** di bawah (y≈188,2–190,0). Di LaTeX: `\hline\hline` … `\hline` … `\hline\hline` (setara; `booktabs` juga dapat dipakai). |
| Catatan kaki tabel | `ᵃCR – Constant ratio.` — huruf `a` superscript 5 pt, 8 pt, di bawah tabel rata kiri. Penjelasan seluruh tabel diletakkan pada judul tabel, bukan catatan kaki. |

## 10. Persamaan

- Nomor urut kemunculan, dalam kurung di **margin kanan**: `(1)`.
- Contoh template (terbaca dari render hal. 3):
  `J(U,V) = Σₖ₌₁ᴺ Σᵢ₌₁ᶜ (uᵢₖ)ᵐ D(xₖ, vᵢ)²` — diakhiri titik bila bagian dari kalimat.
- Semua besaran dijelaskan setelah persamaan; simbol besaran *italic*, satuan tegak (mis. `T` suhu vs T tesla).
- Rujukan: `(1)`, bukan `Pers. (1)` / `persamaan (1)` — kecuali di awal kalimat: `Persamaan (1) merupakan …`.

## 11. Daftar pustaka

| Elemen | Nilai |
|---|---|
| Gaya | Numerik, urut sitasi, gaya IEEE. |
| Ukuran | **8 pt**, justify, hanging indent **18 pt** (0,63 cm), label `[1]` di margin. |
| Sitasi di teks | Angka Arab dalam kurung siku `[1]`; titik akhir kalimat **setelah** kurung siku `[2].`; rujukan berganda dalam kurung siku terpisah `[1]–[3]`; jangan tulis `Ref. [3]` / `rujukan [3]` kecuali di awal kalimat (`Rujukan [3] menjelaskan …`). |
| Penulis | **Semua** nama ditulis lengkap; jangan `et al.` / `dkk.`; spasi setelah inisial (`G. O. Young`). |
| Judul | Huruf besar hanya kata pertama (sentence case), kecuali nama/simbol elemen. Jurnal berbahasa selain Indonesia/Inggris: tulis judul Indonesia dulu, lalu judul aslinya. |
| Status | `belum dipublikasikan` [4], `akan dipublikasikan` [5], `didaftarkan untuk dipublikasikan` [6]. Komunikasi pribadi menyebut afiliasi + alamat [7]. |
| Kelengkapan | Semua yang disitasi harus ada di Daftar Pustaka, dan sebaliknya. |

## 12. Daftar bernomor & lainnya

- Daftar prinsip publikasi: label `1)`, `2)`, `3)` (bukan `1.`).
- Catatan kaki: 8 pt, justify, indent baris pertama 10,1 pt, di bawah kolom tempat disitasi (bukan endnotes), nomor berurutan superscript.
- Jumlah halaman artikel: **6–8**, kertas A4.
- Singkatan/akronim didefinisikan saat pertama dipakai (kecuali yang populer: IEEE, SI, ac, dc). Singkatan bertitik tanpa spasi: `C.N.R.S.`. Jangan pakai singkatan di judul.
- Angka Indonesia: desimal koma `0,25`; ilmiah `2,4×10⁻⁶` (pengali `×`); ketidakpastian `2,58±0,07` (simbol `±`); satuan SI.

## 13. Yang sengaja TIDAK diubah dari template

- Abstrak yang **bold seluruhnya** (bukan hanya labelnya).
- Judul bab yang **tidak bold** (hanya kapital + rata tengah).
- Tabel contoh tanpa garis vertikal dan dengan garis ganda.
- Halaman 5 PDF resmi yang kosong/Letter (artefak section break; diabaikan).
- Typo di teks template (`bekualitas`, `signfikansi`, `menggukan`, `Techincal`, `n short sections`) dipertahankan di `main.tex` agar contoh sama dengan template; perbaiki bila menulis artikel sungguhan.
