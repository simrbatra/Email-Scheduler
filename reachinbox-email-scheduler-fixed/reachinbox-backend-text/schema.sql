
CREATE TABLE emails (
  id SERIAL PRIMARY KEY,
  recipient TEXT,
  subject TEXT,
  body TEXT,
  send_at TIMESTAMP,
  sent_at TIMESTAMP,
  status TEXT
);
