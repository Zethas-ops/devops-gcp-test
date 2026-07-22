require("dotenv").config();

const express = require("express");
const { Pool } = require("pg");

const app = express();
const port = process.env.PORT || 8080;

app.use(express.json());

const pool = new Pool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});

app.get("/version", (req, res) => {
  res.json({
    version: "v2-monitoring-fix",
    time: new Date().toISOString()
  });
});

app.get("/", (req, res) => {
  res.json({
    service: "DevOps Technical Test",
    status: "running",
  });
});

app.get("/healthz", (req, res) => {
  res.status(200).json({
    status: "healthy",
    timestamp: new Date().toISOString(),
  });
});

app.get("/db", async (req, res) => {
  try {
    const result = await pool.query("SELECT NOW()");

    res.json({
      database: "connected",
      timestamp: result.rows[0].now,
    });
  } catch (err) {
    console.error(err);

    res.status(500).json({
      database: "failed",
      error: err.message,
    });
  }
});

console.log(app.enabled("strict routing"));
app.disable("strict routing");
app.listen(port, () => {
  console.log(`Server berjalan di http://localhost:${port}`);
});