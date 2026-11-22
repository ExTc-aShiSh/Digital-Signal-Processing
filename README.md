<div align="center">

# Digital Signal Processing (DSP) Laboratory

<img src="https://upload.wikimedia.org/wikipedia/commons/2/21/Matlab_Logo.png" alt="MATLAB" width="80"/>
&nbsp;&nbsp;&nbsp;
<img src="https://upload.wikimedia.org/wikipedia/commons/9/92/LaTeX_logo.svg" alt="LaTeX" width="100"/>

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)  [![MATLAB](https://img.shields.io/badge/MATLAB-R2020b%2B-orange.svg)](https://www.mathworks.com/products/matlab.html)  [![LaTeX](https://img.shields.io/badge/LaTeX-Practical%20File-008080.svg)](https://www.latex-project.org/)  [![Status](https://img.shields.io/badge/Status-Archived-lightgrey.svg)](#)

MATLAB implementations, analytical scripts, and a LaTeX-typeset practical file for Digital Signal Processing laboratory experiments.

</div>

---

## About

This repository contains a complete set of MATLAB scripts developed as part of an academic **Digital Signal Processing** laboratory course. It serves as a practical record of laboratory experiments, algorithm implementations, and signal analysis techniques covered throughout the curriculum.

Additionally, the repository includes the full **LaTeX source** for the formal practical file, packaged as a ready-to-compile project.

> **Archive Notice:**
> This repository has been finalized and will no longer receive updates. The last maintenance date is **22 November 2026**, coinciding with the conclusion of the associated academic course. The codebase is preserved as-is for reference purposes.

---

## Repository Structure

| Directory | Experiment | Script |
|-----------|-----------|--------|
| `Basic_discrete_time_signals/` | Generation of basic discrete-time signals | `Exp1.m` |
| `LInear_and_circular_conv/` | Linear and circular convolution | `Exp2.m` |
| `Correlation&auto_correlation/` | Cross-correlation and auto-correlation | `Exp3.m` |
| `DTFT and its Properties/` | Discrete-Time Fourier Transform and properties | `Exp4.m` |
| `DFT and IDFT/` | Discrete Fourier Transform and Inverse DFT | `Exp5.m` |
| `DIT_FFT_Algorithm/` | Decimation-in-Time FFT (Radix-2) | `Exp6.m` |
| `DIF_FFT_Algorithm/` | Decimation-in-Frequency FFT (Radix-2) | `Exp7.m` |
| `DSP_Lab_file.zip` | LaTeX source for the complete practical file | `.tex` project |

---

## LaTeX Practical File

The file `DSP_Lab_file.zip` contains the complete LaTeX source for the typeset laboratory practical file, including:

- **Main document:** `DSP_LAB.tex` with a custom cover page (`cover.tex`) and table of contents (`index.tex`)
- **Experiment write-ups:** `experiment-01.tex` through `experiment-07.tex`, covering theory, code, observations, and results for each experiment
- **Figures and plots:** All output graphs and diagrams organized under `images/`, `exp4_pics/`, and `exp7_pics/`
- **Pre-compiled PDF:** `DSP_LAB.pdf` is included for immediate reference

To edit or recompile the document, extract the zip and open the project in any LaTeX editor:

- **Online:** [Overleaf](https://www.overleaf.com/) -- upload the zip directly as a new project
- **Offline:** [TeXstudio](https://www.texstudio.org/), [TeXmaker](https://www.xm1math.net/texmaker/), [VS Code](https://code.visualstudio.com/) with the LaTeX Workshop extension, or any standard LaTeX distribution (TeX Live, MiKTeX)

---

## Requirements

To execute the scripts in this repository, one of the following environments is required:

- **MATLAB** (R2020b or newer recommended)
- **GNU Octave** (free, open-source MATLAB-compatible alternative)
- **MATLAB Online** (browser-based, requires MathWorks account)

---

## Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/ExTc-aShiSh/Digital-Signal-Processing.git
   ```
2. Open the desired experiment directory in MATLAB or Octave.
3. Run the corresponding `.m` script from the Editor or Command Window.

---

## License

This project is licensed under the **MIT License**. Refer to the [LICENSE](./LICENSE) file for full terms.

The code is intended for educational purposes and may be freely used as a reference for learning DSP concepts and MATLAB-based signal processing. Contributions via pull requests are welcome.

---

<div align="center">

**Made with ❤️ by Ashish**

</div>
