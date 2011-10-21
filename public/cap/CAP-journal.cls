% ENOC DOCUMENT CLASS � enoc08.cls
%      for LaTeX version 2e - 4/10/97

% WARNING: This class file has not been thoroughly
% tested so it probably still has bugs. 

% ---------------------------------------------------------------------------
%   filename:      enoc08.cls
%   version:       1.0
%   date:          21/12/2005
%   written by:    Remco Leine, ETH Zurich
%
%   description:   This is a LaTeX2e version of the standard asme style file adapted for the  
%                  ENOC conference
%                  
%   usage:         \documentclass[options]{enoc}
% ---------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{enoc}[1997/04/10 v1.0 Standard LaTeX document class]

\RequirePackage{ifthen}
\RequirePackage{times}      % Loads the Times-Roman Fonts
%\RequirePackage{mathptm}    % Loads the Times-Roman Math Fonts
%\RequirePackage{pifont}     % Loads the Postscript symbol fonts

\newif\if@titlepage
\@titlepagefalse

\newcommand\@ptsize{}

\def\confshortname{Cybernetics and Physics}
\def\confdate{V.1, Is.1}
\def\confmonth{}
\def\confyear{2011}
\def\confcity{}
\def\confcountry{}

% -------------------------------------------------------
%                   Options
% -------------------------------------------------------

\DeclareOption{twoside}{\@twosidetrue \@mparswitchtrue}
\DeclareOption{oneside}{\@twosidefalse \@mparswitchfalse}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\DeclareOption{titlepage}{\@titlepagetrue}
\DeclareOption{notitlepage}{\@titlepagefalse}
\DeclareOption{twocolumn}{\@twocolumntrue}
\ExecuteOptions{oneside,onecolumn,final}
\ProcessOptions


\renewcommand\@ptsize{2}     % Corresponds to 12pt font
\input{size1\@ptsize.clo}

\newcommand\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
\newcommand\currenttime{\minute\time\hour\minute\divide\hour60
\the\hour:\multiply\hour60\advance\minute-\hour\the\minute}



% ------------------------------------------------------
%                Font and Size Definitions 
% ------------------------------------------------------

\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand{\baselinestretch}{1}
\renewcommand\normalsize{%
   \@setfontsize\normalsize\@xpt{12}%
   \abovedisplayskip 18\p@ \@plus2\p@ \@minus5\p@
   \abovedisplayshortskip \abovedisplayskip 
   \belowdisplayshortskip \abovedisplayskip 
   \belowdisplayskip \abovedisplayskip
   \let\@listi\@listI}
\normalsize
\renewcommand\small{%
   \@setfontsize\small\@ixpt{11}%
   \abovedisplayskip 8.5\p@ \@plus3\p@ \@minus4\p@
   \abovedisplayshortskip \z@ \@plus2\p@
   \belowdisplayshortskip 4\p@ \@plus2\p@ \@minus2\p@
   \belowdisplayskip \abovedisplayskip}
\renewcommand\footnotesize{%
   \@setfontsize\footnotesize\@viiipt{10}
   \abovedisplayskip 6\p@ \@plus2\p@ \@minus4\p@
   \abovedisplayshortskip \z@ \@plus\p@
   \belowdisplayshortskip 3\p@ \@plus\p@ \@minus2\p@
   \def\@listi{\leftmargin\leftmargini
               \topsep 3\p@ \@plus\p@ \@minus\p@
               \parsep \z@ 
               \itemsep \parsep}%
   \belowdisplayskip \abovedisplayskip}
\renewcommand\scriptsize{\@setfontsize\scriptsize\@viipt{8}}
\renewcommand\tiny{\@setfontsize\tiny\@vpt{6}}
\renewcommand\large{\@setfontsize\large\@xiipt{12}}
\renewcommand\Large{\@setfontsize\Large\@xivpt{12}}
\renewcommand\LARGE{\@setfontsize\LARGE\@xviipt{14}}
\renewcommand\huge{\@setfontsize\huge\@xxpt{25}}
\renewcommand\Huge{\@setfontsize\Huge\@xxvpt{30}}

% These are specific fonts used in the file.

\DeclareFixedFont{\ninsfb}{OT1}{ptm}{b}{n}{9}
\DeclareFixedFont{\ninsf}{OT1}{ptm}{m}{n}{9}
\DeclareFixedFont{\egtsf}{OT1}{ptm}{m}{n}{8}
\DeclareFixedFont{\egtsfb}{OT1}{ptm}{b}{n}{8}
\DeclareFixedFont{\sevsf}{OT1}{ptm}{m}{n}{7}
\DeclareFixedFont{\bannerfnt}{OT1}{ptm}{b}{n}{10}
\DeclareFixedFont{\pnumfnt}{OT1}{ptm}{b}{n}{18}
\DeclareFixedFont{\twlsfb}{OT1}{ptm}{b}{n}{12}
\DeclareFixedFont{\twlsfbb}{OT1}{ptm}{b}{n}{14}
\DeclareFixedFont{\tensfb}{OT1}{ptm}{b}{n}{10}
\DeclareFixedFont{\tensf}{OT1}{ptm}{m}{n}{10}


\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch{\relax}{\mathcal}}
\DeclareRobustCommand*\mit{\@fontswitch{\relax}{\mathnormal}}

\DeclareFontFamily{OT1}{msbm}{}
\DeclareFontShape{OT1}{msbm}{m}{n}{<5> <6> <7> <8> <9> <10> gen * msbm }{}

\newcommand\bb{\fontfamily{msbm}\selectfont}
\newcommand\bi{\fontseries{bc}\fontshape{it}\selectfont}

% -----------------------------------------------------------
%                 Page Layout
% -----------------------------------------------------------

\setlength{\paperheight}{29.7cm}
\setlength{\paperwidth}{21cm}
\setlength{\oddsidemargin}{2.5cm}
\setlength{\evensidemargin}{2.5cm}
\setlength{\topmargin}{2.5cm}
\setlength{\marginparwidth}{30pt}
\setlength{\marginparsep}{0pt}
\setlength{\marginparpush}{0pt}
\setlength{\columnsep}{0.8cm}
\setlength{\columnseprule}{0pt}
\setlength{\headheight}{10pt}
\setlength{\headsep}{18pt}
\setlength{\topskip}{10pt}
\setlength{\footskip}{2.5cm}
\setlength{\textheight}{26cm}
\advance\textheight by -\headheight
\advance\textheight by -\headsep
\setlength{\textwidth}{16.2cm}
\setlength{\footnotesep}{6.65pt}
\setlength{\skip\footins}{9pt plus4pt minus 2pt}
\setlength{\floatsep}{18pt plus2pt minus2pt}
\setlength{\textfloatsep}{20pt plus4pt minus2pt}
\setlength{\intextsep}{24pt plus4pt minus2pt}
\setlength{\dblfloatsep}{12pt plus2pt minus2pt}
\setlength{\dbltextfloatsep}{20pt plus2pt minus4pt}
\setlength{\@fptop}{0pt plus 1fil}
\setlength{\@fpsep}{8pt plus 2fil}
\setlength{\@fpbot}{0pt plus 1fil}
\setlength{\@dblfptop}{0pt plus 1fil}
\setlength{\@dblfpsep}{8pt plus 2fil}
\setlength{\@dblfpbot}{0pt plus 1fil}
\setlength{\parskip}{0pt plus 1pt}
\setlength{\parindent}{.06in}
\setlength{\partopsep}{2pt plus 1pt minus 1pt}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty

\setlength{\leftmargini}{.25in}
\setlength{\leftmarginii}{22pt}
\setlength{\leftmarginiii}{18.7pt}
\setlength{\leftmarginiv}{17pt}
\setlength{\leftmarginv}{10pt}
\setlength{\leftmarginvi}{10pt}

% -------------------------------------------------------------------------
%                          Sections and Enumerate
% -------------------------------------------------------------------------

% Changes the enumerate environments

\setlength{\leftmargin}{\leftmargini}
\setlength{\labelsep}{5pt}
\setlength{\labelwidth}{\leftmargini}
\addtolength{\labelwidth}{-\labelsep}
\renewcommand{\@listI}{\leftmargin\leftmargini\parsep\z@
\topsep 6\p@ plus2\p@ minus1\p@\itemsep\z@}
\let\@listi\@listI
\@listi
\renewcommand{\@listii}{\setlength{\leftmargin}{\leftmarginii}
   \setlength{\labelwidth}{\leftmarginii}
   \addtolength{\labelwidth}{-\labelsep}
   \setlength{\topsep}{4\p@ plus2\p@ minus\p@}
   \setlength{\parsep}{\z@}
   \setlength{\itemsep}{\parsep}}
\renewcommand{\@listiii}{\setlength{\leftmargin}{\leftmarginiii}
    \setlength{\labelwidth}{\leftmarginiii}
    \addtolength{\labelwidth}{-\labelsep}
    \setlength{\topsep}{2\p@ plus\p@ minus\p@}
    \setlength{\parsep}{\z@}
    \setlength{\partopsep}{\p@ plus\z@ minus\p@}
    \setlength{\itemsep}{\parsep}}
\renewcommand{\@listiv}{\setlength{\leftmargin}{\leftmarginiv}
     \setlength{\labelwidth}{\leftmarginiv}
     \addtolength{\labelwidth}{-\labelsep}}
\renewcommand{\@listv}{\setlength{\leftmargin}{\leftmarginv}
     \setlength{\labelwidth}{\leftmarginv}
     \addtolength{\labelwidth}{-\labelsep}}
\renewcommand{\@listvi}{\setlength{\leftmargin}{\leftmarginvi}
     \setlength{\labelwidth}{\leftmarginvi}
     \addtolength{\labelwidth}{-\labelsep}}
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{(\theenumii)}
\newcommand\labelenumiii{\theenumiii.}
\newcommand\labelenumiv{\theenumiv.}


\newenvironment{verse}
               {\let\\=\@centercr
                \list{}{\itemsep      \z@
                        \itemindent   -1.5em%
                        \listparindent\itemindent
                        \rightmargin  \leftmargin
                        \advance\leftmargin 1.5em}%
                \item[]}
               {\endlist}
\newenvironment{quotation}
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \item[]}
               {\endlist}
\newenvironment{quote}
               {\list{}{\rightmargin\leftmargin}%
                \item[]}
               {\endlist}

\newenvironment{sequence}{      % Special enumerate environments for enoc
    \renewcommand{\theenumi}{\alph{enumi}}
    \renewcommand{\labelenumi}{(\theenumi)}
    \begin{enumerate}}
    {\end{enumerate}}
\newenvironment{enumeroman}{
     \renewcommand{\theenumi}{\roman{enumi}}
     \renewcommand{\labelenumi}{(\theenumi)}
     \begin{enumerate}}
     {\end{enumerate}}
\newenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep
                                \normalfont\bfseries #1}

\renewcommand\theequation{\@arabic\c@equation}  % equation environment

\setlength\arraycolsep{1.5pt}  %Different from article class
\setlength\tabcolsep{6pt}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}

\renewcommand{\footnoterule}{    % This modifies the default footnote style
     \kern12\p@
     \hrule width.5in height.25pt
     \kern10\p@}

\long\def\@makefntext#1{\parindent 1em\noindent
    \hbox to1.8em{\hss$\m@th^{\@thefnmark}$}#1}

\def\@fnsymbol#1{\ifcase#1\or *\or \dagger\or \ddagger\or
  \Section\or \Paragraph\or \|\or **\or \dagger\dagger
   \or \ddagger\ddagger \else\@ctrerr\fi\relax}

% Title page definition

\newenvironment{titlepage}
    {%
      \if@twocolumn
        \@restonecoltrue\onecolumn
      \else
        \@restonecolfalse\newpage
      \fi
      \thispagestyle{empty}%
      \if@compatibility
        \setcounter{page}{0}
      \else
        \setcounter{page}{1}%
      \fi}%
    {\if@restonecol\twocolumn \else \newpage \fi
      \setcounter{page}{1}%
    }


% Section Definitions

\setcounter{secnumdepth}{3}
\newcounter {part}
\newcounter {section}
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\newcounter {subparagraph}[paragraph]
\renewcommand\thepart         {\@Roman\c@part}
\renewcommand\thesection      {\@arabic\c@section}
\renewcommand\thesubsection   {\thesection.\@arabic\c@subsection}
\renewcommand\thesubsubsection{\thesubsection .\@arabic\c@subsubsection}
\renewcommand\theparagraph    {\thesubsubsection.\@arabic\c@paragraph}
\renewcommand\thesubparagraph {\theparagraph.\@arabic\c@subparagraph}
\newcommand\part{\par
   \addvspace{4ex}%
   \@afterindentfalse
   \secdef\@part\@spart}

\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >\m@ne
      \refstepcounter{part}%
      \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
    \else
      \addcontentsline{toc}{part}{#1}%
    \fi
    {\parindent \z@ \raggedright
     \interlinepenalty \@M
     \normalfont
     \ifnum \c@secnumdepth >\m@ne
       \Large\bfseries \partname~\thepart
       \par\nobreak
     \fi
     \huge \bfseries #2%
     \markboth{}{}\par}%
    \nobreak
    \vskip 3ex
    \@afterheading}
\def\@spart#1{%
    {\parindent \z@ \raggedright
     \interlinepenalty \@M
     \normalfont
     \huge \bfseries #1\par}%
     \nobreak
     \vskip 3ex
     \@afterheading}
\def\@endpart{\vfil\newpage
              \if@twoside
                \hbox{}%
                \thispagestyle{empty}%
                \newpage
              \fi
              \if@tempswa
                \twocolumn
              \fi}

% This changes the section headings style

\newcommand{\section}{\@startsection {section}{1}{\z@}
                        {20pt plus3pt minus2pt}
                        {0.0001pt}
                        {\tensfb}}
\newcommand{\subsection}{\@startsection {subsection}{2}{\z@}
                           {16pt plus2pt minus1pt}
                           {0.0001pt}
                           {\tensfb}}
\newcommand{\subsubsection}{\@startsection {subsubsection}{3}{\parindent}
                           {16pt plus2pt minus1pt}
                           {-1em}
                           {\tensfb}}
\newcommand{\paragraph}{\@startsection {paragraph}{4}{\z@}
                          {12pt plus2pt minus1pt}
                          {-1em}
                          {\normalfont\normalsize\bfseries}}
\newcommand{\subparagraph}{\@startsection {subparagraph}{4}{\parindent}
                            {12pt plus2pt minus1pt}
                            {-1em}
                            {\normalfont\normalsize\bfseries}}

% -----------------------------------------------------------------------
%                         Table of Contents
% -----------------------------------------------------------------------

\newcommand\@pnumwidth{1.55em}
\newcommand\@tocrmarg{2.55em}
\newcommand\@dotsep{4.5}
\setcounter{tocdepth}{3}
\newcommand\tableofcontents{%
    \section*{\contentsname
        \@mkboth{%
           \MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
    \@starttoc{toc}%
    }
\newcommand*\l@part[2]{%
  \ifnum \c@tocdepth >-2\relax
    \addpenalty\@secpenalty
    \addvspace{2.25em \@plus\p@}%
    \begingroup
      \setlength\@tempdima{3em}%
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      {\leavevmode
       \large \bfseries #1\hfil \hb@xt@\@pnumwidth{\hss #2}}\par
       \nobreak
       \if@compatibility
         \global\@nobreaktrue
         \everypar{\global\@nobreakfalse\everypar{}}
      \fi
    \endgroup
  \fi}
\newcommand*\l@section[2]{%
  \ifnum \c@tocdepth >\z@
    \addpenalty\@secpenalty
    \addvspace{1.0em \@plus\p@}%
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
    \endgroup
  \fi}
\newcommand*\l@subsection{\@dottedtocline{2}{1.5em}{2.3em}}
\newcommand*\l@subsubsection{\@dottedtocline{3}{3.8em}{3.2em}}
\newcommand*\l@paragraph{\@dottedtocline{4}{7.0em}{4.1em}}
\newcommand*\l@subparagraph{\@dottedtocline{5}{10em}{5em}}
\newcommand\listoffigures{%
    \section*{{List of Figures}
      \@mkboth{\MakeUppercase{List of Figures}}
              {\MakeUppercase{List of Figures}}}
    \@starttoc{lof}%
    }
\newcommand*\l@figure{\@dottedtocline{1}{1.5em}{2.3em}}
\newcommand\listoftables{%
    \section*{{List of Tables}
      \@mkboth{%
          \MakeUppercase{List of Tables}}
         {\MakeUppercase{List of Tables}}}
    \@starttoc{lot}%
    }
\let\l@table\l@figure

% ------------------------------------------------------------------------
%                         Tables and Figures
% ------------------------------------------------------------------------
\setcounter{topnumber}{4}         % These change the float placement 
\renewcommand{\topfraction}{.9}
\setcounter{bottomnumber}{4}
\renewcommand{\bottomfraction}{.9}
\setcounter{totalnumber}{4}
\renewcommand{\textfraction}{.1}
\renewcommand{\floatpagefraction}{.901}
\setcounter{dbltopnumber}{4}
\renewcommand{\dbltopfraction}{.9}
\renewcommand{\dblfloatpagefraction}{.91}         

\newcommand\figurename{Figure}
\newcommand\tablename{Table}
\newcommand\partname{Part}
\newcommand\appendixname{Appendix}
\newcommand\refname{References}
\newcommand\contentsname{Contents}


\long\def\@makecaption#1#2{ % 
   \par\addvspace{6pt}{\tensf
   \setbox\@tempboxa\hbox{\egtsf#1.\quad#2}%
   \ifdim \wd\@tempboxa >\hsize
       {\egtsf#1.\quad\ignorespaces#2}\par
     \else
       \hbox to\hsize{\hfil\box\@tempboxa\hfil}%
   \fi}\vskip4pt\global\c@subfigure0}
\newcounter{subfigure}
\long\def\subcaption#1{%
\global\advance\c@subfigure1
   \setbox\@tempboxa\hbox{{\egtsfb (\alph{subfigure})\hskip.5em#1}}%
   \ifdim \wd\@tempboxa >\hsize
       {{\sffamily\fonsize{8}{\baselineskip}
       (\alph{subfigure})\hskip.5em\ignorespaces#1\par}}
     \else\hbox to\hsize{\hfil\box\@tempboxa\hfil}\fi\par\addvspace{6pt}}
\newbox\tempbox
\newcommand{\figurebox}[2]{%
            \dimen99=#2
            \divide\dimen99 by2
            \centerline{\vbox{\hrule\hbox to #1{\vrule\hfill\vbox to #2{\hbox to
            #1{\hfill{\vrule height\dimen99 width0pt{\hfill}}\hfill}\vfill}
            \vrule}\hrule}}}
\newcounter{figure}
\renewcommand\thefigure{\@arabic\c@figure}
\def\fps@figure{tbp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename~\thefigure}
\newenvironment{figure}
               {\@float{figure}}
               {\end@float}
\newenvironment{figure*}
               {\@dblfloat{figure}}
               {\end@dblfloat}
\newcounter{table}
\renewcommand\thetable{\@arabic\c@table}
\def\fps@table{tbp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename~\thetable}
\newenvironment{table}{%
            \small
            \renewcommand{\arraystretch}{1.5}
            \@float{table}}
            {\end@float}
\newenvironment{table*}{%
            \small
            \renewcommand{\arraystretch}{1.5}
            \@dblfloat{table}}
            {\end@dblfloat}

\newcommand\x{@{\extracolsep{\hfill}}} % Command to control column space in
                                         % table environment.

% --------------------------------------------------------------------------
%                               Title Page
% --------------------------------------------------------------------------


\if@titlepage
  \newcommand{\maketitle}{\begin{titlepage}%
  \let\footnotesize\small
  \let\footnoterule\relax
  \null\vfil
  \vskip 60\p@
  \begin{center}%
    {{\fontsize{14}\twlsfbb \@title} \par}%
    \vskip 3em%
    {\large
     \lineskip .75em%
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
      \vskip 1.5em%
    {\large \@date \par}%       % Set date in \large size.
  \end{center}\par
  \@thanks
  \vfil\null
  \end{titlepage}%
  \setcounter{footnote}{0}%
  \let\thanks\relax\let\maketitle\relax
  \gdef\@thanks{}\gdef\@author{}\gdef\@title{}}
\else
\newcommand{\maketitle}{\par
  \begingroup
    \renewcommand{\thefootnote}{\fnsymbol{footnote}}%
    \def\@makefnmark{\hbox to\z@{$\m@th^{\@thefnmark}$\hss}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hbox to1.8em{\hss$\m@th^{\@thefnmark}$}##1}%
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@maketitle
      \else
        \twocolumn[\@maketitle]%
      \fi
    \else
      \newpage
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@maketitle
    \fi
    \thispagestyle{plain}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \let\thanks\relax
  \let\maketitle\relax\let\@maketitle\relax
  \gdef\@thanks{}\gdef\@author{}\gdef\@title{}}
\fi
 
\renewcommand\title[1]{\gdef\@title{\twlsfbb \uppercase{#1}}}

% New definition for loading papernum

\def\papernum{ }

\def\@maketitle{%
  \newpage
  \null\vspace*{-26pt}             
   \vbox{\hbox to \textwidth{\begin{tabular}{@{}c@{\hskip3pc}}
   \hbox to 46pt{\vbox to 46pt{\vss\hsize46pt\vss}}\end{tabular}\hss
  \vbox{\hsize37pc\scriptsize\sf\vskip\baselineskip%
  \bannerfnt
  \hfill \confshortname,\  \confdate,\ \confyear}
% \hfill \confshortname,\ \confcity,\ \confcountry,\ \confdate\ \confyear}
  \hskip1pc}}
  \vskip.25in
  \vskip .25pc{\large\twlsfb
               \begin{center}\leftskip.5in plus1fill\rightskip\leftskip
               \@title\par\end{center}}
  \vskip2pc{\begin{center} \@author\par\end{center}
  }\vskip12pt}


\if@titlepage
  \newenvironment{abstract}{%
     \titlepage
     \null\vfil
     \begin{center}
        {\tensfb Abstract}
        \@endparpenalty\@M
     \end{center}}
     {\par\vfil\null\endtitlepage}
\else
  \newenvironment{abstract}{%
     \if@twocolumn
        \normalsize\par\addvspace{12pt}\noindent
        {\tensfb Abstract}\par
     \else
        \begin{center}
          {{\tensfb Abstract}\vspace{-.5em}\vspace{\z@}}
        \end{center}
        \quotation
     \fi}
     {\if@twocolumn\else\endquotation\fi}
\fi 

% Get the multiple author set

\newcount\@authcnt
\newcount\@tmpcnt\@tmpcnt\z@

\def\@author{%
 \ifnum\@authcnt>7
  \ifnum\@tmpcnt<\@authcnt
   \global\advance\@tmpcnt1
   \leavevmode\hbox{\hss\csname @auth\romannumeral\the\@tmpcnt\endcsname\hss}%
   \quad 
   \let\next\@author
  \else
   \let\next\relax
  \fi
 \else
  \ifnum\@tmpcnt<\@authcnt
   \global\advance\@tmpcnt1
   \ifnum\@tmpcnt=\@authcnt
    \expandafter\expandafter\expandafter\au@car\csname @auseq\romannumeral\the%
\@authcnt\endcsname\@nil
    \leavevmode\hbox to \@au@car{\hss\csname @auth\romannumeral\the\@tmpcnt%
\endcsname\hss}
   \else
    \expandafter\expandafter\expandafter\au@car\csname @auseq\romannumeral%
    \the\@authcnt\endcsname\@nil
    \leavevmode\hbox to \@au@car{\hss\csname @auth\romannumeral\the\@tmpcnt%
    \endcsname\hss}
   \fi
   \let\next \@author
  \else
   \let\next\relax
  \fi
 \fi
 \next}


\newcommand{\affiliation}[1]{\\ \normalfont #1}

\def\@auseqi{{7.4in}}
\def\@auseqii{{3.45in}{3.45in}}
\def\@auseqiii{{2.4in}{2.4in}{2.4in}}
\def\@auseqiv{{3.45in}{3.45in}{3.45in}{3.45in}}
\def\@auseqv{{2.4in}{2.4in}{2.4in}{3.45in}{3.45in}}
\def\@auseqvi{{2.4in}{2.4in}{2.4in}{2.4in}{2.4in}{2.4in}}
\def\@auseqvii{{3.45in}{3.45in}{2.4in}{2.4in}{2.4in}{3.45in}{3.45in}}
\def\au@car#1#2\@nil{\gdef\@au@car{#1}}
\def\au@cdr#1#2\@nil{\expandafter\gdef\csname @auseq\romannumeral\the\@authcnt%
\endcsname{#2}}

\renewcommand{\author}[1]{%
    \global\advance\@authcnt1
    \expandafter\gdef\csname @auth\romannumeral\the\@authcnt\endcsname
    {\hspace{-2cm}\begin{tabular}[t]{@{}c@{}}\twlsfb #1\\[20pt]
     \end{tabular}}}


% ---------------------------------------------------------------------------
%                           Bibliography 
% ---------------------------------------------------------------------------

\newcommand\appendix{\par
  \setcounter{section}{0}%
  \setcounter{subsection}{0}%
  \renewcommand\thesection{\@Alph\c@section}}

\newcommand\newblock{}

\newenvironment{thebibliography}[1]
    {\section*{\refname
        \@mkboth{\MakeUppercase\refname}{\MakeUppercase\refname}}%
    \def\@tempa{#1}\ifx\@tempa\@empty
    \list{}{\usecounter{enumiv}\leftmargin7pt\itemindent-7pt\itemsep0pt}
    \else
    \list{\@biblabel{\@arabic\c@enumiv}}
    {\settowidth\labelwidth{\@biblabel{#1}}
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \usecounter{enumiv}%
    \let\p@enumiv\@empty
    \renewcommand\theenumiv{\@arabic\c@enumiv}}\fi
    \renewcommand\newblock{\hskip .11em \@plus.33em \@minus.07em}%
    \sloppy\clubpenalty4000\widowpenalty4000%
    \sfcode`\.=1000\relax}
   {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}

% ---------------------------------------------------------------------------
% Adapted from apalike.sty style for citing references
%
% Use parens instead of brackets for \cite,
% and no label in the bibliography
%
\def\@cite#1#2{[#1\if@tempswa , #2\fi]}
\def\@biblabel#1{}
%
% `; ' goes between cites, and there's no \hbox around individual cites
%
\def\@citex[#1]#2{\if@filesw\immediate\write\@auxout{\string\citation{#2}}\fi
  \def\@citea{}\@cite{\@for\@citeb:=#2\do
    {\@citea\def\@citea{; }\@ifundefined
       {b@\@citeb}{{\bf ?}\@warning
       {Citation `\@citeb' undefined}}%
{\csname b@\@citeb\endcsname}}}{#1}}
% ---------------------------------------------------------------------------

% ---------------------------------------------------------------------------
%                          Special declarations
% --------------------------------------------------------------------------

% Nomenclature environment

\newbox\tempbox
\newenvironment{keywords}{%
   \newcommand\entry[2]{%
       \setbox\tempbox\hbox{##1.\quad}
       \hangindent\wd\tempbox\noindent{##1}\quad\ignorespaces##2\par}
       \section*{Key words}}{\par\addvspace{12pt}}

% Acknowledgement environment

\newenvironment{acknowledgment}{%
   \section*{Acknowledgment}}{\par\addvspace{12pt}}

% The following are the new theorem definitions


\AtEndOfClass{%
  \def\@begintheorem#1#2{\trivlist \item[\hskip \labelsep%
  {\tensfb #1\ #2.}]\it}
  \def\@opargbegintheorem#1#2#3{\trivlist
        \item[\hskip \labelsep%
  {\tensfb #1\ #2\ (#3).}]\it}
  \def\newtheorem{\@ifstar{\@newstheorem}{\@newtheorem}}
  \def\@newtheorem#1{\@ifnextchar[{\@othm{#1}}{\@nthm{#1}}}
  \def\@newstheorem#1#2{\@namedef{#1*}
  {\@ifnextchar[{\@opargbeginstheorem{#2}}{\@beginstheorem{#2}}}%
  \@namedef{end#1*}{\@endtheorem}}
  \def\@beginstheorem#1{\trivlist \item[\hskip \labelsep%
  {\tensfb #1.}]\it}
  \def\@opargbeginstheorem#1[#2]{\trivlist\item[\hskip \labelsep%
  {\tensfb #1\ (#2).  }]\it}
%
  \def\proof{\@ifnextchar[{\@optargproof}{\@proof}}
  \def\@proof{\trivlist \item[\hskip \labelsep{\it Proof.}]}
  \def\@optargproof[#1]{\trivlist \item[\hskip \labelsep{\it #1.}]}
  \def\endproof{\endtrivlist}
  \def\qed{\vskip-\lastskip\vskip-\baselineskip\hbox to \hsize{\hfill$\Box$}} 
}


% -------------------------------------------------------------------------
%                 Header and Footer Definitions
% -------------------------------------------------------------------------

\if@twoside
  \def\ps@headings{%
      \let\@oddfoot\@empty\let\@evenfoot\@empty
      \def\@evenhead{}%
      \def\@oddhead{}%
      \let\@mkboth\markboth
    \def\sectionmark##1{%
      \markboth {\MakeUppercase{%
        \ifnum \c@secnumdepth >\z@
          \thesection\hskip 1em\relax
        \fi
        ##1}}{}}%
    \def\subsectionmark##1{%
      \markright {%
        \ifnum \c@secnumdepth >\@ne
          \thesubsection\quad
          \fi
          ##1}}}
\else
  \def\ps@headings{%
    \let\@oddfoot\@empty
    \def\@oddhead{}%
    \let\@mkboth\markboth
    \def\sectionmark##1{%
      \markright {\MakeUppercase{%
        \ifnum \c@secnumdepth >\m@ne
          \thesection\quad
        \fi
        ##1}}}}
\fi


\def\ps@myheadings{%
    \let\@mkboth\@gobbletwo
    \def\@oddfoot{}%
    \def\@evenfoot{}%
\let\@oddhead\@empty
\let\@evenhead\@empty
    \def\sectionmark##1{}
    \def\subsectionmark##1{}
    }


\mark{{}{}}
\def\ps@plain{\let\@mkboth\@gobbletwo
     \def\@oddhead{}%
     \def\@oddfoot{}%
     \let\@evenhead\@oddhead\let\@evenfoot\@oddfoot}


\markboth{}{}
\ps@myheadings
\pagenumbering{arabic}
\if@twocolumn\twocolumn\sloppy\flushbottom\else\onecolumn\fi
\advance\hoffset-7pc
\advance\voffset-10pc
%
%
\endinput

% End of Class
