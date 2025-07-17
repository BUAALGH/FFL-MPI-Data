# FFL-MPI-Data

This is FFL-MPI-Data, a public projection imaging dataset for field-free line magnetic particle imaging.

The dataset includes both simulated datasets and measured datasets, where:

- **Measured datasets**: Collected based on a self-developed open-sided FFL-MPI system, featuring 100 3D-printed shape phantoms. The phantoms are filled with synomag (diameter: 70nm). The measured datasets provide voltage signals, sinograms, and image data of all phantoms, as well as information on the 2nd to 7th harmonics.
  
- **Simulated datasets**: Use MNIST as digital phantoms, including 60,000 training samples and 10,000 testing samples. These simulated datasets are input into a simulation framework built based on the MJA model.

This project provides example codes for loading the dataset, available in both MATLAB and Python formats.
