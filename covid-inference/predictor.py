import numpy as np

from tensorflow.keras.applications.imagenet_utils import preprocess_input
from tensorflow.keras.preprocessing import image
from tensorflow.keras.models import model_from_json, load_model


class disease_predictor():
    def __init__(self):
        pass

    def predict_instance(self, x, model):
        y = model.predict(x)  # Run prediction on the perturbations
        if y.shape[1] == 1:
            # Compute class probabilities from the output of the model
            probs = np.concatenate([1.0 - y, y], axis=1)
        else:
            probs = y
        return probs

    def load_model(self):
        # load json and create model
        json_file = open('model/model.json', 'r')
        loaded_model_json = json_file.read()
        json_file.close()
        loaded_model = model_from_json(loaded_model_json)
        # load weights into new model
        loaded_model.load_weights("model/model_weights.h5")
        return loaded_model

    def predict(self, img):
        model = self.load_model()
        img = img.resize((224, 224))

        img = np.asarray(img.convert("RGB"))
        x = image.img_to_array(img)
        x = np.expand_dims(x, axis=0)
        x = preprocess_input(x, mode='tf')

        preds = self.predict_instance(x, model)
        return preds
