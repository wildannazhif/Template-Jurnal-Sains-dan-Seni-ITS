%% its-jurnal.cls -- Kelas LaTeX untuk Jurnal Sains dan Seni ITS (POMITS)
%%
%% Konversi setia dari template resmi Word ITS:
%%   "Gaya Selingkung dan Template Artikel Ilmiah Jurnal Sains dan Seni ITS"
%%   (3a.-Templat-artikel-Jurnal-Sains-dan-Seni-ITS.doc/.pdf, DRPM ITS).
%% Semua ukuran di bawah diukur langsung dari berkas resmi tersebut
%% (lihat docs/FORMAT-SPEC.md). Jangan mengubah angka-angka ini untuk
%% "merapikan" tampilan -- format jurnal ini memang seperti ini.
%%
%% Penggunaan:
%%   \documentclass{its-jurnal}
%%   \title{Judul Artikel}
%%   \author{Penulis P. Pertama, Penulis K. Kedua, dan Penulis K. Ketiga}
%%   \affiliation{Afiliasi Penulis}
%%   \email{penuliskorespodensi@email.com}
%%   \runninghead{Vol. 13, No. 2 (2024)}   % opsional
%%   \begin{document}
%%   \maketitle
%%   \begin{abstract} ... \end{abstract}
%%   \keywords{kata, kunci, ...}
%%   \section{Pendahuluan} ...
%%   \bibliographystyle{IEEEtran}
%%   \bibliography{references}
%%   \end{document}
%%
%% Lisensi kelas ini: LPPL 1.3c. Template resmi ITS tetap milik ITS;
%% kelas ini hanya meniru tampilannya dan BUKAN template resmi ITS.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{its-jurnal}[2026/11/24 v1.0 Jurnal Sains dan Seni ITS]

% ---------------------------------------------------------------------------
% Dasar: article 10pt, dua kolom, kertas A4 (bukan IEEEtran: kelas ini
% meniru template Word ITS yang berbasis IEEE, tetapi dengan ukuran
% kertas dan margin A4 persis seperti berkas resminya).
% ---------------------------------------------------------------------------
\LoadClass[10pt,twocolumn,a4paper]{article}

% ---------------------------------------------------------------------------
% Huruf: Times New Roman 10pt. Di pdfLaTeX, newtxtext/newtxmath adalah
% klon Times yang metriknya paling dekat dengan Times New Roman;
% bila tidak tersedia, jatuh ke mathptmx (Times standar).
% ---------------------------------------------------------------------------
\RequirePackage[T1]{fontenc}
\IfFileExists{newtxtext.sty}{%
  \RequirePackage{newtxtext}%
  \RequirePackage{newtxmath}%
}{%
  \RequirePackage{mathptmx}%
}
% Pemenggalan (hyphenation) Bahasa Indonesia bila babel tersedia.
\IfFileExists{indonesian.ldf}{\RequirePackage[indonesian]{babel}}{}

\RequirePackage{graphicx}
\RequirePackage{amsmath} % amssymb TIDAK dimuat: simbol AMS sudah disediakan
% newtxmath; memuat amssymb setelah newtxmath menimbulkan error
% "\Bbbk already defined".
\RequirePackage{array}
\RequirePackage{booktabs}
\RequirePackage{caption}
\RequirePackage{enumitem}
\RequirePackage{fancyhdr}
\RequirePackage{geometry}
\RequirePackage{lettrine}
\RequirePackage{microtype}
\IfFileExists{cite.sty}{\RequirePackage{cite}}{}
\RequirePackage{titlesec}
\RequirePackage[hidelinks]{hyperref}

% ---------------------------------------------------------------------------
% Geometri halaman -- diukur dari template resmi (sectPr + PDF):
%   kertas A4 210 x 297 mm (595,3 x 841,9 pt)
%   margin atas/bawah 50,5 pt (17,8 mm), kiri/kanan 46,8 pt (16,5 mm)
%   2 kolom, jarak antar-kolom 288 twips = 14,4 pt
%   -> lebar teks 501,7 pt; lebar tiap kolom 243,65 pt
%   header: jarak dari tepi atas 21,6 pt, tinggi 12 pt
%     (21,6 + 12 + 16,9 = 50,5 = margin atas)
% ---------------------------------------------------------------------------
\geometry{%
  a4paper,
  left=46.8pt, right=46.8pt,
  top=50.5pt, bottom=50.5pt,
  headheight=12pt, headsep=16.9pt,
  columnsep=14.4pt,
}

% ---------------------------------------------------------------------------
% Tubuh teks: Times New Roman 10pt, rata kiri-kanan (justify),
% indent baris pertama 10,1 pt (0,35 cm), tanpa jarak antar-paragraf,
% leading 12 pt (bawaan article 10pt -- sama dengan pitch 12,0-12,2 pt
% yang terukur di PDF resmi).
% ---------------------------------------------------------------------------
\setlength{\parindent}{10.1pt}
\setlength{\parskip}{0pt}
\setlength{\emergencystretch}{3pt}
\raggedbottom

% Semua hitam; tidak ada warna apa pun di template resmi.
% (hyperref sudah hidelinks: tautan tetap hitam tanpa kotak.)

% ---------------------------------------------------------------------------
% Running head -- di semua halaman, termasuk halaman pertama:
%   kiri: JURNAL SAINS DAN SENI ITS Vol. X, No. Y (TAHUN),
%         2337-3520 (2301-928X Print)     (10 pt, regular)
%   kanan: nomor halaman                  (10 pt, regular)
%   tanpa garis.
% ---------------------------------------------------------------------------
\newcommand{\its@headtext}{JURNAL SAINS DAN SENI ITS Vol. X, No. Y (TAHUN), 2337-3520 (2301-928X Print)}
\newcommand{\runninghead}[1]{\renewcommand{\its@headtext}{#1}}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\normalfont\normalsize\its@headtext}
\fancyhead[R]{\normalfont\normalsize\thepage}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\fancypagestyle{plain}{%
  \fancyhf{}%
  \fancyhead[L]{\normalfont\normalsize\its@headtext}%
  \fancyhead[R]{\normalfont\normalsize\thepage}%
  \renewcommand{\headrulewidth}{0pt}%
}

% ---------------------------------------------------------------------------
% Metadata artikel.
% ---------------------------------------------------------------------------
\newcommand{\affiliation}[1]{\gdef\its@authoraffil{#1}}
\newcommand{\email}[1]{\gdef\its@authoremail{#1}}
\gdef\its@authoraffil{Afiliasi Penulis}
\gdef\its@authoremail{penuliskorespodensi@email.com}

% ---------------------------------------------------------------------------
% \maketitle -- judul + penulis + afiliasi + e-mail, SATU KOLOM penuh
% (melebar di atas kedua kolom, seperti textbox di template Word).
%   Judul      : Times New Roman 24 pt, leading 27,6 pt, rata tengah.
%                Kata yang dimiringkan ditulis \textit{...} di dalam judul.
%   Penulis    : 11 pt, leading 12,6 pt, rata tengah.
%   Afiliasi   : 11 pt, rata tengah (baris kedua blok penulis).
%   e-mail     : 11 pt, kata "e-mail" miring, rata tengah.
%   Jarak setelah blok penulis: 16 pt (gaya "Authors" di Word).
% ---------------------------------------------------------------------------
\renewcommand{\maketitle}{%
  \thispagestyle{fancy}%
  \twocolumn[%
    \begin{@twocolumnfalse}%
      {\centering\fontsize{24}{27.6}\selectfont\@title\par}%
      \vspace{12pt}%
      {\centering\fontsize{11}{12.6}\selectfont
        \@author\par
        \its@authoraffil\par
        \textit{e-mail}: \its@authoremail\par}%
      \vspace{16pt}%
    \end{@twocolumnfalse}%
  ]%
}

% ---------------------------------------------------------------------------
% Abstrak -- 9 pt BOLD seluruhnya, leading 10,4 pt, rata kiri-kanan,
% tanpa indent baris pertama. Label "Abstrak" bold-italic, diikuti
% em dash tanpa spasi ("Abstrak---...").
%   Panjang: 100-300 kata, satu paragraf, tanpa acuan daftar pustaka.
% ---------------------------------------------------------------------------
\renewenvironment{abstract}{%
  \par
  \fontsize{9}{10.4}\selectfont\bfseries
  \noindent{\itshape Abstrak}---\ignorespaces
}{%
  \par
}

% ---------------------------------------------------------------------------
% Kata kunci -- 9 pt BOLD, leading 10,4 pt, rata kiri-kanan.
% Label "Kata Kunci" bold-italic + em dash. Maksimal 5 buah, urutan
% alfabet, Title Case, dipisah koma. Ada satu baris kosong 9 pt
% antara abstrak dan kata kunci (paragraf kosong di template Word).
% ---------------------------------------------------------------------------
\newcommand{\keywords}[1]{%
  \par\vspace{10.4pt}%
  {\fontsize{9}{10.4}\selectfont\bfseries
   \noindent{\itshape Kata Kunci}---#1\par}%
}

% ---------------------------------------------------------------------------
% Judul bagian (Heading 1 di Word):
%   10 pt regular (BUKAN bold), HURUF KAPITAL, rata tengah,
%   penomoran Romawi "I.", spasi sebelum 12 pt, sesudah 4 pt.
% Judul ditulis dengan huruf biasa di sumber; kelas mengubahnya
% menjadi kapital otomatis (seperti isi template yang sudah kapital).
% ---------------------------------------------------------------------------
\renewcommand{\thesection}{\Roman{section}}
\titleformat{\section}[block]
  {\normalfont\normalsize\filcenter}
  {\thesection.}{0.6em}{\MakeUppercase}
\titlespacing*{\section}{0pt}{12pt}{4pt}

% ---------------------------------------------------------------------------
% Subbagian (Heading 2 di Word):
%   10 pt ITALIC, rata kiri, penomoran huruf "A.",
%   spasi sebelum 6 pt, sesudah 3 pt.
% ---------------------------------------------------------------------------
\renewcommand{\thesubsection}{\Alph{subsection}}
\titleformat{\subsection}[block]
  {\normalfont\normalsize\itshape}
  {\thesubsection.}{0.5em}{}
\titlespacing*{\subsection}{0pt}{6pt}{3pt}

% ---------------------------------------------------------------------------
% Sub-subbagian (Heading 3 di Word): 10 pt italic, penomoran Arab "1.".
% ---------------------------------------------------------------------------
\titleformat{\subsubsection}[block]
  {\normalfont\normalsize\itshape}
  {\thesubsubsection.}{0.5em}{}
\titlespacing*{\subsubsection}{0pt}{6pt}{3pt}

% ---------------------------------------------------------------------------
% Tingkat 4/5 (Heading 4/5 di Word): 9 pt, italic / regular.
% ---------------------------------------------------------------------------
\titleformat{\paragraph}[runin]
  {\normalfont\small\itshape}
  {\theparagraph.}{0.5em}{}
\titlespacing*{\paragraph}{0pt}{12pt}{1em}
\titleformat{\subparagraph}[runin]
  {\normalfont\small}
  {\thesubparagraph.}{0.5em}{}
\titlespacing*{\subparagraph}{0pt}{12pt}{1em}

% ---------------------------------------------------------------------------
% Daftar bernomor (mis. "Prinsip-Prinsip Publikasi"):
%   label "1)", "2)", ...; 10 pt; indent seperti paragraf biasa.
% ---------------------------------------------------------------------------
\setlist[enumerate,1]{label=\arabic*), leftmargin=20.2pt, labelsep=5pt,
  itemsep=0pt, parsep=0pt, topsep=0pt}
\setlist[itemize,1]{label=\textbullet, leftmargin=20.2pt, labelsep=5pt,
  itemsep=0pt, parsep=0pt, topsep=0pt}

% ---------------------------------------------------------------------------
% Gambar dan tabel.
%   Nama: "Gambar" / "Tabel" (bukan Figure/Table).
%   Keterangan gambar: 8 pt, rata kiri-kanan, di BAWAH gambar,
%     format "Gambar 1.  <teks>" (dua spasi setelah titik).
%   Judul tabel: 8 pt, rata tengah, di ATAS tabel,
%     format dua baris: "Tabel 1." lalu judulnya di baris berikut.
%   Isi tabel: 8 pt, sel rata tengah, tanpa garis vertikal;
%     garis ganda di atas dan bawah, garis tunggal di bawah judul
%     kolom (persis tabel contoh di template: \hline\hline ... \hline
%     ... \hline\hline). Lebar 1 kolom (8,89 cm) atau 2 kolom (17,93 cm).
% ---------------------------------------------------------------------------
\renewcommand{\figurename}{Gambar}
\renewcommand{\tablename}{Tabel}
\DeclareCaptionLabelFormat{titik}{#1 #2.}
\DeclareCaptionLabelSeparator{duaspasi}{\space\space}
\captionsetup{font=footnotesize, labelfont=normalfont, textfont=normalfont,
  labelformat=titik}
\captionsetup[figure]{justification=justified, singlelinecheck=false,
  labelsep=duaspasi, skip=6pt}
\captionsetup[table]{justification=centering, singlelinecheck=false,
  labelsep=newline, position=top, skip=6pt}

% ---------------------------------------------------------------------------
% Catatan kaki: 8 pt, rata kiri-kanan, indent baris pertama 10,1 pt.
% ---------------------------------------------------------------------------
\renewcommand{\footnotesize}{\fontsize{8}{9.5}\selectfont}

% ---------------------------------------------------------------------------
% Daftar pustaka: 8 pt, rata kiri-kanan, hanging indent ~18 pt
% (0,63 cm: label "[31]" + labelsep), label "[1]" di margin.
% Sitasi numerik [1], [2] -- titik di akhir kalimat diletakkan SETELAH
% kurung siku. Nama SEMUA penulis ditulis lengkap; jangan memakai
% "et al."/"dkk.". Judul makalah: huruf besar hanya pada kata pertama
% (sentence case).
%
% Catatan: judul bagian ditulis literal di sini (bukan \section*{\refname}),
% karena titlesec + \MakeUppercase memakan kata pertama bila judul
% diberikan sebagai makro.
% ---------------------------------------------------------------------------
\renewcommand{\refname}{Daftar Pustaka}
\renewenvironment{thebibliography}[1]{%
  \section*{Daftar Pustaka}%
  \list{\@biblabel{\@arabic\c@enumiv}}{%
    \settowidth\labelwidth{\@biblabel{#1}}%
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \@openbib@code
    \usecounter{enumiv}%
    \let\p@enumiv\@empty
    \renewcommand\theenumiv{\@arabic\c@enumiv}%
    \setlength{\itemsep}{0pt}%
    \setlength{\parsep}{0pt}%
    \setlength{\topsep}{0pt}%
    \setlength{\partopsep}{0pt}}%
  \sloppy
  \clubpenalty4000
  \@clubpenalty\clubpenalty
  \widowpenalty4000%
  \sfcode`\.\@m
  \fontsize{8}{9.2}\selectfont
  \setlength{\itemsep}{0pt}%
  \setlength{\parsep}{0pt}%
}{%
  \def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
  \endlist
}
% BibTeX + IEEEtran: gaya IEEE menampilkan semua nama penulis
% (tanpa "et al.") secara bawaan -- sesuai gaya selingkung.

% ---------------------------------------------------------------------------
% Persamaan: nomor di margin kanan "(1)", sesuai urutan kemunculan.
% Simbol besaran miring, satuan tegak. Rujuk "(1)", bukan "Pers. (1)",
% kecuali di awal kalimat: "Persamaan (1) merupakan ...".
% ---------------------------------------------------------------------------
% (Menggunakan equation standar LaTeX; tidak ada yang perlu diubah.)

% ---------------------------------------------------------------------------
% Huruf besar di awal paragraf pertama (drop cap, seperti "D" 28 pt
% pada "DOKUMEN" di template): pakai \lettrine{D}{OKUMEN} di main.tex.
% ---------------------------------------------------------------------------

\endinput
