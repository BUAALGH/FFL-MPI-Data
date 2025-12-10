🌟 FFL-MPI-Data: Magnetic Particle Imaging (MPI) Projection Dataset
📝 Project Overview (Introduction)
This repository serves as the official project page for FFL-MPI-Data, a public projection imaging dataset specifically designed for Field-Free Line Magnetic Particle Imaging (FFL-MPI) research.

The FFL-MPI-Data provides a comprehensive collection of both measured and simulated data, offering critical resources for developing and evaluating image reconstruction algorithms, especially for challenging tasks like limited-angle and sparse-angle reconstruction.

Dataset Availability: The full dataset is available on Zenodo: https://doi.org/10.5281/zenodo.16563447

Authors: Guanghui Li (liguanghui@buaa.edu.cn), Haicheng Du

💾 FFL-MPI-Data Content Breakdown
The dataset is categorized into two main groups:

1. Measured Datasets
Acquisition System: Collected using a self-developed, open-sided FFL-MPI system.

Phantoms: Features 100 unique 3D-printed shape phantoms. The phantoms are filled with synomag magnetic nanoparticles (diameter: 70nm).

Data Included: Provides the complete data pipeline:

Voltage Signals (Raw Sensor Data).

Sinograms.

Reconstructed Image Data.

Detailed information on the 2nd to 7th harmonics of the voltage signals.

2. Simulated Datasets
Digital Phantoms: Uses the MNIST handwritten digit dataset as the basis for digital phantoms.

Scale: Includes 60,000 training samples and 10,000 testing samples.

Simulation Model: The digital phantoms are processed using a simulation framework built based on the MJA model (Magnetic Joint Action Model), ensuring realism in the simulated signal responses.

📂 FFL-MPI-Data Construction Workflow
The construction of the FFL-MPI-Data involves careful processing from raw signal acquisition (measured) or MJA modeling (simulated) to the final sinogram and image domains.

🛠 Project Codes & Examples
This project provides example codes for loading and processing the dataset, available in both MATLAB and Python formats (.mat and .py files).

1. Sensor Domain Processing (Measured Data)
measured_sensor

Purpose: To process data in the sensor domain (raw voltage signals).

Procedures: Includes reading voltage signals, Short-Time Fourier Transform (STFT) processing, and Filtered Back Projection (FBP) processing on the raw data.

2. Sinogram Domain Processing (Measured Data)
measured_sinogram_con

Purpose: Designed for processing data in the sinogram domain of the measured datasets.

Procedures: Involves reading the pre-built sinograms and reconstructing images via FBP.

3. Sinogram Domain Processing (Simulated Data)
simulated_sinogram_con

Purpose: Utilized to handle data in the sinogram domain of the simulated datasets.

Procedures: Includes reading the sinograms and performing FBP-based image reconstruction.

🖼 Data Examples
The data encompasses a wide variety of reconstructed images, ranging from controlled digital phantoms (MNIST) in the simulated dataset to complex physical phantoms in the measured dataset.

📧 Project Contact
Project Contact: Guanghui Li (liguanghui@buaa.edu.cn)

🙏 Acknowledgement
We sincerely appreciate your interest in the FFL-MPI-Data project. We hope this dataset will significantly contribute to FFL-MPI image reconstruction research, addressing the need for high-quality, domain-specific data.

If you have any suggestions, questions, or discover any errors, please feel free to contact us!
