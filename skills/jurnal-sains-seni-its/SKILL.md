---
name: jurnal-sains-seni-its
description: Menulis artikel Jurnal Sains dan Seni ITS (POMITS) dalam LaTeX dari teks/Markdown pengguna, mengikuti gaya selingkung resmi ITS persis -- A4 dua kolom, Times New Roman 10pt, judul 24pt, abstrak 9pt bold, sitasi numerik [1] gaya IEEE, daftar pustaka 8pt. Gunakan saat pengguna meminta artikel/format Jurnal Sains dan Seni ITS, POMITS, jurnal ITS, atau template LaTeX jurnal ITS, dan saat memeriksa atau memperbaiki artikel berformat tersebut.
---

# Jurnal Sains dan Seni ITS — Skill Menulis Artikel (LaTeX)

Skill ini membuat artikel ilmiah untuk **Jurnal Sains dan Seni ITS** (luaran Tugas Akhir S1 ITS / POMITS) dalam LaTeX, dengan format yang sama persis dengan template resmi Word ITS. Template resmi hanya tersedia dalam Word (`.doc`); repo ini adalah konversinya ke LaTeX.

Repo skill ini (sekaligus template): `wildannazhif/Template-Jurnal-Sains-dan-Seni-ITS`
Acuan resmi: template Word/PDF ITS di `reference/`, spesifikasi terukur di `docs/FORMAT-SPEC.md`.

## Kapan memakai skill ini

- Pengguna meminta artikel Jurnal Sains dan Seni ITS / POMITS / jurnal ITS.
- Pengguna meminta template LaTeX jurnal ITS.
- Pengguna meminta memeriksa/memperbaiki format artikel jurnal ITS.

Jangan pakai skill ini untuk format lain (Jurnal Teknik ITS, buku TA ITS, skripsi umum) — formatnya berbeda.

## Alur kerja

### 1. Kumpulkan bahan dari pengguna

Sebelum menulis, minta (bila belum ada):

- Judul, nama penulis, afiliasi, e-mail korespondensi, volume/nomor/tahun (bila sudah ada).
- Hasil penelitian: data, angka, tabel, gambar, dan kesimpulan — dalam bentuk apa pun (teks, Markdown, file).
- Referensi yang dipakai (file `.bib`, daftar pustaka, atau DOI/judul yang bisa diverifikasi).

### 2. Tulis artikel di `main.tex` + `references.bib`

- Salin `its-jurnal.cls`, `main.tex`, `references.bib` dari repo ini. **Jangan** menulis format manual di `main.tex` (`\fontsize`, `\vspace`, margin, `\section` kapital manual) — kelas `its-jurnal.cls` sudah mengatur semuanya.
- Isi metadata: `\title{...}` (kata yang dimiringkan dibungkus `\textit{...}`), `\author{...}`, `\affiliation{...}`, `\email{...}`, dan `\runninghead{Vol. X, No. Y (TAHUN)}` bila diketahui.
- Abstrak di `abstract`: **100–300 kata, satu paragraf, tanpa sitasi**, Bahasa Indonesia baku. Kata kunci di `\keywords{...}`: **maksimal 5, urutan alfabet, Title Case**, dipisah koma.
- Struktur isi: `\section{Pendahuluan}` (kelas mengubahnya jadi kapital + angka Romawi otomatis), `\subsection{...}` (huruf A., B., … otomatis). Urutan umum: PENDAHULUAN, URAIAN PENELITIAN, PETUNJUK TAMBAHAN, PRINSIP-PRINSIP PUBLIKASI, KESIMPULAN/RINGKASAN — sesuaikan dengan bidang ilmu dan dosen pembimbing.
- Paragraf pertama pendahuluan memakai huruf besar awal (drop cap): `\lettrine{D}{OKUMEN}` — huruf pertama 28 pt, sisanya teks biasa.
- Gambar: `figure` + `\includegraphics[width=\columnwidth]{figures/...}` + `\caption{...}` (keterangan otomatis di bawah, 8 pt). Gambar 1 kolom (8,89 cm); bila perlu 2 kolom (17,93 cm) pakai `figure*`. Resolusi minimal 400 dpi untuk foto/grayscale, tanpa garis tepi pada gambar, label `(a)`, `(b)` bila gambar berbagian.
- Tabel: `table` + `\caption{...}` **di atas** tabel + `tabular*{\columnwidth}` 8 pt, sel rata tengah, **tanpa garis vertikal**; garis ganda atas/bawah (`\hline\hline`), tunggal di bawah judul kolom (`\hline`).
- Persamaan: `equation` + `\label{...}`, rujuk dengan `\eqref{...}` → `(1)`. Simbol besaran miring, satuan tegak. Jangan tulis "Pers. (1)" di tengah kalimat.
- Sitasi: `\cite{kunci}` → `[1]`. Titik akhir kalimat diletakkan **setelah** kurung siku. Daftar pustaka: BibTeX + `\bibliographystyle{IEEEtran}`.

### 3. Referensi — aturan keras

- **Jangan pernah membuat referensi fiktif.** Setiap entri `references.bib` harus merujuk sumber nyata yang sudah diverifikasi (cek judul, penulis, tahun, jurnal, DOI bila ada).
- Tulis **semua** nama penulis lengkap — jangan `et al.` / `dkk.`
- Judul makalah *sentence case* (huruf besar hanya kata pertama, kecuali nama/simbol); lindungi nama diri dengan `{...}` di `.bib`.
- Status khusus lewat `note`: `belum dipublikasikan`, `akan dipublikasikan`, `didaftarkan untuk dipublikasikan`.
- Semua sumber yang disitasi harus ada di Daftar Pustaka, dan sebaliknya.
- Hapus 30 entri contoh di `references.bib` bila menulis artikel sungguhan; entri contoh itu hanya contoh format dari template resmi.

### 4. EYD V dan konvensi Indonesia

- Bahasa Indonesia baku; satu spasi setelah titik/koma.
- Desimal koma: `0,25` (bukan `0.25`). Ilmiah: `2,4×10⁻⁶` (pengali `×`, bukan `x`). Ketidakpastian: `2,58±0,07` (simbol `±`). Satuan SI.
- Singkatan/akronim didefinisikan saat pertama dipakai (kecuali yang sudah populer: IEEE, SI, ac, dc). Jangan pakai singkatan di judul.
- Penekanan makna: *italic*, **bukan** underline.

### 5. Kompilasi dan validasi — wajib sebelum menyerahkan

```bash
./scripts/build.sh                  # latexmk -pdf main.tex
./scripts/check-format.py main.pdf  # cek halaman, huruf, geometri kolom
```

- Compile harus bersih (tanpa error). Periksa warning `Overfull \hbox` — jangan diabaikan.
- Bandingkan halaman 1 hasil compile dengan `reference/template-its.pdf`: judul 24 pt rata tengah, penulis 11 pt, abstrak 9 pt bold di kolom kiri, dua kolom dengan lebar sama.
- Target: artikel **6–8 halaman A4**. Bila melebihi, padatkan isi — **jangan** mengubah font/margin/spasi untuk memangkas halaman.

## Format — ringkas (lengkap: `docs/FORMAT-SPEC.md`)

| Elemen | Format |
|---|---|
| Kertas | A4 210×297 mm; margin atas/bawah 50,5 pt (17,8 mm), kiri/kanan 46,8 pt (16,5 mm) |
| Kolom | 2 kolom, jarak antar-kolom 14,4 pt; lebar kolom 243,65 pt |
| Tubuh | Times New Roman 10 pt, justify, indent baris pertama 10,1 pt, leading 12 pt |
| Judul | 24 pt, leading 27,6 pt, rata tengah |
| Penulis/afiliansi/e-mail | 11 pt, leading 12,6 pt, rata tengah; `e-mail` miring |
| Running head | 10 pt, kiri: `JURNAL SAINS DAN SENI ITS Vol. X, No. Y (TAHUN), 2337-3520 (2301-928X Print)`; kanan: nomor halaman; tanpa garis |
| Abstrak | 9 pt **bold**, leading 10,4 pt, justify; label `Abstrak` bold-italic + em dash |
| Kata kunci | 9 pt **bold**, leading 10,4 pt; label `Kata Kunci` bold-italic + em dash |
| Heading bab | 10 pt regular, KAPITAL, rata tengah, Romawi, spasi sebelum 12 pt / sesudah 4 pt |
| Subbagian | 10 pt *italic*, rata kiri, huruf, spasi sebelum 6 pt / sesudah 3 pt |
| Keterangan gambar | 8 pt, justify, di bawah: `Gambar 1.  <teks>` |
| Judul tabel | 8 pt, rata tengah, di atas (dua baris: `Tabel 1.` lalu judul) |
| Isi tabel | 8 pt, sel rata tengah |
| Persamaan | Nomor `(1)` di margin kanan |
| Daftar pustaka | 8 pt, justify, hanging indent 18 pt, label `[1]` |
| Catatan kaki | 8 pt, justify |
| Warna | Semua hitam; tautan tanpa warna/kotak |

## Hal yang tidak boleh dilakukan

- Mengubah font, ukuran, margin, spasi, atau warna apa pun di `its-jurnal.cls` atau `main.tex`.
- Menulis judul bab/subbagian dengan format manual.
- Mengarang referensi, data, angka, atau hasil penelitian.
- Mengubah angka/data/sitasi pengguna tanpa konfirmasi.
- Mengklaim hasil ini sebagai "template resmi ITS" — ini konversi komunitas yang divalidasi terhadap template resmi.
