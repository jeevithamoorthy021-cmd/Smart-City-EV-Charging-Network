CREATE TYPE geo_location AS (
    latitude NUMERIC(9,6),
    longitude NUMERIC(9,6),
    
	
	TEXT
);
CREATE TYPE socket_info AS (
    socket_no INTEGER,
    connector_type VARCHAR(30),
    max_kw NUMERIC(6,2),
    status VARCHAR(20)
);
CREATE TABLE ev_users (
    user_id INTEGER PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);
CREATE TABLE vehicles (
    vehicle_id INTEGER PRIMARY KEY,
    user_id INTEGER REFERENCES ev_users(user_id),
    vehicle_number VARCHAR(20) UNIQUE,
    battery_capacity NUMERIC(6,2)
);
CREATE TABLE charging_stations (
    station_id INTEGER PRIMARY KEY,
    station_name VARCHAR(100),
    location geo_location,
    sockets socket_info[],
    diagnostic_codes TEXT[]
);
CREATE TABLE charging_sessions (
    session_id INTEGER PRIMARY KEY,
    station_id INTEGER REFERENCES charging_stations(station_id),
    vehicle_id INTEGER REFERENCES vehicles(vehicle_id),
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    energy_kwh NUMERIC(8,2),
    session_status VARCHAR(20)
);
CREATE TABLE station_logs (
    log_id INTEGER PRIMARY KEY,
    station_id INTEGER REFERENCES charging_stations(station_id),
    log_message TEXT,
    log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO ev_users VALUES
(1, 'Arun', 'arun@example.com'),
(2, 'Priya', 'priya@example.com');
INSERT INTO vehicles VALUES
(101, 1, 'TN21AB1234', 60.00),
(102, 2, 'TN21CD5678', 75.00);
INSERT INTO charging_stations VALUES
(
    10,
    'Central EV Station',
    ROW(12.8342, 79.7036, 'Kanchipuram')::geo_location,
    ARRAY[
        ROW(1, 'CCS2', 60.00, 'AVAILABLE')::socket_info,
        ROW(2, 'CCS2', 60.00, 'OCCUPIED')::socket_info
    ],
    ARRAY['TEMP_OK', 'VOLTAGE_OK']
),
(
    20,
    'City Mall Station',
    ROW(13.0827, 80.2707, 'Chennai')::geo_location,
    ARRAY[
        ROW(1, 'Type2', 22.00, 'AVAILABLE')::socket_info
    ],
    ARRAY['TEMP_OK']
);
INSERT INTO charging_sessions VALUES
(
    1001, 10, 101,
    '2026-10-25 10:00',
    '2026-10-25 11:00',
    45.50,
    'COMPLETED'
),
(
    1002, 20, 102,
    '2026-10-25 11:30',
    NULL,
    12.00,
    'ACTIVE'
);
INSERT INTO station_logs
    (log_id, station_id, log_message)
VALUES
    (1, 10, 'Station started successfully'),
    (2, 10, 'Socket 2 charging in progress'),
    (3, 20, 'Active charging session detected');
SELECT * FROM ev_users;
SELECT v.vehicle_number, u.user_name
FROM vehicles v
JOIN ev_users u ON v.user_id = u.user_id;
SELECT * FROM charging_stations;
SELECT * FROM charging_sessions;
SELECT *
FROM charging_sessions
WHERE session_status = 'ACTIVE';
SELECT * FROM station_logs;
SELECT s.station_name, x.*
FROM charging_stations s
CROSS JOIN LATERAL unnest(s.sockets) AS x;