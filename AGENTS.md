# AGENTS.md — Jurnal Sains dan Seni ITS (LaTeX)

Repo ini adalah template LaTeX + Agent Skill untuk artikel Jurnal Sains dan Seni ITS. Baca file ini sebelum menulis atau mengubah apa pun di sini.

## Sumber kebenaran format

Satu-satunya sumber kebenaran adalah template resmi ITS dan pengukurannya:

- `reference/template-its.doc` — template Word resmi (gaya/styles + margin).
- `reference/template-its.pdf` — render PDF resmi (ukuran huruf + posisi terukur).
- `docs/FORMAT-SPEC.md` — semua angka hasil pengukuran, lengkap dengan sumbernya.

**Jangan mengubah angka di `its-jurnal.cls` berdasarkan "selera" atau kebiasaan LaTeX.** Kalau ada yang tampak aneh (mis. abstrak dicetak bold seluruhnya, judul bab tidak bold, tabel tanpa garis vertikal), itu memang formatnya — periksa `docs/FORMAT-SPEC.md` dulu.

## Aturan yang tidak boleh dilanggar

1. **Format tidak boleh diubah.** Font, ukuran, margin, spasi, warna, penomoran, dan posisi judul/keterangan sudah sama persis dengan template resmi. Perubahan format hanya boleh dilakukan bila `docs/FORMAT-SPEC.md` salah ukur — dan bila itu terjadi, perbaiki spec-nya dulu, lalu kelasnya, lalu jalankan validasi.
2. **Semua hitam.** Tidak ada warna di dokumen ini. Tautan (`hyperref`) memakai `hidelinks`.
3. **Jangan membuat referensi fiktif.** Semua entri di `references.bib` harus merujuk sumber nyata yang sudah diverifikasi. Entri contoh `[1]`–`[30]` di `references.bib` adalah contoh format dari template resmi — hapus dan ganti dengan referensi sungguhan saat menulis artikel nyata.
4. **Jangan mengubah angka, data, dan sitasi pengguna.** Angka hasil penelitian, data tabel, dan nomor sitasi harus dipertahankan apa adanya. Kalau ada yang tidak konsisten, tanyakan ke pengguna, jangan "memperbaiki" sendiri.
5. **Bahasa Indonesia baku, EYD V.** Desimal koma (`0,25`), pengali `×`, ketidakpastian `±`, satuan SI. Penekanan dengan *italic*, bukan underline.

## Cara kerja

- **Menulis artikel baru:** edit `main.tex` (metadata + isi) dan `references.bib`. Jangan menulis format manual di `main.tex` (mis. `\fontsize`, `\vspace` sembarangan, atau `\section` dengan huruf kapital manual) — kelas sudah mengaturnya.
- **Judul bab** ditulis biasa (`\section{Pendahuluan}`) — kelas mengubahnya jadi kapital + angka Romawi otomatis. **Subbagian** ditulis biasa (`\subsection{Tahap Telaah}`) — kelas memberi huruf A., B., … otomatis.
- **Gambar:** `figure` + `\includegraphics[width=\columnwidth]{...}` + `\caption{...}` (keterangan otomatis 8 pt, di bawah, `Gambar N.  `). Gambar lebar 1 kolom; bila perlu 2 kolom, pakai `figure*`.
- **Tabel:** `table` + `\caption{...}` di ATAS tabel + `tabular*{\columnwidth}` 8 pt. Tanpa garis vertikal; garis ganda atas/bawah (`\hline\hline`), tunggal di bawah judul kolom (`\hline`).
- **Persamaan:** `equation` + `\label`, rujuk dengan `\eqref` → `(1)`.
- **Sitasi:** `\cite{kunci}` → `[1]`. Daftar pustaka memakai BibTeX + `IEEEtran`.

## Build & validasi

```bash
./scripts/build.sh                 # latexmk -pdf main.tex -> main.pdf
./scripts/check-format.py main.pdf # cek ukuran halaman, huruf, geometri kolom
```

Setelah mengubah kelas atau contoh, selalu:

1. Compile sampai bersih (tanpa error; warning `Overfull` harus diperiksa, bukan diabaikan).
2. Jalankan `check-format.py` dan catat hasilnya di `docs/VALIDATION.md`.
3. Bandingkan halaman 1 hasil compile dengan `reference/template-its.pdf` secara visual (judul, penulis, abstrak, kolom) — posisi dan ukuran harus cocok.

## Struktur

- `its-jurnal.cls` — kelas (satu-satunya tempat definisi format).
- `main.tex` — contoh artikel; isinya teks template resmi agar bisa dibandingkan.
- `references.bib` — contoh referensi IEEE [1]–[30].
- `figures/gambar-1.png` — gambar contoh dari template resmi.
- `skills/jurnal-sains-seni-its/SKILL.md` — skill untuk AI agent lain.
- `docs/FORMAT-SPEC.md`, `docs/VALIDATION.md` — spec + hasil validasi.
- `scripts/` — build & cek format. `.github/workflows/build.yml` — CI.
