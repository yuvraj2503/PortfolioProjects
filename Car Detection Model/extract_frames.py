import cv2
import os


base_folder = os.path.dirname(os.path.abspath(__file__))


video_file = os.path.join(base_folder, "Training_vieo.mp4")  


frames_folder = os.path.join(base_folder, "frames")


os.makedirs(frames_folder, exist_ok=True)


video = cv2.VideoCapture(video_file)

if not video.isOpened():
    print("❌ Error: Could not open video file.")
    exit()

frame_number = 0

while True:
    success, frame = video.read()
    if not success:
        break  # stop when video ends

    # Save each frame as an image
    filename = os.path.join(frames_folder, f"frame_{frame_number:05d}.jpg")
    cv2.imwrite(filename, frame)
    frame_number += 1

video.release()
print(f"✅ Done! {frame_number} frames saved in: {frames_folder}")
