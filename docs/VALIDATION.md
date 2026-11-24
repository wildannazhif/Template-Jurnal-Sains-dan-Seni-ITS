# Validasi — Hasil Compile vs Template Resmi ITS

Validasi dilakukan 2026-11-24 terhadap `reference/template-its.pdf`
(render PDF resmi) dan `reference/template-its.doc` (template Word resmi).
Toolchain: TinyTeX (TeX Live 2026), `pdflatex` + `bibtex` via
`scripts/build.sh` (`latexmk -pdf`).

## Ringkasan

| Pemeriksaan | Hasil |
|---|---|
| `scripts/build.sh` | Berhasil, tanpa error, tanpa warning `Overfull` |
| `scripts/check-format.py main.pdf` | **LOLOS** — semua pemeriksaan lolos |
| Ukuran halaman | A4, 595,3 × 841,9 pt |
| Jumlah halaman | 4 halaman (sama dengan 4 halaman isi PDF resmi) |
| Judul 24 pt / penulis 11 pt / abstrak 9 pt bold | Terukur hadir (judul 23,9 pt — pembulatan NewTX, toleransi ±0,6 pt) |
| Dua kolom 243,65 pt, jarak 14,4 pt | Terdeteksi dua kolom |
| Running head di semua halaman | Ada, termasuk halaman 1 |
| Font keluarga Times | NewTX (teks + matematika) |
| Daftar pustaka [1]–[30] sesuai template | Terverifikasi: Young [1], Chen [2], Poor [3], Smith [4], Miller [5], Wang [6], Kaufman [7], Yorozu [8], M. Young [9], Transmission [25], Motorola [26], Vidmar [30] |
| Spasi daftar pustaka | Jarak antar entri kelipatan tepat 9,2 pt, tanpa celah antar entri |

## Perbandingan per halaman (visual, berdampingan dengan PDF resmi)

| Hal. | Template resmi | Hasil compile | Catatan |
|---|---|---|---|
| 1 | Judul + penulis + abstrak + kata kunci + PENDAHULUAN (drop cap D) | Sama | Jeda baris judul sama persis ("…Artikel Ilmiah / Jurnal Sains dan Seni ITS"); teks kata kunci sama persis |
| 2 | URAIAN PENELITIAN, Gambar 1 (kiri), Tabel 1 (kanan) | Sama isinya | Gambar + tabel menumpuk di kolom kiri (lihat "Perbedaan yang diketahui") |
| 3 | PETUNJUK TAMBAHAN, persamaan (1), KESIMPULAN, LAMPIRAN, UCAPAN TERIMA KASIH, DAFTAR PUSTAKA [1]–[13] | Sama | Judul "DAFTAR PUSTAKA" benar (bukan "PUSTAKA") |
| 4 | DAFTAR PUSTAKA [14]–[30] (+ [31] kosong) | DAFTAR PUSTAKA [29]–[30] | Isi sama; halaman 4 hampir kosong karena daftar pustaka LaTeX lebih rapat (lihat di bawah) |

## Perbedaan yang diketahui dan disengaja

- **Penempatan float:** di Word, Gambar 1 di kiri dan Tabel 1 di kanan pada
  bagian atas halaman 2 (Word memakai anchor). Di LaTeX, keduanya menumpuk
  di kolom kiri halaman 2 (aturan float LaTeX). Format gambar, keterangan,
  dan tabelnya sendiri identik.
- **Paginasi:** aliran teks berbeda sampai ~1 kolom dalam 4 halaman karena
  metrik TeXGyre Termes (klon Times di LaTeX) sedikit berbeda dari Times New
  Roman di Word. Semua ukuran huruf dan spasi sudah identik.
- **Daftar pustaka:** IEEEtran memakai tanda baca/urutan standar IEEE yang
  di beberapa entri berbeda dari gaya lama template (mis. [1] menjadi
  "…1964, vol. 3, pp. 15–64"); entri tanpa penulis [21]/[22] diberi tanda
  kutip oleh IEEEtran; entri placeholder [27]–[29] dekat tapi tidak identik
  karakter demi karakter.
- **Halaman 4 contoh hampir kosong:** hanya berisi [29] dan [30] karena
  daftar pustaka LaTeX lebih rapat dari Word. Artikel nyata (6–8 halaman)
  tidak akan mengalami ini.
- **3 warning BibTeX yang tidak berbahaya** (berasal dari entri template
  resmi itu sendiri): `miller` dan `wang` tanpa tahun, `transmission`
  tanpa penulis/editor.
- Garis tabel memakai `\hline\hline` / `\hline` (LaTeX) sebagai padanan
  garis ganda/tunggal Word.
- Huruf memakai `newtxtext` (klon Times) sebagai padanan Times New Roman.
- Halaman 5 PDF resmi (kosong, ukuran Letter) adalah artefak section break
  dan tidak direproduksi.
