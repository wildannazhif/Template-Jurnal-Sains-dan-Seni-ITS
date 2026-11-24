# Jurnal Sains dan Seni ITS — Template LaTeX

Template LaTeX untuk artikel **Jurnal Sains dan Seni ITS** (luaran Tugas Akhir S1 ITS / POMITS), dikonversi setia dari template resmi Word ITS sehingga tampilannya sama persis: teks, huruf, ukuran, warna, spasi, heading, judul — semuanya.

> **Bukan template resmi ITS.** Template resmi hanya tersedia dalam Word (`.doc`). Repo ini adalah konversi komunitas ke LaTeX yang divalidasi terhadap berkas resmi. Selalu cek pedoman terbaru jurnal sebelum submit.

Sumber resmi yang dipakai sebagai acuan:

- Template Word: [3a.-Templat-artikel-Jurnal-Sains-dan-Seni-ITS.doc](https://www.its.ac.id/drpm/wp-content/uploads/sites/71/2021/08/3a.-Templat-artikel-Jurnal-Sains-dan-Seni-ITS.doc) (DRPM ITS)
- Template PDF: [3a.-Templat-artikel-Jurnal-Sains-dan-Seni-ITS.pdf](https://www.its.ac.id/dkv/wp-content/uploads/sites/102/2018/03/3a.-Templat-artikel-Jurnal-Sains-dan-Seni-ITS.pdf)
- Jurnal: <https://ejurnal.its.ac.id/index.php/sains_seni> — p-ISSN 2301-928X, e-ISSN 2337-3520

## Hasil

| | |
|---|---|
| Kertas | A4 (210 × 297 mm) |
| Layout | Dua kolom |
| Huruf | Times New Roman 10 pt (klon `newtxtext` di pdfLaTeX) |
| Judul | Times New Roman 24 pt, rata tengah |
| Abstrak | 9 pt **bold**, satu paragraf, 100–300 kata |
| Kata kunci | 9 pt **bold**, maksimal 5, urutan alfabet |
| Heading bab | 10 pt, HURUF KAPITAL, rata tengah, angka Romawi (I., II., …) |
| Subbagian | 10 pt *italic*, rata kiri, huruf (A., B., …) |
| Daftar pustaka | 8 pt, sitasi numerik `[1]`, gaya IEEE |

Spesifikasi lengkap yang terukur ada di [`docs/FORMAT-SPEC.md`](docs/FORMAT-SPEC.md), dan hasil validasi terhadap PDF resmi ada di [`docs/VALIDATION.md`](docs/VALIDATION.md).

## Pakai

### Prasyarat

TeX Live lengkap (pdfLaTeX + BibTeX + `IEEEtran.bst`):

```bash
# Debian/Ubuntu
sudo apt install texlive-latex-base texlive-latex-recommended \
  texlive-latex-extra texlive-fonts-recommended texlive-bibtex-extra \
  texlive-publishers texlive-lang-other
```

Atau pakai Overleaf: unggah `its-jurnal.cls`, `main.tex`, `references.bib`, dan folder `figures/` — lalu compile dengan pdfLaTeX.

### Kompilasi

```bash
./scripts/build.sh        # latexmk -pdf main.tex
# hasil: main.pdf
```

### Menulis artikel Anda

1. Salin repo ini, atau salin `its-jurnal.cls` + `main.tex` + `references.bib` ke proyek Anda.
2. Isi metadata di `main.tex`: `\title`, `\author`, `\affiliation`, `\email` (dan `\runninghead{Vol. X, No. Y (TAHUN)}` bila sudah tahu volume/nomor).
3. Tulis abstrak di `abstract` (100–300 kata, satu paragraf, tanpa sitasi) dan kata kunci di `\keywords{...}` (maksimal 5, alfabet, Title Case).
4. Tulis isi dengan `\section{...}` (otomatis jadi kapital + angka Romawi), `\subsection{...}` (otomatis huruf A., B., …), gambar dengan `figure`, tabel dengan `table`, persamaan dengan `equation`.
5. Isi `references.bib` dengan referensi Anda — **jangan membuat referensi fiktif**. Contoh 30 referensi di `references.bib` adalah contoh format dari template resmi; hapus dan ganti dengan referensi sungguhan.
6. Kompilasi, lalu jalankan `./scripts/check-format.py main.pdf` untuk memeriksa ukuran halaman, huruf, dan geometri kolom.

## Untuk AI Agent (skill)

Repo ini sekaligus adalah **Agent Skill** yang bisa dipasang di Claude Code, Codex, Hermes Agent, dan agent lain yang mendukung format Agent Skills:

```
skills/jurnal-sains-seni-its/SKILL.md
```

Pasang dengan:

```bash
npx skills add wildannazhif/Template-Jurnal-Sains-dan-Seni-ITS
```

Lalu minta agent: *"Buatkan artikel Jurnal Sains dan Seni ITS dari hasil penelitian saya"* — agent akan menulis mengikuti `SKILL.md` dan kelas ini, memeriksa angka/sitasi, lalu mengompilasi PDF-nya. Aturan main untuk agent ada di [`AGENTS.md`](AGENTS.md).

## Struktur repo

```
.
├── its-jurnal.cls                  # kelas LaTeX (semua format ada di sini)
├── main.tex                        # contoh artikel (isi = teks template resmi)
├── references.bib                  # 30 contoh referensi gaya IEEE
├── figures/
│   └── gambar-1.png                # gambar contoh dari template resmi
├── skills/
│   └── jurnal-sains-seni-its/
│       └── SKILL.md                # Agent Skill (Claude Code / Codex / Hermes)
├── docs/
│   ├── FORMAT-SPEC.md              # spesifikasi format terukur (sumber kebenaran)
│   └── VALIDATION.md               # perbandingan hasil compile vs template resmi
├── scripts/
│   ├── build.sh                    # kompilasi latexmk
│   └── check-format.py             # validasi PDF hasil compile
├── reference/
│   ├── template-its.pdf            # template resmi ITS (PDF, pembanding)
│   └── template-its.doc            # template resmi ITS (Word, sumber ukuran)
└── .github/workflows/build.yml     # CI: compile tiap push, unggah PDF
```

## Aturan gaya selingkung (ringkas)

Dari template resmi — selengkapnya di `docs/FORMAT-SPEC.md`:

- Artikel 6–8 halaman, kertas A4.
- Abstrak 100–300 kata; kata kunci maksimal 5.
- Struktur umum: PENDAHULUAN, URAIAN PENELITIAN, PETUNJUK TAMBAHAN, PRINSIP-PRINSIP PUBLIKASI, KESIMPULAN/RINGKASAN — sesuaikan dengan bidang ilmu dan dosen pembimbing.
- Gambar: keterangan di bawah, rata kiri-kanan, 8 pt (`Gambar 1.  ...`); tabel: judul di atas, rata tengah, 8 pt; tanpa garis vertikal.
- Persamaan bernomor di margin kanan `(1)`; simbol miring, satuan tegak.
- Sitasi numerik `[1]`; titik akhir kalimat setelah kurung siku. Semua nama penulis ditulis lengkap — tanpa `et al.`/`dkk.`
- Desimal memakai koma (`0,25`), pengali `×` (`2,4×10⁻⁶`), ketidakpastian `±` (`2,58±0,07`), satuan SI.
- Penekanan makna memakai *italic*, bukan underline.

## Lisensi

- Kelas `its-jurnal.cls` dan isi repo ini (kecuali berkas di `reference/` dan `figures/`): **LPPL 1.3c** (lihat `LICENSE`).
- Template resmi ITS di `reference/` dan gambar contoh di `figures/`: milik ITS, disertakan hanya sebagai pembanding/sumber konversi.
