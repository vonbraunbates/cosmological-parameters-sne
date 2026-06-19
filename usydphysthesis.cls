% LaTeX2e thesis style for Physics at the University of Sydney.
% It sets up a title page, loads up the amsbook class file and
% then redefines a number of things which I don't like in amsbook.

% Francesca von Braun-Bates, 2012

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{usydphysthesis}
  [2026/06/11 Simplified University of Sydney Physics thesis class file]

% options %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% additional fields in \maketitle
\def\@subtitle{\relax}
\newcommand{\subtitle}[1]{\gdef\@subtitle{#1}}

\def\@university{University}
\newcommand{\university}[1]{\gdef\@university{#1}}

\def\@department{Department}
\newcommand{\department}[1]{\gdef\@department{#1}}

\def\@degree{Degree Name}
\newcommand{\degree}[1]{\gdef\@degree{#1}}

\def\@thesistype{A thesis}
\newcommand{\thesistype}[1]{\gdef\@thesistype{#1}}

% usydphysthesis is now fixed to two-sided thesis layout with numeric citations.
% Unknown options are passed through to amsbook.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{amsbook}}
\ProcessOptions\relax

\PassOptionsToClass{twoside,openright}{amsbook}
\LoadClass[12pt]{amsbook}

% packages %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[
  backend=bibtex,
  bibstyle=numeric,
  citestyle=numeric-comp,
  giveninits=true
]{biblatex}
\RequirePackage{amssymb}             % extra maths symbols
% \RequirePackage[titletoc]{appendix}  % appendices
\RequirePackage{booktabs,multirow,threeparttable} % tables
\RequirePackage{graphicx}            % graphics
\RequirePackage{subcaption}          % subfigures
\RequirePackage{lscape}              % landscape pages
\RequirePackage[parfill]{parskip}    % line between paragraphs
\RequirePackage{xparse}

\hfuzz=4pt
\vfuzz=4pt

%%%%% amsbook setup %%%%%%%%%%%%%%%%%%%%%%%%%

% we now change a few things in the standard amsbook setup
\clearpage{\pagestyle{empty}\cleardoublepage}

% default margins for two-sided printing
\RequirePackage[twoside]{geometry}[2010/09/12]

% margins for different environments
\newgeometry{bindingoffset=1cm,
            vscale=0.85,vcentering,
            hscale=0.8,nomarginpar}
\savegeometry{default-layout}
\newgeometry{hscale=0.7}
\savegeometry{title-layout}
\newgeometry{vscale=0.85,vcentering,
            hscale=0.9,nomarginpar}
\savegeometry{widetable-layout}

%%% cross-references & citations %%%%%%%%%%%%%%
% Define abbreviations in citation
\DefineBibliographyStrings{english}{andothers={\mbox{\&\textit{al}\adddot}}}
\DefineBibliographyStrings{english}{and={\&}}
\renewcommand*{\finalnamedelim}{\addspace\&\addspace}

% number within chapters
\numberwithin{section}{chapter}
\numberwithin{equation}{chapter}
\numberwithin{figure}{chapter}
\numberwithin{table}{chapter}

% Nice references: 
\RequirePackage[final]{hyperref}
\hypersetup{
  colorlinks=true,
  linkcolor=blue,
  citecolor=red,
  urlcolor=red
}
\RequirePackage[capitalise,nameinlink]{cleveref}
% \Crefname{figure}{\text{Fig.}}{\text{Fig.}}
% \Crefname{table}{\text{Table}}{\text{Tables}}
\Crefformat{section}{\S#2#1#3}
\Crefformat{subsection}{\S#2#1#3}
% \newcommand\itemref[1]{(\textsc{\romannumeral\ref{#1}})} % Item (I)

%% lists %%%%%%%%%%%%%%%%%%%%%%%%%

% bullet for itemize
\renewcommand{\labelitemi}{\ensuremath\circ}
\renewcommand{\labelitemii}{\ensuremath{\square}}
\renewcommand{\labelitemiii}{\guillemotright}
\renewcommand{\labelitemiv}{\ast}

% lists for enumerate
\renewcommand{\labelenumi}{\Roman{enumi}.}
\renewcommand{\labelenumii}{\roman{enumii}.}
\renewcommand{\labelenumiii}{\alph{enumiii}.}
\renewcommand{\labelenumiv}{\arabic{enumiv}.}

% table of contents %%%%%%%%%%%%%%%%%%%%%%%
% remove toc title: solves parskip bug
\def\contentsname{\normalfont} 
  % make chapter entries bold
  \def\l@chapter{
      \@tocline{0}{8pt plus1pt}{0pt}{}{\bfseries}
  }
  % indent subsections
  \def\l@section{
     \@tocline{1}{1pt}{10pt}{}{}
  }
  % indent subsections more than section
  \def\l@subsection{
     \@tocline{2}{1pt}{20pt}{}{}
  }
  %% this is the amsbook macro \@tocline 
  \def\@tocline#1#2#3#4#5#6#7{\relax
  \ifnum #1>2 % [\c@tocdepth] % omit tocdepth > 3 or [default]
  \else
    % vertical space between chapters
    \par \addpenalty\@secpenalty\addvspace{#2}%
    % begin amsbook settings
    \begingroup \hyphenpenalty\@M
      \@tempdima\csname r@tocindent\number#1\endcsname\relax
    \parindent\z@ \leftskip#3\relax \advance\leftskip\@tempdima\relax
    \rightskip\@pnumwidth plus4em \parfillskip-\@pnumwidth
    {#5\leavevmode\hskip-\@tempdima #6}\nobreak\relax
    % put dots in only for cetain tocdepth
    \ifnum #1< 1 \hfill 	% fill with whitespace
    \else \dotfill 				% fill with dots
    \fi \hbox to\@pnumwidth{\@tocpagenum{#5{#7}}}\par
    \nobreak
    \endgroup
  \fi
  }

% headings %%%%%%%%%%%%%%%%%%%%%%%%%%%
% chapter in header should be \sc rather than in capitals
\def\@makechapterhead#1
{\global\topskip 7.5pc\relax
  \begingroup
  \fontsize{\@xivpt}{18}\bfseries\centering
    \ifnum\c@secnumdepth>\m@ne
      \leavevmode \hskip-\leftskip
      \rlap{\vbox to\z@{\vss
          \centerline{\normalsize\mdseries
           \@xp{ \textsc{\chaptername} } % this line formats Chapter X:
          \enspace\thechapter} % this line formats the chapter title
          \vskip 3pc}}\hskip\leftskip\fi
     #1\par \endgroup
  \skip@34\p@ \advance\skip@-\normalbaselineskip
  \vskip\skip@ 
}

% the standard amsbook headings are not very good %%%%
\def\partrunhead#1#2#3{%
  \@ifnotempty{#2}{\ignorespaces#1 #2\unskip\@ifnotempty{#3}{. }}%
  \textsc{#3}
}

\let\chapterrunhead\partrunhead
\let\sectionrunhead\partrunhead

% theorems %%%%%%%%%%%%%%%%%%%%%%%
% give an easy way to change the font used on theorem labels
\let\SMStheoremfont=\bfseries
\renewcommand{\qedsymbol}{\textsc{q.e.d.}}

% Theorems (etc) have a common numbering. 
\newtheorem{theorem}{Dummy}[chapter]
\newtheorem{defn}[theorem]{Definition}
\newtheorem{thm}[theorem]{Theorem}
\newtheorem{prop}[theorem]{Proposition}
\newtheorem{lem}[theorem]{Lemma}
\newtheorem{cor}[theorem]{Corollary}

% This removes the italics in boxed theorems
\theoremstyle{remark}
\newtheorem{Remark}[equation]{Remark}
\newtheorem{Example}[equation]{Example}

% the AMSmath theorems are indented by \parindent which looks silly
\def\@thm#1#2#3{%
  \ifhmode\unskip\unskip\par\fi
  \normalfont
  \trivlist
  \let\thmheadnl\relax
  \let\thm@swap\@gobble
  \let\thm@indent\noindent% no indent
  \thm@headfont{\SMStheoremfont}% heading font bold
  \thm@notefont{\fontseries\mddefault\upshape}%
  \thm@headpunct{:}% add colon, not period, after heading
  \thm@headsep 5\p@ plus\p@ minus\p@\relax
  \thm@space@setup
  #1% style overrides
  \@topsep \thm@preskip               % used by thm head
  \@topsepadd \thm@postskip           % used by \@endparenv
  \def\@tempa{#2}\ifx\@empty\@tempa
    \def\@tempa{\@oparg{\@begintheorem{#3}{}}[]}%
  \else
    \refstepcounter{#2}%
    \def\@tempa{\@oparg{\@begintheorem{#3}{\csname the#2\endcsname}}[]}%
  \fi
  \@tempa
}

% the AMSmath proofs are indented \parindent which looks silly
\renewenvironment{proof}[1][\proofname]{\par
  \pushQED{\qed}%
  \normalfont \topsep6\p@\@plus6\p@\relax
  \trivlist
  \itemindent\z@
  \item[\hskip\labelsep\SMStheoremfont #1\@addpunct{.}]\ignorespaces
}{\popQED\endtrivlist\@endpefalse}

% the AMS paragraphs have an indent with parskip, which looks silly
\parindent=0in

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % date on title page of thesis
% \def\Today{\ifcase\month\or January\or February\or March\or
%   April\or May\or June\or July\or August\or September\or
%   October\or November\or December\fi\space\number\year}

% thesis title page
\def\@maketitle{
  \cleardoublepage\thispagestyle{empty}%
  \begingroup \topskip\z@skip
    \null\vfil
    \begingroup
    \LARGE\bfseries \centering
    \openup\medskipamount
     \@title\par
	\if\@subtitle\relax\else\large\@subtitle\par\fi % subtitle
	\vspace{30pt}%
    \centering\mdseries\authors\par\bigskip
    \endgroup
    \vfil\vfil\vfil
    \begin{center}
      \@thesistype\ submitted in fulfillment of\\
      the requirements for the degree of\\
      \@degree
    \vfil\vfil
      \if\@department\relax\else\large\@department\par\fi % department
      \if\@university\relax\else\large\@university\par\fi % university
      \vskip18mm%6mm
      \includegraphics[width=50mm]{crest.png}
    \vskip6mm%\vfil
      \normalsize\@date
    \end{center}
    \vfil
  \endgroup
  \cleardoublepage
}

% insert page break after tableofconents
\def\tableofcontents{%
  \@starttoc{toc}\contentsname\newpage
}

% control spacing in the bibliography and fix up the toc entry
%\def\thebibliography#1{%
%  \c@chapter\z@ \c@section\z@\let\chaptername\relax
%  \chapter*{References}\list
%  {[\arabic{enumi}]}{\settowidth\labelwidth{[#1]}\leftmargin\labelwidth
%  \advance\leftmargin\labelsep
%  \itemsep\z@\parsep\z@\topsep\z@\parskip\z@
%  \usecounter{enumi}}
%  \def\newblock{\hskip .11em plus .33em minus .07em}
%  \sloppy\clubpenalty4000\widowpenalty4000
%  \sfcode`\.=1000\relax}

\endinput
