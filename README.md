# Parkinson's Disease Detection Using Speech & CNN
# 🧠 Parkinson's Disease Detection Using Speech & CNN

## 📌 Project Overview
This project aims to detect Parkinson's Disease (PD) using speech data. The audio files undergo preprocessing, where vowel onset points (VOPs) are detected, and the segmented speech is converted into Mel spectrograms. A **Convolutional Neural Network (CNN)** is then trained on these spectrograms to classify healthy and Parkinson's patients.

## 📂 Dataset
- **Dataset Name:** Italian Parkinson’s Dataset (Provided by Guide)  
- **Availability:** The dataset is private and not included in this repository. If needed, you can use a publicly available Parkinson’s speech dataset.

## 🛠 Workflow
1️⃣ **Speech Processing (MATLAB)**:
   - **segment.m** → Detects Vowel Onset Points (VOP) using LP residual and segments speech into ~450ms windows.  
   - **melspectrograms.m** → Converts segmented speech into Mel spectrograms.

2️⃣ **Deep Learning Model (Python, CNN)**:  
   - **Jupyter Notebook (`sowmya_trial.ipynb`)** contains the CNN training code.  
   - CNN is trained on Mel spectrograms to classify Healthy vs. Parkinson’s patients.


## 🚀 Installation & Usage
### **1. Clone the Repository**
```bash
git clone https://github.com/your-username/Parkinsons-Speech-CNN.git
cd Parkinsons-Speech-CNN
```
### **2. Install Dependencies**
```bash
pip install -r requirements.txt
```
### **3. Run the CNN Model**
Open the Jupyter Notebook and execute:
```bash
jupyter notebook
```
Then run `sowmya_trial.ipynb`.

## 📊 Model Performance
- **CNN Model Accuracy:** 98% 

## 🔥 Future Improvements
- Train on a larger dataset.
- Implement alternative deep learning models like LSTMs or transformers.
- Use Discrete Time Warping (DTW) for more robust feature extraction using Handwriting.

## 💡 Contribution
Feel free to fork this repository, open issues, or submit pull requests!

## 📜 License
This project is for academic and research purposes.

