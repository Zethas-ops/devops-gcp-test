require("dotenv").config();

const express = require("express");
const { Pool } = require("pg");

const app = express();

// Disable strict routing agar /healthz dan /healthz/ sama-sama valid
app.disable("strict routing");

const port = process.env.PORT || 8080;

app.use(express.json());

const pool = new Pool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});

// Root Endpoint
app.get("/", (req, res) => {
  res.status(200).json({
    service: "DevOps Technical Test",
    status: "running",
    timestamp: new Date().toISOString(),
  });
});

// Version Endpoint
app.get("/version", (req, res) => {
  res.status(200).json({
    version: "v2-monitoring-fix",
    timestamp: new Date().toISOString(),
  });
});

// Health Check Handler
const healthHandler = (req, res) => {
  res.status(200).json({
    status: "healthy",
    timestamp: new Date().toISOString(),
  });
};

// Health Check
app.use("/healthz", (req, res) => {
  res.status(200).json({
    status: "healthy",
    timestamp: new Date().toISOString(),
  });
});

// Database Check
app.get("/db", async (req, res) => {
  try {
    const result = await pool.query("SELECT NOW()");

    res.status(200).json({
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

// 404 Handler
app.use((req, res) => {
  res.status(404).json({
    error: "Not Found",
    path: req.originalUrl,
  });
});

// Start Server
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});