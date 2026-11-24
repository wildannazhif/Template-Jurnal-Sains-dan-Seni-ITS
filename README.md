# Jurnal Sains dan Seni ITS — Template LaTeX + Agent Skill

Template LaTeX untuk artikel **Jurnal Sains dan Seni ITS** (luaran Tugas Akhir S1 ITS / POMITS), dikonversi dari template resmi Word ITS — teks, huruf, ukuran, warna, spasi, heading, judul, semuanya diukur langsung dari berkas resmi.

Repo ini sekaligus adalah **Agent Skill** (`jurnal-sains-seni-its`): pasang sekali, lalu agent menuliskan artikel berformat jurnal ini dari bahan penelitianmu sampai jadi PDF.

> **Bukan template resmi ITS.** Template resmi hanya tersedia dalam Word (`.doc`). Repo ini konversi komunitas ke LaTeX yang divalidasi terhadap berkas resmi. Cek pedoman terbaru jurnal sebelum submit.

Acuan resmi:

- Template Word: [3a.-Templat-artikel-Jurnal-Sains-dan-Seni-ITS.doc](https://www.its.ac.id/drpm/wp-content/uploads/sites/71/2021/08/3a.-Templat-artikel-Jurnal-Sains-dan-Seni-ITS.doc) (DRPM ITS)
- Template PDF: [3a.-Templat-artikel-Jurnal-Sains-dan-Seni-ITS.pdf](https://www.its.ac.id/dkv/wp-content/uploads/sites/102/2018/03/3a.-Templat-artikel-Jurnal-Sains-dan-Seni-ITS.pdf)
- Jurnal: <https://ejurnal.its.ac.id/index.php/sains_seni> — p-ISSN 2301-928X, e-ISSN 2337-3520

## Instalasi skill

Skill mengikuti standar terbuka [Agent Skills](https://agentskills.io) (`SKILL.md` + frontmatter `name`/`description`); satu folder yang sama dipakai lintas harness.

```bash
npx skills add wildannazhif/Template-Jurnal-Sains-dan-Seni-ITS
```

Atau salin `skills/jurnal-sains-seni-its/` secara manual:

| Harness | User scope | Repo/workspace scope | Invoke |
|---|---|---|---|
| Claude Code | `~/.claude/skills/` | `<repo>/.claude/skills/` | `/jurnal-sains-seni-its`, atau otomatis |
| Google Antigravity | `~/.gemini/config/skills/` | `<workspace>/.agents/skills/` | otomatis, cek dengan `/skills` |
| OpenAI Codex | `~/.agents/skills/` | `<repo>/.agents/skills/` | `$jurnal-sains-seni-its`, `/skills` |
| Lainnya (Cursor, Gemini CLI, Copilot/VS Code, OpenCode, Junie, Hermes) | `~/.agents/skills/` | `.agents/skills/` | sesuai docs masing-masing |

Restart session setelah instalasi — skill didaftarkan saat sesi dimulai. Di Codex, alternatif instalasi: `$skill-installer install https://github.com/wildannazhif/Template-Jurnal-Sains-dan-Seni-ITS/tree/main/skills/jurnal-sains-seni-its`.

> Skill merujuk `its-jurnal.cls`, `main.tex`, dan `references.bib` dari root repo — agent mengambilnya dari repo (clone/raw) saat mengompilasi. Simpan clone repo ini di tempat yang mudah dijangkau agent.

## Penggunaan

```
Buatkan artikel Jurnal Sains dan Seni ITS dari hasil penelitian saya.
Judul: "Pengaruh Suhu terhadap Kuat Tekan Beton".
Penulis: Budi Santoso, Departemen Teknik Sipil ITS, budi@email.com.
Hasil dan data: [ringkasan, angka, tabel, gambar]
Referensi: [daftar pustaka / DOI]
```

Alur agent (lihat `skills/jurnal-sains-seni-its/SKILL.md` dan `AGENTS.md`):

1. Kumpulkan metadata, data, dan referensi yang belum diberikan.
2. Tulis artikel di `main.tex` + `references.bib` memakai `its-jurnal.cls` — jangan menulis format manual di `.tex` (`\fontsize`, margin, `\section` kapital manual); kelas sudah mengatur semuanya.
3. Kompilasi (`latexmk -pdf`) dan validasi (`./scripts/check-format.py main.pdf`), lalu serahkan PDF beserta `.tex`/`.bib`.

Aturan keras: **tidak ada referensi fiktif** (setiap entri `.bib` harus sumber nyata terverifikasi; semua nama penulis lengkap, tanpa `et al.`/`dkk.`); jangan mengubah angka format di `its-jurnal.cls` — `docs/FORMAT-SPEC.md` adalah sumber kebenaran; jangan mengubah data/sitasi pengguna tanpa konfirmasi.

## Manual (tanpa agent)

Prasyarat: pdfLaTeX + BibTeX + `IEEEtran.bst` (TeX Live lengkap, atau TinyTeX untuk instalasi minimal). Alternatif tanpa instalasi: **Overleaf** — unggah `its-jurnal.cls`, `main.tex`, `references.bib`, folder `figures/`, compile dengan pdfLaTeX.

```bash
./scripts/build.sh                  # latexmk -pdf main.tex -> main.pdf
./scripts/check-format.py main.pdf  # cek halaman, huruf, geometri kolom
```

Menulis artikel: isi `\title`, `\author`, `\affiliation`, `\email` (dan `\runninghead{Vol. X, No. Y (TAHUN)}` bila diketahui); abstrak 100–300 kata, satu paragraf, tanpa sitasi; `\keywords{...}` maksimal 5, alfabet, Title Case; isi dengan `\section` (otomatis kapital + angka Romawi) dan `\subsection` (otomatis huruf A., B., …); gambar `figure` + `\caption` di bawah, tabel `table` + `\caption` di atas (tanpa garis vertikal), persamaan `equation` + `\eqref`; sitasi `\cite{kunci}` → `[1]`. Hapus 30 entri contoh di `references.bib` dan ganti dengan referensi sungguhan.

## Format (ringkas)

| Elemen | Format |
|---|---|
| Kertas | A4 210×297 mm; margin atas/bawah 50,5 pt, kiri/kanan 46,8 pt |
| Layout | 2 kolom, columnsep 14,4 pt; lebar kolom 243,65 pt |
| Huruf | Times New Roman 10 pt, justify, indent 10,1 pt |
| Judul | 24 pt, rata tengah |
| Penulis/afiliansi/e-mail | 11 pt, rata tengah |
| Abstrak | 9 pt **bold**, satu paragraf, 100–300 kata |
| Kata kunci | 9 pt **bold**, maks. 5, alfabet |
| Heading bab | 10 pt, KAPITAL, rata tengah, angka Romawi |
| Subbagian | 10 pt *italic*, rata kiri, huruf |
| Keterangan gambar | 8 pt, justify, di bawah (`Gambar 1.  ...`) |
| Judul tabel | 8 pt, rata tengah, di atas; tanpa garis vertikal |
| Daftar pustaka | 8 pt, sitasi numerik `[1]`, gaya IEEE |

Spesifikasi terukur: [`docs/FORMAT-SPEC.md`](docs/FORMAT-SPEC.md). Hasil validasi vs PDF resmi: [`docs/VALIDATION.md`](docs/VALIDATION.md). Konvensi: artikel 6–8 halaman; desimal koma (`0,25`), pengali `×`, ketidakpastian `±`, satuan SI; penekanan *italic*, bukan underline; titik akhir kalimat setelah kurung siku sitasi.

## Troubleshooting

- **Skill tidak ter-load:** restart session; pastikan folder bernama persis `jurnal-sains-seni-its` dan berisi `SKILL.md`; panggil manual (`/jurnal-sains-seni-its` di Claude Code, `$jurnal-sains-seni-its` di Codex, `/skills` di Antigravity). Auto-trigger bergantung pada `description` — awali prompt dengan *"Buatkan artikel Jurnal Sains dan Seni ITS …"*.
- **Compile gagal:** pastikan `pdflatex`, `bibtex`, dan `IEEEtran.bst` tersedia; cek warning `Overfull \hbox` (jangan diabaikan); fallback ke Overleaf atau instal TinyTeX.
- **Artikel kepanjangan (>8 halaman):** padatkan isi — jangan mengubah font/margin/spasi.
- **Skill ini tidak berlaku** untuk Jurnal Teknik ITS, buku TA, atau skripsi — formatnya berbeda.

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

## Lisensi

- Kelas `its-jurnal.cls` dan isi repo ini (kecuali berkas di `reference/` dan `figures/`): **LPPL 1.3c** (lihat `LICENSE`).
- Template resmi ITS di `reference/` dan gambar contoh di `figures/`: milik ITS, disertakan hanya sebagai pembanding/sumber konversi.
