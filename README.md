# 🌟 FFL-MPI-Data

This repository serves as the official project page for ​**FFL-MPI-Data**​, *A public projection imaging dataset for field free line magnetic particle imaging*.

The FFL-MPI-Data provides a comprehensive collection of both **measured** and **simulated** data, offering critical resources for developing and evaluating image reconstruction algorithms for field free line magnetic particle imaging, especially for challenging tasks like limited-angle and sparse-angle reconstruction.

---

## 💾 Dataset Availability & Overview

### Dataset Access

The full dataset is available on Zenodo:

https://doi.org/10.5281/zenodo.16563447

### Authors

* **Guanghui Li** (liguanghui@buaa.edu.cn)
* **Haicheng Du**

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
├── 1_reconstruction_codes/      # Signal Processing and Traditional Reconstruction (MATLAB/Python)
│   ├── measured_sensor.* # Process raw voltage signals (STFT, FBP)
│   ├── measured_sinogram_con.* # Process measured sinograms (FBP reconstruction)
│   └── simulated_sinogram_con.* # Process simulated sinograms (FBP reconstruction)
├── 2_simulation_framework/       # Calibrated MPI simulation framework
│   ├── mpi_simulator.py        # MPI signal and sinogram generator
│   ├── calibration_params.json # Calibration parameters file
│   └── generate_data.py        # Script for batch generation of synthetic data
├── 3_deep_learning_demo/       # Deep learning based reconstruction examples
│   ├── limited_angle_task/     # Limited-Angle Reconstruction Task
│   └── sparse_angle_task/      # Sparse-Angle Reconstruction Task
├── data/                       # Dataset Placeholder/Example Link
└── README.md                   # This file
```

---

## 🛠 Code Usage and Functionality

This project provides example codes for loading and processing the dataset, available in both **MATLAB** (`.mat`) and **Python** (`.py`) formats.

### 1. `1_reconstruction_codes`: Signal Processing and Traditional Image Reconstruction

This module contains scripts that demonstrate loading the dataset and performing basic reconstruction using traditional FBP methods across different data domains.

| **Script Name**        | **Data Domain**   | **Dataset Type** | **Key Procedures**                      |
| ------------------------------ | ------------------------- | ------------------------ | ----------------------------------------------- |
| `measured_sensor`        | Sensor Domain (Voltage) | Measured               | Reading Voltage Signals, STFT Processing, FBP |
| `measured_sinogram_con`  | Sinogram Domain         | Measured               | Reading Sinograms, FBP-based Reconstruction   |
| `simulated_sinogram_con` | Sinogram Domain         | Simulated              | Reading Sinograms, FBP-based Reconstruction   |

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

## 📧 Project Contact

Project Contact: **Guanghui Li** (liguanghui@buaa.edu.cn)

---

## 🙏 Acknowledgement

We sincerely appreciate your interest in the **FFL-MPI-Data** project. We hope this dataset will significantly contribute to **FFL-MPI** image reconstruction research, addressing the need for high-quality, domain-specific data.

If you have any suggestions, questions, or discover any errors, please feel free to contact us!
