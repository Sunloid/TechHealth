import sqlite3
from flask import Flask, request, jsonify

app = Flask(__name__)


def get_db():
    conn = sqlite3.connect("techhealth.db")
    conn.row_factory = sqlite3.Row
    return conn


@app.route("/health")
def health():
    return jsonify(status="ok")


@app.route("/patient")
def get_patient():
    patient_id = request.args.get("id", "")
    conn = get_db()
    row = conn.execute(
        "SELECT id, name FROM patients WHERE id = ?", (patient_id,)
    ).fetchone()
    return jsonify(dict(row) if row else {})


if __name__ == "__main__":
    app.run()
