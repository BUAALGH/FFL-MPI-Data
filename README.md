# FFL-MPI-Data

This is FFL-MPI-Data, a public projection imaging dataset for field-free line magnetic particle imaging.
Corresponding Authors: Guanghui Li, Haicheng Du

The dataset includes both simulated datasets and measured datasets, where:

- **Measured datasets**: Collected based on a self-developed open-sided FFL-MPI system, featuring 100 3D-printed shape phantoms. The phantoms are filled with synomag (diameter: 70nm). The measured datasets provide voltage signals, sinograms, and image data of all phantoms, as well as information on the 2nd to 7th harmonics.
  
- **Simulated datasets**: Use MNIST as digital phantoms, including 60,000 training samples and 10,000 testing samples. These simulated datasets are input into a simulation framework built based on the MJA model.

This project provides example codes for loading the dataset, available in both MATLAB and Python formats. To access and download the FFL-MPI-Data dataset, please visit the official website zenodo at 10.5281/zenodo.16516439:

This project provides both `.mat` and `.py` codes, where:

1. `measured_sensor` is used to process data in the sensor domain, including procedures such as reading voltage signals, STFT processing, and FBP processing.

2. `measured_sinogram_con` is designed for processing data in the sinogram domain of measured datasets, which involves reading sinograms and reconstructing images via FBP.

3. `simulated_sinogram_con` is utilized to handle data in the sinogram domain of simulated datasets, including reading sinograms and performing FBP-based image reconstruction.

FFL-MPI-Data construction workflow:
<img width="4082" height="2748" alt="论文Figures_06" src="https://github.com/user-attachments/assets/31f7cbbd-02a1-45d1-b091-d27324f8d104" />

Examples of simulated dataset and measured data images：
<img width="4082" height="1856" alt="论文Figures_09" src="https://github.com/user-attachments/assets/2771144f-9aa5-4e0b-bc1f-b6c10ae48a02" />
