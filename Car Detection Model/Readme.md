# 🚗 AI-Based Car Detection Model for Visually Impaired Assistance

This project aims to develop a lightweight car detection model optimized for low-power hardware such as Raspberry Pi. The system is designed to assist visually impaired individuals by alerting them of incoming vehicles through real-time audio feedback.

---

## 🎯 Objective

In India, visually impaired individuals face significant challenges while crossing roads due to the lack of auditory traffic cues.  
This project introduces a **smart wearable system** (e.g., a cap with an embedded camera and earphones) that detects vehicles in real-time and provides **directional audio alerts**, such as:

> “Car approaching from the left.”  
> “Truck in front.”  
> “Bike approaching from the right.”

---

## 🧠 Features

- Real-time **object detection** using YOLOv8.
- Optimized for **low-end devices** (Raspberry Pi, Jetson Nano, etc.).
- Detects **cars, trucks, bikes**, and other vehicles.
- Integrates **audio feedback** for blind users.
- Scalable to add **new object classes** (e.g., trams, buses, autos).

---

## ⚙️ Tech Stack

| Component | Technology Used |
|------------|----------------|
| Model | YOLOv8 (Ultralytics) |
| Framework | PyTorch |
| Dataset | Custom-labeled vehicle dataset |
| Deployment | Raspberry Pi (planned) |
| Audio Output | Python `gTTS` / offline TTS |
| Environment | Google Colab |

---

## 🧩 Workflow

1. **Dataset Preparation:**  
   Collected and labeled vehicle images (car, truck, bike) using Roboflow.

2. **Model Training:**  
   Trained YOLOv8 on Google Colab with transfer learning.  
   Achieved `mAP@50 = 0.954`.

3. **Testing and Evaluation:**  
   Tested on real traffic videos; detected cars in low-light and noisy environments.

4. **Future Scope:**  
   - Expand detection to other objects (bus, tram, cycle).  
   - Integrate with **Raspberry Pi Zero 2W**.  
   - Add real-time **audio feedback** module.

---

## 📈 Results

| Metric | Value |
|--------|--------|
| mAP@50 | 0.954 |
| FPS (on Colab GPU) | 18–22 |
| FPS (on Raspberry Pi, est.) | 6–8 |

Sample Output:  
*Video demonstrates car detection with bounding boxes and label confidence.*

---

## 🔮 Future Vision

> A world where assistive AI can give the visually impaired **independence and safety** in real-world navigation.

This project is the **first prototype** toward a wearable AI vision system capable of detecting and alerting real-world obstacles in real-time.

---

## 👥 Contributors

- **Yuvraj Sharma** — Developer & Researcher  
- **[Friend’s Name]** — Project Collaborator / Hardware Advisor  

---

## 🧾 License
This project is released under the **MIT License** for open collaboration and educational purposes.

---

### 🌐 Connect with Me
📧 [yuvrajsharma8760@gmail.com](mailto:yuvrajsharma8760@gmail.com)  
🔗 [LinkedIn](https://www.linkedin.com/in/yuvraj-s-801a9b1b4/)  
💻 [GitHub](https://github.com/yuvraj2503)
