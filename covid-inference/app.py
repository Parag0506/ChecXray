import os
import sys

import flask
import numpy as np
import tensorflow as tf
from flask_cors import CORS

from predictor import disease_predictor
from util import np_to_base64
from PIL import Image

app = flask.Flask(__name__)
CORS(app)


@app.route('/')
def index():
    data = {"success": False, "method": flask.request.method}
    return flask.make_response(flask.jsonify(data))


@app.route('/predict', methods=['GET', 'POST'])
def predict():
    data = {"success": False, "method": flask.request.method}
    if flask.request.method == 'POST':
        input_data = flask.request.files.to_dict()['img'].stream
        img = Image.open(input_data)

        preds = disease_predictor().predict(img)

        pred_proba = "{:.3f}".format(
            np.amax(preds))

        if preds[0][0] > preds[0][1]:
            string = "Positive"
        else:
            string = "Negative"
        result = string               # Convert to string
        data["prediction"] = result
        data["confidence"] = pred_proba
        data["success"] = True

    return flask.make_response(flask.jsonify(data))


if __name__ == '__main__':
    app.run(threaded=True)
