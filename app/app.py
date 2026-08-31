from flask import Flask, jsonify

app = Flask(__name__)


@app.get("/")
def index():
    return jsonify(
        service="aws-devops-delivery-platform",
        status="healthy",
        message="Delivered through Jenkins, Amazon ECR, and k3s.",
    )


@app.get("/health")
def health():
    return {"status": "ok"}, 200
