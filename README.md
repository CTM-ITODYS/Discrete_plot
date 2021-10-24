# Discrete_plot

This software aims to create a dispersion plot from several data files of windows generated through umbrella sampling simulation. This software generates an image with the help of the gnuplot free software. This last is available on:
http://www.gnuplot.info/

Usage: Discrete_plot.pl LABEL meta_file 

Where:
- LABEL is a... label which will defined the output files.
- meta_file is a file similar to the input file of WHAM.

Two output files are generated: LABEL.dat and LABEL.gnuplot ; The first will contain all the values whereas the other one is a script for gnuplot visualization.

Florent Barbault october 2020.

If you use this software please cite:
Theoretical and Experimental Elucidation of the Adsorption Process of a Bioinspired Peptide on Mineral Surfaces
J. Touzeau, M. Seydou, F. Maurel, L. Tallet, A. Mutschler, P. Lavalle, and F. Barbault
Langmuir 2021, 37, 38, 11374–11385
