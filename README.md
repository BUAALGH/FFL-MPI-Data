# 🌟 FFL-MPI-Data

This repository serves as the official project page for ​**FFL-MPI-Data**​, *A public projection imaging dataset for field free line magnetic particle imaging*.

The FFL-MPI-Data provides a comprehensive collection of both **measured** and **simulated** data, offering critical resources for developing and evaluating image reconstruction algorithms for field free line magnetic particle imaging, especially for challenging tasks like limited-angle and sparse-angle reconstruction.

---

## 💾 Dataset Availability & Overview

### Dataset Access

The full dataset is available on Zenodo:

https://doi.org/10.5281/zenodo.16563447

### Authors

* **Guanghui Li** (liguanghui@buaa.edu.cn), **Haicheng Du**, Ziwei Chen, et al

### FFL-MPI-Data Content Breakdown

The dataset is categorized into two main groups:

#### 1. Measured Datasets

* **Acquisition System:** Collected using a self-developed, open-sided FFL-MPI system.
* **Phantoms:** Features **100 unique 3D-printed shape phantoms** filled with **synomag** magnetic nanoparticles (diameter: 70nm).
* **Data Included:** Provides the complete data pipeline:
  * **Voltage Signals** (Raw Sensor Data).
  * ​**Sinograms**​.
  * ​**Reconstructed Image Data**​.
  * Detailed information on the **2nd to 7th harmonics** of the voltage signals.

#### 2. Simulated Datasets

* **Digital Phantoms:** Uses the **MNIST handwritten digit dataset** as the basis for digital phantoms.
* **Scale:** Includes **60,000 training samples** and ​**10,000 testing samples**​.
* **Simulation Model:** The digital phantoms are processed using a **simulation framework built based on the MJA model** (Magnetic Joint Action Model), ensuring realism in the simulated signal responses.

---

## 🏗 FFL-MPI-Data Construction Workflow

The construction of the FFL-MPI-Data involves careful processing from raw signal acquisition (measured) or Langevin modeling (simulated) to the final sinogram and image domains.

---

## 📂 Folder Structure and Directory

The repository is organized to provide clear access to reconstruction, simulation, and deep learning examples:

```
FFL-MPI-Data/
├── 1_reconstruction_codes/         # Signal Processing and Traditional Reconstruction (MATLAB/Python)
│   ├── measured_sensor.*           # Process raw voltage signals (signal -> STFT -> sinogram -> FBP -> image)
│   ├── measured_sinogram.*         # Process measured sinograms (sinogram -> FBP -> image)
│   └── simulated_sinogram.*        # Process simulated sinograms (sinogram -> FBP -> image)
├── 2_simulation_framework/         # Calibrated MPI simulation framework
│   ├── main_function.m             # main function to run
│   ├── Datasets                    # MNIST train & test dataset and lables
│   ├── Noise                       # FFL-MPI Scanner background noises with harmonics image
|   ├── Models                      # SPIOs model with Langevin function
|   ├── Modules                     # functinal modules: Basic_setup, Magnetic_Field_Generation, Signal_Generation, Visualization_2
|   └── Phantom_Photos              # example phantom photos
├── 3_deep_learning_demo/           # Deep learning based reconstruction examples
│   ├── limited_angle_task/         # Limited-Angle Reconstruction Task
│   └── sparse_angle_task/          # Sparse-Angle Reconstruction Task
└── README.md                       # This file
```

---

## 🛠 Code Usage and Functionality

This project provides example codes for loading and processing the dataset.

### 1. `reconstruction_codes`: Signal Processing and Image Reconstruction Example Codes

This module contains scripts that demonstrate loading the dataset and performing basic reconstruction using traditional FBP methods across different data domains.

| **Script Name**        | **Data Domain**   | **Dataset Type** | **Key Procedures**                      |
| ------------------------------ | ------------------------- | ------------------------ | ----------------------------------------------- |
| `measured_sensor`        | Sensor Domain (Voltage) | Measured               | Reading Voltage Signals, STFT Processing, FBP |
| `measured_sinogram`      | Sinogram Domain         | Measured               | Reading Sinograms, FBP-based Reconstruction   |
| `simulated_sinogram`     | Sinogram Domain         | Simulated              | Reading Sinograms, FBP-based Reconstruction   |
If the user is processing voltage signals from the measured dataset, use `measured_sensor.m`;  
if processing sinograms from the measured dataset, use `measured_sinogram.m`;  
if processing sinograms from the simulated dataset, use `simulated_sinogram.m`.  

The user only needs to modify their own data storage path to complete the image reconstruction.  
Our sample code provides a single-data processing method. If batch data processing is required, simply add an additional loop for handling.

### 2. Simulation Framework `2_simulation_framework`

This module provides the calibrated MPI simulation framework used to generate large-scale synthetic datasets based on the MJA model.

**Usage:**

**Bash**

```
# Example: Generate 10000 samples for the limited angle task
python 2_simulation_framework/generate_data.py --num_samples 10000 --task limited_angle --output_dir <SIM_DATA_PATH>
```

### 3. Deep Learning Demo `3_deep_learning_demo`

This module presents deep learning usage examples, typically utilizing the simulated data for pre-training and the measured data for fine-tuning.

* **Limited-Angle Reconstruction Task:** Focuses on restoring images from limited projection angles.
* **Sparse-Angle Reconstruction Task:** Focuses on restoring images from a sparse set of projection angles.

---

## 🖼 Data Examples

The data encompasses a wide variety of reconstructed images, ranging from controlled digital phantoms (MNIST) in the simulated dataset to complex physical phantoms in the measured dataset.

---
![论文Figures_09](https://github.com/user-attachments/assets/8f19adc6-183e-49db-bef7-28a9a4ccff68)


## 📧 Project Contact

Project Contact: **Guanghui Li** (liguanghui@buaa.edu.cn)

---

## 🙏 Acknowledgement

We sincerely appreciate your interest in the **FFL-MPI-Data** project. We hope this dataset will significantly contribute to **FFL-MPI** image reconstruction research, addressing the need for high-quality, domain-specific data.

If you have any suggestions, questions, or discover any errors, please feel free to contact us!
